Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665461;
	b=BPoT+++3vHILcvPoV4jipJ0yPGu/sUlhlXtq9EwEixMbqq0RMleP+4Hhn629LxSe95af
	 c2T1Sw0rU+0YkQ1C2w9sFl1XAz9i3aF5yYbfNbbpCW+Eh8ePMJoRtsTyo666U+U8115NC
	 kTicS5dvAhC2hN95o4A8tkmma+4yLMex+W8KXi09/lr2TGTsZJP77LSiCI1LstSRV+YOO
	 A4CzLPVKARI5io18sASsnINfc/vpoFo807AyoyCS5xfpC0va2UQt5148auWKesepdShLh
	 e/db3O4/iSYLou74u2mRGPEwzoX01Rc595SbaKpAcXR+wnC5VbfWoLTyOpC5BU8sWpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=71JjEhbwaTNqxIco7zwDbIKtj+sF06i9pCIddAMXRTA=;
	b=TVz4jVHSp8Fcs3vXMJj1dZ/6eqjAzCVD0/xquMhjr6ZG2u853QBvDquNKC9QXTTUWTT/
	 OhxYQvkYh171KWkTEAp9TZVrljOowMdq2wMNGjMCEiNZN4Hpec10Sbkv4QpdWF1c9DpY/
	 MnYnOcUZv5ImtuTaAQcSEf5lnca1x8QgDOHsOU/e9Y+RQn5h7VCHjtHJWQU03osrLI6vP
	 Ahp6BEb//CkCQfyF/f4YuaBY66m6IAH0kMhCilThYGVslERF64pT2PpBtuMhBor8f0663
	 XhtTlWJxqAepDpCguewviXb3dyBp2XkvnALMLC/Y7GhmU1FOMGtpyb4QMDJg8HZTRIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cKGp8hAd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JBc5670k;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84F606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF84F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cKGp8hAd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JBc5670k
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D3E27A058B
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:57:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 22:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795665459; x=1795751859; bh=71JjEhbwaT
	NqxIco7zwDbIKtj+sF06i9pCIddAMXRTA=; b=cKGp8hAdERqdac5F3e/zNBTJIm
	W6Rltf/dBvpCtkT+jiDMY9+X58dIduCmv12RZD1sk/sMsapUrKrzNhtQyD/ADi49
	BTJZlb2Ltteg2vLNQNVxQdETNMPmI9MKWkqvRzzdxkdSWb4GSc06+cMYXQLM0ewc
	jtKFZqWBU4kEd7/IbezUw5+sTm7cA1+krIBM89QRWFjRnXD+XRX7WYb4Sj28DskF
	5VuSdVcjWPAGb7JzPWdG6BhsB4t3VyZ3mOXbulc/DF2GmALDdMt+WAOQ2EJXYRsk
	BAUQSZB2ltH3xzxW62kbmudpUSRSRSbq/L/emFNo//PE2JRAMqlOvkwxsXVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795665459; x=1795751859; bh=71JjEhbwaTNqxIco7zwDbIKtj+sF06i9pCI
	ddAMXRTA=; b=JBc5670k2IWjulpAnzsQv2yk8DHJjXRZnmlpr6qZkpJlJGzIuz7
	rPMZkxnhDZz/jy/f1UuFexaNkdydVQb5Sx/rMSE6Yw2XDtQ+9Ro+pC0nQf6NslP5
	F5WckUYLg66yNHvZaLhS8uLXsRbpbIXa+9+FZye9iUbiXSXHKGOFlZhHjECM8M4F
	ahD2kjakN0rHXiIAuKOa3izzMpbiwrrk7MCv5gRFyCelxiaoeiN6NfbvfpwZ/YnS
	FjcPPBYJolSAN3kaaTE7Shh9KyHnoEPcnO+eDhcDJ+uHzvV4nyZtGTtlN7/InJAm
	oCXGlSeQv6eicQnlD7oHl5xkhHIhwaC27fg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795665459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:edfzeLpDera1wiNeKpniOuC/TeKIuBi6U7VYQbET4uj3fJg
	vzMevaLoRONPckawwyFvmVz/a0NeeQcn68hgLAl51ruW2xKZAvw6/yTL35TgFNPX
	QVHjwIdv/cZD1sQL1Rvp0OgLkW560MhaIcWBqKOfnJbB3guq/SKfdtb7EQpUosmP
	AwY1dm4P1CDPrDCqpIVF7MTbR/Wikk/TJTzzHi8pa61AvU4MIQVVx5E/dkuqYnUB
	7IP4SCsZUpuP3TN7q2O3w6gmEPZpfc6ROm8k5fljQLCxeN44tlemVosFVKT/ZA0m
	/m+VAMwfsuhgs6F5PuQTVK42HU1CtNAYoM2KfLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mUHlDG2ofSXn4B+JAva21K8vgjh395E0zbimQH4IDA0=:SeZhf5AfUjwwjbAYwPOF41uB0ET/jDDl2gt+sHneYPA=;
