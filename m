Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197837;
	b=RjumRqMLM6fLF2VUlmPeZkHFHLqrSgkXmwAN+PqHX4DTFyJv8/E6e+XaGOuMEE41ukN1
	 XGNb9WyB/cmcAE5W52fk//8yskkCo0eJrJ60ttllpAJeof9Q5eND2vtzDtMhhgpkb249S
	 JHWEdOIt7c81wWJz3odLdvsK5wU4zYmauqv5jNNFhPY+vdzdAYbUAogGL/hdv7CxWM7hE
	 gs24PqVDO4unzAiSMDfc3nwsJ/sFlZrgDhHi2dYJTvdlEWxKBdHteTlUNbtdUEPoWl2LU
	 MmnZher8JCmZf1QZNgXDVUtW9qy/726CTmyN4F0BJjnmEYCZZg5/TZ4aRlTDoGt9vTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zf8V+vfwqXl/Muxph8vXuZHWg97L9518VmTxkZ7Cb3Q=;
	b=iZl7Ty/rGfSTDRF3E7n/nDNpoQVF7HBHXYb6eaz/PvMxpMAR9CtjYx/aeHH150S4XZ4T
	 vMLTfPBUHSlk/Is+xiItbPsGuxLkeZTTt2gVVZETLp5dAO8/2a7xdM3/mewXfsNixXvua
	 tIqw938nnU20HbzDH8MNI1Tt2rZpPfbgqN3sM0Qd8Z+m+q7EMGxD0z1jqIcmQZS1RBTpn
	 de/CJOdc6DTxvupxZ6LMwubznYMO0VFnLGfc68IS9g01O8PvyjG+cCvJKFgkPVlnCd/wO
	 JVDEBTfrEXJtCJ5BDJXK+jLAtzjSSWKz5AUyCwUtZEw1RFESUQIiUOovqsHFampq1Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GBh4B3Wt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683260A3812
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0683260A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GBh4B3Wt
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f84a55cc06so768270a34.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795197836; cv=none;
        d=google.com; s=arc-20260327;
        b=DI2hVVssA6p1mcSLET8mbjo4kMFfbXRitg8Y5Xy6nduHmCDBDx2SXY9Bs5J7qAVeBB
         nSv0v7TYwRTysxEBOTRneBhGBxJp8AGOTROYT7pire2a2OQh+yA471sZsxaixwZqn88Q
         yO/WwoVi+hP50LuMTUkKl5XmxAAerz0KfOJVfPK2fHzqZ9pZlRM+bVxwHy5WSfSKfnW2
         tSTXLl2zsz03TztAWM7SeQUXAsnsUJarD7lUd3sV6g4RLQqVyY2vs5DQsBMEL8f2d2SV
         y8q+WGHadd1ReP/JU4g8PPspvu11bpp+e3fpF62gHnJIs1eYViQCHEs6fWeb2HdDDlB0
         hy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zf8V+vfwqXl/Muxph8vXuZHWg97L9518VmTxkZ7Cb3Q=;
        fh=nmqN2FjBudVTOrf5c924oxjxtPZGKfVdJvX/AOm7wks=;
        b=JaO1I3yXaLwpI54FeOIEvx4f4sHQ0Q7J+PWkcUY0KTAp2PqF9qQA23+FMlNtUvLR51
         5F0+fPEQWQDQ8G9VQTWWCJpe5MuTUUyDt0sYx6qR3tlNboOaF+zBxpPfcGzOPlAQz0jA
         OQNvOzxFfUBx2TjwDO1SCaVjB6UUyiP2uzTBZ4QxsUXaHb+PRfOh90/vDCJfHDCscH+G
         c2yqIGYCPlOWj/rZRJMgXlBxa4GZq3c8hSx6iQsUb/XfzWOIWH8CTBh1AdxQm9obisjk
         jMwnDN8E9eKncx151PDtPNVdO6EGclQhaF2tuBdJmeF5O5+fzk+DPH7LiBWs00mELV0J
         MhMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197836; x=1795802636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf8V+vfwqXl/Muxph8vXuZHWg97L9518VmTxkZ7Cb3Q=;
        b=GBh4B3WtJ/VTC8BrR186YAEPgBmUkyZGwnyjhZHIiAU59KQEyWd0vhHe2h/u1ljHe7
         cf/S2Euau/27OdBPkrniX1DrcraQfV3zMDx7hdw7EWmcaR1gOAv+6sdK/AZbGzDLrq43
         /4S/ZuRTMGKPvdLr8leRVIsiwONyF/XvVXIATNFadx4VEKun1k09WsinqNUv2LXii0dV
         huumrJ9KmDyYANvgpkxu1hkdRHT/lqG/AmTZ2Gq9Id0B7/zbTupTxEH9BLHRpFXVoZT1
         AP8+zG5r6r+5cmj8iObTu7qUHQgcaIrZ+a6nBaXRZ2A/UkNliBamTC7P4/i+0nG5dLcb
         uAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197836; x=1795802636;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zf8V+vfwqXl/Muxph8vXuZHWg97L9518VmTxkZ7Cb3Q=;
        b=CosvlpHwv6q4ifg1MQJtc4SOJwWzTSi7d66wVq2U5qZ/qfhemg7z67ITrlEYvc6/vF
         SHzMysRKgFxHRdYD/aOXGFeV8j3CcpwcZNKyZhxbl/0HLXHr6ad86L5/QQs5mqSumpVN
         hwWW57olDVyXjAyBpVDDr7ShW6FG7t8X/EhWEhMndUimq5ljBNz2QMNPYTsaVlDUaWNy
         MoVM2UiFKqZPHeRF97yl/Z8qBI9AbaxxtUPrN+yyoV69qxhGWnsD8+aBfKBwl5cpoFRH
         12YCtbzEHu2/v6UxGT6TytThVP5xq7c1oMA/rwUPqSHgxPcbUJNSH2fa83SlfSFxCkir
         056g==
