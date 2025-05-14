Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19A13AA53
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235589; cv=none; b=IxBPL4rRLGQ+xbXSTnRTqOW/7IDwCFo0Br7QNdClK0VtxGk58xGouyl8JUhdlaexoBLM9ZvWKb6qTxHx5vJiFizlB52EmX1fwE9EsKNuEEvphyG4ofFebxunYJO4dk1CIOQbcl7QbJmY5sYOT1LagB1EYrNVNJHZM9YgNqfCv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235589; c=relaxed/simple;
	bh=hHohSURI6XBDTLDfkqAkx09JR44Nb+MTwSkUri47tow=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GJAVMMxAjTV52BOJ7UA8DVggBAXuvappVvT6tZborgT+UxCyEJ6jzlCkUcNwQ58UBt/reHe/WoO/7Pgw8NWFEwJzAu+e5LLyAd9ITaHhqbllwOBwpQEILrxjBLAGQltk3usnyNR7C5FMiZ+SgvvifqEPmmEDo2gz/If5dgNLAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6A9RtgK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6A9RtgK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so5147830f8f.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747235586; x=1747840386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqrdfIDCDz14Lj5N7Cp+11Yvj2gys4SirSonOjZ9JpA=;
        b=S6A9RtgKLnjGHr6A09kuInXo0kTu+65ibIEtezS5bzgbm2CX7ZJvfJ1v/AkCjmLByy
         bjxLDGmu65dBHlAfkgyWv8VQLK6t4urU/Ya0Mpr5K1X5n5+9VaXRazhK3uTfuHjy5ly+
         xwNUCGj7JWfaNDSqKKU2xTQgL6jMXZT7t2NsFlaXa4gje05R6vE8R3xZiiv96Or5S4Qs
         IpNrXHM1oRWNrBueA56uMtKVFew4Ox/zu4hRiWAVrCV4xcBWR9h1OBntuHVIUkK2eZxa
         /0NAZQITpns7KmWIxADyfSgnF9A0aw8iBO5PwjjfwA1M93EBxpwMHKCUyGvGHEhDnu+M
         k+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235586; x=1747840386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqrdfIDCDz14Lj5N7Cp+11Yvj2gys4SirSonOjZ9JpA=;
        b=xL7x4b6pZiOXGDZfceJ9+yd1c18baxsA32JJpe/7u069gj37MUz7jIaJqx0wAdMN+Q
         4PcrfluWKASEs5OVkyHbl72xqpYiAyB+IIi9JCI6kbtB/bImAP0e5nfa+CNj8anzHDlF
         96xMrkvUdWq+UUdVX0ky7nYdh+62A9kWrS2pwg6z5A+XXdfMwFmasKOw8aaoMb9doe1T
         Q03gvuM0EWCXmAXdf4J5IJmJqsjtL7u4Pa2o7lRrfIlbo4fGWkS+9vIhzOsHLe7LIdaI
         lp4SMZMxgeItQ7RRB9WSkYHkWjBS15syZMh8pnmc+nQ7GJ2455n64eL3pnfzuwY6p59p
         3noQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHrLiKIcga7iioK6uPjLqBDR3qWQggCrijCLBpQa+yYN7FtKxrrqK+GJ1xc6DZu+oytAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAthr/5k0W5adT/BsIy9KOy7Qzj0rZaXdiHLmK2kN/Vxmdw+G/
	zIhSFY677d08j9pE0xn0LmxvZ/INnw5LcmUR02qIg7GS6xOIAorZn2/7Ig==
X-Gm-Gg: ASbGnct39b8QzCLq/9Jodz0c/Yp6T6VYJcDf1mXf3n3TRye5NXeFeYeCHBFdqecnhEW
	OCZavd98lmN5LffhlwkXflCGBRkdyOHO1E+Ysm2joNPtxtE+eTdXOQbYGmiDHP+2TmaXZKEt94c
	2wCRUYvOHZDJr7tf41Jl4/vN7zPli+BC5Ko/d0awHVxvWJEZUwEBpPAjW000w9lhu/XcW6EPYR8
	xykAJ+LtzH2ArHVTLJnUplU5WYz3RfPm1QB9v1Ffz4DheVDNHE/jFR9cwvhnpP2qR8EysqS+mEV
	VfH2dxVAbRyJ/7It+RzZZvufShyIWbHAD+r1Prgd2IEgTI+bAUuWm5gI6zA1tqHPKsKJrjPpjJG
	eyE0zS488zfIIKmGypDiFeWlf+cU=
X-Google-Smtp-Source: AGHT+IElEqXWYoe8PwBnzfa9mMGO4hEgy6BlFHlMOuySUQqSwjWCMb1UfF4l8LF2hrm8cyhctRcMxg==
X-Received: by 2002:a05:6000:40de:b0:391:2e7:67ff with SMTP id ffacd0b85a97d-3a34968fd0fmr3199162f8f.10.1747235585842;
        Wed, 14 May 2025 08:13:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebec4sm20388310f8f.36.2025.05.14.08.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:13:05 -0700 (PDT)
Message-ID: <8ab91ee3-26b6-4ac5-9332-64649cf329e6@gmail.com>
Date: Wed, 14 May 2025 16:13:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
To: Leon Michalak <leonmichalak6@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
 <431d6fec-3955-4703-8bb3-376eae7ff052@gmail.com>
 <0862a881-2e0a-4051-949f-3d0b94408fd5@gmail.com>
 <CAP9jKjEbfbRijEowYjkbeQxKC1GqLCoM=hCjhXSgsrvgVAkO0w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP9jKjEbfbRijEowYjkbeQxKC1GqLCoM=hCjhXSgsrvgVAkO0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 13/05/2025 16:05, Leon Michalak wrote:
> Hey, thanks for the thorough review Philip. I will properly digest
> this when I get some free time, but I just wanted to say (I probably
> should have mentioned this so my bad) that the reason I didn't change
> to test just the singular command (yet, anyway) is that someone else
> thought this was a good idea testing all of them,

I'd missed that message - have you got a link to it please

> so I wasn't sure
> whether to touch it or not in the end, and thought I'd just submit
> this v2 and gather more opinions. Was this perhaps the wrong approach
> though?
If you get conflicting advise then it is a good idea to mention that in 
the cover letter and explain which option you went with and why.

Best Wishes

Phillip

