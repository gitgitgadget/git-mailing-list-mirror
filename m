Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E128DC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 00:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3D561075
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 00:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ3AQM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Oct 2021 20:16:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41645 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3AQM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 20:16:12 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19U0DXWg079752
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 20:13:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Jeff King'" <peff@peff.net>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        <git@vger.kernel.org>, <avarab@gmail.com>
References: <20211029212705.31721-1-carenas@gmail.com>        <YXxpjLhiguq4HY6g@coredump.intra.peff.net>        <YXxs4NZmpjhRkoYA@coredump.intra.peff.net>        <xmqqbl37ijc7.fsf@gitster.g>        <015801d7cd10$8d404810$a7c0d830$@nexbridge.com> <xmqq35ojihx7.fsf@gitster.g>
In-Reply-To: <xmqq35ojihx7.fsf@gitster.g>
Subject: RE: [PATCH] wrapper: remove xunsetenv()
Date:   Fri, 29 Oct 2021 20:13:28 -0400
Organization: Nexbridge Inc.
Message-ID: <015d01d7cd22$fa6c6970$ef453c50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD1p6jrNojDT2nQCeA0hV5rmPbfSQHD8XfqAjjb4UQCj3ErFgC0XlPTAKzdU52tb4qX8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 6:29 PM, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > On October 29, 2021 5:59 PM, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >>
> >> > However, according to the unsetenv() manpage:
> >> >
> >> >   Prior to glibc 2.2.2, unsetenv() was prototyped as returning void;
> >> >   more recent glibc versions follow the POSIX.1-compliant prototype
> >> >   shown in the SYNOPSIS.
> >> >
> >> > So it is POSIX to return an int, but that gives us at least one
> >> > platform where unsetenv() returns void (or used to). glibc 2.2.2 is
> >> > 2001-era, so that may be old enough that we don't care. But it
> >> > makes me wonder if other older or obscure platforms will run into this.
> >>
> >> Ahh, OK.  Well, we will hear from them soon enough.  It is not like
> >> this is anything urgent.
> >
> > Well... maybe for some of us 😉
> 
> Heh, but we all know you are capable of locally patching ;-).

Our CI/CD uses Jenkins and depends directly on the git repo, like normal people 😉

