Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130520;
	b=r/cnsGBIlquwcc1+fSmeENKHn0MKUM87/eN6jOtELnGfPGkYUnG34t9UXvxwDezc6mpj
	 ei08CAlpsjYHIRoJvZSerV31jXJCjtgyZ3dTziHjj6/jRsgCttPoevU3FZ5C6ehw+YX4r
	 Bjvvqmje6Kstm9mn5dYe46coszkIuj+VHPO6Dgf9GPhpqHyafVeNrS2Uai1yEBaqaYKlS
	 wqi4stqvW977yvoXRk/TbGa/pyXYbfHOKFTnU2JFCoebbXXkSFOF0uZZuwddLo3IoDaO3
	 VkzBV4frGu68QOb+C3ovwMakryr3WLTRsTxT7GYKOYNIZNw+FRQJseK9u9wVD/vacjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=p5kH/GpwInfVAGeuNNHDiNOQyYCaFzHJRBP/fgKX4aw=;
	b=BV0ZlQRY4bXf7YqzoQLscpMMj14OzK/rwjIJ9LXkPI3rd+AkyeQtVLrm96BNBp73JYnt
	 0yOInkQSEJVWGyLpm98xcjf2pdqZ2WTHXrJpdlgtFzoSABRkrZyGqoPu95Oy2slVmFcNm
	 tEv0IvUFICfKh87s1czIa6Q+25ZKCh0fbJTvEBXdDUGy5HsPL2xK303ZIPmAml2EDjlS9
	 34q0tI31eNRoAXqzkUn7abiDeEVJ6FH3Aww/dnYEQiDOebHOY3LsEKjUdYooPYJguVnYj
	 ooEZPa3qUJIDsc5IPKy9JfVqmokd5vsRUzQFrrohk06KVMORtoPdubJ2QD7qrxavStQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mE0xQYtA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="yUmG/PVB";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB8606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90AB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mE0xQYtA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yUmG/PVB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 003247A012F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:48:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793130518; x=1793216918; bh=p5kH/GpwIn
	fVAGeuNNHDiNOQyYCaFzHJRBP/fgKX4aw=; b=mE0xQYtAlXNF1WYYn6xTyJrYbb
	FE6cRV8SmM2oDyNTa9plGr3sN0W0rOclE+7bhy4itT0/zx5tKPompeMYe62akd50
	KI5JeptLgXXzS1Zkhpdzk+RYKCRVzJF4SqbBhV4VMKgVWdmu9YwS6hIyd4cNV055
	D5ms7+EmrilLRwTGUVPn9Paz0rcQSOf4CB5tSwxz2TlXAa26akck+YyMnOCGGx7/
	WPeHirMQu2aufH4nuCGOOQ/NE+8irLTyWcDkHIbekysZW+WLJCuLoVpxLyCElPzj
	tp7blEI/epDxjBWaAwamnt5aNxGpDR5DfcPsnqajSQKpn+Vr7VhI8ODzIvQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793130518; x=1793216918; bh=p5kH/GpwInfVAGeuNNHDiNOQyYCaFzHJRBP
	/fgKX4aw=; b=yUmG/PVBadXfe3JDMdVNNdyZq7EhXAw3aEmlg5ZyF78QaaVuZGp
	48MvPq8fHGmbOLJ4G9VXGmvvxV2qawi/B6foU9YxfjPH8tAhXLIlprzR8OOZwBp4
	aM4bCuTY8Aop/HjW1eZVHwhdE7MDTv6RBx/4OGzqNgmNArtt807l6ckPSH5qsEiH
	1qZprKeIc+NqS2Lvi+7qee/KbQEEg5EjFb3mB9ZkUB0A7gVgUaebxKNyqQPJ6dkS
	00lhXDk7OjOtU042FX8HYBwS2pPr4QHUOUouPhqHJ53/wVzTEYJYn8x1V5vZW1s6
	3ygYU0TMs6/P/QH8gRELWjBlAVETyn/laHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793130518; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:f3ucescYZg6iqa7pgdzbYVeVRQkTCSnqGrDGhV9fLCR9q18
	kzc7khh0xvPgiYGgg+pxCHO8QOZC4ErBh1sVLFXkR+TmO3JdgiKXEX/ybGj9mDtS
	x2XCYAdKdIDDbGvgoyQBhdERq4vju3kyFWMsIg+CAr3Yoj64WRJ4iLMCsS29f6ty
	kOvIq9cyCoQUUoIreAbV7BYDdmOsFz6EHo+dOErDXa4tFP+SGVNuHSQySTA9goKQ
	Zf0DqSyoI0uu4Lb/utjrDbaEdVSJlVDDqq11Xok72ceAdf7KILcqk24RHnGEHl0w
	P0KiRXcmNQpjZuE3a74XOGXpPWwBZuUGoZ6bXEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xH4FNx1Jkx7PLs9sG7oPhXHM6V9eeD+OH0R1H0Rqsr0=:alyvvASooQPVZusF45UKSQ0ZhgyvL+jwLWZqEp/CCks=;
