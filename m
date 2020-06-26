Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D38C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5729520B80
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgFZV0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:26:21 -0400
Received: from elephants.elehost.com ([216.66.27.132]:26519 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgFZV0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:26:20 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05QLQGL8045334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Jun 2020 17:26:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <011901d64bf9$0235d2b0$06a17810$@nexbridge.com> <xmqq366hh6ns.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq366hh6ns.fsf@gitster.c.googlers.com>
Subject: RE: Static Linking git for HPE NonStop
Date:   Fri, 26 Jun 2020 17:26:11 -0400
Message-ID: <012601d64c00$6d366280$47a32780$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQCOhHzYPmmKTPEbIRsXh0oTWnq0GwJPfSLCq2h7toA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 26, 2020 5:14 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > ... Is there anyway to force a static
> > linkage instead of using DLLs so that we can isolate this for
> > installations who want to be insulated from the confusion?
> >
> > We currently have everything encoded in config.mak.uname and do not
> > use make configure or configure explicitly. Just make.
> 
> A quick scan of our Makefile seems to say that LDFLAGS is left open for
> builder's use (i.e. we don't add hardcoded "always link dynamically" etc.
in
> there, so that somebody doing a build for a particular use case can tell
the
> linker "I want things linked statically" by adding appropriate and linker
> specific flags to it, and that propagates to ALL_LDFLAGS to be used at the
> last stage of linking the git binary itself.

Thanks. That would work just fine.

Regards,
Randall

