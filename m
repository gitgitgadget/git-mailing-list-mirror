Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA71E47B3
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499442; cv=none; b=g6cLqfqIH8nDU/s7SNRxhB/2PNKK88dJQ4Ho7S5CLMpG1wSNZME9Fqdx5XyMf+NGLEB1gnQSx81bG2aAwopRiIc7T7o+o4KHo9tpBmbU27KGXo6WFt/9H9GMHZXGrSY4Wb7DZSOoZq5r1p3LbE4b4RdtfUUNapW/NDOVOdRHw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499442; c=relaxed/simple;
	bh=1gts8EhdaZaNChAJ4QpSPnnmLB6hH3PvaQ7Nr6CM9T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9vdMoItffyZDljiPWjLU3PKaoKywFDHxurAwlldgcZn8EIv2fNQSIGO+nfFFPzaRGpQZVUVW+mesPKK9unmIOtdIuG8i4cbKBavDV0iUcNFXa+GucdGwkKsdH2zK1ZPKbC3RP4in5EITBz2Y/nJhLsrKYBgP2oTLJj628oBFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f43676b7so1110446d6.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499439; x=1743104239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDvkRdaUJLTiftEedrZ79LnI5P1Pnc+oR2RiDw0R8vk=;
        b=ZKE3KPjbs03vkHvDooVUuknBuHlPbRdE6Nb6xDi93Gr8Whi+KOqD9DqRb1AMtHa3jv
         jh+cJ0nlbapfiVCtLj7hnr5jT9eJhg1EnmfL6NnwK1WRS407HxCuwRzO231xsFIJvvfD
         CUr6LENAl7Rw4Eil2Xx4uZF5ZnrUE49LYbcRz61wShb51f5Z2A4OLppY49wwufKi4Es2
         VNiqlw0+eI9JTKzX+KoOARl799n4wIWZHNG4T3zxJV1VLYDcLCcox/AZDHo8H6X7vvUD
         /ImE69rqoONaAK4ZbV+zDRGDJICSZct9at3MhF3+YZx3kDjkFI/0e9F6NzlmxSpgnr4a
         09/g==
X-Gm-Message-State: AOJu0YzKvAj0x7kNv/vmbk6EhkfKEM0zy5euYrrub4FK1VyTlGZj+GEf
	Ef6Bgq3SecAcRUIOaFxFtALh0pBVMQx69gwsMlrC0j4+4D3pYkJKZLq6ctP8Zcx7YuU8SZhaDyX
	ewt6xdTG8j6MfHJyltKVsGVcy18vpPg==
X-Gm-Gg: ASbGnctSIKlXWiXsHBpx5bbqbTl1zwUSl3YW2e+psF/zVcQLCGzsh1mYBbWe2zoHW74
	Iv9Xzmfahz0pgTLA+bkf9DqoaNp/aLi0k+jIzjuM/1i0o9DdMrcuXtaytn+MhIuptAlllLRjjAs
	+TZ38+jJrTwItgt7TlE9FtBCkP
X-Google-Smtp-Source: AGHT+IFgXZt++8ylGmoCRQSqYeXFvzWTp5gyGXHrXRJEyNTNzBgs2CHKWvWBAHR6BFtmPGvtkoDzmBo8f47IH6hjbBI=
X-Received: by 2002:a05:6214:21ec:b0:6e8:9351:77f8 with SMTP id
 6a1803df08f44-6eb3f2f181fmr3260066d6.7.1742499439566; Thu, 20 Mar 2025
 12:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Mar 2025 15:37:08 -0400
X-Gm-Features: AQ5f1JqZqRAHO4J8KxrVPbdHLD-YEByfgEmxhrVHzIoLf-T18Wxm5NjJ9N7uqX0
Message-ID: <CAPig+cQdoZwY3u-xr49Jb8aaQmE69p4i4RUdy=cRv-V7VoWENg@mail.gmail.com>
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv scripts
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We have a couple of tests that depend on Perl for textconv scripts.
> Refactor these tests to instead be implemented via shell utilities so
> that we can drop a couple of PERL_TEST_HELPERS prerequisites.
>
> Note that not all of the conversions are a one-to-one equivalent to the
> previous textconv scripts. But that's not really needed in the first
> place: we only care that the textconv script does something, and that
> can be verified trivially without having a full-blown invocation of
> hexdump. So at times, the implementation of the textconv scripts is
> reduced to their bare minimum.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
> +test_expect_success 'rewrite diff respects textconv' '
>         git diff -B >diff &&
> -       grep "dissimilarity index" diff &&
> -       grep "^-61" diff &&
> -       grep "^-0" diff
> +       test_grep "dissimilarity index" diff &&
> +       test_grep "^-3d 0a 00" diff &&
> +       test_grep "^+3d 0a 01" diff
>  '

This change seems unrelated to the stated purpose (`textconv`) of this patc=
h(?).
