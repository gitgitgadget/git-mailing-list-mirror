Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25D155A4E
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563528; cv=none; b=Tha9yKIdSyflBGL1qex+ppn2FUtui8YhcQp05MpYJz5TlHXVYQcGidAiagH+LNXgiTTVe+nvJACtWZTmlZlBylZeaLVcM3CitV/2fTjtzNXM82LRzySklFjv4v9O/tsZsewUnBXh1WLXz2tqTWWmqP9jTDV5pK/VztIt8OEHt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563528; c=relaxed/simple;
	bh=vpO9vYuOZm2+iyNuMbSjQeFmv6MnQKUIYMMhxRU1MmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+uff+Fdm7DePXJI1VLSjFSLNjIuc0NpC8aYVNHHvD2o4KyN/8Xhwq1tECNrJLD/b4PQzXBySSkWejAKA1odoATcQdubuyNWSBzeo5WHR2FzkJUE8NOzGxGQMZ9ZsQyEs8DHII8GdGA00D6CR4j+42xxVDZpLVIK47OZVdgnhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aBfuhvgK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aBfuhvgK"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82aac438539so124768739f.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726563526; x=1727168326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHF8gr+Oih4ioRafGEBJ+lZ6ZoMod8d5bJTXIKyv5IU=;
        b=aBfuhvgK4MGvHbBVUKg7ZU0c4gOP8ok0LE+dGW+3G6/WhPgbBcYfTgqcNxautcFEhN
         gKAvTkBvwv5OPNtj7ylFQzvRrBc5heO4xOebJEnMAuqHjVwpDN8ZxSYFmWqmHnhkQms6
         NnimkmyPlHh/CW8uJp+31mI1BxoTI8q1eVlLrMqLaGl3kcswB4K0V/0z/5MNjao7OJqW
         dcPYd5lMm1WFaAW6Xr7bkSc8OHeK/tUaHbrrM75l9qEkQ9wy8mS/9XQKXjtCpW7jDMC8
         SEMPihh+laoPemrlbM8LTEElWNWvsMRQmAte8PSZWbNjd+gpU2W11VmD0yzzSaDd4gsS
         royA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726563526; x=1727168326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHF8gr+Oih4ioRafGEBJ+lZ6ZoMod8d5bJTXIKyv5IU=;
        b=jdzkuJkpkxpJpLEhmL0DJlKgInv/ZWEN6EvYBTfHg970xcOZq1mneLKm3orosfZATX
         yPPduP+iQLHtg7uWVBp5vQKgqQlzTQm/yG2fjU9Kd7kD5Vm9eMRxxcoOr49gAGW1EHER
         qkeHsybNJ7LpZJTdZNrFXGm5k++LMIJO9S8mLkiC+RAKbzNnJvHZ/+jIJDNEitm3Sa50
         YRSxUUC8GM2QmvT19C16y2a3bKwLM87jjqh/JEfsTzP18seBq79ocgYvpvhSyghBKrIl
         0QEDOxJrey6IwPuK+Vx5GGttdqIYsSLFLZN8W6mZa8OLrXzkRiyDDlKDGpOn4LGJVWDe
         rclw==
X-Gm-Message-State: AOJu0YwB8wLt+r2GfVFKL1HQ10uRUm/XWTySXGakfbXsH1JgOXHDwJN+
	d4fKuGe8+H4o9Uj5mLyCN+EW9z1YNGl7WCs04bcwz+VVYsE4RPptPC9M/OVzpQ5nsMO9KvFBBqs
	RPxR4zA==
X-Google-Smtp-Source: AGHT+IF+BU5cWbwVkuu3fl9XiP8KZiVj42S9duPOCK7hB1KN71mcUsU0PCsQH9YMXInifzdvfezddg==
X-Received: by 2002:a05:6e02:1c87:b0:3a0:90c7:f1b with SMTP id e9e14a558f8ab-3a090c7116bmr92135725ab.12.1726563526316;
        Tue, 17 Sep 2024 01:58:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e10b83sm21284605ab.31.2024.09.17.01.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:58:45 -0700 (PDT)
Date: Tue, 17 Sep 2024 04:58:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
Message-ID: <ZulEwjnNQet6th8w@nand.local>
References: <20240915111119.GA2017770@coredump.intra.peff.net>
 <20240915112024.GB2017851@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240915112024.GB2017851@coredump.intra.peff.net>

On Sun, Sep 15, 2024 at 07:20:24AM -0400, Jeff King wrote:
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 78e7394406..3f69675961 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -44,7 +44,7 @@ open_editor() {
>  mode_diff() {
>  	git diff --no-prefix --relative "$@" |
>  	perl -ne '
> -	if (m{^\+\+\+ (.*)}) { $file = $1; next }
> +	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }

I was surprised to not see you use `--diff-filter` here, but I think
that that makes sense. You only would want to exclude deletions, since
that would be the only time the post-image is /dev/null AFAICT.

But I guess that would make it impossible to do "git jump diff
--diff-filter", which may be useful in some cases. TBH, I have almost
never used --diff-filter myself, so I'm not sure how common that is.

In any event, this seems to be quite a reasonable implementation to me.

Thanks,
Taylor
