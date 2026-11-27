Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811736;
	b=mk3G1PsH2bpL+yHvWAAz8r8eMVV3jEeqX5SP79OJYdBqJKNMKey+dpgsT4TCNK1IUgqf
	 5c0I5rsHvX4MA89qAZ70Fmt5rU4cuBxJIDgAoeQ1josqg82GzJ3Pd34zyaRpIC/WkMuVv
	 Arx2zt3tFIOw3Y9JVizOmMjKMqefw/b8h593Umv5rY5uioFvu4rOby+6Oq+NB0CNumx/O
	 2a1cswjtA23+M87rL9/sKy6OHgT8O/NCxeZQgzN9SqTtDc1MbfhbHommr8WKl5ju9NBxa
	 awBN5Seh25PPqImypold+8UZg33KG9hQrGP+gx+pbZci/ilM/qcTlodEKHPaRfH8zpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811736;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=TXwxFAMU5OtWrhxu77LZ8lneNlqF4KvR8+ICCwW4xnA=;
	b=BIt2kJCb8K4kOX/HlFMF3xze2DaFpzwVnNjgXa0Sr4FOkDSXAb81QXjjwZgTClU+L9tS
	 brLv03grkj7QUtA5Wtad///nOZaU1LQhM8KTmV0rRpjheAdOnJc/GF9D8f+g1nvJpj7ka
	 6aUVvH1QqKu9PFwpjSw5oemsXjnrVd7dzWLc0xVrpA3oUUsAHuIbaWWwr+S4XQGhEtiMc
	 GnzXWMBLgTs7NxL0SZmkpgOGteQZGdFuWL+Z5h8rwmHD+ujsID6Std/6NghB2joMPJQZw
	 2QfTZQZXtdYWOUcwSfK0/c3sDU5QfvVoPEc6akYQuypiCnh0f2cjNmB0yMUmIJR2F4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=aJBaHDId;
	arc=none smtp.remote-ip=109.224.244.28
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E314606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 20:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E314606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=aJBaHDId
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795811732; x=1796070932;
	bh=TXwxFAMU5OtWrhxu77LZ8lneNlqF4KvR8+ICCwW4xnA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aJBaHDId1UgdsbWVawyAJnja0LHs0gUa6gPHtnpPMsRwUmVFmRGQ7weWsKnvgFU0z
	 7hSXszZqqWLq9Y6aB61UlIn0IWHa9IPZPk22Tp2kKk3vgINHbTIhLFS1wvRf+tR4KE
	 g7/8tL4M9aLHDCyigsnGiwAqVW6/YYbUAVeXw1DF5JG5dX5wOvnmFzSbchj+2lzdKd
	 FiKcAYo+VuYVgAAyMUGmiJ/QsQAyUmxYqvUqxWt2PnBHtXg0CpmCRf/69ONoXZmflq
	 sZb1jZkr42lHpGHthV4xbgSYDVP1WsTs1aFXAH0SbtyeqrYoNCR3dOke+7b9Uh0C/h
	 /P9f+B2L1WTFg==
Date: Fri, 27 Nov 2026 20:35:29 +0000
To: Junio C Hamano <gitster@pobox.com>
From: ATTILIO ALESSIO <attilio.alessio@protonmail.com>
Cc: Alessio Attilio via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] status: warn about stale submodule URLs
Message-ID: <OMY1zvJHIGS8yvryfUhct_Q4HkqQNP3QJ0ezjSIY6F5k_L5UpMLJ0B31C5LUjJwglnYlccCCh1WVqawRDXMUQXPX9FgsxWFwrcS5HUGaZ_4=@protonmail.com>
In-Reply-To: <xmqqecc69maa.fsf@gitster.g>
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com> <pull.2509.v2.git.git.1795796162.gitgitgadget@gmail.com> <b0dd21100ccfe4411ccc1237fdb7ddedb66075e8.1795796162.git.gitgitgadget@gmail.com> <xmqqecc69maa.fsf@gitster.g>
Feedback-ID: 158305026:user:proton
X-Pm-Message-ID: eba015aec0ce117b7d41316cbfe54a3e8f2ca76a
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------7b718d8737d262fb4d77f58b4d67d297ffc9dda5a9e99302f08017bf093a4a2d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------7b718d8737d262fb4d77f58b4d67d297ffc9dda5a9e99302f08017bf093a4a2d
Content-Type: multipart/mixed;boundary=---------------------fe6a74c625c7648773990770c1dbf7f8

