Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC12C43219
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5577320658
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhAZWBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:08 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50598 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390637AbhAZSHY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:07:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l4Sjh-0053rF-Jp; Tue, 26 Jan 2021 11:06:41 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l4Sjf-002TYP-GJ; Tue, 26 Jan 2021 11:06:40 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 9EF301280CD0;
        Tue, 26 Jan 2021 11:06:38 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RrAvr0-hnWx5; Tue, 26 Jan 2021 11:06:38 -0700 (MST)
Received: from ellen (c-76-27-24-148.hsd1.ut.comcast.net [76.27.24.148])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 5A27612807A3;
        Tue, 26 Jan 2021 11:06:38 -0700 (MST)
Date:   Tue, 26 Jan 2021 11:06:35 -0700
From:   Seth House <seth@eseth.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <20210126180635.GA28241@ellen>
References: <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
 <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
 <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
X-XM-SPF: eid=1l4Sjf-002TYP-GJ;;;mid=<20210126180635.GA28241@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 03:32:13PM +0100, Johannes Schindelin wrote:
> So I'd rather see `git mergetool` be turned into a portable C program, or
> alternatively using a built-in helper that _is_ written in C, to perform
> that desired text munging

I tend to agree. Though my personal preference is Cygwin's (eventual)
approach, I can appreciate the arguments made by the MSYS2 folk. But
setting that aside, IMO, the ideal place to handle this would be the
same place where the conflict markers are written in the first place,
xmerge.c if my limited C literacy is correct.

I don't see a big distinction between writing a single file with
conflict markers and writing two, diff-able files with each "side" of
the conflict -- they're ultimately two different formats for expressing
the same information. That would give us the portability you described
and the (pretty amazing) performance that merge-file already enjoys. :)

I'm more than happy with calling merge-file twice for now. A future
C optimisation, perhaps exposed via merge-file as a new (e.g.)
--write-conflict-files flag, would be even more awesome.

