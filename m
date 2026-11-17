Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957712;
	b=3RBpzrE2Y/ZESE8IQESSon+b4GYk9JPi2KQuSrnxe7AOLC+dItyO7HodvamRMjznkBLt
	 K1f39FtcYn5jxiPgV/QdNDDniZK4u6+IU2HVusIflsu9WV5XtbFOncPfYhkhUgqTSaWAH
	 ql44YQSlDzyvNPHmrqtR4QPMXl2/cBBrmE5aFfe89yL82UPsBbRoXk6gG1846uXjhcguu
	 MOTHwaWfKsasFU2t6M1HFr7UlWF/rWYaV2EyYYd0S28ThMPwsFRS2XRl4xZark1e1m4zo
	 nCyvU5LtsLXrD2g9FFPHk6csTuyO4CRqjgFc5pUkKIRVMSenOZzumqj9vM9aMxgFpcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957712;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=BuZxjaIVEqZYiYLX1LjAYeeLs8vOl+mol5YzscoJ+1s=;
	b=06mN0gU1njmMFss34uWuN7JxvVRmjzBEZ5wjYotIzc4ZGID+4MAFjPzgLr+mKpsgiiKn
	 h0Cku1O5ZWMukGDGBSjzrk++CKWXLUd1et2lGBghboEJr0GK9iamg+DWiyUCYA2ey8Kn+
	 /cewGvmmuf2reIkaaDO1fBRTyZv9eFmfNW0/HDxUTGEX4EXdEAyf78iH6aWFYtTDLVSKZ
	 /19dkKgZpWBulWVPCshY88cid6amerTk29gnmYC/X1B7pVatWwR1DZ3+10FLFN/LSw7iG
	 1aAFM2EMng+Bs3bmllSa9qhVNJwqQCFllkfZH/sYftY61s/VsnTqopjSgOZsUao0emA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="WFHe/Z5r";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=du97N9P0;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159C606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1159C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WFHe/Z5r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=du97N9P0
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 586FF7A0267
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:21:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Nov 2026 18:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794957711; x=1795044111; bh=BuZxjaIVEq
	ZYiYLX1LjAYeeLs8vOl+mol5YzscoJ+1s=; b=WFHe/Z5rOuiUv2Fr7MzZYPVj+y
	DYJmnG1VYXLhjV4XmhWcnFyqowdZyjCvIxZm3/lm+axxqRLwSvFPXcM2YActfVBD
	UpxbCio4ZXqyv43VS3/e3aAV3FKW+XPH6QWICUPoJI1OF8yjpVfmcZuSJdcI71dU
	vWLDHxXmQREvk8K3Ne7n4ffmTmJecCa36xe4b1MPKd9emGVjdQ4yLlCjDNY/0ig/
	lEFc8m1Dh6Q7HKOTDaUKZhxUXYz7nAoF3nbHRVTOm/4gCIEiG9Yic+XjA2P9D7rp
	OGbsVvCXgkJrpBmC3e8L2J8y9xunpWJ7RdfBkCLRBALlxB9vEmnXRiEvDAIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794957711; x=1795044111; bh=BuZxjaIVEqZYiYLX1LjAYeeLs8vOl+mol5Y
	zscoJ+1s=; b=du97N9P0IPg9A2iv4OKIGTY6C+iH3CLra1NNugzhYMBHZqvJYJc
	mATkoThu//9U3LMbn7iEXwudWPGEsOT1q66s8W2iNGEqs2+ejMNtgSc/ouWdGNvN
	/MkUOjjLU5KJfTMDKWPXgSBbT6ZROT3KKPVrQQqouNtY5LBj2cFFrnjwVQCtq4Hw
	a6ESKcP4tAiuYBo6YbmzM8zy5MeMdWlSg1oQ3WPP/DOmYo1ZwSVWKGIyNp2cM/Lf
	c0So7jfABCf8ReovpoDjLuVrOxtvpCZYq6PpRuHN2nG86NNWv/YWYIOSoHSh7Y6H
	nTgNT9ux9pmIuxAkRQhblUb27vRhnNK7zug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794957711; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ShFlCSAM8Pq7NNDIu3gCbbI7LQbefkOH+aaRFlYD2bcDFoc
	XwL3NyVwwVT92TKbUmngsCq+lMt/g3DUlR/vOhi7beZYCPf4iYVO5F9rzkt1aW6n
	s1P0Ftwmz6Bx+XME2IuQEoBGA74wrQftw/cHCLZNUA98opWrP3gxqQtwstK4BJ5a
	XUksAvPsWftbzJrakQhKQQWZWgr8BYSD5dglEcHFHuTZW6ZYwCPEOOVcgxQEX/Bd
	AtKDgfFR0m0ATNzVw5VzGOwWraQcSetVm+lQwOGKJRbsbGK4w4al9MSzmQfcCP/P
	3JSeS+HK3BIMNV2CpQ2Ij1Nz57vokcsEuLY6avQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0JC5b9SRkim2uGuqh8xKZp1CNKqvrU1dreAbN9TiJgg=:22673png8fGO+9Mh013dW4tGkNBednil4o0/kmkpaWc=;
