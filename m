Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2215E20986
	for <e@80x24.org>; Tue, 27 Sep 2016 13:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750840AbcI0NZG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 09:25:06 -0400
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:34001 "HELO
        gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751631AbcI0NZE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 09:25:04 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2016 09:25:04 EDT
Received: (qmail 17721 invoked by uid 0); 27 Sep 2016 13:18:23 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy6.mail.unifiedlayer.com with SMTP; 27 Sep 2016 13:18:23 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw4 with 
        id odJG1t00r2qhmhE01dJKfB; Tue, 27 Sep 2016 07:18:23 -0600
X-Authority-Analysis: v=2.1 cv=Hq7lRSjS c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=GW1xBdLrtEIA:10 a=pBbsfl06AAAA:8 a=7Fc2rPtaS4-xxt_ugvUA:9 a=QEXdDO2ut3YA:10
 a=Pykvx6M6Og9ney6Qs4Vj:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID; bh=CaoDROwZLrg16A1jPemcc62RzCeXEBVsTqhza0og6Rc=; b=Pe77NJDfTmUeUM
        dCiKgSIBNM1Dhg5RUphUQ129JJR11QrhyDripDx7vfu6vJ+6S/KymsperYw7gqg76JwM29O+fsmIv
        +VO1LHlpCSCgIcQvzTlhkf09zrLSZyw9ac8k1;
Received: from pool-173-76-103-154.bstnma.fios.verizon.net ([173.76.103.154]:46126 helo=homebase)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1bosH2-0005HT-NH; Tue, 27 Sep 2016 07:18:16 -0600
Message-ID: <1474982294.3190.32.camel@mad-scientist.net>
Subject: Re: git 2.9.2: is RUNTIME_PREFIX supposed to work?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 27 Sep 2016 09:18:14 -0400
In-Reply-To: <CAPc5daU_nnHRjtC02bxqRaoU+0Rgi7pS6e912Fqk-Xy=qdKWFA@mail.gmail.com>
References: <1474925524.4270.35.camel@mad-scientist.net>
         <CAPc5daU_nnHRjtC02bxqRaoU+0Rgi7pS6e912Fqk-Xy=qdKWFA@mail.gmail.com>
Organization: Please remain calm: I may be mad but I am a professional --
 Mad Scientist
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-0ubuntu1~ubuntu16.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box531.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 173.76.103.154
X-Exim-ID: 1bosH2-0005HT-NH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-173-76-103-154.bstnma.fios.verizon.net (homebase) [173.76.103.154]:46126
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-09-26 at 14:57 -0700, Junio C Hamano wrote:
> On Mon, Sep 26, 2016 at 2:32 PM, Paul Smith <paul@mad-scientist.net> wrote:
> > 
> > Hi all.  I'm trying to create a relocatable installation of Git 2.9.2,
> > so I can copy it anywhere and it continues to run without any problem.
> > This is on GNU/Linux systems, FWIW.
> 
> I had an impression that the setting was only to support MS Windows.

Hm.  You may be right.  If so that's too bad, because a relocatable Git
is very handy even on UNIX systems.  Is there a reason for invoking the
subcommands by providing the plain command ("fetch", "merge-base") as
argv[0], rather than giving the fully-qualified path to a Git command?
