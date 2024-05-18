Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E879DE
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716059405; cv=none; b=PwfRGSFjkAxQ+2h+u5j2xvvLLIQJa6Zb4bxU7GZo7ZioFOhmvoIPAXupusS28MGDvwTy3YZWFY9u6se8e1ejx699e3WHCRu0O3Z8YCnbaJDG7D618liIgd/37rqrCDT6svR/39TWmmNatFII+r7QzVSDy6tze68rBZAs1fJPXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716059405; c=relaxed/simple;
	bh=T8Q9DUTcOQQHe2B7WHZECRJZ+xDl2Hd6W8D3FsJ2UwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dz1M0JFJbRmOgVjBWDlr8Xndg4qGhtiVwzYUoULpvjBsMsM7bxoRtiKXw+mbo7GDbFvZE0fvjBECudxBLZUzE2w+aLCVvyYsNtu1ER7bNPp9BSTFaQSJlJ+o9s7edlQWewW2m8z4i/CSWjfT73rV+6RNd6y2nMcjkJReZycZONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UysxB6Gy; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UysxB6Gy"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62027fcf9b1so8947397b3.0
        for <git@vger.kernel.org>; Sat, 18 May 2024 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716059402; x=1716664202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wZEtAjWlZgsDAcUG6+c2PeaLOPra/WqeJZPfXh1m/E=;
        b=UysxB6GyzceMmEV/F2gn2ET+arbACTtz+9W4lcGGFbsisM3pRHGzdtAwO/+af94H+l
         CDsGPQ9OvTquPfVPYzUd04U2ycyJFywGb121ohJIDycbJ2LvyIgcvWHB3Pp0EaFCuyA3
         hoLS3PjQ0HUB3xpTGrXdx5Ijg0Qxz54mmYlZdAUEh5QCYAz2HPC10fnPmKyRIjWKPB8G
         jijTmBOAifRcmGjCHSPOMbDc6P9/t1f66oR0QeoWmeZfITvtqele1F21TJ/F3x7h7BVO
         7iEP3vAVH3OWQK/t767yNZ43EQm45GoZQyfAKY0c5VVCHSD4FxbLh+O53peP82jgW2qA
         Xcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716059402; x=1716664202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wZEtAjWlZgsDAcUG6+c2PeaLOPra/WqeJZPfXh1m/E=;
        b=UYZa3f2Bkd3dosthddjhEToDvjJ76cXRr6/dWAp0NaJBNacaaafgRPPdXSOlsBowAZ
         TWQOrbbLTd+sRk31klyAd5N3kf7fPP/ox9abu+oP5zZBBE7avE/XGtpjNPfFXqqc+fJ7
         sp33+sBl1GstYFIXED4KGVefuza6kYcuTcUX96BwnrNpQ5SoLBaP9VhJIh3eO7/WdIyv
         zYcAfEXUwEq2m4nWK9D+NaYVw5T/DQPZoqbCgqUwMpZFDdK6Qpw+HjiN1XiqK7VIcaf3
         e+59x0ZU0u3K5xaz1ZXJBH7IA/CyOAdg5SGiTtmAl1GY1fk2zAHwFQu88gZ3ilHEgUkq
         rXDw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pnqN9Bk79m0lvY0ye5HPdZGVkHEp3t874/agEmQWEFtTBXDRy3DQPV8NQfB0dX17lCEnUOW/HYYsoea/ZnBfov7P
X-Gm-Message-State: AOJu0YzLmudRyYxi7q91wv7rqf3Qcy8QxegGcVpLQIY0m4X6y652RNJi
	MNYhk+V/Zn4VOfumY19XvVjXhEfiaaFBd/RUbP3d+PaXo8yqnmPX9JRVvTzwdac=
X-Google-Smtp-Source: AGHT+IG+nUeAgr9acBiK/1DbNb+mh7kbe9AVtqVJP9OFpLEKPvscYc//nNj/56tQBfg5x3aMM3DbEA==
X-Received: by 2002:a05:690c:6786:b0:618:498f:9dbe with SMTP id 00721157ae682-627971bcd9cmr13045587b3.10.1716059402639;
        Sat, 18 May 2024 12:10:02 -0700 (PDT)
Received: from ?IPV6:2603:6081:1e00:aaa2:6c3b:4f8f:100f:63d2? ([2603:6081:1e00:aaa2:6c3b:4f8f:100f:63d2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e5b0b4asm44350097b3.137.2024.05.18.12.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 12:10:02 -0700 (PDT)
Message-ID: <4c4049e9-f5fa-41c3-8a6a-df4fca2f07f1@gmail.com>
Date: Sat, 18 May 2024 15:10:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: document what --name-only shows
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqeda0jr7d.fsf@gitster.g>
Content-Language: en-US
From: Nathan Faulkner <natedogith1@gmail.com>
In-Reply-To: <xmqqeda0jr7d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7d73e976d9..0c456dfd0c 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -318,12 +318,13 @@ explained for the configuration variable `core.quotePath` (see
>   linkgit:git-config[1]).
>   
>   --name-only::
> -	Show only names of changed files. The file names are often encoded in UTF-8.
> +	Show only the name of each changed file in the post-image tree.
> +	The file names are often encoded in UTF-8.
>   	For more information see the discussion about encoding in the linkgit:git-log[1]
>   	manual page.
>   
>   --name-status::
> -	Show only names and status of changed files. See the description
> +	Show only the name(s) and status of each changed file. See the description
>   	of the `--diff-filter` option on what the status letters mean.
>   	Just like `--name-only` the file names are often encoded in UTF-8.
>   

This new description sounds to me like it only shows files that exist in 
the to-commit, not any files that were deleted.
