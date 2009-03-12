From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: [EGIT RFC PATCH(was Re: egit problem with sym linked eclipse project dirs)] Add some support for symlinked
 projects.
Date: Wed, 11 Mar 2009 22:57:09 -0400
Message-ID: <p06240814c5de27cbf520@[63.138.152.192]>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <p06240812c59ed365d694@[192.168.1.106]>
 <200901232233.59232.robin.rosenberg.lists@dewire.com> <200903112317.41380.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 04:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhbE9-0005b8-F9
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 04:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZCLDD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 23:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbZCLDD2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 23:03:28 -0400
Received: from deanbrook.org ([72.52.70.192]:43775 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752777AbZCLDD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 23:03:28 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2009 23:03:28 EDT
Received: from ::ffff:70.109.253.176 ([70.109.253.176]) by deanbrook.org for <git@vger.kernel.org>; Wed, 11 Mar 2009 19:57:38 -0700
In-Reply-To: <200903112317.41380.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113000>

OK ... I'm a bit confused now because I no longer have Git listed as 
a repository type for Team Sharing.

I deleted the existing org.spearce.* eclipse plugins

   [eclipse]$ rm -f plugins/org.spearce.*

pulled from git://repo.or.cz/egit.git

created a new branch for this test and applied your patch

   [egit.git (linksbranch)]$ git log
   commit 2b86cd4e27a9d9158092305271d6fb25ab27846e
   Author: Stephen Bannasch <stephen.bannasch@gmail.com>
   Date:   Wed Mar 11 22:29:26 2009 -0400

       check through links for repositories
       Robin Rosenberg's patch
       see: http://marc.info/?l=git&m=123681033214178&w=2
       and: http://code.google.com/p/egit/issues/detail?id=52

   commit 341b9c1abadd2ac0ec9ecc7c597990070612e058
   Author: Ruth Alkema <ruth@diasoft.nl>
   Date:   Wed Mar 11 16:42:45 2009 +0100

       Better fix for 'negative position' error on large pack files

       If position is really big and the window size is fairly small, id can
       be negative.  Instead of producing a negative position by extending
       id to a long, mask out the low bits from the original position value
       to compute the window start.

       [sp: message by me, as I had already applied v1 of the patch
            and pushed it (see immediate parent)]

       Signed-off-by: Ruth Alkema <ruth@diasoft.nl>
       Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

   ...

Opened Eclipse and switched to the egit workspace. Refreshed the egit 
projects and exported the org.spearce.* packages as deployable 
plugins and fragments to the Eclipse dir.

The new plugins are there:

   [eclipse]$ ls plugins/org.spearce.*
   plugins/org.spearce.egit.core.test_0.4.0.200903112237.jar
   plugins/org.spearce.egit_0.4.0.200903112237.jar
   plugins/org.spearce.egit.core_0.4.0.200903112237.jar
   plugins/org.spearce.jgit_0.4.0.200903112237.jar
   plugins/org.spearce.egit.ui_0.4.0.200903112237.jar

Quit and restarted Eclipse.

When I select a project with an existing git repository and try to 
enable team/sharing only CVS and SVN are listed.
