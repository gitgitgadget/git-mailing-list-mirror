Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979919F130
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510021; cv=none; b=pAtEUXdVc2ogXePqkCAE8cVmtRlDOw4iXMeqt3lP6JFYQtlXnRjpprQ98P7ATWIdo9xX2ng5ICxiDS/6mm+9sNAMfFU1ci/Z75fHQrdOfvtRN9DOf/QGPO3DcYy5XXXp+tbJ30Z6Gw+GenrFcdE6Tl4jdKgG8dET9Rq9CkiKEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510021; c=relaxed/simple;
	bh=iKeMlbqfCF7U1viVGcUr0coAarnBXzFFG/CmlP8x19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDNewKLW2cghUsmJlkXnVBGMm4dcANb8q7umfYlqe13SR6Fvo0Cd3zyuqBK9pM69yYVkwYUik7jhu033d3If8YpbgRC9J21k3D3vndwTEUp9L22F3aviAWaROSMhviOZivlBNp/VUD3fgMqk/kpbHKBtQ2IpagUH6Uj50WS6BHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e657ea2e6fso6824166d6.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740510018; x=1741114818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK7IcVxUVkJVk0Vzz26mOAA5bpI1qKM/icwKutlmf8Q=;
        b=FCDUY9fiF1qTZtCpRg6AkibWSksjep00Yuy/9eBo3Sjtu6Kl9q8Hi0xbxtxPf1V6lu
         Ptw4f8shlTMf8rZy3S3BZLccp6EmnG9U5hY16RWkaVHmADUR0+D5LB6uXeXi6U5nTj6g
         EHzzhiTcgiPpl/8/S3nDqKjI5Erb2RTC/LVNzbiKJqbOSeFt2kcMb/VA88DPHHiBewgs
         1RoSwVqBHO4bUy9YXuhk6rvVahLCXPqKb+X5aeIXxZKcVh0Cr0bCiXDucb/BzGrYx050
         2IZ1VA+SgxV7MWZnZH1GD13DteDyC5Q810Lo+j6/f6h/dEHxhbEGL2UbJhuXIIcIvZUl
         8mVg==
X-Forwarded-Encrypted: i=1; AJvYcCVDQ3oRdcRinlb/qfwm4Z8swiU/Ug014gTJua1VKurWHCL7XW6TL1RAblKLJQmFqUnsY9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOJqk6wiLGwfFtg63AOVXfI4BnsqAg6PumbP8bFEiepJ/Zcl7
	+ctPbUyI2v2hMTvCvWUiKJAups4u5TgGxz/AyfeuQ4UQ+I4kQMfZYAu3dz7soBiAQq5NMdT0OFZ
	/ce83YKi/9isJHbVc9PJ/D50nrSnzZHTu
X-Gm-Gg: ASbGncuMepH3pMWrhtZcAl3Vmexagk/WGsDZvDQoaxOwCG2WXhAn5nvDEWQU3tFCXkL
	U7nie6NPqIYdRroZpZ1zmMDp/AINhlQzcfP7lrZTlI2n5ER+DeQLLFG+vbi/LaEtccBxCqNTw+Q
	Kqoi9O7KOfPKSfz0m+tNtxYF8srb0LGtTCb7uRPmJp
X-Google-Smtp-Source: AGHT+IFROvF6j4LF02qsN6TTMPsWgpCp8jNPKwsLw6owjJDOjvitovkW0XnLfN0UKkORsMZXop8pkp2AC+73tpRswgw=
X-Received: by 2002:a05:6214:262d:b0:6e6:6a6c:79fb with SMTP id
 6a1803df08f44-6e6ae5ff006mr93473426d6.0.1740510017508; Tue, 25 Feb 2025
 11:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062958.GD1293961@coredump.intra.peff.net> <Z72sp639o8rxG1Qf@pks.im>
In-Reply-To: <Z72sp639o8rxG1Qf@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 25 Feb 2025 14:00:05 -0500
X-Gm-Features: AQ5f1JrlMMpf8zLPcNfnHRnV0myxj_xR15W2791KB2UXgCBXc2qTWxrg0hfsySc
Message-ID: <CAPig+cSq89192SvKQRcPqDTnBEkVtLyrVMPmU989c5gwkO1tUw@mail.gmail.com>
Subject: Re: [PATCH 04/10] unpack_loose_header(): fix infinite loop on broken
 zlib input
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Tue, Feb 25, 2025 at 01:29:58AM -0500, Jeff King wrote:
> > +     mv "$objpath" obj.bak &&
> > +     test_when_finished 'mv obj.bak "$objpath"' &&
>
> The order should probably be reversed here, as we nowadays tend to first
> queue the cleanup before doing the actual work. Not that it really
> matters in this case.

I'd say this case is fine as-is since that particular cleanup *only*
makes sense if `mv` succeeded. Moreover, if these statements were to
be reversed, we'd need to take extra precaution (using `||:`, for
instance) against pointless failure of the cleanup code itself; i.e.:

    test_when_finished 'mv obj.bak "$objpath" ||:' &&
    mv "$objpath" obj.bak &&
