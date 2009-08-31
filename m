From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: git-svn-Cloning repository with complex nesting
Date: Mon, 31 Aug 2009 09:41:28 +0200
Message-ID: <9accb4400908310041j45d2d1bar9e61348e355892b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi1WE-0008Sk-Vc
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 09:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbZHaHl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 03:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbZHaHl3
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 03:41:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46137 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbZHaHl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 03:41:28 -0400
Received: by bwz19 with SMTP id 19so2613218bwz.37
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=N9MVg7NI4WxFtLBnDMFuzrPNcbLHpgIZKYLd22+jWR0=;
        b=CU5YOuvwNOYiXXi2R6Y9dtDb/6T+UmDPlv+oko82rOapGL2+t/jwEfNaS58CNVYRV7
         CeJF0O7HfpWUL0cGL2LW2uMe7/P/oC5k1AdoLyHtg6Loz9Wx9Zt32iDRvSjP2UU/PY+U
         uzcVRThopkqjSIUK8bVPLo5P4BilfrDJtU8Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=W8RlCijyu/+e9KQz7auhS6PHH/F9zqUeoiZV31QnfuMWRzhD3u2dSbpXl9Pqsuwz7r
         3NxsiN+a4r4lT76nFKuS0dTiP3qqjYHOKAM6dfv5TjeeqpFyObuLaVNZ++I5RhfcjQb9
         jEIFIow3i27+7GcVgtSc4u+u7vQ3Oj5EBLtxQ=
Received: by 10.223.103.3 with SMTP id i3mr1290180fao.65.1251704488592; Mon, 
	31 Aug 2009 00:41:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127466>

On Thu, Aug 27, 2009 at 10:32 AM, Daniele Segato<daniele.bilug@gmail.co=
m> wrote:
> Hi, this is my first message in the list: this may be a newbie
> question and my English may not be very good.

to prove my sentence:
the subject should have been "git-svn-Cloning repository with
_complex_ nesting" :-)

I received help on IRC (#git) and managed to setup the svn-remote in
an acceptable way

> I've an SVN repository structured like this:
>
> http://<url>/path/to/repo
> =C2=A0 =C2=A0|
> =C2=A0HEAD
> =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0|
> =C2=A0BRANCHES
> =C2=A0 =C2=A0|----- V1.0
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- root
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0|----- V1.1
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- root
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0|----- V1.2
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- root
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0|----- DEV
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- FEATURE1
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- FEATURE2
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |----- FEATURE3
> =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0|
> =C2=A0 =C2=A0|----- BUILDS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|----- BUILD1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|----- BUILD2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|----- root
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|----- BUILD3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |----- root


this is my setting:

git init
git svn init svn://svn.mydomain.com/path/to/repo -T HEAD -b BRANCHES -t=
 TAGS

vim .git/config # edited the svn-remote config as follow:
[svn-remote "svn"]
	url =3D svn://svn.mydomain.com
	fetch =3D path/to/repo/HEAD/root:refs/remotes/svn/trunk
	branches =3D path/to/repo/BRANCHES/*/root:refs/remotes/svn/*
	tags =3D path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*

git svn fetch

it seems to work as expected: only those branches that has a "root"
folder got downloaded and fetched.

I still couldn't retrieve the DEV/FEATUREx branches in that way.
On IRC they told me I can add another line for branches:

branches =3D path/to/repo/BRANCHES/*/*/root:refs/remotes/svnbis/*

but I haven't been successful on this. They told me that I can add
multiple branches lines only on newer versions of git.
Probably that's the reason for that.
I have git version 1.5.6.5.

It is not a big deal: I can live without those branches even if I'll
like to have them too.

I have another problem now on that SVN repo but I'll open another
topic about that because it is not related.

Regards,
Daniele
