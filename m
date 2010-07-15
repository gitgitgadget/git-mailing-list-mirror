From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git-svn question
Date: Thu, 15 Jul 2010 12:50:31 -0600
Organization: icecavern.net
Message-ID: <201007151250.32974.wjl@icecavern.net>
References: <20100715171849.GA31823@heretic.net-ronin.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: carbonated beverage <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 20:50:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTWJ-0000gg-KE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934273Ab0GOSut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 14:50:49 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:43889 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934118Ab0GOSus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 14:50:48 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id DC19635B22;
	Thu, 15 Jul 2010 12:50:44 -0600 (MDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-trunk-amd64; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100715171849.GA31823@heretic.net-ronin.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151105>

On Thursday, July 15, 2010 11:18:49 carbonated beverage wrote:
> I'm trying to figure out how to import a rather large SVN tree that has
> been around for a while, initially converted from CVS.
[...]
> Given multiple projects that are nested as such, is there a way to get
> git-svn to import the tree and be able to derive the tags and branches? 
> Also, this tree is a little over 1TiB in size, though a large chunk of
> that is due to the duplicates made by SVN's branches/tags.

That sounds pretty messed up. Someone may have better advice, but I'd 
probably approach it by doing one or more of the following:

  1) Fix it up with svndumpfilter first to get rid of useless or duplicated 
parts, then import it.

  2) Once imported into use git rebase and/or git filter-branch to clean 
things up until it's how you like it.

  3) If all else fails, archive the SVN repository (or the git imported 
equivalent), call it "old history", and then start over and manually import 
only the active and useful branches and tags into git.
