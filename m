Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEA524C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144777; cv=none; b=a7Y0zc+DRwslNdqLnt3/vijdYRjiXtVwhLlR9pV2vgSHWvk2owWr50nKvn4cOXsp4LC/FhcWT0HBBvsXtuA5E7qDAR0OjUTQyufQZoCLXZGrV8xpcwlDhIxqiaVyJ/iTpUwvrcX8J8tmVaf2Q9RS8yd7g4zT9henQtM2+cFSAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144777; c=relaxed/simple;
	bh=ILUrvyg1C9w6DvFAk5VIIl69WTH4jaUuMyD9SZJs4uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKOZTlr7nVh2rPhemjkh+uh2SlHKlpDpo6ht39KhYHrZKfYWer0fhNB/3YYVXmCfhmoGv1MrijSzT9p/YvH9+n7I/lOZaoYkjMpcjBLhgIDaklDgt6QXg1704Yf8kj9ObMbkb7T48m5QddkNc5bAw5nWcK/w+wwawwwA1tjPiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IINYrWfH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IINYrWfH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3a97a6010so52435637b3.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730144773; x=1730749573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0FG0/9mztcU96fPSj5YjWm9x8H5ZbOCNhrnftWBVPg=;
        b=IINYrWfH37v1BRs1GyMrFygRitJnfS62dmFQgPx468U0UkFTACbNLbNZzIZfLgOX9n
         jxq6EPXcJrO3jnsFuyhO8cNSjjovwPA/yNk9wat9dyaeP0ZH9NwwXGusTNoOSO5Sk5Xv
         2lAT6ZbAAf6AD3E97W7C7T0oYaqYft/GXxrPRhaXyCeID+8WDFrfw2dsyZkcfizbJ0EZ
         yPHXeiQRgj0QpD4bgUpdlxzPWD/y3i9eKw6dj2mSKpj+dQA4F3CegriHPAoKohwjV3Ye
         MHh7KyE2WwG6YH/TBHNMoaJ3x4w+vIKxgq2528JxqGPpNA4pb8czRQT17XsEJTQ7T2yt
         IqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144773; x=1730749573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0FG0/9mztcU96fPSj5YjWm9x8H5ZbOCNhrnftWBVPg=;
        b=iuMwzFpt/tdEw9zXEyaxgjVSoutPX2RO/RF9GxdFB0fgPrR+COb7sbJ7JvjvRG1FZC
         9l6C8A/j4sMQWGdxTEaYvazvnlG2byVT3bZywpMOidUFn6TJsZzwZhuFuVWxS/cpz1Q+
         n7Fthgwp1BfFudo2/Z9tCJlAHjoisSCAYE0gyBJcnLBZxFyc8IXYPXMUjoC1jG83fKNb
         honK2UnBZEC4ltvE1mXKMQt+NzywEJ0pYPW3LoGw5F6YJlWLYGxNTgsF0pLS6dasBuTN
         U0L8eb5S7REXhDg1tY+7QSdWyDgk6NVCdc6vdYSx0Kf79lTeYMy1dHcEAltH+tP7970F
         4hBw==
X-Forwarded-Encrypted: i=1; AJvYcCVbFCMWQlG0eruIOI8Td/DP3NWJUgsIWc22LwRA+jTn0XDswaEvYD0ZPILAzir4ibFaq7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcINUkgozOLPxsKqPMwqI2do9ObrLjwW1coeF9M4bnu6CHaJD4
	hx97pRG3IWlWlm3jgxOl3CADoxpxmh6aeTjIVE2HNmAFtqgjSAKK
X-Google-Smtp-Source: AGHT+IHvcBJOrWPrVV3jsYpfQUPhefdWFJdPKrXQ7E2WQuLW2LxJJk4EhCqXOwJM4xQ/Oicu70fZAA==
X-Received: by 2002:a05:690c:660f:b0:6b1:2825:a3cd with SMTP id 00721157ae682-6e9d8acb3demr75702447b3.35.1730144773158;
        Mon, 28 Oct 2024 12:46:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2591:fac3:7e68:7ca2? ([2600:1700:60ba:9810:2591:fac3:7e68:7ca2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bde098sm16000627b3.30.2024.10.28.12.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 12:46:12 -0700 (PDT)
Message-ID: <85d3c75c-d7c2-498f-8afe-34c49337ba37@gmail.com>
Date: Mon, 28 Oct 2024 15:46:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local> <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
 <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
 <Zx/I+9icWGsRz11x@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zx/I+9icWGsRz11x@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 1:25 PM, Taylor Blau wrote:
> On Mon, Oct 28, 2024 at 01:13:15PM -0400, Derrick Stolee wrote:

>> You are correct that this is not compatible with those features as-is.
>> _Maybe_ there is potential to integrate them in the future, but that
>> would require better understanding of whether the new compression
>> mechanism valuable in enough cases (final storage size or maybe even
>> in repacking time).
> 
> I think the bitmap thing is not too big of a hurdle. The .bitmap file is
> the only spot we store name-hash values on-disk in the "hashcache"
> extension.
> 
> Unfortunately, there is no easy way to reuse the format of the existing
> hashcache extension as-is to indicate to the reader whether they are
> recording traditional name-hash values, or the new --path-walk hash
> values.

The --path-walk option does not mess with the name-hash. You're thinking
of the --full-name-hash feature [1] that was pulled out due to a lack of
interest (and better results with --path-walk).

[1] https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com/

>> At the very least, it would be helpful if some other large repos were
>> tested to see how commonly this could help client-side users. Are
>> there other aspects to a repo's structure that could be important to
>> how effective this approach is?
> 
> What measurements are you looking for here? I thought that you had
> already done an extensive job of measuring the client-side impact of
> pushing smaller packs and faster local repacks, no?
I've done what I can with the repos I know about, but perhaps other
folks have other repos they like to test that might present new
aspects to the problem.

For example, a colleague was testing this in a variety of Javascript
repos and found that the node repo [2] was slightly worse with the
--path-walk option. I've since discovered that this is only true when
using a checked-out copy and the .git/index file is iterated, as some
large source files with few versions become split across the boundary
of "in the index" or "in commit history". (I am fixing this aspect as
well in the next iteration, hence some reason for its delay.)

[2] https://github.com/nodejs/node

Thanks,
-Stolee

