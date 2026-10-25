Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902365;
	b=MGWIEx7N5f3+IKjS4B+1WDSMid8I/SjplqfIr23B8wUCq8ijmt4kP2dsW0t7Xivy13I0
	 XBhVoFC2YlcGOxTmZWHeinzzG1SxxyI9J1uVgFbEVxxsxNpTKijcjqTqE9Dkie6ApYny8
	 Gmggvc+IGcnzlRvMljWiKx6v4Sfcrb21WDc9rj0CB2buqs/SKXYvUW+RSOfKsj0mzAmuk
	 P3MThpF0B6uVkVusLcJAqgccM01lo+iuU3Hw4mKlNDr4sZEIaRIwUPx0gQ++0L0BySQdU
	 IbISfMdykjleec/Toz8UkUBrCmJ7V0/3hmXHUR51Cig5bxDsLXbklsJKZ6pFTCI3TDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902365;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eCKcQB4GJmKJp2oYSSRA0mUM+0m9EaBw3xg5jrm3ITA=;
	b=OQECzkmcCD/3Fixj6Je+YJZluZF/uSP/i55XSq13cAmuKt5RIEsRWVAYM8UP2KKnU8nP
	 fIHCMwpamK1naCIATp1jnWLMBpxqKocFeCBpbEXYbTaNO2ETr8Hiu7DFkGmSf7tECKrKG
	 4tp0BluapwSMlQoChclxglQhEA7r30Z+hdRkzEI57jJGIOHu29nnEBwA+ws9uIctlBbZg
	 ETRJkAB17pVZIW0CCMxB/4uCvDqbqk3K9d/IL12EDQ6DvCLSJpjjI9NDdky/lU+FDGMEe
	 ugIcwyQpFmg/IG/XvtrglbliCAXy/3VVTiY0qLGtxn61boFfVrr2sQhoGNrjUBhSDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=awkPW5P4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SVRC2EF7;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D4606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 04:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 138D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=awkPW5P4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SVRC2EF7
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C7B51D0006C
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 00:26:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 25 Oct 2026 00:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792902363; x=1792988763; bh=eCKcQB4GJm
	KJp2oYSSRA0mUM+0m9EaBw3xg5jrm3ITA=; b=awkPW5P4jl8TiswAoDS+8E1Cue
	5JAN+TTAXtchFJyKmL4Rksm2u58uxWIej4HtTqcD41jwJL/cibh2gDcgpxwSVL2F
	lX1CkxU41A4DxNvKb5zAK8Tzx2nKSi410e8gUtY2puNE1q0yrXjMSogaCUYu/Yb8
	iI1yUTIPSb0omqt7iciHU0XdZhGEs/Vb5boH5NC4EzNE/agvUgLuujVa4qiX8RjD
	wVLdbaUO7D1kAT0GPy4sIjocY57gCKjPugtCBd1383mkpOqYQTvGEnHOqn+42EqX
	xvKTJ/6xH5zJJ76a2pDbgqGaMXsOHs6pAki6+5Aym3rkFgkW8kHdWT+YkVZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792902363; x=1792988763; bh=eCKcQB4GJmKJp2oYSSRA0mUM+0m9EaBw3xg
	5jrm3ITA=; b=SVRC2EF7iIx+TALWTH5YXtYFV1fihttLCeZ0aU4SgVhO6Ry9C3j
	JLkkGpb/wqaRCQKeSbL7hDUa2iBRNY+GQZM0hZF5P5hiHF+ZNjwkdvg/7l14aUZt
	MoeIGl1yh7sgu0SGQ+MGH5ia7bE0HjPGU9avQv+5kyzX54FWJUMBmvGC9cO5YCf+
	jKfErrk0v+U1AEcykDYTvuDhgycy8HsUoCruDrdy3p0NSXqIt1cRgY+7NXq1Oonm
	/APe7VMYhYZ+/BaFDlN1Oekp2vtBPI2YgTZ2I77QglrkF+xWDCwhgMSS3J5lMoig
	YZwdQgQLqSMhH6WfsQZs1UGGEeQVFB+D+SA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792902363; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MO/0G4qfQXiTVLXpthxyhKA6p173DkqkdL476LSjdFUCi7d
	e1q5S4jO76FlyDsvruZTRkMOF9Cp6E7Cn7Xp8ziLHqHtWm/6cvpXwZO+a8P5CMtU
	/mASaB+G3jLQoR1mGJaA4MIjhRUaRN8BCzvkhTltcNYS2jyRqc8/au+A8tbCv44R
	8LseL0qS0+O+iR4eOpJyTC41qAqW53aTEnMGaAjiZ3aiezhPjKMm0AC2pb7f8h4Y
	l51AnHXTGp2I2bpcH0AYThSDLWpO1TtSMxZjjxX+cNhAT/0wtdtD/XzAjiB3rVlW
	SP4DB3uL9fuE320XmVna49EAQI/PPCVkB1d00Hg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3uBo5WwbcvOy+8by0avQx6SJzFxJLRjgZ2NUU1Q9GnE=:eCKcQB4GJmKJp2oYSSRA0mUM+0m9EaBw3xg5jrm3ITA=;
