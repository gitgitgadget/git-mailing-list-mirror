Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C4346E59
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916362; cv=none; b=cxE9kNiVWizMAIhAzvO3ZHrNCVfi2Jy8GwTR8tnJ40tZ+1Jj4jRr+0899Zm2mW/1FlnwLJ6D2X179ViSZys/jN/IoSrf4sp5M9KGlPZpVrDN3kE0z4VewSuAcAdjDKZaiuwnO8skFhCzsI/XDgwkoKOlAxKzvVulDbUe8jj1dJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916362; c=relaxed/simple;
	bh=6yIuFVuGWfKygPSJOIW4YmEtAEVlNJvGAwiTjeLvZsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvIY+abEt0K8CB9HL1qi4heYKYl0dFV/cxQg5W7NBnsoLcALhddnd45Zs0i8W9cM3QZNxOVE5b+2WT8sE/CY8+urTRk5gGGm36Fnrr7O8c1WlkA30FH9w3SaqzUh2RzT7pIUUSuY93cIA7Ya7vb0UhZy98qIs9MxCEI6qi8pw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEgdMyXX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEgdMyXX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2b2c9eccso1771461cf.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916361; x=1783521161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jaq8TWaSMODN8Ga05kGsE0btPGIsXkEshhA+6FAJim4=;
        b=JEgdMyXXlaPGKnig2prdc5v9Fq+oogFs8ZaHuXznXPMvlfniRNz4F1oXPQ9O/mwMfU
         Une66DMHrH4Hpdtj8KJoZP6Wb9FwKZEXKP4mNyg6u2fTWI+VdPNCPlB4sajhR8YTil8I
         O0xBKIwyNeE6rFqfKuM+9QzXkRFWRoRdP2W9Di2gX9m+AkakqpvrkEVZaxOENlenIaMS
         L1p7zZmhPgU214uFoqtoAQW7MDH9qHw/Wb4vd1Yw9zu4kvyXYPW0SKe2cXWo/k9dgpNY
         Xq07FUtm0uTg/Kwmq1gjMQW3CQt/jobCEn5+VN7HuG5SOlGomvN75fQzIay6jOx1MMhp
         JYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916361; x=1783521161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jaq8TWaSMODN8Ga05kGsE0btPGIsXkEshhA+6FAJim4=;
        b=qCqcrr8YM7CkazkHP1LfYi7k39ucmOFnlUI0qNWny/AzxaI8qGWhhfcuw1hjt7pzuv
         IoIcbX26QYKiKAjqenTTxY9/xAl6uuItFQCvVseLiiD+7P/8QDJYO83FLNxks/5Ow8Oc
         kzQpPDV1D8mOTQD8AOzcTcDxoJ5NiE7FY7o8+B6iFqxHLuB/mfwUtVmjiGFL3EQ3NUgh
         NSh/lG4ZGzITVMj+nQDZ2wxJJhgHNLCvkn4UcsR2posNiOtS2eP3NeOe3mMBxqsY+QO8
         pZ3N/i4A4Zqd5/YeSv1X51qY3klPw5ZicORPZ7TLYr9UNrLpTAbWSpMOp/kR1TNUKsud
         DF0w==
X-Forwarded-Encrypted: i=1; AFNElJ9Asd5Pudxxco2fTt9h/SfysyYQGXJtyysQuSYH94Z8PpkC2SlhAwyvjidEoeuNt8i0fKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO6qwt+tmsiSKPorWG26CH6a6ihI9GbRUGU/VUlI5JIgDBAc+
	mlr6eWrfoQuq1L/c9kSScJwf232rkfshehaa0hnv4cs9zhj9OrBdbItF7FeuGfrP
X-Gm-Gg: AfdE7cmsvtZefZvyHmVzN4RIYZVroRORN0S3XM9fMBATCBeYuUs8eUp+1zatNNRPXdJ
	7u6EqJGnuT04n3Uy6QA/KLKjv889ovBOBAkQWpaKa46XvGrScPUJmLWAiT/vJxjipn/w7v7MQJv
	YCLytyqCwJ5/5CfDPP7v1ykKwgBH9r6AQluajxPB1G3U1/F5gWk2MjVBotPnEwN4iRjBTD5TBbz
	cEgqkLLpTKV1SNsDPhAFhplQFaUa7btx/z2AIvbkqN1XcMrpOG/5p0JfAHA0LgcFoXNi2C5Rd+W
	R+0LKQJftbb1OF+9ZS/DdO9YcDVYGNpHb2jgbPuMykgMfvrkXGfSBftSQ+WGKhExI8MY4hkZ+hu
	VvTn1PGXzfzKx93UWutWJ1Yf0vN5PYXK/N6jJtSNBoyaenLdJlsa3UKlWbhDPHVROkWbnX8mdjL
	arde8keryrZ14oPPqOXzjRHotdrHZZIcZtuooMiRBnFDf0N9f7seeDRLLbTA==
X-Received: by 2002:ac8:590b:0:b0:516:d955:ea6 with SMTP id d75a77b69052e-51c26a57b99mr24908631cf.14.1782916360271;
        Wed, 01 Jul 2026 07:32:40 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109cbaa9sm45072441cf.20.2026.07.01.07.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:32:39 -0700 (PDT)
Message-ID: <b641aed4-ad52-477b-b1d8-9d8e470be46f@gmail.com>
Date: Wed, 1 Jul 2026 10:32:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bloom-related leak fixes
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260701063538.GA2579765@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/2026 2:35 AM, Jeff King wrote:
> Here are a few small leak fixes that only show up when you run the test
> suite with GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.
> 
> Combined with the commit-graph leak-fix here:
> 
>   https://lore.kernel.org/git/20260630064301.GB3733961@coredump.intra.peff.net/
> 
> and Kaartic's pending fix from this thread:
> 
>   https://lore.kernel.org/git/20260614141600.620272-1-kaartic.sivaraam@gmail.com/
> 
> This will fix most of the leaks we'd see if we ran linux-TEST-vars jobs
> with leak-checking. There are a few more related to building with
> openssl for sha1, but I'll tackle those separately.
Thanks for fixing these leaks in the simplest way possible in
each scenario.

Thanks,
-Stolee

