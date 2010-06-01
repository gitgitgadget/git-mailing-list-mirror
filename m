From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 1 Jun 2010 19:16:19 +0200
Message-ID: <AANLkTimnQJmctLU1LmT1x3KhB84J2Wrqsa8Nfo5vVDLI@mail.gmail.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	<4BF7B751.7050704@pileofstuff.org>
	<4BFB7F7F.5090407@drmicha.warpmail.net>
	<4C041656.7000008@pileofstuff.org>
	<AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
	<1533278916.20100601231415@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	<ajsoft@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:24:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVCX-0004tg-Sd
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab0FARYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 13:24:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42797 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0FARYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 13:24:24 -0400
Received: by gye5 with SMTP id 5so1341505gye.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=idkl05dh5kFxgDXch9yJvszsgN0Aa+myO0zo9eeZuNc=;
        b=TVodnHrq1igiaak9/7+g4qK+9iXCtwRFU38rvSWQyIAjUAl0KY59YfmmjsQ68lSUDA
         EK9hwLyuwWldot/E/oXaOP6e+lXCi6CP/5zAaYh/tSlPD5lVRym/MPKp9aHZx1IeWTp7
         TdVBWqv0MvcuTdfJFqr8rsNwgIcttfPjN031U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=brvWE/HmH72lhbmuN1q82GdQTED6ucfjOvi1uNok6yj79oANrY16Vt+d10269BqLMX
         ovr3XiKaScZar6+D5sQG8o4BhG2saIhnwZv1Kw3k1iO9nV9IkCn5BQUZJuh7pNZdxZgY
         w1aX8s9vboXYLOVLKVwVOvtyB27lK+A8usfYU=
Received: by 10.100.246.37 with SMTP id t37mr7260506anh.17.1275412579452; Tue, 
	01 Jun 2010 10:16:19 -0700 (PDT)
Received: by 10.100.34.5 with HTTP; Tue, 1 Jun 2010 10:16:19 -0700 (PDT)
In-Reply-To: <1533278916.20100601231415@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148143>

2010/6/1 Alexander Iljin <ajsoft@yandex.ru>:
> Hello!
>
> DS> You also can't create new Subversion branches or tags with git-sv=
n,

I've been corrected on this: git svn tag and git svn branch are there
for that purpose.

> =C2=A0Another point: you can't contribute to branches via git-svn, yo=
u can
> =C2=A0only commit to trunk. It is easy to be confused if you've creat=
ed a
> =C2=A0feature branch in Git. If you then want to git-svn dcommit a
> =C2=A0half-done work, you will mess up the trunk.

that's not correct

You can contribute to any subversion branch, but you have to do it
with a local branch tracking the
remote one

say you are on "master" which track remote svn "trunk" and you want to
contribute to remote branch "v1.x"

you can do this:

git checkout -b myBranch-v-1-x v1.x

it will checkout the remote v1.x creating a new label "myBranch-v-1-x"
for tracking it.
you can then work on myBranch-v-1-x as usual, when you'll git svn
dcommit from there you'll commit on the remote v1.x branch.


but you have to be careful with cherry-picking.

if you want to cherry pick a comment on trunk to commit it on branch
v1.x you'll have to amend it removing the line:

git-svn-id: https://your-svn-url/repos/trunk@1234 a123123....

or you'll not be able to commit on the remote v1.x branch.

I created a local alias for cherry-picking an a safe way for subversion=
:

[from alias section in my .gitconfig]

cherry-pick-svn =3D  !GIT_EDITOR=3D'sed -i /^git-svn-id:/d' git cherry-=
pick -e

which do a normal cherry-pick automatically editing the commit to
remove that line.

may be this could be added to the svn alias list?

Regards,
Daniele Segato
