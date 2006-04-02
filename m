From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Sun, 02 Apr 2006 08:49:22 +0200
Organization: At home
Message-ID: <e0ns59$uq2$1@sea.gmane.org>
References: <1143950852.21233.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Apr 02 08:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPwP2-0004Gn-GN
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 08:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWDBGtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Apr 2006 01:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDBGtY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 01:49:24 -0500
Received: from main.gmane.org ([80.91.229.2]:37601 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751279AbWDBGtY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 01:49:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FPwOp-0004Ev-3m
	for git@vger.kernel.org; Sun, 02 Apr 2006 08:49:23 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Apr 2006 08:49:23 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Apr 2006 08:49:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18260>

Sam Vilain wrote:

> From a discussion on #git, the idea was raised of "multi-headed
> branches"
[...]=20
> If somebody adds a commit (5) that changes "foo.c" again, the darcs
> history would change to:
>=20
> =C2=A0=C2=A01=C2=A0->=C2=A03=C2=A0->=C2=A05
> =C2=A0=C2=A02=C2=A0->=C2=A04
>=20
> To represent this in git you could just roll back the head merge comm=
it,
> push commit 5 on that branch, then make a new head:
>
>   1 -> 3 -> 5 \
>                >- head
>   2 -> 4 -----/
>=20
> However, if there was support for "hydra", or heads that are multiple
> commit IDs (and necessarily, no blobs in corresponding paths in their
> trees that are not identical), then you would not need to destroy and
> recreate this dummy merge head commit to model your patch history in
> this manner.
[...]

I'm not sure if "hydras", i.e. multi-commit 'heads' are what would make
GIT able to use some of Darcs patches calculus ideas. If I understand
correctly in GIT 'head' (and 'tag') not only identifies commit (commits
in hydra[1]) but also tree (in hydra it is result of trivial (?) merge)=
=2E
Wouldn't it be better to somehow represent rather partial ordering betw=
een
commits in history, to have something from Darcs in GIT? Although I'm n=
ot
sure about efficiency, and if we should do detect commits dependency --=
 or
in other words partial ordering of commits/patches -- at commit or at
merge. And if we should remember (or cache) partial ordering/dependency
info...

[1] I've detected some confusion in this terminology. "Hydra" is
multi-headed moster, yet in your ptoposal it is one head that has multi=
ple
bodies... and "octopus" is taken. I guess the terminology should be
switched (octopus <-> hydra).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
