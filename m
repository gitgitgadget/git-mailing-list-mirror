Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A41C3F04
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724902; cv=none; b=imdpvuRi90RiHRHmoOlugC1sajX2usRiRDDvRNQ4SQt93asg1ulQA532ZAFWiTomUN54w9dmJRkudrpt3k7iu8A9DqQY1VlFBSxz40041f0vrh8kL9cFY1zv/FwMl/jGePr1u6+phoAIkLY2e9uelA7WUhH4si+DDRmtCWOLnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724902; c=relaxed/simple;
	bh=rg2IfFTtfpa3vv2n2rlUkoEJFM4az69z3AFfFimoLSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6yofL0cIyNJwwFttbY5EcX77wdfm500ZegVR+qZasHYPxTq8JB51thcaUeb8+gL6RLgzFCjrGI+rS4Z+u8XglJGogjSuFW+MJTSmLy57ReMBh6GakwrgM+Ol+azAZZpTILUbuToIke5B037mhlNtC4Nkjg9lYx0tX08HIQruhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcTpZ39f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcTpZ39f"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb892fe379so255210966b.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740724897; x=1741329697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rg2IfFTtfpa3vv2n2rlUkoEJFM4az69z3AFfFimoLSk=;
        b=OcTpZ39f0I01sv2QAiBMV6g5+lIR7AaEE4kh3UkYUIuK/XI8zfpno5EfTcpOJO9y5z
         tmAJlglhunmLm1X/8pzFjbsGitljIgK7p9/vDAWuuFE+/sVQHmNSwB2XVjF069wyJjWH
         9vxeDOC3RV7Q4oC8oqSestBMfxV+zwsMSxhf/VAEF0NJmQn+GEqKWUlYZfksGsziRG9g
         WX8TkniU31sUSFHkPDlY+3266a/+RpVkPwO1ziw8GG1ClZugQpRCPuPHxxk3AJbE8Q2y
         /mLWcGRY0lgTB0JOH4tYQ5RGpZ5QGaPXf/THGIF3a2gTRl6pMfnqfLPWzg8oncxGeEol
         Y8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740724897; x=1741329697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg2IfFTtfpa3vv2n2rlUkoEJFM4az69z3AFfFimoLSk=;
        b=lqvD2cc55CO2WRqIiUXO8TjhToG35AqQ7s57CwIsCKPZqBx+7/mJ8ctjJ5z0UlcIhL
         pjdb6Tx1IPAH1ieDYUfLlLJOXZxbrOU9rdz6XBlqqfV/azsa21yMIPsVJu8nRHJCTZxS
         kiJjWDqzekIeLxImn2sSqAme4jpZcnligoVNhglj29hDMIVDgr6ttm6xwqxK4pLLTTcZ
         YitzU8S3lexA5VNli6U6pXvRJohlOjOy45/kYfrk1ZBOkfxUpGNsFUvdKRR6ef8tsYyO
         oSRE+MrCPDVaEcLNsDAZADTyXVsU1lGcc6NZn5tSfmaiRdtbEAhdv4GlwWPnYrKarTR1
         llZA==
X-Gm-Message-State: AOJu0YyOWHQSj028Sj16bf5kSicvKgZz093CoH3cuyS0Um8AMC/21/ib
	8ajH1dsiOdb7w9N/6XSTAZ8mbSkVC7XJgdjxxMH7KPDdJe3QWdGz+4ab2KMUUxvj5IIPJokx2XG
	RBSG7v3wTOnxPsKInbIu8u8rsEAsPPA==
X-Gm-Gg: ASbGncu0v7ypPLSDMSTd+yBCuF2kwqqvpg9cjgGdL6SoeWCvrcmXL+ACXLM++T17nUc
	iC72JsfT9KLJtM/G54Ijqfu3NGgyf1gg/swlt82CJl1qPoacYisN4Gffc2oSxGcJbK/ikpbfjcf
	FqZX2HmUUDA/FYNqedX4yoj48UBMOZkFGnWWs+pnBV
X-Google-Smtp-Source: AGHT+IHE6M/CBNuZlV3MDFewHVGUrdAKXbqpURF5UsIUbHQGuxzr8j75KitoOrtVXRncSLLW9c04GdFCs97QqKp2AIU=
X-Received: by 2002:a05:6402:4316:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e4d6ad8c0dmr4242929a12.13.1740724896940; Thu, 27 Feb 2025
 22:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2NSvRJo4XUmuWFVfqN-XF4_Qiqu2VncEdWVi00qSLNaA@mail.gmail.com>
In-Reply-To: <CAP8UFD2NSvRJo4XUmuWFVfqN-XF4_Qiqu2VncEdWVi00qSLNaA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 28 Feb 2025 07:41:25 +0100
X-Gm-Features: AQ5f1Jp8jOL_JOsHgF8jGOjrPLX626YnDZ7L3ju1yyRhqeyLBnqscQe15pjLOvA
Message-ID: <CAP8UFD3M7cO8umjeT8ih9j_h9NaCzttqSo0UYDoFL8p5=qpmqQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 120
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Olga Pilipenco <olga.pilipenco@shopify.com>, Chris Torek <chris.torek@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Sorry for the typo in the subject. It is edition "120" not "1ZO".