X-ME-Sender: <xms:juH8agrG3pYmquYOtL0QgTbcdpN8soGulh76IVDCpPHdxjlarY8YAw>
    <xme:juH8ahNc6Q3mHD1qpXza6378jorNjCCypXi9MqY-LQmMRxFSwcp4oVwRXt61udUar
    EIYcp0nr8B0MkXuOWtREkDWZJO3EwT538XfkiLMIP73MRZj-oCv_8g>
X-ME-Received: <xmr:juH8ahxUuckyWBK0PDAnt6hhDR5XSK7hRIb8tdokQamMS-nyTN0BDuuoG6weu5OguMGIxnnmN5Sci8i757qff5OIVKhnUdT0NOFr>
X-ME-Proxy-Cause: dmFkZTGYfvPjABwIyaVxhO+IOHeQRELzZozgG/JMcarO80xbjsxoXECxg6SnJso39y5hdy
    Vw50WsPZW0IjLkqQg5Bb7LNaNStWXmsNgsu/vXq/MPAFmg3AvyV1vhQoKGUxdoAprFXVVL
    9E00bvcEXvgaXuQNBj35ASxvNKlDuHxdrRygYSYOmDtubkCPXF2a7wE8Bm5D27KvJDaGg4
    nNwO3GIzNIBWLQwv2ywunCMunOF1rTboUyi4NUaQHaRBCGDowuIt3XGGmY6PTgchGIfD1k
    g8e3n7iSggWL/eqeuzqXAzcif19FpPgDn/6kwrW5hawEzSpEL/l0zqI9oKzOROh1DWaZG8
    cQL4GeV/6uqwMDwZhguFBkCW9DXhEDX56OYH3amyNTuv/3WRq9+6WpVKvevZGw70dC5TQE
    C4yWRtJbFN4NuWj+0L93gPrb9I/Uu5KO4bHsmlG5mkE0i8SKUO2/jqmwreE2wnDWbH0Uod
    dxo1gDDkIHCoZUeMz3157KGK4MVyc6G93704Wf8Pq7c3ol0vGaCZwNCFxJ5facBPR9HPM5
    sV/alwx2gqzar4yhncuEqrGP4SgPTSIHnevmN2k6NK1MadMFHTgLcvtGHznPyLTZZBM7Tn
    jlO9yrd+q47qf0LxPr4pT6xtnA8UkUe2vi3iERZLmZAFONXdVBEhAM1qz8/A
X-ME-Proxy: <xmx:juH8aqsti-Qi9dBPoyiJCaacVdKnF3q2FI1mV0DTynCmwjryikpOFQ>
    <xmx:juH8aq5hhAxtbkAFfdYwGrplwlP5WE39H8CSevXgqZqRSaDH8XcLaA>
    <xmx:juH8apT-crwpfVuCEU9ToVwQaORTsAhS8eGOQJNfuc_yjhRQyfyCMg>
    <xmx:juH8appDTLHShaXGCHo91gjLbiHJOBsuAjof0_lK1a0y4sLK-iXl3w>
    <xmx:j-H8atHJBl-A8ijbl1ChmrY-XDcIQ7qcL0WwzE7O-pNdtDmGAYEHKLeX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:21:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] diffcore-delta: use size_t for the size of the
 buffer to hash
In-Reply-To: <3427c3d2c8c689371bcc111f0915853a0f679f5d.1794909894.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 11:37:55 +0100")
References: <cover.1793546752.git.gitter.spiros@gmail.com>
	<cover.1794909894.git.gitter.spiros@gmail.com>
	<3427c3d2c8c689371bcc111f0915853a0f679f5d.1794909894.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 15:21:49 -0800
Message-ID: <xmqq7bibavsi.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> hash_chars() in diffcore-delta.c takes the buffer size as an "unsigned
> int". With a file of 4GiB or more, it hashes only a prefix; because the
> similarity score is calculated against the full size, similarity is
> undervalued, so true renames are missed, which also affects
> "git log --follow" and merges.
>
> This was verified using a 16-bit simulation, where
> "git diff --cached -M" reported a delete and add instead of a rename
> (e.g., "D a" and "A b" instead of "R099 a b").
>
> Make the size variable "size_t".
>
> Triggering this requires processing a file of 4GiB or more, so no test
> is added.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  diffcore-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index 2b7db39983..7f10f79ffe 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -127,7 +127,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
>  	unsigned int accum1, accum2, hashval;
>  	struct spanhash_top *hash;
>  	unsigned char *buf = one->data;
> -	unsigned int sz = one->size;
> +	size_t sz = one->size;

The cnt member of spanhash is still uint, and can wrap down to 0
after 4 billion collisions and makes it appear the hash bucket is
empty.  Should it be widened at the same time, or are there reasons
why it does not need to (like hashval member that can stay uint)?

>  	int is_text = !diff_filespec_is_binary(r, one);
>  
>  	i = INITIAL_HASH_SIZE;
