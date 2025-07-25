Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FD239E62
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426029; cv=none; b=K0NNGWVj9KcMYeT4I4EzSiirBumVN8c+WJefin4OWwKWMfcWSRg5OZVxKrY8XQqamN1Y2VPucOlRxLJLm7flTMkfaEBFWF1q3l6+DwU3SWi5/6OmmGHklJS2pAR+Ejr/GFc2dzRM7Z6hbILNiG4vETZQoCuFDgL3kXlwqqDgzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426029; c=relaxed/simple;
	bh=ql8Xj2jan4Mb4vD45TUI9pu6Y+7wKLCF469cANkQy6w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jzxd5GVSREosb47rtMW+VMgQ4jwfH5kW5XAhMjkJzS/LUvrGHSaYHM5GNQPbzR7MiinRsY9t0pfVBFwVhdIBicFoiSXJKDLqY/y5WTrVLrIcTEFvjn1rMwu6/Rbp63flwoaLsWv5UlhaV0c9hkZGsK3R3xbwzUxaXiKtuT7by2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdX+p6bL; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdX+p6bL"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-23f8d27eeeaso16959355ad.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753426027; x=1754030827; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY1OWNaxnLwqWthvs38mNlICmczAnzN1Hq4dB3xYDys=;
        b=SdX+p6bLZMI/bp3pLQgdrfmoko4vEzbmG6rNEHNmShJ2/8nIcQdMX96PjT/7ztXiMi
         0K3QEXbA8ATdcHwEfGdxrpQEOUPItlTQkEDPwFmLkz8klfl9NMayldc+9MH5nPXkbK7A
         5gNzvjWA5q6ZH/LqL7Fr7/vk5qoUa11/hOKz/kNr49foILnvm7yxtnsroTax/AVxebD6
         6itBntCIGjs9MwnXfyrihR4FhSPk+rtZtnUCAGcvvhd9HFIT85qaEgl3m+J20exTFNh4
         cWxXCZbn7sUCfrqwlfe1NY8Qjl9Vh8mu3Q3b0UxxNT7jkwHEdIxJgSKGc8ObzAjvYd+m
         Te+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753426027; x=1754030827;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY1OWNaxnLwqWthvs38mNlICmczAnzN1Hq4dB3xYDys=;
        b=kq0lPq9deKkyPfgjim7NRqXPt+5/B0UTLpEG+1YU4hz4aK+GnzfeckAqQgdNIByMYI
         xKt2u6qeVc5XJJfw4Va1U6P+7nwuwfi6/XS59NXKtXJ7R9mTepp8H4dJGnicJ3XqmdW2
         ttQQ/4hXbNpZnpX+U5KwwHhiwI+iY7tbzCpVMxnKsKM0OHJwJAzuDZKqUch/VHueVqIz
         tSDCmXWlBVKZTuic1GgXOfpVR/+x0o6lsnvCt2pHd1tNvTKFNYRT12cq4WZ3G2O06WVc
         qzew8eGgvvBE3wS1jZZv306qZPhHsxZD7107dqeRI6RtMILwqQ0QARiN4daZPwjKlrE5
         r5rA==
X-Forwarded-Encrypted: i=1; AJvYcCVz4wvcEjq5e6eJO02sqBMISGwGyBQDFfL8VJkRL2hKiBF7aWw8QHz2q31LrCXgOX3RNs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywiaM3jlxZHBxXP0/4U0x2WyZLeACzY8b3cLXoXHM8wgKj7QE
	T1f8Eh6Y53BTLOHxAtsSPi8TQLJcrzM9mNvsRTk3UHJzSzuHqILkKOCx
X-Gm-Gg: ASbGncu296vCCcem+oXlh0Svpc35/JDO45o2/nz2ccVvk5J55gfIpdvbXCuZokWbYen
	8Qu1DG0GWV6jOGlEXSjbZaSvquKVmxSDXJCZJaBrMbbedcH8cil3hr+YATZqhEdekWAesNR/Gs5
	HklZ/GejVUn/f/5vm8QzGv10Not0HOZcH7K5+UWE0WmeeEpV5WP6Qwokmoa9YJpjohcSJprXv3X
	cjE55HyL2XURGRGquav+Ht20KfHZDZRRaV0fRaJ4eyl4O+36LpAXpdLvL44eXkr4B7sOxTuLrOl
	pc/O2185xE1ST8+W7CjS9a+3CXcUapQzfN0UxzZT2MutA3Z75XxOfl+CJJ14k0dwx2p/4c3xy11
	lyvp5PMD9ZdRdL6XxstuEBJ3dTKyM2Vv0VyhGz/ABVioBR2pq2IdNSTV8aJIBZ2mFhwy3LcI+01
	bqh6SSZULPiAm6FpbYY3GvLoc=
X-Google-Smtp-Source: AGHT+IHFv5Ka2j/pNgNOY4RMIecMY2JeQqYvpoKQrl261z5yNtE7EBbLhtSzO7VKDhp1ApKjAG5mFw==
X-Received: by 2002:a17:902:d58c:b0:234:d292:be83 with SMTP id d9443c01a7336-23fb309b7e0mr14458255ad.10.1753426026942;
        Thu, 24 Jul 2025 23:47:06 -0700 (PDT)
Received: from smtpclient.apple (awork062155.netvigator.com. [203.198.28.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4785f54sm30021765ad.77.2025.07.24.23.47.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jul 2025 23:47:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <87v7ngstc8.fsf@arnes.space>
Date: Fri, 25 Jul 2025 14:46:51 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6A35A7CF-966B-4EC7-B575-86E6CCB68D03@gmail.com>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com> <xmqqqzy6omul.fsf@gitster.g>
 <87v7ngstc8.fsf@arnes.space>
To: hi@arnes.space
X-Mailer: Apple Mail (2.3826.600.51.1.1)

hi@arnes.space writes:
> 
>> it does not make sense for the answer to be different depending on the
>> presense of -w or --ignore-matching options.
> 
> does it really not? i thought of `--name-only` as changing the
> formatting of the output, as doing something similar to this:
> 
> git diff --no-ext-diff ... | grep -P "^(---|\+\+\+)" | cut -d/ -f2- | uniq

Git computes a SHA value for each file, so when using --name-only to
check which files have changed, it only needs to compare the SHA values.
There's no need to generate and then filter the full diff content.

Of course, the implementation of git diff is more complex, but I hope you
can roughly understand that --name-only usually doesn't need the actual
diff content.

Thanks,
Lidong

