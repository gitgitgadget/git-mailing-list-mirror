Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564E4734C6
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269650; cv=none; b=FNbszvNULSjvuNkn7vgkNqpv1F1E36opEt9Z8xiPcXv7pc5h0Kqm9mRrmt8RjSpphnRzp5/hSFzhyrVa9Xqq4tVLqPwFdQX7qds0B8uzh6zVtdYy+jANvZ1/nSTeJdo34J0r82EB+HklxjoRnZoynu/gDRuoeK7pc9qIOE3jy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269650; c=relaxed/simple;
	bh=jqUooDpwGfwelryQDW7CnVRPxx3kdni3qWPiiAR9b74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0dQRilf2LP0raPdeo4saeKq8ShBDFIefq1uIcg8DduZk9AIremT7ilFQ3SY/9bwBfQBrnAyajSXkSnIvL1KfUTJrI/8tfA+TlUVVDdF30x1d3G4eG6Sp7vNKAuzpVKd/2QN9udSvG8chYaxJyVm5t1DNtd+rKQSyBFM1WSu66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHkMpQUX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHkMpQUX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso270480a34.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785269648; x=1785874448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x0oITKhX3swAivYE2Rtr4T+hjRrfwRG59qZoxgd4OE4=;
        b=gHkMpQUXU+gt4BoedNYmr1d2N2F34IhBvy8O9Qgzu8fCb6qBZo2FDYs+4sNH+/MBX9
         HTAt9G4g51o3+8z+RD1zayh2g/fO40FeI0scqc8eIvLQRrbeMMFkDdrhhUEMe4WcAnRm
         YQkbjVbGKj21ZcH5K4JM1zVeV4yiUDCn02eSOWMY96uLiDeGwYxBaka2Po/534ShpNcS
         lh3r0TSZxVHTCocBDQYPz/qgDNSsk6vKcVazNn+yOCFYo+quMILwuqtdUuPW1Gf8Nzhc
         b/sRuW6SPLkMLPC3G3FCB/LAPHEkyr36l4jry3Xo44kmCQOUE7MHwAZ3cXSLjHKAkyvB
         QX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269648; x=1785874448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0oITKhX3swAivYE2Rtr4T+hjRrfwRG59qZoxgd4OE4=;
        b=N7gOpWze/Mmm/4TX7Cu4uOQ298PiGOrIF4TbycP5crc09EMluDsllhnz0Y9A8jX5hJ
         etLBm921akHCh01y+dIM06mj9ipFPUrRIF2v4icch0XQxRcIhdFHUu/0xc0Jp6Tt6axA
         mdBWnaDpfLfT2Si2dEEqUEBX1Xk/oKRbpuVj21i5AvU8PVSaOj4/LjBuRvBRx5SB37eG
         F4WGhiHNIyA0YoM10gQFLCYxhsgqMecJOAz7Yxv5w8joFQsI9QbkkMMNcznM+dAMEeim
         unrJV4H3x1DftDXRMq8FZhZBBZX8sUJbPVCyxJ6NL0oFxexJXpzesILIvrHvx3ITD3rt
         thMw==
X-Gm-Message-State: AOJu0YyNeP5vifSrfZm5cz2vjOjoytoO0UviWux/GelQ7+HBeMu4hqnS
	bOt0KZXIUdobsZAAfJADiIrjalzNPe0vwdaT85l1mHwVU6NPTmZPPGE4JWIasA==
X-Gm-Gg: AR+sD13NVWX/H6UVvffnV5131jQz4YXhMUCgd2/XWnYJ0OGjeD9aWFsoFy5tIzGvRfq
	y8WMu+mBvJ3V8TWZmigc4Rxm0PSj6vbNzJPp2ROifDTKls6a98isTsOQu7f/jnpVkZKNNOoh67f
	dYL8K1i65Z79LpnY4FZcLDa+v3yTuCD4JiUw1XyxxUzQhfi83l9mxYk9gujQ/QS/WY3LYwxqxwW
	1FH8dUuwoDGoeDIzd9NKL+PGmjhWtBPI+PBKPcsvi5V+NhUy0x3DWj/pNB1HuveJRuttuO2OBKv
	8KusNWehURoVFGJ6EWF/VOcb44bCdaMYyKHBZ4uh+CFp1lEzN+dQWW97Y1tPC+cGVHbXK3mu7bS
	bMbNpFRatYvQOf8l5kkjgfFf8K88X4STJKfXAsaeHwc7rhWk7ZPV4xtaribBOqFvz/wMtn5s=
X-Received: by 2002:a05:6820:208a:b0:6a1:7c3e:f62a with SMTP id 006d021491bc7-6ac96a4ec81mr1735483eaf.12.1785269648013;
        Tue, 28 Jul 2026 13:14:08 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d5f3aebsm582065a34.9.2026.07.28.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:14:07 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:14:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] loose: load loose object map for the correct source
Message-ID: <amkMipjGA_7cwpOR@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>

On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> When loading the loose object map via `load_one_loose_object_map()` we
> pass in both a repository and the corresponding source. We ultimately
> don't really respect the passed-in source though as we instead always
> load the map via the common directory. This doesn't make any sense
> though, as the function is called in a loop through all sources, and as
> such the expectation is that we'll load the map that belongs to the
> given source.
> 
> Fix this bug by instead loading the map via the loose source's path.

IIUC the primary source is always being used, does this mean that
repositories using a compat hash and alternates are currently broken?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  loose.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/loose.c b/loose.c
> index bf01d3e42d..9dad75373b 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -61,9 +61,11 @@ static int insert_loose_map(struct odb_source_loose *loose,
>  	return inserted;
>  }
>  
> -static int load_one_loose_object_map(struct repository *repo, struct odb_source_loose *loose)
> +static int load_one_loose_object_map(struct odb_source_loose *loose)
>  {
> -	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
> +	struct repository *repo = loose->base.odb->repo;

Ok, we really only need the repository to know the hash algo, but we can
get this from the loose source.

> +	struct strbuf buf = STRBUF_INIT;
> +	char *path;
>  	FILE *fp;
>  	int ret = -1;
>  
> @@ -78,10 +80,10 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
>  	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
>  
> -	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
> -	fp = fopen(path.buf, "rb");
> +	path = xstrfmt("%s/loose-object-idx", loose->base.path);

Now we use the correct path per source. Looks good.

-Justin
