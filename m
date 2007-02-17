From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: monotone is slow
Date: Sat, 17 Feb 2007 01:17:38 -0500
Message-ID: <20070217061738.GA27864@spearce.org>
References: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com> <Pine.LNX.4.63.0702162347430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIItN-0005q4-0d
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbXBQGRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXBQGRn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:17:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59798 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbXBQGRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:17:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIItA-000484-DY; Sat, 17 Feb 2007 01:17:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9714420FBAE; Sat, 17 Feb 2007 01:17:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702162347430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39966>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 16 Feb 2007, Jon Smirl wrote:
> 
> > 45 CPU minutes to do a pull. About 2hrs real time.
> > 
> > jonsmirl@jonsmirl:~$ ps aux | grep mtn
> > jonsmirl  8382 80.5  4.4 131444 115204 pts/0   S+   14:54  45:44 mtn pull
> > 
> > And it worked, nothing was wrong. 1,500 revs pulled.
> > Let's convert the world to git.
> 
> But does it cook dinner?

No, Monotone doesn't.  As slow as it is...  and apparently one
could almost make a turkey while waiting for the merge.  Well,
a deep-fried turkey anyway.  :-)

But if you apply the following patch, Git will cook you dinner,
and faster than anyone else too!

diff --git a/git-merge.sh b/git-merge.sh
index 04a5eb0..00d083a 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -51,6 +51,7 @@ finish_up_to_date () {
 	'')
 		echo "$1" ;;
 	esac
+	echo "Also, your dinner is ready.  Most excellent."
 	dropsave
 }
 
@@ -95,6 +96,7 @@ finish () {
 		esac
 		;;
 	esac
+	echo "Git cooked you dinner! Go eat!"
 }
 
 merge_name () {


-- 
Shawn.
