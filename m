Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58622280A49
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628594; cv=none; b=LPBfI4HxApqNmKJPAcNZz8tTbrX74mwM7KRp/WJGzAUWuMK9ethBJ3zC9B26PAiBiqklUmM0ZJyXcEqN/uBVZiGGwj8/zqpVZvBJMIKGp/N3+DSJKHbeMzkEDUnhDkiepFd7e0dcbA44mx8myQtplVqfyq8CjtLKjI4JSqhET2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628594; c=relaxed/simple;
	bh=P+N8UKCDswnloa0QDvu6jszx4FQ0NEM+LC2KgLHp6mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RYh1ruiZkhP6CTT2BNdMuVOsGCfI5ifr4L5NmKR82edZhaxa77IwoNr0HL8pKOzWS7U89KmWSU9qCLlrlhKWvUQZWYJimhgyBzQE9epZHlBu/6s0CwthwHdKPI8uZ4iVOjIAnt/sgIljswN+Fj5mCEWeAVZk0rPZ+mPpu0cXu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y70Pb7cE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y70Pb7cE"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-703cd93820fso40051807b3.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744628592; x=1745233392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQE8PZMFYQFWdwwLc4jW6DgvDvCeaXloah5iV/AqDsg=;
        b=Y70Pb7cEKXyXl1xKkcYmf5HPYMCGf9k0r9NN4ZHErsItLHvEtkzjwxAk6ACaeo9AzZ
         S2B+D1lSSLIXfVZsSyuoCmI+6q9Bv+r0VC0W0DfRPhqMHj3VzqpGhK6CZzOaw/zQBdMV
         Vzrm8HlEM4iVoDEzNUk9qPBo64RE11wPUFfjUbgJ/666CQM7sk6jv7UOYEG0QWnFxHQD
         JVZQ42A2IMPdEebx5a0vNbjKtIXARptVRtkL60FWIrTASGNWiKUMQnjYpvnVnYJ+lr6z
         Z/4ELh9ktuDLBnN9m/lCr5I/8EI5wvCMExZHHkYdMS01ZHQQ2Fn4YkB53FFSbzAWpP60
         0+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628592; x=1745233392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQE8PZMFYQFWdwwLc4jW6DgvDvCeaXloah5iV/AqDsg=;
        b=cIcjYUd1WgBHzWJ5+9vIwGh8kLiuL/mRwwGLP1Ls5DOYIxzuxtEPryAxzshu8JxmR4
         2B7MYYabo5RVaGAf0ro8NhxA2bb1Quo8bnUbKsKOjbcx4VrFJBPnBCFGRkmq9Y9laVLe
         8yMIxwhEHDErInDfGQzdgHUPrkiwmSPTY2lXBZE05v7DkIxkCEqLci+3U9FEMMLal2oX
         s/XCGBah8LXkKMZU3MztErrnNrGhph3A+sSCU4mYD1XYIxuugJiXuWunZ7XEJAiH274i
         OWQkyhYkiP8beFJF8jZxs9MCHlZwSoq7ol5RnTTEkWBVokxHunEIzSFRoAt4c8zSFHPn
         gitg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Xrj5KYpbYnvsXm+0ZhXOwlpzxwnzYqI+ylZNlrOxR8yWwARa/rW3yd25A/E3oe777ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6u2Y6/DSNjeZcNnBt3tBQWJGbY1oznjLgOBAKSUh5ASyVPgPN
	4kCuyH+HBgthZ/2BGA/efYjtoAg0LF4BrVkh2orIpVRz80MiDrBI
X-Gm-Gg: ASbGncsy/DglM9tFKA8aKPuV9iisKTumjKrxGwceMi81z8P9cjpX7t6OmsRQ+xlKZQ0
	PqikbIzwCsZrynSrZlqp4x6v98MgqcEa232bPWcsAZBBRBvX0iOwGupiZIlcw/M5jqnbAEH/pxf
	hqzEKUhNMZI54rdnRtfZg/tVflr1mpihmEPv5oEqwIXYX221P1mtnzGB9+EalIDgmTrIp6Z3aIX
	YiZjHyYVMOdmn30dmcf4ul9HocP89X+W+8HRjh3vUEmL1B5bouIeuUnxnQEMI7RM8sPFTgNb763
	55KJS5sBY29esSMfKn/HO+JxUIfE73fMfroLyctYeMT5MiafKdO9R382DtAxcrkvD2+rO7oif69
	2H8JBy+1e
X-Google-Smtp-Source: AGHT+IGFsiT+HZJA0kXIOwcKu/3ap1qUKqMpLiTTveEMlaJMipUl9tyAIQEBm2t4utVlPH4fPWtamw==
X-Received: by 2002:a05:690c:11:b0:702:6276:9446 with SMTP id 00721157ae682-70559a99c29mr164639137b3.34.1744628591873;
        Mon, 14 Apr 2025 04:03:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:7c:2672:658:1757? ([2600:1700:60ba:9810:7c:2672:658:1757])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11a6f3sm30114747b3.40.2025.04.14.04.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 04:03:11 -0700 (PDT)
Message-ID: <7c2b338f-f795-4957-aac3-20e6dd5b5f48@gmail.com>
Date: Mon, 14 Apr 2025 07:03:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/path-walk-2 (was Re: What's cooking in git.git (Apr 2025, #03;
 Fri, 11))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
References: <xmqqmscml2zq.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmscml2zq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/2025 6:58 PM, Junio C Hamano wrote:

> * ds/path-walk-2 (2025-03-25) 13 commits
>  - pack-objects: allow --shallow and --path-walk
>  - path-walk: add new 'edge_aggressive' option
>  - pack-objects: thread the path-based compression
>  - pack-objects: refactor path-walk delta phase
>  - scalar: enable path-walk during push via config
>  - pack-objects: enable --path-walk via config
>  - repack: add --path-walk option
>  - t5538: add tests to confirm deltas in shallow pushes
>  - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
>  - p5313: add performance tests for --path-walk
>  - pack-objects: update usage to match docs
>  - pack-objects: add --path-walk option
>  - pack-objects: extract should_attempt_deltas()
> 
>  "git pack-objects" learns to find delta bases from blobs at the
>  same path, using the --path-walk API.
> 
>  Comments?
>  source: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
The current version (v2) has not received any comments yet. v1 had
some, which I responded to, as well as some exploration of the use
of --window by Taylor. I haven't heard anything since then.

I continue to get user reports of folks using this feature in Git
for Windows or microsoft/git, so I still think this would be a
valuable improvement for the core project.

Thanks,
-Stolee

