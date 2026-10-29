Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261152;
	b=0FPSAXQDM9z/rYw0v1WVqLBf7a66i9+n9GGMn6/0XboI0bnsLXQ7C5fiULlUEuqfTy3S
	 SsEAMgk0CEwzF+Tal2Y0Uo3szEonG1PcuMk3slqWzA8b6PVV7uitBcUYuoLnqxckd2PRV
	 Y2i2LF9RuPRiVKJ8lm1zZUK8FN94ROCTADmwuPrm1Q+B1BogvC9cTgNIwZ+v6hhGihuFI
	 wXStEuQ97mW5QkSIhN+iPYDJMFDImYXHarYgruHqhwGPnWm+vGEGD9f8wm1dnuaOz1lhP
	 YD5vKctrQUCwgbb2YkHUHrfEn3MSO+BJ2NW26CZnQE8m5ncRII+sg9Sb3Is0DzRY9cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261152;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=E2VBPIDirm45+oRWfUykFLyOXVjN0pLAp05myzMFc9s=;
	b=5fSWuIa0sPBjUu4FHBOmNm/8DRqjIq0EPCvyyTZ+X25Bt66JFwWErnw5QYrJPesBCP3s
	 rdWxruytEFwfAjPmrKTEOjJwoJj5Lz20x8dfXgKffS0MwtV2bD4smmR2hasIckPJIH06u
	 aBTlzbETu5DbMhpeecVR0jMqW1jWe8y8ossMbbvyH6M6v7kfX5fv2G/AamnUyWcE0qQVW
	 vcD+LEIOvX+9y6PuNNyw0WqHy001aLh05Q6U4vB3BfCfAqslSvl06S+v80uiKRnOxjkVa
	 Q2qsb2+hCwPqPC4ZGbCVX34VxmPdpaZTPUXhamP0zaBLj7jMK0vCrqCsG1CS9QX0PAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uGIiBZ7r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XedvZO4X;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A4606A323
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5A4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uGIiBZ7r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XedvZO4X
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EE9F21D00123
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:05:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 04:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793261150; x=1793347550; bh=E2VBPIDirm
	45+oRWfUykFLyOXVjN0pLAp05myzMFc9s=; b=uGIiBZ7r0/pPgsTaM2JDxkyNvs
	X78cGoIbX3E9vC/uGPE0q5WGZELZPcfO2he4zPw+CY3Ma70j2fbFSXYnBI70qIMh
	QJTo7fLnBryBnRDzGcgZ5/ngJyNDLnMGdDd1Eohjpqg4pG3AMhOMKPwV6/ys+0En
	hREzeOU8hwNGLIoQgf+l48KL9StI3f8T/qg2+DzvjdGD+rPcVE8Nzq8Qb17ekOKE
	UUB1eiaWiIo/SQ2lpOWTcwdqxELMhSffMSSTF7c1XRqeFebZ9ue2HWv4iHSnl4Ot
	EDE6que12W25xQanzLSuAUon31N+dW5HKoWRJheAfOKcU+R81O/EXxgG9hgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793261150; x=1793347550; bh=E2VBPIDirm45+oRWfUykFLyOXVjN0pLAp05
	myzMFc9s=; b=XedvZO4XoCmfUIRSEVMlOZrxj+wZTs8YulH5Wy5fp9YG5rspOhM
	QlZuClJDer74vyj8nkX2pHU8wUU4UPkTT0211Y515mhgSbh7FzZKsxo9pocpxHRy
	LH07ruwrX3fywAQ0Ob5tLkHcXKNezmb205CtOwDUgfUyKtrEMq+X9NCPP1RoXGus
	ofckppCj/pMtJu2VY5qfRpdcfzj/iVADfNH60H3lFgiEXgUzqCKwn2af4oetQq8N
	rPClRnQcNwLEgXU0Pce8f/enAzkyZdTRVYN1fpwqrCkMTVg203YqE8FnAajZUoPM
	mtV2puBBgkDLjhe6v39i4b9qAn4q3N8YsfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793261150; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cNuDtndWaCd6zXBlfetXnuFY8SpT6TicCUQUi20CLknrdMP
	67RDWM6rrrv2tjZTLNHabaiacbPj1oco5qZrwlppXO3fne2k1Oj69gH69nn27KKl
	uvhrgTrMwV1JOj/i8Y7IfUYYMA0+eZS8nRCNCz029lj+lkDJKItu/jOa6JMjNhRb
	Tg8KPnVDj0y+9mJhIwS7hfLFkIqLOzxqZZPIwPg/ViVRutOMMiYweBrnhYzyCFpU
	Ghkgm+E8yxwOKQwnlv2ZgPXo9i9q9F0XRFO+u7+OPRnqB6jxfycC9VOrRtWRvv1e
	VT6OJG7iRdntcaFYTyHcosy2fdPg62IS3k9qzAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LTZB2Dg2g9viXD9xs+wEcB3S6MOqwfXbly5rSw/Hbcg=:n6x1Yq7q6fub5d/GbfcD13vJ6rOq/AwX8qKUDXvW5mw=;
