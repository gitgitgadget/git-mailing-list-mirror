Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D21C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 06:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72782206D8
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 06:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKTGmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:42:00 -0500
Received: from feynman.df7cb.de ([195.49.152.168]:55712 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKTGmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 01:42:00 -0500
Received: from msg.df7cb.de (unknown [IPv6:2a02:908:1473:f520:76e5:bff:fef3:7e00])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 47HtQY3Nmyz3Dyp;
        Wed, 20 Nov 2019 07:41:57 +0100 (CET)
Date:   Wed, 20 Nov 2019 07:41:58 +0100
From:   Christoph Berg <myon@debian.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone git clone some://url
Message-ID: <20191120064157.GA22081@msg.df7cb.de>
References: <20191119141537.GD18924@msg.df7cb.de>
 <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re: Junio C Hamano 2019-11-20 <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
> Christoph Berg <myon@debian.org> writes:
> 
> > On some git hosting sites [*], if you copy the repository URL, you'll
> > actually get "git clone some://url" in the cut buffer. When you then
> > proceed to do "git clone <paste>" in the next terminal window, the
> > command executed is actually this:
> >
> > $ git clone git clone some://url
> > fatal: Too many arguments.
> 
> Or
> 
>     $ git git clone some://usr
>     $ git git git diff
> 
> ;-)
> 
> I seriously doubt "git" should do anything funky when fed such
> command lines.

"git git git" is obviously silly. The problem is really just about
this single issue:

1. go to some website, copy the git url
2. type "git clone" in the terminal
3. paste the url, hit enter
4. be annoyed when you ended up with "git clone git clone url://"

Christoph
