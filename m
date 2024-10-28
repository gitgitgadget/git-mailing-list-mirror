Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FB15C3
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074825; cv=none; b=CZ/B0b3ZNOlnwIsgxSJRJQ1B5GOe36Dm5x5aoLLGlXMmnHf7FH+NJXvsTvby9I+oNTaSmjGJyJ6yvKTpEcB/rAP69/qGIAmlaTnqXZ9wnk1Vr4LdbOmdGAzkK4uPLB5SAfBywb3XD1+NuRB6/aNq6vmTGErZWmiuklQ3IJKGiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074825; c=relaxed/simple;
	bh=V7XLyHJd5p1aOaRLkqTAgI6WcBkhO6WJWSv9S29cqL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhyz9dm5JYwsPyYbCSxO3ejI9AND5lnWTth/KEMjpuPShuJwZJz/Myi2e/FReaFoXHKLvjEoCDGp78iZY8udl9Xx1yJ6woxSCI+lZ8yULTZmakKcaSx8vUjLtm1d1yAVlnxZTO7U8p082NhNvEFTO4SIajlsK+cxhI3j/mgTTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kLsPy2bc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kLsPy2bc"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e29327636f3so3907742276.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730074822; x=1730679622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XLyHJd5p1aOaRLkqTAgI6WcBkhO6WJWSv9S29cqL4=;
        b=kLsPy2bcQcoSKqlJ2vxGQMluPBEX36qA+tFosJGh6BWOK7cX56D7R1X4oaC0hCKitE
         LwxFpCqyml1KUO8HBpBqyGrgBydcTjE6N5icweNtXdlUH1kNpfP6PX5OpX+qHp5EbbPf
         HXMlAOFHG7T2zV+/HMAUAplOqj65hrQDtqKP4jxuB/yPkRGwI8nvx25rgbYTD3qFeufi
         Dp9HbTsn6jr5j2K3gZ4J/J/VZPfmty8WjtHDJG/5Q2vGq2VE1duc6XWi7NPAYcXjCcv/
         CJyPFlCf4lnGZ5SX5aHlhTFs7kKEeEp2HUsCHwnHTIJ4M11rDACB87tDUNBgasMhW4kY
         kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074822; x=1730679622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7XLyHJd5p1aOaRLkqTAgI6WcBkhO6WJWSv9S29cqL4=;
        b=BGh/+ynF6hdYv9jq7zJUvGS0ujZTtqYIbi6whD0ozePbsENMBuHdJ88fbvh54ovP0T
         o9uIAAVgiEgDR/+y1BeyANjyotk88sUIx+qcNTNdMUoqaM3rhfHiJevfRoJYK11J7q+8
         DGjXTT0Unxh4ZX3nieHylT/s6YrEXiRGd9yqUEVdL+q090j9MjH63uj2CefBf47O0NTZ
         4dmXEj4Bkm0CtMuP8d5ek6zFLKINi9f1TX7PFbGbjrYn6NLT2cPeseYzariH4Sw22Xk/
         +QjcNyNtTWIvf/53DciPPw4mTZF5b2dMaPTqTeo9s9Iu51TDE7nP3zn76QgEQvf30Khq
         w2LQ==
X-Gm-Message-State: AOJu0YzL//UuqFxSkjxO3SjsTaf+SaSmvlJ3Sn4zEec2zTkCnczAymjE
	3152q+fxaAD0bns9lr6MzpxQIm5wxQIf6QkD8FTjP/4GR8jizrp4HsTH10ZAmTQ=
X-Google-Smtp-Source: AGHT+IH3tCI+D0yqD7J8d+y8rcQzL3/iXR9mD4wKZ7T/guRPR1sUikAKaGfY7QDaSr42Bhg1fYLQqQ==
X-Received: by 2002:a05:690c:4a0d:b0:6e3:6b73:be66 with SMTP id 00721157ae682-6e9d89e1674mr62347897b3.27.1730074822639;
        Sun, 27 Oct 2024 17:20:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6caefc0sm11989007b3.142.2024.10.27.17.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:20:22 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:20:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/2] worktree: add `relativeWorktrees` extension
Message-ID: <Zx7YxLPItxvFJK62@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025-wt_relative_options-v1-2-c3005df76bf9@pm.me>

On Fri, Oct 25, 2024 at 10:29:47PM +0000, Caleb White wrote:
> A new extension, `relativeWorktrees`, is added to indicate that at least
> one worktree in the repository has been linked with relative paths. This
> extension is automatically set when a worktree is created or repaired
> using the `--relative-paths` option, or when the
> `worktree.useRelativePaths` config is set to `true`.

This approach feels like a very heavy hammer. I wonder if writing
worktrees with relative paths by default was too aggressive of a step,
and if we should instead make the new behavior opt-in rather than
opt-out.

Saying that new worktrees are written with relative paths, and that
creating a worktree with a new version of Git breaks reading the
repository on older versions feels very unsatisfying to me.

> The `relativeWorktrees` extension ensures older Git versions do not
> attempt to automatically prune worktrees with relative paths, as they
> would not not recognize the paths as being valid.

This is the piece of information that I was missing in the earlier round
when I merged that down. I think we need to take a step back and think
about how to make this change safely in a way that doesn't break
compatibility with older versions of Git.

Thanks,
Taylor
