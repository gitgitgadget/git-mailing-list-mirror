Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705396;
	b=K3LDq6jDWhL/CqkhLh2wmg+uW3A2s9WtasbKVoa28P1YVqtlT9uxhU8wwerWBITLgdcv
	 fofF19Ao8lN3EIdpbCBAzR71jIjlMDFG6z1xRKwqcoJYQ3Ciy4jH9Qmv2bMk5vGLuzTlc
	 5JzvVdRw27ZdmJDIVp9k1k0bvGE5Fx9eZV7kJUtCfSasKdv7QvGV6dllQcCMGlQof5bCY
	 /sgRMIeQU6WlWkxxaCWf+AOpRyJ8ykUYnqfp8kuavnJOa5MubTo+Y2kK4c/e/grvezk0b
	 0ktLqSRpyPheWEx24VxMszrFKTd6YYrXytC4pFAosw0gVrTF4eBMQQFT1UjWjUXszeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705396;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=inq6uLLO/47dC93LjTtRskMSNIl0DoP6okO2U2pIKXE=;
	b=H79PcLD03R72UttuiOo7FjKOCT9gpVRxcbyrezVMf4flZCzyHfhaGsd9aEvJd1/cXbUt
	 OMYEEffK1VsDbNh8TvZtT2gCr7YTTvrQSlUUPc464DlReauWcR0IkjQ1ewdNXMbWTC/vr
	 M7FP+BljtV9SRORj7oFmZkBfgcMjBD7zVMBcyYkpEp7AndP5F8StRlKyp2pmAMt5Mqtv0
	 XTvsVw+seaFxQS90ji2AUgHADzQUyN284ucJRbK7nTH84GL/xYKst2ccY2UN8TIci+v6E
	 l1R7FoOiUMvgWlEGGFl96iJ92KGCeO/LniqzIaftQiPmLCdybwXjZHhcZNpgMjmr7Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="m9Fl/WE0";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jgMKWeqf;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A5606C541
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482A5606C541
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=m9Fl/WE0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jgMKWeqf
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69B757A0170
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:29:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Nov 2026 06:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793705394; x=1793791794; bh=inq6uLLO/4
	7dC93LjTtRskMSNIl0DoP6okO2U2pIKXE=; b=m9Fl/WE048KBfu5s66X7S5Dhdp
	Hr7DyHs/izTp/7+7BTas6JHGvbQhRRM6qUq9V9j6GrLAUpUAwV/qDzOBpUeX4EZk
	vZ+7rCfui4sq15ahsYMnEBjZBGjNPS0Buu7pv/HGG+O2a7Xs1mNeg5rpXHAZFQtn
	goTZmwyKMA5m7zYnWytvSf2Qo/QXPDzSLQVfXLou3HlM6ptddlY9+bYYEv0szHXU
	oy+Dn21c5hlHtzAqfCtVekvYydc3e2DkKZl/4CpiEa+Drw98QixHhmEzu5GukNlj
	jJ1S+WiRvI/eNaq4WXP1g8MPUMFl12OOVVc2rGCMQCsLEijWKm16HCsx3YDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793705394; x=1793791794; bh=inq6uLLO/47dC93LjTtRskMSNIl0DoP6okO
	2U2pIKXE=; b=jgMKWeqfPcyJg1FQvP9nomX63Oipkgw0P4u9vka3b9WODIAafmz
	ef9dlu46255gLVHfF3rxcFs2VQb9BCJXS6O8lxluTgWfgFLsICjfqgsr6Jv4yM1Z
	xUX2a3dvw5vPMEoi2pYLF+2i04Yy9dMBxKIVwsC6Y0e6aTjc8xXoELMaW9QWBXsc
	hTOQkvZsR6eYQ3uSS6fGTXqtFZC+S5X4dfwl5LZlAny+MUVynPDtJMbMlBdrGcfH
	2LchWeJMkX35Tut7KTLNffoT/e/s4+uP7k5dv+KBLbwuPOHeqvlyYsEwseqWX1Bq
	4osf/iSen4HKqLkZNrVfaHSwI+ZOmUnGK3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793705394; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Pr0KtSfIUxw/8vc2OdB7EK9Ut9XkqugtM4CAwiZCWltL+AW
	fPUTD7GJ2h2d+XmaW7by60bWJKuAOKENoewCX7MoOD2cF6eCp/ew+yEFTlRnshvK
	o97q+s1YfPFcIblC4+LzeXvsYjgv4v45kzrw0qCCPVGn8Yt1uMc/IfKWplFr0+O0
	d1EM9KZu2YZ24b/pgrrIJhKEF8shCCP/e20RNwNWOwi+m5Xf30rtqGQ0hk1IWpkY
	78tkTHFRl65vWp7qj/kWqJ6DPXLXacf8c851AZjsCYVjVfBOsu7njA8yZ8pMqzAQ
	dLHrssXnlhZviPzRdoC9d73q964ZleWVXqTuyhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b8Ed0CN6A0wbtQCzBms2VVMaUulWCCU/JxsTc/HKfEw=:DE06R11qUgPSsd741V8YoGITAKUQaD7ernFeVPVu50k=;
