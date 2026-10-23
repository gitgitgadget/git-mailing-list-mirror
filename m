Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738617;
	b=thFzwIv18jbzA4P0jOwHdVHJhDsXVa1sJFB827P4u308LpYA3sng2yqOW5XodkDkG/RD
	 Nx/HSfxioXoPznDEBsPq8OLaEJ+KlWpyGsSl9WGMmn6VMthFA6jZACfZ/MncP7wtwOE4A
	 dq0gAi5Nz/sxxclIu64Q5z8Om/1i1hMT9N/pxTBeUtdrbHCWYXuLBUtAhYksPN0/jUEO2
	 fOWY1iGeML5yeHFpPp13+YWRY3zLfloMpE8Hqi+C8gZjNdCldK+fJQw6I5+3n2gV/1Fum
	 ztixYCUUfBnwMjEVtxjoUYrPsEsc+otVtQ3J8+vhuekBDFi6hrh0kSOrsxX8GshD9sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kkv/U1Wivoo0C/uPK09pT3GBvrAkxbvGGNIYXB4PqkE=;
	b=EcnpJ2ebwIYquryzLKl7+zHC9IBFAcj78C/PP4ngk+nRgUgI0i/ndfCOmLvB6GvLOgv8
	 4O2dQzpPIr2vebY3YcckZnMnIChkOyQXTG9/NJ2vGCohSb6ZRAA27xXNMn4gP9ICciETX
	 95Hs7s9F3Y3ZlJn5beJYU0C1lmRKSESXCvvbyTcXf+uNT4pAxMhMsFb7uQkW+kyY1A78L
	 5K6bNSBARVRzO5pLrXqYwC2X2IG12gmeD7r+pTQKVUfKcg1EKzVN5dwXW1vUiuStTHbGE
	 Y91q9AzesawuA/AvSui3e0RBgXFMH2hP1/U4AN1GYvoR6/fJYVFv2iQj3Le1+ryaZgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fPpahITf;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D77606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D77606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fPpahITf
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so278385a91.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738617; x=1793343417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkv/U1Wivoo0C/uPK09pT3GBvrAkxbvGGNIYXB4PqkE=;
        b=fPpahITf8LLvyEJCMC8Cg3KZRxZ4BoGPurntYSApLJmC5Sw0xQDR1NxgboJVk3UbGb
         j9RNPpax2pl3BM1RYaXDCNeqUpglV4Ass3rzWT8c2qKJXj46wn3cCul7JqIZ0goeeWTo
         gTL29BAbaDtHWcJyErAE43dpRXVwL4KrUHXarZxDYpkNSUUcVjYKJPCid+hIE2GAqwhK
         I+gAYLaxMb2UbC0NdFqkDPTxKgFJCK9rhOhZcXhGtGqi9RysFQEHQwWjqG734fIaQuan
         lDOf7IGdge8ZVcKQ3pUvFZg1JM7GEK83w3yrwwFGrW6APasFDx5WZ4a0zGZZHteX34DK
         QfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738617; x=1793343417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkv/U1Wivoo0C/uPK09pT3GBvrAkxbvGGNIYXB4PqkE=;
        b=HxRVv3+YxDXBQLl28YXHsNp/ArfRcO2/sP6qLykb/HwWgZVNBcrje+W/kCWHQekG6L
         XHpD1dCOM5mLAZKmJQ8+ZLbq2yL/iL+khVKshRAWa4G+58kK0cwgIlSpfZXQH8NBqyQ0
         NFXXbkJiJdDFjFHrNPxkUNwIoxSU3f7FYdiKRCSR/SraQ+4+pXUoF7dKtxkT9wFuoXzo
         Pgjsb1UKlHwYkRJdHtU421+zc6AAnINGvJbKgGaOnnc65MpjrOVW9X0jurqKdSIEVswR
         ObGlM/PRyVOurKqQg+NzSriP70lV17iGpxN+MFa5QYt2muiNmvciME0JtvJdov1YCjnN
         kIPA==
