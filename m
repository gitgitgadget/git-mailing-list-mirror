Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D84F1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfFMR2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:28:15 -0400
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:49158 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbfFMR2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 13:28:15 -0400
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 7B80F1E0E3C
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 11:28:14 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id bTWIhVZ28sFwgbTWIhOMkY; Thu, 13 Jun 2019 11:28:14 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=J/aEEjvS c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=dq6fvYVFJ5YA:10:nop_rcvd_month_year
 a=eAOjpCpGei4A:10:endurance_base64_authed_username_1 a=iz-zNJ8GzIr3HHWB9zYA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WcYeaxjNVhDDddttFIiN6UicPx+/Y9blImj0WV8ruSA=; b=dkKyZiLq0SVx5I71WR+gsRl/pK
        Pl1VWezHyUep9Y6AabdXfrJghaK/6AySf5Z9epNHcjW2gGx013XMS6geM8fZtSRIlgy2NNRHg/p94
        TPKVo9c4yxOYaLCjxKf5TCZC9;
Received: from [65.112.16.22] (port=36932 helo=pdslaptop)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1hbTWH-001LGJ-Tw
        for git@vger.kernel.org; Thu, 13 Jun 2019 11:28:14 -0600
Message-ID: <13c40b4b819f702a52f7039177579f87fa90aa50.camel@mad-scientist.net>
Subject: Re: Reducing git size by building libgit.so
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Thu, 13 Jun 2019 13:28:10 -0400
In-Reply-To: <nycvar.QRO.7.76.6.1906130914250.42@tvgsbejvaqbjf.bet>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
                 <20190611234815.GB8616@genre.crustytoothpaste.net>
         <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
         <nycvar.QRO.7.76.6.1906130914250.42@tvgsbejvaqbjf.bet>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 65.112.16.22
X-Source-L: No
X-Exim-ID: 1hbTWH-001LGJ-Tw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdslaptop) [65.112.16.22]:36932
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2019-06-13 at 09:51 +0200, Johannes Schindelin wrote:
> Hassles aside, you mentioned Linux and macOS. What about literally
> *all* the other platforms we support? Like AIX, NonStop, HP/UX, etc?

I assumed that we were discussing providing an _option_ of building
with shared libraries, rather than removing support for static
libraries and only supporting shared libraries.  The former is the
typical model in portable projects.

So, the answer to most of the (important) issues you and Brian raise
is, "if it doesn't work, can't be made to work, is too slow, or is
annoying for ANY other reason, then don't do it".

Regarding things like publish-ability of the API, I don't know what
else to say.  It's FOSS, after all: anyone can do whatever they want
(with respect to building and using the code) regardless of the desires
of the development team.  All you can do is make clear that the intent
is that the API is not stable, and if they don't listen and their stuff
breaks, well, as the saying goes, they get to keep both halves.  Not
adding any header files to the installation rules and packages is also
helpful :).

There's a certain amount of cold, hard reality that every FOSS project,
regardless of how friendly and welcoming they aspire to be, simply
can't avoid while still making progress (and staying sane).


I certainly don't want to minimize the amount of work involved here,
nor do I want to in any way volunteer myself to undertake any of it: as
I said, I don't have strong feelings about it.

I'm just saying, there's no technical reason it can't be done while
maintaining the same features (such as relocatability) as the static
library installs, at least on the major platforms.

Cheers!

