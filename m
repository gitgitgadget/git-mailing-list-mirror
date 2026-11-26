Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707466;
	b=lGIzzvxXRe/DpKfBDNPy0of0YIAeLYyK1Kj6gOdxkFUvACUTvfzmXiRYI11ETWpvqwmd
	 ZQruxlMY+P4RxsD+luZAmd5lit5KFntJR6N9pZfQNW7VRaryW6YVAqD0WqhfFHLQXifXX
	 ICLn9DhunBiwfHfqFJ5MqusGaVaVI2s2z89zbx0u1e+yumzP150nq2UqbNNj1YOAuqaYD
	 3txZ9JzUaZv2RAlaEla5da/UW/uAtjBmTzla/FY+pa4/i8SwaEPP1hr3W7pF3XrwwsH0N
	 TfKScO51LwutfAO1+4GE/jvPshEWJEvhiHalhoHYX29Pi50vmoen2UxSutIUn5iBkKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RvHsauNVKrNV7jKSpO+efzZgyswn6evem0llXkIoN0M=;
	b=HapQcei+ZbncSgzNppJ+2SLSUubqpdMBhaLcBqg0T0jnPCujREQfOyERWmeaC5Zue6jb
	 sKTQ37iWWMkVVtuHOABgKF4Xw2WHasPxr/luiFXIjsqPBH23e36PE+JHxmKpku7fi2Vq8
	 xuqHVzkAZpanc8NxRZb+XZ9sUHYLqf4Y+FEFzQEHke8k/XJxWC4MQuFnqy49oFql3VgPo
	 W1ck5/eh+2VPHs+FXPm9dQlodk8dQk17GdyAij9u7lTmHmOBWUCYwaooOH895FK8pMZxw
	 grUdZ8pqwmYx9w6pbatTPAhBkytHzNT7JhCl2vCvEYyIPoZGwxrPUkT4e5b0JfBlqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guTRFH32;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC923606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC923606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guTRFH32
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3863db981d4so10057946eec.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795707465; x=1796312265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvHsauNVKrNV7jKSpO+efzZgyswn6evem0llXkIoN0M=;
        b=guTRFH32/zItVDRLOjcddSpLROCU9LJCBGpxTAJHr+33uhMe3RaO9FUpc51cfBy8GV
         hQVZuRThTMBpMOo1JjZa7bh+F/BBzRptDfS9ouhZDmzA9qBR6xBFH2OTqgoNiK087XCl
         cVPs52sCZpkZNvuSSXrF1AmIhjjFDLeRba+QsagjWdnqmCrr/MA0qgSO+SwgnNDpcnx3
         c5D5lkkMc6rQTlrU/g6OJw84phjXArBA9XnXOJMeCayLVm1mE3PvIYcx5K/3kJ/jGNUV
         n1EH3draNCWAz7ob0XJZyLBYaWSWYilbTDBEa27FTq0wSNAzxPYPmT7YH9HRhYyIDgp1
         lLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795707465; x=1796312265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvHsauNVKrNV7jKSpO+efzZgyswn6evem0llXkIoN0M=;
        b=qiMo33NFSLlhlYyt77wI/KkV3LGNeY4xiGHo0ZPjqrfQDEKmpbPkiTPa0+hr7QB92T
         bMu1zxYRZ0dbSowpdnE7x0IrCMg4SNYWM6AwivNRxL6VpE8GlnaJC06YPaxCeaiWCJwT
         yuDubRFCkNbVgAW7EYUcBbPmtY/A6TWqYXr5a2rmA4NtjbYXtoe/JOWLvlnh5oIfdPfI
         rw2DkIqOiLwFCE6TOslpGxzXHBSJtUupVepEuoW6Mf75dR/7u80Vnz9rxv30d7mQfRPD
         xBSpnuBQhNCiqH4RVSgF2LdFBYGkMaMUHPzJxKJIrqqhnpY4+i5lBLSpgBtmvpRNsg1a
         KUbQ==
