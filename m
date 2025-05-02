Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133B156C63
	for <git@vger.kernel.org>; Fri,  2 May 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197857; cv=none; b=kKUq3uYZbrX3VWZVRxMLWsHkfj/Bz5a3M2VpLioKZwBgVUJ9uBXNpshwZNZ+p/fuxLQ7IxRhWe0aINmhNdTSRY7SDCzBxs9X/Me5s46zbIdtyUtheQsRDTXhK7OV/mMu4gulYjYT0704Hs9OsRsBRxS4mOEZBDGL3S7N5XTZkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197857; c=relaxed/simple;
	bh=c+f8wwx3jEJQ2wSIPEl84sbiWLukFegtXIZ2kluZyAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko/91ejQyjx7WVWsCp0NkHvXwUbEgqmJ2X/JuvM2e6525txd/8tFD/0GDj0vYCq6+GGtTKH3O4MLKkC/70pVr/fZIoOJfm8bEEWGPHONyy0s9XvTLzHpFyO/juE849Lf8I2zwZPPLQrQg9PUNpUCvWIxdbTCiGdahI+DzCFRh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMVN0d0k; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMVN0d0k"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7082ad1355bso16725387b3.1
        for <git@vger.kernel.org>; Fri, 02 May 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746197854; x=1746802654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cny8S2w60wg1wZwm0VSSiYqF/xf4Mzz89J8ToaKGXk=;
        b=GMVN0d0kcGHNi5NvbPYXTmVo5nuIiX0asEgosR0+fNpRXaeN5B73xqODyuMfLKbFIF
         q665Twyhkjs42bRdY5mywBVsl+ic4CJXQqe3g+AryeF+ZJPYQ5VAylSKO2RTcdOhMG8S
         6L4/jIxoERu7b7xVQiF6q0oV+P+OHahOql0lW3aVo0d9bpwwGbJad8THKV0aFY8d7IQH
         o6RNF6vieZaWa+nB/QmRfbcOHbp6s5La+SK7hDwptfeNx5s1+uSxrLG1vwg/zWKSA/Mr
         iij9R24w1/gu17p2GH3EO3yfgLGI1h5QWMMavpHOScOVBsGF+dh1foUaKNJ7KeO+99pj
         bGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746197854; x=1746802654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cny8S2w60wg1wZwm0VSSiYqF/xf4Mzz89J8ToaKGXk=;
        b=f069eHGcaBN/mB4aHYo1t65XqvEWiIxn34XEGbT/Nc4c9szqb41dUBLPAnoT1o3Gpw
         KPuQsa6xeOou5AM/9h6iBf0MNLNiou1x5kG+j4SeSCFVAZKuUAt0K9u4Kw/HAj3M7W3e
         j/h1AmWZIUwXnnPHpYejSZtZzka9ITa+Gq/za2F5JkN9ZxYPusU+LbLGJ3u/4d5KIOzM
         BSwoYMsEVMlu4uT4c2ttRAQdgMC5fnkrjxbu029i5aL2JpwUV+ci7+feZCg8VBlR8ZsX
         LOLIBi7b7PmEsHwFs31B96uqUdN+2lIjbVbMEnsPBay/1jUd5z+kKEO+7bp+Ry8rxZE6
         k/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXcVb7PUlwNPwokACgSlpp24YAnMrU5A9xem6t6bDHlMR9os8voMOIOQ3dqOyn/XMuFxoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3TSiPKlAebNzB/P53FwsH6qoe5FGAcc7gCIT601YyDKYrhPP
	w79FipQo2fbPx7SbLQpo/qeztzBfY7E6YGcQhkM72GP4vU+8b+tJoul0oA==
X-Gm-Gg: ASbGncsb7PwDBxHsjK5leNwkZ/ak2hY7abbDoKg5wCHcSyIhgQlLF36gYwQV9WwBrGD
	za4qvdgJzbHAyDJMS6zewkdGQPXYwcrKYdyasM4yoebxleQi2jnclg2cLBKkuxhR1nFx7E9H3Hq
	xXesOmkOowQkcx+vjQism+IldVPTvaXNFVxIIv9yZMltY2rBd4a0gNaDj0r6yDuQNpx/SSxcDkt
	ZFFcirr6jOUJPKh+74Yz8PBeoEVCrSfZomKlsqT/WTUUco1msS56HQNqVN35z6MnGVbxWRAurx1
	gcRZl3mzBOd+7VLtE6fOTc4jjPhzvKqbaMBAU8+Lx5XoyYOKXOmNVHxbIcEysPF6FZmzbm0CjHk
	Do2L5Lf/wpsTw4arJyCrhN4lS
X-Google-Smtp-Source: AGHT+IG6UN0YN63y2BToIgUYBIZLgN0Bfz3+eymG1M1WR4pAfPWiof/W5NpVXaHshDfydOC+RFx7XA==
X-Received: by 2002:a05:690c:4510:b0:6f9:a8e7:430 with SMTP id 00721157ae682-708cf01183bmr43181407b3.4.1746197854100;
        Fri, 02 May 2025 07:57:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:82c:13ff:f438:6d53? ([2600:1700:60ba:9810:82c:13ff:f438:6d53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c46c4699sm7370607b3.115.2025.05.02.07.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:57:33 -0700 (PDT)
Message-ID: <d5307e82-8e45-4a2a-a8cc-03f84c2d5670@gmail.com>
Date: Fri, 2 May 2025 10:57:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/2025 4:43 AM, Patrick Steinhardt wrote:

> Changes in v3:
>   - Simplify the heuristic for "rerere-gc" so that we only count the
>     number of directory entries in ".git/rr-cache", without considering
>     staleness.

The range-diff was harder to read than just re-reviewing patch 7, but I
think this v3 is ready to go.

Thanks,
-Stolee

