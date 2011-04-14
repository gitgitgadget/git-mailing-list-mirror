From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 15:24:14 -0600
Organization: icecavern.net
Message-ID: <201104141524.15212.wjl@icecavern.net>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:32:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAU9O-0004Cc-FM
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab1DNVcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:32:25 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:47563 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752597Ab1DNVcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:32:24 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2011 17:32:24 EDT
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 8976E3616D;
	Thu, 14 Apr 2011 15:24:17 -0600 (MDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171562>

On Thursday, April 14, 2011 14:30:59 Chris Patti wrote:
> We want a way to have our Bamboo configuration utilize a symbol to
> refer to 'latest release' 'latest patch' etc. in Git, rather than
> having to go in and change the actual branch name every time we ship a
> release and create a new one.
> 
> We thought about using something like:
> 
> git symbolic-ref -m'new next-release branch build for Bamboo'
> next-release release-3.15
> 
> However, this symbolic ref is only local to one repository, and we
> want it to be global across all of Bamboo.
> 
> Rather than resorting to manually copying the symbolic ref file
> around, from repo to repo, is there any way to make such a symbolic
> 'variable' global?

Why not just use a tag or a branch ?

git tag -F next-release release-3.15

  OR

git branch -D next-release
git branch next-release release-3.15

(I personally think branches are nicer for this since tags are "supposed" to 
be immutable.)
