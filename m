Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E4143722
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943665; cv=none; b=tOUmfQonQAeJz3X4p3WG3/fS1dnevcSOrsQ/ZFW632uwACmuL5Xoz+Xo1LvklZJ3rhsROshHiN6wOjzIzGVWAp6yAfFc9lc4JL+y0W/PnUNUzxS4+G3a2KKUP/sHE0Rg5BAUOj0+Vmls3iRvCA9lsosAOzQxWl4yWxFP4/4sEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943665; c=relaxed/simple;
	bh=BB2+6hQTiBqfW1/a9z/qUsWujXhQ8A0dXpUinSPKi/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUp1yrDMkA+hB3xDSMT3MejOMn4tw/PzZZbhuuAuTG8B7vNWw5MsL13JP6o7Clkl0YdOx5SZfYR9jis1kzlXJtWNy7egkOH04FqP/NwaUjUhBAR2nWrdVH7K3A+0zj8wbXn4NQ8KUwGyTH3EdcMiCIx7gXJMzwOUWS+hOBQplXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1T01ZAFr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1T01ZAFr"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b120428a3cso248741685a.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943662; x=1729548462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+7QB+03yLvGBYJG/8Jb2UUb7sb1grL/S2LuKLwB9G8=;
        b=1T01ZAFrQ3b2M2t5bq/70P3cKlzoY+m7JkmLwIhXjdNFROMCBT1JaC7wT37sxNdZnc
         WII9spd7uZtdjCZbJGqsXIoRl3HIR5SiqHcy4eHK768AGmbbWaTEy3ktVvUHRinipjXM
         Yq5g4+6eKPbESb0YJbHegzGstDczS2Ww8mgnz1X3KTCSk9wFqqeGpyjJaDx6EYqugME0
         Dm7nhfresA720uEEsYIvJyD3cxYZnFULq6fvp/GegAX44SbZ2NNOVba6BoCWvjDNoYAF
         Y4ykPKV4q/iEzX8SWj6xBRz1sk2pG5ebBbo6bChZKgRmTxvW5N4onwtrN/s2U7uZmrVj
         KQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943662; x=1729548462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+7QB+03yLvGBYJG/8Jb2UUb7sb1grL/S2LuKLwB9G8=;
        b=VdfZ7MDn2Q6GFqUCvGww76NIMSmpAkH9JJLerIZnB5dH7N4Y7+aM/m08HoglonR7GK
         vm0PtoLOA2YRQ1BAl+4udrIpKgDpJVPYjtxH1s1y14+gseskK2ABU2M9dhDvnn+fBalk
         RFcBk/X8RzShh54Z4VK0mT+olgoFC+hgv4O1AhpJN0BGgFBApjXIzzwQ6TzQ9yFlWmWi
         ZnwfZOMqU+9JRUzN3Hd5ouRZ/XEhDLBYlOy+lW6O+d/bby0JK/F5g6iXrDoNpN1wtilm
         gQmWuLyD/CmtsygG6pfjHRe43vINhyFneL96l60v1mqRyierIxpNeWwlgBIYwZK7EZcj
         lKdA==
X-Gm-Message-State: AOJu0YwIt9880hRl2b7iHN0G1hfHlVoC0SYimi/OG9N7L5LhqL2WdVdI
	H/FsOAbiFFqGrWd4HzFMP16e1OqJNW+QbjF49/gZwrgPn6lKHkCe7j36DZl8FGzu3XuujliZUuT
	M
X-Google-Smtp-Source: AGHT+IGrbPZzijeLGPJOCUm9BOBf26CVCPCK0c2mO78TL3iTLm/buzgr4gNWRIli0J2uh0mZHAG2Gg==
X-Received: by 2002:a05:620a:2496:b0:7a9:aef5:e5b6 with SMTP id af79cd13be357-7b11a3a74bemr1674938885a.41.1728943662287;
        Mon, 14 Oct 2024 15:07:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13639a509sm391585a.92.2024.10.14.15.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:07:41 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:07:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <Zw2WLC0h65LkbMCN@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <f5700647839a21b5aed0d2dc45e65bed36ddd392.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5700647839a21b5aed0d2dc45e65bed36ddd392.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:20PM +0200, Patrick Steinhardt wrote:
> In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
> point to a test-specific directory. This is done by using "$PWD/gpghome"
> as value, where "$PWD" is the current test's trash directory.
>
> This is broken for MinGW though because "$PWD" will use Windows-style
> paths that contain drive letters. What we really want in this context is
> a Unix-style path, which we can get by using `$(pwd)` instead. It is
> somewhat puzzling that nobody ever hit this issue, but it may easily be
> that nobody ever tests on Windows with GnuPG installed, which would make
> us skip those tests.

Heh. I am sure that the story of finding such a failure was probably an
interesting one as a result ;-).

> Adapt the code accordingly to fix tests using this library.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-gpg.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index add11e88fc0..3845b6ac449 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -6,7 +6,7 @@
>  #   executed in an eval'ed subshell that changes the working directory to a
>  #   temporary one.
>
> -GNUPGHOME="$PWD/gpghome"
> +GNUPGHOME="$(pwd)/gpghome"

Makes sense. Thanks for finding and fixing.

Thanks,
Taylor
