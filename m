Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306402C859
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691058; cv=none; b=krgAXJp+Jy5YLW5tx8RnboJnB3M7/ZfHhByE8PK9+aChDp6skAGN52pUXbizlf4bVRqvMXX3oFAr3uTqhX7HzJ6he0+dHKhjm4LrFSyFYXwMo8AXCHj6Kz10rZoV3wpZBPOVfzkv7l7WWGGkd41qS32/aj1MU4E9O0MEb4r6cKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691058; c=relaxed/simple;
	bh=dJ8zAFfHnLERfM6uPTGPiaJUfM62D17d8NxlbaD9+bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1M37Jhly/8EC7u+lJy9pQxFBDSAU38qXao1bebR6gIX06aKv7HmQ5Ys1wvvIazknB5TMFNYV5SH4jdubfm8YDbfIhmLpIzhd+d3pkyW8DeQQsqsn+gOTULTaA9vysPaLBv6sui6NpaWYuyJpYQLl8ZqUBbTdyCg9mAB1OmksXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeTI+5jk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeTI+5jk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f0054cb797so14296657b3.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734691056; x=1735295856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ8zAFfHnLERfM6uPTGPiaJUfM62D17d8NxlbaD9+bk=;
        b=WeTI+5jkWcCrCF6j56aPasnocgwH/T9VZAvchxXt6z9DRuxHRIz/nFr4CQOrUoCs/v
         nB1C7moMKeKdfcKmk4A4FELXhLBsaWF2rIwDd6V5Ag4HY77X54YRQKCUJ0O8cbFvcBAS
         6kA9GZpmDieAz7UFFdhvkPPCznDAk1ZSKlIuGNd7/FFrrJv2dd4QHt1+s+n77utHSo1v
         8JgFSO4q2MTMKU0X8itujedF8D5H4+SRBtV5eQ2+IL9ZUFY3fQHAIqX7iqBlEanzPvn3
         hJVqkQTIggZlFVJ4xLWuaitcVwYMg534c+ZPvXoQx4IkQ511bLUJQowI8brHqP3cgERh
         5ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734691056; x=1735295856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJ8zAFfHnLERfM6uPTGPiaJUfM62D17d8NxlbaD9+bk=;
        b=cxlVl1s1Cap04fs8mEjFC8sqFCFLbm7ucxgPoKXFa1YWn42tO4PPWwG0wCtpPoXG/6
         SuQqOiJbi47Gm56l1a3s1I/96/m69qgjdIU1X7Zjg09fNTU0i+YMAdA1QGldFkzHGoa0
         CAPid60yCBQ3VrZu8oAlFJ5Vaa63HwXsxTDHeYHadwTGQP3DSlz5gpA0DwtubseGSyel
         716BCo2CiHWNaAAxYtPNZXlr4YbELenEhe1tW3M5wxnAP/aPQZB/LOdY65hYGojQgTIa
         wE3tF2CtWC25KfZUZbHZXSng8nCubgETxX1PgpNjHy7P26AlZBcrLIbID/a496rNmAjz
         79Gg==
X-Gm-Message-State: AOJu0YwSFXPCRKiXw0FAwRbz/YalfVikyQZ9P2v1Ck8sl/c+i4V2aH0X
	x71cTZ1ynhEMMk9huKryBg8I0D0Hj0+eC/2eMQ/YADVbD+e0+71Uv7lpL48ApuXC0l5vKjACmJd
	7ZS+IThWNdHFKOuHDhxQJTpxVKlluF0Osxxi8KA==
X-Gm-Gg: ASbGncuWP6NyhWvIHmFqvD/y6nlEtnd4wrHO33tAkd9jZGYUg8YIKyU+//j2l+WpRh7
	f2Rw9A9IyHhsewiRK8NSH2dasz5y327esbT4LTg==
X-Google-Smtp-Source: AGHT+IGDtTXLXt5mYvE/Qo6zH0sxyYmwiV6gMETn124JC5osGe5r9U0dqpi0IOdoC0Dg+LcydTzdXJy7f0hOjf/UHdg=
X-Received: by 2002:a05:690c:113:b0:6ef:96f8:b609 with SMTP id
 00721157ae682-6f3f821a21dmr17723477b3.31.1734691055727; Fri, 20 Dec 2024
 02:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
In-Reply-To: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Fri, 20 Dec 2024 11:37:23 +0100
Message-ID: <CAGedMtd9F3tZXC-z-5=csELdPakzFS=QU-e35So3Og_ak0mq3g@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I just published a new blog post on unit test scripts I've selected
and prioritized for initial conversion to clar. I would love for you
to check it out and share your opinion!

Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/week-2-prioritizing-test-scripts

Thanks
Seyi
