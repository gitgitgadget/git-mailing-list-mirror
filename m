Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367452;
	b=sGjYeaTq3huSBL6ghU2fC+1oIwhOM1U+zLvPBFowvfFjSbcVivGpbJal4Z1fNSbtAKEp
	 jMtGbwCysO9GyKXoIk/yhfcoroj/BdMd+LIEyJtGTGO7CQyCI1R3/PxNxUyGwp/RrErDk
	 Ixdw8laE2LTN+OceeBMys67mElXR5x/3RmRXE/xqEQ1lfDvZg5jQmLf5KpiCDmccELFJI
	 agmX+6ggut2hsKdIU5CayakXWp5jCNzv9lkX6G0QmGdgXLCPy3jCQvYD3oa/K+va/sPrV
	 ezhxo0f4fe5JQLVSrZQ7uhoZLQ0a/bdZyP+nQfMlnfaVLoQsntuVCY/f1DT9RISP+FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=FLrmH22bUJ/zu/+zjuLfP33AiMGYf9iuaoysNKY71sg=;
	b=eLHHdLI0HNDu6qAV8yFOJJLU+n54pYHqWJgH1iBqy0HGSLzdigEkXFrpjUslvh0GvhqQ
	 Vn/THirtzJM+stezLHTCldrTfoqBE5VQrk4/q+2fBAVn37ErVU6P8OpMq/GpUg0VYFvds
	 7xvRDtwkQ2iCeKSNPxQ3mW6LNnHmCDT0X9fTalbpvHm2wyNoZmeWOrD5MXfOP2fsUk7HN
	 OkqaXmXuCLXtPy4N05NFDJtBmZdI75pcW8mfZKQlJhGtg+L/wYInO7kKKkWQRTl0qDMoH
	 O4HeKz0jvq6ik4TcbkygRj19CuOLSImN2YUioARQxnHH5CcxjEQU0ECPWe/6mH9Z7lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfJNsAeo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED0606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3ED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfJNsAeo
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3aca0bf7fd0so6298761fa.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793367450; cv=none;
        d=google.com; s=arc-20260327;
        b=Oii/QIPksqBfeTuk8FK8S2NuEbnLmBGEv+c2slwsqQKGtui0OwWCtOSxh+djkgPT+7
         J2EaUl8m8FCNK6k1qva7MFKsRM4SXZXXn5R9chLT1TmygpQcA7s52oWFxIJ5J3cA4he5
         RcIVH3MoBYElfNN0zAHv1cTfBL+n00dOxRy2CMZMF7IPMiI3vwfTOMLgLyYlLWqhbcET
         FGaWj4lU0aq+HyZXyqHANWDR70XMbRaRO0pVEs9igaeLRUHFiGjlvlvdmn3Re95tRaqF
         C+f+geKP2Kg6PLxexNM4AyKHv6atiiVsrz7KSIOVWVBdzs1RAZtGayRx3v4UWx1w2S7P
         OFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FLrmH22bUJ/zu/+zjuLfP33AiMGYf9iuaoysNKY71sg=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=riy8jHVNFLw7WkffZExk7/x8QijQ2HUxmbyZ0wxtMj82fBdF+O7uo3+Kgcg3G7r03Y
         c2kl65+1nGfBRqo19Zq6fLXArBNJHEUUVXMJWoReeWiAy3PjbwbiVojwrgpOedTEyBMW
         3xovk0MTqE8ovFnoDiJgJXmkkIhVeXlI7EVMIwGccTNBjLos2H/dyaGlHAbKfUpbNQ+O
         AY4ybXeSs0a8NqX2u6zq5sZv0WxTqHEA9rhsmqMoJ1ve+8MHoTE+iRnx0wXb9CV6XX5L
         A+tQFcAMGM0tENIyE04tyytOPipfNHNSNzNO2aGzKDaSkfHuoivsMaWK54GeipBnX/PZ
         DaGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793367450; x=1793972250; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FLrmH22bUJ/zu/+zjuLfP33AiMGYf9iuaoysNKY71sg=;
        b=HfJNsAeoQHuPy5KzWfm7ttrp73npj4KoFPmqlnjO592tdM1GdNRQMOI1gsgVmG6dKW
         Kmr+ITLbJ37e1xEgaHejjBcCpMfnQ7NMQ3JPNXrJscWqp1Sdmki/mmxMA6M5br070nHh
         SzMRi1Y8wRHPMrgo7UQlTRmmsGKZ4EJNyBLxOQP4ROXR0nktcIAA+YbE8DEnC7bNSIpM
         mEzt0Bj0uprCWeqgL2r4lltFFhvgerJfxDILFgBL92d+CYK3X69u263T+umDi9Y4tjut
         2gkTPsM9nLk4IUs1j7kZguvycVqXkBvjuMi7S+eyTDU89rr+q0Mamygs9wQZH1AvFYJU
         Du2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367450; x=1793972250;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLrmH22bUJ/zu/+zjuLfP33AiMGYf9iuaoysNKY71sg=;
        b=jxYzhVaMyOUZo0vUeoRDINfaQuy7Kg3FVlN/XAZ4sgv6VKqwN46apFHSoNDHqEUmKR
         /pumHVj3y563EKXLWHg90hdzAhC+g7B52pVuJCd9Pz1SgAqN/vSkAPoW1kPX9v/HpL6z
         f1kyI+d07GN7/P9ku3hOX3/ka1IS60UbbGmllFkoWqHrXoFypSKOlkvQWTRSr7xN6LCq
         tj87J08nCEh9DzLJus88yNqw7qeMxASOa8irZHaa6epSVaCcpfQVrXcSaQN9aDDqlg0T
         6c+zgPOP6XZObJ1dGK98biPC2/SmLN2KwNt6MmllqeYJoDTQSofAsmLBdCuEAoaCvmSJ
         riEQ==
