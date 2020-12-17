Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770FBC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C65B2360D
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 17:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgLQRvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:51:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48274 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 12:51:24 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kpxQH-0038Lw-CM; Thu, 17 Dec 2020 10:50:41 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kpxQG-0006gg-HA; Thu, 17 Dec 2020 10:50:41 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 3774E1280E3A;
        Thu, 17 Dec 2020 10:50:40 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t6_CsdFG6tJR; Thu, 17 Dec 2020 10:50:40 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 4E5441280DA8;
        Thu, 17 Dec 2020 10:50:39 -0700 (MST)
Date:   Thu, 17 Dec 2020 10:50:37 -0700
From:   Seth House <seth@eseth.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <20201217175037.GA80608@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fdb3471c6bb7_d6d032087@natae.notmuch>
X-XM-SPF: eid=1kpxQG-0006gg-HA;;;mid=<20201217175037.GA80608@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 17, 2020 at 04:35:29AM -0600, Felipe Contreras wrote:
> If you want to see the original LOCAL, REMOTE, and BASE, you can turn
> off that option (or simply never turn it on).

Agreed.

Felipe, the functionality in the v3 version of your patch looks good to
me and I think it's well worth including in upstream Git.

Would you mind switching the autoMerge option to be per-tool rather than
under the main mergetool config section?

You're right that it will likely not cause any downstream errors; it's
just a difference in preference. The tools that perform their own
conflict resolution will likely want it off and most of the other tools
will likely want it on. I could envision wanting to configure multiple
mergetools -- some with and some without.

After work today I can go back through the list of mergetools reviewed
in my post and grab screenshots of each with this option enabled so that
everyone in this thread can quickly compare the before/after results.

