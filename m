Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D451DC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48E1613DA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFBUiB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 2 Jun 2021 16:38:01 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55441 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhFBUiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:38:01 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 152KaA7L044423
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Jun 2021 16:36:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com> <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net> <YLfl4jkuwSCiNrrS@nand.local> <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
In-Reply-To: <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Wed, 2 Jun 2021 16:36:04 -0400
Message-ID: <003d01d757ee$ebe93080$c3bb9180$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7fmH3rhE7hkXT/heyzvk47BFclgE1aUB7AUaXbccDGYfiRAHqs6saqXze98A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 2, 2021 4:16 PM, Peff wrote:
>To: Taylor Blau <me@ttaylorr.com>
>Cc: Randall S. Becker <rsbecker@nexbridge.com>; 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
>
>On Wed, Jun 02, 2021 at 04:11:14PM -0400, Taylor Blau wrote:
>
>> Subject: [PATCH] compat: introduce git_fsync_with_restart()
>>
>> Some platforms, like NonStop do not automatically restart fsync() when
>> interrupted by a signal, even when that signal is setup with SA_RESTART.
>>
>> This can lead to test breakage, e.g., where "--progress" is used, thus
>> SIGALRM is sent often, and can interrupt an fsync() syscall.
>>
>> Add a Makefile knob FSYNC_NEEDS_RESTART to replace fsync() with one
>> that gracefully handles getting EINTR.
>>
>> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
>> Signed-off-by: Jeff King <peff@peff.net>
>
>Probably Helped-by might be more appropriate. But regardless, I definitely give my S-o-B for anything I contributed.
>
>>  Makefile          |  8 ++++++++
>>  compat/fsync.c    | 10 ++++++++++
>>  git-compat-util.h |  6 ++++++
>>  3 files changed, 24 insertions(+)
>>  create mode 100644 compat/fsync.c
>
>This looks as I'd expect. But after seeing Eric's response, we perhaps want to do away with the knob entirely.

I'm for doing away with the knob altogether, providing you don't mean the platform itself 😉

Regards,
Randall

