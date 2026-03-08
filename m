Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D81EEE6
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772929757; cv=none; b=K+ZGWpv2+rFZ4UCNKAdkGI5xLo/iF/9wUx7BYrSmjevugScoEbeQdSETxl42PqdTeqTGUeAjqm8e81bE9XQJ/1EoI17iywpJHYXuJQIwKRnFPLmcvgReVu5pPWtyH9d4hyMG+Y64e5ERwASpEVyUtxh+Bc/u8IEiSg1FYYVLYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772929757; c=relaxed/simple;
	bh=n1qL5cJBNr3LalPWx3J8JmbMiQdNfLr+942oA07sRlw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PUQjWGydFjh5okpaMhrmsS9jvfQFb8j/IE7Z7THZqIkrHbgs8N2wtS7wGncIjC7Qxphn30DPVmca2rW8025oI+1p/H8CxYEQor/7b5whxpJ5QwGhDJdVqL0yC6QJBnTeZSCBtJ6oP2aM+Xa/06PJKlXJqarRHVhgNbRgehVFCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOaFKzCK; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOaFKzCK"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso7091751c88.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772929756; x=1773534556; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOaaKkhn08uO8fOgyAajO2hEpDBuqooHZn3uA2Y//p0=;
        b=TOaFKzCKcGo2be82ZmeXur96B36+ml/VqD23rE0Ve3p772xQNXSE79xhvKTAeqG4Ll
         7zBE6MdkDkCjPpptvvLMoik8heswxb11cE5P4kY5IExM9RMPNwB7ysmF09wnlkxYCsxT
         hy793yuGSmIXW1h7MFoLSW0FbitQ7izUU4u+oLlOms5i4O3C3y1wToNGCCxWtB57sT4B
         O3bNb9RLVoAsG4mdIkI1LjwbdomYnhAj3S2GeDhpdQFpnok3F1txBw/y3gpKljlYwP7t
         icmwHwRJvrlHtugWgLDUo++stUhSEoIVbd94aSQKptniyAe6yypC80/f80WpO2pz2WLd
         81Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772929756; x=1773534556;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOaaKkhn08uO8fOgyAajO2hEpDBuqooHZn3uA2Y//p0=;
        b=F3A4OwM96VrHrb21XzLJpFagQgxPdxtXLPNTbEKAHuQzE5TayCgcGcErNqfYhM6zMJ
         k4Wh2dLaxtXBL0hwqCWriOwt3pfGYfTnbHm6IBnbrUonHGVhHT2ygVZi07u7mv5rwxFT
         lMob+kLWoeDA+y51r2A92jGtAdgIruBQyr7dzTLSPpCcKcbE8c6D4ROaRAziQeTLvmxx
         8jEg5cjqL2viToLaPjpjMwXh5pr+unyqZhvmUW8dctgol8KHuM4wF9a50zgO312VjzJj
         5DWfn2peikbtzHIVbzxQBQh21zfEDs7W658F9sFNhfln0bO0dVTjr35jHE8/t2Lw/Ykm
         NFDA==
X-Gm-Message-State: AOJu0YwbW+/E/T9c28VshNW7RkY6mcR32PZ0wod0FcvVyXXU5l2WTuol
	d77+ZzcowlsKgO9yHJ24XMOP/wO+LbK6r2aUnd/igTQtvte+FYUevmxK
X-Gm-Gg: ATEYQzzMdM9Z+K9/PmYorauwINxenj4AetpI9tlKLWxNl5l4KHMtxrefth/imO0zVP0
	y1rBoia6EZiAz2CEk9vIgH+tUBQP5xaX4+FVuXfNgzJwXxlhkSxXy2DJZN5Crl/swADtUPAXuCN
	4RIVamLlnUKunWX+SzILQFv5fRjG8qL0ZXpqvjV1QKsBKEnnyPwXUriC9K5CVWXpRffRSlnOCBn
	56KBaVFbsS0cET9jcn+bK/gpIjZV58EAoprObeGsxUep+e629kCY2JMiwlkD0UhP96pGryg6mIH
	nt1DEGsZo6toPc8GGXAGlaoG7rXxQCvtuI5JXu0FuiT9dmBuSGISH8hmXkQDKiVO30u8THx/FXd
	KmSyQ0wbSv1af/c0mQrbIdrEFO0PI2oYpV+GoOqxO+rHa7KTQfjIpFlEn5bMpLT7GjB8U+OhPrz
	abN+GG2PVFJUBzgfwi+VXVzlTlH7K/bzMLfCzE/RnZiEDdRSAyY9m1
X-Received: by 2002:a05:7022:f81:b0:11d:f440:b743 with SMTP id a92af1059eb24-128c2d8fb25mr2796302c88.7.1772929755774;
        Sat, 07 Mar 2026 16:29:15 -0800 (PST)
Received: from smtpclient.apple ([177.33.87.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f4351bsm4134965c88.11.2026.03.07.16.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2026 16:29:15 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net>
Date: Sat, 7 Mar 2026 21:29:00 -0300
Cc: git@vger.kernel.org,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com,
 jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com,
 jtobler@github.com,
 karthik nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <041DCF2E-75FB-4B0A-9128-FDBB1A6DAC3C@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3864.400.21)


> I think you should provide both.  I originally added this for things
> like `--git-common-dir`, which Git LFS would really like to have as an
> absolute path in the way that Git canonicalizes it, as well as
> potentially a relative path.

Thanks for your input, brian!

> With `git rev-parse`, you can change `--path-format` on the command line
> between options, so if you want both, you just request one thing, use
> `--path-format`, and then request the other.  However, that can't be
> done with `git repo` and `--path-format`.

It makes sense. If we use the key format suggested by Ayush [1]
we could retrieve both values with something like

   $ git repo info path.git-dir.absolute path.git-dir.relative

I'll stop by now. Since many people are interested in contributing to
git-repo-info in GSoC, I'll leave this decision to the person who will
work on it, if there is one.

[1] B46AA932-28EF-4A2C-96B9-0F05D9641C1C@gmail.com

