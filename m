Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFE2EE262
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203289; cv=none; b=tMVhtULMMioj34jZuyNf+LO/sljmIlKv1+48MA9ti2d/LrZtqDFxBSJcKOTDdriGRPPOwHs3fDXEgd6XbFhZCyOm4Kg2WXZ+bR4374q9fJZMEkABMOY6/wfixi1tVYvvXETBQiBi7/v5h4NH8qzYT9+rY/e6Csb/dthRs52jT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203289; c=relaxed/simple;
	bh=bU3hZ4meFNUMDXpQAfJ008BSj5ewgIQ2V35o8EzwvIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqeI9tgHW9r+WL3nJrqp0Ei0Z2I29zaRlSe8zLQShhraOotIQlStlakWl46hBkkB2+8Qi9v0EYSBzhAGgBECSGSs0QtN74RgLPBxiRP7Kq9CHmI1VnUdp/hWkIAyX4wgUb7Iu4vBX94oHlnSj3BDz3Jounvr+s6qd/XvMdrcY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyBPaQD1; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyBPaQD1"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94de664b541so809340241.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779203287; x=1779808087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvAPF1pVm63wmtxBui/V78Gv7jIFJ8ov4uCKQk/+jMM=;
        b=fyBPaQD1B4lVUuy7XE8oQcUg4TYenbdu85pzUpaXMRmoKmcb1r5YjqWEoKlGjtl8KZ
         67iNcgzULlTRkqTWneGo2+5a7iQVX8+lDD1WuXkkihJTfeV7pwB8Q4hyvMZAgq/3vsYq
         nL7hyxokQtG6Mau8vAc3ocvr9fv2AviSy52sR1b+fCz89QPFRCOVEELlHESE+QnaSabq
         cAoVN2UcJOYwR//OzsValP31tT8MTgsmCzu0mqWsaebDd58VcQ+TpPa4Dny2+yEgj16r
         2/DCT7jV6fFJIIN/Wd3rzxbzF+89gzuLIQi1CwSnHxCmf4KTA28IvjJida2IYo1X4DuB
         RTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203287; x=1779808087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvAPF1pVm63wmtxBui/V78Gv7jIFJ8ov4uCKQk/+jMM=;
        b=NNQAI6/K1WO7mZtWcnOjVQLOr3gu6XJT5s3kSvXcYK0GN1aKwVHHU6UtQb8a0oXlSE
         zS7c4HnIDpbbBBIuJVj/Vgz0alUuk1Qxpr7rZeLarqbSy+2I3iamIAjzgh0L50Efy29J
         u0Jfl5z9a2aRUF1m0wJnz27rLzESTG8w47s2hRsO1KsCaTtDkurvOasARUjxXmFs7IXr
         Qv91Lv047PsFhrJHfJ/d11E95CuHDSCSyDo+B6CoziLp7EaRMi4ktASwO5K01Z/aezXB
         EJy7hOOy+9flPKG9etBIW5nauBx3fn4FkXCitfJKObhxC4JqH483FIMZggJN0psnRSxv
         XxCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UUDEUUoIOQON83uqQCZB6c6QLTFPFg2GHxlw/MdBmN2LDbU4sjui4w1dStZyGozPFci0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8+fQ22xrutFMdbmKp14To5hthna+Bympsfhsn98SiLNQYUPg
	zowuj3tEbz5RcIuPETsecDDNXyxluVYAQVqks8xiNzU+Zd7ReIocxJad
X-Gm-Gg: Acq92OE3noqVrUVfhNJUzwxExdO+2jyCTvn0mgyE5ObmruxMt1S6jezEkG7WuyzeVPJ
	y/S2KNqUhWEibBMrUESyhgiiK+eVbr6e75QYBTXqIs21yzG/TolFEdMQEsjCxbiiif1RUoPAz6c
	/sDPJhLvqmOj47sTm2b+/Sq0B3qOFJslyDARRBbl169oXcqX4gtbNiRsGH16Sl+1GaJ8wZErRBa
	a8KKKG94ODjdn2IXXqcO/xqmEgHMRR8afJNQeSJsGbmxV+WEaGOtSB0Fv3LjqqLYAA+gF8r8CDX
	IYjqboFOkoYdSpb4ASYfbjumYKYQ34sCPmXHqkODQFgUXyFBGuLT0fGtwl69kKNT3AcH7lskmpD
	1ocptj/qSBvB5vQjd5cx4tkK14qI0pdlJNhtGSmU7y+rdkS/XUVXFy715XU84eQrkc8ApWZt0hO
	lkZKm3y+Rbc/tIad92uDJcEONF7bWTlC0L8axY3kZygousUC9gbw99WmuNhyQmzrst7KKtWw==
X-Received: by 2002:a05:6102:80a5:b0:634:5339:33bf with SMTP id ada2fe7eead31-63a3ec894fcmr10111877137.18.1779203286561;
        Tue, 19 May 2026 08:08:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905bdsm93042176d6.23.2026.05.19.08.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:08:06 -0700 (PDT)
Message-ID: <b78904f6-5465-4dcf-bf6a-629f925ce1b2@gmail.com>
Date: Tue, 19 May 2026 11:08:05 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] fetch: rework negotiation tip options
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
 <VI0PR03MB11634DBCD7ED97E3358AC9339C0002@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB11634DBCD7ED97E3358AC9339C0002@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/2026 5:13 AM, Matthew John Cheetham wrote:
> On 2026-05-18 21:19, Derrick Stolee via GitGitGadget wrote:
> 
>> Range-diff vs v4:
>>
>>   1:  7409a479d6 ! 1:  538913a327 t5516: fix test order flakiness
>>       @@ Commit message
>>                   Use 'sort -k 3' to match the actual number of columns in the output.
>>              +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
>>            Signed-off-by: Derrick Stolee <stolee@gmail.com>
> 
> mjcheetham@outlook.com, not mcheetham@outlook.com.

OH NO! Sorry for this typo that I copied into every commit. 
> LGTM
> 
> Thanks,
> Matthew

I'll fix this reviewed-by tag and resend. Sorry :(

Thanks for the review!