X-ME-Sender: <xms:2oTdanouAuPPcQMWXq0Y9acNr69ZwsZa61o_tr5YU_VhoHbMWlQBKg>
    <xme:2oTdapFd-fNoLnvfZi6EUnrXw7yEqDcHNLBwrGsA82vGTjZAgXc__sGZ5bB1R4ijx
    r2w3f4rlNa0n-5L8Ak2RbBmowEvviNMV2okz_4oO9IxBTD8mZ7osTQ>
X-ME-Received: <xmr:2oTdahklZx_cjSGUGPaZBQegE7aKQ3um82ROuza3jAzsfite-XUQixitAVWjbTg-3xqJJp6RyvhEkm7ISWrqyfcqmOHDB_4aNe11>
X-ME-Proxy-Cause: dmFkZTEhQSTkw1YZPhjeOKf+tLhYr0cb87P9eJ1ALqHZvVXLgtp+Lxr5TJUwro9RgHrwQ7
    hMQm3Qp6UmALDq9ukSof/KneQ544SATxe1tM1Wm6jDNyvzW4grtInMUowrDPk6Bhse2KyY
    zkKNGVYlMvy6PHqVG43lu+POZ/IrgIT6i9aRRNRLo89gKxvF1v4uKHbHqcqmJnPdHufa7c
    2Iq0GpuiM3TWbAPo+TWgqt8a+Exj4+XM/yQx/2x+ORaUwFmxdCT5ytn2FXbGrZfI28jGvh
    atVzhvpcfgdx4HIn9fhY+PbGZf6cfPf2XB2CfRdhsMuk+buMk9zP0dfcJ0qVe8BllhRlaX
    atP0fpDgfKoEaybW/xRS++IdLTsVZTy/z8UtlR6UjdJ6z/YVgR/YrqzWxIr80SWr0FhJtk
    KEBJ81cuyf/8n0XoYkDvEpLqFNxn5qrQACWlfKEwSUl3Sb+mZHL1y9glAY+U1Irq4cHaSA
    G0oPx2O96KqK4facsfhdZIAa9xcH5Mb+sfqyPJ9gOuXVMKPQsqQeU7YB8EuzuOsfMB2cGQ
    +lskTGXtdx+rE/1JrL9PPq42Sb9Hn7gkbKcq8o7XBlrmHpn8VP3N5JazIxkaxw7whyINNl
    2nXUBgRVYd38GM+3gH/pG4LvpGNTLKc/H/LMaZ+SsRrDwAzuhRlWU9nWfYNA
X-ME-Proxy: <xmx:2oTdaknFFdR6BLelidGDzF8VwzFhCAydXFxejnwtm-FDu6Pvgh6R6A>
    <xmx:2oTdaqsRMnQCCO5Dx8s48DgillAoxIFRZRgVo-1S-SsJLHQ9Sm9ZWA>
    <xmx:2oTdavmoZhMwqH_-6EgiO0SHV_w2oRXFEHWOHG6zRAb3gAaxQRt4yQ>
    <xmx:2oTdatux5J-Lr6-SJBRUj-A9zitlPpCmdYcaNhYyTeEHwabPvfjfhA>
    <xmx:24Tdaijc_1oK0tFtiy5nTxzE3HgfhdbhfjNmNjXVdGksXQkNwJQjL3OJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 00:26:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] object-name: use Q_() for the reflog entry count
In-Reply-To: <20261024152931.440-1-aniketgupta3001@gmail.com> (Aniket Gupta's
	message of "Sat, 24 Oct 2026 15:29:31 +0000")
References: <20261024152931.440-1-aniketgupta3001@gmail.com>
Date: Sat, 24 Oct 2026 21:26:01 -0700
Message-ID: <xmqqa4o2z9ra.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> When reflog is asked for an entry that it doesnt have, for eg with
> "HEAD@{5}" get_oid_basic() reports how many entries the log has. The
> message is not marked for plural forms and a log with one entry says
> that "only has 1 entries"
>
> Use Q_() so that the singular is used for one entry so that
> translations for languages with other plural forms also can have the
> right form for each count.
>
> Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
> ---
> Changes since v1: t1506 was also looking for "entries" and thus
> failed with a one-entry reflog. Now it matches "entr" just like Junio
> suggested
>
> v1: https://lore.kernel.org/git/20261023133118.456-1-aniketgupta3001@gmail.com/

Your v2 must be a reply to your v1 message.
