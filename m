Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40779EA
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818609; cv=none; b=a8weUrGKx7n1gEkQfjYT8dd71J0DIoal1U6ylNvkJmz7rev5ziNKJFE9bgkXtC8BIqBPvyld0UAEVEJg//MiYvRwQxtBODsZBH7FlvBCTluE+19V/IB39kduZNeGoO9AIL+ERULcn0XcpmEV7C9/qPpBhgW2bpakst8Nw3mll7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818609; c=relaxed/simple;
	bh=gnD24nSs7RUS66CyGvxaHm56LotHN8d3k/Q/hcEM0k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVB5iJwXYvXwO0ib5Rnl8HHQH9q95SHzdJKPD97nY8ElbThCxtI4RWZfViQk7962c74NG/hGsR+3ke6TjVQpBi3/DeHcsFRzIV7S+zT96lrMmez9fgQkF7+4UAV9gGfUNUQAOGHIucE+7hxUZd1s3YofXxbdGNa5vBaJSizW09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFDK8eZs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFDK8eZs"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ade750971f2so258235366b.2
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749818606; x=1750423406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YODZewk9UlKNZh0dhW9XyizZAw2BU7pV1dfm9Sxu8DE=;
        b=BFDK8eZsCJ0q17+Il2aUBtsta8sj1Ps9IKx6XnP6Eb/m0rKe4hhaf4hB8zOUbH4cRc
         GrLpsc1jQBJkIvgZAQa0nzQYMiDExdXuA9Br+kPJwpku56dbmx6t9KxEfLKfkPMcnuRa
         cH1bQYM6w156QBB3aQsBtynrpDel8MQsCiGx25gRlOQdLI4O4elIiYVi8XjqQkjgLBT0
         TWljhRJAT2He+LtzgxB0vwBO6zSr+wqtPnA8LWBSdlbU/y/2qYJ0KlpMEjiAPpJaoNgr
         KTorRYa9upJUKHML3Tz5a/01IRQrna3A+tHFCGEKfov017f97NxBZE+2Ss1NMIYL6iga
         IREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749818606; x=1750423406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YODZewk9UlKNZh0dhW9XyizZAw2BU7pV1dfm9Sxu8DE=;
        b=ixW6GmrMwFxl8/2dZwErhFTlloxLaDIK0FLPTZLb8dObfrEW0tIrBW75Minsuzu6Je
         o/11tjxoKGsTAZZn7xNWUUQxRdt8+z/zDGvCrKpek9Q04QQEwW8mEGBY0+zx1ir60twO
         pGCyqkSrJmUKEs0PJB3F5rIfkraAejpcCxSpEEVaYb0JRzxSufU8Ln6183RYM9/kPK+D
         NRHSfH7OXTfLRDLFuBKsimXKBB8htHjzrse5vtSzWgnorNjUAK9SZZNpT0zLlmxUKvBK
         xHGD3HXChDbA5L6HetEF0sT8R8irbV11GsmQOXelYJ/vYok9/ru3cKwTLXM51orvrObF
         wlEA==
X-Gm-Message-State: AOJu0YwOUY0HeG59JW6wl5F6Niv2m77hhXHNXugdaSdqqzvWpCdch35X
	nB2AQiYLPPwVNasSCG0O2kamR53TnodQPH/uEboW+nPeyCa1jbI80mKQBHDHZBVf6+DahWtbqTZ
	7bj0e/FMiVN3yLfMI3FHF/bAq5HtvDB4=
X-Gm-Gg: ASbGncshw7c58WkJ6fHU1GhzqwbNdnqLPUpZoNCzh4N1VcSgBFarnniOC3Q7uAiG2DP
	qsy4WnwN/GH3/8jcIdRAxDcfzS386VswJb7TsA5it/JqSsaL5oob+MwjeHiLC7G23/BTIswAs3+
	A10KK6WncuIlY9uRn9M6BjiD+jzUsXAxXUwzUIjBipEzuMyF+5mhv53Lgf
X-Google-Smtp-Source: AGHT+IGkjxi2yNi+EWiv3d3kaEevMCyTEP41f1lL8G0s2Hr6CJZkFFd8yXLSpMT/iJj25qD3J3fvt2Qdae40syenCY0=
X-Received: by 2002:a17:906:4fc9:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-adec5583313mr284613866b.5.1749818605444; Fri, 13 Jun 2025
 05:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
In-Reply-To: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Jun 2025 14:43:12 +0200
X-Gm-Features: AX0GCFsJnPCILJUv-QEWY-nf1zeG0RhVuE9LjslVJFYqGIZGgYGX8iVmBKWtgFk
Message-ID: <CAP8UFD2ZhXSE85EtQbA42UR0ds+nsQba4EcY589raMBAoOrfLA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] refs: fix some bugs with batched-updates
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:

> Changes in v4:
> - Swapped out F/D for D/F in the second commit, since we are talking
>   about conflicts between a directory and a file, also D/F is more
>   consistent.
> - Fixed some typos in the second commit.
> - Changed comment to single line.
> - Link to v3: https://lore.kernel.org/r/20250606-6769-address-test-failur=
es-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35=
@gmail.com

This v4 looks good to me based on the range-diff and my previous look at th=
e v3.

Thanks!
