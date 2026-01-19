Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059732DB7BB
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846307; cv=none; b=lsru/aicoxGDuirawdLjYI/Sq9aShee242DhwchDc367JkjMsGl7NlIZelEUYpTHQVGsf4aCRoiWOD5fkPpHs5zyXr9X2r0PpUw3CR5Rvtw43oBWKhGsatlPvpRKDvtyqrDQF2bDDCCB3beekmOP1fygpQDjkQBncopzdb16cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846307; c=relaxed/simple;
	bh=3c2D3FCcT/UjBGq1RSvesP6s+pB+X8Qtb/CSKXWKrPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rWUcJWfKoHV4KyvmI2yuA+SwPlPDhfLrvegF5ZFkwX5Uhsa2R8xuZMQCcyT9MmehQ+l7lCDZgMiUNtD3BqyAWy2uhT4qdRlZceD5cY32WXm0BaHzHC3egZZoa6c0gYJMjFdrw9tvVuZoOZM69gRtzt0Qyar6TOTPNYDKrwYqRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4d85I8R; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4d85I8R"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a288811a4so47264026d6.3
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768846305; x=1769451105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3c2D3FCcT/UjBGq1RSvesP6s+pB+X8Qtb/CSKXWKrPE=;
        b=G4d85I8RIIZxxyYc6xb+oFFMzezhG6srwcS4O/WLU3O/zl2Ce/6RkbfBoM3KIhrgJE
         E0rGIPG6A4Pv66HU+Cmn7j0javeiJqr5FH+RN9KMu1A1ulRhnGP7ik9x0l4l+/G5XFM+
         94DkcmNGqVYBfIkyOOeFtvDUpDC3yGqdt8XZjKDPzEtR0NUA+A7eCYUYP5/OLhGVxHo9
         w0DgvgrnIMBBxIUqUUoLHZGaOCfbF6wor4kQzCkDTCKR8WwRFXeKvwc6q8n3xWFRld2o
         RYi2ve9i9Bi54En24Rf+xvBriK1O256DN/8gSSfoIjMQJEYk8qa2rjx5DE1r7qNJjVAZ
         aINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846305; x=1769451105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3c2D3FCcT/UjBGq1RSvesP6s+pB+X8Qtb/CSKXWKrPE=;
        b=wu+sep9YHOyZsbtmsABp4WIjYord7NIJNcSeRUQ0/5e9kkJtKb1DMQ34V+hD9CK/X5
         6lMnffHqTaa74uO1TdzOCFM8w5jndJd7Xa/tEMq9vZbRWEqxYsTOY4IvR+DxzC79U/xt
         LqsGEEL65VAOcFE0+Rx6QWS+Z10xH/W0fn8LWLiGUvTgMkGgxoXsWTABz6d0zQP/hSdY
         pRWBhtO6MansQLtx+S7i6O+9z/mTDmeg0KrRgAxWgw25C8CD9Qq0S1fDxFjW5klrkiD8
         Fi7xchW+7KdcU/LUtaWGdHA6I92aykbzCt+rZl7vDa9iUB6O1czXPma39iO9YX4v6FaW
         7V1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdYnxz7vrIE72QnWdJ7xalnPNwQ68SkGjNWEGtrAOeOeOUt9qnjdMtLMtK6omCG9xtgpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAmuCu62HAP3pPPxMAChMTFu1twitHWB4BTCT/j4c1wP/HFry
	CuOy/pn98xDq2PM3Ei6iyRdeDq+ovWuq8IhyNFtAxTprv8tvhXVyvJpx
X-Gm-Gg: AZuq6aKL3tzdX8Z4rQY9dMCAZpilkNJXRCMFxvXYCNaXv6A+eYXXeVFDmpEilk9bLJr
	yBtsRmFWcDNLgphCp9cyz7ZUCWr9oIqCVVWvR0ZzJZqFeqjhTYDn7ZyjLtrOSl4RIYCyjgQH/Rb
	zxbxH8HfTPYwN+q3bM2xLl2++5fXMUyD/gTGa80ecV9ogRqOra2DfB7FrS7kVFynZmweIQs2PbD
	cj+yyqKJqKqOCyNmIzCc8KhFBnMg51LhUot8f/NJ9Ok2whPDbKAoO360eBdrMRL4Tbq/Hbw8aFI
	voomlGnJ+3mb6lIlD4mkufB6x8MXiysdj+mXrRdef6mNMPh3XK/fXvb2AqSsU7qAF1kupLmAzWY
	yeKwhG74SzG4DhNn9+8kN71qJIyZE/ftwo6r9AyfP047HdjEk6MhUXtr5M5j+2cZ3dEA0Dde3D8
	Au8bFjJUj0laOtfQ7Af9UlyN6pJOQw9wASfuzquB+WKdK5XTYvzv9bjjCgFA==
X-Received: by 2002:ad4:5bcc:0:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-8942ddb2fbfmr194995456d6.55.1768846305001;
        Mon, 19 Jan 2026 10:11:45 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e49f2sm87177876d6.6.2026.01.19.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 10:11:44 -0800 (PST)
Message-ID: <edbde063-2c39-4812-9970-247b67f678c7@gmail.com>
Date: Mon, 19 Jan 2026 13:11:44 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1091: cone mode list deduplicates and normalizes paths
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
References: <20260119165724.7339-3-pushkarkumarsingh1970@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260119165724.7339-3-pushkarkumarsingh1970@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/2026 11:57 AM, Pushkar Singh wrote:
> Ensure that git sparse-checkout list in cone mode collapses
> semantically identical paths (e.g. "folder1", "folder1/",
> and "./folder1") into a single canonical entry.

Are you aware that this is already being worked on? [1]

[1] https://lore.kernel.org/git/20260119123339.48435-1-amishhhaaaa@gmail.com/

Please contribute review to that thread with the context
you've gathered creating this patch.

Thanks,
-Stolee

