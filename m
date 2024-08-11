Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40717552
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723417404; cv=none; b=ggEAcHku9kfAzirzQSHwPU3QAL3nS5Q13UKn1N7eeti+Blq2BUY9LHEdSHExYGgpJR3Ylx6E8gW64XsHFAve6Eo1lDKP0ClNktdS5oXvumOKBuo4xcNUzOHwiCbw7b1/p88JPgaoki5WfSZa6zDnRy54FtIlacv+d8aMEAoKOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723417404; c=relaxed/simple;
	bh=BX1R3OQGaD2Fh138f3PdkOTIVfnfiNQgtDCyeV0em9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaWffUZFLChbxc0kjye359R4dczq/CFueBurSIe7Jq5Zic2p3OTueg6SZFvZLNnusark8pGwWAzSNUfAU+Z769HLbDrlRbG9Xhxp5LOYbJoBLjnQIDzbFfpq6csHJGvdRjqb8uCp0BBNA+JCXRN+hRFfSMFPLevYsGkW+mPvcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70949118d26so2926582a34.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 16:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723417401; x=1724022201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2A89KUEr3jXn5SM6vAIauQVlH4WrKKMvgXvJYinnuo=;
        b=LY0/IZHeWITAkR0aNys7//XSOcxKu93CGysVfuTSZo5fQkPfRCBKHpQfPNsQrSyB8p
         dtV4SKfoT1I+/1mq3aMl7fQcaOzatsgFkEe4I3tLGbxcgaxdnLoNFF4lzSGV7MHo1zlT
         bSo46dhKrIxj/yDezkO2Cx5PtW8cnfafYfIOcWCG8yt9KsO5CifZJOsHDLQQkD+/G6a/
         wOiFrIKM5QWtXjm53xcoEsVv5/FX9ExZvli3/tDl8gnsJCv8twHDpRVPAwSt7TLBiG5D
         R+wkwU8IYpqu5mmY3GyCe5TE4wkYbLsM265wc788wY5HGG4Et208U0psTmPcgWJgSbmy
         NiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWZK6EpiQp9aWE3IDDnOFIGlqVRjEIkgUfOwrackFkN6xQzV+V9nNrMFDNJA6FpK8rMFdtQjtLPo2aA8lAfPD3xER1S
X-Gm-Message-State: AOJu0Yw1ZqQ0u2vcu5614fxnGHa5hAyowpVZ8bVQ1xxpXLr7TVF5hvzF
	Kr8rBJSmwJr0jp3Dv7g1cySwDuuZGUPp6lYrqT8A3I+dUcRduR98J23R/6DqGXPfCwqjjspj+fy
	LBaU0Gqi6fXYxwVGAyIx7BvEIOnQ=
X-Google-Smtp-Source: AGHT+IFpt5RvEF0QiVhj60uq1qP6t+j4+6khXEvOQriCXK+8jwNTeZJhh13NK0VnPss14jDLKWdJbSE+RZU71p5G13Q=
X-Received: by 2002:a05:6358:282:b0:1a4:e0d7:8418 with SMTP id
 e5c5f4694b2df-1b17713bbb6mr1209335955d.23.1723417401320; Sun, 11 Aug 2024
 16:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com> <6398d60387a6607398e4b8731363572e@manjaro.org>
In-Reply-To: <6398d60387a6607398e4b8731363572e@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 11 Aug 2024 19:03:08 -0400
Message-ID: <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
To: Dragan Simic <dsimic@manjaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 1:27=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-08-10 15:15, Jason A. Donenfeld wrote:
> > Still the same name for v2? Cmon.
>
> Yeah, I was also surprised to see that.  This _isn't_ cgit.

Josh addressed this point in the v2 cover letter by saying:

    Known NEEDSWORK:
    ...
    * Bikeshed on the name
