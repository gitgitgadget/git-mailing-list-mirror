From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Thu, 21 Jun 2007 23:56:53 -0400
Message-ID: <20070622035652.GD17393@spearce.org>
References: <20070621045333.GB13977@spearce.org> <7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 05:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1aGY-0007Hf-Rg
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 05:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbXFVD45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbXFVD45
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 23:56:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45951 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbXFVD45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 23:56:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1aGI-0006Er-66; Thu, 21 Jun 2007 23:56:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60E5E20FBAE; Thu, 21 Jun 2007 23:56:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50670>

Junio C Hamano <gitster@pobox.com> wrote:
> Hmm.  Now, how does "git-blame" tell if there is usable git-gui
> installed with it?  Will we have "git-gui --list-features"?

It can run `git gui version` and check to see that it is >= 0.7.3.
 
;-)


I'm actually not sure we want to apply this patch, hence the RFC
prefix I put on it.  Jakub suggested it, this crude implementation
was easy enough to hack together, so I posted a patch for someone
to play with if they were so inclined.

Maybe we should just put a link in the git-blame manual page to
the git-gui manual page:

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 66f1203..599e10b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -36,6 +36,9 @@ $ git log --pretty=oneline -S'blame_usage'
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
 
+A powerful graphical viewer for the output of git-blame can be
+accessed through the blame subcommand of gitlink:git-gui[1].
+
 OPTIONS
 -------
 include::blame-options.txt[]
@@ -184,7 +187,8 @@ commit commentary), a blame viewer won't ever care.
 
 SEE ALSO
 --------
-gitlink:git-annotate[1]
+gitlink:git-annotate[1],
+gitlink:git-gui[1]
 
 AUTHOR
 ------

-- 
Shawn.
