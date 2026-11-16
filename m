Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844953;
	b=MVWep7HXJvn885bKZcMJGo90VKCfS4mt7SAATAH46sPvWIPrzsojStlLgMldg2HAmYOa
	 BqQXZKUzyGlKVDlzLNoab5Amx4gvRTvSGB9E8vqHwRj+WqmCtWEgO4v02EUesAFJhKdvu
	 TscMX05z8zLjCF31H4F2bqr2gS/XBJMYyEGG/MHRpXxagTMuh03RlkRKbOTTLRr8E3+V4
	 Do8OSx939s+tV/L5yw14xa4rP9qVgxWmLnEs6PNBSsfgJHJv17I1UfwSxAv5Nxekh8DgQ
	 bqgvxl8ORJ9lINKVOMKBIA5aqxUl6m477z0nV2yMN4HA7Nhl5PIyEuopUqQ0n+jbJ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V9t9EbQZswYmjqIats4JYD/eFNxWJmw3iWg7tgos7XI=;
	b=OQ/wxmiW4Az2UdrGs51TyCO4CYbFyOmOgKCRyngTbxklvgN/Z7bEX9mseIh34gbli/tN
	 r3hhZ7ocC/hrCG84r2mep7k6OOorSe8LJxK4n36ceWuhtlSK/os0w0J90u1AVyAtVWQDa
	 sKncP091BrVefDpIMx/qiqAZ8N4QjNUB7+/k8C0TyTfBPZlUQ7JJNcA06zwTs+myc6ygs
	 yByWun84pge8w0lPCDt6jUZq6HQmvAcJroto62X/lfQAYny7z9yqCIItQkQ3+V1nRw2OE
	 Pw4S+6Da++vwnw0hGAga+5otJkY+cMcmVEyBfYrerVibZsZ5myDtSKe22f6N0ZgDVZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAbfYxFg;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15051606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15051606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAbfYxFg
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f30ff609eso28892896d6.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794844952; x=1795449752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9t9EbQZswYmjqIats4JYD/eFNxWJmw3iWg7tgos7XI=;
        b=pAbfYxFgonnxtsNIC53z4YwrkdK3vAWtTxVeMdYb2cV3YKMjf6Plf18znlhszWjkFR
         +oSltqHBoR+grllQENN7J64Znn1/pRESWRpXmS+aXhJRSlLzS24heEoVfteL9voCFfQq
         B7BC8wpLs4dvEvMmsl+DCDmckQXAFoTV8gdt8JfHIWXhNIwGRoznI9/SLHII1ybM7z+q
         EBeqCIRSSo+WM5b8VOYbGpNEPbg0f4g72NcGEl2uCHEGgPo0LjYwbda8rbqCZkDvee1M
         EFpsHSqeX43Z1ZpSAXN3SY8W5JYbTg6qdyWW/guSN4zby04BwBq4wpnC52tRKnVgJeoJ
         0m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844952; x=1795449752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9t9EbQZswYmjqIats4JYD/eFNxWJmw3iWg7tgos7XI=;
        b=PNyuZkvw+71B4S1fEo+Abpb7sO0gTVw04Pgu6H/M8v24pVpj+NgN4OsKYxCYQ4Z7Dd
         NhPDIAypB9OzqrE+C/KN+ft2PzLCHy1oKzA9KJ1j8qwuaaGUQvyqLGYgVBFFSZTRIlCX
         Q52PQvFxTWIGK3qUcqgd1bswKe9FQ5urHu8IUiKfo8C+eaJBGdeUio3fVXtRfMkF1xt3
         2ILbkVHAI5n5UjS4LCaOZ0Up4ML1vLKn7c2XR7H9rV6ffDiGbp5RDlxVhKBZYC2/b+OV
         5fxCSzR+QyEW8+FMTlRAMZxfu+Fkjr5kDMBnyRvqSn4ka5pQXvadpZZZDto2bz2aGDJF
         IMJQ==
