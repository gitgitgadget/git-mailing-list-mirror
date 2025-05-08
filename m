Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981114B1E72
	for <git@vger.kernel.org>; Thu,  8 May 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746738465; cv=none; b=SQYC/1MA4FHVlCPaQgK5DwYICk4BFp3waD7a15afRqQ/V+ya7jOVlqL7+H/UaRretpOF/IOibpoY02GtLZdRf0WHL2FByEhBBEcPR1avEYD1pJxvajR+mw105QePpEqutSfXyYOWuQFXwr11lYB3HhaYo/WF82l8czXtehSCm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746738465; c=relaxed/simple;
	bh=nEmez69T2rem+79/2aAqsau63hzq5U5GQwJ/jUFaLeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU/AU4HkLTzNQ5zJ3sTlTV/Jaz+yvVErs4g2vU8muLS38A5Nu/A5sZWnBpLcxjt1aHFF3VWRWyuoCjhHctKNZwk+MuM4EyN020Bf1FN13xyjVOB89ApMaeAN/ILnLk5T8e9QTNNOwtNHxv8RMpqj0XsA35VIKP9tkYg8Pqcxy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 007EB3430C6;
	Thu, 08 May 2025 21:07:41 +0000 (UTC)
Message-ID: <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
Date: Thu, 8 May 2025 17:07:37 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configure.ac: upgrade to a compilation check for
 sysinfo
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
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
In-Reply-To: <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ekHrD14GsvTzXT0PbIPbDOyT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ekHrD14GsvTzXT0PbIPbDOyT
Content-Type: multipart/mixed; boundary="------------ED7LsLdoFgc2fRrN0pxBq9lj";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <9baad29d-a5bf-443d-98a1-36d7020e5835@gentoo.org>
Subject: Re: [PATCH 5/5] configure.ac: upgrade to a compilation check for
 sysinfo
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
In-Reply-To: <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>

--------------ED7LsLdoFgc2fRrN0pxBq9lj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/8/25 12:44 PM, Ramsay Jones wrote:
> Commit f5e3c6c57d ("meson: do a full usage-based compile check for
> sysinfo", 2025-04-25) updated the 'sysinfo()' check, as part of the
> meson build, due to the failure of the check on Solaris. Prior to
> that commit, the meson build only checked the availability of the
> '<sys/sysinfo.h>' header file. On Solaris, both the header and the
> 'sysinfo()' function exist, but are completely unrelated to the same
> function on Linux (and cygwin).
>=20
> Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
> cygwin", 2025-04-17) added a similar 'sysinfo()' check to the autoconf
> build. This check looked for the 'sysinfo()' function itself, rather
> than just the header, but it will fail (incorrectly set HAVE_SYSINFO)
> for the same reason.
>=20
> In order to correctly identify the 'sysinfo()' function we require as
> part of 'git-gc' (used in the 'total_ram() function), we also upgrade
> to a compilation check, in a similar way to the meson commit. Note that=

> since commit c9a51775a3 ("builtin/gc.c: correct RAM calculation when
> using sysinfo", 2025-04-17) both the 'totalram' and 'mem_unit' fields
> of the 'struct sysinfo' are used, so the new check includes both of
> those fields in the compile check.

and

> Note that I cannot test the new autoconf check in patch #5 (I don't hav=
e
> access to a Solaris system). I _think_ it will correctly unset HAVE_SYS=
INFO
> on Solaris, but I cannot confirm that. (I can only test on Linux and cy=
gwin).


Well, I can confirm this results in the detection being correctly
changed on Solaris 11.3 and stop reporting sysinfo as available during
=2E/configure, so this has my ACK on technical grounds. That being said,
in the original meson thread, there was this review:


On 4/22/25 3:31 AM, Patrick Steinhardt wrote:
> On Mon, Apr 21, 2025 at 01:51:46PM -0400, Eli Schwartz wrote:
>> It is deprecated and removed in SUS v3 / POSIX 2001, so various system=
s
>> may not include it. Solaris, in particular, carefully refrains from
>> defining it except inside of a maze of `#ifdef` to make sure you have
>> kept your nose clean and only used it in code that *targets* SUS v2 or=

>> earlier.
>>
>> config.mak.uname defines this automatically, though only for QNX.
>=20
> Ah, interesting. I mostly went by our autoconf infrastructure when
> converting the checks, which didn't have a check for `getpagesize()`
> either. We might want to teach autoconf to check for this function whil=
e
> at it.
>=20
> In all honesty though, I rather hope that we're soon in a state where w=
e
> can just drop autoconf altogether in favor of Meson. The only two
> blockers I'm aware of are wiring up git-gui and gitk. The former projec=
t
> has already been adapted upstream, the latter is still in review. But
> once those have landed, we should be ready to mark Meson as stable and
> then we can start deprecating autoconf unless there are good reasons no=
t
> to do so.


So you are indeed teaching autoconf to check for this function, but
should we also ask whether it's worth continued maintenance of autoconf?
It was/is not clear to me who the stakeholders are for the autoconf suppo=
rt.

On the one hand, it exists so maybe it should be fixed when we know it
has issues.

On the other hand, it sounds like this patch (and commit 50dec7c566
"config.mak.uname: add sysinfo() configuration for cygwin") only modify
autoconf out of a sense of duty, rather than finding autoconf useful.
What does it say about the autoconf support if the people finding bugs
in it don't even use it, but only discovered the bug while working on a
different build system they do use and depend on (config.mak.uname, or
meson.build, both count here). Who *is* using it? Apparently not Solaris
users?


--=20
Eli Schwartz

--------------ED7LsLdoFgc2fRrN0pxBq9lj--

--------------ekHrD14GsvTzXT0PbIPbDOyT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaB0dGQUDAAAAAAAKCRCEp9ErcA0vV6Wy
AP0VUAGBmI6DspmgEQhWffnLDUPCTZdcGrb5xBGUX+SU5wD/UPe3jom4XgGV2kf0QqI5YYZVBHav
5N76It4l1w32lgo=
=uYBm
-----END PGP SIGNATURE-----

--------------ekHrD14GsvTzXT0PbIPbDOyT--
