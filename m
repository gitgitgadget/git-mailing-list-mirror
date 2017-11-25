Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4F920954
	for <e@80x24.org>; Sat, 25 Nov 2017 23:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdKYXLO (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 18:11:14 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:52187 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751197AbdKYXLN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 18:11:13 -0500
Received: from CMOut01 (unknown [10.0.90.82])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id D69EB1E06DE
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 16:11:12 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id ePB91w00C0QvKlu01PBCSv; Sat, 25 Nov 2017 16:11:12 -0700
X-Authority-Analysis: v=2.2 cv=K4VSJ2eI c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=sC3jslCIGhcA:10 a=-qA8Sg-ed6W9_ROAwzoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WHzA0f7tcqv7AzLUP/juBUVIDJpNZitA/NN7XAD9JhM=; b=n2JUk7C6zmtIsGZNk1G6uC0SIK
        o6wj3+lubukIk0CTKepOSP7ayYGTSk02msp6qWkmNGIsrJ+FfVJUlSNselQEFMjsbo/T3Y/Z6LtKJ
        3+c5t7YO0hh5rEYpmQHv5A+2p;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:41750 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eIjbJ-000teR-07; Sat, 25 Nov 2017 16:11:09 -0700
Message-ID: <1511651467.2847.212.camel@mad-scientist.net>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Date:   Sat, 25 Nov 2017 18:11:07 -0500
In-Reply-To: <20171125200615.GA4344@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
         <20171122223020.2780-1-t.gummerer@gmail.com>
         <20171122223020.2780-5-t.gummerer@gmail.com>
         <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
         <20171125175010.GB14993@hank> <1511634365.2847.211.camel@mad-scientist.net>
         <20171125200615.GA4344@hank>
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
X-Exim-ID: 1eIjbJ-000teR-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:41750
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-11-25 at 20:06 +0000, Thomas Gummerer wrote:
> This part is getting done in 3/4, and is definitely going to work
> without an additional flag, so this is (hopefully) soon going to work
> just as you want :)

Yay!  Thanks!
