Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB587BAED
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653790; cv=none; b=NJdDftFgB6/7hRh0Y1XkXg7bHymndQ4JktfLOIe7fLKIjdx0WTAysAynqFYykD1YLShwKctCtMoACo8EeSuW6XfrKYHbjUEUL/0M9K5AT8MGd6FWFTjwrMHxOcmXIZBMJ9ajCsZeMrxYDrPMmTZZkQBn1z6mVDU/OkxV6llT1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653790; c=relaxed/simple;
	bh=XUfMfregk+mt4OYGdBjYRZpoY7IcBMop01fz7ubC4+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tDjHX8IspLiBhtM0Aw5Hu+T7yaI0WHF+NuMgcBnY7fXRGmbIxa8foJkSuotZQOZdwRQQXPwSeQs6f7wezLDCv2n0iohNpZjychvUDtrNiTszFD378X1+57/0BYIzLFdNEdhoVK3gS6Isvl8reP0p/Vgx1+/yiwXzFw9Ndj1IK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD7y2trJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD7y2trJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so610370166b.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706653786; x=1707258586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pSNMJYTCT3g5NLQ7igHcR35sEbfvwacVSXcGBF7vKOk=;
        b=TD7y2trJzsD54zvcEhbtJT1QInCh4W5uB0+8A3kQ/6GJW2XjpUzQtIj0igZJtSn45Z
         3tiuI+Yf7Pz1Po0Vy1WTFxH8ZSfpkFvKny9ZZikgFSVOXS6O0/bBlp5feKWRuUbY/IBA
         ecaSAcAjmUvueAQeRhwSmaOYltL2ZEqjcCsvN0Bz355Cim2jRZceXV8icsTYZfn2QNez
         RQXJPkfbuoO3DgY2tsNf3iVPRxjoRQxyy63gpz46I73P9/SIOyuakC9rScADYajSetyL
         9AjSIHglWHOCezKmg3i9ycIOVaFWaKPiZDwASiZKIjnFNwQ+OKgKIQoheybDqnDQXzEY
         BiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706653786; x=1707258586;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSNMJYTCT3g5NLQ7igHcR35sEbfvwacVSXcGBF7vKOk=;
        b=dopbgtdvhSxOhlNEJo8O2sjnPM+9wh1kRjrtU62WMO5okwWeLRW/3qkRchJ9XBcZTD
         PzuccWo73Nv1FTaReaAe242kILXw9u1RSM0EstFzt0mPiaVoShWW1kd1+2jf98NQNTg1
         2mvgujV7p+P5EpWdWgp05PefcwK9ILTg5OIKt8Oz3nLZE+aVMnHHuUdUWa0WB/qvA1TR
         PTcI2yLZO5bRZBaMtCJB2EgEOUvFqs6ajECzEAKQppSnIYqN8Ybr8EDCM3A+x2g/cedw
         pubf5tRaBSxyH9m192Dtpfr4j4ezPTd65ZiHrkLXC0UsfOiKxL1N4xc88eDyrX33JdXO
         jz4Q==
X-Gm-Message-State: AOJu0YzOyHjqzio1rMc2OOU7Tmc7bN7rkwi1HE9WFLZBGRegJeFD6dLL
	b5Sf+NdO4Mkd14bkjXKZunVIzIH5/vO4sCoZAX22WffZjpmDMfaVMO6I5rNS/qZ032BhqmgeaPh
	wqXjVsYacqtwrm3N+ddJ0FezOf+biQ5mvNPc=
X-Google-Smtp-Source: AGHT+IE87LZdIjg3/WwiLnkDM96EJNqmMheVe+t4AjnmW0UkAq820Ew9ecD9oSG7OgkkvxyxDAdS5iaTTV446Qno8Ak=
X-Received: by 2002:a17:906:39d6:b0:a30:5f51:46d8 with SMTP id
 i22-20020a17090639d600b00a305f5146d8mr8668573eje.27.1706653786128; Tue, 30
 Jan 2024 14:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Jan 2024 23:29:34 +0100
Message-ID: <CAP8UFD1C5gbUvdfgzE3BVpXKS39_ciWK74jvi=6z6cARJ_fYjQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 107
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Brandon Pugh <bp@brandonpugh.com>, 
	Jeremy Pridmore <jpridmore@rdt.co.uk>, Elijah Newren <newren@gmail.com>, 
	Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-107.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/679

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Thursday February 1st, 2024.

Thanks,
Christian.
