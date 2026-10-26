Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035993;
	b=Ql7QvWMkk2QKPBJYm0kmwYrmM+WOOpQibeGHJJ6mt33jJqiHYhALQy3IQBNtYeT90F4C
	 Jt5r8ccUExdJu7FpKBx1i0JQU/DXk8IzJTzum7ScTlwvvov+mzMlKwxZLAJj0BuoKKqFc
	 9BolQ0B++cYo2PDB4BnftKM5njsHp05gknI9n/oGMAQKE4QJDy+KaTZf9sG6gz7Srzc0D
	 gD+wJc28+8zJgUGutjASCec0/L4WMiXXVxBb14MsqkqfYty7rj76qxmx7NjZp+7Fdmx6+
	 tA/PjMfvzWOeT2dxezosezlURXEVuYNmzxkZ6XBAONIiUDCIPHkOL/czk5x72jkQy0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035993;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Kpc4YNn4Ff+xtcic8xm6J6ClflIp7WG993KYg8e8Ej8=;
	b=lVm42XiPN+7ZAZl+HSfxQ5CZvI0me8zW+XoLOtv+Zod0Q+bpZtmf1YuNLAoPS1awG4I3
	 q5Fqfm0Gmgfnu9VfVp4JJC9bCzVNK+tIPsHKLDkPMRLGLSGTwl/0MmpmrR6soPpfegEje
	 DjVYPabhbhrsZ12+0t1fWjXQbIfpjrXBiPswD/o1EdNyNAc4rz3bXYZUBIMVX999Dehfq
	 TBViHsdloed66TWjUcPvXi8si5r962MVWfYJ2bcRAaokIsaKMG90wJZp1W45Fb1VoCZNE
	 UETAUNtc0ZIh7ft79ZwEccZq41ddyQ3GTU7HwL/zeUozsLZEMk2wWup3wY03qTjqBDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KKxPP8B8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xHD142K1;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D9606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KKxPP8B8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xHD142K1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C87B67A03F4
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:33:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 13:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793035992; x=1793122392; bh=Kpc4YNn4Ff
	+xtcic8xm6J6ClflIp7WG993KYg8e8Ej8=; b=KKxPP8B8ATasA7RelaIncnYmEs
	TU/TzX/RqmEasFst+jAMYcNBePKhG/L4LsMV74F8E45xU5iLVkumcJgGbG9xaMp8
	T3hPZ+PqfsJfuFkNN4qqb3hhzqks+SWWC0oPFpZeUwF+O3bQW6FNnjvGivJCRI1a
	iDvcuCyq4wfKGe0KTBXjpO1GR98pl3kf0Bg8fDhvCinM83AxrneJHiKWhA1a5dN/
	V8m5dXbbG4F3dk7TTonvG6XeIS4mf8xlNPuM81mJZsxqfu932cduZGWrXEvvPGLl
	AMYlZfWOcQiS229lkq9aKmleMe+05iwvLlK57UcuPj44WWGqk0QViiwzqr9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793035992; x=1793122392; bh=Kpc4YNn4Ff+xtcic8xm6J6ClflIp7WG993K
	Yg8e8Ej8=; b=xHD142K10/ayH6jemKfMl2cbkJRcOZZohjkKpCzUh+PqMsuRo8K
	G9zAUlA2nveGm7ZeNw/WOxJfB20jLO+0YfyNTlFqpZTqMZYY11LeR4Xx1pyZcWUH
	MgDzQqEc5MqTRbJCZToA5GixXOfIFUdJLg2afYJoDUiCXhDnbH0r9rk6/XtxGG2D
	ocylrWzD3vWCG9B4NQzU3wzpw0IVFvA9UvFL2NqbwzPQf4P42F31rYWsrZzay+jb
	PekEDMcZ902PWIqkhmWD+/xa/l1mHmPKIQ62NxX2P2Cj8/q9nQ883abx1de9SUK9
	3KaKddw+tBqH2zjn7Sh98BqhfupHH/bpYdg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793035992; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eGodlu0ubzmflYuzN0FzS5WWpsASGxKnlpeRhs5uDoeg2Y4
	qWgZq9H/ZrusvII5vnafAJhH8jZnzGGRXLVJhmoGo1nw3fLXrCil1ztBdOJIyNk9
	+0kO9BLaS54gl1RyDLF36RIAmubtRCKYK59gugMJe8lrYN5DMjA/7GgbTfEonpNd
	c4fqA9040yqse3s943g59a8vG0ofbSPk5XFBgE7sBl+und1DGgtDifvJmigrPOVx
	ZLCorvfgRgkjioS+W8Dp21Ys7LBKlWXGdF//BoC+J7PLP9PO29l4r4YNuillUmhj
	Xlq0FKIPIUshtlq6Olb873o3Bh/pe5BbHZmMNCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:K1+jlzLrQv/6fIRhWujwLtyL2450l0z+NSTVhAOJNuA=:xIaDxu1amLZHFqgzZImYvUrxkTvUK9u5HTUk901nT3s=;
