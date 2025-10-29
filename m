Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A93358CA
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754788; cv=none; b=AbaYDAIReOG35PjtscRZjyX6PWVCQ/qQXrbOySugs52hMJoJ9N2fvMLslNARVvQZTYKuYmPsn/ae0tShN6iC5gMGOe/2YxrrZ/p0vwG7bLu59yz3K/zQ9m3ifCVmOgJ7KiC9C5/P9gzVRS0M7DE9XX80pHk0tzrWY0flszUeAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754788; c=relaxed/simple;
	bh=LSlvi/+HukKW5qTuTv3cdrOMzsmCX0OcaEwaU6HMrFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ougighMPX6N87hAuV7i0LM7aGetmjp4wK5GOPoph3JWId9SjZDsRG/NlRHpFhicv+Ff6mok2ZF7QzTfPmE1hwkAqeEruwWgMamiqSf5Jr15jwiGK4B4prjiEbr8Tj7FssxJ2zlxOn2uo5B8kOiVMQzcJjISidQOnhx+0QADDYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C79MKJ8T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C79MKJ8T"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso2246053a12.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761754785; x=1762359585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFEPyddicOy5ce2DKIFuT8M34dnCCXCbF6YDnzfLqqs=;
        b=C79MKJ8TgiK52lWbXzRatcTld3vAEaa4sb2q1b6XHSlcN3gwwFoEYFP/r9emiO2SNT
         y73ZL8J+SxvD7IRTnw1zQyuWOwW8/75qVpm41D6G4L/3NruHffPgsz4O0AVDeQa2H9D1
         Vwuw4zjXfW17iMWlnMwxTRUM+XwTR+A/m6R6QoUgbIZdsaTJtG5v6ohWJPnfGx7s0xxH
         Qrf/BVg5OZrAW6yV7TcEa5XLeDxAQnLTGVdFz0/enIJpzhlJM2a1zbrYsr27J3fz03v4
         GGoht37Q41EUXk6FyUzkrbR4FOB5oyf+hpFh65pRt7fzp0jIwPvoBR5DBQ2BStcfSutZ
         ss5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754785; x=1762359585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFEPyddicOy5ce2DKIFuT8M34dnCCXCbF6YDnzfLqqs=;
        b=chOnncVKdq1KFGxGcN0CFymfs5I8dbkEv7UcFa4JeQzkqWIt5iBwuV+w4VNcmUmFYv
         oprgbDHbQ6kWnZ5kK7t93ZJdEn/JR95rmBsZidvNGl5HK8NydIJeP0M371pBf2eh++Ao
         CJjjQueopZPfOAu6pKkDIIB0yAX9uCjFycNgAP+FDXai7egcoRFbSo6ijy65P3RcsEej
         ylDhhBy5XBnSCaUNkefeBKzdF8XQXdSxfBuvywi/896/G3HJSLHpj61QgxG+/NQQ3BLp
         igAbZ3kDMlpEg926SiKSJ4uSipRHoFGmuXvQ4n2umenZwvhospPPAoAfujrmoPYwnxR0
         GoYg==
X-Gm-Message-State: AOJu0YyeEPsYkDIraHiqRgfpKbpfyOmn4PJqIHtq52GqGLyx+aLaCo8E
	lGMOF7+SJCfbo37vq/gReKIJ14UHZlBAHp+sKxAkMbAi9RfqoT0ykpdTh3rgXIP6yRf5w+gGKA7
	tiALSJcjBcxZ76k4yqlDZGJKFBskEIFiCaQNB
X-Gm-Gg: ASbGncvnY/8fyu9RAZHLGzNn9Cz1ZMKWeynkfy5n+8deIpsyMxasO6kYhw6LN63mmCv
	2u/g2Y9fsvBMWF1NrOZ+WyqfL5ZPRE2WPEuaAwfaRYXF0YjMxKEGxB3AkFaRnEL70qMkB+GF0+O
	X45I1jvkxjemWjaUp5VpD4WO2IYv8qkehTUQl8566ROOIuvY8/kEmUsDcn0JHLCIEDdzS7fONxX
	dUG2tK89XtsIvRjJ6JKvAIqWk6P+OTv7b4/Ji2Y1liM0XD/AdDChhzuMGGIUaeuKqxTtc/io0KW
	TqHMG7377laChzrUCG5tP7geFAon
X-Google-Smtp-Source: AGHT+IGLKthis1fW9boWe4aDdCkjpiUsEKOiniChXMDeao3BHXaG1p6b7FMtEX7hwzWiNpQiHeFLvMBoskzy28Afl6A=
X-Received: by 2002:a05:6402:4312:b0:62e:ebb4:e6e0 with SMTP id
 4fb4d7f45d1cf-6405e7e6bbamr174662a12.1.1761754785094; Wed, 29 Oct 2025
 09:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-1-siddharthasthana31@gmail.com> <20251028214609.10041-4-siddharthasthana31@gmail.com>
In-Reply-To: <20251028214609.10041-4-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 29 Oct 2025 17:19:32 +0100
X-Gm-Features: AWmQ_bnLkM6bAnTafS1-0Ko6JFOh8pqytbYrDxQILSXcSW5Y40f21D4P9JORVvE
Message-ID: <CAP8UFD03fx+wKwJzDG8UZz=+S8=07hG6npNnebTmBxrcXNYqGQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] replay: add replay.refAction config option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	newren@gmail.com, gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:46=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> +static enum ref_action_mode parse_ref_action_mode(const char *mode_str, =
const char *source)

Nit: it's a bit strange that it's called "ref_action_str" everywhere
except here where it's called "mode_str". I'd prefer "ref_action"
everywhere.

(I understand that "mode" is related to parse_ref_action_mode() having
"mode" in its name but it's the case for get_ref_action_mode() too.)

> +test_expect_success 'replay.refAction config option' '
> +       # Store original state
> +       START=3D$(git rev-parse topic2) &&
> +       test_when_finished "git branch -f topic2 $START" &&
> +       test_when_finished "git config --unset replay.refAction || true" =
&&

Is there something preventing test_config to be used in this test
while it's used in other tests below?

> +       # Set config to print
> +       git config replay.refAction print &&
> +       git replay --onto main topic1..topic2 >output &&
> +       test_line_count =3D 1 output &&
> +       test_grep "^update refs/heads/topic2 " output &&
> +
> +       # Reset and test update mode
> +       git branch -f topic2 $START &&
> +       git config replay.refAction update &&
> +       git replay --onto main topic1..topic2 >output &&
> +       test_must_be_empty output &&
> +
> +       # Verify ref was updated
> +       git log --format=3D%s topic2 >actual &&
> +       test_write_lines E D M L B A >expect &&
> +       test_cmp expect actual
> +'