X-ME-Sender: <xms:M64Ha5YKQ-UsGxs4PzqKVbcKYPbhUHzpf9cNDE7D3KCDEFeewn2eMg>
    <xme:M64Ha_dAvz2fL4JHCv0Wt95StSpdsNTyULNGZzS4xZovb5vYBRqplPb3ut3f4_k_L
    fxnREYhW6vp2Q8FcEnhV5lRDcPPKuttxpDgf_iHMmmgSoOn2pjA_3g>
X-ME-Received: <xmr:M64HayJRDcj5eKJGky4qI1MGBIAqlPM_YkjworejuIZlRVzF4hBBRf4bOY7HOSIR0NmVNdaLMgyLTGD-Q-MmYvdDaHpIhtQylT_ghNI>
X-ME-Proxy-Cause: dmFkZTFVtBVMz0L41cT+SgbD0P1eitlxI5zL97M6sW7kSAsS8ZFyihdAoYR56MfxOXS7y5
    SczQf8JKMg3weHrvkyogPHSBhxqDn1/8a/ExRJoNm22Ewk7LleDU6j4d00+km010YahpGC
    AdX+cas5wQN9PN0ABZDv6kfrOe5ek02ntr4fMH1alhY2fCI+keHBCPys2T8ua7VQxdwYTW
    sFzZndT44HVQSqVLdkqmfULTgfIfG2sOslirAcOOWWtyoYCgXXRzMV+p4CXsluVxupkFXo
    go/C0N6bf4zf/IeaRI1nfe92RtCRUIkXZx5cJfEItpzJQSakkWunMQJSK8Ef0TGO1txZNC
    a29Cl0fAl/wuWkSgJpNZP1tV6zKVT3i3moVObCEr/4EXbfrnQEyNiWF3DIn4pJ4HlG2tyI
    /6bycsIUV7030CSjEW68LnhDOzlrBN5/o3XVuiMUOO0zfsP5LgwnSdNDZNyO5pN12xjspy
    WgatldJC7OWuEN0DmV92C34byV5oGwJFd/z6p492H8FNpJGDX4Iu30MoMJZ1j0WfYQPxkb
    nMgk5I0PjC4zjwyKWFnsRko2ch2b/wMOSWIWc94nEKXtbbe3PytBLHjrcRiD8bgBeBAR0w
    yFIjtSsostZVT7vzBNuB7nZMwTOdSU8X5iHy3CnNVWVScpSt+bwVtoOa/9pw
X-ME-Proxy: <xmx:M64Ha0I10eB9L6-FhddjrbNnHTFPd0KwftLYoUysEL43W95ECeasTg>
    <xmx:M64Ha5WHAyyq2uuHCbTuajpTeyxYRMTiAFJAzD4CCRn29-ur95Uh3g>
    <xmx:M64Ha1mWZP0bEQqZJkfiHnsG9LMItSiwQ9xVCAUzHkMGAG2xbC5rDg>
    <xmx:M64Ha3lKt40sphojKrcsxuTC8ljz58ijn08ke7qqyOtUvcghpV85gw>
    <xmx:M64HazaibpXyr7Mc5Ylzm4OEyAnuQgu-p4YDA6zvekjA2aKmKmEhhqZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 22:57:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5 0/6] notes: start passing the repository through
 notes.[ch]
In-Reply-To: <20261125220214.35881-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 25 Nov 2026 23:02:08 +0100")
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-1-okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 19:57:38 -0800
Message-ID: <xmqqzeuwqm6l.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> What is left for future series:
>  - notes.c: the display-notes code keeps its state in globals, and log,
>    format-patch, diff-tree and format-rev are given a repository but do
>    not pass it on. format_note() still falls back to the global
>    default_notes_tree, and expand_loose_notes_ref() only takes a strbuf.
>    The hash-size helpers are also still on the global.
>  - notes-utils.[c,h]: still use the_repository. And the hash-size helpers
>    still on the global are reached from here, through create_notes_commit()
>    -> write_notes_tree(), so converting notes-utils is tied to converting
>    those helpers too.

Inside load_subtree(), the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros
still derive the prefix-length byte offset from the_hash_algo, even
though hashsz now comes from t->repo->hash_algo, so converting KEY_INDEX
together with the other hash-size helpers will be important before
mixing repositories with different hash algorithms.
