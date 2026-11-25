Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629034;
	b=VbZ7hsauCglZASMjZphF+zbsE0SWNTqarbrMYbTXB2lAGWlfquz3dCVymDOJeVjigVBc
	 /Jd1sLt0Px6306+EdP3reW2CqD/WyZoO9OIS6nz/jGjI6rfG2XZmpOTYQ4DVRKee+kl74
	 eFvE2hKIVSuL0Jqwmf5lxfo4hywxbjswNSK8qSlTIy4+IObqaetGNCQBTCjksTMGu4fq9
	 osqf9dUhcLq14mYLVviRAgxj9vsWJisR99Vf2E9fKJto4SuMj1wC0Ud29rmIaADeMRfst
	 c4plpVr/6bem2GpbqeVp8UGLp8ps/yQyMcC2gS7AyvwE20NbYXrtoxMhL/h4SfO942g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629034;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iaoKMiFMkuU855iSeO4LesZkNT2tQo23F1/Z8j2VV4k=;
	b=cAvL/dVLKIig/xkp97MV+/aO7NjYvQ//okVMTypHiZMGvN14OdXlass6VplavcXTJusA
	 FhELQ9EH/zyHi0GYecQOgEWLojgW2u+NtaThIgvRdqt9ETsQOhFliB/ListuAPF0mJYcv
	 wW6nGdFh2pHsFs7K4fHs3RR0gFeYo2p9EF+gEgWogWEGSfj3v++wqtGjxBWC1b4dKlOIv
	 RsZpUgGSZJolJZIOcCr+YxchiUZk3hQGVhGCx3nEfAljl1jX2s3ImtXQwCVfWvYe2KRn4
	 TKCJp2BumFjzKxHgXAgyTKLkdpuJUTS+1u4mRLMN98L0gNvpUka90ezYV1Q3ODLI3qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D2D4+sU3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="5Ryc5UE/";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA4606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EAA4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D2D4+sU3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Ryc5UE/
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D960EC0BC4
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:50:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795629033; x=1795715433; bh=iaoKMiFMku
	U855iSeO4LesZkNT2tQo23F1/Z8j2VV4k=; b=D2D4+sU3V9gGQ28y5D6W8X1UMO
	hL67LarRcDDaDY9e+DYqfhf9AiHQ7Fo2HIm1AuqYfpZfSMbP+kmPajAvJy7e19kT
	tVmzoNuD6Ib60Z8VyXKin20Y/kN7/+9XKGCOJ1Jb1ahkzF8U+sM4ST5lIkNNdCYz
	UIuejnkZng60Tc/qzmPCnN2wk2SikSCQM8SzC/Ps9A7ue/PPEiVc7w1iTeruxv9K
	eq1hD658hMi2LEHsfTMZr1EHkfKYpOVNCtMSMxfzVnJt6IepXt1cfR42RgBc8slo
	18HERq6+rD78GsBpPzdQnCUGhs0o1Zxh6Zx96B9KWX0LdDkO+t3r/ff/YDuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795629033; x=1795715433; bh=iaoKMiFMkuU855iSeO4LesZkNT2tQo23F1/
	Z8j2VV4k=; b=5Ryc5UE/fYXYAIOzBWkZj5wUo0TKIW7SzWotuTlp8OPoaAe8FWF
	oQa6uXH68YNste5qVy/KyDujP9VnKXYaWb5fSD4BoSggX3zLtnXMUWGn3CscziyG
	F4cP68dRSaC14noh7eDOJzT1gGDtxTgXtk4mkNGcs0tMyi7NJJlu405Fw7QOrDYE
	m6pToKt+rwvbZuPhHvcwbzi+BV8NlTXrOdIJhxIdomSNn7OiI3l0kHYagah12A70
	1hl16NU8l6fveoYYEPiXsqFetl1Ca+cV+0SFSAqE2lJ8N054T4KYDBVd4Dhzc1un
	Xyl+hCParR1j+CMvMQRKEO75wBfPgn3MbAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795629033; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NkpLdgLCAdvaphpACegQZDx6sUr+2VNpgMEMLKK4L5pqUbQ
	NUTUMQY5TwIrmuJy/EhJvbiT5lj8BqNR+5p92FG3kjWrYvNUjil0X9JfwvA4RuCY
	kr4iuegwzI3FzewzHxHwygQHcrqMXa2pRxb5/B5lWnNIChW2Mhfh+Cs4FflwZPLI
	29h5HMLxKZU7F/B3qonj48Td5CzIze1TX9G3rRi6IlE/1ZKy8LlMsftHuOhNqTsl
	ksJR8qbpvcF+iYFIWiDcp7Vpt1fCiaghH3cFc0WCL7rnnLbNNMXEvKdDyQWTDLwH
	HfUHlOb6np2b5QT9ZqsIzwicrqpbnXDBo4714kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pBclWXySV/pgU/sNkLkpQkvLNF24IewgBfxhhtR+Yaw=:iaoKMiFMkuU855iSeO4LesZkNT2tQo23F1/Z8j2VV4k=;