X-Forwarded-Encrypted: i=1; AL+hErGtzhC/VoLaYXrLe8Tl9IA26yoFGuoEQwBbRA/hfcEUIiw4dViX9iEakKRDbrxP4AZvVaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G/DgfYPqBHh/f6UCpry3aXSzyAVQBu+RBFNzRFo7ePVE70s0c
	6SkBGNI/NRmWTAo+a0EqQp24kDDeylGtAAaopRMyY2b50TiautSuODsfdmz6qWbC
X-Gm-Gg: AYBFou2ZOJHzbU5cNvSvvVjL4pXNY2eTetBq3rGWkICYFM+4kPOfmyvI5HXsxvKzNgo
	fkq/yaTmIjJMl/8DvWjDIT21VC48QvWYCwpSxsV6T6Z6Vt1vzAxYhRyrxfNfH4wmEW0pYXQjH44
	BF3TjqYOYExGXnfU+wxdL1iiLYQMmOjuT/nWNk/51Fq2bsteZJIBYR0LAgqJ1Y7DPN8eP708y2z
	kf9Nk5a5Ea5d1zSJXqtGFjfPKjoqETh3UNf5MUeMTQss27cj5gmrN7pUqxEko0ECACpuEkdCJ6c
	3GhgbKhCHmcEV2cNWzUgJkp71N1k1sIj2sykeruAJPUYtOCpn0umDski083Cx6FkMhNr4wwpeUh
	+R2XRd7Q+8/q43ON7J2EQYPVpRM74AXV9Y3Wmd7dZS/5IPXY9cPkupzP2spPqZCOL+0PVr+pKmz
	L1j5Nz84m59Td27xa7/vWEOvSNfKj0eGoziLMF0DcwrT8bsaPkUBP5t2Dv5iKcUTVrewezdeztu
	PRTKOJPPo7hiZfBiyst30xMkUg7ec37jfzxXRiHb7zgq+OrqbjgDu9+9sMkusmuKM9BLBKwS1/e
	V/6bATDQC3DRSkAAtgkpfr/N+Mwy8ptL8bBEoD2P91ufuPCrQrqp6HQs4lLrR62m77NX78I5VRE
	Xt6uLyT1HpjE9JHDBkOUWCoCycwf2n/4oHI6XuU785ZWITn5RsyqU07zHfPzH7jA3ixSFEdhF0V
	YDBM53LtqAxMCj0ba+B5ZOR1jjlLMKOmecYHf6y2hlqX8ZE4JkkkP4gD8=
X-Received: by 2002:a05:6214:1c09:b0:91c:6c93:4482 with SMTP id 6a1803df08f44-91f24166760mr168319406d6.23.1794844951812;
        Mon, 16 Nov 2026 08:02:31 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d9f3cesm88143426d6.35.2026.11.16.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 08:02:30 -0800 (PST)
Message-ID: <aacc4357-7f8c-4e5f-8cb2-1d2bdec767e4@gmail.com>
Date: Mon, 16 Nov 2026 11:02:30 -0500
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
Subject: Re: [PATCH v2 0/2] builtin/repo: improve counting of objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
 <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/2026 3:01 AM, Patrick Steinhardt wrote:
> I was recently using `git repo structure` in a very large repository and
> was eventually greeted with an OOM. So I had a bit of a look and found a
> way to improve the memory footprint and speed it up a bit.
> 
> The repository still doesn't produce results. As it turns out, walking
> 33 billion tree entries takes a while, and everything rev-list based
> that walks trees is kinda broken in there. Oh, well, a problem for
> another day.
> 
> Changes in v2:
>   - Reword a comment to point out that parsing the commit should in
>     theory not be required.
>   - Link to v1: https://patch.msgid.link/20261113-pks-repo-count-objects-speedup-
Thanks for these changes. I found your v2 patches in my inbox somehow
disconnected from this cover letter. But I'm happy with v2.

Thanks,
-Stolee

