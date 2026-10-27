Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098025;
	b=dZra2DFTuNsGRhCbPnprDozDmf94bQvuUJc8+hb4f3baSjDYFO/2NpWwS2y0jAi3PGZ8
	 105vv3KShPnRWj7jyNZMnZw8gAe3Y5TWF+Id6+7fiHRXOKqIY1Bok8R6hk4mhNYuwwIkG
	 j9aJ4FB3hoG8O5x/I/cpecPOuQrGkFU4ZdY+xGEO5e5Hr9iyDk6HPyP5CE4DYGhS6NI/S
	 9Rgvvt9g8Wxq+DKmBcBDj+j5K7pFWaRQdz8PSO/bSwxKrXrIszyZ/A8FJf9kMLbx4w+De
	 BKlMOLpre9Ljd3m+RH5HhCAowA7WRymWpfCwlfk3zf+lueSaIuVyH4I6NGakzCn4KKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098025;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=PgDhBlybFxQE3f1hA4EGTSAjxLnBkbtju9oDWUkAhY8=;
	b=SxBe/FDETaUNZH3Up9VlBJNhsbWTPIhceSnsPNG73KudLoOU7Acw8AqClQtndM6WVcRc
	 NLa2cG+mI3BMvUADGlUIDkWnfPOebzqRt3LkvwvCmY396O/45q2e9fRV5Vp3eQHTmRZt4
	 PgV5t8VlUhEekAEWbnbPrEGKYOOSxo9tZ8EYlK6lxzdmYqJz42U+QrkdwjzwS2Atihtj5
	 /9BYNXGDlebAAFjRVAJCFvAAi80zSDCX/alp+4WvW9JtjkGWsjy36+eXj6QIfrmhCaitg
	 yTdnIpk4fBeiMnWuspoR7VqC475S5pwwbBMAlc4VQ/TVJ5OO/F+W0LoSAu5uaoMu96Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dshnRw3E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=A9lKBxl2;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC32606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC32606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dshnRw3E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=A9lKBxl2
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A22951D00142
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 06:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793098023; x=1793184423; bh=PgDhBlybFx
	QE3f1hA4EGTSAjxLnBkbtju9oDWUkAhY8=; b=dshnRw3EhHWReXhV+u6mV3ZiQx
	RRQUxEa1lEuV8MauvYg7IxTtHMwWIPP8dkPqIMP9Mn06i6J2sFEiEruvP6GDKqCp
	jndERIjR2uncM9Nlogj0Zg2viAb7Ejm8t3pkEos62UmolGehfEhn1hhjBFLf+yY5
	bx5KeAz81dQXIVcXI/fhOygM+qdsHBDoU+It2ug+WkdNwYrzg2W/wEbhkePBs8l2
	ELLDhEF3EKkuPBvdfou3K2vU3ZW+zxjLE9y5R+m6CyqRQ52Lv/pT4snYL549fzcE
	dX6UOAQ7JAFptMkXfWto+zWr/pbWL0YJ3clNmZ4+yXE0lQ/dxr+CHECPR27Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793098023; x=1793184423; bh=PgDhBlybFxQE3f1hA4EGTSAjxLnB
	kbtju9oDWUkAhY8=; b=A9lKBxl2ip4fzXtqE7bW6EQFgWOUO6ImXbu84xyWfTPc
	7CSCjAeRQtfX9Y0VFyWQbsOXcLohyt5bpgQ+yQ4JYBECINb9uWGZPmncFkHlHlGH
	PRkjKmuFJUe5lzxonPS7gCQNJLqsQDpTCOCnGWXS7yJ81roCuHSW2X+wS+1stwGx
	r2z33nONfqYWu0QrKfeXCHtqRYIbnZMccQH6BsdDJDA9pLHeOv/8oLuP6BuxyiDS
	hPRYSvwGn54x1Zs+16LD03MCeCkFRamxTt5Wn3mONjnAfQPhsxhVy45lQ9rwb3m4
	zcl9yJuh8Xdkuaqoe6E2EfSJULFCivUaD8BF0UAXSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098023; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aZ9UIm1zYYL2U7ioDEs1mk4MgFWXqP1ss4h0XpJqw2mz6R5
	kxv2AxV5G3BLP0i4XVUiNn7QO2sP14v9uu9MdFW0sJNz/UyNYEfVOUa5LAGFdNdp
	jGWM1iI+HGu6kD24rhhkJBZwzbqj7oQmi8+Q/BAOeDBlHCM3WEajgcgCCSuV89bN
	Pku+OFRDc5VIQZ1B1OEgCsHex7NmIvUnc4jf81w/NW+3VNDjIDHBJ76b6MqJMuqx
	TGBn2l3sJESbmXNHBU9LX0Z/qWSN7qCk0XZ+TsIXaxjJzfQotfBmvHm2t5p+XveW
	V2syQHZix5V3ufVBJ1hdO7W+ZYD79t4nRfqM1fQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:kuVYZ2UfRIfxQ+qiWML0g99DKYNL2zkiVEJuyrBXPc4=:kIqqmV39+ggfE4l4m90Gf1FPp4phIIbymHKlbtT9qYQ=;
