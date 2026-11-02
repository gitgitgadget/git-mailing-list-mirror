Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660235;
	b=sEv5G0HdiJYnVC73kLJfDDmsN6U1sheuGIyuafJtCosuwBY3ulCalZn7HoSFxi6uCDxd
	 t4Ut7gRel+NMhVhDyqVTcESi2Yow3232i2wl1XuSRaTZ0VDPAgvo3o8C8qOeob4ogQsyl
	 yuC06JZ/SBKPIVHR/z6A9HzkGOtyLo+Gm0pPTRhxWQwBXuar6h8i7dDa6FzL4FVHHgOGn
	 BztkKv+qICpB9U5yuHY+0huF9IF676ifj4fgBt2SoYBqh6RVH2uIWZmslQb83db5IP0Go
	 4HtTfhR/MzxbUSSybmE2JiNrNiMBoOkmBQP9QTPdqi3aPPbXh6ta1UWltBMYI9gRA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660235;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=b+cXz/Ib6nowKA8vKaWDaeRk/3atPjkRT37GVKpAm64=;
	b=2D3FGayO8yRKol6wqFxOUKHlYpTxSza2hz2dlCKmkq5jJCoQv2UW/3EHL1f2qm3zgSci
	 DFiPZAdLhHIrRFEVU9kCzZ1ZnKFqCWQcE74UQyb3OzsyrQLppOwGqd1uhRFP9ZKs5Hwtm
	 6Q5TPPYycv34TNz6jdbIxkAtTyNiYYWHZRpp87Ftd1kBXlzzphvmEpG2Cv7VVwe9X7TCZ
	 EpkPBVw2x72Lx+aofLPXr+TDgbwXdWWTiVA7pV+vif9xKoHUEqiSvARImRfKCRZOML/2F
	 RfhuVtsAC+dQz8eHRMFqG2Lfjt7ss1MCNZY+BlkQOsr1m1WRADinIwIerhMazaIeezA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=P6gCV1EQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KLymeKHM;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DD606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F34DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=P6gCV1EQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KLymeKHM
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CC107A0146
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:57:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 17:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793660234; x=1793746634; bh=b+cXz/Ib6n
	owKA8vKaWDaeRk/3atPjkRT37GVKpAm64=; b=P6gCV1EQjXZToCgHBS6CkvbVVE
	p5PeLbajykz3U0g1BiCbEa1LLSwebqSr0NTz/btH/ynNvJVqkm2vw2xM/Xg1sUxB
	Z9EJjiaTAXbEfE+n+BhsuR8D6ssyzKqybz2+C450ggxSEikLnwrbfZGLyGzCeBsB
	9oRvH+BF7ezwk1PniVw7tUaGPgoy99ScGqeAEvA74za6iDwbUFz3fm0ugEbKMWLe
	UHMKCpTekLh9u6iZONs7s5mQQFhI7+jqGilEMe001LtTk2R3mDq1UkOuyOI7wF6U
	YtjckR++/ex6SkqfV/9dnb6US6SwCkKEemkeRc6rtmaQbNFripSq0ojlrH/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793660234; x=1793746634; bh=b+cXz/Ib6nowKA8vKaWDaeRk/3atPjkRT37
	GVKpAm64=; b=KLymeKHMQCcy4roXcLSvpnE36agWhNOug6aYBV2t6B1RnfuDdol
	PHpI7p4NtnJkTFhQatrfcBAacuLL4fnVO07c1GmKdNbJ/6lEHsXBhgNriLikzdJs
	PBo/HGP0oG8g2LDDrPIDJVE+iEOFjpuFcfyY+KcisCMeyOboXlw9/EgenZF6tdcV
	V5r7iktNKaK0LeM6myBo1oW3S+W0h7AKryCRDEvA7PtNnH4xky9Fl/llAFGrAHWX
	JkAgnsPT4oSKuBtWvAyDSz9wcHNqj5zP+Lkq+uF4htvzH4ADqshTMSvkF6v3Kb6i
	GzJzjrKdFuqGhZZxA3Qh7jpDoLveEogZ+dQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793660234; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Yq9AwPqTb1thk0Po7VRPJ8KvcdzZ2/EJISUcquh91h+JXJQ
	FW2aE3Mt8gf5gw3Kex+yojouWCAqAwJ0NqHGg256selAReDHE+tlejrGlu55nqwA
	VayttQaqgu7BT2dGX5GlpBHpzP9EWEIF7H0lsfI17wKQK7fhEaq95ZZSSx5vKYzQ
	yw3YZsIwTK/QoEF6jo0HmQUZgqL+ifd2yuh2xggzIkwa/mJgjKW57DXtRjwr5exl
	oKEVV5bkvk/2HmnvSZJxs1sE/50vpe7EGhrH952s2vzyu6fMuJuvG6x4m6A7W/9r
	kUWMeCKCV5Ow0LrW9OyziLmSUV8UEqhtyiaFnlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J8RgaG8fbNT3P71tjAfyhxFBtZi1s6WrESJrmQrubbI=:6RrDsSU9xu3d+gJpk7omw4GOsgze93c4Azyy/SmRwCo=;
