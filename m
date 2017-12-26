Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BE51F404
	for <e@80x24.org>; Tue, 26 Dec 2017 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdLZUmJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 15:42:09 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:38632 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750822AbdLZUmJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Dec 2017 15:42:09 -0500
Received: from cmgw4 (unknown [10.0.90.85])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 62CA41E17CE
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:19:07 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw4 with 
        id qkK31w00Z0QvKlu01kK7Nr; Tue, 26 Dec 2017 13:19:07 -0700
X-Authority-Analysis: v=2.2 cv=G85sK5s5 c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=ocR9PWop10UA:10 a=eYjMWUKC9XtOimOw-toA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0iarmrG87l2tSE38PEynXn5V6dZUZGKmvlKR1gEGpR0=; b=HGGhVeKbE1ELNgqYaWv3LN8bns
        OgIJ1InGcyOMC1QZvKz5z3dSn62x4f3ewqJHqrMKbsdBDPRjTlptm0SkKUtG6K00YjohO7hlZGIzZ
        M45vKHyaqD48wjiJ6v7E+2nnf;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:34846 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eTvgl-0037To-HR; Tue, 26 Dec 2017 13:19:03 -0700
Message-ID: <1514319542.2717.406.camel@mad-scientist.net>
Subject: Re: Bring together merge and rebase
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Carl Baldwin <carl@ecbaldwin.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 26 Dec 2017 15:19:02 -0500
In-Reply-To: <20171226194408.GA22855@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
         <877etds220.fsf@evledraar.gmail.com>
         <20171223210141.GA24715@hpz.ecbaldwin.net>
         <87608xrt8o.fsf@evledraar.gmail.com>
         <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
         <87vagtqszf.fsf@evledraar.gmail.com>
         <20171226194408.GA22855@Carl-MBP.ecbaldwin.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 74.104.137.100
X-Exim-ID: 1eTvgl-0037To-HR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:34846
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-12-26 at 12:44 -0700, Carl Baldwin wrote:
> > Sure, it could be opt in, be a new format etc. But you haven't
> > explained why you think a feature like this would need to rely on
> > an entirely new parent structure and side-DAG, as opposed to just
> > the more minor changes I'm pointing out above, and which I think
> > will give you what you need from a UX level.
> 
> I have not wrapped my head around it enough to convince myself that
> it gives what I'm after. Let me spend a little more time with it to
> get a feel for it.

As someone working in an environment where we do a lot of rebasing and
very little merging, I read these proposals with interest.  I'm not
convinced that we would switch to using a "replaces"-type feature, but
I'm pretty sure that the "null-merge and rebase" trick described
previously would not be something we're interested in using.

Although "git log" doesn't follow these merges (unless requested), all
the graphical tools that are used to display history WOULD show all
those branches.  In a "replaces"-type environment I think the point is
that we would not want to see them (certainly not by default) as they
would be used mainly for deeper spelunking, but since they just seem
like normal merges I don't see any way to turn them off.

If "replaces" was a separate capability then it could be treated
differently by history browsing tools, and shown or not shown as
desired.  For example, a commit that had a "replaces" element could be
selected somehow and you could expand that set of commits that were
replaced, or something like that.
