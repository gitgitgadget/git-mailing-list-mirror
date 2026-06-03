Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A2480DC4
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492038; cv=pass; b=m8g7OHAc/Sc2jnLScBpzGjq/cYR/rZJnrg3FP3jzoJxv/wmBW7UTxdS/v9NmxUg0Dy+Sg0ufgWHDz8fXATob6CrdQHTjOMnAxCS7+4ZBgZ+HEp8RmXJiFqkWErSpkVW2RHBaooUSLaFxAZ0vBqbOCMicuq/NbPtxpOhXjSqGqac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492038; c=relaxed/simple;
	bh=6kK42NhIPbvRguWldoa5ZicEz5iIJW6m5cThr9N9Mn0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilbOIGJUySTBGIPqStwvESPEH+Y2Tqj6YAxnMsRIygCrIyweV73qL6M+6znTL6x6G6H82nnRrJ7cs/p4NGmmUiFGhiQ9xREa/7w3ZWruTYK9X/4Sq0KtcLAuo6ITcMRkFNaMk59c4rlz+ZpcnodGS9T7kDT69vJ9H01rywkNVYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVhSeiFG; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVhSeiFG"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-963849a4611so2204863241.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 06:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780492035; cv=none;
        d=google.com; s=arc-20240605;
        b=jeL7KDo0ZCAACo+AWamtl8ZyrRoFDPQwTjAFSyNcQSEqfQ7UAojVkaZVIlJYaE/Zsm
         n98/qk0oTsJduVTxnCsvBaMgaUpPOAB9B2TdzF0N/E15uzwTsUCSqANKRxRQkCBZh5Zs
         Vjtqpt5JrCHhDmRFUDz18mA86hRteH+vJIbIXLwtNsDbEOJuKKOQdeQFwPmsNUt+SOnw
         O9n0ruTGKajKIBeTCNyG+PVXGIjw9QLZuIL2Hh5ywxwKVeW8HP+91Q5Jqaw1Vs+Qq8mQ
         O/erzvQ/m8tINyCz4isxBD7Bv3ZpYfoUNJLOx2q61CzEfsmeMcyme6cDAhw8Q9HOlthN
         X8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6kK42NhIPbvRguWldoa5ZicEz5iIJW6m5cThr9N9Mn0=;
        fh=2kQVON5Zo8LEbYHVHKXcw3RbBeu+Sk+bOOjTNxzr6bo=;
        b=ekX+VsqyisP2PtA8WgSiAZR4+KpUL74bHmd3iSiMLGOFx47ze4OiieUh7aDaDxVKjm
         ndWZMr6B/AUBH/m+NPoLMajwnHnrPyPWVrz7/UyknDN0PLqSuWWGMAL2hbtm4nF47xFH
         7MXC44UDSzjNAOrL8sqdh+u76DXt+0htnXSrNGjcMoG9Wli8LFM33DwNZv5N7lalytgf
         4RaBYLZkkiHVn4j9QKHftZhXPG9AjZi/U6L63A6Y2yjqSAfo2M5hadZDYiOY8/aJUZfP
         Fp8vDO9fOWlVT3eGoT9xYdLZApqjDjFmf8NGoQaj6ZDkGmDHwAj6YUfR57qTpABGCFXo
         n95Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780492035; x=1781096835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kK42NhIPbvRguWldoa5ZicEz5iIJW6m5cThr9N9Mn0=;
        b=bVhSeiFGQ77lqMMu+Qm15TwiFHyY4HYmfCeRyuG8T18YkMUONixcRX8EZ2i+cidf7l
         qmJAoH7XTxjF5itutfesADfGw/wUOyBz+DD4rjrdItRT2QFls8uLswVRWP10hPauloHe
         GtVHnER6/W6CFQbyg8MnWrbzTJ2N2F90ihh0exe/kZ0eUQQnvtXMbjysccVARkOBNW5S
         xFxo6gGh02Q/VCLyDNSqwwLhtO+trbzlY0u+9V8Dq+CvXV6A36VOl1beP8aZZEPkUHfJ
         mKGnEW4dLX1O1GHYEZaWEjJJMFn4HHfDlc0juLwpiNm68FvcYK5BiNiTTbzzGeRZiSiD
         fA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492035; x=1781096835;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kK42NhIPbvRguWldoa5ZicEz5iIJW6m5cThr9N9Mn0=;
        b=gSK4VMRckCj67wQYn/aq/caouE6KezNAIfoAA1PGWvg0LWvM5FZWbY620uUI5T1iHm
         Pv2fuJPP05qJraw8YtTIysioU9SzE4qAFXYuKXdG8hk2z9K4C+Z1nCTealmqAS+KMkY3
         yjmrwJz6qFX2HH1GbuSm+NE1e6PmDCBqaLYD3dfCvl3yn34ymJnp3ve1DmFUUpf/jUdO
         N+2BJ3XvKhZ6N9E4O8gSnXcK2wqD7fe6IbORrPEJbIst265ov3ZACMTMlCcIRiPrphk6
         bY9txjlEqisaWtYIJYptjPEoP562sZSLLbi6m9+o+Cv0rgllE606fGzIBJs1qJ4q8d+l
         L2+A==