X-ME-Sender: <xms:SRXpasF6jo46IIIfkMkHqY_qqLi1TcJvt33Q-9v1Egjf1edNJi-bFg>
    <xme:SRXpapDrUDT24GaXmhjx8iPQIO5uJ_gDUaTUDcamG-LSruvElFb4JHzDjGotPqluZ
    t9rB92n4_l4UAMgHDazsGU2EbcZAYokG9zOX2CXGNgwEsRwTRwRZCg>
X-ME-Received: <xmr:SRXpav8Gm0tk62FXCs_2ufflJoU_HRXE6KrfAEp86iTCdFFQ3qxSzJdPt9tcK_427j0ZMUJCRBhtmhQALRhYoL_yaZiBENqk0UAG>
X-ME-Proxy-Cause: dmFkZTGIBGSsvM24KY7o+hhhoU8VEMgbBg8ExsGj/GkosUnl5inrgYa5rvP1FKY0GORCZW
    BKGJdLHw+WR1YVlqWPsYRVt3m2zxDWAaAfJbq+h4muXoWbFzKDuJMHy8moXuK0Po5icock
    k+jXuZjc4R9kcfTyGiB7eZbwQBqsDGOO9tn/k7gidmtCsFNxj8am2ctBwywR0bzasauCWl
    FXtBjrDG68cbk/klgYETJTEZdcLF+YRCuuIvTarbpPcZs5g02qHxPC/UqkBSZ9ryajDuDx
    rT136qGgssVdEaQS97W3zpnB29bco2HiSNr3o7djc7+tEvPNijVG5BDAfJ+FQw2hY49Qlc
    4WfacJ3aYOjpz5IMPKIISOZimbZdYsqRTfeopRWupL3TUMFSwEHxvvXJMpnDhHUmZO0zoz
    FZdDyMnCEYFk66Rhqk+yJfsc3kNteWhVPlzFteDNnCBTamJ7vF6eRs+S8oLvbi6pL5KwFN
    Pp9Im4rvMAHpJm4jtuQxGzxGu3lz5XaVUqu/UsJ52XNaulJs3Q9Ea3EGsTkrABMduJSN/o
    ekKwlvys0oQy8JGfApESjxArRaQ7dUT+ls1ll3gECEjcnINIJ8O76BgWB9v7pO8NrkL4PO
    6txp3HDgNMv9blaGNRa6UIz3S7/+qzd6hHW4k5kLofU5FqMlDcMVBYzNia1g