X-Gm-Message-State: APuU4Z849mrp/lbbtMpCZsKgBZb9xyuzaSIQXhswtEC24tUAmzQ+9RBO
	XJO1aHAi5wUcvN36AAMEKGbAbPKY0vWZNH4rklikXkqEVONbHGI9FBAL
X-Gm-Gg: AZFdTZf3+eDJgqS5XwWuVRzw+6q/YECH+mw8oLF7SYZsJzdwk5Kx5SmxpAtpQT2XI1P
	hAagTd1M1b+S/K35xg1Yz4LJRBMeq4mgGVKjjyC1Xik3cH48WVzHHsMPSNs4VV1P05XXbFBEoxb
	5xJ7h3cToTXWW40ZHfc3lGKcslCuMQt/uDohkqrsKzUWO9USaZuHP7pCoQZ5j2ERMd0LDr72f62
	4lnRHXaSZUYELUqbL2APZOS+qJ4QBSAdWY2HuUSWxGlEya0P6nZRH4WIsNpVVtz3EGT15xpL8+4
	S2vgfLY2gFTHQN5NNid8e3o9I4Yo47KGK0XpcLMkdPpdoaNDzwMEab0uZ521UOZOAjNMHFrGu9A
	wKQvfP3Xy8z5kxNn1RnDr+la9piwCnULcc8hm109yBK6K8ZosUxoMFKYx0hudZkTeNW5tlcvwE9
	ZDNp1YqNz+gcJsoDyfPgMaAu9XRyuA77xpokDIT42fICSftqDWlp5QT/AkHcSBHiarJtWVR9hiO
	jIE2+1B1NkVqtfYpX0mYeSewCfCA7HmXfLgae7u8fpLzCMb1fEkhnTfxdZ6yJD5qBkZGLIWqyN8
	00KVnkhJ9+O5R4sAI269w+D8idztHV0aji+tpaS4H/Ct
X-Received: by 2002:a05:7301:2222:b0:384:2662:a7fe with SMTP id 5a478bee46e88-3856c9a1180mr19558487eec.1.1795707464863;
        Thu, 26 Nov 2026 07:37:44 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm68526337eec.14.2026.11.26.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:37:44 -0800 (PST)
Message-ID: <aaee3092-c549-4ff0-af98-36b59ff898c5@gmail.com>
Date: Thu, 26 Nov 2026 21:07:40 +0530
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
Subject: Re: [PATCH v2 05/13] object-file-convert: implement mapping in terms
 of object DB
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-6-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261023072559.3204273-6-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:55, Christian Couder wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
> 
> Now that we have odb_map_oid, let's implement repo_oid_to_algop in terms
> of it.  We still need the latter because it does some cleanup that needs

May be s/latter/repo_oid_to_algop/ for the sake of clarity?

> 
> diff --git a/object-file-convert.c b/object-file-convert.c
> index 63ee18630b..90a75a6c21 100644
> --- a/object-file-convert.c
> +++ b/object-file-convert.c
> @@ -7,6 +7,7 @@
>   #include "repository.h"
>   #include "hash.h"
>   #include "object.h"
> +#include "odb.h"
>   #include "loose.h"
>   #include "commit.h"
>   #include "gpg-interface.h"
> @@ -35,18 +36,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
>   			oidcpy(dest, src);
>   		return 0;
>   	}
> -	if (repo_loose_object_map_oid(repo, src, to, dest)) {
> -		/*
> -		 * We may have loaded the object map at repo initialization but
> -		 * another process (perhaps upstream of a pipe from us) may have
> -		 * written a new object into the map.  If the object is missing,
> -		 * let's reload the map to see if the object has appeared.
> -		 */
> -		repo_read_loose_object_map(repo);
> -		if (repo_loose_object_map_oid(repo, src, to, dest))
> -			return -1;
> -	}
> -	return 0;
> +	return odb_map_oid(repo->objects, src, to, dest, 0 );
>   }

I guess repo_loose_object_map_oid and repo_read_loose_object_map are 
dead after this patch. Shall we remove them?

We do seem to leave the reloading logic up to the backend and we've 
captured it as an expectation by mentioning it in the callback's 
documentation. So, I guess that's good.

-- 
Sivaraam

