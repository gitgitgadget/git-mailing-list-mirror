X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 17:16:02 -0500
Message-ID: <20061203221602.GA15965@spearce.org>
References: <20061203045953.GE26668@spearce.org> <457347E1.2020800@stephan-feder.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 22:16:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <457347E1.2020800@stephan-feder.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33144>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqzd6-0004pi-0u for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758514AbWLCWQI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758532AbWLCWQI
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:16:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:23748 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758514AbWLCWQH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:16:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gqzcd-0005JZ-AP; Sun, 03 Dec 2006 17:15:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2C44B20FB7F; Sun,  3 Dec 2006 17:16:03 -0500 (EST)
To: sf <sf-gmane@stephan-feder.de>
Sender: git-owner@vger.kernel.org

sf <sf-gmane@stephan-feder.de> wrote:
> Shawn Pearce wrote:
> ...
> > One of the biggest annoyances has been the fact that although Java
> > 1.4 offers a way to mmap a file into the process,
> 
> Be careful with mmap:
> http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4724038

Thanks. That particular bug has been of some discussion on
#git before.  I'm planning on making it a configuration flag in
.git/config for the user to decide how much pain they want: mmap
(with all its huge downsides) or read into byte[] (with all the
memory footprint that requires).

-- 
