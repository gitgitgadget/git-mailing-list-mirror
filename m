Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9753368
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366674; cv=none; b=kupJr5p/ns72J/O5sQqxaxr7qgGdNpkgKEiNpSkwf/LXri8sdaDgKmGyqOuYeLzEjU0Kbey12dyvyxtWFVHAn7f76ALpEtCXi0l0UR0DO7TMU9qZLXEzVbJa9ubHGBk6xrppF6OnUaluJVMfk3mnEw2L2wetLvY0wvoe9TdBB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366674; c=relaxed/simple;
	bh=9xOodYjTy4mygRGcu/yWTO1zKZR8X8Kc75+pWhjeVGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWzaj+iKkV+OuZPayvpaA0um5PFIAvBAtr8Q4SELXZSfblj6GeF/BBJwNSRJlS2QMxfGi/ZuonlHYkcptWmyMF1+DlTn5rJFF1OkI134uQ74ttzA8dsxnRbGatP2HNJ6w2oiI3MTQnObxGxlBZ+EnFde3powTk20/wzHm/Ul9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <71ed5967-0302-42bc-97c7-81886408d688@gentoo.org>
Date: Thu, 26 Sep 2024 12:04:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pdpDbdNblJNM4O3A0OUDw9Km"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pdpDbdNblJNM4O3A0OUDw9Km
Content-Type: multipart/mixed; boundary="------------2sF0XIklnyzcrWySN9eK70eU";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <71ed5967-0302-42bc-97c7-81886408d688@gentoo.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
In-Reply-To: <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>

--------------2sF0XIklnyzcrWySN9eK70eU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/26/24 9:55 AM, Phillip Wood wrote:
> One thing to bear in mind is why our CMakeLists.txt was introduced in
> the first place [1]. Visual Studio's CMake integration means that so
> long as git-for-windows is installed building git is simply a case of
> clicking on a button, there is no need to install extra software or
> plugins. I'm not sure the same is true for meson and I don't think we
> want to end up supporting both.


I can't really offer suggestions on what may or may not come
preinstalled in Visual Studio. That thread does suggest the major
problem cmake was trying to solve is:

- having to install the git-for-windows sdk at all (is it still
  necessary? I guess so, because POSIX shell and perl and mingw
  runtimes. Unsure how either meson or cmake could solve this.)

- people who are *unfamiliar with the command line and want a GUI*


Meson has a trivially installable VS Code plugin that is supposed to
handle setting up the project for you. You can generate either ninja
projects or Visual Studio solutions. "One may need to install a plugin"
is hopefully not as big a barrier to entry as "install a bunch of stuff
then go to a shell and run make vcxproj". Is the criteria truly "must be
one button click"?

I'm aware that Visual Studio and VS Code are different IDEs but I know
nothing really about the former, SEO for distinguishing between the two
is *atrocious*, they use the same exact plugins marketplace, and I
figure using VS Code ought to be easy enough for such users if
necessary, anyway.

I think that discussion between Meson / CMake / GNU Make / etc. should
be based on technical merit with attention paid to ease of use without
coalescing down to "unfortunately, our choice has been made for us. We
must support a *specific* Windows IDE and use whichever build system is
preinstalled inside that IDE, because it must be a one-button solution
with no dependencies".

Stuff like "how painful is it for a Windows contributor to set up an SDK
and then also go mess around with Makefile targets and then load the
result into their IDE" is an interesting discussion to have but not
quite the same as saying "go to the marketplace and install such and
such plugin" is an obstacle.


--=20
Eli Schwartz


--------------2sF0XIklnyzcrWySN9eK70eU--

--------------pdpDbdNblJNM4O3A0OUDw9Km
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCZvWGCwUDAAAAAAAKCRCEp9ErcA0vV22r
AQDiMNq0It93RURNRZq4hKmulAjX2ltat+6peG+q7T55qAEA1Rkvy+vk4VILTbM9mC+bhdLrJxaC
Hew2Msw5xMbEMQk=
=zsfl
-----END PGP SIGNATURE-----

--------------pdpDbdNblJNM4O3A0OUDw9Km--
