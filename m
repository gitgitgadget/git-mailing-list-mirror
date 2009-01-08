From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 07 Jan 2009 16:57:39 -0800
Organization: Slide, Inc.
Message-ID: <1231376259.8870.633.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <1231374514.8870.621.camel@starfruit>
	 <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EJXiEHVDtfQ3d8mrIUbm"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:59:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKjEq-0002vX-Mp
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbZAHA5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZAHA5o
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:57:44 -0500
Received: from mx0.slide.com ([208.76.68.7]:55534 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbZAHA5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=y
	K2feVvNrgBF9VjsRMkQ60prxMWwrZXcO5/VYORISFc=; b=16SuDroxydMNulVRx
	sasLpaDot6+/yZgc3FpcsWm92/YLuiPQCz55M0Wtrk3z0jMgwfFC49N9Mawyihfk
	hyFtTB1SJYqbgGlHGGCzmib7W+8CoKkyedZWS1h/kB7WkHIQMj2SSlG/oAtujiF5
	y1i73lxnq7n+KywDAIpRo9fmz8=
Received: from nat3.slide.com ([208.76.69.126]:58262 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKjDQ-0006A6-7o; Wed, 07 Jan 2009 16:57:40 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 37BA73899037;
	Wed,  7 Jan 2009 16:57:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.877
X-Spam-Level: 
X-Spam-Status: No, score=-2.877 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.126, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZBN1jC+nUpp; Wed,  7 Jan 2009 16:57:40 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 10C373898B8A;
	Wed,  7 Jan 2009 16:57:40 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104863>


--=-EJXiEHVDtfQ3d8mrIUbm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 16:48 -0800, Linus Torvalds wrote:
>=20
> On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
> >
> > My most esteemed colleague (Ken aka kb) who pointed out the memory issu=
e
> > was on the right path (I think), and I have a reproduction case you can
> > try with your very own Linux kernel tree!
> >=20
> > WOO!
> >=20
> > I set ulimit -v really low (150M), and the operations I made got an
> > mmap(2) fatal error, but there is a sweet spot that I found, see the
> > transcript below.
>=20
> This is indeed the packfile mapping. The sweet spot you found depends on=20
> how big the biggest two pack-files are, I do believe.
>=20
> And if you do that
>=20
> 	[core]
> 		packedgitwindowsize =3D 64M
>=20
> I think you'll find that it works. Of course, with a _really_ low ulimit,=
=20
> you'd need to make it even smaller, but at some point you start hitting=20
> other problems than the pack-file limits, ie just the simple fact that gi=
t=20
> wants and expects you to have a certain amount of memory available ;)
>=20
> Can you cnfirm that your "reproducible" case starts working with that=20
> addition to your ~/.gitconfig? If so, the solution is pretty simple: we=20
> should just lower the default pack windowsize.

This certainly corrected the issue, is there some magic
packedgitwindowsize that i should be looking at my own repository (our
internal one) in order to prevent the issue from occurring?=20

Looking into .git/objects/pack, I think the two biggest pack files are
3.5G and 177MBG respectively :-!


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-EJXiEHVDtfQ3d8mrIUbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllT4MACgkQFCbH3D9R4W9bHgCeMQY3FmdxRM6Gq0De1WQgLnzc
BqsAniXafLbs6UxpCtdQqykmtoYJmaGr
=uYUE
-----END PGP SIGNATURE-----

--=-EJXiEHVDtfQ3d8mrIUbm--
