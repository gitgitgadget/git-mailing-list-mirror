Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342393;
	b=DxmEBwmGYqDj7va1LQwYyCD4Vry11XPuc7rMhoZCRRqKpEDyT2JkUXvTiZYURZ66gE5e
	 rSHnWytM7nGxEmaQaVueb1IVVVuprp5umWyEW0aWY8arq45jDtsJWLFOG/KQZqO8C0kVl
	 A0IxxaEl2eTzVClLEHwZT1IKD9cj/ygrZ1tF6Iez7dQRQCO5+vqMqrJZeR7ONPIuZqPtC
	 CmKm6TXiB/DW3u3w6iE4gfviT0LSgraDX07ldUTEMVRp+xwu5L7RAqHdnw84aTkDMb46m
	 XNq379QXSKcHfkpn26MPF0FeOxoZ5yoFaQ4sKmVk51ld4BT3gtiEg9deUb7Wjwo4emA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342393;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=E/vA5tyHbbCgInBrhWEVvsDInKI8GC8lwM3Ww3nKSXk=;
	b=X2ZDuuXKv0FtAvQDWc8W7/9NMIcsf+nKQct9k21hLF702ASuLzGB2GjlYRrwINc8SVaS
	 +tNUZqXC0kSOWH3v9AwmgOmDJVJijqiGoPIrZdnQJ9ejlpkHg8GAFu55obh2SzQjjMbbu
	 tQ26+9BFGNXvinMvvgG3+WGX5Jy758mMzRcn043dFlfrrUDgnX3QOGCJSSOpxKPXL5aYZ
	 GfMioEoY7l9rYld5dtpUWPJ0V570rr9PPe0gjpSeosICkIEFCdbfTzOsbrTqBpRnQXRao
	 TAEZLOlJsRqhCq6JtpxHeRdBGsl5GD45Xdl4dhZ3YuN50CfYUb9PFztBvqUzU3shb0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BkUjCto6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vrh1IXTt;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22A606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC22A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BkUjCto6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vrh1IXTt
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04BCD7A025D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:26:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 15:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794342391; x=1794428791; bh=E/vA5tyHbb
	CgInBrhWEVvsDInKI8GC8lwM3Ww3nKSXk=; b=BkUjCto6P1nM7+ZU/0ZcN0jyrn
	6LoGGFda01gRIJFilV+MwnvB7I9LsHWprDmU9TCboKIuf5xM18KT1sYokCWVn8U7
	JAautpCbsyNnVyERghMeF9eVGnwGSpenRQmgTjz6oRrndFiT5xCjJ1w5y8Hh/uQk
	9TPUGwg/rVFNccrnaVoXOJklAZLrFFWWIoBgIAoqZn9mIgLzWIQBTrnY7HQkXsjJ
	BSXzw2FNkndKMrtSCuT/mT+MYL6teHxM7kpWnmIJ1Vm+d8a/pnqXZUQxd+uZo0Ii
	982QRAPorurG1guu9dizIZmFeLlEg1aFGdBmULwYN+/3U5A8SKG2btCD+4Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794342391; x=1794428791; bh=E/vA5tyHbbCgInBrhWEVvsDInKI8GC8lwM3
	Ww3nKSXk=; b=Vrh1IXTtySaNrm/56RG02b7ahRnylDL5wJ9RG1Y5pjwwXf1Br8u
	fN+bQdbtnEqlB8myCmLrl2nPIK1SxpfdUWH6VSERhiLf2i8GyU7Fz7ty+X3FQfAh
	f3okv8FHJCM9bxGXjyxNxjlXk7zPTDgm+K9ZBPmzGzlsK1XVWUSD3ZIZXZ1/d1AT
	inTZD9wrGTSF80mlYUVu46fXFIBjLGjuCSgUBLAM3prrZ418M7SJFGHtS/qEln80
	S6Sxu9M+JZuJMjLiJeksO7eprQEby5Ood5PqIEW9EYtId9sf8ostdqURhdlAw6ZZ
	PQDH8kP5AO4LcM3Se9IffR0aQMsfGhnv6gA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794342391; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d8GQNJ17sku9XV92tqYG8H5yt5hQ1qR80GerHUdZghL4OD6
	/IXu/ElOwGT0bvy528XMm8UBKTXKO6oeIkpwb5HqaNRvZ3/GOqEsXgnevr52apao
	QcIKvzKcMZdl4yhAH7C+LFec5/rG1d99/MQagJjPyVGc+uQWF+CWkptbdpjNnDzY
	lK+ZpbkKv7j6XoeRFCw6YN4quIxtz4FwovqIGsbwQ9S1O0zBhadUMcR6M7ev51GQ
	cxeuobt41tOPIUSc46ToExvodPZgnvoVrC5kKUfcep0AxhwYghzNatMOKZwmWUVJ
	CUyZBiGvEsgfu6cT3mXCB2Isvrgja3tGlcN8uOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xfEdO9UkF/o+RFmGx1+SBSgLdC7z8OfAbHGTVGasqOY=:oxzRprjKHfrzSHyiE+k84FbwLqWR1pKrk1g/cyMjflo=;
