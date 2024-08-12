Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321917C7D9
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471691; cv=none; b=ukSK/eI6zJtFryVa0NI6yT2SSL+UA5HxGl2QVAOkkUB0UEVil742KCHY0UMG49AydK1PxAEAVc1QHUQIagESp23Y3Vj+3zAL2NxNEQKcQoi09y/vQiqrHcMgSTaChnFyru/1MFoyxo9IoS33IvLoK6DHECMYgU2iqqbZCrGRudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471691; c=relaxed/simple;
	bh=RdA6E5J6J1ogVC4ZwzoWQk9EWc6LrAawCW+wx9zj0HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ9lYtlZZwxIN1pgIV7QBZTTt8Ye6wQRnXppnTJu2dqn6IwZ/R5Sx/ycAwfcmllmkBd0w/khghc8sxxdnIj03Y1RyATbBl1VVdDuetDSvgZrT2uPCkquQt41U87S7i6+XEB9vZroKS+hYcBLdu/KjIEiHz7yz5KPP8lawKUyOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Hey+IDlT; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hey+IDlT"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0e88873825so4266065276.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723471688; x=1724076488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dO3G1r901vTs9d2ECpd3Ylhn66CM1vMT5fv+rC6zCHM=;
        b=Hey+IDlTaU0QILZWGc+7oAkPTuVu4Ddi3a9dQfpKFMyiQzWy6CP08FGZpF8crMh3z5
         kf9pyxRCVPuxwqsvT8FaI0q7/p+KGToisPZ7Vj2MLr8bA4zn0WmuK5Clbp82/AMDVAkH
         V7EaxobgGhtxF5txEWwDI2IuuEo/DK1lYN808yS8As2ZYrtqM3s5Y3SxfyEGKIwYSkcD
         z+SsoGzRiR0GIT+YVGjcTVEUmUN+tUBQiwEDcUe0J6DCBD19MSx/+VnDAdKn+NaiNbW+
         eOLnakAvAAiEs9tT6R8l6I9mtAH/z8TPIiq0AFzzBYXxc0MV5x9mEgnxa0jEQyqQXRxF
         mMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723471688; x=1724076488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO3G1r901vTs9d2ECpd3Ylhn66CM1vMT5fv+rC6zCHM=;
        b=PSxWRSJYOv+ZdxqL0Cvu0AgUImRXQtI62hg63bRn5gxklqAj0b+64usbv3ImAzyQD0
         t0eEaYlNMjd064GqRd9gahmALo8NQVOByKIo7Gx+EIHX5d1id8smQvEHx6dor0QflIYT
         aRu4YQEg7binDvuSJdnU1ZJ+mIMZl5NrQerc0aJZAUeWHazCtzg89rCGUg7SjRg8e/97
         OYATM5UZdd/oqaU14zj4viOQK590Ra8KPJ1hV0SSNdOq4zPEAfhbCzSPhRD0D8omEhit
         fA8l0goktm27zWxK/o3HWeZWAq/ox/eLKq2Gw/x6X3I7hCbPxQYQ6Wxv8KmN06u4WVOe
         r4IQ==
X-Gm-Message-State: AOJu0YxwWUYSrAKyGK82LSIWMtpKlW3UD45xXMRg1bDYl4zPB39qWMby
	UpUqLbS0bxWbhWm6mHopLEJpm5OPP+A+RezwMMpeQlPza+dVWQuUCZBG/eD44+qdWjZ0jquNx3f
	c
X-Google-Smtp-Source: AGHT+IEykH5K1DLNSYLxA9E9BFwV78caH3YkJDsk69w9zMooLfwLF/OoUeefKKCSLy2cClh42tO9Og==
X-Received: by 2002:a05:6902:e0a:b0:e0b:d6aa:43e3 with SMTP id 3f1490d57ef6-e113cea4a38mr477602276.17.1723471688161;
        Mon, 12 Aug 2024 07:08:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8c78a21sm1148320276.50.2024.08.12.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:08:07 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:08:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <ZroXRQX5ieXCmpD9@nand.local>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>

On Thu, Aug 08, 2024 at 03:04:33PM +0200, Patrick Steinhardt wrote:
> When we have a `url.*.insteadOf` configuration, then we end up aliasing
> URLs when populating remotes. One place where this happens is in
> `alias_all_urls()`, where we loop through all remotes and then alias
> each of their URLs. The actual aliasing logic is then contained in
> `alias_url()`, which returns an allocated string that contains the new
> URL. This URL replaces the old URL that we have in the strvec that
> contanis all remote URLs.
>
> We replace the remote URLs via `strvec_replace()`, which does not hand
> over ownership of the new string to the vector. Still, we didn't free
> the aliased URL and thus have a memory leak here. Fix it by freeing the
> aliased string.

Thanks for the detailed explanation here.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  remote.c                 | 2 ++
>  t/t0210-trace2-normal.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index f43cf5e7a4..3b898edd23 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -499,6 +499,7 @@ static void alias_all_urls(struct remote_state *remote_state)
>  			if (alias)
>  				strvec_replace(&remote_state->remotes[i]->pushurl,
>  					       j, alias);
> +			free(alias);
>  		}
>  		add_pushurl_aliases = remote_state->remotes[i]->pushurl.nr == 0;
>  		for (j = 0; j < remote_state->remotes[i]->url.nr; j++) {
> @@ -512,6 +513,7 @@ static void alias_all_urls(struct remote_state *remote_state)
>  			if (alias)
>  				strvec_replace(&remote_state->remotes[i]->url,
>  					       j, alias);
> +			free(alias);
>  		}
>  	}
>  }

These both make sense to me, since alias_url() allocates the string it
returns via xstrfmt(), so having the caller free it makes sense.

I was wondering if there was a nice way to neaten up these two call
paths that both call alias_url(), check for NULL, call strbuf_replace(),
and then free the result. But I think the result here would be pretty
awkward from my attempts at it, so I think this patch looks good as-is.

Thanks,
Taylor
