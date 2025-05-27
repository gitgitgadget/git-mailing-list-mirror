Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C619E7F9
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363942; cv=none; b=f3sfZluBuTgieHraKLZ77BYLnSjIFyM5wSFldltyztCami8WbVIlx/DlbMnXf+tiCeLrGwsAqkKsxrPk9DDxuetL59mKdmZvZYs+rSwS1KXKcTL/v+G4JxBgLi1Q9hIQ1JbVcRCJB1f1ZNFFQsTGPxbcCehvpWB8AynXU8b8fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363942; c=relaxed/simple;
	bh=NORHZf/jQwUUGwZB8Y38TWoZWhs9hvHYTK7v51bQ6v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYTxzGArLyCgE/BiBZfF0doH9jTdfONnRKqQBjNHh1z9Us+IcOdJXml5Wq5Bx4O/btO9ox3dgkGrwT5NlPHR2xvzU7xLAIiSTMIxxDlhaHye70OJN+DxLx+e9zcAyx8ueC5XTfsghd8nj74j9ehovT/UXXa4tzbpGNZtOXN/ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4X+Mt5/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4X+Mt5/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2347d505445so13116155ad.2
        for <git@vger.kernel.org>; Tue, 27 May 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748363940; x=1748968740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BB07hJJsl9M2jtbQn9G0wV6fosBTJQTv4LOqP1n6A2Q=;
        b=T4X+Mt5/3TlLVNeqXLrInS/i9i3PIVUHRQHIlk4cwW2d5ciN6mHYLoLpIYJjXi/Jy7
         0CfOPmAZdUhXzdS+SmlBmyiAX037iZtmBf5/+62HgOSl38IF+FmV38pL5iD0ycwKGclS
         b+RdhymYROwi9m1C0gr64mtdk5ROipwg0bwTfQB/4CWiSZpOUOhebhBCTO51YjOtB4wM
         2FiuEZ5Pu0b8p2QZ2mnN1vTj0amjjAy2yvNFh9KUU0Z8+s3jbGQyndsPUlfGZQder/hX
         iLpQWoSxLgax3Vm/m+RWK+vfmvLh3jHeta2aCeQm1fiL5u3OvQyfLj8T5jMk9klAqQSi
         xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363940; x=1748968740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB07hJJsl9M2jtbQn9G0wV6fosBTJQTv4LOqP1n6A2Q=;
        b=CxBrBDslxNhTPSoAzhaEKB3wXPJ2+zXJ2Kpk3XvAV9T9iT1fHiBgV3DEGsX/0RmB2L
         Re/VDdDRxl4xtkoO4dNMjVDvBxNf1P2AJ9ixGJ+QnsoAJVTscGa5N7uZoJzUsUW9qAqR
         3QBNNoQzoeqUF772wOi1kQ9CPeJmTWWnStFWKp2JtrpezoSSJuC2JU31hkgAYDdeCW6O
         LWm9jAflaXlzPQwH/O1UA+RMUdcOiTRS1wgivqEJZo+KciQzwquO2W+aqpTpe3euiXCS
         OhrKeFW7kn7wEQ2Y/gJac9NbKx/o8kySN83AHLpIQ/uFcO6VkQkz6xhqTLKhZ7wpRPVw
         fu3Q==
X-Gm-Message-State: AOJu0YykC1GLU+kSbRymdMGp/U8aInUv+Suw+5peuNSt2MlKzVVTFdnq
	KEba1uypI5ETjyhA+ky7fOtGW6cLhxvEdNG6YucfiW5qiDdnDtZg94W2UuZmwQ==
X-Gm-Gg: ASbGncvf5bjJVdDtTTsZ5nC8O/FsCBLAmssD6rxfJD9JsbEwGMYavXkmP/odbUwdjyj
	PPZJK63symRlD34AbEoInNIzei6VdtcjoMAp1aMKdZyEcmNWIpHmw/FixyUiseT4MAD35NpyyyH
	mN9XI6sFxtjZKQf40lVGxH5S2DFw1oOIaHRISLSqmtASKFAIwAm+nS5OknWCCDvFbUQRjpgBQu8
	otAwT6LvF9VY7aP9oOHfuOahg2Mh7Ow8FrlFqcXLAnHxJw02iIvlO5nhaKIaNxIiVP93pP5n1R3
	Fbhsyt04TAgbnNrn/YRf+tjD8vgWyBJYJdtj+2DC1sJZYPYIySmJevLHSeOe1EGJA2ND/mGdYFt
	hD6QygdFTCaI=
X-Google-Smtp-Source: AGHT+IHVawWDmCrOSD1iKWUWSxrwPn40feY3wpK8I05pjAFEWQyau9RJrx/PoE7TjSswddyKFYS2Nw==
X-Received: by 2002:a17:903:2f8c:b0:234:bca7:292e with SMTP id d9443c01a7336-234bca735e8mr12583955ad.14.1748363940501;
        Tue, 27 May 2025 09:39:00 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2345938ae16sm40096825ad.255.2025.05.27.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 09:39:00 -0700 (PDT)
Message-ID: <9befdb3e-ff6e-4416-8735-1eea99dbbf01@gmail.com>
Date: Tue, 27 May 2025 09:38:59 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question About Sorting the Index
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <1008ijb$6j0$1@ciao.gmane.io> <xmqqfrh3qe2w.fsf@gitster.g>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <xmqqfrh3qe2w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/25 11:36 AM, Junio C Hamano wrote:

> For example, the fact that the index is first read into core, each
> entry is represented as a cache_entry in-core structure, and the
> code accesses them via an array active_cache[], and that array is
> sorted per pathnames, haven't changed.  

I had a thought. What if the in-memory cache were stored in a hash,
where the pathname is the key? That way nothing would have to be
sorted in order to lookup a particular file.

The on-disk index could be in any order.

I don't know how the overhead of creating the hash when a
git program starts compares to that of creating the
cache_entry struct and then later doing the sorting.
This seems like the key question.

Jon


