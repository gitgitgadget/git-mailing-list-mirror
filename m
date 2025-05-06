Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB11BE23F
	for <git@vger.kernel.org>; Tue,  6 May 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494167; cv=none; b=U7pg5L3/glVri3hizgXlxTqQm0dunodEsgQw7MOTZ3+ecFf1rBQndfb6kRt0c8WWMj/FhgP1sVFYapi2IHZ23bTYkGTzY1ucaoLQ6fT3wZVXjGebBZlntnojBn1I2w4gMHJCZOdkAKRfUZo/rWm6N7DXO4k4fkP+wwO0RiaR9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494167; c=relaxed/simple;
	bh=sXCIKBXfqNDvmSOYjD4jG/p1aPzNzb3C7dYPlJtvRpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5atS58LRzXlDRHcG+Rrm5X4bnPvnKrVeKdw7gdvUHUaxFam3SKe19Vntz95jCMXorQXMcu770ABHr9ghj9FVGIle2gBH92CDOYmdUyF5LetYwVzPvD/3/y+MPtbaiUixAFWjPCGQLCKVDg62tnaiNuSCn2ijEJRM5sADd/YSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkYwwdv7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkYwwdv7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b07d607dc83so4247603a12.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746494165; x=1747098965; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/+i3kEXZQQpB+7yYGQyWdX3xy/W0IRhzsx/CUThwDw=;
        b=YkYwwdv74c6qj2UHXwYRKg/e0C9Aa+Pkh25W3CGayOfw9gJH+e/lmKjjkj06hgD5ER
         ZqySyAacXyjd87z7RdmOWMY/rQ/gAz31C8/PXOm0QdPzsYtW430mpOFeHx3Ylp76zGeU
         9GApnG9V5A3cf0YTQIbXF/ALobeQqZvPrZlG2Krf4mt8H9QPk9sytxznNpxEHPT828l1
         Tkcl4oJxKKeZX2gJakMjHmyhMMAeEm48Oakl8uRjilZY1Gd7zmmGfB4RiH+fvjYcZW6v
         KktUbcqR5FWxTL0JeQITCf3yowZwpCfiTtKO2T8GJwSWAUswx/DFIlw+DJS+nlmQAXY8
         b4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746494165; x=1747098965;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/+i3kEXZQQpB+7yYGQyWdX3xy/W0IRhzsx/CUThwDw=;
        b=V+jfl4jB2YH6XeNXMv4BehvGalZHGcSzoe2aeAmD0WSZbPNqthO2rpDaDH7RXrCK/R
         lbmkRD876kcsVkQvemTtkxNW+AuURyQ+U//BMNv4ngwV0/fUlCmCg1SUQaIXg2Zn0smZ
         Fr9ZxXY22qBvcLqNlsf9zmQ4J9lWXuiGb9CA8A0H8quoM2U1gBx0xRGiOwlCUlSAL+Y8
         0dl8a4kAN4ipn2ad+gLyOiG2L0tESUwaNDZBKmHmK3iaMXwbcqoeJXkDktTV1wpO8Jze
         0GvWOel6uHullY6rpKdEZI4iiJZQsR1ksV0hHeeGB0m1v7rfsGVz4Dv9dq8FtnYJ/lTj
         RZAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPz3SMUJeDpLokcxrPUfibIyKjIrIm2kjV+eNA0Dn3tuH6UWKh+MiyzY5oB8mZXE6uKtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQ0ezXtYfoLQP/AIJ8MSycrxuk8vtbxm5yAaqWLDbiMQR2Sjp
	gmmYNClrCE0lbyceUdb+EiSaJgFwrWEIDbSjDJwJN9jNiAedJXgI
X-Gm-Gg: ASbGncvPueoRr9uRbvLPon8594/SCFxfNIFbgG0gx/Ss1NV11y3xs87kvGz+EnRum5W
	EW8QbKfGftw/5cksLVTRAoV9niv1RMI+Xh1b6nTTdh6exWkKoSgYbESVQrLZDUSubH/k+edJ3QP
	q1culX46HbedLQb9Uae35KDiNVOMAUzvKYySAN7Zf5DROuwsx5a95LdnA7Q78ktg3k26FsF15LY
	MdrHzcpv56PjzQckfXqqJ/Ld/oxs6ALGmF8trmwddQA/ZPbN4oDkdoBvRsJyqWAXXm9z0IAAuKP
	YzarjO5oBC9Zg7RIfBQ5pw==
X-Google-Smtp-Source: AGHT+IG+C7dHwvTipmg8xkMbU1zvptK8FsV7t6HbSVyt1juzlLsQnjfaAuSrUB6d9q9wxly3R1KljA==
X-Received: by 2002:a17:90b:1cd0:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-30a61a50832mr13237568a91.27.1746494165288;
        Mon, 05 May 2025 18:16:05 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::16aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3464e830sm12514129a91.0.2025.05.05.18.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 18:16:04 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  shejialuo@gmail.com,  sandals@crustytoothpaste.net,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives
 EMFILE where POSIX uses ELOOP
In-Reply-To: <xmqqo6w6okni.fsf@gitster.g>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<20250503041718.42195-1-collin.funk1@gmail.com>
	<aBheGySF1FTsIVzx@pks.im> <xmqqo6w6okni.fsf@gitster.g>
Date: Mon, 05 May 2025 18:16:03 -0700
Message-ID: <87ikmemtd8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

Junio C Hamano <gitster@pobox.com> writes:

>> Nit, to make this a bit easier to read: our style guide says that nested
>> preprocessor directives should be indented by one spaces. So this would
>> become:
>>
>>     # ifdef __NetBSD__
>>     #  define SYMLINK_ERRNO EFTYPE
>>     # elif defined(__FreeBSD__)
>>     #  define SYMLINK_ERRNO EMLINK
>>     # endif
>>
>> Note that the `ifdef` itself would also be indented because we already
>> have a surrounding `#ifdef O_NOFOLLOW`.
>
> Hmph, it does look easier to read.  I think we used to have some
> outlier files that indented CPP directives by prefixing spaces in
> front of the whole line, but these days we standardized to express
> the indentation by inserting spaces immediately after '#' that
> always sit at the beginning of line, so what you showed here is a
> good example to mimic.

No problem, I sent V3 with the suggested changes. That is actually my
preferred why of indenting preprocessor directives. But I saw a mix if
CPP indenting, so I was unsure what was correct. I guess I could have
looked harder for a style guide, but at least hopefully I followed
'SubmittingPatches' mostly correct. :)

Collin
