X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH take 2] change the unpack limit treshold to a saner value
Date: Thu, 7 Dec 2006 02:59:56 -0500
Message-ID: <20061207075956.GA22558@spearce.org>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home> <Pine.LNX.4.64.0612062244090.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 08:00:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612062244090.2630@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33558>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsEB4-0007cZ-ON for gcvg-git@gmane.org; Thu, 07 Dec
 2006 09:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031811AbWLGIAO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 03:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031815AbWLGIAO
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 03:00:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57409 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031811AbWLGIAM (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 03:00:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsEAj-0001Qz-U1; Thu, 07 Dec 2006 03:00:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1404920FB6E; Thu,  7 Dec 2006 02:59:57 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> Currently the treshold is 5000.  The likelihood of this value to ever be 
> crossed for a single push is really small making it not really useful.

I started that out at 5000 because it was a reasonably safe
threshold.  Users who didn't explicitly lower this value didn't
enable the feature.  But it was still useful on initial pushes into
a brand new repository when the project was very large.  For example
pushing git.git into a bare repository *sucked* before this change.

Yea, 5000 is probably too high.  Nice to see it drop.

-- 