X-ME-Sender: <xms:933zaiTwjAqV0Ylr5-bOrzVcPN6iFP7YUbZTcjFb_GeLqtXuDso12w>
    <xme:933zauxXIRpMRgY2MvsbKLc0X5If_XyW05aGf9tDhCh-TMv4td8cP9YtQ4_Z3AxCc
    7cenVEDDuWM9yv8x9c7w-fqw1j8mJuiMRkdvFXKAJ3m2_2r8sZ2Cw>
X-ME-Received: <xmr:933zak2FqjiQhveSggIcVp7r7vBEt_Qvd1iFuEV2s5BJUefJJI9nBonhG57PSDvJRqhVAChj7jfnRRJATm1gMA-Wl_w_lWqsUih->
X-ME-Proxy-Cause: dmFkZTGTia4lCFI0dNGROClPbXlqiS9bbfheGefQtX5r6xtQ45cThjPXstA5ZiGB+Rd30d
    ZTETHSKdFEwF3bUAJ5V7hYFri/qRbjYLUpHch/xnpypzgh1bWcktEu5O91ZfsNNuRZYlbT
    5y3Xdaz8UShpsdAeo/7Hac78N013MJGeVyoF/3CDcycvSOWV7rSRY3z2tfuJ8YyX63SFRv
    HF2g5L4uATiqWjlQxoBaz3qB63nwzh6TozrzmapMrCYBLa+ClKQd3IRybtBZC9tqpmicA+
    nlp4xnKn73TMBmR+Kr4SZa5ltxVhNJFGoz/iRnKW/AP6yuQci4ejsaXvY5F8fkJcGcnFF2
    OOYtKCQSJGPtxvSb78bZmoAR8HaJh6n2szThTnXWVJEfboNhloW7B2Dgo3+UHzSyhjwg5i
    1iItC2iPj4tLw+N5L1Y7LTcJt41x4Gz7HIxjlTvg1LSseKMfiT/AnuwjgoGJf187QoEvka
    TyHlnLJE4uSXvM1lJ5e0LI6f2tgVBvwo2FCLfYNiy8FNMQVVEHtvBGhDN/44g1KSrp2EeZ
    cDoRYVwZBNv0deV/FGswr9Lc8DWo5A/IuuzI/oRvqmMMhcLBvz959PKrPXNS/eni2M7iu/
    BFba8rteDxKnueDfMJOPn8UfXDiw5HYbMuBCfiyyMZUnTKcL7grB6KsVlXwQ
X-ME-Proxy: <xmx:933zas79edZRxrCOsh7nz5Q7fXvK6lmzG-_rNw3iMbvtj2zgMzFyrg>
    <xmx:933zanVaITf_Mq1Dm4j_nz1Pxp1mM2ZMCPlyJQ1wFuqoR-unEJ_-VA>
    <xmx:933zarDv6pis27YmKMTE69-y9CpT7XuJgcQZ-69rUcVNt2uRkFqOFw>
    <xmx:933zam5Bi02wM2iFgRT4hyO2G-vF-hJv1RWRJUeD5k-mTH7u4pxOQw>
    <xmx:933zasVtP9AltTgsMYsKx6mM35_L6AlFd8O7FLw-CJow0oNdOIQB4NP8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 15:26:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3 1/2] submodule: use the submodule repository to
 abbreviate commits
In-Reply-To: <01c3cc25738c43d61aff153805e02db872ff21de.1794335969.git.gitgitgadget@gmail.com>
	(Srujith A. Poojary via GitGitGadget's message of "Tue, 10 Nov 2026
	18:39:28 +0000")
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
	<01c3cc25738c43d61aff153805e02db872ff21de.1794335969.git.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 12:26:29 -0800
Message-ID: <xmqq7bikqvpm.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/submodule.c b/submodule.c
> index 6fcb606f7e..1302c11ddf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_options *o,
>  		struct commit **left, struct commit **right,
>  		struct commit_list **merge_bases)
>  {
> +	struct repository *repo = sub ? sub : o->repo;

Let's step back a bit.  Use of any repository other than 'sub' is
wrong as a way to correctly find suitable abbreviation of object
names in the 'sub' repository.  Now, the variable sub is NULL when
the submodule is not initialized, in which case we won't know how
many hexdigits we need to abbreviate "one" and "two" to, because
there is no repository that has any object from that submodule to
begin with.

> @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_options *o,
>  
>  output_header:
>  	strbuf_addf(&sb, "Submodule %s ", path);
> -	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> +	strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
>  	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
> -	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> +	strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);

And that means the above patch is an utterly wrong rewrite, isn't
it?

Because using o->repo is just as wrong as using the_repository,
replacing strbuf_add_unique_abbrev(), which uses the_repository,
with a call to strbuf_repo_add_unique_abbrev() and using o->repo
does not fix anything.

So when (sub == NULL), the code probably should just grab the first
DEFAULT_ABBREV hexdigits of one and two and be done with it.
Guaranteeing uniqueness of the abbreviations within o->repo does not
help anybody anyway, right?

On the other hand, when (sub != NULL), the rewrite in this patch is
absolutely the right thing to do.  Thanks for working on it.




