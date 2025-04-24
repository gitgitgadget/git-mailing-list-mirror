Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7A1F3BBF
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525224; cv=none; b=qoPNuEKbYciSvvAjwYpJBA7m3rHxyPxInpe+OmiRKEBR3B9Fhmf4QaiixgLUglTQPi7krfefXWVhme3j6foPamQaVVforASlc7tWoTDj9z3iYsD2uwrB70z01sqoSTglqY8MdH6nRJyBpTeUZW22L96nAwun6Qvni7RvFMoBFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525224; c=relaxed/simple;
	bh=pE5o1hg9mtglHe2ddfQ7bHeVEOMDd1u5FCDceEHUPmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcqtBy3orPQ2NPemQynlljNcWGU3qvcDQJnJJsT0kRoFJ9jD20Ja4UisP01yNMvh21paJfEiYzgR8T7YNm42WcvbyIxFOn536G3EELPp7mwJIWtMSOym+gIDSYIF0HgVvB9aHieJ91QExjI/bbEPI8bM2BpZIie5Nx8bQJSiBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3+zWtPN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3+zWtPN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff4faf858cso11820567b3.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745525222; x=1746130022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWJl7jhItFABCt0bioJKBDS7eCatG6w6IeCCHJIB7dY=;
        b=Y3+zWtPNuXf8LQxjwz7LAJW+t9oXKTtD2WZCJfKTWCnFA/DfM3M1Cmqs2o3edY2Rhs
         6joxY0YBfxN3BE0CS4xS0WxzEZ8cGvFHScacawPh4IMbWAIlpv/ORRqjUkTUTJRUYLZ1
         n5d9OsrNNffoKNB3FF9JBNmPaOBDS2saa5qcr5cyOdqVE+HyeLgT1GQrWw+FkF9B7idi
         abaFJI9+zdpeqvB+qgwZxe6/MFtGYu0RMLjD8ExK6oiFL448/wA2Phy4Ve29qZuJj+pS
         iioPGV23b5LcjlVuvzAvKpZ1brtQYsM6wNU8NPR+Sg1dd81yU/UE4P15narv2p4YIgva
         Nzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525222; x=1746130022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWJl7jhItFABCt0bioJKBDS7eCatG6w6IeCCHJIB7dY=;
        b=LB7wPhPonocpzumXTm5xP6e0i4KLKvnJ0msxuFcg0RCYZKudgfcelW3zjOAii3kFne
         W6A93IduRXXnSWF6PUvicJtIVZTCa5b7Es+2zvxiqe3YXbeLf1JCAxQ9b7nRTgWP8Va6
         nfgvn3qf+B99JYKhx01MMBfu1RZo1yAP0WvFefWLsQsdpNPBVX/eJHxJw/lmtdjfSfq2
         UPcq595VJEiJP0Ynn1soE+xqr2TvX3AgFcQq7W+fK21f0ujVU1A5PQhLfj4qjSub3Upq
         3cJThIRyngv4qU9nB/vdXTiDLXJ83lcmevQ5QzGpx0S/e1dCtk824fk51cpISYnFePKH
         50dA==
X-Gm-Message-State: AOJu0YzrW9zonh2jrQBCId3f5ISJVEmTIvBaskexBFgAz87hE3Rync5x
	pz6HG68z4PmlC+ZXPHYu1skQUSR8hjDwnxLAqkSPZ9gui618y83S
X-Gm-Gg: ASbGncvh4sloiFflbMTFdpVcUokABwAfIPhd1RvyHZeeSfRvWMDwyV3ryocr1Lnf2xd
	0E5iBjS9nbrP4kywA9efIVqeso0Ml6mwqOiH+iR8TE2oOG5Bzmu7JrLtbAHMjCDw0Sg1LFLmUmo
	A9mhmglILpajNnBmUxZ6c7Bnfb2ptY2b7m37MADIu0dgXZ6nWtvDSXhKkW2B/XKcqKrozd9F8Zy
	rZFp6dkL3IVqJU6e3PP3aDwKogpxGhsGHeKES8X+Tw7HSs4fTA4utuqzznH0zYxsqpW70aeCslw
	yn/btK3DzX+wn1weCHNte7ZIpooTrhqmAFjkf/154TYLA2Ih88JF1hgPhzK3745vR1YJ+iLC6aN
	TUBjMNldMGfF5n14T
X-Google-Smtp-Source: AGHT+IFs8+wVPemSk0bGIdatI/0CZlW0OX4K5rzY44fKWk/aubSIqBy+oK4dL3el4hV4vMGMd6kSUg==
X-Received: by 2002:a05:690c:6c0c:b0:6fd:3d37:99ce with SMTP id 00721157ae682-7084eed7b5amr17847017b3.17.1745525221791;
        Thu, 24 Apr 2025 13:07:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f47b:26f6:e1cb:3462? ([2600:1700:60ba:9810:f47b:26f6:e1cb:3462])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70841acb279sm5008907b3.92.2025.04.24.13.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:07:01 -0700 (PDT)
Message-ID: <9999f7f2-759a-4721-a4d0-6d3bdeb17b25@gmail.com>
Date: Thu, 24 Apr 2025 16:06:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
 <xmqq34dxuz21.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq34dxuz21.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/2025 3:41 PM, Junio C Hamano wrote:
> I needed this to make
> 
> $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make
> $ cd t && sh t5309-pack-delta-cycles.sh
> 
> pass.
> --- >8 ------ >8 ------ >8 ---
> Subject: [PATCH] fixup! test-tool: add pack-deltas helper
> 
>  t/helper/test-pack-deltas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
> index db7d1c3cd1..c8e837ea06 100644
> --- a/t/helper/test-pack-deltas.c
> +++ b/t/helper/test-pack-deltas.c
> @@ -122,6 +122,7 @@ int cmd__pack_deltas(int argc, const char **argv)
>  			if (get_oid_hex(base_oid_str, &base_oid))
>  				die("invalid object: %s", base_oid_str);
>  		}
> +		string_list_clear(&items, 0);

Thanks. I'll make sure to apply it. My GGG PR validation was broken
top-to-bottom due to other environmental issues so I had not seen
this failure myself.

Thanks,
-Stolee

