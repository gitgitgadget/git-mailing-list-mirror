Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2077246BA1
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362892; cv=none; b=Dhpy7g1stJ6DQ+E2d6/OnTqabszfbiWbYgy90Ttymg2CCxZZ7mod3XqpJ01fqTyR5OHKtkxonAYnAgwg3YAkDj8ZEtC4bSXqMmWmYeS9bxf1PySlGKpoLcaYF2uM2Q44RgvZ9t4ZDynk4A6y2hDVUjh98jZFbPH6QvFjiuHEF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362892; c=relaxed/simple;
	bh=IXj02XiJr/Wvqr9Oyp+LepP+jEODFJHzEX/aVi5UUr8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tznucfjtgn7HDlTb7lmf7v7M1VsLosRYqagAUsJOXsYKMG4N5Gt7RI7TlyK44Jtdoy0bFPDXyQJAF1+76PyRm8vq7EJ2qs/RsY6uKkeTGkF84qxidk/RbC3Y9AlT1YztdM6fHg9DPETy3N/71P5XZeCdLlbbM/5QKSRMMn6iC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCJHhFwY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJHhFwY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so765809a91.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750362890; x=1750967690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IXj02XiJr/Wvqr9Oyp+LepP+jEODFJHzEX/aVi5UUr8=;
        b=kCJHhFwYU1jCYmR6zSgg3HVU31zrMjeDgH1UUSusJNpf3WpV1VMxAd0G3ggo29fGYO
         lD5CEOeLK1ear1kIRMdSmMuxEEk12WiBUpquDsESo5R+MbsTSrF9hMOQsld8RoVE6eJD
         +d0MH5Zw1GPW106ekk67liprzo0oVzqEH9XaaJ2rpYxIpdN/coZ97ZhRlIq7AAX7PopR
         pReiBtVPW6iK+vcTbwV8hyX5G5grpgvHMWyPsMKCMtpBa0gP1A4nmQQNw45GZECfgnL+
         zLNmNrub9/dyl5jCsoJGefNcTNvw334y+HMI93YjcjOXpXAZkCW7ceViaCWaHsvv7NPt
         9VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362890; x=1750967690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXj02XiJr/Wvqr9Oyp+LepP+jEODFJHzEX/aVi5UUr8=;
        b=cQncfsJLwyIle+UepfnEVOx/1k9hhJtSSpt9mXURaLHy0DKa48oCz02cZM4ajPurht
         9F3yZJqsRYfMq2DApxmTc5CT7nlkUzKOTgzE0ZcDtsA6GHWTC8sti0Hyk6qXOS9ir544
         ixfa4HSck8Wzi/neZn5FM0DwPdkJNwkMrBn6BUrPtpGyHCh6gm73zZ1YZlwAjFpGDtRf
         9G7ZOEIJib9+d1+YRN+4QnliWhDoswm3a1fAQhLLfugh6IrXGX/LGkwB1IAAT+VO97Uc
         7IbIcVR9/XL9IYufyBfIVdqYitAFCXCnWg5+g2qUdxBOTjdrJdzenDeMH1sB/SBUU3xB
         Yh3w==
X-Gm-Message-State: AOJu0YwCytg7dmAxOgyrtvxheP1McXjBAKM6LWqOnsD97k1DAMgEkn6J
	ZZ0LqXFFS5KW/10i/9ubXVPX9qC8//pqEF0zT4wOh5UD++xKhzAuPYMTFgt0o3HB1m6CV9/MyjZ
	ijdMtCc5hBOk6qCSHX3qt+z2+xzHsl0IcUaAAJZU=
X-Gm-Gg: ASbGncukVAa6v66Op1vzXXZAXbClhulYZMKFrKlBGD1znQMNOjYa8kovbXorLY2ldbN
	Sd7PsLEgQv4FSTfI2F/4j+YQ2SwwBPf9bx+ATxhOSoW6b/PWZ11rZRo3qXRLfGH96NEsos64Js/
	ifVAG4eL1zW1Xdbr4Zx3+xBWj2z76IfBFbgoj2YfmIV9W09AEXKWj4subk
X-Google-Smtp-Source: AGHT+IFWQ4gZeDQNVdo/FHl8TGfLOCWJGYjXpmGhcg3mGDV6SZn6qbxR4G0HsvN8ACFIN30NLFg1eYzsyNa+khj2BAs=
X-Received: by 2002:a17:90b:51c6:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-3158acdc1a8mr6715447a91.16.1750362889756; Thu, 19 Jun 2025
 12:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 20 Jun 2025 01:24:38 +0530
X-Gm-Features: AX0GCFt_a7HL0CVLnnOozk8pgXA2T3XRKXwBTq9Fzb_fqDusotsMoCLxb1q2uKQ
Message-ID: <CAE7as+agjJm=taLgeracuApiGR1YgP5ZQhoHroTk6=Z0E9ww9g@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC=5D_Blog=3A_Refactoring_in_order_to_reduce_Git=E2=80=99s_?=
	=?UTF-8?Q?global_state?=
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone!

I=E2=80=99m a GSoC contributor working with Git this summer. I=E2=80=99ve b=
een sharing
weekly progress updates on my blog:
https://ayu-ch.github.io/

So far, I=E2=80=99ve posted blogs for Week 1 and 2, and I=E2=80=99ll contin=
ue to
update it regularly throughout the program.

Feel free to reach out if you have any questions, suggestions, or want to c=
hat.

Thanks!
