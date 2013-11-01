From: DimanNe <dimanne@ya.ru>
Subject: =?utf-8?B?UmU6IGdpdCBzdm4gYWxyZWFkeSBzZXQg4oCmIHdhbnRlZCB0byBzZXQgdG86?=
Date: Fri, 01 Nov 2013 10:12:40 +0400
Message-ID: <299211383286360@web20h.yandex.ru>
References: <1771383029875@web26g.yandex.ru>
	<87iowgiloj.fsf@linux-k42r.v.cablecom.net>
	<87941383056091@web26h.yandex.ru> <87ppqmg5me.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 01 07:12:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc7yS-00031E-KT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 07:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab3KAGMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Nov 2013 02:12:44 -0400
Received: from forward3h.mail.yandex.net ([84.201.187.148]:49711 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3KAGMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 02:12:44 -0400
Received: from web20h.yandex.ru (web20h.yandex.ru [84.201.186.49])
	by forward3h.mail.yandex.net (Yandex) with ESMTP id E79A013627E8;
	Fri,  1 Nov 2013 10:12:41 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web20h.yandex.ru (Yandex) with ESMTP id 56B98E407D7;
	Fri,  1 Nov 2013 10:12:41 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1383286361; bh=GDIkcFUScPzTnmW+Azc9jnANnTdmERVo2drEDt/XdTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=we6EJ/KrRwVqAWYfpr8iCGWjeVcT6IpemO28ZrkWuUfio8U1TzwgrYL2dZKui9Gwr
	 4fFMKQ9cPi1FpYZM/s6nR+XZOpPsFJm/CIA4LsGLieMY9rKlrPx+x5fCt41EHl/+VV
	 fB5dDmjzQZcRRNphOK7CmXNEPmD+B1Qv3Jf5GTAo=
Received: from 95.108.172.103.red-dhcp.yndx.net (95.108.172.103.red-dhcp.yndx.net [95.108.172.103]) by web20h.yandex.ru with HTTP;
	Fri, 01 Nov 2013 10:12:40 +0400
Envelope-From: Dimanne@yandex.ru
In-Reply-To: <87ppqmg5me.fsf@linux-k42r.v.cablecom.net>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237202>

Thank you, it seems, that you are right, and following works

1) I cloned trunk from scratch
git svn clone -T trunk/ https://some_host --revision 1104830:HEAD

2) Then add branches I want to fetch in .git/config:
fetch =3D branches/proj/proj-stable-2013-08-14:refs/remotes/proj-stable=
-2013-08-14

3) Then run
git svn fetch
wait for about 10 hours without any output from command (this was most =
difficult step due to absence of output), and after that git started to=
 fetch revisions!


30.10.2013, 19:06, "Thomas Rast" <tr@thomasrast.ch>:
> DimanNe <dimanne@ya.ru> writes:
>
>>> =9AWhat does your config look like now?
>> =9A[core]
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Arepositoryformatversion =3D 0
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Afilemode =3D true
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Abare =3D false
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Alogallrefupdates =3D true
>>
>> =9A[svn-remote "svn"]
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aurl =3D https://some_host/trunk/
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Afetch =3D :refs/remotes/git-svn
>>
>> =9A[merge]
>> =9A=9A=9A=9A=9A=9A=9A=9A=9ArenameLimit =3D 50000
>>
>> =9A[svn-remote "stable-2012-09-13"]
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Aurl =3D https://some_host/branches/stable=
-2012-09-13/
>> =9A=9A=9A=9A=9A=9A=9A=9A=9Afetch =3D :refs/remotes/stable-2012-09-13
>
> Sounds like you should instead have only a single remote, along the
> lines of:
>
> [svn-remote "svn"]
> =9A=9A=9A=9A=9A=9A=9A=9Aurl =3D https://some_host/
> =9A=9A=9A=9A=9A=9A=9A=9Afetch =3D trunk:refs/remotes/git-svn
> =9A=9A=9A=9A=9A=9A=9A=9Afetch =3D branches/stable-2012-09-13:refs/rem=
otes/stable-2012-09-13
>
> or possibly, instead of manually listing the branches you want,
>
> =9A=9A=9A=9A=9A=9A=9A=9Abranches =3D branches/*:refs/remotes/svn/*
>
> --
> Thomas Rast
> tr@thomasrast.ch
