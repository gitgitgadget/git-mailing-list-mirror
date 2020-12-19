Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFFC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970E23B27
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLSAT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:19:28 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38130 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgLSAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:19:28 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kqPxO-006OG8-4N; Fri, 18 Dec 2020 17:18:46 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kqPxM-007Jxv-Sg; Fri, 18 Dec 2020 17:18:45 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id B02CE1280EFC;
        Fri, 18 Dec 2020 17:18:43 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6rilDdJ1GrTk; Fri, 18 Dec 2020 17:18:43 -0700 (MST)
Received: from ellen (c-76-27-24-148.hsd1.ut.comcast.net [76.27.24.148])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 6A8541280982;
        Fri, 18 Dec 2020 17:18:43 -0700 (MST)
Date:   Fri, 18 Dec 2020 17:18:38 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <20201219001838.GB153461@ellen>
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <xmqq3603v3a0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3603v3a0.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1kqPxM-007Jxv-Sg;;;mid=<20201219001838.GB153461@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 02:04:23AM -0800, Junio C Hamano wrote:
> When unconfigured, I
> would say we should enable the feature by default to give it wider
> exposure.

I am unreasonably excited about that. :D

> If it turns out that all the tools we happen
> to have do not seem to break with this new option with just a few
> days' survey, it does not mean we do not need a per-tool escape
> hatch they can use until the next release either fixes the feature
> or makes it disabled by default, when there is unexpected breakages
> discovered later.

Well said. I will try to complete that screenshot comparison part of the
survey that I promised by tonight, or by this weekend at the latest.

