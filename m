X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 11:58:49 -0500
Message-ID: <20061117165849.GC32597@spearce.org>
References: <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org> <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org> <87fycjs5yg.wl%cworth@cworth.org> <f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com> <87r6w3b68p.wl%cworth@cworth.org> <7vu00ysbwi.fsf@assigned-by-dhcp.cox.net> <87ejs2qvmb.wl%cworth@cworth.org> <Pine.LNX.4.63.0611171103150.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 17:00:23 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0611171103150.13772@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31712>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl73N-0008Ls-4i for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933731AbWKQQ65 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933732AbWKQQ65
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:58:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56722 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S933731AbWKQQ64
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:58:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gl737-0002mb-I2; Fri, 17 Nov 2006 11:58:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A762520E469; Fri, 17 Nov 2006 11:58:49 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I introduced the remote.<nick>.{url,fetch,push} entries into the config 
> with the goal to enhance -fetch to remember the current command line with 
> a setting. I was the only one to find that useful.
> 
> BTW I still would argue that it is better to write the remote information 
> into the config, because you have a saner way to manipulate that from 
> scripts than .git/remotes/<nick>.

I'm *fully* in favor of the remote.<nick>.{url,fetch,push} entries
in the config file.  I've pretty much switched every repository to
that format at this point.

In writing git-gui I'm finding it much, much easier to manage
things through repo-config than to do any mucking around in the
.git/remotes directory.  Yes, the remote files have simple format,
but I can get everything in one "git repo-config --list" pull it
all into a Tcl array and work with it; using .git/remotes means I
have to open the file and read each line too.  :-(

-- 
