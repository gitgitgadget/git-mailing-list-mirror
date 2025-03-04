Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FF1D63F8
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114208; cv=none; b=lluX40KDwpn9Nqz6KhRs2EtvZx44DTIko9KBb1Wm9iEH9RoAk7jgjJVuWQq9ERuVqssYxP2F6AXCXvz0nwJFucQPeq5kK6sRtbtU2qQCDpVPopBrPXhV+hA6/SIIp5qZPGj7y1e2SFyuiagx7sQGTdZuJZuT1C3WbvGXeGYyee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114208; c=relaxed/simple;
	bh=pWpDScFFIFw93QFZk/SUWVBDimunUvCeFkw2PcGk2xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH/IrG2rBpdVD1sickRYpV5ugg/4Y6n1wniH0upYV34S5O96g1fXPrG4j5jFrCiyJNMA97b3JK/FYW0fBoTwA+1gVVW/Km7khHtx6E4k9c5GDKQnnqGNB9wTNc5gQo/HMloR9ac/gZAcaILj2t3FxTDd5c05HZusFf+tP8KclmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WraYDmnz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WraYDmnz"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72726025fa5so1428401a34.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741114206; x=1741719006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWZGIPC7bVd8t+dWOrsjYcoNUjJ/G3vC3MrpkiJZRdQ=;
        b=WraYDmnzf9PtmG+Z3eWnfzoumq0WdJ1T3tLvCmtXzUjCphwGtVmi8a09oiLycyUM3g
         ivLZlYFAW2jl57DHdDfMkbgw+uQqe6Y6uVNdcrSB4TeiAj5dFZWr4qzDrcWD/TMyjyFk
         yDcDUvYwtuvLEBtqQ2OXDqV+USy8QdWRxhu6eisYvpBilvj4FWP3gtZXSTqRDHVVdooE
         8GCGYQlb1iiBmTpgN25pPnuntQenoDjyFoYwjI2xuKV6OyZQfjPD6GbC1QoF9f5mWwyc
         qaKuBXUuGwc27stffOZVKHAwSM1+0/DDlRsut5NMu9BtjzkN2B5GKbxT3G2Yt8TSnFpF
         JIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114206; x=1741719006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWZGIPC7bVd8t+dWOrsjYcoNUjJ/G3vC3MrpkiJZRdQ=;
        b=bptgiv4BC5jNYs4TXqhvx4sjcVX2+s/SWLvAgVNAnFwx/FbB8/Ozvre4Kn+qph38tv
         OFDwiFFrRLcUds7uhWIlHqgH+ICK5F7t9mpzEYdqPOa4N6vI+gfy50asJZpxwtYjEDs0
         5Cgc+5SGMME7GpOiuQHoxSFQoO2nkh6PdVbgGcYzYpevPFctM4jaXxlYsGFAjVIw58lK
         fRkQnrnV9f23SOmSjIp/Bge1N8fnMqU/PUvZG1FZqKoeckheQU7l4vMU89ZxV+IG/CBD
         OtVmMitvzqJlQJudVPvPmPF9lQhVjs8prxBkEL/4709qKKnuqIDGA8j1U7txMu9Sgdwh
         wolg==
X-Gm-Message-State: AOJu0YzIzGBqyUnPbgJpx+eJJS7au90zdps9App26DTMmKzvIarziNcE
	tejCe7UHvBFvjG34DebA7gRhDyMnYQkOrhGECTipCosa5uJ/3bL+cFaLyg==
X-Gm-Gg: ASbGncuQctQUcIlbuEoNxCvLV9zk+WLqOFaaFu2iizejS+42BQaCs46iJ/Xwhmwyl1r
	rfHoliJB+MunpQJ+rUggWgLkQAq/8q/pevdR2NruGb2I8JoZ2DjrBxAKM9nMaIFzHBSWPsqeg8A
	oznPqgL65DPPAx+SVCgkr0YZ7owfE7Pg9TS0H6P2A1R/M+khkxdkAh2+U6twnRb5VQ3ANiuOpLM
	vRzEo7jWJ+zE4dA/ALGyvKzUlnqsc08CEQTo47DXHLTMpDD0Xy9bL4tf9XfN7tKSoR2Hu1UUEyV
	WTWTc2xk1TnlSDJO4k7Ljq/B1rHv6uSJecuJzQ==
X-Google-Smtp-Source: AGHT+IElrbRnunwPKvqQsq81fNoRAZxdaXDrKjGq26+htNkm9ge24dqJklYaglHhSk0hqL24JAHaEA==
X-Received: by 2002:a05:6870:c90a:b0:29e:362b:2162 with SMTP id 586e51a60fabf-2c21caf6838mr123722fac.20.1741114205839;
        Tue, 04 Mar 2025 10:50:05 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c15c446de9sm2378424fac.46.2025.03.04.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:50:04 -0800 (PST)
Date: Tue, 4 Mar 2025 12:46:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/12] pack-write: stop depending on `the_repository` and
 `the_hash_algo`
Message-ID: <hqhlqyonijhjovsop3s3bqv2hjkfp2pde6h4r4jzlcrcreygvf@k53cld26eqs3>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-3-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-3-c5dd43f2476e@pks.im>

On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> There are a couple of functions in "pack-write.c" that implicitly depend
> on `the_repository` or `the_hash_algo`. Remove this dependency by
> injecting the repository via a parameter and adapt callers accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/pack.h b/pack.h
> index 9f1194ac13d..5d4393eaffe 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -87,7 +87,7 @@ struct progress;
>  /* Note, the data argument could be NULL if object type is blob */
>  typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
>  
> -const char *write_idx_file(const struct git_hash_algo *hash_algo,
> +const char *write_idx_file(struct repository *repo,
>  			   const char *index_name,
>  			   struct pack_idx_entry **objects,
>  			   int nr_objects,
> @@ -106,13 +106,13 @@ struct ref;
>  
>  void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
>  
> -char *write_rev_file(const struct git_hash_algo *hash_algo,
> +char *write_rev_file(struct repository *repo,
>  		     const char *rev_name,
>  		     struct pack_idx_entry **objects,
>  		     uint32_t nr_objects,
>  		     const unsigned char *hash,
>  		     unsigned flags);
> -char *write_rev_file_order(const struct git_hash_algo *hash_algo,
> +char *write_rev_file_order(struct repository *repo,

These couple of functions were already injecting git_hash_algo, but
still depended on the_repostiory. By instead injecting repository
directly, we get both.

Makes sense.

>  			   const char *rev_name,
>  			   uint32_t *pack_order,
>  			   uint32_t nr_objects,
> @@ -134,8 +134,9 @@ int read_pack_header(int fd, struct pack_header *);
>  
>  struct packing_data;
>  
> -struct hashfile *create_tmp_packfile(char **pack_tmp_name);
> -void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
> +struct hashfile *create_tmp_packfile(struct repository *repo,
> +				     char **pack_tmp_name);
> +void stage_tmp_packfiles(struct repository *repo,
>  			 struct strbuf *name_buffer,
>  			 const char *pack_tmp_name,
>  			 struct pack_idx_entry **written_list,
> 
> -- 
> 2.49.0.rc0.375.gae4b89d849.dirty
> 
> 
