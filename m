Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CB17BED0
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731353; cv=none; b=qSxSl9hPiU8Blu7teJdd6j8D2juPRqCYRd4NzC9qmPBmoiGztzBhsAexNFcHcGh9nYd+YRyEK3ouLJPER9rilVoK35FLBUJ4MoGQ4nn9PLiu4nHjNquSUfUWkjfFJmkJsWKP3tXQJrc0J3GmPsp9kx7RYqhZks4LjYi/bCrpis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731353; c=relaxed/simple;
	bh=U2MjY8862YxdE6eeHDH5P1N8mn4/x28JTdSsKJY3Hg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrVNc+onsnyNbgzXuEvOj/foqW35BhjSUFkJYNem1Z1bOaC46orKcEhFLnEee6RzGgr0JkmFjbBh1lU0G6tJ6y+34Ebo7z7BBXH/wZ9AXa/UjUrgVKsPZdNAy0IpInDRjHd3jymblCF9QFhcA8ckUbOMDidIXOcjokiAgL/u/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ebaumX/3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ebaumX/3"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25cb262769so4282849276.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727731350; x=1728336150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELcRQBQ45taR40fTeTn4csLIww/l0L1N5oWkgnSY6Rs=;
        b=ebaumX/3Rd9aSisXG+fNs9loMI8Ain1GmMaUTBOKizSn9g3z7VDKF5Uk9bvNt3Exv5
         gfRHUSRp58aRdgnkscYjLk9MMJ+UjwZ4rAxKvBuSij6v8sueFsZLy6MJef7dalP0tx9V
         JYUkVneKNRPgjGOY6CbSj+yV0r+uPrLTvlW4DkDO0905LpLStwsV4lDGctkBBMcUGCNe
         aJxOo+Xfa9rDmyR6uInzBDRXf+HCqPZyOJQUITbcJSsu6MxYBVbFarFSLRnLqnMHQOjA
         GPX+OARym4SQbN9NanX99bXvevb94OKIJjRWkCXYCWLvVs0tsR9rhg7S0fItxaqte1V5
         z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727731350; x=1728336150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELcRQBQ45taR40fTeTn4csLIww/l0L1N5oWkgnSY6Rs=;
        b=l2qZgYLSp8U5XXJJccuabeV+w7Kby3jSNOwQpnHSGrxje8H2EUX2JAZktkXx+Qq818
         xdEltJGiEuOs1oVx03nRp/jPVhDAouD4SbJehY9xERMsXaXQKiR3BDAUd8MgizDZr0NC
         keNLDoUp8WlgWRdZGhwuXGOFyf6C9h1NyS8UYzuxWee+h6BpA1czeaxg+/TFjUU2LiVQ
         qWQKCu1InqbXnnDPHKlg5/N04rsQBCbyfnOeAgJ1TqIFvGtNHE/Lwt92tqC6loiCbxMp
         n4hE7gpM/OZuyTUA0wwH69pzxDGLixc1J5w0a89NcgHwOmErupne5AtZZZjUEHzSA932
         1dxw==
X-Gm-Message-State: AOJu0YxXEU90MlAitkbbP2BhPis2q5ZPzXE15gPRjbu0/ZmcrkQ7CiUN
	TDC7Cca0PjGgUgsaYF3/Rs4vDh8o30kzJe/H6UmSn/jR+ds18tHqxf/IZIIQ5yMrFgabfHspC+z
	bfow=
X-Google-Smtp-Source: AGHT+IHscAUXhQyOyb9Ttea1A9fSfwZOFApDlG9T6Yop/jrYEinmCqNWiC6ad2uW4MArblZEqgwWXA==
X-Received: by 2002:a05:6902:1501:b0:e16:6aba:f3d with SMTP id 3f1490d57ef6-e2604b14f8fmr11755338276.8.1727731349986;
        Mon, 30 Sep 2024 14:22:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e638be8csm2593948276.41.2024.09.30.14.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:22:29 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:22:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/23] pseudo-merge: fix leaking strmap keys
Message-ID: <ZvsWlNPGxt5AOQcK@nand.local>
References: <cover.1727687410.git.ps@pks.im>
 <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>

On Mon, Sep 30, 2024 at 11:13:53AM +0200, Patrick Steinhardt wrote:
> When creating a new pseudo-merge group we collect a set of matchnig

s/matchnig/matching/

> commits and put them into a string map. This strmap is initialized such
> that it does not allocate its keys, and instead we try to pass ownership
> of the keys to it via `strmap_put()`. This isn't how it works though:
> the strmap will never try to release these keys, and consequently they
> end up leaking.
>
> Fix this leak by initializing the strmap as duplicating its keys and not
> trying to hand over ownership.

Hmm. I think I am probably splitting hairs, since a few xstrdup() calls
between friends is unlikely to matter here, but... ;-)

It does seem wasteful if we can avoid it. We already allocated heap
space for the matches via the underlying strbuf, and we really do want
to hand ownership over if we can.

Would doing something like this on top of your previous patch do the
trick?

--- >8 ---
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 28782a31c6..6b6605d3dc 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -110,6 +110,7 @@ void pseudo_merge_group_release(struct pseudo_merge_group *group)
 		free(matches->stable);
 		free(matches->unstable);
 		free(matches);
+		free((char*)e->key);
 	}
 	strmap_clear(&group->matches, 0);
--- 8< ---

That introduces an ugly const-cast, but I think it's tolerable (and may
be moreso with a comment explaining why it's safe).

> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 28782a31c6..bb59965ed2 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -87,7 +87,7 @@ static void pseudo_merge_group_init(struct pseudo_merge_group *group)
>  {
>  	memset(group, 0, sizeof(struct pseudo_merge_group));
>
> -	strmap_init_with_options(&group->matches, NULL, 0);
> +	strmap_init_with_options(&group->matches, NULL, 1);
>
>  	group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
>  	group->max_merges = DEFAULT_PSEUDO_MERGE_MAX_MERGES;
> @@ -275,7 +275,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  		matches = strmap_get(&group->matches, group_name.buf);
>  		if (!matches) {
>  			matches = xcalloc(1, sizeof(*matches));
> -			strmap_put(&group->matches, strbuf_detach(&group_name, NULL),
> +			strmap_put(&group->matches, group_name.buf,
>  				   matches);
>  		}

Otherwise, I think what's written here looks good to me.

Thanks,
Taylor