X-ME-Proxy: <xmx:SRXpalCETPLHiqAMIOItUEXSfJpkGmcXheqPAvFgD8pNiJ74RXnjww>
    <xmx:SRXpakQFqqnUz18YgL50XR9O7fYPiPfHzDRU6pY1VMr3hKJhQnlAeA>
    <xmx:SRXpast0_1-tfZNby9YvLWJOPMasdQq1DTM7SpOAbCjIo6UjEwoRFg>
    <xmx:SRXpag2T3yWRf-y0G34F2hX0lwmNfeB_ZZLxq9UnrgfJgT58aMwwMw>
    <xmx:ShXpapbZPxz3dxW7IORWTwVV0L0pqlItke-mgW1P31QvRE3i4tOqhx10>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 17:57:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Christian Couder <christian.couder@gmail.com>,
  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH] doc: document the current project governance
In-Reply-To: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com> (Antonin
	Delpeuch via GitGitGadget's message of "Mon, 02 Nov 2026 15:13:55
	+0000")
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 14:57:12 -0800
Message-ID: <xmqqmrrqg7uf.fsf@gitster.g>
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

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> += Governance of the Git project

> +This document describes the social structures in place in the Git project. It intends to be neither prescriptive, nor express a judgment on the merit of those existing ways of working.

Can you line-wrap these?  Even though once .adoc is rendered into
.html or whatever presentation format, how the source document had
its words in it would not be visible, but a single long line that
has an entire paragraph is very hard to work with when we are
discussing the document in its source form.

> +The Git project develops a free and open source distributed version
> +control system.  The scope of the project covers
> +https://git-scm.com/install/source[the git.git repository],
> +associated repositories hosted under the https://github.com/git[git
> +GitHub organization] and the <git@vger.kernel.org> mailing list.
> +Other spaces are considered external to the Git project for the
> +purposes of this document.

Do we want to also cover Discord and IRC chat channels?
(cf. https://git-scm.com/community)

> +[NOTE]
> +====
> +Not knowing exactly what is considered part of the Git project or a third-party project, I have left the following repositories and initiatives out of the scope of this document for now, but I am not sure about this choice:
> +
> +* https://github.com/git-for-windows/git[Git for Windows]

What do they call themselves?  A friendly fork?  https://gitforwindows.org/
might be a more official entry into their universe.  I dunno.

> +=== Project Leadership Committee
> +
> +The Project Leadership Committee (PLC) liaises between the project
> +and the Software Freedom Conservancy, Git's fiscal sponsor.

We are a "member project" of SFC, which acts as our "fiscal sponsor"
for us, providing non-profit administrative, financial and legal
infrastructure.

> +Those members are renewed by cooptation, after consultation with the
> +community. When doing so, the over-representation of an employer in
> +the PLC is
> +avoided.footnote:[https://lore.kernel.org/git/20180821020849.GA2527@sigill.intra.peff.net/[Re:
> +Git Project Leadership Committee], Jeff King, 20 Aug 2018]
> +
> +NOTE: Is there any existing process for leaving the PLC? (for
> +instance, if someone has become inactive in the project or is in
> +conflict with the rest of the project's leadership)

Nothing that I know of.

> +=== Security team
> +
> +The security team triages vulnerability reports sent to the project.
> +They do so on the private mailing list <git-security@googlegroups.com>.
> +This team also includes people operating widely used git hosting sites and packagers.footnote:[https://lore.kernel.org/git/xmqqbj9d3y9x.fsf@gitster.g/[A note from the maintainer], Junio C Hamano, 1 Oct 2026]
> +

> +Is the list of subscribers to git-security public?

NTK as far as I know.

> +How does one gain and lose access to this list?

By asking for an invitation.

> +Does Johannnes Schindelin play a particular role in the security
> +team?
> +https://lore.kernel.org/git/5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de/[He
> +seems to have the lead in triaging vulnerability reports], but I
> +can't really tell to what extent

Why don't you ask him yourself by CC'ing this patch ;-)

> +=== Localization maintainer
> +
> +Jiang Xin coordinates the localization of Git by maintaining https://github.com/git-l10n/git-po[git-po].
> +
> +NOTE: How would their successor be appointed?

Not limited to this, but there is in general no "appointing"
process.  If there becomes an open seat that needs to be filled,
it will stay vacant until somebody volunteers.