X-ME-Sender: <xms:147fatcczDLqPU2UhIU78LcFPK7psAT4ev-Fh406exVNM0uGCAKS_g>
    <xme:147fau6ydgLd-oCyzDek-YmeEEnNkjSLIZJ03Ob0OBWeEDzR5RoWRVwaOr57fJVyd
    NxCYP2yCWcCUcf328YINBOO17TfVV2tfQFASs_ATja7zd85JKwwKe8F>
X-ME-Received: <xmr:147fagVed1HDHdJGQvbOiqahAuzu2NiTlbocXpyyHWjM5phfBY8ewISVR52Pr6SQwtBHi3-wefQ-SWLAdW3_zeOSPThQSh8rzrCS>
X-ME-Proxy-Cause: dmFkZTERsFFzt76N2NiFTaCoLTfRH35QhwCLSNs8UuAcM2ZMMTofjIAMN/u/Y9ct09JZMK
    MEQswObRqJFzM8TdzXikY+Nj1gYT1YjH/2VaMPYaDKNgRwQlvcSQnrPomIZf4JwkPZa2eU
    AVrJtmoirLshTsXUeo75A9hHF7dCJSDw/qci3Emkh1Qy+jPc5SCf3JeNm8xN88JwrrTf01
    kPtGFSw1smThRtSXTEaTCR/GC+RtmhplCK2kKnpbWYPeYDvV431cEj08/mdcy2QEvkzMnT
    YraZy+Vj6hniAEjdOiE/HHSPzOmJfLOFvO14BD61zi64wSkFiWfVsaG48i0qhcg26rdFN4
    jBDYsq5MZL1CMyPgxVUp3+3WP+k8OB8EURRQ156Z8C2P5Jg6lq6aqLWrmszyYvthIU209I
    FU0WAWfTVI983xG6vR2ZAGDIcWdWXEDwgMABlgdNyx59IAZI4NZnOyvBA+IB/Pj7TywbH2
    j9kgURewMZsT4kzcpd2J25pFjFxP+QbEzEjlT1uQoSHyPyBZqQkCBxBOQfHYtjxsJ2bxmh
    FAUKkH50FK5Gp+BI3++y6wj7fUn7WUygfxBAw5TUXnQH0cXFFkKzCPHhkS6cDq7zbeqi/h
    BcbLz67DI5OWrk7TvOruz6q1wa0mPM3aE+MeczXIOkt064dwzqF8pFc+I+mw
X-ME-Proxy: <xmx:147fat711NRS62kvmOD0Dt6nr_eurqUfGxyR2GwGT6WAmMyrDV97KA>
    <xmx:147farryr4ajZoQ7hzsylq4qylQolfAIB90Ne4RvF3Ix4PCNWewQ7w>
    <xmx:147fagmUpQt486Ys16lpS5HN6yCVIPkz5_vhN5dXjxJa7Wk7VaP7vA>
    <xmx:147fanOU1AzlWzkLVBI3l2lyxqrqyOaLeaRj61FHvbz1JzJ4ntdQ6Q>
    <xmx:2I7famCD5KCaKp2BE5xHOwuDlc1Qy38-oUk1Th2dgoKgTDrjBV53Lvxm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:33:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kerylefondji7@gmail.com
Cc: phillip.wood123@gmail.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH v6 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
In-Reply-To: <20261026172456.561-1-kerylefondji7@gmail.com>
	(kerylefondji7@gmail.com's message of "Mon, 26 Oct 2026 18:24:56
	+0100")
References: <xmqq1p9hhbue.fsf@gitster.g>
	<20261026172456.561-1-kerylefondji7@gmail.com>
Date: Mon, 26 Oct 2026 10:33:10 -0700
Message-ID: <xmqqtsm8qsdl.fsf@gitster.g>
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

kerylefondji7@gmail.com writes:

> Hi everyone,
>
> Just a gentle follow-up on this v6 patch. I have rebased the commit directly on top of master as suggested by Phillip, ensuring a clean single-commit structure and proper indentation.
>
> Please let me know if this version looks good to you or if any further adjustments are needed.
>
> Thank you for your time and guidance!
>
> Best regards,
> Keryle

It is not so friendly to send a reply to v4's review when the one
you want people to take a look at is v6, though.

According to Documentation/SubmittingPatches

  https://lore.kernel.org/git/20261023213813.3318-2-kerylefondji7@gmail.com/

is not ready.  No commit log message to explain and justify the
changes, and it is not signed-off.  The shape of the submission
looked nicer in v5 iteration in this regard.
