Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C228F948
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550089; cv=none; b=Wxy9sRawzAmrvxoBF34GWZz4/uF/FXf+Zq0pI5VdMrYtYMPCyx38fQJKwsEL7ee++kDeT+9znd6P+jwwwJBrYYm08BkHxB94ZJO6Vw7MpHodXenWu7zqD3MOQO5ZcWcHMwD8GoypegQlz2dIG1m9p9WUBOn+wZlkpK2SM5hIu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550089; c=relaxed/simple;
	bh=Jr6lXakWWDEGyP+PM/ceqXhx6cXswhCw8dEdYRCgqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAQuf43TzdArIUM/4WdtSLReCPAligO1Z/rLqpKTJBDFVhSG5xEd6HMmJYu1AfOtIDUVMuUxlqbAl527jireMcerXGyhk5auyFBooEbfCjYtWD6WOaJuTp4QCNACKSsQsxvafTJoxHsbpV6W0KdlNjovJYH7kX3qPgT7/g+36+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GX0KjScs; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GX0KjScs"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-651b4d09141so5123119d50.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778550087; x=1779154887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nC/guMnY9Ksw6rdkVcsoslD/9hunaFEcr/kKae5Mug=;
        b=GX0KjScs9HktwaiKwEoo6/O/ExUYff7nSvMyLxI0YzWJc8oGz9EyJd40vGgHvNnhyv
         fj4y4cTfVRSjUapvehBTgFon++csuk9dZTiZhgxxM4MJRYBW+G3JeJp5/AmhDjSaZzjE
         UYy0EU0ix9FCeQFInimom+mJDrRr8EbQ2g0pwz7T6hA+EeomBXolUPxJ5i0jb1u6b+Li
         rqt9VILNHAwB9j8sTSlWeO10d3BBuulTaDcqkEqWQH0WvwNsnW7z/Yk2b9u+Tg74wu8A
         1wvFRA7+UAO4aoYp97lEVQtsfOK20ZvxuqOZ9eqPAkVt1CrCVipLt1dryQG79zjA6OU2
         7+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550087; x=1779154887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nC/guMnY9Ksw6rdkVcsoslD/9hunaFEcr/kKae5Mug=;
        b=S5Lse8i6IHqD+Z/BJpGHpca0crhZONECIv0W+pptnB+3KBFxqfa7zjpGrDGO6SJffX
         ErvX4E9TM08irSibHNM1lpL9/P/6vZiqgWuF58LQ1KX2nEYtyddWSWArzQSOqWCg+BAB
         KNDVLL2aPfXhSf/9VKclXlT8OSEFJx0GrWzs/Ru/nMSRM6VB+4nwkRWF+7y7gVi4Nez1
         +cqcmzkT7FwUceFZ7x9PzpJQnXLYU7kLfLGpT6FJ93oKcm51wrK6RM5qKpR3MD231ozj
         teiThYRF1wiNbN9PLdbfaRkQ8mlo+gS4YhnZFdwCZrmtGlngEKeqPlaKKSECm6HgOS80
         vZ0A==
X-Gm-Message-State: AOJu0Yz8G4Z9gf6kYti6b1X6e1e7HFqd7bTDJzvAY7RmoidHuDbYfI2k
	NwwrttRNicGJHeFHRm7ipiidOWTWcQxKarOXvuB1/YUWi5jswPdXTmN63DBSwRX8BHU=
X-Gm-Gg: Acq92OHXAuBthjunJOhqrMgx0/nzG6QBw7deZnDlXwclUMDGnBsoCpH4nXE1EWB4q6d
	Unw2seDZ0Z0Wy8ywseaxQbDlPhVv8XM6Kilq+KXy+WR7GZrenyHPTRQnLlvDbowFg3uhH+fQ7UV
	zBCBWormLenh8gm1OGGKNT8pc7Bu42UP0s5iiOdb/985x+4Q2oqs47AKpe97juxzXL5oCsCEASP
	gOy5aScnZnZdnkwpQ+bxuviww5v6vltQkUU9ZMQSARu++4GVchWviT4LdKSC+e4oZUURPVhh0j/
	ni7J9s7TXy7H8jkTQF16bbqmX9hZYXhi9p6tqrX6tHq2LBln5K/K21tFizfEMO7Dj06C1tnwO9w
	ar0aVXVMQ8PYDX+wm5zYYEudmghM8CwYrcnAQvT0voWRP9VYw5TTnw4JCAnvOADDCDx+VS3uUdI
	EhIECKW0dmOybCYuvgu8MQYVWNaRhJJ0TRWNOzsKqQEXKA+4Rpfsn2xN7jgVzZgRT6i82Q1FqL5
	PBV0BzY9rUWZZECNQHP3hZNYBW4DfHum2QHyrWhuS5h3QnVmlAz7HIsKjg1x5pjmUEjRtkerChk
	kZrcPInYHY+n29iO
X-Received: by 2002:a05:690e:4293:20b0:65c:27dc:4a64 with SMTP id 956f58d0204a3-65ddd38689dmr1381998d50.3.1778550087255;
        Mon, 11 May 2026 18:41:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96a67a9bsm6146937d50.9.2026.05.11.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:41:26 -0700 (PDT)
Date: Mon, 11 May 2026 21:41:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 10/12] path-walk: support `tree:0` filter
Message-ID: <agKFRV4TjInVOCaO@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <c9efff0ea8d72d2d084957e1b099801b8d8727f3.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9efff0ea8d72d2d084957e1b099801b8d8727f3.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:07PM +0000, Taylor Blau via GitGitGadget wrote:
> @@ -534,6 +545,18 @@ static int setup_pending_objects(struct path_walk_info *info,
>  			free(tagged_blobs);
>  		}
>  	}
> +	if (tagged_trees) {
> +		if (tagged_trees->oids.nr) {
> +			const char *tagged_tree_path = "/tagged-trees";
> +			tagged_trees->type = OBJ_TREE;
> +			tagged_trees->maybe_interesting = 1;
> +			strmap_put(&ctx->paths_to_lists, tagged_tree_path, tagged_trees);
> +			push_to_stack(ctx, tagged_tree_path);
> +		} else {
> +			oid_array_clear(&tagged_trees->oids);
> +			free(tagged_trees);
> +		}
> +	}
>  	if (tags) {
>  		if (tags->oids.nr) {
>  			const char *tag_path = "/tags";

It looks like there is some prior art here for enumerating a sentinel
path for "/tags", but I am curious why we did the same for
directly-listed trees in the presence of --filter=tree:0.

Thanks,
Taylor