X-ME-Sender: <xms:J4HgaprQCeDFm8DCurlNpHPBa4cEd3KMJMonDA_migMhO7eOqIrwYw>
    <xme:J4HgailCMLZFcrxfu8-FrAZt0kOhWqMhaETIjvQBjQAJ5OjwWX2fQP-2npCvq7BKP
    6RCl90rsEftZrWB-J_AmnjmDfNPT008DDPxeLt8rQUl78i9_C3Qkgo_>
X-ME-Received: <xmr:J4Hgar1s6_Xqmt4-jK4GWbhbifl6AI2touL9tBzaImPaGoGPK2rZMA>
X-ME-Proxy-Cause: dmFkZTFGcNDQq3FryyGjokRfYCu6Zt4CE/NqW96Ry+fAL6wzxXt5tg/huH7eKYT38+vdLY
    xZ2guC9IWa4xi4DPVFHKsWf8lsM/El+HsmyQvP0Krpf/WFQEcVOx/cYJ/6F0JnlyVVK1Uh
    9EboGvu6SL9yKjVVM5K5OYyD/dIwqguEIATYLit3Epn61CnknJTkxRjbFv4VXGLZsd9MRC
    wplvZjBXhYnd00KoWJvTK3ha7TiUhoUEc1wu5bXLHO3+b9hnZcI6zRDa1dqi1TDNVImKIH
    IiaHC7eEsRWS2F04d6pzPwrcmB2hK38idVQ3sSycUxUMVbVyhq2VtP2h8owcTiaDVj2WWw
    WOWBjT/4rBk/Df/ZBQ9Un0wDJcAa8OcOmKw5MGOzy/fHjJowLqaDExPSJ/0JSaCc1C9Zu9
    8doP2ouuWYCsimpC6FgEzQQlw8JDSoFQ3VTkJeq0bSt8exgCvpcygxMd9am4yK6fmSrjLc
    f88594K5oLIwNRztyYeVlZiyfTmO5neSiClFY4X8ur82mf5WhyrWCPW4mRLLNiIBpEDZbX
    5tuWt17rS+rz69X90nr1mRezErJspPG9ZNYDpkSrKOLSvp8Sm730OEwYrcTrXe3F+9PNm1
    VDf3R7/5biDd/w7upWIVtApTOet0UUN6N1/1lONz9Zo5riKS0mbwBjz0OIbw
X-ME-Proxy: <xmx:J4HgaqCboMUvYko6LNg0SQ3byhu-hFNgv2MVX_FX1xYKghGXTfhGug>
    <xmx:J4Hgaoz42EnhpY59hRbqp3Q_PdncqjlCfhShKHBfvPqNXmiPPupeCQ>
    <xmx:J4HgaomIaqtzWn3g8xbjWWyo0x6jQjf9rdv63kvZoVv2R5pg3S-82w>
    <xmx:J4HgatFBUm6g4ya7obP9gbF_usybxy9u0ClqOT1wlbwCUYPoQB2_KQ>
    <xmx:J4HgahITc1XgXgWuXu8Zo0dZK8rpKtBrw8COSdvM40I_eRJIzjUiNMVE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 999b4fa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] builtin/rerere: convert to use subcommands
Date: Tue, 27 Oct 2026 11:46:43 +0100
Message-Id: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBBFf0Vm3QGT+MJfKS7SZNRRjJLRUhD/v
 bHlrg7cc04QikwCbXZCpDcLryGBemTgRhsGQvaJQee6UrmucZsFI91DOV5uXRYbvKBRjS9UWZr
 CNJDkLVLPn1/42f053Sdy+12D6/oCekRo8noAAAA=
X-Change-ID: 20261027-pks-rerere-subcommands-318d41553438
To: git@vger.kernel.org
Cc: 
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
 rerere.c                      |   7 +-
 rerere.h                      |  21 +--
 sequencer.c                   |   4 +-
 t/t4200-rerere.sh             |   5 -
 11 files changed, 275 insertions(+), 101 deletions(-)


---
base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
change-id: 20261027-pks-rerere-subcommands-318d41553438

