Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399534;
	b=k6s//vFcLosNSEzLpqG6q6qnoXlUEUE/YSnonIouIrhtkXO9q6XFuy/ibqpnnMGHNgpp
	 VxALT26xP2Z29DrU9HwBUfHp8pZCoNOlrR0bSKB0mxLAXELw1ByeigpigWyTqSfCyygcW
	 1NIoiSt9aId5FxjOjNg7vn4e4CG8DJi062Z2DqDiEUlvpXKUJHn/vh+TYDjenoGMb9nMN
	 a6zd1r2Mi8fhKw2s93RiGBeCT1xCk6SD3XuAFtisiGs+ZkAk/oIaNMPgNynUDB3iPgxXj
	 gYoo6iBxPUdUmBxKhc4DVzFL/OX51EgEVNX9b7cx/MRj+YW8FnSgkKkas2ugLjAGPYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399534;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=jKPpVa7LVp7g/lKDhNPT6yHXoKDs5iEwMb3znIK2rzM=;
	b=ocROJUZogiq6Z4U9V2+i33Z5kRKfeB9C70GHYRe+XIyPsOfiMMEpQMgKjeYTqKs53R2T
	 kqBgR1rkOF78A3CRnkMlQFwQAyUH3zz++KbruGoAtSGldSrXk82A5D+FEfNxfSba+dNz4
	 kL5bTOO1Gyl1Ter1d6jaTiazZDYQuGQ3IZ5Dde7ra55vGInXuXyvmrAbHAZiOpqWJzv5U
	 zpaKCQJb74hVHgHHAkHO/0NucQrZ2g3fFz9ln+xAcPrctpQIina9h1U3SCLRIaTO5kHPq
	 ERnX6fNwk8MliwN9JXyoyRmPBPpXdN422Ac+Kk9S2uENtXdnU39AQ0sUYF0uSLXqnbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rMmMKMiZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lYEM4DBe;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF912606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF912606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rMmMKMiZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lYEM4DBe
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 40C241D001B6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:18:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 07:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399532;
	 x=1794485932; bh=jKPpVa7LVp7g/lKDhNPT6yHXoKDs5iEwMb3znIK2rzM=; b=
	rMmMKMiZkuK7+e9j5qsaEHURtOp1Ptd1Pk4XrGK2l4fVM7vU2+NL19+RFIopm6Yt
	dmAYwRTwhwXXi2KxLFIdfsu3SK1qKRHulKR+3lSr//B1Hf7OcHqyqi+tvMujHzOj
	t7zYyuzaIpQQdTx1eO8cFEIcClqmPLYHeURgRGPFwh7IRpwNCLW13VL4MG4TsfSJ
	iCHFXMwQL4t+pzLM440iou50GFR59UHBQHkEnI3XnZjwVBoYLb1IOUxdyU+j1vNE
	84KeepekDMMqUDoc0Mvt4Wvgk00VZO0rBO0bjRVWOsdRrvmzyzYIl6IcSIykGQmm
	v0e7kRea7pxYi6wOhHCAgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399532; x=
	1794485932; bh=jKPpVa7LVp7g/lKDhNPT6yHXoKDs5iEwMb3znIK2rzM=; b=l
	YEM4DBeTMw8Lv5tazpuPE714tdxAi3qUJkvSzYn8QHsgjw+AYvzA+hf20dgBdOMa
	wokqUBqVZs1SiBwUduZHZNJSfEc/FkWy+pfoF2zQ55P86AmwDioc1dvHnXAb1oOO
	HBNdy7YVGjrDXPCJ7fty3D/GmpC73NOW9SQ1w7CDDUqM9h5kdcu6BE0PjadwsU4U
	rq7nAoTgRM655ug9wrTlEQrmepxoJ8/8yZpV3lwHSIWWRPil6jFNdRtNFuOVQYZr
	PxBl3CwRO0VmqB8UrssSje/bmMRRohqlSIBYIB0ZdLGjAhKXKO37nKATrWy99VOW
	vvEHMpUv+Dazr/AgKRQeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399532; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XjdXK2eZP1bx9ZAofCu1NY62CYy8KZ+D0WatrjM+NhKMPKi
	tXnTY5wpmCfE2yAf8hffi+Pygn31/WaHcyDWRelBD+jS4Ei9zix0xSV/BZHmjSNx
	+EjYSGWZ0FMo6WBydJdVMrYxu3hy5kTsxIsF21bxi3QVSyWeYBjt+zfd77aDQTRj
	4G3QDcsw5WUurCL6/LhxTkoWqjfbEdyiO+6/LWEVQSiGMW/3N304CgV266XtPmxA
	3EVerCmSvWoeLwbSx9V5R2jhcYTYPla5tvpLLejc/NPf/9JRSh+mM40IVojSjB6t
	LEANpeqtVIYI5n/rrhcFFuMe6PvwHNFsiWlklbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:us7d3/hDnGLna+DOtK8+e/ZZyv7hE50jGUpd2MbvCRA=:dgXUTbChvEG4vbnSrceXkiuo2iOhF3AaRcLlbidKG/A=;