-----------------------fe6a74c625c7648773990770c1dbf7f8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

"Junio C Hamano" <gitster@pobox.com> writes:

> It would help to explain in the proposed log message why three URLs are
> compared and under what condition, and which status formats emit the
> warning.

Will do.  I will explain in the commit message why the three URLs are
compared, under what condition the warning triggers, and which status
formats emit it.

> Perhaps move the unnecessary call to repo_default_remote() after this
> early return, before the first use of 'remote'?

Good catch.  I will move repo_default_remote() below the early return
for non-relative URLs.

> Perhaps use repo_config_get_string_multi() instead?  I do not know what
> error behavior you are aiming for here, but the 'string' variant would
> barf on an entry like '[remote "origin"] url' (valueless true), which
> would give you NULL in the '.string' member.

Agreed.  I will switch to the *_get_string*() helpers (or guard against
valueless entries) so we never pass NULL to strcmp().

> In order to match what sync_submodule() does, 'gitmodules_remote_url'
> should be computed from the raw 'sub->url', not from 'gitmodules_url',
> no?  For 'config_remote_url', we do not want to run relative_url() again
> on 'config_url', I think.  You only need to prepend 'up_path', or
> something, no?

You are right: the values passed to submodule_has_custom_remote_url()
have already been resolved once, so resolving them again produces wrong
paths when the superproject's own remote URL is relative.  I will
rework this to resolve the raw .gitmodules URL and prepend up_path to
the cached config URL, matching git submodule sync.

> Instead of excluding individual cases (like "commit or history can call
> and .commit_template or .nowarn may be set by them"), can we make sure
> we call the extra check only when "git status" is calling the wt-status
> machinery to prevent it?

Yes, gating the check so it runs only when invoked from git status is
much cleaner and avoids leaking warnings into commit templates.

> - Should "git status <pathspec>" limit its check to submodules under
>    the given directory?
>
> - Should "git status --ignore-submodules" bypass the new check
>    altogether?
>
> - Should "git status -s" and "git status --porcelain" detect the
>    misconfiguration like the normal "git status"?
>
> My tentative answers to the above are all "yes", but the design needs to
> be discussed, the choices justified, and the result documented in both
> the proposed commit log message and in the "git status --help"
> documentation.

I agree with "yes" on all three:

- Respecting <pathspec> keeps the warning scoped to the paths the user
  asked about.
- Respecting --ignore-submodules matches user expectations when they
  explicitly ask status to ignore submodule state.
- Emitting the warning on stderr in -s and --porcelain modes ensures
  users and scripts still get the diagnostic without affecting machine-
  readable stdout output.

I will update the implementation, tests, commit message, and git-status
documentation accordingly for the next reroll.

Thanks,
Alessio
-----------------------fe6a74c625c7648773990770c1dbf7f8--

--------7b718d8737d262fb4d77f58b4d67d297ffc9dda5a9e99302f08017bf093a4a2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wrsEARYKAG0FgmsJ6YAJEChTxUkNXp/XRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdvhgHjiHGWx4QW7UfUmmvZcS9qo9zzEEtcw5vk
bSJsTxYhBFac0FsKMyEPbw2vTShTxUkNXp/XAADktQEAqCBhgbM12pvGAj3m
gOihWOX/J3ansVxo01zBcv6W/B8A/2zUBXgRx6BImdCYfbWAmnYIOqYPnroo
RTDT93Mi5W4N
=BFG3
-----END PGP SIGNATURE-----


--------7b718d8737d262fb4d77f58b4d67d297ffc9dda5a9e99302f08017bf093a4a2d--

