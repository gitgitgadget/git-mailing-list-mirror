Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85A149DE8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997214; cv=none; b=L2uqReoQmj36FBVJqn78PCPiAO7RFYDNq7R+CTXsCsmPvNeKrpAvbN8opRX/jMb/o+ounEndFQcydp2UmzzrijjhcjcV4uReIXsbd0p77vsb1CFCYzd1CUioH9nJgFEQcyAbYSO3m0uVfLj0xwQWbxx0k7s6dwBuajN9kIgcxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997214; c=relaxed/simple;
	bh=ACF1rT4GttKbrTX3i2q1ASwM92SJTPO5BIm1FI6kUkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBkOqGXhHuclyvROR7Yqi2+tN/hsYEI3HqHPl5doM69zn59XkIf4WC3Q4/nQ0E8P4IPvyxcxTFidhxsd9tURycw6MLEuIlXMA4hmRnsc28pwEILo2dCXd2AqWWGKIXgQmKvzGh385GiuBF6D70LAvy9LLde6SPypisG3/7LFjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9isQLRY; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9isQLRY"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb9de518e2so2312889b6e.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737997212; x=1738602012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfOk6dqSMBKWRJ392zVH1iMxErLwX3oIzB4XEan9/aU=;
        b=W9isQLRYCRfHmoL4AoUSReBTogeWMyOs+FwiGOzyfEWWp2gA/du+1Ef/c/cHakqEcr
         cf0ZjX2v9VXz+uzdlzQLOHgTAkJahGz4pqlEjlhtiyEIPMaeEj8Gpc36Ez7SG/KF4VqR
         wnheYkfnub7ZfW74GOmv/XmeiVxPFHGCplb3Kfoh36RiI1deZh+W39Rv6B98ZECOyr0Z
         RiDNFQef6SAOf0JHJkF398HK5xCAn4Vc2cBUcEaGROpMgiKIfSsWJnard22tOw8InCds
         WYq8WH5oHT5le1VZlvHmli3Sup+spKq8qq8Fuh1rm8pI0/Eofv4HLkGhDdvSi7doceOC
         7ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997212; x=1738602012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfOk6dqSMBKWRJ392zVH1iMxErLwX3oIzB4XEan9/aU=;
        b=KcWCQjd44FBX+bOqEQrqK7RwIeXymPmJBlFpgoKiPkOLYIsHOh5uc6q5XhYK/1oJZL
         SDLAuluDhcSyRzzECT3ZViHd9yRif+f0pWVXQ7myWAGlG69HLNPU5gPZgZK18ZRbBqVl
         T5KF9zberRAPMd7YQoKNS6hAf8ulJA8au8AWO35yxn+Tysv+LlUpD8tR6a6Ys4n+uvwO
         ntIeLeblGox/4eXjiIUco/HmuJGFI1TsJcbpX+JAJdgQ+dLogUOmpfs0Njxr91CzwqR7
         q5/Z1w+q2z6/AK/axHHIJxipoT86jWxjvczybY9s+EqcxHX5W6vG76CYkNdd1lbOYEYc
         6Dsg==
X-Gm-Message-State: AOJu0YzODWqOGxS+xSxmwpdvVzsUanG3bsPOgLccEA7j0LYYYszE+wKR
	Mm9kTdQaE84nvExAY2DRty5xcpDFXVFROIhzblo8Qzbs2mkuQ2C+MmL5Ag==
X-Gm-Gg: ASbGnct5oRJYdJ/DM0s3GRVIAeiVhJWm7CK7Q/XAauQPKjgo4XYF2sRNpg/Cakqu3KY
	+K6fmOGzQoJp5N8QefaiL1QApL3B1L7qLWF+OxZS6GExITEDJDtxGcb3H10hyGVcvnL7SXLJhkd
	20DJMbGEKekv0c47jq5oJCnPEeWqxPki2YMb1NCK7z+t9AAs/mnWbdhfA1vU+7rr5gv5WRILsox
	bG6S7w8B58crSXrO8oZF5+I0kaph1eZQsQMM8DGPY+hU1B4CdTK5kzsICit/DVOZ2dJW2JFNg==
X-Google-Smtp-Source: AGHT+IE29rv01CsMA8wX6jYQ5k4ViF/cgmLOIAsUqO1P+Tg47McjGzEywtC3qjSb/3SrLYvE72Yr7A==
X-Received: by 2002:a05:6808:2445:b0:3eb:575d:5063 with SMTP id 5614622812f47-3f19fc95875mr22986013b6e.23.1737997212203;
        Mon, 27 Jan 2025 09:00:12 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f098111asm2411537b6e.32.2025.01.27.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:00:11 -0800 (PST)
Date: Mon, 27 Jan 2025 10:57:20 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 01/19] reftable/stack: stop using `read_in_full()`
Message-ID: <u7hbqd6at3owgka4pitd4vgzc5emgipnx3w4dat5ofpiv5hxxo@lbfj36uhqtsr>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>

On 25/01/27 02:04PM, Patrick Steinhardt wrote:
> There is a single callsite of `read_in_full()` in the reftable library.
> Open-code the function to reduce our dependency on the Git library.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index f7c1845e15..9490366795 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
>  
>  static int fd_read_lines(int fd, char ***namesp)
>  {
> -	off_t size = lseek(fd, 0, SEEK_END);
>  	char *buf = NULL;
>  	int err = 0;
> +	off_t size;
> +
> +	size = lseek(fd, 0, SEEK_END);
>  	if (size < 0) {
>  		err = REFTABLE_IO_ERROR;
>  		goto done;
>  	}
> +
>  	err = lseek(fd, 0, SEEK_SET);
>  	if (err < 0) {
>  		err = REFTABLE_IO_ERROR;
> @@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
>  		goto done;
>  	}
>  
> -	if (read_in_full(fd, buf, size) != size) {
> -		err = REFTABLE_IO_ERROR;
> -		goto done;
> +	for (size_t total_read = 0; total_read < (size_t) size; ) {

The cast from off_t -> size_t matches the currect behavior, but is it
always safe to do this? In `git-compat-util.h` it looks like we have
`xsize_t()` to safely handle these conversions. Since this series is
moving away from `git-compat-util.h` should ideally something similar be
implemented?

> +		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
> +		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))

The error handling here for EAGAIN doesn't go as far as what `xread()`
does via `handle_nonblock()`. In this scenario is that ok?

> +			continue;
> +		if (bytes_read < 0 || !bytes_read) {
> +			err = REFTABLE_IO_ERROR;
> +			goto done;
> +		}
> +
> +		total_read += bytes_read;
>  	}
>  	buf[size] = 0;
>  
> 
> -- 
> 2.48.1.362.g079036d154.dirty
> 
> 
