Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661861;
	b=VaRyXpz6+nIutuiU3uUEecRTs1cA04D646Ren3ZsaCSjn7B0WQCOmXYHjCdG8GWJBJbZ
	 1Gm4I/ViycVUy4M3hK1rIFCG4XRfsoAeq7imRVj+qwUgurQw81VAPGJPl+ma4HXnQla0i
	 QWnd+LT7qYWkXVk98+Lqr7+P4wytA6jeWmVylGH8nZ1+jyOF9I4OJC3pG3YNBC8PsRI4V
	 J+9GsdMWW4zpz9uuscAHlLYr3PDAiORSL8tu8hlFk+RZyD4AyIOKy2MuMax/BxSrdVxF0
	 UO/ecn3WWkkUuLGzZvUtErbsQMBvwCv0O98Qf5s+5O7V93JHVQPrLDreLE6IJr3ig6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VhvOSTafLu/Dst5ospwRXnsCds2Xg+QCAlopEs1qifs=;
	b=VpBSKLy1vXoQn+Jl3q3m7GQ7acU2GbZmIoAjvk4D4g6RSh4yXvvMdwFDFtmVt7zviRvN
	 UzPZ1NGVjWMTH/q0Vpw1dbJuE+Zb6SUx7BXETttlTXW8b1uAnw35PXdQkc//c0jAHILkZ
	 CwJ6uyt6t1uj/RGG54KTkT/iCVjhRo3j/mTNhIVOyYgVx692VNvhQmlFrwk6tqhczSPtb
	 GKOEzWvDXOt+XDfFXqRyE0Y5FXRhPK+7I9IBRjDiBs/wok/EE2003rRwQwZTYEdxS5ksx
	 yOpD9W/7LZTg5uM9P8TTLDxPcTgXsd9ZLbUcNjNZ6oOmEh5cxZBcSaeFYOYWKi73z6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LD+9GvHG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ycReuWsK;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816F606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 02:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9816F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LD+9GvHG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ycReuWsK
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EF56A1D00554
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 21:57:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 21:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795661859; x=1795748259; bh=VhvOSTafLu
	/Dst5ospwRXnsCds2Xg+QCAlopEs1qifs=; b=LD+9GvHGVAUyhl4iAZxcV2/rU6
	KpQ/OsrKs0KpIoorIKikedLdSClw5gTpd+VZR+YmuXTTp9FQLyIfMqb1D6lNtUYJ
	R2R+kDPxH9TJ6IW0bMjPWxmm6U60TG8Wgw2THqkQTk0uHtOTr7ztAEaenMVfDFn7
	gSYat2jokheTNiBaBwl7x32i7pEEoft/Y/X3WoeBO118vH3QLJgOLN2yfBtmNlQM
	CjOXBLPo+kShKDVOuzveqw6SlE7a2FaKKSOXmDFSreceMhEORrB0gz925XnBCbPM
	R3pN7utxITOkHrr2GXhuT5Pok+b3WQX0TBlW5/99q/Et4ZJYPYUMniq/Yd8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795661859; x=1795748259; bh=VhvOSTafLu/Dst5ospwRXnsCds2Xg+QCAlo
	pEs1qifs=; b=ycReuWsK0FIU+QRnyjovvZtxHyP4EtHiUHpsvHE41c/oTeBl6Fi
	KBBunqo7gaxQjnisy8CD5f1aRY+N6zYPa3oROVWIszJeKFLmsybZ3/eYjreWwGW9
	En06tymaVevkxJ32MbCOJTQwxWYLaLTubEjSFLupJZFf7RkFdzGAmmQkK3hYPaJG
	gxJ0JRmgksQ0nFhpntMHwY7fhHeTldcm+TU3K0FJ1nm0Sn0sNd9ImYvVN9xu6aQh
	3YxZnXz8EAUdVS4EZbAYyrESFc0YvQDm9lYJagI+UJXHG92k2sUZBBH9/J0mj2aX
	5slsInVHNnvouIgd+qkK69CQYAcmUwcBzgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795661859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Dzha9+E3C/2NqnTKigpOneKxuOfk18RpsZJIeAJX5zBeL1S
	wdWvZHImECwehjKWi3iPE+3F0iX/tjBkWazorlO0X2mIgZKm5oHLxdYN+AANvLJy
	B1Qc43gYD9CoUPgptt9xX/OUAFfr/tdjX6RzxET9XIb+7ouStlycEPY17Xe8pt+6
	4N6UE2tXBez/wvVSORpR5GW6IXJh0iwfxGUVAerU/G6CWZ3sGdzyHoeSsQEOuOz/
	Fbf720TJDfKn3tB8zzXhtCg6RbDWA0KyCHhi6airb9LvLlPnWiRDz5HMajDQ4OLj
	dmwe+qpC/cgDJXPxVxBQUXfJN7R3txKe8CEr9uA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QcwIdhepp/IneVAM+Mz7RDMMOjG697KXZQSdGokNxiE=:c+ZXJjDt0yWRQLexyK/lWDwS8bVnxisVkEUfxxCoKoM=;