X-ME-Sender: <xms:LF30aoMmzuMi59P37HkpOJXbWgP3HbROmZWIWI0NwE9vJJ3hc44I7A>
    <xme:LF30al_YUrP_GlDP5Kq2x28cAVCtbTj4rA5ki9xtH6guqnb5VZJcHSG67LmPaSRXz
    Z2zyBlzCnLNr0cbBjc8y4RNTEO6uPQuMP6aKl9gUGaPhGL0WSktWmY>
X-ME-Received: <xmr:LF30akSIKRCbngAGoaeZMQl2jbB6iL6voP7Sqohd19Qb2fqXc2VoNW9IPk-0QuLhIZcSNQ>
X-ME-Proxy-Cause: dmFkZTGUbo6pLIMpgbrx2XOUAchq5v6Dy5wcqWod1AZmRN7He47Wrc2DE14iZmZDRxWMOr
    xRptI2SpSopX7CnW443E7MxxzjYHYTwt0X7YlY+Vvr7U5dy1Kd7RwGvMWgqND42MIlNd25
    U38J9mA/87xYsFE1pxFipQq8W6KSZvWM4pRcf4lUKpYjHd27P6RUS6owvp4NuwMgRXg48m
    1Q0X9WPIw8wmBB6IMpsNvbHV494N47ZkQ/Jwb03xnGjMyJAEMnoX6zG7ncP5GVSlOzS/Dp
    QxTIULSeZRrw3NSsyLjja8Qf2o7XltG8E+rr1ag4pqcKgCGq+rxQB6GuSc7WfU3CDCiOsa
    675Ktf155IyPXb22sQfCs4NQGRbty2iTBpsEk9l5RnebKzphyPzEwC4VkQTjhFzQ+60yr4
    yf3tekT77FO1HFYMs7JXaeCGcCG23gU1AGvqT3KtWwn2N9KaBxN5HBvF1RsBDJ/1sWzS74
    VdLPl+OE/PEPEzunQ4m86hJcZBsko0qI8CGso5anoweOQxqlPZMJjySGpU+WlJySnRrnA5
    w4ULT9m6blLQJHlG1Y8yjauC5SNv1LuzX2V66l22t23g6BR2u1UDyQA247sZhpWzqQZUp1
    5xPYTG5gRgnoIaFG4Qoz6OlYsUVjUmi1qFrm8WZN0ZYsDjvwypcn0bPSySnA
X-ME-Proxy: <xmx:LF30avkq7KHPd7X7zMUMYXxO4JjVr1cX5Bhu4SqDjWngCckTSujaTw>
    <xmx:LF30asQ391hsgCXpYnVV3VM8VCrGLTg-qL9Nbpe5rpUUj8dKdk9rKA>
    <xmx:LF30alMko6wzSFPVncTDWEKYe1zUFJm8MI5XcMK4moxFDcLltnTkRw>
    <xmx:LF30atUciBJLz-JjktPk__T5r__a8j3XlQ46AVw9vWdfYBSftaQkDw>
    <xmx:LF30anwrLPDzmiluOzXLCgpq3rc5AhSr0HWxjQ7s_nLRR7J-DifTXV74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:18:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42947d49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:18:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Date: Wed, 11 Nov 2026 13:18:36 +0100
Message-Id: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNyw7CIBAF0F9pWIthgLboyv8wLlqYWjR9BGqja
 frvQk18LBoDm5vcOXciHp1FT/bJRByO1tuuDUFuEqLroj0jtSZkwhnPgPGc9ldPHcZH/a3UXdM
 UrfFUgDIS0lRIoUg47h1W9r7Ax9Mrh/oF9RC12KitHzr3WJZHiL2/IyNQRo0SmQ4fmU4Pobi1D
 YkLI/82dqsGDwbLTVoWoFAp/mOIjwEsWzVEMGRVQSaNqkoFb2Oe5yeh+VZbUwEAAA==
X-Change-ID: 20261027-pks-rerere-subcommands-318d41553438
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

while reviewing some patch series around git-rerere(1) recently I was a
bit appalled by our custom subcommand parsing that we do here. This
patch series here thus cleans up and modernizes that part a bit so that
git-rerere(1) behaves like every other Git command that happens to have
subcommands.

This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
rerere cache state, 2026-10-23) merged into it.

Changes in v4:
  - Some more polishing for `RERERE_{NO,}AUTOUPDATE` documentation.
  - Die in case both of these flags are passed.
  - Link to v3: https://patch.msgid.link/20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im

