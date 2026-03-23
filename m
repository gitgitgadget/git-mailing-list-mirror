Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36528642B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249122; cv=pass; b=YJTD0JMs3KJl3wwX+zMHK6jky72YsfzIEcqNua7SwRS11+7pYTRl47OxTnbwovCg9HFMQJ4En2dJvu/mtPWhQNdobF/XjMlNyaFHaByW7L0Mj0Dtqgq/NxWaAwsATz0kUKg9uXyGndEFPIIJ9B9P4XPim6W0wXQ5V9Z4jq0MpP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249122; c=relaxed/simple;
	bh=2LlQc2VBZXdCwLUKREeHy45nsX7BdvHTBQ8eZmftyOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUcN2HZUFnuyBQ6FjT2inKb9R1R+/m7n2H2FQ4HeJNFnDEITYJMDJ7jyQ5cC2UYq9yymAAnWj+Q175wNSuRtVxfFB0RvzUyiRTuUUK7TbSbn1BiEMjvOn5xSlLm68uQqYl3qqhkbCDDJdmcEXjxzgjwO5zpe3hOZy+JVqxJKHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=SI4HumFt; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="SI4HumFt"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so2750663e87.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 23:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774249119; cv=none;
        d=google.com; s=arc-20240605;
        b=XsCLOJmxl9xKB+5cXnZXEaRKBKPdI7C1SM+gQXX2onsgtxaTVXybjvtAZvv374ijmN
         VXGLUtEEcGztdwlnZc4ZGy2tfTOeBir+pvwQmed5E09PVuYyM/BJDU4r+EKh6SJCUbt3
         1qjZkxcJbR/SQRxAJkXtE7TIyMOPi5mEraBRmWJdJTihgpXjr9FMrRBXg1FYKhhsR85H
         M/ANUOM1IsiFovZ/e2TNtAF3NpaSDcpEQCZitNn6EAChI2PWYOk+JzhEzmh22eReVkIl
         4NTDqr9EWK1gna5L0KIx2rbf1NDuzoKZ59m7NKBSyTP1SaS+UjZhk/Y9EYnnsRz2T30W
         b2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LlQc2VBZXdCwLUKREeHy45nsX7BdvHTBQ8eZmftyOA=;
        fh=FLmO9WH/nhnHUGkfDhwJGtMtZbaxhWpLsVRueFpTzwo=;
        b=EQBScmzRCXqURpegbUYMQl704WijbG3lo5VGFc6c6opD3JRwkgSwKc7oIyNy1bze1v
         7ggRtAixTfoTKb4Vc6YfePMdrTHNv5x1U06xOEryjWAgNm5tyhWkd18I2Q13zf3Rke6I
         +5ZZ4TL70q3ky0OwDLLL2Eb0sdLZZzBvdmu/vDzsV/S/Egu2H4awMnhkiiG7eEi/FoF1
         8xSjwv01twgPt1Onm4C+iQQkgKooRGD47Mz51uGGrIYGZcm1wXTskK8jd6x11DprvaK2
         25r6KHX5zQEDqThMDolasGFdgfkxwmSMv1tGAp0PPzd3bbzVT1gTeozYdquJ18JyXHAJ
         bnTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1774249119; x=1774853919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LlQc2VBZXdCwLUKREeHy45nsX7BdvHTBQ8eZmftyOA=;
        b=SI4HumFtg0NiyK3EZuPduBeC75qws8XInBIwCpckSO46hRcLdgqJJ38bqM0BprVEKk
         b4DzGRWR3i5SaOevqXMCMBJ1l5RkHXyJCLKRvkNcg0WqO55vajfdeehmoILTFZu4V1Ej
         7PpWHLXoaI6taYGcF4nEA8VOYLp/kouirlBWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774249119; x=1774853919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LlQc2VBZXdCwLUKREeHy45nsX7BdvHTBQ8eZmftyOA=;
        b=BngM5xqNlS1ULhkhiOrSQlXxDL6S+4Yflo+Q280z19irWowGp7Dehx1tk7Ha01oOhM
         yIp33eVAK2Vd14sEAC409Fo78gLUbw7ae+/RN1AXoDFn6wBl+4BRnUfJBjEp0Vpz6GZW
         +LO7gpZ14cA+UmQBK0i1IjeXpW8c8t8Oht0wWVVLMme+o84tF+dZmjFlmSCL4pvIATEA
         7RAcasRvXhA7MaNUf0P9wXeH1rgOwKyz+7TUSjuRkbwuU4U1J5kDBmfAXgv7BIhJC5pE
         riTZsBQK63R50JYbvo7dquCXMY7gSTrSFPjIwR/s0itlnd7UDMlUnN6Hs6zDwh6148NT
         iJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXL0IuLLpIvQzDbv4YqMeUt2mRcek9h9/rAYLNCT6/1TB3hWs2fgE6GL2TdnIu6zaU37fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBuLpaidj/98oZVblI1YvjlmH6Jwo5g9jJ8vbfBScJuRrxGhx
	KZIT+z7g/WiU6YQ0YnVjMUCdF3FWMGm3/EEhpaPgenqJ8N3EkEomjU8oBYExfZMdQV36FlQ/r70
	PO8krFa0FoCPb1DGUOVE3WU+0M4ajbtKEyBFsZlaM+g==
X-Gm-Gg: ATEYQzyURRMsrkIQTAmipxvOSkx7TyMDXk4PYEAcmKJBjQNYP7NLfjBB60nOKL8gjXf
	MGU6jjrZPtFn94gPCKQnMxyPERl1BN616lXvaPfHtGjkpXdY8nkiiHzFBt3vsjsUHeVpIHlPho1
	ZHcuPl1n1MmGrM0dol2ad/JYyCsLZqCWw72cuIXytFBDg0yh7mgiLg4lKP1U41xNoE2+36g47pp
	tZDIQZXGA0RhSvUFXS132KNLqAsyD8uB0bNi92sOTUxVI0oQ9ixPPvc4p17/LqjojhrkuFRWshM
	g0Y=
X-Received: by 2002:a05:6512:6d0:b0:5a2:845f:d41 with SMTP id
 2adb3069b0e04-5a285b61730mr4187887e87.23.1774249119033; Sun, 22 Mar 2026
 23:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com> <ab4RIZr7b49VKjR9@nand.local>
In-Reply-To: <ab4RIZr7b49VKjR9@nand.local>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Mon, 23 Mar 2026 08:58:27 +0200
X-Gm-Features: AQROBzBC653tE5w2MkEOBLO6EdiFlCrYSk9bZPW_MZ52EC0USdcWvjAbw0RRC9Q
Message-ID: <CAGjQmDPOo+c=i-oTOzCV=EO+B__3ySR4wd5EYZ1EAdL+jF5rLQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] http: add support for HTTP 429 rate limit retries
To: Taylor Blau <me@ttaylorr.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 5:31=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Thanks, this round looks good to me. The main things that I noted from
> the review on v5 was to drop the old 3/4, and a handful of suggestions
> on the final patch, all of which look to have been addressed.
>
> The first two patches being unchanged, this round looks good to me.
> Thanks for working on this, Vaidas!
>
> Thanks,
> Taylor


Taylor, Peff and Junio, thank you very much for reviewing!