X-ME-Sender: <xms:ssXpag5RB650JjbwUiGN0uy_-tMhph-0dPklbH61nxp01mTVDB7W_Q>
    <xme:ssXpao7XBuwpPyvfvhg4Lr0L6T5jNhnzRYEylpzI2LiaIuBBz8OJn2q3eEq3hpzSg
    0d0vcZfVE3_RGfBIX-YwDzZxFpG41259xUqcKJ5CzPiVkYtGzA9>
X-ME-Received: <xmr:ssXpakdpZe0PalvCQbiwS9HZnPWUNLwliBpPxjcFnklBKkhQQo6Ehw>
X-ME-Proxy-Cause: dmFkZTFhtpSfkmIhik3CNpLEcjnopBeXT+0q7ikUzgzXra28TY7meHAIazuymjnPsssJnD
    cgbeWGckfa8PV77DTABqUX8Sqs25yvJh1K5bo0jt8TN60iG7Y1t5wmQgMk+7i3aSvYdduD
    lXdKYk6kb6z0ymlFK/8rJdJkBF9GCh3O2sLJ47dWbP9m4sRCq3CQKUWPVxBfUrAcoebed0
    tAP4/pdS3MAbGIL2/icMHGVI7VAP9xgzwjdpysIiD0OFJjplU0vb09C6V1niB0qKgZsH6z
    Au0qWYfHKDmMy9722j6/C1KHk0FEUJM8eCOd1iPg+sI/TUbpJwJ/KmZ2ucxyVHS9qirRGY
    D6IbyEz1KXAZHKL+JXGDE3pDWX+2sPq3toTtSeJTv1fRhUc+0wV9a65s3zySZVnmbuFLyt
    9k/wB7eFprnQEYLUoz1t6LJcuvg+Zv3qdMTO7ajXcSdKmnMrjgUB0zN/3z7neSAyOyUmi5
    Wxm9VPd0lOrgdp0JqFe+ErbEsxRkDomufjVPluFiCZhLzaeBk2IZmH59sme0+YxlZtgvxv
    6S3s10sVVN7piPIuDJduszATjZruCOJrVreo1a8CYUweRgIBcBL2473vg9+QHOveI/QYhZ
    7vUVG0DNF5WBAGCtXU5JknH606AzNLW57zFOi81cmpPd3tArmFL39ONp83Sg
X-ME-Proxy: <xmx:ssXpakCrV6n294xo-92OuaMoqxQKxPfVO1lbwW-oaOJYbUklnpQtSg>
    <xmx:ssXpav-fcOr6dOmyyrx_8SUyApVX708NFq4mmoOjBHxv-ISlf8YIJg>
    <xmx:ssXpanKHXfHrqI__BGBBZkw1bBcYm5dFU3FOKN3u8ayeWqBAMFUpdA>
    <xmx:ssXpaggrhg0DxrKypvEU4PxATblkNqGHyOW6RVQYI2TItRviz5qOzQ>
    <xmx:ssXpaj9Ox5H7fj1bEyMKIwDoR9rQx3_CB7g4AMbboIn08O4znsL9iqll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 06:29:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 738b311d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 11:29:51 +0000 (UTC)
Date: Tue, 3 Nov 2026 12:29:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/5] doc: glossary: add root ref and clarify pseudorefs
Message-ID: <aunFqykTV0QHCmV3@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-2-andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101230326.3675597-2-andy.koppe@gmail.com>

On Sun, Nov 01, 2026 at 11:03:19PM +0000, Andy Koppe wrote:
> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index 52301a56dd..f905b4467b 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -500,18 +500,25 @@ exclude;;
>  	unusual refs.
>  
>  [[def_pseudoref]]pseudoref::
> -	A ref that has different semantics than normal refs. These refs can be
> -	read via normal Git commands, but cannot be written to by commands like
> -	linkgit:git-update-ref[1].
> +	A name that can be used like a <<def_ref,ref>> to refer to an
> +	<<def_object,object>>, but that is not stored in the same way as refs.
> +	For example, pseudorefs can be passed to linkgit:git-log[1] or
> +	linkgit:git-diff[1], but they cannot be written by
> +	linkgit:git-update-ref[1] or listed by linkgit:git-for-each-ref[1].

I'm still not entirely convinced by this change, as it only focusses on
the difference in storage. How about this instead:

    [[def_pseudoref]]pseudoref::
        A name that can be used like a <<def_ref,ref>> to refer to an
        <<def_object,object>>, but that has different semantics: it can
        record more than one object ID and may carry additional metadata.
        In contrast to root refs, pseudorefs are therefore not stored or
        handled by the ref backend. They can be passed to commands like
        linkgit:git-log[1] or linkgit:git-diff[1], but cannot be written
        by linkgit:git-update-ref[1] or listed by
        linkgit:git-for-each-ref[1].

Patrick
