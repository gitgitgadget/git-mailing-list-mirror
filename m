From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 10:20:18 -0600
Organization: icecavern.net
Message-ID: <200910201020.18676.wjl@icecavern.net>
References: <loom.20091019T094924-194@post.gmane.org> <200910191327.49092.wjl@icecavern.net> <200910201741.50764.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0HRm-00021h-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbZJTQUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbZJTQUU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:20:20 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:45195 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752514AbZJTQUU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 12:20:20 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id BE00036865;
	Tue, 20 Oct 2009 18:20:21 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.29-2-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <200910201741.50764.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130806>

On Tuesday 20 October 2009 09:41:50 Robin Rosenberg wrote:
> m=E5ndag 19 oktober 2009 21:27:48 skrev  Wesley J. Landaker:
> > (Not CCing everyone, since this is mostly curiosa in the "using git=
 as
> > it was never intended" section):
[...]
> > Filesystems are mostly reliable, but only until your crazy users do
> > strange and terrible things. I have a real, non-toy environment whe=
re I
> > use this stack as a [horrible] workaround for some issues beyond my
> > control:
> >
> > git -> ext4 -> lvm -> dmcrypt -> loop -> sshfs -> cygwin sshd -> SM=
B
> > share

My main point was to illustrate that having "git fsck" do a REALLY GOOD=
=20
CHECK is still desirable, as we still haven't reached the days of file-
system utopia where nothing ever gets corrupted (even with a smaller,=20
simpler stack).

The actual application where I use this stack is because of odd require=
ments=20
and circumstances like data must be physically stored on a particular=20
Windows server on the network that uses a weird authentication method t=
hat=20
samba doesn't support, and it has to go over the network encrypted anyw=
ay,=20
there are lots of holes in the data, so I want ext4 for the extent supp=
ort,=20
file-size limitations on the target, etc.

It's a really an exotic love-hate mix between an off-by-one-please-no-n=
ever-
again kind of situation coupled with a bit of "because I can".

> The obvious follow up question here is: Why?

If you are both nerdy and morbidly curious enough to care, send me a "b=
ut,=20
no ... really, WHY?!" with the git list CC dropped and we can talk abou=
t=20
details and/or other crazy stuff. (I don't want to get wildly off-topic=
 on=20
this list.)
