Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E18920404
	for <e@80x24.org>; Tue, 10 Oct 2017 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755272AbdJJMlD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 08:41:03 -0400
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:39496 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751415AbdJJMlC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Oct 2017 08:41:02 -0400
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Oct 2017 08:41:02 EDT
Received: from cmgw2 (unknown [10.0.90.83])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 669AC215E09
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 06:19:44 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw2 with 
        id KoKg1w0140QvKlu01oKkxQ; Tue, 10 Oct 2017 06:19:44 -0600
X-Authority-Analysis: v=2.2 cv=dZfw5Tfe c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=02M-m0pO-4AA:10 a=n0cEkMv3dxfyu5oJbw8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=711pJz94FaGGnDyXMpyguPZMDfvAd12yrAcf/oVtn6E=; b=qFPMLGVBVoXAH/bErAROT80j7l
        0/rwJx+ojppH+onYxmuG3mGFaDLjs6kgJIuUtz1YJNNi0Fpa5iztpFsjbvjKJBGHCAYpJp0E3jOjF
        GXagjBWpYoqrRt+NHdy8SdKpp;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:57720 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1e1tVc-0000S0-ME; Tue, 10 Oct 2017 06:19:40 -0600
Message-ID: <1507637979.8322.33.camel@mad-scientist.net>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Date:   Tue, 10 Oct 2017 08:19:39 -0400
In-Reply-To: <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain>
References: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
         <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
         <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
         <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
         <1507412674.8322.4.camel@mad-scientist.net>
         <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
         <1507473160.8322.12.camel@mad-scientist.net>
         <20171008184046.uj7gcutddli54ic3@thunk.org>
         <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
         <20171008204227.f6wgaobosa6yn62g@thunk.org>
         <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>
         <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain>
Organization: Please remain calm!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1e1tVc-0000S0-ME
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:57720
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-10 at 04:36 -0400, Robert P. J. Day wrote:
>   ah, now *that* is a compelling rationale that justifies the
> underlying weirdness. but it still doesn't explain the different
> behaviour between:
> 
>   $ git rm -n 'Makefile*'
>   $ git rm -n '*Makefile'

I explained that behavior in the email up-thread from this reply:

> Globbing in "git rm" matches on the FULL PATH, not just the file name. 
> So, if you have a list of Makefiles in your repository like:
> 
>   Makefile
>   foo/Makefile
>   bar/Makefile
> 
> Then 'Makefile*' only matches the first one, since 'Makefile*' doesn't
> match 'foo/Makefile' or 'bar/Makefile'.
>
> If you you worry that '*Makefile' will match things you don't want to
> match, you'll have to use:
> 
>   git rm -n Makefile '*/Makefile'