X-ME-Sender: <xms:Xv7ialnOl6D2nCh6-FawRgrzGKiKfIt_g6pwoOHDOTe8iCW_64jkVA>
    <xme:Xv7iam1xpgSE5V1bLbaoPhOLhhS5J1-A1s5yvRzS-eg8_G7DT6suC0s-KGG0Elr2Y
    tJIz-qNmFNa6Dzj22NL__E0UQBZk6mRYvnFIgqvEtIRcSYJgT-7QooN>
X-ME-Received: <xmr:Xv7iapQvi89GrqDEHbFgTNrTgjJ08kQrRBlOeM1c5JLv2ON5hn9C6A>
X-ME-Proxy-Cause: dmFkZTGHC0ij1QijoNMMYRB1PJw9ihfhc/Ds3RHOk0VoYHbwJQEoYtydlvIm6PpZBd1zYc
    nZpes/FB0rhrJVkJMyQrN7WTc2V6G3IZie0qjeVCGdK7+hRoHoH7cziSOkBXTbWRY25BlY
    Jtlfp8wktF8PRR4A6cwBwhI2BCOLwY7XeoMYqbb6DmcLyw1cDrZvDVWBqMGjMUMzAe1OVZ
    VxScDNRe7m1dNZslxdK5vvESrvb19YI010lcozKxs8IBJ4+lF7FNoW0hlSDogKneBwKqT1
    3NNDu9ExpbE0YL8KQApr82PPlqzJptYcMFQNfDJbBaIEL9k875BWuznY05iMmjQP6p4hMM
    U1Ml9GMBWtks0DFr+AFm37sC66aV56MHX5svwpIGmC7wKPIR4Mc8hdatbrEqtlZvSKpKXp
    17CGOT++SCMGgyHVEm8Ye+hs1X5yxut5pcqhYlfxBcS0j8UV+Ghy48/oPA1FUIdfRSXgDA
    DkoS4Di8NvN7k7Xd8RmGMCFkI7LuutYm3TPEFwgOCa/pRMGvd7eomaa+Uqm07qstlj/1jL
    FRX2TthnQJII6soG3i0PQx7BxxH11bLEvv3MJqY5WK7sgNIHxk2wgaN0dNnk3FiGUSioyH
    Mk7CEr5q6PP8VTldtkugHaUQ/yGTtJ+Td6G7+/FXJu2exQ7muDWLe8EsdggQ
X-ME-Proxy: <xmx:Xv7iaguDTMfM7MkHxGYaqpo5pKyz-tGbm_X3_va5LbWf64c9SLc9HQ>
    <xmx:Xv7iamYrOtvvKL8O9uKAwozK8R7wRrNJJ7zpJjb0NyDuy0dJK66dMQ>
    <xmx:Xv7iatsJYq78XVsQ2HMfB-Xg4TP0wcKk9KWf1oRk0Kl9vYJwwphKQg>
    <xmx:Xv7iagGnETDk0Rc3ukuvBWCtUfHRr5-0lrquR7QmJ1_egNBWOK_ZHA>
    <xmx:Xv7iauVGYkPzJKv0GAyNFf2XWVM-v-hWl8u9e6egMmVJGh2Ru2Pr65x1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:05:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37f94a08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:05:49 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:05:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] loose: lift loose object index parsing logic into
 helper
Message-ID: <auL-W9Z2H9Ivn1RC@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-3-jltobler@gmail.com>
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
In-Reply-To: <20261029002413.3291184-3-jltobler@gmail.com>

