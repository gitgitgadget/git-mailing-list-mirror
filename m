Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701427;
	b=tnzHePqmq4/Q+xhmMm/BYmmzDZGmK7PcJhd/XDl2FqKg2XRBWdiyClydQYkIMbdVRFH4
	 ZwwwhoGM3f9WUUiARATylH9ksm6YjiSGcyldsVW26HAYH8mJ0NUsvDujkuCts6nsodCQ5
	 4pCoAevWQ8Dvs2+SD9MtpkmN9KC5fmRjEH+M+YiGFCu0g9Z5//FAiyF0PESTdWg1x/qr7
	 f2YW7rD4KcuKVsPvZ1lKxHAuqYtPaik1YKtz8FMs5fqmgpALrNjx60GoRM9QlJynh+6oO
	 2E2AT5s1nyyKibhKmBAIbXQi3cOwgaCRqjDQNn46MZLBdpF9CWiE6kGEW+ggW8TLOsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=I0V7iP+AMaFo0TrDeNy6CbkbEIqybiLaShUpkDx0t+A=;
	b=vF9rOH89X+zqRo3rIt1WjFtc0nbMR9Z9mfqAvXdZFFk+HEECaaG3VsWpMxNSXK4zBeqB
	 ogg4jCAgEyUSdy77VP+SRRVFqUBHRFCwnfMu2Z6pnadV6ruKZlJFlSoey4fTCuK7pTYHd
	 0i1sWD3cWTSW9bVRQfdPVC6k3qH4P8tfvcRnFr/Asq5wVjEAEvaPuzn/xId/BokD19Z0w
	 0Xpch+Zdl+FJYnTdTJZcl78NpMDXvnx9UZVR+yAnCGxPEJzARKJbXE0CXCI0tTOVq2jW/
	 JEFXMTFO9dWHn/CdCy5MHN4Vq7W1YxzCPvVZJp4tHrKCYI5xKuLIv+0ZZgRD6u+dHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A0U7nS/5";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39C606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B39C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0U7nS/5
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14394530ec6so597082c88.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795701426; x=1796306226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0V7iP+AMaFo0TrDeNy6CbkbEIqybiLaShUpkDx0t+A=;
        b=A0U7nS/5sYkFVkfJCp5oqISF9Cj38RV0JVF7bgWIyPAxVAYPstVLsIO0lwHrx9kvpZ
         jzsIw5c5yvEs0U8GEKCUULH7UL1llXyenpjU4F3jO3NH1jOD78SKaNO6pfr+oYUir5tk
         aG3tZuyXOILmL4yBm1pvqbAJTtUwPYstmqk8XGDeqUZWfCZrqW+NsuYb3BMCu1hfujcW
         EHQU4lKJ+5uBxMilVZS/qqUwjZj9QdRpaCcGiGDebaDV/pKPjt0BLgV5r+77DeVOjFVd
         6ybNpZJR7QYb7h/xGfgCRzvKW/ZNGxzON26z/YK14oAxp8RKQyjWnKRWsh/T+Q8GI29V
         hvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701426; x=1796306226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0V7iP+AMaFo0TrDeNy6CbkbEIqybiLaShUpkDx0t+A=;
        b=Im0i0KnqwOc+rU28P6srWdchcDKeoA6HHFuE/Ibkyb2EF64bsSs0yElJk8uSNKMFY7
         gu7vheSBYXe7bikZKs8JyJhbY7cNsGO1viFVXlzweYDJjBR14daU4lKn5XryLr7YscxF
         E3J3b/EynEdZuaWfB4WvCFElumuKLZJQaWANVxItMqhPlxh/QiSCftlPslg6EkLxRbjp
         IaaopRzSAaYzBWZWhzYxgj0PMUiDitk2C3yGuy2TClq2xcRXK54z6J045P9UyekyaF2k
         /9wPebJ8AOUMIZsRRoDcteW8jOJKbz2jj814oqWfZXjuZno/EkKEwdVhgRDjpCt9C4yT
         2Ehg==
X-Gm-Message-State: APuU4Z9gzRGDldNi2ryj32t4v5MrWBv+1aoaCjhtkvIVCgZCZzerzUPQ
	Oz9+avGSW9Tj3IW9Wn5gAy0VGVW7osk+GpO4HeKH22v/P2fvIiRNc1ag
X-Gm-Gg: AZFdTZfFConceKWlLiiuL5SwNy4WCuKqCjUoZ+2qCzLNclb91Xc+HIsdPBxnlMfewDL
	TlysLpll/7SJnVd5bPRfyzAUJ2wh84O3i1jZS9kz9PAsT7oAVMvpfLZnz6lOJP9p3+k3RW5KI7c
	H0CfDQWsu7s5hM+Ne05m08DEQjccvieUv02cm1MBnZWTy5nwCssKz869/CV7DAF6kzn/UmSr7ad
	EwG/+Pi/1bVGqqXTCcrLG2GbR2hEXZw2cpslAiIrD72UXQI7I5qz+9fh3NQeNrlGLZ8QMSnAxNn
	qugh+qjNghV0p0IP7iChNXhiAhuE6crW15d5cfm+faO+NuyB5HJd8rcxk+9/Qwqa2Qk4XFc/tTT
	/HJMmeN7M3QkWQbyVQXjxjiI17+ifPebCblkpuCNUjfzwkGj/FbSayeUsHlXc9FHPMqg0oIqOC0
	NULVV11OJt1S28KY2Aps+wf5+E/Ddxt0Yt+xOXi24SVbm+HA7gvr4V6MmyYO8ECvYu6hcDk0ZG6
	yWduQ7kKbMPqUVoN+6pC7Wk9rgVNga35riMIWOs3JM3xTWhzd8sLWKfpyWGlSwtSmkFIyyrWcyI
	cf2FXgzABTuXNGOFgBhU4bE8dGXupqbVLcjCIVpT/yYtbbaMswi+va9oZTH/B8AZFyk=
X-Received: by 2002:a05:7022:f509:b0:1a4:4194:fc04 with SMTP id a92af1059eb24-1b5568e4322mr21472660c88.28.1795701425903;
        Thu, 26 Nov 2026 05:57:05 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm50431164eec.1.2026.11.26.05.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:57:05 -0800 (PST)
Message-ID: <3b70d34b-5dba-48fb-ad5f-137e73c36c78@gmail.com>
Date: Thu, 26 Nov 2026 19:27:01 +0530
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
Subject: Re: [PATCH v2 03/13] loose: add a flag to control whether we write
 mapped OIDs
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-4-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261023072559.3204273-4-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:55, Christian Couder wrote:
> 
> Right now, we always write the object to the loose object map.  However,
> in the future, we'll need to temporarily store some object ID mappings
> in memory so that we can rewrite other objects, such as when we're
> indexing packs.  Let's make this easier by setting a flag indicating
> whether we want to write this to disk.
>

In retrospect, I suppose the "Let's make this ... " phrasing is kind of 
an unwritten unexception to the "imperative mood" guideline. I could 
find a lot of commits using it.

> The bottom six bits will be used for an object type in a future commit,
> so pick 1 << 6 as the write bit to avoid conflicts.
>

Nicely explained. The patch itself looks good to me.

-- 
Sivaraam

