Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53360EC5
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951994; cv=none; b=ut/ZI7DYxtWD9emJTRwXAU5zqQ/3pbQ+8k3VCkh04qUS7Le0xOVYb2r5fQLCORtHNdzZoJ2gMHaLoQK3eeJSZ+yKNes4w4w586lL74NwiBYjxKYtL4/iPi3RIRjusyDAt1gSIxRxOZudgcM0H9+wISLMRxvBlnpr8uyQZaDnufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951994; c=relaxed/simple;
	bh=8VOaiqnU3BWo6fwItxDRM6MhuujnXZXCsXVZfgl81/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5/BrcrQaTNGUd1CrtJY3yN/R+wxE5oaTfKocLvnqCDdt+0rmplguJAOfvs0RgY7+OYSOsnUaPf8mBABVBfxRkQ526uyGgi2PrJv32w72ZgEYKOVhInCGpMj/J9F8fYPhwNLe/tGJ3CHVoFYRCbmqkLHP5e03cLN03LqioFd/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BQ04enI9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BQ04enI9"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e29028f3926so4333588276.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728951991; x=1729556791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8VOaiqnU3BWo6fwItxDRM6MhuujnXZXCsXVZfgl81/s=;
        b=BQ04enI9/eELKovCU6jxutcmQK6qI1pWQALiBhKpzh47N+7wPPrRkky+7r8D9WRVP+
         YUGPNbAW8a2/x9/BIXVAIm/4iEAbSlzx0SBGbkV5yie+vrT7M3JCO/3PELH6Sm6Z5+i6
         hkSFDnmDvW8qjqfJe7zGm6mAC7NnWFy4G1H1x9mn2yqvlgPqJLCFhhedqz0yJclAxFOI
         W+23aW3n17IGhqhWPlQcpOGvPhuTXJuaf6xfM7+7ZGfE/uBLJHaWrILfdtFlFyBM14Oh
         umYCXtO8QjEtTVXw9/xAyuhIZwKkwn6HB6+AQr2Lr925tDi4YNwRdRZ7d+DeKEfHNvih
         DDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728951991; x=1729556791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VOaiqnU3BWo6fwItxDRM6MhuujnXZXCsXVZfgl81/s=;
        b=j3qZj0ZEZse1zIF8a7wcs2WZ3i0FOCG3P+JLQm4YIvDwowmHIWY+77Dz9vaBGqbNEJ
         whU0x/PF6x6WQAryk1v1ngha4VurQz/JK18vnKknUp/xdjkwxIuoykbBztMci2/Ut/s3
         FfoLDCOOJswLzmIILcJcvE2jHErQWcR3uXzs3+AuIg5JizveJPFXVnkOzss/DmxP04Og
         fwg+Ianpt6u1t4k5vkGCQL0YupRQBt6WEjDExRBflEReCFW1FPB/RMHuqr/WOwu5RyDj
         okUQh0K26GuLM4j0PHvExV2hAkkPXV4Iv8R1WSVfqcVC5F8ipla9gxXqJfOq3haBAkWM
         qI9Q==
X-Gm-Message-State: AOJu0YyE9P3aWlLTaEBE5lL6H/PjaFxSl1giLDzu5CjBMMy+4lE+l9gJ
	CcC4BRgIQ5W4jpT6oZtqUSL2MQ5l+ry/XuCvwQ3GPT/FRtMih77UQ1rgeQb5lqE=
X-Google-Smtp-Source: AGHT+IF2z3Yp9MxGx5lxtsr0tChGAzSzSlZ41cNKFwc7TzKgKz3sP5qbJrMo0SwIDe7d7eV/rZCYKw==
X-Received: by 2002:a25:ed0e:0:b0:e29:6f36:b59d with SMTP id 3f1490d57ef6-e296f36b6c6mr48323276.16.1728951991290;
        Mon, 14 Oct 2024 17:26:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d050b61sm39812276.42.2024.10.14.17.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:26:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:26:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: David Gstir <david@sigma-star.at>
Cc: git@vger.kernel.org, Richard Weinberger <richard@sigma-star.at>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Jeff King <peff@peff.net>
Subject: Re: git grep does not find all occurrences on macOS
Message-ID: <Zw22sTxyWCbczZy8@nand.local>
References: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>

On Mon, Oct 14, 2024 at 03:34:02PM +0200, David Gstir wrote:
> Hi!
>
> I encountered rather subtle issue on in git 2.47.0 on macOS 14.7 (installed from Homebrew):
>
> git grep will not find all occurrences of string patterns containing a “.” under some
> conditions. In my case I have an ISO-8859 encoded text file which contains umlauts.
> If the string I’m grepping for occurs after a non-ASCII character in this file, git grep
> will not find it.
>
> I’ve put up a reproducer here https://github.com/iokill/repro-git-grep-issue, but the gist
> of it is "git grep quz.baz" on the ISO-8859-encoded file below will not return anything,
> when it should return the line "quz.baz=3":

Interesting. I have a macOS system, but don't build Git on it regularly
enough to test.

I CC'd some other active contributors who have recently touched grep.c,
perhaps they may have a better insight into what is going on here.

Thanks,
Taylor
