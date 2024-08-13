Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C1433DF
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532244; cv=none; b=jqlNIIIIzNRe25QIdyqctZLDW2SDVHuGm1kxnfmO1icH2vRp9Lh9q7SMxORUutP+kOxEBvN1cmHq+VIzghQEahVNyUyBV/S/mXtPjkapOeg4e2AN7gm47g8NCXRzqgV0+Fh50s7rHVoJLLalFDUE9PCQTKrmUUAFEkIUhHFPLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532244; c=relaxed/simple;
	bh=X8OPCaRODJss+TuF4QgYzYgfHtdrhTDwi/SVDByINHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swTFaHqX43uR1L0/VK+qgc7v7BVR5zAUZ058LwNbZ3NROfgHPyMkvWn9ZPoyCNi6MwnIFwZtj8M54MSJgZ7Wl/3tJIT/z7C6MKFPW0udSd2NTpDFlVh1Dc73bVR7ya5vqG01O88Gi0pOyyE8IMJfqKFvsiJ1teGmBgDLXDLaWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf42a563c8so9035306d6.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 23:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532241; x=1724137041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8OPCaRODJss+TuF4QgYzYgfHtdrhTDwi/SVDByINHY=;
        b=bfJ0ftpj6tdgmgWJFnyRgRih1W/O7qnihbwXs/uMqFBeKBDrIiBV6dXw+KUjTL+HN1
         b7wZqttBa0tgoB/AQDfRWvb5+fMTcZchtC97XcnU4M6Anda7e2sz+5lQNAyJHHWM2kBu
         JrVa3Ds9nIUvbUAkwQONmkb2/RQU0+DmO604HHYkJuqc6N0rTgvVr5x78fPxMC6bKDNH
         /jnYNmG7GLG7/oecIMKDmJEKZ9qt4lTABuycvU0lMpojoHcCSfZW5lwnVHInzGVkE32I
         P1S5xa+9q4EctXGwutUXZdR9j6YKW50bVNmVtcrRnCQBO9qk+ltUtzjcri9J+bDwlke/
         hwlQ==
X-Gm-Message-State: AOJu0YxZ+Rqw3+OcRdwG8/cNcSjJoF19+FNVOZTVwkt8sCtarH/QoVhz
	b388O+CFrkqwW35b2x8Z0Chr2Oyqcxed/MWvhcOvCfgv0g947DpJi//weXR7qPPQ3P4ltSJ6CrR
	xeqNq0wT0u5jfNDCMcyBVumgyhEM=
X-Google-Smtp-Source: AGHT+IEeCqCHVkMvYvi8TvpWST6X+syJ58+OSH+DRcblmrqRq9Owe1NQklt3l+gBAggl/AH37Keo6kJexgTlT2qMVL4=
X-Received: by 2002:a05:6214:4892:b0:6b5:1976:98ac with SMTP id
 6a1803df08f44-6bf4f7eb70fmr27655586d6.28.1723532241293; Mon, 12 Aug 2024
 23:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723528765.git.ps@pks.im> <ab7538d0bbb8b3c02b5db71a421163fbf87a45f6.1723528765.git.ps@pks.im>
In-Reply-To: <ab7538d0bbb8b3c02b5db71a421163fbf87a45f6.1723528765.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 13 Aug 2024 02:57:10 -0400
Message-ID: <CAPig+cQ7+mHQNL8Y5m_8puM769qyTJTLOhA5NHnFLapO9P-T1A@mail.gmail.com>
Subject: Re: [PATCH 05/10] reftable/iter: drop double-checking logic
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The filtering ref iterator can be used to only yield refs which are not
> in a specific skip list. This iterator has an option to double-check the
> results it returns, which causes us to seek tho reference we are about

s/tho/the/

> to yield via a separate table such that we detect whether the reference
> that the first iterator has yielded actually exists.
>
> The value of this is somewhat dubious, and I cannot think of any usecase
> where this functionality should be required. Furthermore, this option is
> never set in our codebase, which means that it is essentially untested.
> And last but not least, the `struct reftable_table` that is used to
> implement it is about to go away.
>
> So while we could refactor the code to not use a `reftable_table`, it
> very much feels like a wasted effort. Let's just drop this code.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
