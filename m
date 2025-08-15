Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04F2C0F91
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271670; cv=none; b=uhhNXtFM/vYVVmNv82BmSfcU3AFGmVSgLScELQIpCDkSLHsBctzt83jxxFz3/sETbEHurGcQ/evGBkVkwrdJA4YlsFHux/bklurFL454H9wbRUHI2VB60r5m5FFgKOc2v0R2G2KFr/JxNmehcG9/N7uhRpTmGF16We62E5Tu3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271670; c=relaxed/simple;
	bh=R6W59BSv1Txvfwn+JeGhJWHuv8xabY2t2ns+DI9jktM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QLVkJsIxeFm1T029b7sPq2BIsiv2cSD8fy7Fck5rLBUPQkg6/gjeIQHGMGK34TR+byCgsLC5HQ2DGnMMeBwqLLx8acNznssQ2JWOhxpxWrsvmhx6XvHiAILAv2lgR/JGeGk4cwqeX1GAOdL9WyjQYkkhMb+5bIFCXuzFMPelCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqpf8UEW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqpf8UEW"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a9f15f15fso17347286d6.2
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271667; x=1755876467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NtdAvRw+K760xOghtixOoeKWCRNaRIvjPXPT+mr2kk=;
        b=Iqpf8UEWrP1i+3CsLGO//+leLRcHUbNeMCT6C3TtRXR5AG+8Bqiw5TK48xIg//53Da
         b7xujbqprDtQdltaC2tY+dqy+DELP/fYz4wlAPy7zo9a3GR22MMGt9tcFa8I5RTM3X3J
         2Vol1K52t1lisaMOI6jJn4hS8ZxpmH9OjObvEhYVk4wQNgQ9ZXcpXPkM3QkUnubuSL+m
         Ub8wh6xwpnVzBrRyXkBZklCsY2ccuDIG/MOR9tDdRDKcH6/Ol9JtlUEaSXuZTAPxU3jy
         vvneQWgnNqJ/oHE7LVbDSh/qYNPWMHTRoOHcI0FIZwvTcqQOCXNz/2d19uwR+J1NS0z+
         mqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271667; x=1755876467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NtdAvRw+K760xOghtixOoeKWCRNaRIvjPXPT+mr2kk=;
        b=UWTZIAby6Gk6twWF5nZ5w1j+J5NvPVJXbKPJTgCLa0eFANDSizATvtOaEzPY0LVnDE
         w/ZHCn03bebmn8kMFHQf3bWi4Ga+ndkYNI3gzq+iuhWY2dvOn0i2IitrUP9IiT8GL3d6
         v66hFYlAC/BhGg6wITCBkIuhW0pKyrsp6oCYUVgRJOzh/o+gPbla6Z06hf8ZcXDc77ju
         vA0HqgV+cLO34onkSdY8IyyrFpfjx4kQ89nfTF0/VL1iNn0X6yS1bM3l5cw0sDoy/+F2
         T/GFh5uWBYOM7UvpBxbKcFz6wZKmbCio1k/aeAWrAaqOsQHhtCK4S5hrcgcKM3vbVBFa
         qO4w==
X-Forwarded-Encrypted: i=1; AJvYcCWe7zMkykHSkRLBsTSE3v/dY4SwHItpq/DVXBewqYacZaT/SHhWpsxeUf3fi+CF9Ta14ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPqC/5S+qhRGJQMomMMyNreNGnV0iyHyXA5sOjXbQww4b8JEV
	FtSdGTU0P1P612oPBc/HdWCqSTXlvquZDlIuTownAEwuuL6TfPCsyuA5
