Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE38651B6
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398090; cv=none; b=Z+KnpIL852wbWvVWXcF6fFvCyqDOv3qBWjmpeEMX3HaQHkdx1WklcoMA04q6pkBuujl4IRxHjnFm24J7u2IwtXrILjBvPNCZHBRPS2R+aJHjlN57qgss380RrE5xP1iIZNNV+B/d/zx2i8dAUK7Z70Jjfij/HOFeToN0zMeAckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398090; c=relaxed/simple;
	bh=+z8Y5xhN/yfCX+s7vfGkQAFdr+wsfEgRxptv+IuR9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=skjubcFxYUyz9tB4sMsfPf2OkkyasO4KS2+uTw296L01uZ2xF0cq+yWkRVoV9pKwtc3QkOthoK9TV4RfgtSvL3R6STNnJruM92rHMaDUOwmXKFINklnpg8Dw6RTY3GwYnrszvSy3cX/5Buotru76/amtFPJYV+CbdoN7Up90/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tonC3vk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jXQ5Fcy0; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tonC3vk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jXQ5Fcy0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 30B8A1C000E0;
	Mon, 29 Apr 2024 09:41:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 09:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1714398085; x=1714484485; bh=BHVQlu252Kg6VvRyiLDokCPlli7ucj/N
	iahLQGCjBt0=; b=tonC3vk/gO4rDlrPBlWTzniwerbe7DMP237+9Pk8M0V+78Cd
	M6hVDwwVTS8fi4wstcw5n7cdZQ1DXlp6f33RekbSH75aQCibJm9XiC6NVch4DbsO
	vSRzBzeKb8o0daAE2W02dGSAcPeTqj1JkrsJNmhrWNUraV+EXmVW6/diHLGhvwmi
	UBMS54Omk0drz6Vh/08hJGOhsz5CKeC0ZJjpmAjHCYqxaLRxoe/ts3nWUoF6XHOr
	vxpuMAHcTkLnvmiEu8zvauowgJv8934YudH0pfPWiEtaE/JEEJp3i2bNvd5uD1n+
	DCdxB/WWJRvccKpWoK0GpWPcHtq3Mq1z3vABcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714398085; x=1714484485; bh=BHVQlu252Kg6VvRyiLDokCPlli7ucj/Niah
	LQGCjBt0=; b=jXQ5Fcy0AIzeYVPCJ5gDqNSHBBR8xvopnVNFjtDoMi8ABx6hL60
	3MijOWeQTB02ZI9QeReza/LoZfMDJh/G44JU0abSgeCqvrUIyBj1f0fZB5I2oXlY
	LRw9bltHQldNxHOyaVuLMVKgibkKO1fhi6GY8eWT5iKUt9lkZKv6k29If/A+bzOY
	VrRQ6h143FRDXdMwjR9vuFrSJ63Xn49s8OL5W97wd+0N/EGGuOn23JwbooD0n0ov
	ImW0k+k1KuK8Wn6MbBMSHbwzrTStPHSDQb/uAl6H6CHE7DGt1XGsJcG+bLy5HrC8
	+bQkb3Fc/yFxQhxRfdJMbPubYCmzTl+xJnQ==
X-ME-Sender: <xms:haMvZjWlvs17l-n1lMkYqWC242O7vEERSi1jo_GQ9SqgVQnlhOBjQg>
    <xme:haMvZrkRbG2SsB0cKK6vrXoAv9pUKj3OoefVDcaaxuTKYlNxAso-d4qbDoVArZYzy
    xz7YIhFKhRLERKA5Q>
X-ME-Received: <xmr:haMvZvYZ3GpDBy9prGyaVw2UfFae7U1KFBGuCW1R0qRYgHzxGmyeM7pBkWutV_a4sSvg8afHHNRK5xDZOfXc5CFAvp8SFSIautgr9s7AoXsrDg30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:haMvZuV9tcZvbPkBJfMtiC1IsJQsxL1e0XAsOJRFW3Mcj7G6-U6X2Q>
    <xmx:haMvZtkcwouhQQZOqPZ1Mlx6KqHqiXIQzmCldMuV4RiOTFux0C6FWQ>
    <xmx:haMvZrfagy4lfDaNM9urRbDaNYpTFfkPWsQLoBvkfUmuiR7HQusvcQ>
    <xmx:haMvZnEb9gmyKTTKDL7mrQGcQk1WffzNh-5ocut4YBBxmOD_E7AAYw>
    <xmx:haMvZjhA8g43ZTxJj25YWhfQfwvWs44MjK3y2GYQ_LU0sQKAbR9vo5Js>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:41:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 509fe54e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 13:41:02 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:41:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] Clarify pseudo-ref terminology