X-Forwarded-Encrypted: i=1; AL+hErH/f+6/A8iapmfrXw7nmbqEj8c/C/69aI4z/pUI0kqzLPrc94yamqx9sNW4Aty8WbGo70o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9BPjeeLFa1lO9rjMER/6vLPRljFi2Dmd1y3wU/Q03uOcpIjv4
	w1jx94zFje7Bpg9cN3Iq6bNY+2AUCLFxw+UgzMqYHjF75h6tcctEd/R9wLkoUDxSPbODJaj3JdL
	BKq7PuIk5smfM4urvZujBrFR5+68mOnY=
X-Gm-Gg: AYBFou1QvYm4ksncgnd3e58mBLr4JeCzDrlRKvKtJgSDTqsrOB1KnQInO2Akwq4o9GC
	3IPvVgQeQaKj9SQSvwzFeGzdlVJf6X4KJVr1dPAbCPOUAuEy8oMrQPmTETB+loXhu12Cxugg+fq
	I1s7+4GtXoj2me52aIFwuMboniKS6QMsW/iXB6iGsIg07OdlWjdGA7cR4ypR84We6WJaBVt6BR/
	1SDBou0yFeAqqf6DATORgPU4z+ehkLdtJ7tPF/a9xdItedNihsVF+HYpF77V6R5vHQVUbSd5N/A
	ev4M3cUxIzsmCEuaB4PHJxmUaAkLiorMoIo2+w+vG2BAGvU4fiTXE9O9eSsK6orPm2eQnTDpdmz
	B9PpRGDb2lV2EXwDDxoCEkXnWiy0lhtefiEA=
X-Received: by 2002:a05:6820:7092:10b0:716:bb4f:9d1c with SMTP id
 006d021491bc7-71b39559ce8mr2508512eaf.70.1795197835399; Fri, 20 Nov 2026
 10:03:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
 <20261118-master-v2-1-3f2aaec15d31@gouders.net> <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
 <ghbj7k1mg5.fsf@gouders.net> <CAHWeT-ZXEXvxn2Zf=mt1tvjLxMvPzgeiMUvC1Ani5mcLbEvFGQ@mail.gmail.com>
 <xmqqld6nsbmh.fsf@gitster.g>
In-Reply-To: <xmqqld6nsbmh.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 20 Nov 2026 18:03:43 +0000
X-Gm-Features: AclHuK-qUcipvMjcm9CNa_9kTQ_kTegZgTae0xK2C0B_A2aWihxjKnKP6U328FQ
Message-ID: <CAHWeT-Ypq0cN7U8N82mhew_-CBBcQgUsgSzxcHvnKQ+QhJGptg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
To: Junio C Hamano <gitster@pobox.com>
Cc: Dirk Gouders <dirk@gouders.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 at 16:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Koppe <andy.koppe@gmail.com> writes:
>
> > Callers could already sidestep the length check by passing SIZE_MAX, and
> > the number of consumed bytes is returned, so I don't think that's needed.
>
> I like the simplicity of the approach.  Thanks.

Except, I was wrong, sorry. The 'end = s + len' would be undefined
behaviour with SIZE_MAX. Callers do have to pass a valid length.

But it didn't sound like there are use cases that don't know the
remaining length anyway and can't tolerate calling strlen().
