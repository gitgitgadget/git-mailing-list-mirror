Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320D376
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580210; cv=none; b=Zu4yIWhtG6U1DXGCV1n8FprO3wGc9/8zE9R8KfG4dnqFpjHLOwL53l7cxkA1mFYhxQ4yp4hOwA99hUBlNNzdtdPPwQsyOnNAlkOf6yTP7QWlHzBtjK+Gwp88XXRUjidgOgsc6qLiSMTdpWMnvBcECJAFp1zoo+P3awQz3RUMqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580210; c=relaxed/simple;
	bh=pfqY0Tz1jHBr16FAJ/fiy3+3gk4aCL/jWV/R2SYKQQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IUctd/SEeR1DBiS46tTcymVwQgzMJDM1dnp3uDAgjNccPQW9IMU52avjT5L2nJ3b4B5Q4gUkk03EN5UvyF6bbuslq+wKmQDU0+SBv1ZhWYbg07QQw5cB0Mn+KQCjnZMsvuyU9nXxOSKCMVZ5djZUbwICSrvxe40AOX1AImT6qqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aronnaqv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aronnaqv"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70907505121so27649187b3.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746580207; x=1747185007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2e9wjmf9VnHeaBoj4IgOL/NedmN3szTk9IRz/HaYUB0=;
        b=aronnaqvRlw0WxWqZRU9/xiLa3nveL3WbGr/xmGwYgQy1QHikclxd4J6gBDf3Mth+8
         sxBsQfRTq1ZQrjFxUYHaSzEAlnDsv7+17hmlepfcM/W/sv+BC2yTm2JGsEhPF9c3eyWn
         YJ7AG8+2tvadCF8qpSSkC6+vX9UAGLgpTglxoX0QGx+gCFtx7jwb3sffgGZMDtrfE15w
         a93vJ66Nzqv+gZY6cyc77od6cQyajsfJsjzmKDqJ7v6HFdLj61HiK/AJLjdmtWQOr8/x
         R89Sp/G/IVBoxpbS48rMRBB9pu9cjs9eD7f/4tl4NxMOccUp53R3WhPmIDnzV4ZNtDSO
         XziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580207; x=1747185007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e9wjmf9VnHeaBoj4IgOL/NedmN3szTk9IRz/HaYUB0=;
        b=Pj6Cck7x/O1aMDZDoXC9+9qX+LA6WAOFPiSRTyKqISt65I7wbkjpqlFVMM29hL4qEd
         Mulm6g9O4nHCNuNRMlZquk6kJ3Bans9vvJTvPlSkncQ4ud0OJ9Pw6RNk62zHNhEGFTUi
         pm+V3FTBZGKHIzUY2ig4CUz0w8PhGBZ2n6tm4KuWhCtMy2E4zq3raL8U1Y4ZXF76avXF
         RYy7gSdLno4xLEJ2X/9n3Nk/WOKGhzqqb+D6Sk92YOBrfZ6BQuEfQyu3DOKhh29v2x4Y
         n8q+VEsYTkMfKvTD/67b3WfFPCK2rz3MKRV8sPihTPxGdn0c/WwTTCqOuUvq+DcgJMhU
         ylWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsir24Qybo0a2+w5lktme7Tn0CjPUQg+XMsSSN9U9kPYcqaLlpnA9SgppzH0B2eDThccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwprBiDCNJV9gE7qeh2/nFcTT8X0k6zsxanWeg5DUwVXnoKjGr8
	/sQiNRq4bVjwsKukU7WExgqkzZpWjADdBqQMD3/gc87Sr27RrUC4XVRhPA==
X-Gm-Gg: ASbGncvIYr7sil4izuRDTVgso+/rzK1CF7hQnbtf7MZpbhdJkF4ew/OAtiXzqCow/bF
	nIAFCHGE3eHYsnFAa+FzgKUGObRXJ575zViojr7hApBetFr1brbF4vOWJ9fhZI1Va6cf9ghXEUw
	lLASNV0Ai2cguh4wRMkzpUyWBxbE3va4f8JttTVCDo4HMxL7tM8tj7JxrbFwsXnHc68TVfM31If
	4I9dg2i6uV78qdUBdolowOSthMxWsMoMZRIuU2SlBBtHcmoQgpvB5UZp+Wph1kxGZSHot1rpv5r
	GXDStfOEINfmMR9usRlq5YICEDa4narmCqWey2NBdmfhjte9MKsOv4x4+8ojHIaA7EI7wq39bT9
	DzmplfKWkeVE7RvOwvnA7orAzCsmq
X-Google-Smtp-Source: AGHT+IFOhMRi5HUz5lCkUEgvcyZoOWIgUek9KsHOXPZbQ9NEYlhYCe1RD4DULn8l6VwiNMjBj7bsIg==
X-Received: by 2002:a05:690c:6085:b0:702:5689:356e with SMTP id 00721157ae682-70a1d9f4fa0mr23483097b3.12.1746580207250;
        Tue, 06 May 2025 18:10:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a1e923029sm1611157b3.8.2025.05.06.18.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:10:06 -0700 (PDT)
Message-ID: <d731678d-bda2-474d-81e8-39da85bd9038@gmail.com>
Date: Tue, 6 May 2025 21:10:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] odb: get rid of `the_repository` in `find_odb()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-5-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-5-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 0a184d39720..28550d3bcc9 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
>   			struct repository *repo UNUSED)
>   {
>   	struct commit_graph *graph = NULL;
> -	struct odb_backend *odb = NULL;
> +	struct odb_backend *backend = NULL;

nit: this looks like a misplaced variable rename that should be in
an earlier patch.

> @@ -101,9 +101,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
>   	if (opts.progress)
>   		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>   
> -	odb = find_odb(the_repository, opts.obj_dir);
> -	graph_name = get_commit_graph_filename(odb);
> -	chain_name = get_commit_graph_chain_filename(odb);
> +	backend = odb_find_backend(the_repository->objects, opts.obj_dir);
> +	graph_name = get_commit_graph_filename(backend);
> +	chain_name = get_commit_graph_chain_filename(backend);

I like how your use of specific backends here cleaans up a lot of
garbage around the --object-dir parameter of the commit-graph
builtin.

This is a real structural improvement that is made possible by
this refactoring.

> @@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
>   	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
>   	struct strbuf buf = STRBUF_INIT;
>   	struct oidset commits = OIDSET_INIT;
> -	struct odb_backend *odb = NULL;
> +	struct odb_backend *backend = NULL;

Here's another of those delayed renames.

> -struct odb_backend *find_odb(struct repository *r, const char *obj_dir)
> +struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir)

I was looking at this implementation and wondering why it wasn't
renamed earlier, but upon closer inspection I agree that the
rename is worthwhile _and_ the method shouldn't have been
changed until now.

>   {
> -	struct odb_backend *odb;
> +	struct odb_backend *backend;
>   	char *obj_dir_real = real_pathdup(obj_dir, 1);
>   	struct strbuf odb_path_real = STRBUF_INIT;
>   
> -	prepare_alt_odb(r);
> -	for (odb = r->objects->backends; odb; odb = odb->next) {
> -		strbuf_realpath(&odb_path_real, odb->path, 1);
> +	prepare_alt_odb(odb->repo);
This does make me wonder if we should be able to prepare the
alternates for a given odb without using an owning repo. Yes,
we'd need to assign the repo parent when creating new odbs, but
the info/alternates file is in the object dir.

Perhaps this is waiting for me in a later patch...

Thanks,
-Stolee