X-ME-Sender: <xms:FgDhai1Ye73B5QbEEDwPytXa-sYy2oDyQH0llGu6NcQUbQ8knUuh_w>
    <xme:FgDhasjwCoAg-zzfjgHt4gi-nyTGXtS9VR3rdb-NlIkTBhavzebZ3Eo2tq5R_Blg_
    AEn1eHW8ZVoRkZqQRoepUc0MQ_4-W5vmRzmu373yRqKzX5gkEjm5cg>
X-ME-Received: <xmr:FgDhaoQ92vW-Kjrz1rn5k1mazWaOtHS8SYXAVKivBW7-NG5YCpCAe0_mTE6_xJBmnl4LPSpEN2oc0qWDTfVxdCLx7bZ3keP1YrfL>
X-ME-Proxy-Cause: dmFkZTFBRrtVz9XnAAzVZYeGDfld540KlszgRAnwkmHfftBrC1GTJiou2z88i4+SdbJCcf
    WUFSP0T+z10RrkSJlopftaELlDMNv2Flk7SMHwasWPzDwOkVfGHQq5OkWlbefYsQ/vWm1F
    vpdU7EcX7oCUf0cVzYnoVaXRi/GB4k2ifZqZ/N0Vt1/tTXRSRDJl6AYA14vcBPDuwBrt9b
    14w1yqcZruLu/EBoXO627PdPygElDv5+uSXad/3mWptI2hX5xpOFoyJCnuUM7gjegBzbDc
    FUusRBUy8kgpeYdo9l77evqFarA9WacTZp4DbVRtMEYyeZZYprwe8IwOX4yNnVPGDsjNO2
    JPu8xynrG72WCEZQY7YQ3wkWjw1aN7xmHZK/Ct0x+CFN70XgAVUD1BpoT1b3ZbMlD9UIPr
    o/J0SABKyGbkEr7TzQtE+qcIqvUc/wI4p5vGIaPT2yvQPj2DF4Vf2mSO5Pp36YofiA1wZV
    HHTsaEy4crV7xSGQ8SCQCmVVAGvav5JWwFnykfoxW5KdIawT2OgTPQjTy1RlTfJW7++rFL
    WgtN2OhDDwq78jZ4azSEg0MFkAwBQfCo1+ufRq/bCT/H8cncUqqbbukQvQC69+67iaY9fT
    eMS8jUBbsJL5wEV03TFUABWWORfydV+075fxhZw0XaKapqNPid1Uz/XQ0Rqg
X-ME-Proxy: <xmx:FgDhathMq9dgAHGFJJzTcoC6kkOzqJ6cV7QWOPImA40ZegnlEJ8Egw>
    <xmx:FgDhao5De0z6dMh2V2U_55AdOG9KBccpjbcQ_xR4LfZhYWWdwT_jUw>
    <xmx:FgDhaqDYpsQcDM-pvIO89V6RIB-gn-X0MZPnwDR6PfQQyy7vJuaAmQ>
    <xmx:FgDhavYF_YJvTpaDhZkDdA4-w8IpZhi6ZCDzZQfUTY2a5XvTuZtwdw>
    <xmx:FgDhaspitr16qBJ7ilPf6AtX9c_WkJb5e1ViZ9chFh4Dc3lwm6-TiHjQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:48:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] rerere: rename `repo_rerere()`
In-Reply-To: <20261027-pks-rerere-subcommands-v1-1-d836c36ce0c5@pks.im>
	(Patrick Steinhardt's message of "Tue, 27 Oct 2026 11:46:44 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261027-pks-rerere-subcommands-v1-1-d836c36ce0c5@pks.im>
Date: Tue, 27 Oct 2026 12:48:36 -0700
Message-ID: <xmqqv76mj563.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `repo_rerere()` function is the only function in "rerere.h" that
> does not have a `rerere_` prefix. And while it does indeed receive a
> repository as first parameter, that's not a good-enough reason to give
> it a `repo_` prefix.
>
> Rename the function to `rerere_record()` to be consistent with all the
> other functions.

I do not think the convention to give "repo_" prefix to variants of
functions that worked only on the_repository should stay with us
forever, and losing repo prefix from this function would be an
excellent first move towards that future.

I howevr take isseus with the verb "record" in its new name.  What
the function does is not just record.  It autonomously finds out
what situation it is in and does the logical next thing, which
varies.  It resolves when a recorded resolution exist.  it records
when seeing a particular conflict for the first time.  There was no
single good verb to express that.  Perhaps "to rerere" or "to
perform rerere" can be invented as a verb to describe such an
intelligent operation?


