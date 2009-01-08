From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 07 Jan 2009 16:49:40 -0800
Organization: Slide, Inc.
Message-ID: <1231375780.8870.629.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <alpine.LFD.2.00.0901071621340.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-CjL0ChRVtdhuuHmv2BAi"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKj7a-00017G-2M
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbZAHAtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbZAHAtq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:49:46 -0500
Received: from mx0.slide.com ([208.76.68.7]:60987 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbZAHAtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=s
	sVsIiDTzQgkXfVHh0V7CPunZuCLJHPpFTR5uKYBlOU=; b=prRbI4jCfgTPnNT5N
	G82hvf6TiaihjUhrzz5CbWGYIVksXdmGdnYg+sXTig5Z2eMOgHSTEw3PU2EuUjcu
	gGHWcd5MoRV+nGtp7uQTHGLtXjFHqMzdJYw9+Q//QpoKz2L2PAyO1UiIgwFdAlhu
	3b9rv8bQILCt3hIRwZaNpCpNwI=
Received: from nat3.slide.com ([208.76.69.126]:43804 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKj5i-0005oT-8K; Wed, 07 Jan 2009 16:49:42 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 368843898BB3;
	Wed,  7 Jan 2009 16:49:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.864
X-Spam-Level: 
X-Spam-Status: No, score=-2.864 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.140, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ncwVObAU7FJ; Wed,  7 Jan 2009 16:49:42 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 030B93898567;
	Wed,  7 Jan 2009 16:49:42 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071621340.3283@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104861>


--=-CjL0ChRVtdhuuHmv2BAi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 16:37 -0800, Linus Torvalds wrote:
>=20
> On Wed, 7 Jan 2009, Linus Torvalds wrote:
> >
> > >         > limit ~1.5GB -> corrupt file
> > >         > limit ~3GB -> magically no longer corrupt.
> >=20
> > That is interesting, although I also worry that there might be other=20
> > issues going on (ie since you've reported thigns magically fixing=20
> > themselves, maybe the ulimit tests just _happened_ to show that, even i=
f=20
> > it wasn't the core reason).
> >=20
> > BUT! This is definitely worth looking at.
> >=20
> > For example, we do have some cases where we try to do "mmap()", and if =
it=20
> > fails, we try to free some memory and try again. In particular, in=20
> > xmmap(), if an mmap() fails - which may be due to running out of virtua=
l=20
> > address space - we'll actually try to release some pack-file memory and=
=20
> > try again. Maybe there's a bug there - and it would be one that seldom=20
> > triggers for others.
>=20
> Ho humm. We really do have some interesting things there.=20

Always enjoyable when these mail threads get this deep ;)

>=20
> Is this a 64-bit machine? I didn't think OS X did that, but if there is=20
> some limited 64-bit support there, maybe "sizeof(void *)" is 8, then we=20
> default the default git pack-window to a pretty healthy 1GB.

I was only mentioning OS X with regards to the Samba/NFS red herring,
the rest of our operations are on 64-bit Linux machines.

The machine I reproduced this on ("Public repo case!") is the following:
        tyler@grapefruit:~> uname -a
        Linux grapefruit.corp.slide.com 2.6.27.7-9-default #1 SMP
        2008-12-04 18:10:04 +0100 x86_64 x86_64 x86_64 GNU/Linux
        tyler@grapefruit:~> cat /etc/issue
        Welcome to openSUSE 11.1   - Kernel \r (\l).
       =20
The machines we're experiencing this issue on "in the wild" are:
        xdev3 (master)% uname -a=20
        Linux xdev3 2.6.24-22-server #1 SMP Mon Nov 24 20:06:28 UTC 2008
        x86_64 GNU/Linux
        xdev3 (master)% cat /etc/issue
        Ubuntu 8.04.1 \n \l
>=20
> I could easily see that if you have a virtual memory size limit of 1.5GB,=
=20
> and the pack window size is 1GB, we might have trouble. Because we could=20
> only keep one such pack window in memory at a time.

The DEFAULT_PACKED_GIT_WINDOW_SIZE in our local builds is 256M, FWIW

>=20
> I have _not_ looked at the code, though. I'd have expected a SIGSEGV if w=
e=20
> really had issues with the window handling.
>=20
> Anyway, _if_ your system has 64-bit pointers, then _maybe_ something the=20
> default 1GB pack window causes problem.
>=20
> If so, then adding a
>=20
> 	[core]
> 		packedgitwindowsize =3D 64M
>=20
> might make a difference. It would certainly be very interesting to hear i=
f=20
> there's any impact.

I can try this still if you'd like, but it doesn't seem like that'd be
the issue since we're already lowering the window size system-wide



Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-CjL0ChRVtdhuuHmv2BAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllTaQACgkQFCbH3D9R4W+RDACfesY0Q1mmz9AvX0vrj3seu03H
a70An32axrYsDqpuplO9dyj1FANcBzh7
=ZYOt
-----END PGP SIGNATURE-----

--=-CjL0ChRVtdhuuHmv2BAi--
