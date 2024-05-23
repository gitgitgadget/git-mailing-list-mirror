Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADC2628D
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487197; cv=none; b=tSHUSs3zl2fKUwiOrGIn59Pj1YZWyVd3R54uiK3LHDP/enQ559jiBk+TAbbi5Q2A4aZNblGeCAGeRXlkKCCOALmI//c/b3M1LlsaPHh41O8FvEGalwXA+RVJFINbZKDpKMqU7nCy79G8/6Dc/jr8L/QkJw0e019/ZW5R9fjWBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487197; c=relaxed/simple;
	bh=3/kLpxQtXu1AyKKQsS8YZmS5WYOlvs94hqCc022Ntno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7b0Vd5cht1Z6c4CKsMKXnDJTSpXsw6pSa2EJ6r5AkCW+EWN61Tq8UqeV8ij6nftJj15jMlERyL8wCbcQFJ4DMoXgNQCjyL+WaWw0BRTFq8q0+QPzxiF5ofuzq+KlDwvPypahYQMIJbT6qsqi6lGlizvvNMAGKfWbD2MHJCFdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a08091c2bso236087b3.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487194; x=1717091994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/kLpxQtXu1AyKKQsS8YZmS5WYOlvs94hqCc022Ntno=;
        b=otyT4B39/iE2bczJufslhmXqyxzhVEOXQa7HEJ4kK9AIPjIB/vxqb9QRKB83b1SQTE
         kiQNKCLvcIjaLF7gH5RO1dFvNR1R4SMroQEJ3DgSWcYcHSEgC/xJdSk++7ASvkeVaupS
         l/ISokYtvI3jgCOR1fPm0G6x9b7bntkhZSmoKLxMu/0ipvFoE8N6H37MDKy75ZkDo40C
         Tm3+BfJQUM61Qaxh8gVm39NOn/6jcDOOmJyGWE3QhwUW6XU9xMvdcZvEekF7E+skChSg
         qf9G5fpBRVONPuWQaV2tpqVws1Zc9OMw0UMDv4Mp7V263aFTsiGVbuI5L1K37dVuRjpV
         wlkg==
X-Forwarded-Encrypted: i=1; AJvYcCVzB+ib86QH9TZHnSbkXkF/sLmRK2KPX/seqAMuZrlnwnZd0foadeaUjk3tnmqQLMCPiTJdRTdPbS9FYnBnybuhTPtC
X-Gm-Message-State: AOJu0Yz+n5s0ZP0mdcn/YgQrRJy5jA+c/TkzflVfRmvi/9QqC3SusKX+
	NZMQwDi6g/NViLXn7swVN1VbaaQGLhYwORpggTnQSR62mcZiJD3oLR66jCv0SGY+1rwR0at/yaJ
	kn5PWG2pySWwOuLSRWgsc2gEk9qDF5A==
X-Google-Smtp-Source: AGHT+IEpU+NJ+hhMva1s3iCmmsbFPhe/6OiNnu/+l0/n3YfeDj03EA0y7lh0wSs4zoqsRNj13QniUD+FoAJ3EAXR4/E=
X-Received: by 2002:a25:b814:0:b0:dcd:d94:3db5 with SMTP id
 3f1490d57ef6-df4e0dde81cmr5837390276.52.1716487194195; Thu, 23 May 2024
 10:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240522090326.1268326-1-knayak@gitlab.com>
 <xmqqbk4wy3ji.fsf@gitster.g> <CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
 <xmqqr0dsv6e8.fsf@gitster.g>
In-Reply-To: <xmqqr0dsv6e8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 13:59:43 -0400
Message-ID: <CAPig+cT6_j80vh_HEjg6HWKXpkv-huggudShh_RgzLSKvV_bOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> We may want to teach "format-patch --range-diff" to place the output
> of range-diff _below_ the list of commits and the overall diffstat
> in the cover letter

Placing the range-diff below the list of commits and the overall
diffstat in the cover letter is how `format-patch --range-diff`
already works.

> (and at the end of the patch for a single patch topic).

This could indeed lead to less visual clutter for the single-patch topic.