X-Forwarded-Encrypted: i=1; AKwUvByVfMzvixFB77vx6OLjoydeiJpMBPowHSLYv4IULKiDf5WvnTzHcuupe+jDIXzSdGA9OV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV3ZUMNHzk4O7hEu1Odu/8sUWy+OrT22+N+wS4ikbveZdgMlX3
	OBMfootXsJYOMCoH8OjJeWaDMprs9l3HXeejx/8iia+eLVO83Gm2HsAO
X-Gm-Gg: AYBFou2XoJQni5/MZPxZ2GA6tXGbjWqNqYsPvj+N/MYS/tvToI1MSGQJMPI1i6BS/Kq
	TwIPyME/ZHUzAOnGd8u+4UlHKWEwFrt+cTk0sjH89wWcPL3oIGQskFypVWaNHg4qUxoI9DE8Ioj
	AGzcw3Rh22+cKV3ajvpdfEZ0qnykMBt2VgcsYFJB9kn0NOHZMV5dgDm0V/BoD9O2mQYRvnWaSLw
	ss6arOoFWmKYswqlQSthflFS6XrXMvNRVsM4dGWRTEZH1CAwhG+KwgZTrfz/8RrDjIBtDsiMmtN
	5HKv1jIGJjqlvKsrUNxa1NxPSxLPR5+HzqAQF2L2S/1oz1tfPCuUsuac8N6yw41ZedbcE0IfRza
	X//3t2Eu2h2YVXhARSAKfgq7kDZd9Lt6Wu5h14ODKTSByrG/QfKpEjzv6h4+wJPGzVITasPKdP1
	NMwZKUjwA0kby55i542X3ifsPbCRKjVYM/Iq87jBSriZp9rBh3VlN0gkMaVvUjuqNAAkU8ANhMy
	j0J4IIWci0vcRoPJ7rmrL4esu4gkaQcQmAgy/ZrImjPiFhuYY23OWxeDW0WWAIFz3dKRCeMFQ+f
	A2Q32yysEdir2+EfSWMcfdv/H0YRUo0wxDY=
X-Received: by 2002:a17:90b:1e46:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3adce0ccf4amr966006a91.9.1792738616868;
        Thu, 22 Oct 2026 23:56:56 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:64c0:b6fd:f107:8ea8:9e90? ([2406:7400:12b:64c0:b6fd:f107:8ea8:9e90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add2a132f6sm529468a91.3.2026.10.22.23.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 23:56:56 -0700 (PDT)
Message-ID: <2a050885-a1c2-48d6-b561-3c2ea0a05dbf@gmail.com>
Date: Fri, 23 Oct 2026 12:26:51 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Shashank S <shashu8660@gmail.com>
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
 <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
 <xmqqzewgosyw.fsf@gitster.g> <9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com>
 <xmqqzeweopov.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqzeweopov.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 22:40, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> I raised a PR to fix that:
>>
>>     https://github.com/git/git.github.io/pull/875
> 
> I do not think your update is taking us in the right direction,
> though.  Recommend to have it under three-dash lines instead,
> perhaps?

Got it. Does the following change read better?

diff --git a/links/mentoring/soc/SoC-2026-Microprojects.md 
b/links/mentoring/soc/SoC-2026-Microprojects.md
index 41354b50..17519e2d 100644
--- a/links/mentoring/soc/SoC-2026-Microprojects.md
+++ b/links/mentoring/soc/SoC-2026-Microprojects.md
@@ -49,8 +49,9 @@ with Git's dedicated test helpers like 
`test_path_is_file`.
  - Start small: Pick a test file with just a few instances to convert
  - Run the test suite after your changes to ensure nothing breaks
  - Follow Git's commit message style
-- You _do not need to_ include the command you used to find the instances
-  in your commit message
+- You can include the command you used to find the instances in your
+  cover letter or between the three-dash line and the diffstat, whichever
+  is appropriate. Do not mention it in your commit message

  #### Need Help?
  - Reference [this 
discussion](https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com/)
-- 
Sivaraam

