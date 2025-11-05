Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876D30BF79
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341145; cv=none; b=li4wYWVbMbl3sdWVq0mSaWxQoXjqv15NDmZlpqoZ4pm1Mr9GfF+Umq3S9AvEagiU5XcS96Hgs0licReSmPdMFqze1HiFhE8+AvOJePoHYqwRzb4iQI1UzgGfB5/SE2uLOjeLAFAfDy61FgVO4/unkmgmZL5eQng1+SF6WBcSIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341145; c=relaxed/simple;
	bh=Rbw2JiZS7Ga2Jz8ByA5LlhwVo3LJacYduOFbzcio6nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+txAZkHVQaipfV88+VEVWmT+FhqG8EDhBhXTza3SsdcykVzUVt5ySqg91BjbevYQvaWTHDCCqWzL1J9YqqZt6eSexA3aC+XlkN7AndX31sPEIJE9STo0mvj1wRSGGNq5tmEWYG/KEURasFjwFXm5SlIId1wGQEeYnXY4CLWkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e43PYNQN; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e43PYNQN"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dd8a02e808so635055137.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 03:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341142; x=1762945942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbw2JiZS7Ga2Jz8ByA5LlhwVo3LJacYduOFbzcio6nY=;
        b=e43PYNQNJ218qB/m8Mvaw/OKNL6NpOwCVgVAS7Qbz5A2hynvgogfi2NKpmP8xcDxUc
         XWC2d9aFvnyhx066oYWFCoIRV8x6ljOaBmI7L/NOJfAm9fdgGPPLmnnaX1hglbVDyblZ
         vgfTJM6BvfF7QueUDwPAXQ/+tj4smUfayj3cWDpjbTrn5RsZM4QAiEVDFtaKuBpECadP
         jdJRmZQhw0K7DlH3/CruFoVzuK1m1z3p6VVdndkxTTKXjHPp3BUVmYPsHJ2Wa6LO1jDb
         sy9UpOdBDJKHHtZRi5cwjy9iHvtIRroJLL+LmTmGYvVM82g14yY84pCe6tI7ul7fXD/a
         NCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341142; x=1762945942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rbw2JiZS7Ga2Jz8ByA5LlhwVo3LJacYduOFbzcio6nY=;
        b=sEkPa4T4WA9N49mCI2gtlD0URuxzxdBMQUMXbY0GNovJ1DRG2HAeSci5B1mZsylqdh
         sdGaSDwUlqiOtZzE4QM7DlsKHznLiBJ9G/Fc2sBdP8p51Gu/XV7My4in31y5NDZL7TNb
         ay6nHdRbXpEMa1XAMi8jW/xS1jL/X+KBMnxMsybgmu54cMJH4/IOD2ORbQGQUcPUtSdN
         9g4OT97UDWSPyOnHH/1SlrbwIyrKRlRTm3IJC+YRstVjzD/2OgupNzWtAN6fDijQMuKH
         2cv8D+GRGh+IUxe2yFiMGdoUaJHeWePCyLBpvT/uS9Q+/VK+3ljWi+EfmiIEMutJUgOh
         MVTQ==
X-Gm-Message-State: AOJu0Yw37mVMwOBGtkJA8lwU2uY5Ti7h/Bga9Rt+d990skjPRpZEsoPX
	+43G59C1uddTyslEdDoIAGeF16OL3kX1uy9j7XbJ58j0oyjwWugs0i2y6/PW+fxuNuM8rxuX0cD
	yYy4kuXedRwxTGJtcSN8iFpQNz56ZZC237VM+a3DLMA==
X-Gm-Gg: ASbGncvV/lJ/c/Nq2mRtmL6aloFLfOAMzW+f2CUJN6gcpu86hRS3mbIadpShBo9+kK4
	6xrw7Up0Ig3647gOkL59jfccganLsXYPlIaCSYU2gPTCs8q1Px36dKTxbgQ5Pz42wlxfb5vHXvO
	D5Gt6nkwW37fKRB03J93/bEVH7o/TF1ZU/l0p44kW5lD2mRxiwzXSEVngmJjFdBY8TvyaNAIrzW
	PMbucUL7se/OVORhaVqlyomDbc4YnRoY2giFqwy9taUw3mFdW1rUKqfbfDPYsnAAsMHwPMSM0ga
	Uv1l8SPDoT3lG4D8
X-Google-Smtp-Source: AGHT+IGfzx930m2caJM5RiiQhItDzlf0/uX0ZPtfJu06gT8smLeuNmcmQwb1FqUrOhZjvfiPlvss/PEqHMKKYjGr/90=
X-Received: by 2002:a05:6102:548a:b0:5db:27e9:933f with SMTP id
 ada2fe7eead31-5dd8921eac8mr980518137.40.1762341141869; Wed, 05 Nov 2025
 03:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+JX8FoKKB8LrCbPgXgiqSLvtpk=HBsxCcZAW2M_Y1-Of48Y+Q@mail.gmail.com>
In-Reply-To: <CA+JX8FoKKB8LrCbPgXgiqSLvtpk=HBsxCcZAW2M_Y1-Of48Y+Q@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 5 Nov 2025 16:42:09 +0530
X-Gm-Features: AWmQ_bnZJpqtXxjWLiGkPPniBi9vga5MOxWCqABFeQ_pARYa8lncbPBsH2WK0DA
Message-ID: <CAPSxiM9wOuzW-Qc0dagsHNjFh4Hj7Hd0yq_G_wA6Gm3-Vr3Xmw@mail.gmail.com>
Subject: Re: Outreachy Proposal: Refactor Git to reduce global state
To: Queen Ediri Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Acked.