Message-ID: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpGhp03X3ig9304g"
Content-Disposition: inline


--jpGhp03X3ig9304g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

there is quite some confusion around what is a pseudo ref and what is a
special ref, and the documentation in gitglossary(7) overlaps. This
patch series clarifies that:

  - A pseudo ref is anything in the root directory that conforms to the
    pseudo ref syntax (all uppercase, must end with _HEAD), except for
    special refs. There are some exceptions that are now listed
    explicitly, and these only exist due to historic reasons.

  - Special refs are really only either FETCH_HEAD or MERGE_HEAD, where
    the reason is that those aren't really refs, but can sometimes be
    used as such.

I was very much pressed to go a completely different way: drop the
special ref term again that we have recently introduced and replace the
pseudo ref term with it. This would return pseudo refs to their original
meaning, namely something that is not a ref, but behaves like one at
times.

The current class of pseudo refs I would then drop completely -- in my
opinion there is just no need for it. Everything should be a ref, and
what we currently call pseudo refs (things in the root hierarchy) is
really just a naming policy. Refs must either have pseudoref syntax or
they must start with "refs/". It doesn't help in my opinion that we give
refs which conform to that naming policy but happen to live in the root
directory a separate name. They behave no different than a normal ref
anyway: they are stored in the refdb and can be read and written as any
other ref starting with "refs/".

So, if we went down that road, we would:

  - Not have special refs anymore.

  - Have two pseudo refs, FETCH_HEAD and MERGE_HEAD. There is no other
    pseudo ref.

  - Clarify that refs must either start with "refs/", or have an
    all-uppercase name ending with "_HEAD". Exceptions to this rule are
    "HEAD" and a couple of others that we wrote due to historic reasons.
    All refs that match these rules behave the same, there is no
    difference between root refs and refs living in "refs/".

I think that this would be quite a lot easier to understand than the
current state of affairs we have, and also return us to the original
meaning of pseudorefs.

If people agree with that line of thought I'll happily revise this patch
series. I didn't do that yet because it would be quite a lot more work,
so I first wanted to get some buy-in.

Patrick

Patrick Steinhardt (3):
  refs: move `is_special_ref()`
  refs: do not label special refs as pseudo refs
  refs: fix segfault in `is_pseudoref()` when ref cannot be resolved

 Documentation/glossary-content.txt | 36 +++++++------
 refs.c                             | 81 ++++++++++++++----------------
 t/t6302-for-each-ref-filter.sh     | 17 +++++++
 3 files changed, 76 insertions(+), 58 deletions(-)

--=20
2.45.0-rc1


--jpGhp03X3ig9304g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvo34ACgkQVbJhu7ck
PpT8Hw/9FUvNYvgnl4riO2/6pe8S6e4QxK+KogRY0tkqku9OlTAmzvWA/9VX4GLW
ugullU5rOZMgM23YHkNEOThMlI3GKsqPXtdm7DzzPEgJVvLIujfVS/EiX8UcLJqa
iVyfZa5G3I3Ratc31XNptiveyOlF2yzsDJ9CBzFxAcldPeAm/MkmjX20AphOebtZ
BM8hIa6IwV7MfvSXSXwPdHYYy+W9zO5S7E2xzvL1kcielAnGoF87T0sb15nRoh/b
49svz660pVCHDmEuSBPE79+6IAEFpQV4/WwjHoIBE5UcnUIMotPSG7CemruaKg6M
3kwXLZj7TsGM30V3G7Q/2tBy+DFJ+BknoR5h1L6sTquk56TOF8tNQ0MnTJItoZQA
t2cdYqs2s17PpSwxyfTZ7+UPq3fPsWkMFwNmy6FJPR88fuQyaC4o8VUoZ57N9Bp+
ZgzeutJeEORL+nzRV6z+hhenM2jJPsJw9mP+u3K8z0RIqYP0WJEdbdFX0OOsvt8e
wK0k2CvIR/TUDiRPfl+VoXZWCD0jeUFJOyxxbySOASBz3Y4LKACSJidXWaNr4dOm
6cJRKhSoZ0X7WbW1JezLsP2EaSwqm8r/lBtdC5mNY4K5VnzvYd7KRd8kF962HA/H
55S9vPl4B8Ex97i7POkRge+WpkmwD5p+8oPGvqntU84eGAyzJfA=
=CNaP
-----END PGP SIGNATURE-----

--jpGhp03X3ig9304g--
