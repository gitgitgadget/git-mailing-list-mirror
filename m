From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Git on Mac OS and precomposed unicode
Date: Thu, 21 Mar 2013 17:04:40 +0100
Message-ID: <514B2F98.30409@web.de>
References: <64B4EB934AFE4B358B94EB717103887E@leo-koppelkamm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Leo Koppelkamm <hello@leo-koppelkamm.de>
X-From: git-owner@vger.kernel.org Thu Mar 21 17:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhzO-0006Ur-AC
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 17:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762Ab3CUQEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 12:04:47 -0400
Received: from mout.web.de ([212.227.15.4]:55767 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756390Ab3CUQEo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 12:04:44 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MV4bp-1UCyIu0rdt-00Y6Gn; Thu, 21 Mar 2013 17:04:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <64B4EB934AFE4B358B94EB717103887E@leo-koppelkamm.de>
X-Provags-ID: V02:K0:maXveN87JXBhdznjgyLSSfalo7aE30IUx2YJXzhoXj6
 e1oRKTKlRbAW8Vaomy7cF2H7Z/nsIN2QCCHTEKazvKH1EXsC0O
 4658VpEuZZh2ycY9nYr5UdBuk2egVxkShQp+GEY1Dc4OZEfFPV
 StvilOoj0/Jf5bicdk+/d2BLjErit/jpefi7TpX1/i1SIT14cM
 SIIaEy60uSpZXXG9RVaNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218740>

On 21.03.13 14:00, Leo Koppelkamm wrote:
> Torsten B=C3=B6gershausen added a patch for this a while ago.
> It seems it only works for files, not for folders with unicode in it.
>
> Eg. on ubuntu box:
> git init
> mkdir h=C3=A4
> touch h=C3=A4/file
> git add h=C3=A4
> git commit=20
>
> Later on Mac
> git clone =E2=80=A6=E2=80=A6=E2=80=A6
> git status
>
> # On branch master=20
> # Untracked files:=20
> # (use "git add <file>..." to include in what will be committed)=20
> #=20
> # h=C3=A4/
>
> Regards Leo
That is what I read from the commit message:

   When creating a new git repository with "git init" or "git clone",
    "core.precomposedunicode" will be set "false".
  =20
    The user needs to activate this feature manually.  She typically
    sets core.precomposedunicode to "true" on HFS and VFAT, or file
    systems mounted via SAMBA.

(Which is slighty wrong, because the name of the config variable
is core.precomposeunicode)

What does
git config core.precomposeunicode
say ?

You may consider to set it to set it to true globally,
git config --global core.precomposeunicode true,
and the next "git clone" will work as expected.

On the other hand,
could/should we consider to change the default to true in Git 2.0?

HTH
/Torsten



=20






What does git config