X-Gm-Gg: ASbGncuVcdzRn0e6giJDAkKOL+gfBwstj6Cb9DpeuKwfEvvxvr7Lb7uroNcQchRcg4o
	FkB+YzVdH7g++YxOrBifgWVUdbmdsqLFBpp7RdmeH7khN/323ZGvi27CGdUYCukss9YZf6YGi67
	qwV1jGXYT+XD2wLzZMZtV0lPUO/mIctZIB6g0tCe8owhNf6DJSX0rNU0tECuaXrozgCb9PPARGE
	dteJbLCs+gYCv1LoD+wRANcQtU1npE9gKs0NQFU40YrhtZKTCmdAlaDHgr4jBe+QNvEcyXB8umC
	cFi1aE70Fxf/fA42972deL1iZtRU/+gO85rP96xeN8Lff8xF326kbvYlN8rq6okDymYc2Qh10+o
	yZZT4sSzxeHscN5mAHeUKvm8g783moshU/wE=
X-Google-Smtp-Source: AGHT+IGQvzWpqjcyKn2I34oKWOnJjFHKJ75k+DOzkZrncCBe5lndPxbq8x7WH/zrogJdJJ6yA5YWEA==
X-Received: by 2002:a05:6214:ac7:b0:709:b92d:e84 with SMTP id 6a1803df08f44-70ba7ae80c1mr31162156d6.16.1755271667211;
        Fri, 15 Aug 2025 08:27:47 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92f924bsm9406156d6.46.2025.08.15.08.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:27:46 -0700 (PDT)
Message-ID: <f61c4070-3d29-465e-8dbf-55c4562c0342@gmail.com>
Date: Fri, 15 Aug 2025 11:27:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Efficiently_storing_SHA-1_=E2=86=94_SHA-256_mapping?=
 =?UTF-8?Q?s_in_compatibility_mode?=
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Patrick Steinhardt <ps@pks.im>, Jonathan Nieder <jrnieder@gmail.com>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/2025 9:09 PM, brian m. carlson wrote:
> TL;DR: We need a different datastore than a flat file for storing
> mappings between SHA-1 and SHA-256 in compatibility mode.  Advice and
> opinions sought.
...> Our approach for mapping object IDs between algorithms uses data in pack
> index v3 (outlined in the transition document), plus a flat file called
> `loose-object-idx` for loose objects.  However, we didn't anticipate
> that we'd need to handle mappings long-term for data that is neither a
> loose object nor a packed object.

I'm generally not a fan of this approach to (ab)use the pack index format
for this, especially when the translation needs to expand beyond "objects
in the local repo".

The requirements, as I see them, are:

1. Given an OID in Hash1, load its mapped OID in Hash2 in O(log N) time.
2. Given an OID in Hash2, load its mapped OID in Hash1 in O(log N) time.
3. As OID pairs are discovered, add them to the data structure in ~O(new)
   time.

> Some rough ideas of what this could look like:
> 
> * We could repurpose the top-bit of the pack order value in pack index
>   v3 to indicate an object that's not in the pack (this would limit us
>   to 2^31 items per pack).
> * We could put this in new entries in multi-pack index and require that
>   (although I'm not sure that I love the idea of requiring multi-pack
>   index in all repositories and I have yet to implement compatibility
>   mode there).
> * We could write some sort of quadratic rollup format like reftable.

My thought is that the last option is going to be best. It does require
starting a new file format from scratch, but it doesn't need to be
complicated:

* Header information includes:
	- file version info.
	- hash versions in mapping.
	- the number of OIDs in the format
	- the previous mapping file(s) in the chain
	- offsets to the Hash1 and Hash2 tables.
	- room for expansion to other data being added to the format,
	  as necessary in the future.
* Hash1 table has a lex-ordered list of Hash1 OIDs and int IDs to do
  lookups of the mapped Hash2 OIDs from the second table (by position).
* Hash2 table has a lex-ordered list of Hash2 OIDs and int IDs to do
  lookups of the mapped Hash1 OIDs from the first table (by position).

Lookup time would be O(L * log N) where L is the number of layers in
the collection of files. Writing time could be as low as the size of
a new layer on top, with squashing of layers handled in the background
or in the foreground (opportunistically for small layers or as needed
if background maintenance is not available).

I'm sure that things are more complicated than I'm making it out to
be in this email. I haven't looked at your branch to see the subtle
details around this. Hopefully this just gives you ideas that you
can use as you compare options.

Thanks,
-Stolee

