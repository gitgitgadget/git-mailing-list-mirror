Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE740D590
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782710722; cv=none; b=k674WAaUn03v3GM56U5cjvciFlvqAiW2b+wNkniG95nGSi8YNLSyoqQPQ4/tDRAq5/msRsqQJGjhQbtEsFoDcvCk9JrD3H2x0UpRhOtHt9Pq/i6uhtFbPb5V4pPR4qqK8US1gxrQtIUFraN8KenoEQfvyFO7VCAkDL3d8uAGL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782710722; c=relaxed/simple;
	bh=SQx4FY6G8/xcedylUhAk10Jc/7fG87UZHj9/d56FigI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu9/BWHv4BIexvocMjAS+/KUr0cYbnXq4RheqyCc8nARypDGwR6XHSgxB0/w+gcMQ9DwViGY36fub1WPpbp7nyYuBWEKIVBm9wxOKnv1N/hX39OQwXEgcF9lZ9mk6nJNvaLbgjry7Mf7HBdodPzy/mPoVEa798GFctC4uW5RDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od9T/8rh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od9T/8rh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1332658f8f.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782710719; x=1783315519; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TzW0biys1rorOKxUDOSxX6i/IpFvZKIHME6GIja9Zdw=;
        b=Od9T/8rhOxB9fAHW2iUeDrKDRUpE+WADWJltv7L2pC9Y5T5G60uBRPxp/jQO36nygQ
         AF/zCaG1oFa/RGFd8R8ldThYyVwTaExxUfkK8B2uEhZgYlIBYtpHnGYm2q3OD4qhmieU
         GEE4wy2la8d5QKMTqCNfP+TqsfE366phGSZBj6jT+RUyrq1MqOuewyoJ/8tkxYYKuI7I
         9LDlLY4zQna4flpbhSATk3J09epYpaAkKpUhMgciLTWIocyWSYzun1CoAT1GDho9dTjE
         HN/eYamDqzSFFUcphgVQAe75+kfw0v8jD7CnsFGBG+Aa+GtEN3dM4Bm/vMY1Z5gj63o/
         H5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782710719; x=1783315519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzW0biys1rorOKxUDOSxX6i/IpFvZKIHME6GIja9Zdw=;
        b=tZdyM/U0eCSRw7bPWZW3bbGRDA1/4cOVJPTeArWyzM5XANz7w/hI5leabNVVY9a9Q+
         pZowpvqRl9iFhMM38y9ZtG25KqGOcQolq59V6r8AuOeigCag0lCMcNbOX+zNXlb1wH6J
         Mghv+efP+NZozfDqMbOUtukzvT+JC62a11JoYgmjzdMKd5QUT4UZGUnV/qxeIB/m217v
         /u8RPgsTmwdzOgt6b69uDiYgIbXvummNMMi+nR5NFQytM2HoYG/jF9M2jp4/RrBkpg5N
         meTdF5MsB8hre7tK53X8SXz6COzpbeFmRbm3OyGOJw4zWW7sb/3Wa3pKTcglCkXckuev
         b/tg==
X-Gm-Message-State: AOJu0YzMcYYLRDomyURNM0NFUGPkY0xJDaxIb3iJ2gesjb7v7H9IHzJy
	cM5N/ah8wL412b08zL4gMqHxCq96FsQUrHscgNytVY7hznxvXEdaDLAk
X-Gm-Gg: AfdE7clQLz21tb2XkQTnmvp9d3catNh7iXPaC/RbBRwDgiPq9RDaZK4NwDWJT6RjY+O
	lErQB3MhuQGxt2R3CxJaTC2PQwEOwpefyZDLHFnNFTe2t/6Hj7+1VHyjNu1yCMvgSryYorN13mv
	liSbMw1N840SMtDtC0rGFHgkPmtQrrqYLaZAfgWXgnJV8ko1agmkrrwQJMV1xHHCKqU5g4+NiCx
	q/QrMIdEbHfm7cDC14ciw9uZNu9Sn2WB+XwK3GmsJ0U+J58A9bmykMJZoOLFWVjQeMSB47rwgVu
	je9qpKNQtwKsogpgLPISrNuzsKIwob9aCGNooLAJ04gga/hCMRCN68Qt8u3KRniCMo4nLFWJNh0
	WWTAD8eHeFhFYLMXEA9tFWQYL6y7nbfeL4kE6YOae48D0E/Sur+W0EaxqTaQQg90mWuEtxi79jK
	FzHqvF+gl/Ww7e+l9PmUkF0AkA9TUaYi4hqopffAZ9yaU5tCCLg1UZuoU=
X-Received: by 2002:a05:6000:2903:b0:472:55a:ef89 with SMTP id ffacd0b85a97d-472055af37amr8791986f8f.27.1782710719384;
        Sun, 28 Jun 2026 22:25:19 -0700 (PDT)
Received: from localhost (92-249-246-182.pool.digikabel.hu. [92.249.246.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f978dc0a9sm23059978f8f.15.2026.06.28.22.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 22:25:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 07:25:17 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 6/8] commit-reach: remove unused nonstale_queue dedup
 wrappers
Message-ID: <akIBvWT7nIWntCNT@szeder.dev>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
 <4db485b48aae810eeba28ea4feb47401ab352e88.1782649547.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4db485b48aae810eeba28ea4feb47401ab352e88.1782649547.git.gitgitgadget@gmail.com>

On Sun, Jun 28, 2026 at 12:25:44PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
> unused after the previous commit. The core nonstale_queue functions
> remain in use by ahead_behind().

Please squash this patch into the previous one.  Since the last
callers of these static functions went away in that commit, it can't
be built with DEVELOPER=1:

  commit-reach.c:91:23: warning: ‘nonstale_queue_get_dedup’ defined but not used [-Wunused-function]
     91 | static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
        |                       ^~~~~~~~~~~~~~~~~~~~~~~~
  commit-reach.c:82:13: warning: ‘nonstale_queue_put_dedup’ defined but not used [-Wunused-function]
     82 | static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
        |             ^~~~~~~~~~~~~~~~~~~~~~~~

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-reach.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index 9ae306f60c..176ffd68d0 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -79,24 +79,6 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
>  	queue->max_nonstale = NULL;
>  }
>  
> -static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
> -				     struct commit *c)
> -{
> -	if (c->object.flags & ENQUEUED)
> -		return;
> -	c->object.flags |= ENQUEUED;
> -	nonstale_queue_put(queue, c);
> -}
> -
> -static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
> -{
> -	struct commit *commit = nonstale_queue_get(queue);
> -
> -	if (commit)
> -		commit->object.flags &= ~ENQUEUED;
> -	return commit;
> -}
> -
>  /*
>   * Priority queue with per-side commit counters for paint_down_to_common().
>   * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
> -- 
> gitgitgadget
> 
