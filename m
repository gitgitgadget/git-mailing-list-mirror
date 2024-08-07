Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF77E563
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041883; cv=none; b=GAyjRanD1THc4H64Jy7kONngixVIaWdxvIMqMpVymxlhHg7xkeier+V17j5KiqNC6Mv0EM/3th3lPCLA63a2TT9mdcpMx46NG016cLOVJ0tXwNlH82pvbrJvDkI6FAv6xBuK6+TJGh8TlP9crUltLKs0PRUztpafPuor8Ibqa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041883; c=relaxed/simple;
	bh=ZFq6WyvDiBejRgCVJtgELKhfL/ZOXDjToWFQdbjo0Rc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GgNP9A99GdJeJhNDkHrW/dI3BEPudZ0RIc5OapyB+UDTp6g/iWEXq5E2KMvQ1qlLL612gRj/rU2Xfgpb8t1R2vJy4fcopvvRfvrmyt/2JTPuGsFBJdq7qJxj4WDESmxeZJ0RAk4IvgX8zmABA1ttEmYxdOKJT6r7cY7xq2cK+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4dYut7+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4dYut7+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1153401a12.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041881; x=1723646681; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KwZ3gOA0R9IusxgZxTNStc+zQtidwC/uOix0utWHn4=;
        b=m4dYut7+kgBHkVv/MGBZ8E52FFJcdrit2fcaQEUVQso2xM6irLtcsDD+pP1NFxD/vX
         rNZc8iilVRuz8jl4Jc3TB8PVAQrVlBjbxSdFSgoyVDmy4ET3+d6MwJHEsNmMkcSVUeAl
         LSI47+bDPGgCfDjeLgQkYGbhmyN/bO2aVg4a52YOCoZJCwY/qQutFtvyJaYdCwbAdi66
         KCuBhnfcHepha/PkjYYTIdlXoxXwHzhF9FNcADkUC6V0OUjinFC2MnFKKFTNO7gHQqaa
         pD+aeM13QYdsBDyaJjvLQhLwApUvmSKCZNlPrle4utvSAHAWzCK6l8CMuJj4ZQcGhqlg
         56Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041881; x=1723646681;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1KwZ3gOA0R9IusxgZxTNStc+zQtidwC/uOix0utWHn4=;
        b=kab1GQUCJWIRATQ51xDRxdjOToc/bygFS8J/hoLYepHbOgGl55rmodmf4YBxTjnnRs
         EsrfItEjRCi/VAaf85xDLfcLZvr0C/fJQnXDTJBix9wr00N9XzsjYH3DxLTkkejMb7oj
         4/ZHQzYhcIADMaohUTeLQcsMrfr7mkaCGelg4EktBwoMYUmxfOC696N/3nh3+vWJPIGA
         3zRLGFj+VV4cYn/NrAx6o5Bo+Z1GKcknwPIb5yXvUdQhCmU9M8AjlwBLjrFEnSyPwu6k
         lD9FqsWCsli3JsDRl857YAm27V7Mn4ZINyXyzNOvJo07b/fAlv3eE25GSKhnDmlSjUDM
         qijg==
X-Gm-Message-State: AOJu0Yz4V0RL+aMeXVJLXFexjr/BmspPsKXVdUM2oB3ebz6a5F2zY1Fu
	4acfoOo5SZ6+y3I/enQ5sam0R4yqdZcgDUW7/3vsuIodmtM5pA8X
X-Google-Smtp-Source: AGHT+IHl46MNb48qbuIys/GfMEXuPgAYGll1LK0B3mbAYe6gWnCUhdGRk8fSMdVOjHH7YC3tp0KxCQ==
X-Received: by 2002:a05:6a20:4f8a:b0:1c2:9070:90ce with SMTP id adf61e73a8af0-1c699680665mr15077274637.43.1723041881352;
        Wed, 07 Aug 2024 07:44:41 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfdefsm8527231b3a.101.2024.08.07.07.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 07:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 20:14:36 +0530
Message-Id: <D39RDAEXKU68.10JTFKUKJ6YHH@gmail.com>
Subject: Re: [GSoC][PATCH v5] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Josh Steadmon"
 <steadmon@google.com>, "Junio C Hamano" <gitster@pobox.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
References: <20240730115101.188100-1-author@example.com>
 <20240803133517.73308-2-shyamthakkar001@gmail.com>
 <CAP8UFD3VwiAbGvzgi14EcEQLX6Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com>
In-Reply-To: <CAP8UFD3VwiAbGvzgi14EcEQLX6Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com>

Christian Couder <christian.couder@gmail.com> wrote:
> On Sat, Aug 3, 2024 at 3:35 PM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
>
> > Range-diff against v4:
>
> Nit (not worth a reroll): the range-diff usually goes before the
> actual patch in the section starting with a line containing only 3
> dashes

'format-patch' placed it here by itself. Looking at the release notes for
2.46 I found this:

 * The inter/range-diff output has been moved to the end of the patch
   when format-patch adds it to a single patch, instead of writing it
   before the patch text, to be consistent with what is done for a
   cover letter for a multi-patch series.

Thanks.
