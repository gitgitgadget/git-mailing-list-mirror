Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0079D20372
	for <e@80x24.org>; Sat,  7 Oct 2017 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbdJGWH0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 18:07:26 -0400
Received: from gproxy9-pub.mail.unifiedlayer.com ([69.89.20.122]:44062 "EHLO
        gproxy9-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752710AbdJGWHZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2017 18:07:25 -0400
X-Greylist: delayed 1364 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Oct 2017 18:07:25 EDT
Received: from cmgw4 (unknown [10.0.90.85])
        by gproxy9.mail.unifiedlayer.com (Postfix) with ESMTP id 164B51E071E
        for <git@vger.kernel.org>; Sat,  7 Oct 2017 15:44:39 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw4 with 
        id Jlkb1w00N0QvKlu01lkeHF; Sat, 07 Oct 2017 15:44:39 -0600
X-Authority-Analysis: v=2.2 cv=OZLoNlbY c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=02M-m0pO-4AA:10 a=UsgmYl4N1hb_70AsnakA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3weYv5F+m1LBSIw6k8q3pOsgJl6slUjSS9dusd4OKkQ=; b=Hjys9ElsmRmEiS35Y2i/1azIPi
        0RJm2sl8tEuxsGoZJ6b5pf2FHXDImyz5cfbdKsmFS5C4Puxrks8kAvGX8S8Y0Q2JkvE+SCrtwpt9S
        e8lejr3cFySID4+cWBZmQiJ8C;
Received: from pool-74-104-137-100.bstnma.fios.verizon.net ([74.104.137.100]:41868 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1e0wtf-0034XX-EU; Sat, 07 Oct 2017 15:44:35 -0600
Message-ID: <1507412674.8322.4.camel@mad-scientist.net>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Date:   Sat, 07 Oct 2017 17:44:34 -0400
In-Reply-To: <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
         <20171007190402.GH3382@zaya.teonanacatl.net>
         <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
         <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
         <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
         <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
         <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
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
X-Exim-ID: 1e0wtf-0034XX-EU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-74-104-137-100.bstnma.fios.verizon.net (homebase) [74.104.137.100]:41868
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-10-07 at 15:43 -0400, Robert P. J. Day wrote:
>   it's been a long week, so take this in the spirit in which it is
> intended ... i think the "git rm" command and its man page should be
> printed out, run through a paper shredder, then set on fire. i can't
> remember the last time i saw such a thoroughly badly-designed,
> badly-documented and non-intuitive utility.

"git rm" works the same way that the UNIX rm command has worked, for 40+
years now.  Very simple, very well designed, and very intuitive (IMO).

The major difference is the ability to handle globbing patterns, which
UNIX rm doesn't do.  Maybe the way this is implemented is a little
confusing, although I just read the man page and it seemed pretty clear
to me.

If you don't use glob patterns (or more specifically if you let the
shell handle glob patterns, which is how I always do it) then there is
really nothing bizarre about "git rm".  Maybe you could be more precise
in your criticism.
