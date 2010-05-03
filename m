From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] git branch --status ?
Date: Mon, 03 May 2010 21:54:42 +0200
Message-ID: <4BDF2A02.1050907@drmicha.warpmail.net>
References: <p2i91b13c311005031131vc876475fn674c0ceffbdb3cf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Cheng Renquan <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 21:55:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O91jM-0007xx-8K
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 21:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab0ECTy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 15:54:58 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41748 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753590Ab0ECTy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 15:54:57 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 890A1F4647;
	Mon,  3 May 2010 15:54:44 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 03 May 2010 15:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Oosuh2iSMPybW0fjHPVgsQlFRpI=; b=datF+IRcBgKiaW4o3Sa9p4wnzM2j1XYmsdFLVqgEcF12reYvKt3MRGqNua1VK6nPQvUjn2EL/dRhnxS6sXQ/kIRCDTvTESLPYF2EX05SLgSWuX0kvSrRsTiODP6O2D25xvWzYy9FPAdlxqRIg1pK3AIPw23WJg1kfZp+D303Cms=
X-Sasl-enc: izcWHHRndvObdoGLU3VqxjKWMsx14liwmA262kFtkucD 1272916483
Received: from localhost.localdomain (p5DCC068A.dip0.t-ipconnect.de [93.204.6.138])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 426458368;
	Mon,  3 May 2010 15:54:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <p2i91b13c311005031131vc876475fn674c0ceffbdb3cf6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146252>

Cheng Renquan venit, vidit, dixit 03.05.2010 20:31:
> Hi, all,
>   I'm considering to do a feature patch that is useful for this scena=
rio:
>=20
> $ git remote -v update
> Updating geko-ceph
> From git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client
>  =3D [up to date]      for-linus  -> geko-ceph/for-linus
>  =3D [up to date]      for-next   -> geko-ceph/for-next
>  =3D [up to date]      master     -> geko-ceph/master
>  =3D [up to date]      rbd        -> geko-ceph/rbd
>  =3D [up to date]      unstable   -> geko-ceph/unstable
> Updating newd-ceph
> From git://ceph.newdream.net/ceph-client
>  =3D [up to date]      addr_cleanup -> newd-ceph/addr_cleanup
>  =3D [up to date]      auth       -> newd-ceph/auth
>  =3D [up to date]      bookkeeper -> newd-ceph/bookkeeper
>  =3D [up to date]      cephdev    -> newd-ceph/cephdev
>  =3D [up to date]      for-next   -> newd-ceph/for-next
>  =3D [up to date]      master     -> newd-ceph/master
>  =3D [up to date]      msgr       -> newd-ceph/msgr
>  =3D [up to date]      osd-timeout -> newd-ceph/osd-timeout
>  =3D [up to date]      pgcache    -> newd-ceph/pgcache
>  =3D [up to date]      pgcache2   -> newd-ceph/pgcache2
>  =3D [up to date]      pgcache3   -> newd-ceph/pgcache3
>  =3D [up to date]      rbd        -> newd-ceph/rbd
>  =3D [up to date]      rbd2       -> newd-ceph/rbd2
>  =3D [up to date]      reconnect  -> newd-ceph/reconnect
>  =3D [up to date]      unstable   -> newd-ceph/unstable
>  =3D [up to date]      upstream   -> newd-ceph/upstream
>=20
> after this kind of remote update, usually we want to know:
> 1) which remote branch is the latest? (then know which branch is most=
 valuable)
> 2) the latest commit information of every branch (remote & local) ?
>=20
> I'd like to use "git branch -a --status" to achieve this feature,
> something like:
>=20
> $ git branch -a --status
>=20
> git branch -a
>   master [%h %an %ad %s]
> * new33 [%h %an %ad %s]
>   remotes/geko-ceph/for-linus [%h %an %ad %s]
>   remotes/geko-ceph/for-next ...
>   remotes/geko-ceph/master ...
>   remotes/geko-ceph/rbd
>   remotes/geko-ceph/unstable
>   remotes/newd-ceph/addr_cleanup
>   remotes/newd-ceph/auth
>=20
> So now for everyone here,
> 1) how do you think it's useful?
> 2) if some current command with some switches has done the goal?
>    (then I don't need to implement it,)
> 2) if not; which command switch (other than "branch --status") do you=
 prefer?
> 3) implementation suggestions?
>=20
> Thanks & Cheers,
>=20
> --
> Cheng Renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8), Singapore

You may mean something like

git log --no-walk --format=3D"%d [%h %an %ad %s]" --branches

although Jeff will tell you to use

git for-each-ref --format=3D"%(refname:short) [%(objectname) %(authorna=
me)
%(authordate) %(subject)]" refs/heads

and will probably know how to abbreviate the objectname here ;)

Cheers,
Michael