X-ME-Sender: <xms:I6AHa-qtJjX1pInMGLOgtA-2pzxbTo5C7net84G81JVQKIEgO2K-5Q>
    <xme:I6AHa7tD2S-QMfH0PAUDF2JoNcFvgbd5jsNdrcDSbROiH0XCbsx440xkp1fSMS2_s
    2XVYlH9Ge2oh6dcFjfZE2JNXWalv2OPQLW1Z4m3Jgh-Uh4J82CpV9I>
X-ME-Received: <xmr:I6AHa5aWTMC2OTkNEHGmdSQZ0jo2R-JJWFx9jS1_4AcwZMe7JhaoR2TZlntQ6vOFKyDuXK9ySHAbJQ7BtnEmw24cmJkcYdEaTUkHjCw>
X-ME-Proxy-Cause: dmFkZTF0diSLva/n/0uL4cZPWCs3OLAMytR3rI9CRDm4CdEUNQUoOug5EkQfVgao3n//Rm
    xPEO2eUAwRrQ05znyGjgVTV4Vt+VHvPQ9lVkEJkw+HeGcAZSQd+37sp3aTwzJPN1ISeyiG
    zlOvOUU590zZ3h9IFkw+HyeEU0x2h4NG1UFMhnXhzf/z7vXk23U2L+0U4ctWRR/2nFV/GM
    wAK5dMVvF0DPcIXnUmfkevKbO/DRfA9FGMs95NOrdpaJAkNg0JZ7QVpcCwAYCmfzrxLyxv
    CmdzMWAiJRv2GfNUKBDh8D8OlbmjsbRdGfCvnk0LP7Qxqp9lgpAmSUNn4xDxveqn6zzKrt
    LLXNszRTccoGK3gkhefFU9bzVSfJc4yfAtlFp8ZkZEgIwLsYaxTJY0u834TtmNKDxChL/X
    WS/9LXINQFWKIxGg7W/M0xxdh19LCarulocftWORN+1eiqGAGbAg9nk0MV3mtdrfB8ByTU
    +qCoU/DIbqy947s+FAuyWNlLm0K/K5CI129VMjh7PdYVMYl1YPZeKNtepdd7OjvFvKhWQ2
    qmFMIjpLClqMi+NFM8iYFpPwcBUmGue1cWnbp7+ceWgECFvtNW9G5Me4grqY5G3NhQlAKe
    MwZoCLELIVyVtoDssRDXq5mDQUaGMYA88U/JorYZ5XIgyD0hFogZlf2IlQ9A
X-ME-Proxy: <xmx:I6AHa6b_FwswdsCltTauJq7JYBRc_jHmYKxOD_pUhIP3BoFtHQSV_w>
    <xmx:I6AHaymMLRK2yoitBA8xwpLySfdfa8m91_qXwZ0-yWbSdfBAYvRLEg>
    <xmx:I6AHa12B1U2v1eJGaxJso94-Bl5voaiYmho2v5van4ETaX5-Q5UQKA>
    <xmx:I6AHay3zoGBzjQrr6V0faMX1I1StmDHhnTMVVp31_fZvsFMGPDZIMA>
    <xmx:I6AHa9-HPNpTHLV-C3Moorwyqo5xBpzVfFH1WP_UT7Fz-5AaclIklUip>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 21:57:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v5 1/6] notes: add notes_tree_or_default()
In-Reply-To: <20261125220214.35881-2-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 25 Nov 2026 23:02:09 +0100")
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-1-okhuomonajayi54@gmail.com>
	<20261125220214.35881-2-okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 18:57:38 -0800
Message-ID: <xmqqh5h4s3j1.fsf@gitster.g>
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

> Several notes entry points repeat the same check: a NULL tree
> means the default notes tree, and the tree must already be
> initialized.
>
> Use one helper for that check. notes_tree_init() asserts that
> the tree is not yet initialized, free_notes() only frees what is
> there, and format_note() initializes the tree when it is not, so
> those three keep their own checks.

At this point in the series, the initialization function is still called
init_notes(), as the rename to notes_tree_init() happens in the next
patch.

> diff --git a/notes.c b/notes.c
> index ec9c2cb150..a73a51e1a0 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1140,14 +1140,20 @@ void load_display_notes(struct display_notes_opt *opt)
>  	string_list_clear(&display_notes_refs, 0);
>  }
>  
> +static struct notes_tree *notes_tree_or_default(struct notes_tree *t)
> +{
> +	if (!t)
> +		t = &default_notes_tree;
> +	assert(t->initialized);
> +	return t;
> +}
> +
>  int add_note(struct notes_tree *t, const struct object_id *object_oid,
>  		const struct object_id *note_oid, combine_notes_fn combine_notes)
>  {
>  	struct leaf_node *l;
>  
> -	if (!t)
> -		t = &default_notes_tree;
> -	assert(t->initialized);
> +	t = notes_tree_or_default(t);

I somehow thought you would leave assert() outside the helper, which
might give us a better abstraction in the longer term, but I do not mind
either way.

As a way to prepare for making copy_note() safer in a later step,
keeping this step a pure refactoring makes sense.