On Wed, Oct 28, 2026 at 07:24:11PM -0500, Justin Tobler wrote:
> diff --git a/loose.c b/loose.c
> index c6f4ee0ec6..5f72c644f9 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -48,67 +48,88 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
>  	return 1;
>  }
>  
> -static int insert_loose_map(struct odb_source_loose *loose,
> +static int insert_loose_map(struct loose_object_map *map,
> +			    struct oidtree *cache,
>  			    const struct object_id *oid,
>  			    const struct object_id *compat_oid)
>  {
> -	struct loose_object_map *map = loose->map;
>  	int inserted = 0;
>  
>  	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
>  	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
> -	if (inserted)
> -		oidtree_insert(loose->cache, compat_oid, NULL);
> +	if (inserted && cache)
> +		oidtree_insert(cache, compat_oid, NULL);

Okay, so the `cache` is optional now. You mention that fact in the
commit message, but you don't explain why that is. I assume a subsequent
commit will make use of this.

>  	return inserted;
>  }
>  
> -int loose_object_map_load(struct odb_source_loose *loose)
> +static int loose_object_map_read(struct repository *repo, const char *path,
> +				 struct loose_object_map *map,
> +				 struct oidtree *cache)
>  {
> -	struct repository *repo = loose->base.odb->repo;
>  	struct strbuf buf = STRBUF_INIT;
> -	char *path;
>  	FILE *fp;
> -	int ret = -1;
> -
> -	if (!should_use_loose_object_map(repo))
> -		return 0;
> -
> -	if (!loose->map)
> -		loose_object_map_init(&loose->map);
> -	if (!loose->cache) {
> -		ALLOC_ARRAY(loose->cache, 1);
> -		oidtree_init(loose->cache);
> -	}
> -
> -	insert_loose_map(loose, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
> -	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
> -	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);

Okay, all of this stays in `loose_object_map_load()` further down.

> +	int ret;
>  
> -	path = xstrfmt("%s/loose-object-idx", loose->base.path);
>  	fp = fopen(path, "rb");
>  	if (!fp) {
> -		free(path);
> -		return 0;
> +		if (errno == ENOENT)
> +			return 0;
> +		return -1;
>  	}
>  
> -	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
> -		goto err;
> +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
> +		ret = -1;
> +		goto out;
> +	}

Ideally we'd of course print an error message telling the user what's
happened. But we didn't before either, so this is fine as-is.

>  	while (!strbuf_getline_lf(&buf, fp)) {
>  		const char *p;
>  		struct object_id oid, compat_oid;
>  		if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
>  		    *p++ != ' ' ||
>  		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
> -		    p != buf.buf + buf.len)
> -			goto err;
> -		insert_loose_map(loose, &oid, &compat_oid);
> +		    p != buf.buf + buf.len) {
> +			ret = -1;
> +			goto out;
> +		}
> +		insert_loose_map(map, cache, &oid, &compat_oid);
>  	}
>  
>  	ret = ferror(fp) ? -1 : 0;
> -err:
> -	fclose(fp);
> +
> +out:
>  	strbuf_release(&buf);
> +	fclose(fp);
> +
> +	return ret;
> +}
> +
> +int loose_object_map_load(struct odb_source_loose *loose)
> +{
> +	struct repository *repo = loose->base.odb->repo;
> +	char *path;
> +	int ret;
> +
> +	if (!should_use_loose_object_map(repo))
> +		return 0;
> +
> +	if (!loose->map)
> +		loose_object_map_init(&loose->map);
> +	if (!loose->cache) {
> +		ALLOC_ARRAY(loose->cache, 1);
> +		oidtree_init(loose->cache);
> +	}
> +
> +	insert_loose_map(loose->map, loose->cache, repo->hash_algo->empty_tree,
> +			 repo->compat_hash_algo->empty_tree);
> +	insert_loose_map(loose->map, loose->cache, repo->hash_algo->empty_blob,
> +			 repo->compat_hash_algo->empty_blob);
> +	insert_loose_map(loose->map, loose->cache, repo->hash_algo->null_oid,
> +			 repo->compat_hash_algo->null_oid);
> +
> +	path = xstrfmt("%s/loose-object-idx", loose->base.path);
> +	ret = loose_object_map_read(repo, path, loose->map, loose->cache);
> +
>  	free(path);
>  	return ret;
>  }

Right, and this here is the original function that we had with the
remaining bits that are specific to the source.

Patrick
