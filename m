Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65C3EBF31
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190492; cv=pass; b=Nz7iyTomz2h13sMXtNR2vezrFYo2bz/dJd9m7dH4gh7BIAghpRUXvXlNN6hSnbXs4g2nwRGNqhhnKNhBspxRtIRHl7O3CywOywEyt57ogkSp15IUEkiGWNSiMb3488HUywJPKdxRs7Ue9itnC5dIHJn8oqW2LDoX7Ipzs+mPm3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190492; c=relaxed/simple;
	bh=GQ07S/JQeWCQYWepdVsXrOvMbi610ehmhwNGiA7/Dgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tgosyk2Z1jACugMm3EmuTeKDUxEsfAoxl0XF4wGDB4G+Xx2Ww8K0EoPFjXzcVFeIkerquro1bICUmNN+N9SDS+XrpLiHGhIeBRhViXe2STED/eEWTSqTumDisLXzufhGsxCeJIQNpkSoQTuXGDxQyzTrRSxSyJNqMxmJ+5P+qUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK3EFGG7; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK3EFGG7"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64937edbc9eso2342030d50.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769190490; cv=none;
        d=google.com; s=arc-20240605;
        b=UTTGiwYj0ivkkKKFnf1l8kWzy9cEd/VGtO0medHdSZA6HfmURDVAwtiCkj3LWTjIJJ
         RsvZmKQxuKFQK9GlRhCs3BWKV5r10QmNVHxnHxxOP/fVC6cEsyVZuhnvUrs9k73ftyle
         qnqzweTHYVslJl8IdUTgCTpehLDQUvJfX2Z/OjveBXgZtvdvov3LizOOcvs0i7tYo4mo
         vN5x2CkyuOwXWpVw+PPpO2PYPNXN8qiTdmTptePxKP2xkcF29gMU5pYVzF4DufZnwbDD
         EPkO/K2QVoYrDUCV9p/sGdyQ2eWvYOJv9BEULlP9vePli+4nRTVge6VrMIAizpoqHIrU
         7TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GQ07S/JQeWCQYWepdVsXrOvMbi610ehmhwNGiA7/Dgo=;
        fh=M9xm0D6FtuTBqEh3xNlV0ZtAxvxKpYXc8z+aJZbJU6A=;
        b=JhPQJMNj/rclRRJFvnsk8QQZvrGWhFMFnLIKDCEMdTUcfZe7qEpVzHYmjXFcLrvyKv
         PCQy5yt1UWnJf7J2Ui5Crds2P+B31xSxFwrDu6IIhl6H8wMVwbAqjGUItV7MYZe3Ljr8
         TRCbRr7NdUPXRx2uGM2/f1Mkz4Dp7r+pYT+2KdJC4Tcv9bhArmKjwbDHNfmfbnQv8yQ4
         9Dz9iahsVcImJk4q3Yc6B94PIrX/UKkB+OdMoENCXtb+a1AxhmNhIXRhLGQiiv32K9C9
         Z64cxivxdMekhBLnX0mEd4eNA/ddWCrzZE94u43+qgSQC6bmHyNVQKucMlKqNPAxKvwV
         MfCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769190490; x=1769795290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQ07S/JQeWCQYWepdVsXrOvMbi610ehmhwNGiA7/Dgo=;
        b=mK3EFGG7VjX1tXW0F30aHZMKpqN3o+Otfup0RrNY8b8Q4NzO/wsQquQwNt0726t3VT
         kiEQQ0Pl0XAF8C8mm9ho/Y8vfdXKXS4fZ7Ov+cddChK8FzMnO4WfB461UTLSF1Z/FCKc
         rkPXL+JXCxOfgnVw3OHqaWxjszwi53Y5O0Aa/YUmv4tzFEe77UTueeVjvEHk8JGJ5vwI
         Ij4M2o9R3KY4HTfYPF+a7n3/DvL7pTrEzWUJ4+mhH1mbVx3X6FtdegTQjf4ZUz0hYI/p
         0oyoWnpCXo5qNCkl4eZhwvpRuP1mpDjCDhJ61FvYNrRjAksX00Eg53av4B5d6wMWzBv/
         2u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190490; x=1769795290;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ07S/JQeWCQYWepdVsXrOvMbi610ehmhwNGiA7/Dgo=;
        b=YcvH66cAscATVDxvSpeWKO0YSXMcnc3c+t1P1JDX3SkK6GkJjk4e8VPWBWxHxv+6Sb
         A5/y2VYyS0NF0cEl+4OEYYs2D+4xQdEQlHxaVxBukb36HxvyZoUJD46I2WTqjuO6O4H2
         A8hVaHTA59GevYW+La5DhCWjssrydW4vHK5Cb5ElFXvX/FgYlby8yb1QKmyEYT4D6CS4
         H//zO5beJcXJ+NpAC90D3jFUGEkNZ/plm4XtldH4PXeBWsuFOFo8xZK8HvcvNxOdTjlG
         h3gfRIdhudvTk/EYkPgB8CsVNPTn5LjslLZ+qoBOfa9M1ETELHXP/VZjIlEzGcy87wDE
         DENw==
X-Gm-Message-State: AOJu0Yz6VYjYHwudy1wUqAWRpRknp9SMosGdDhDt0YLB7HrBOvGnBqfd
	Xq2br+AARAjI+Fdn8QM8z34Xdp1vsdDS4gl7cLQGN1aBt6yCsXEKfkFqEUDDCdXcGCj8KEEWDRq
	fhPSQs1MJaTi0LWDiYoIyvxN0Pss+JpM=
X-Gm-Gg: AZuq6aKGczslo2B42cT1V7uAhqEhpHgleEquKFLVT3gD63OIGyE0BMpOek/LAJvhi80
	0ZC1N3qTkAvty09d309/bRRsm2EcbIR4nqK18/Y67aa1jLiuhxHjETzFpaCCIigZMcVGF9cllGQ
	k7tosKb+5yvc7NQLfTcyGzPL60zUasJFSVl0lnSYqdgTx1ZlBHxqnn0SgEdMEq4RkrEhgwNW0cG
	ja0cOZGbfj1KDa+TC9e13ntQqV1qY9ZSZ3cX01wamc+Sm6jB6dul4yzieh24bDr01Mxpl0=
X-Received: by 2002:a53:a84c:0:b0:647:fea:2955 with SMTP id
 956f58d0204a3-6495bed1382mr2369413d50.25.1769190489827; Fri, 23 Jan 2026
 09:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Fri, 23 Jan 2026 23:17:58 +0530
X-Gm-Features: AZwV_QhPWXCZNbpo775ioOM-qJGSXltw0DH9_78Mr0LlFSlHCWK0w56UeXTZXCk
Message-ID: <CALE2CrTWGTrttvBQFAAfFcXJD7wWoq4KHue1q7ra1WTgUOYtrQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] subtree: validate --prefix against commit in split
To: "gitster@pobox.com" <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Content-Type: text/plain; charset="UTF-8"

You're right, thanks for pointing that out.

On rechecking, v3 already included both the indentation fix and the
regression test, so v4 did not introduce any substantive change.

Sorry for the unnecessary reroll. I'll make sure to only resend when
there is a meaningful difference.

Thanks.
