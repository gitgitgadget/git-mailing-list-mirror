Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320164;
	b=HsR9w3eJx1504YgG3HueFcy6ljPRUEL0dBjlV3Uw2DPU4Tn8ZmyO54cg9jGql9PzdDYo
	 ITh9aywk4eNw6DhEBRVgQLSOB5z1c4MYbyL/opr+gBnRPEkCMokqTHh1FhHTe8VKOUQN3
	 FIVpfdgLUBHElxnds5XRWOfiOijQRAEgljG986ot99+6A7qlSMayNyj84NdRVT0gTq7U7
	 xPz+HlUUNrT2OQzOkrRhM8QuwoxZJH/wi2Iq+v+fpsWB4Bv+VJr0mGjV3VCJ6CB9wXU3o
	 hVkjOfR1RRBwfgZbLPfTz3cSIXbFSp8YPux/HPZ54aaP72+FA0AmZ3/KfHBjQ/pfxsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=crj87tEn4Sg88iAm1hwgABaJ2e/jnFKOr8meds62fAI=;
	b=cCrLORwfZb3JU8UUxakRJJKgMIPQ6/RuVxxetDHhKwWOFrHBli6O6ixVDv2H1ip96SLN
	 LeoIN5EBpy6IqkZpX4FZKRcI8LNIHwsDrD+MPH9Sz288EdYsUHb73nBaIWQn2eDrVuUC6
	 5s5OfW/BgKody39hvDdBS04g6oyjObCuQWPaLB06wq85b1FZTZr/srCJ1TlwkAM+6lNUA
	 KnDatnEEo94CXdHRaD5Luh8Vdwvfp4AmfWw4KVga3l1X3MbnMPnzvIxtTvEZ2nLSIn79Z
	 Brn/NwSWeqW8GD/7VaOxmxafgISPUMQhF1stNhYWfEWxIJFSNEMTEPH/v8s/KLeWNCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vLy6iJWK;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88B60A260B
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF88B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vLy6iJWK
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso504001a91.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320163; x=1794924963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=crj87tEn4Sg88iAm1hwgABaJ2e/jnFKOr8meds62fAI=;
        b=vLy6iJWK8jK/j/6nXUSSauafh9+d97pabM0DHhTrS3qMcikJfYQyS1jDNs5LjHa9Wf
         8hgIeI3F/NCZyAqId4uE5mllMHvCkWayOm/wAnIV/cY93qI53OlSo/saVFgdUyyByK+S
         qffNvywCLkacQ4U1iZxzD/bp/8T46e8LqKxckUv51X6O8gHDvyrCacH3Gn9RnxaLmzox
         3eDYBw7LsBE5FpY4irLyxkQxqKEF2pUHGT2DUGqCjxSArOcdjdxK4Cv+PWz3IZD6bruz
         ZRH5yNpAestAaSNLw9wYNylscr4Dfsr4RvOHjAOpEf5zI99z1MrV7pJW09FLzja2ezR6
         rNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320163; x=1794924963;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crj87tEn4Sg88iAm1hwgABaJ2e/jnFKOr8meds62fAI=;
        b=qzQMcbTcO/MCMMlNYbpBY1QqL3G+DoDn99FBHB1gERhtvnsF6v/GZCsacpv7Hoc79r
         zmhiSBI8CF+N6i/Y7QoLMXUBB90ZCnyPUvREKxUv/owhV2YP17R61RaigZg38Hrv/fmR
         3OYcvsavK+4Xb+5CKop5aE6v0gjyHmXAbJzl+ux1Wel08V0EReTE/ISA6a3A1kOBiydh
         JXENkqma1tr++FJzRXbHEgjWADehWUlc1HWXZ3JLAioBud9gu5mPRvBDHGrs3rNrHlaf
         9FOo6qO5HC78UJPShHBKNWz+9cCNrgHSTvsdE+DZVS0wjPKP6vfJ0fYlfYM/7uLDqjsu
         LrFQ==
X-Gm-Message-State: APuU4Z8U376XfvyXRsl2INoI/8JtME/KOC2zLOta2BMsXpGq/T7/wq/9
	DujYj9up2L4rgoFi0mzlhHr1r0F8omMMofmEApKV7KrskJdBALISxYIVW2DgqDWL
