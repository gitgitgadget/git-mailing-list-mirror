Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677392356D9
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679355; cv=none; b=EGXRicP80Mw+ue1jWlOXmAo2HTHVOiPsirMeQL+OOvwifgSVfdmW82dsvchMPQD1NtFaWIjNdiYQAb0J2kElYA0IRUA2nFX08rDqv1sZgPEH6DZDJimTN1xdU/GvkFDvRqLZCygd9Hc/4SHpWGUk5hSePpl0zbznqDpXTXH83FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679355; c=relaxed/simple;
	bh=igDi+P/BHAQ9gKvIaiwovMNMSy9T79lDovtf7oamPQM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bl8/agNNH9YfegBKN2Bfdlh4FhvhPntPjWUE9ZA+vpRHpFfTwcRrhofmOggaJ7JJSQ9sM3uPmBVWyhTwaH2ZHrOnHQJpCVm5SKlVcnwcxgCWKHehyWF+gpdIXktcE9mLMh3mOLAxFRWh8utEgplRXzpj1zXmEHA0tRXB9egjUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2GWtpdA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2GWtpdA"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso6429521a12.0
        for <git@vger.kernel.org>; Sun, 31 Aug 2025 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679351; x=1757284151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7XqTws0M7DETNtn1lZn7vkm2oXQFkIlJHQxoGFuBhXc=;
        b=M2GWtpdAhFkP7RYnMb+PlTVtseYnmJPX3ElYtXn6Ofen7n+feAi9iVKRN8+4Q0e7DW
         klC/JL5Bvp+fElhvcR9KiHWOof0lYfe/sxtVGbHszMO7VIzVKNiylG1A6HII3n/HhAI6
         UWJchPtARcgDPKkHzALcwsnnl880Baj14uzlk1WXLCqEF9eU2SmV50h0+ezx0UZWB2pT
         NB9sV1YQg9qqafdtWVoRKZ/uM2YtKZsOtcH4s2TCP8vezrkJkDXjW64Kg8xPXIyPbFIz
         zoi8YN6CCdTyxhzk15eqkevhnFea8kvOZKkanwY6vBk0GwWz6FfAha7l1D1xKHbuGnuF
         b/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679351; x=1757284151;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XqTws0M7DETNtn1lZn7vkm2oXQFkIlJHQxoGFuBhXc=;
        b=qt+ixndOrFq2CQCEubtw9OT0SqPyhHMZ4VRnZyvQqX6aE8K169e6KIyfzER2UH+xNY
         lZYopXHu6dXTixtySMa5ia9Pu6W4mwLF4ft0XSae3vDf5N3j/2x+TE/wl4NeFm3fGckS
         t4IcaND4oadwAX3dBZfKAtT/zWLFPYTfCvCTO5KFnPSSRtHpg7dxSc3Apc2vs9t63Bxf
         nkbVKsfBDMqL1tzflsO2j0tryyZQCg39Bh5FYDq8UXsbscmAsovypCMflz4fCXKYqjq/
         S9P+QYdDTGfIPRG9AoBU0pbvEvyapu5MPGuHAp1PCZwgnRqAQ1wbRT55GdsCFcmlvdw6
         AACg==
X-Gm-Message-State: AOJu0YwH+12A3yRFpcWdGzT3MXU4w/jTz1wQR69RfzvfUZoh5MYyKlZu
	mXomWhqzw3xEMehsxaPZJcurRjRo+hhWVnZx8gAPLse9GjNpCFc21ttC5boOP7/uI2tWOkmU5fa
	s5meZfneloTjYZb/t8jUzOzBGfNtDxEgLKaRc8Sc=
X-Gm-Gg: ASbGnct4zxxdGKjqqWKcsX30VaVm2Kr+swcJgMzgTu/UjhcjLxzziIHmhfX8zLgB4+W
	1VC0yc7w6xPlUUpyQG5aODbknshtXm3eTE4z1GjoSQa6QJUnO3Zje4323c7XR3NectbVXdtm3m8
	rOIhw2/P5wE3S1BCnF0//zgIU8Yx/pqW71FgBjmhbh5BQV0v/DyW8VV2eoOa8BB8riVqZcs07Wh
	4DXGlEOerLC49VIg5l0GibWxzU0Vm/dLauA8ehU
X-Google-Smtp-Source: AGHT+IEEWHEqS4mjy+aY06vjmBh8iGVZUTY7uVj1UKWp3TG9RrpG/mpzTQQ9a1qv4eSq4W9kl5Fyl2AFicjMIMN8r/E=
X-Received: by 2002:a05:6402:2742:b0:61c:7ba9:8a3 with SMTP id
 4fb4d7f45d1cf-61d269974dfmr5006469a12.3.1756679351097; Sun, 31 Aug 2025
 15:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 1 Sep 2025 00:28:58 +0200
X-Gm-Features: Ac12FXy3jU8rV4ehMpkfIpD_727CBfTkBu77nYaeSsDXHJ77bYQvWk3yzadMhFA
Message-ID: <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 126
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Bryan Lee <hi@looping.me>, 
	Lidong Yan <yldhome2d2@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-126.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/793

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
September 2nd, 2025.

Thanks,
Christian.