X-ME-Sender: <xms:6R8Ha32JG4YpgefsML68u7rrdfCW177kRNEcCFvaIh58PiUAN5p3hw>
    <xme:6R8Ha1LT5IrF8FuMyGp_P5z55V9L3YQLNwSvRpN_eNs_og91_6KIVl31kVz4yP_f-
    O7T0AA2F2Zl5YVdxWUmK1_dpEnvHDitNcc5rZU8TuD4eQ9m7DZD46k>
X-ME-Received: <xmr:6R8Ha-Fjbjgs_DUgRZTKdyCJ9mfnaTl1iWOgzIMklUGamHN190Cc7p3lzFV7CcB_YzL3lHgnzcr000ObPAgCQ5VQsQDkhREzl1T6gaE>
X-ME-Proxy-Cause: dmFkZTEIscm+dPgJrbTeLRCqhFuLQmmKSPPd3nJyEcSpksY1+yW+bgDPBq63gyEhc5BfPG
    QnTBWVAiguVIxuKqDKVcpp/Rz2najuEROt0JTMQ8htI/2c7vW1RoZNMjhitYeaEPMOPPyx
    hRjf+cf5K4ndGzZLlCgRn72UrU4+wpmzPIvCUx+JBZLBSFbEzxU1s1I9f9ggSZ9tA+yDmf
    2VTUpJNuNz4HUKPZBY2h+bzDfy/B1511rnpmoCigT0n30Q9ojth0iI54+rMBUQstQI3yGo
    D2sYq55xyTNsnrftNRIswphQlzU+WlDTr8pO/24DBeCDub6HbyH9zvf2TAW4ulz2LrcylU
    KMGZQPtKidyl7AQJQZbgHmhV/Ux3kQXznsPxu9Tkw+dbQdDjOlSAfUqU9HGLH8ZuNvmymO
    edFS6TGGSiojnQujtQ4YC3n3EO/xT9o56p9aPaIpqz6+G+v4e/NbbMT2gFgB+4AZ04MnSv
    PWgKfWNvfZ9JNH67eJ286FeSRQ8ib2TFCQb3LphLjFFBIxd8hbF2uE6Plgtmj9i0+1upID
    ueKcdeZLdAprGt9St+GAlX1Nwa0hjtchFp7xlY54eJ1M+SYKp8uzfgGBsCTiEj9Rnugx/x
    491qI5wvOaV3CCEV4ZAvultAYQ7U6t+X6AiXhch90pewVItAeUXQtBjCvZ8w
X-ME-Proxy: <xmx:6R8Ha5XKEdt_ISYz2NbTjbLemh8u-1P2GdsX83sPHZ860s2d1K5sFA>
    <xmx:6R8Ha-ytL2IS0nc9WKEv4m6pZRRUFHzJkpEFQct5Wa_B0RCLeqQROQ>
    <xmx:6R8Ha2QT14J9qpKM1Oxs1RB8pkEexRhhHHJUAGx0oyWaTHCKdrOTMg>
    <xmx:6R8Hayhq8gtqqv8pehWgp7Cg8bLGliSwbB2Tr8u_r4y9DGPaxocpvA>
    <xmx:6R8Ha6WS3RVma0S-0I5QtN55eK4nMApx-dDSOjSqNVy-V5sY3_SDCtYM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:50:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
In-Reply-To: <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
	(Okhuomon Ajayi's message of "Wed, 25 Nov 2026 07:45:01 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-3-okhuomonajayi54@gmail.com>
	<xmqqtsl5g28h.fsf@gitster.g>
	<CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
Date: Wed, 25 Nov 2026 09:50:31 -0800
Message-ID: <xmqqqzg86brs.fsf@gitster.g>
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

> On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>> But others? note_tree_find() calls note_tree_search() which by itself
>> does not touch 't' at all [...] The conversion in this step would cause
>> them to dereference t->repo without checking if t is not NULL or
>> t->initialized [...]
>
> note_tree_find() has a single caller, get_note(). It replaces a NULL 't'
> with &default_notes_tree and asserts t->initialized before passing
> t->root down, so 't' is already non-NULL and initialized by the time we
> read t->repo. note_tree_search() not touching 't' doesn't matter here,
> since get_note() has already dereferenced it.

OK, I missed the guarantees that these limited number of callers give
these functions being modified.

So copy_notes() in [3/5] is the only unsafe conversion we need to
rework in the next iteration, I guess?

Thanks.