X-Gm-Gg: AYBFou1DRZ18qbiV2WlZPxIllYNJN+XIa/gcIqWO5Z1Q35K7X7sgZcs1Sdy9Bu++lav
	C+3y50Nv0xo1/TLGIe5/pWaJR1u6f0Xc5j3wFubjwZzNdt0FCsBY/a6dV0/SWx0hLgJf57kjYLI
	gKuLepR50KZRGvt8bVmOFFE9K+RB177cJKpMHAo6RcCvVb1AmYWIkLawrqmCLnSwW6vD2skshtO
	zr3Wkxn3w6Gxzstvm5kVF3auDNiVnKBvwq7RdmDTOmSutPQQ52qhFMJExilncMCvzNKWwwQLdz7
	7DeKSjRC8Drez6Rqj+saa3Ox+jgEHAdRV/lTucWzx0JGQUcb+e0nV87/zEEO8Ii2siLopydjVl/
	IGdVJYnK/dQtWI/PJMkx9iLFG+Gv9t3vGWjII9JdrrPFWPxO8em/DYG2hfXSXPLAvobiaXrMpzy
	uiTviSCPzkuMFYX2sv3PWHp+D14SpRLRaKxBRVgFq/fgr0LSQmwilOI8vtwIIyd3eQ+p1VD4LdL
	ovC3Qe30mb2kZAgehXtr5A03DpfyQtP0Et1bsm7AA8iDbqI0A6QkcCYmnNL7HYMqVITENidcQtS
	s9/c4x6UlNRusabx+FrIfzcDX738nMqIeFVF4AacfW0L
X-Received: by 2002:a17:90b:2d0e:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3b166d1d382mr2507542a91.44.1794320163063;
        Tue, 10 Nov 2026 06:16:03 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db922e8sm51803a91.16.2026.11.10.06.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:16:01 -0800 (PST)
Message-ID: <9794ae30-d6a4-478a-aa25-88f8d9e02810@gmail.com>
Date: Tue, 10 Nov 2026 19:45:58 +0530
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
Subject: Re: [PATCH 4/6] odb/source-loose: deduplicate logic to mmap objects
To: Patrick Steinhardt <ps@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-4-fbbc86c29693@pks.im>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-4-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> The logic to mmap objects is duplicated across `map_fd()` and
> `odb_source_loose_map_object()`. The only difference is that the former
> takes an arbitrary path, whereas the latter derives the path from an
> object ID.
> 
> Deduplicate the logic.
> 

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   odb/source-loose.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index a90268e200a..5cd679e802c 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -544,28 +544,11 @@ static void *odb_source_loose_map_object(struct odb_source_loose *loose,
>   					 const struct object_id *oid,
>   					 unsigned long *size)
>   {
> -	const char *p;
> -	int fd = open_loose_object(loose, oid, &p);
> -	void *map = NULL;
> -	struct stat st;
> -
> +	const char *path;
> +	int fd = open_loose_object(loose, oid, &path);
>   	if (fd < 0)
>   		return NULL;
> -
> -	if (!fstat(fd, &st)) {
> -		*size = xsize_t(st.st_size);
> -		if (!*size) {
> -			/* mmap() is forbidden on empty files */
> -			error(_("object file %s is empty"), p);
> -			goto out;
> -		}
> -
> -		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
> -	}
> -
> -out:
> -	close(fd);
> -	return map;
> +	return map_fd(fd, path, size);

I just noticed that map_fd could follow the goto pattern followed above 
and avoid the redundant close() call. Something like:

diff --git a/odb/source-loose.c b/odb/source-loose.c
index 737d583f03..4ace94084f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -532,11 +532,12 @@ static void *map_fd(int fd, const char *path, 
unsigned long *size)
  		if (!*size) {
  			/* mmap() is forbidden on empty files */
  			error(_("object file %s is empty"), path);
-			close(fd);
-			return NULL;
+			goto out;
  		}
  		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
  	}
+
+out:
  	close(fd);
  	return map;
  }

Of course, this isn't really a show-stopper for this patch. Just another 
relevant cleanup I noticed.

-- 
Sivaraam

