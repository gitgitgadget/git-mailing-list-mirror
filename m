Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE91F80A0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019326; cv=none; b=tm84Zy0fgIMyCXN1QFGsCb6qKJ5cdetBgH8qN5iG/zMYuJnb6JKEzMizPlMUFrMQNDOCpDd8UJmGj2w3dlt+ybOq2rozq1XgDsLMuUHNQoekjzD5w0K9yB9fRkMMfTC2EwcVVDKhk7U+qBItmHTXGQ0tsbTqcVpMLig9SxnqwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019326; c=relaxed/simple;
	bh=5CIiXrVXJc6REPyo5h0PgdVkluRPl+QXfediZM9TdNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keIjHV1J8PefBp7tBtAr+nlesLVg0tqpZmneyEk6hzIPrdaokgZDfxuR3P8HDtHiwWCiDEXz7IvDf4/o28ZssWc1yIUbL3thUOOh9D8LJsy1tyRRb17jgPYEpxZ440+xfbQFbobvxte6rqiGjtkIkwahWqTZ59gtZsTTgBluR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WgrUfuDD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WgrUfuDD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7afc658810fso517158485a.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729019324; x=1729624124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9dx60BsXN3O31vH/ZDTeFh92YgYEvs3/i4S2vlYUx8=;
        b=WgrUfuDD7JbdX1XIEccexNwBYhxgYyTBnbGn4CogpicSj/5r1m4pEYqTa1ake8YCjG
         OwLF/78kxcEK28xcTSSBQaGKcR1q9gjBk/+fv6hQL9hu7DJL6cjcEfZZiKmrN/Uc1MG7
         P8mO01Zg1r7+qwLgiBnwCiWdUgmzOSEZuhlp0cZ6At4tA3/2/FDuz8GkqMEh0vX6wm+0
         ZdoB3Tbc5rU+yT7DnCQ6sAokqhePe159wDB3IPZmIjs2/ggtPUH8N6FerR2fxxhzsAl4
         bNJhR0/yoptgs3znagLxabR2AFUruF1qSTpVnaiO60B0sgtJyribUeV0sGswflwUJRbZ
         ZIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019324; x=1729624124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9dx60BsXN3O31vH/ZDTeFh92YgYEvs3/i4S2vlYUx8=;
        b=qoYq8oWefckO5ndDYD2XptDr/TtybS9CmL7uegcWEKxSQHed2/VUYji7eY5fejdDyj
         HQA0xa0RQdKkgp1NTDIkOodRjy5YOsjXiBM8vRUYgYfpXXi5voj9no7nQG/stgPcCw/V
         PVEFZc5h328RbzatrrY4jXs3gaX+g9J6KWInYbpk/3u76OekNcHRehvRkZxO72vqgNdg
         afcz8vlpRX8zt8c0UrCj5a1pv7T4yWnG/H29pA1J1yKs24M83+6ljtwvaJCnrvilJX01
         OrMRDYmsNSti34oHLWvDjHBxab2HxhOfumN4hEvJYZ2H61j/0BuYPx+1jK0Wm2ArAuv4
         YT0A==
X-Gm-Message-State: AOJu0Yx3RVXq/4yPDZ5zGlWlHwEGVmhq2MQmgcB1z+rOkn5B0x9h2WuD
	q1dVC7YmPg86+itH9hS0kZ9jVYULFNv5T3dDMbI1Pab9HeAZ0KBJFVs9DF6od94=
X-Google-Smtp-Source: AGHT+IENKKtzCfsPgfSijhkA02Y7Hio1NTnkaMVFG9Y6PSrJSrlMYYf2hp0fig+3bMkkKlrYOxTxmA==
X-Received: by 2002:a05:620a:1a03:b0:7a9:af5b:6921 with SMTP id af79cd13be357-7b1417c7993mr213665585a.21.1729019323884;
        Tue, 15 Oct 2024 12:08:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363c9ab4sm102502485a.126.2024.10.15.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:08:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:08:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Liu Zhongbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Liu Zhongbo <liuzhongbo.gg@gmail.com>,
	Liu Zhongbo <liuzhongbo.6666@bytedance.com>
Subject: Re: [PATCH] builtin/fetch: iterate symrefs instead of all when
 checking dangling refs
Message-ID: <Zw69unaf9JzPOA8i@nand.local>
References: <pull.1812.git.git.1728962878717.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1812.git.git.1728962878717.gitgitgadget@gmail.com>

On Tue, Oct 15, 2024 at 03:27:58AM +0000, Liu Zhongbo via GitGitGadget wrote:
> From: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
>
> refs_warn_dangling_symref() traverse all references to check if there are
> any dangling symbolic references. The complexity is
> O(number of deleted references * total number of references).
> It will take a lot of time if there are tens of thousands of branches in
> monorepo.
>
> So I first identified all the symbolic references, and then only traverse
> in these references. The complexity is
> O (number of deleted references * number of symbolic references).
>
> Due to the infrequent use of symbolic references, there will be significant
> performance improvements here. In my case, the prune_refs() time has been
> reduced from 20 seconds to 4 seconds.
>
> Signed-off-by: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
> ---
>     builtin/fetch: iterate symrefs instead of all refs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1812%2Flzb6666%2Fspeed_up_prune_refs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1812/lzb6666/speed_up_prune_refs-v1
> Pull-Request: https://github.com/git/git/pull/1812
>
>  builtin/fetch.c |  7 +++++--
>  refs.c          | 35 ++++++++++++++++++++++++++---------
>  refs.h          |  4 +++-
>  3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 80a64d0d269..ec4be60cfeb 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1412,15 +1412,18 @@ static int prune_refs(struct display_state *display_state,
>
>  	if (verbosity >= 0) {
>  		int summary_width = transport_summary_width(stale_refs);
> +	    struct string_list symrefs = STRING_LIST_INIT_NODUP;
> +	    refs_get_symrefs(get_main_ref_store(the_repository), &symrefs);

Without reading the contents of the patch below, there appear to be some
style issues here. It seems that the indentation here is incorrect, as
well as below throughout the patch.

Please make sure that the indentation is consistent with the rest of the
project's conventions which can be found in
Documentation/CodingGuidelines before re-submitting.

Thanks,
Taylor
