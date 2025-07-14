Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED8253954
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511920; cv=none; b=XqxRZmB0oLRZWa3HeGDcJfc0RBjXly4neH/bWtW56QFK5Q5psWdZu8x8ah8q0jKLsY0GuUMpITgtwPeq+C0TpS6O2RelbI0REiWY8deK8zs5VW0p+l0kmPFWDpxnAcu6xONBIzUWVBkoRZ9/maAJ9SaFgxI39e+Ci57eHPqAors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511920; c=relaxed/simple;
	bh=ngwZxWjLDreir5yV6Tw3Rle1m8vhbUuedq0gbV1GrwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxqabiaEv0o0hzseskhI42Nf9ExBT/pWCItwNFXf4yYQJkUNQlvL5KyTl/l8Plr604RQcmezYAKZMhiaxCCX3bgzT2wIMPS5p7+foH8Xg4vVfusBXwZkoLZ0XnbA3uB7vDRqLQILUcR5yrPdS48cpHbnJr08TggaLBffazaIX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYiaBveW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYiaBveW"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7180bb37846so10393637b3.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511917; x=1753116717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngwZxWjLDreir5yV6Tw3Rle1m8vhbUuedq0gbV1GrwU=;
        b=VYiaBveWt8XcUFR2zik+tvmzAewVh19S7ZZCbD4qRIllpO24MdOIVHWS1bel0jcH7q
         qaaOl8CH8UfIaJNSkScctBC8DHGBGd/C3qy6LpjEYaJwefbZp/BtJul4cJHS/o7TjW4i
         72c0uLfgDPrTacPfrlvHY7CD9eUC9tfCj8GUSBD+7tKxwdhZya/d1g9J1kBvpkIL7gWH
         yqyaAC3gohitIS7p1Zbhk9qeA/J2HJBfoR/NB35ekyvXhgmlzhhsK0OCfh2QPfAepqQW
         78F2117JGwJm85go3zvhi35aSQoCKgsKnSMgW2pFSnbuih98hkJ1HB+vQVc6ryBI4o+f
         nDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511917; x=1753116717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngwZxWjLDreir5yV6Tw3Rle1m8vhbUuedq0gbV1GrwU=;
        b=KYDJQUmPsVaUSR4oyerE0kYONLK5VVq/6OPMmtSQQYfYezuFgFY8zbdiUL8QdqAZp6
         7Ei80p1AruNLN+cUhWEXJiZYXuNs5vwpc0L4DkkDDlzlgiGGC9dy4M0r9QETIhTUSp6z
         xbgy6obykZ6Aw2whmXOiiRz3OWHygfR5dnlCzY3AsSJ4WzHgoBUSDhECNMKS+R67dIuz
         Q3JfJ6ZYwL/iA2Su8cvMFBnNnS4qwE0ZOEcY2KSU4ZvE1CfDMx+a3/J0k0k7fELFj5bC
         Upf6itKwnq2VZ41oUD8xP6P9VGljAMgJw+BD9Q/S1uZeb+RSLdZ3JWxmxVjod0uNAy3C
         +KxQ==
X-Gm-Message-State: AOJu0YzJMnoeoToiX4h11xf6qqSR7KB863BqUnBt4E/ArEGaSEgi8UaU
	vlpHEyBryd1B5++bhNkULtyi4f15MnG5/Fqig10sQU7yn0jNd+ZbA5vQ
X-Gm-Gg: ASbGncsIYJeKKTaZsEbjsVoeLgDf9cke8P1S3HHnyL93cC5vn+OpLD+M5Bi6Qn11OGQ
	IWeXEHQk71dnLeZISN4RjrFctjhvVnxKh3EVyuYLY3xPdxi1LlN5Ogbak5swu2bEgDCAvvW3Fqx
	4Stp5J+BAFHLuF/7qu7nmwqgELRtXpWLBbVg8gO5xHtj7g4aIO6luWsudhxcH/IhUF9hUceRNiV
	qGnNGvoqenbFZOvhlZenTEJlHDugd1hBTpqqqnX0qACiV/AtB+Ve0IjXNzBUHNdTVWs1kTjTdve
	9Dv/Vf9rKNdcgTj1IEfopjxb3iZxV80kKWKyJc8arz+9GHEJ0+DzHDnX0Ert/dbiQXh1FVqfHUo
	thGEd3+UaICgAoK/9qnbFg1uirUF2+viSIEMmPqHy8XxynuFP46cD35ReA2gmr78QOD1Qm3cVlQ
	QqtXvYvE3UvA==
X-Google-Smtp-Source: AGHT+IELmRDGU+rfZhmYvpxy68zxBut93ws8lw+VrVFcl9uSBvmogi3wiFHotOcwcLucQ8ZtFEnGoA==
X-Received: by 2002:a05:690c:4913:b0:70f:8884:17af with SMTP id 00721157ae682-717d786eaf2mr225719577b3.6.1752511917256;
        Mon, 14 Jul 2025 09:51:57 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d51aa6sm20210837b3.1.2025.07.14.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:51:56 -0700 (PDT)
Message-ID: <30afce8c-c932-4c51-9a27-e63385608514@gmail.com>
Date: Mon, 14 Jul 2025 12:51:56 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] bloom: optimize multiple pathspec items in
 revision
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 Lidong Yan <502024330056@smail.nju.edu.cn>
References: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
 <20250712095129.24642-1-yldhome2d2@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250712095129.24642-1-yldhome2d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/2025 5:51 AM, Lidong Yan wrote:
> To enable optimize multiple pathspec items in revision traversal,
> return 0 if all pathspec item is literal in forbid_bloom_filters().
> Add for loops to initialize and check each pathspec item's bloom_keyvec
> when optimization is possible.

The patch itself is good.

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>

Here, I'll just point out that your sign-off should follow mine
because you were the last to touch the patch. In this way, the
sign-off gives a kind of timestamp to who made the most-recent
changes (and that those changes have that person's sign-off,
and may not have been vetted by previous signers).

Thanks,
-Stolee

