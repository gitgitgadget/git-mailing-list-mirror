Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632C15575E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331234; cv=none; b=XTMXb7YTCjvc1Msk+2DmEZpd6tKiemMMO12/9I2tYOfJnQCNray/iOEKNzILbazctftWJMze1mP9xvj9L3dN4GjnFHcRGuqFPbwElO/qop2yyRGHeQMoG8bKVi1zZ1xIyH0B+aXfaYsFgaJ8ISXZEp5echmlkavQncL8O+MTFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331234; c=relaxed/simple;
	bh=/YeVLa0hgw0B1IymlP9wQ+GONldMwHQrSIyyDDYLEXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfnkSvDidt1InkAK/k/jRIKmHNbqSGxsl8UItxTniDazSeGtj54Xwf1gbE34Tq5e1Y4XlVnLars4ppirs+GH+mt1ztuGYlyi5+qfiWykxon+7o4HoY2mLooQ/3QjsLbXxSsXF1lvlauMl1Y9jSD1Hq8VbhIjkhXzYPSNzdiYkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHrJdd/f; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHrJdd/f"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e30d0d84d23so3909034276.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731331232; x=1731936032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haDxIywD5pFr3R79GByNmrXc1xw7CzYb0xxJbKOMnG8=;
        b=iHrJdd/fHLia/LKUrNy6Yu4ce/+yzjJjyhNZelsFm/n0+potTdb5PBhMCajiQ1fWb/
         QbeA810A2ihIilSIs9M23w83y4sqRMTESlE9m8KOxUTUkCwNEcnGBBPEnEsDwLl2Ps2W
         wfDYQKSxSetIVxN4/S8EHn2w2Bh9OaJOr4JJ3aFHRTzd4FNDCh772El2H6D271fOsYg/
         ThX8CNILZd1Wnj8sMN/fjEXUJ28IyPKhYwLNqKP60tSmBTwwef/u7LQbqkM12oH3kI5/
         eDigzOnNisVI1MwqZbb0YGkF/G7ayN+DgAcOU+9sd2vvhDgoPr/YRNNwfpVEBprqdFGm
         8B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331232; x=1731936032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haDxIywD5pFr3R79GByNmrXc1xw7CzYb0xxJbKOMnG8=;
        b=kgbKlFD5uQ+7rhGwyPR50w36oARvTtQzXFXtlvZ3ytTSf17eKuZOubxSJPm+6Zs/AX
         3f5JNngTzCc8QJYuCcjyQ79YkocxwpujTc4C7pih+Mc05Z2pWzDFoWz3w+fG3TVTeJuC
         /eHpUdLYFdPSD/Kv9w7NyLuirWrPB2J5WaCPl7jr7G3xbRwkH5NCrWV/S8z9/5lCwjjX
         Y+AcoH5ml3NVolK/8gsGDxnk8OyA5xUgK8hx6Jt1aVXoHbenpmnPbH0WiO6EUZ1dAhRq
         Ovaqb2rDxStNaNJEPDtApnFuzxIc2xWSi5p4co7io1/vxTJvQqcctnCkC9nhQqsSAatk
         epgg==
X-Forwarded-Encrypted: i=1; AJvYcCVhFYrJdLe+loquNAGdyu8oILOFaTbb9moRrYewIzVKde+t+XZ+CBQUmtZ4UCfnQHqzL4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQupjuj2IWECLrUMmzgAM6kPuYK6nVG+ZrOgQgJ9ezDO5xp77
	FxVhWuARhMi4w3oVfn7VlHc7PvvwotYKcqI+NuPhJsq02ecBoron
X-Google-Smtp-Source: AGHT+IG6R450CvBBev8/KKCZaqregq3JUWrDnk7BnpNgMhZpgkdiSPz2gpvBPCrA3xfitgMbugfzXw==
X-Received: by 2002:a05:6902:728:b0:e2b:dff3:bda with SMTP id 3f1490d57ef6-e337f843c06mr13245335276.6.1731331231858;
        Mon, 11 Nov 2024 05:20:31 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:cdf0:7186:dd7d:aa91? ([2600:1700:60ba:9810:cdf0:7186:dd7d:aa91])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ed085sm2275316276.52.2024.11.11.05.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:20:31 -0800 (PST)
Message-ID: <db91e3ec-9c08-453f-bf76-4aa131f8b798@gmail.com>
Date: Mon, 11 Nov 2024 08:20:30 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
 johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com,
 kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
 <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
 <20241104172533.GA2985568@coredump.intra.peff.net>
 <xmqq1pzqwnck.fsf@gitster.g> <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
 <xmqqo72miim6.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqo72miim6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/24 9:56 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:

>> The --path-walk approach does not suffer from this problem because
>> it has a second pass that sorts by the name hash and looks for
>> better deltas than the ones that already exist. Thus, it gets the
>> best of both worlds.
> 
> Yes, at the cost of being more complex :-)

True. I hope that the results sufficiently justify the complexity.
Further, the later uses of the path-walk API (git backfill and git
survey) build upon this up-front investment.

Thanks,
-Stolee