X-Forwarded-Encrypted: i=1; AFNElJ89mvDUgN1q8vYDUmk9DOGK0/SXtKPaT7HCoqxw2f858uIN2eZR6OT9XVTWp8UELu5zPdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkmE9EoDfV0lNmE3X3q9UuvAS/6aYxUmzzK2rFxRwVRf4qxE1
	5BTT2BzpQHJPA+1n6/oRw9qAfOLzX3W5X3Rpk1bGufdJyLPyW92IGq/twfUWmqhDbjStc94O5wY
	m024iQuXnPVQFZE6PRKJdlbLDom5xtKFHjA==
X-Gm-Gg: Acq92OG2+pOobg+fpRMY9IPAMT+8WH4huWn03KeNqkf+7WO4GGKbWXJi/FIBLBla4Ck
	0yATDOBin9sbo5dUbnVisrq9ynCQp1BROraGWuYOpd+DGjGKsW3SIXu7YxckLDLG9Wqd66wpZLw
	fIw9Zg19Hhk6HXdTSuBVQ4mAGrhz3YlgSLxG7pyidc/AOdGlxCRkwvIwQZFWCZ0x0gEDAMZvLW+
	N9Tee15IKmDMGfExnBYCFsLM3EsrHREIPxcZIBnrt/t5ZNU4SZk/gPB8CBpxNpZ5rDdTeM8iiZK
	0gmjMa4YbaOm5u7HUkIg/j/h/3FJyZFEdNUIdzCejvlBcfI8FJmjqTVPyAios8iKssXNS4mcuR2
	kuYepdvPR
X-Received: by 2002:a05:6102:d89:b0:611:61d3:819c with SMTP id
 ada2fe7eead31-6ec2d7ff257mr1261442137.10.1780492035416; Wed, 03 Jun 2026
 06:07:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 06:07:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 06:07:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-1-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im> <20260601-b4-pks-odb-source-loose-v2-1-90ff159430af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 06:07:14 -0700
X-Gm-Features: AVHnY4LXJaZrAjOCNe55cf_SJvMbgetR6Qd0d2sPdGF8nPzTaYO8yNFai0urbvY
Message-ID: <CAOLa=ZSRQpAMGDwfP8vAiJi+G=WPW=YPrrs21pVt1O4j2Uh-zQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] odb/source-loose: move loose source into "odb/" subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004c06af0653591bdb"

--0000000000004c06af0653591bdb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent patches we'll be turning `struct odb_source_loose` into a
> proper `struct odb_source`. As a first step towards this goal, move its

s/its/this?

> struct out of "object-file.c" and into "odb/source-loose.c".
>
> This detaches the implementation of the loose object source from the
> generic object file code, following the same convention already used by
> the "files" and "in-memory" sources.
>
> No functional changes are intended.
>

[snip]

--0000000000004c06af0653591bdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 494a9cec184b4df7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0p3RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDJYQy8wWDVFS0VEbk92Sk9VV25zZWo2TkVxcHNXTwoyL2kwV01tdC9X
RnR1Y2E2b1dXSTRpMmZYYWlYcGhkWWdWeDc5Q052L0tDdGNid09kZG5EeU5NdlRWNnpCaEMxCkM4
UU1NeDhidlFqR1J0M2JuQjVPQWMzQXZNY2NMdVNZZXU3SFNKcUJxTXpvTWhnci9uNlZuS3JKMURj
UFdmT0YKaFppU1BKNklCaW9adllCYkIvVGw1TW42TmpNVnpLZVZacUtxeU9MTTg4aFk0dFJER1Zl
OXdxN1pmNXY2TDk1TApnU0F2NXdXMXlNR3ZGaEs4STB6bnBZWm8xWnBZTGpRSkpNKzVjckR6U3Fz
cUFKb21uRDgwaEhlbzFWODZJWnhVClIzRTg5RndZMkw0cHpad2todmd3MDkvcUc2VnRwcms1dHNk
bm1oNzBDWk8yWFZyaCtOV2d4dnhiUFJOMzF2TFoKRkNTaGxSZS96cjRwYTM4L1FCRnBZNzdiTlpr
NFRNUWFOQjdNUmJoN0NZcEpSSjU2b2lYQ1JVR1ZySUJxdG1XRwpOQjNxdWRSb2NOb2pCbVc1TldL
NFRSeStoaGFzaGlUSWVLMVJQa21UUDkrOXh2YVAwUjU0WE9oOTkyTXA4b2pjCkhONC90enc1aXUw
WmRuTlo3VVhHSVUranVVSy9ZRDB2djNDNit5ST0KPXMrbEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c06af0653591bdb--