X-Gm-Message-State: AFq9FYKoVsmzx5VYoEUCTr3Zfq+muZljo2kSUssnnjZFWrjai+kcrpJb
	y1Kp/Nx9xP7qShRSWc6eWtBWBF64gpYOIFRTqXve+EYl1b4S3XVrZ/MljHXgdDUlo0qtKFHwkgQ
	xSlRv7umforyy2CZgV3fhwZqSIuzpCK9XeX5FtBU=
X-Gm-Gg: AYBFou0VzX5VPoRwXyJgYm1kmjXIf1t9A/P/dd2AHRYBTvYi+tV7OLeHbsP6OVn27gi
	Gt+MD378bQ9j78LFos48D12h2t1C/YkTwHUvCs7fUctADqdEHWrXXZNaty5Oy+9BVhZhlmdeZXR
	ZKSmSZzl4gPgpxyTLZhwgM26mv/ZYP3Wq5rpzkVZ/9le2ZHpW1w8xYECssEyoQxuEE6qSXr+Jks
	kHdT+9mrL3McCAGQ8QOa4pu3JzMzu7dwTSxMWPJCANzKNG/KjCED1sq5t0zdMw4YMwZlWr2B1/R
	eRFH5NpEd6iin2BFy3V7FZX+MBKXf5Wju0qNReZABRTDZIfWMY8ohXG6gmRpnCF72aw83ltyjJC
	t0NN5Km+TjPBWjd5lElAtvp742bolGfqy2a9jjjWBOmTXjs2BiIb7AGX5w1CqFS2J8c8=
X-Received: by 2002:a05:651c:50c:b0:3a9:c1de:852a with SMTP id
 38308e7fff4ca-3acb7963315mr5080761fa.3.1793367450021; Fri, 30 Oct 2026
 06:37:30 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Immaculate Mecha <immaculatemecha87@gmail.com>
Date: Fri, 30 Oct 2026 16:37:18 +0300
X-Gm-Features: AclHuK8Hy-thMkm_-cfKtLIJn9X7QiX3Cb6RmRxWdsTgfiQkshJa9i3KrMgueuU
Message-ID: <CAKUOgLzP0CSwOwLeoSpM94A+XCT2X_cVojHsLugDfw+tBZk9LQ@mail.gmail.com>
Subject: [Outreachy] GIT_DIR inherited by shell aliases in linked worktrees
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm considering a small Outreachy contribution around repository
environment handling in external shell aliases.

I reproduced the following behaviour:

Create a repository with a linked worktree.

Run an external shell alias from inside that worktree.

Have the alias execute git -C ../TestBaseRepo rev-parse.

The nested command reports the calling worktree's Git directory and
common directory, even though --show-toplevel correctly identifies
TestBaseRepo.

I traced this to the inherited GIT_DIR variable. Unsetting GIT_DIR
before running the nested command makes all three results point to the
target repository.

I found the earlier 2020 discussion about GIT_DIR inheritance in
aliases, but I'm interested in whether there is still room for a
focused contribution, particularly around regression tests for linked
worktrees.

Would this be a suitable microproject for Outreachy?

Thank you,

Immaculate Mecha
