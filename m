Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A539BFE7
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372047; cv=none; b=DmJB4QsX0BM/JY4arJ8gdH8IQu/lDrB/GY/CQ2LEFWtSmkkYghrrjh9+og+lTkejpl1WHb4XRJm1mbXWU4eUb+Uo6Fpv6y/tVPR2VTISPv3wDn6Aters4dU71R9/6McavVorOV8MPk02nQeoCkmXEuFeDSsv6fAgO3eElH0Uxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372047; c=relaxed/simple;
	bh=pfNaBJO/7F5ApKbVFwP4NKnJuv8IdHHWCZt+qeTMT/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhqF9El6oLpDBdbYqVT427euD3DPLq29ld3rHE0BIPAFL6KEJImu5q9KSSGM9WfSLE1PmYaQM7SOAq78lzvcG5W/Tm+gi2uUr7d95vGzXZN60J1U+lrTBc/GsarjzuVIW/cNeBaWnoS6Dg3klv3ngKyukBsJVszB1I+SNi45sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh56clcm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh56clcm"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b2d6f9d00so49207081cf.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774372045; x=1774976845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhncYDtWITXXLbOg/ucsbX4GxaFNz2gZts6ukCb2udw=;
        b=Lh56clcmn8tCcY3S+HvrA/VgOLdRx04NWOgfy+TmZw/aYmAoAB7YZa47XcTfGd7KMK
         xVz0G06ePuXTvdjBhLSF92yOaPwpEe387WbfVlW7/eonKHXpAYHp+bJ6cHu2pWLd4fZS
         HAm0zdAuiytCxCjPYean85y0swGW+NpwBjiIJCbllg7bQnzP8EEfrLgeG4R6E3JXKnyJ
         mDJS4+lFZimpDOhOzbMjgO9fW1zXbADDmP59q51c2x2c7QEp+Qx7w4kvn2DKNPr7GJBv
         /5+M3F+CKeJARhJ62OAYjE34banNZXvxOZY+ICr7fMVTCp3hDFo2HWqAV0KYDjtV8iIX
         jSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372045; x=1774976845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhncYDtWITXXLbOg/ucsbX4GxaFNz2gZts6ukCb2udw=;
        b=aN9mVepuV0qYXGhHgzAjk/dP4WgR2WBT5Pc/TlFkvXiduEnPWEkskfMkmXx4rSG5nM
         dhW71ojPQg7r6sUmbnSD05NRO+7q1TQqTPpNXQbuknzW26gcw5ohuGt7wIsHNbTw6EOG
         7rUrcCulZ8sryhPPIjpcUSzwUM9M3CvSyNPhHT4v5d/x9F8o+aqT2qxPiYDuQbV0+7Ge
         ynTZKsSb1M8BPXXxZ65ZScq3kY/8jLa8SXiitpgkINUd600WjonoU2WnxTCyDXhZMse6
         wCS63aHl1sO/khQWOJXN23124DqNhL9MLLRCAoEvgciUQJK9+3tAU5YSpEhX5AmP+aZd
         4SoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMk5PXL7YVqpYzYAiHP2oIN3cTdFmd80+MdWtn/0Gh59U6kxKIkcOdZRLjXFR9j/+gx0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5UeAj6AxOsRtYW2SKY8H57gbfmV8CydMBjbTQXwpQOHRTQy9
	TaHYnRq1nV1clfr3HxdybrPaIA5hRpbFvACeLfpe1EvKw+t6h8Ai3v8+
X-Gm-Gg: ATEYQzwbahQY3biuH7qUyiYr39JBJ6/oFYr4/+6sfLlbvktXoJiB9lAimvRGRa5qPpb
	9x8TEac3J7XZCkq/lLtW3T4J+K0XOoN1TR40nC84clo0KQqBoYRNogU2xZVGSBsAfMtSaIojFFQ
	SDjPmpFJwkbhF7qxafIP6IWgL2CtPLacajX2N8ZEcLHtMzm3uwI4yUdwnb02/js4OPuHlZXv5iP
	3NtLod46Urh4BmEP8F07wLeFa6Klq18fJKWJpQALIZsVQteOxZcz/Ap2oti7YOyqIrq4z5sls7O
	EbNuw5uwxGZPVsJlr6AQltkgRnN3UeK1lo4yye1zOwknqZm9BSjKyztqh89jp23EXAxOhRdCcYf
	RsQwtgdFhPbnK1txQ48koeGzq/HjBFcMIpjXRon984WQxHlPdNzud3/6wr9v99vhUGPGo3bmejd
	CJ7Mee6B/nu9AsHwKmmjHfve4pAJJ+nPwTy5K/99uhbWqxzPnuM9pCbGQ7ZlWGF0iN0YuQmw==
X-Received: by 2002:ac8:7e81:0:b0:50b:2763:2bbb with SMTP id d75a77b69052e-50b80af9dbcmr6475631cf.0.1774372044676;
        Tue, 24 Mar 2026 10:07:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b6f8bc1b1sm25862191cf.2.2026.03.24.10.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 10:07:21 -0700 (PDT)
Message-ID: <52a72fe5-d86d-4f06-bd08-5bbfd1faa78e@gmail.com>
Date: Tue, 24 Mar 2026 13:07:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] repo: show subcommand-specific help text
To: Mahi Kassa <mahlet.takassa@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, lucasseikioshiro@gmail.com, jltobler@gmail.com
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
 <20260324122111.84122-1-mahlet.takassa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260324122111.84122-1-mahlet.takassa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/2026 8:21 AM, Mahi Kassa wrote:
> Use subcommand-specific usage arrays for "git repo info" and
> "git repo structure" so that each command shows only its own
> synopsis in help output.
> 
> Factor the shared usage strings into macros to avoid
> duplicating the same synopsis text in multiple arrays.
> 
> Add tests to cover the subcommand help behavior.

Missing sign-off.

> @@ -148,5 +148,9 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
>  	git repo info --keys >actual &&
>  	test_cmp expect actual
>  '
> -
> +test_expect_success 'git repo info -h shows only repo info usage' '
> +	test_must_fail git repo info -h >actual &&
> +	test_grep "git repo info" actual &&
> +	test_grep ! "git repo structure" actual
> +'
>  test_done
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 98921ce1cb..0f7ec4da10 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -224,4 +224,9 @@ test_expect_success 'progress meter option' '
>  	)
>  '
>  
> +test_expect_success 'git repo structure -h shows only repo structure usage' '
> +	test_must_fail git repo structure -h >actual &&
> +	test_grep "git repo structure" actual &&
> +	test_grep ! "git repo info" actual
> +'
>  test_done

Whitespace issues persist in these test files.

Thanks,
-Stolee