Changes in v3:
  - Clarify what `RERERE_NOAUTOUPDATE` does.
  - Link to v2: https://patch.msgid.link/20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im

Changes in v2:
  - Document rerere flags.
  - Rename `rerere_record()` to just `rerere()`.
  - Link to v1: https://patch.msgid.link/20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      rerere: rename `repo_rerere()`
      rerere: convert flags into an enum
      builtin/rerere: drop `the_repository`
      builtin/rerere: stop passing flags to subcommands that ignore them
      builtin/rerere: turn "forget" into a proper subcommand
      builtin/rerere: turn "clear" into a proper subcommand
      builtin/rerere: turn "status" into a proper subcommand
      builtin/rerere: turn "remaining" into a proper subcommand
      builtin/rerere: turn "diff" into a proper subcommand
      builtin/rerere: turn "gc" into a proper subcommand
      builtin/rerere: use `OPT_SUBCOMMAND()`
      builtin/rerere: introduce proper usage strings for subcommands

 Documentation/git-rerere.adoc |   8 +-
 apply.c                       |   2 +-
 builtin/am.c                  |   4 +-
 builtin/commit.c              |   2 +-
 builtin/merge.c               |   2 +-
 builtin/rerere.c              | 319 ++++++++++++++++++++++++++++++++----------
 builtin/stash.c               |   2 +-
 rerere.c                      |  14 +-
 rerere.h                      |  43 ++++--
 sequencer.c                   |   4 +-
 t/t4200-rerere.sh             |   5 -
 11 files changed, 299 insertions(+), 106 deletions(-)

Range-diff versus v3:

 1:  e9237465706 =  1:  f669dc6eddf rerere: rename `repo_rerere()`
 2:  94d91a0620d !  2:  4fd3f6aa650 rerere: convert flags into an enum
    @@ Commit message
         around as enums so that it becomes trivial to see what kind of flags are
         expected. Adapt the rerere flags accordingly and document them.
     
    +    While at it, detect the case where both `RERERE_AUTOUPDATE` and
    +    `RERERE_NOAUTOUPDATE` are passed. This combination does not make a lot
    +    of sense, and it's not obvious which of those flags takes precedence
    +    (it's `RERERE_AUTOUPDATE`). All current callers know to only pass one of
    +    those flags, but let's be safe rather than sorry and `BUG()` in case
    +    both are passed.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## rerere.c ##
    @@ rerere.c: static int is_rerere_enabled(struct repository *r)
      {
      	int lock_timeout_ms = 1000;
      	int fd;
    +@@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
    + 	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
    + 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
    + 
    ++	if ((flags & RERERE_AUTOUPDATE) && (flags & RERERE_NOAUTOUPDATE))
    ++		BUG("RERERE_AUTOUPDATE cannot be used with RERERE_NOAUTOUPDATE");
    + 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
    + 		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
    + 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
     @@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
      	return fd;
      }
    @@ rerere.h: struct rerere_id {
     +	RERERE_AUTOUPDATE = (1 << 0),
     +
     +	/*
    -+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
    -+	 * working tree but don't touch the index.
    ++	 * update the file in the working tree but don't touch the index. This
    ++	 * can be used to explicitly override "rerere.autoUpdate".
    ++	 *
    ++	 * This flag is essentially the reverse of `RERERE_AUTOUPDATE`. It is
    ++	 * invalid to pass both flags at the same time.
     +	 */
     +	RERERE_NOAUTOUPDATE = (1 << 1),
     +
 3:  99faad47068 =  3:  48692c2c88d builtin/rerere: drop `the_repository`
 4:  f164c482227 =  4:  e76991dd39d builtin/rerere: stop passing flags to subcommands that ignore them
 5:  0573d2323e8 =  5:  2474dca4713 builtin/rerere: turn "forget" into a proper subcommand
 6:  2098dedf4fd =  6:  cecdbb1c63b builtin/rerere: turn "clear" into a proper subcommand
 7:  e8eaa2b4092 =  7:  54fc766f9d2 builtin/rerere: turn "status" into a proper subcommand
 8:  a5781284b8b =  8:  fa2c839b2cb builtin/rerere: turn "remaining" into a proper subcommand
 9:  9a4278df0ea =  9:  416b8311ca9 builtin/rerere: turn "diff" into a proper subcommand
10:  e63b9be0d74 = 10:  adb2b68f833 builtin/rerere: turn "gc" into a proper subcommand
11:  47889896ecb = 11:  a12e19cb2e8 builtin/rerere: use `OPT_SUBCOMMAND()`
12:  5e16a247b49 = 12:  4b1b6170ba3 builtin/rerere: introduce proper usage strings for subcommands

---
base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
change-id: 20261027-pks-rerere-subcommands-318d41553438

