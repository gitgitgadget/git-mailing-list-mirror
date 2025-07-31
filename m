Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B227E040
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001025; cv=none; b=RcFWe8NcIeU0+enYCP/zPI7x/K6kaqgy6myU96FGtpMbIkUAjAjje0RI8GVZjqVsRhtiR9il+mna+QcZMs7WWekjn8A1NF8eTDaYM9y+i5ksYbGm16ePP1TCsP6FegZLdNRL35eEB5rTPxsCS1RH8BLTkVfA/HNogPsiod3fv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001025; c=relaxed/simple;
	bh=oU1mCOXxJshWIlaaRzKDcwXgHqzYaDNUJ/tvICv2XQ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RnPaR+4HkoMCyxnRAs0cwn3L0fYqb0i0sgcsfFvSb7pfgNhItVcQyBdSzrPVra8zbJcHy95AuAa557IXLeLBXzGM9tpwamr/TyIWz2XVs16x1EO9dU6qcbzXE0pTbSocuqJsWqgXOU7rlDQCcxPORaR8yN/R/HDYP8K+psPYlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJby2bNj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJby2bNj"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso2164522a12.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754001021; x=1754605821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jgUZq1o5a0CYNP9yUPB7vbVqu2T95G2kpudtwia8KX4=;
        b=FJby2bNjUDnE3rQy6d1OKb4pEvx0dYnCbLkcjiBFUfCsyXzTbeeC3YZIUvrnfEq1hO
         iZRusugwILR0aTAP21oJVq4auV8yoiCigGkzqPAi+s0zOeDdG0+eB874MUBq0lgfA/76
         ccoaizImXHvGTFJJxF9hElZafRJi/N9ee5Ia1XtoGvGMeQW8Iti/w1TCtc574smm6VjY
         DQy3seee9PFDZS7dgb9l4uIP6QIljnqdGDag9v00AZ/viF2RqxgpZ4p4MvD6xbW5Y4Mt
         +mWX+7eH+dLOzcJavy6Fp2IvfW22mjvsZL8fC8loAd4flndenRp5/Ch4vVevnCF2Nz6x
         jyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754001021; x=1754605821;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgUZq1o5a0CYNP9yUPB7vbVqu2T95G2kpudtwia8KX4=;
        b=WGaIuDjCNC59fBZkwb57E7qFTwZShq78WVeEcGbzn/NhGWFk/xT9ej8Ib7I2BJHf/H
         bSK6Fn/agqYIL7SA91wDYOWBmaFQ4X0ZqDW9kGPtMKM28AOuLJZtY57YR7OESUtoPiYm
         WcnS6dtZOXFELc9Zxefn3SjLoNGgauasL59flK/r7YTPx+D7aidOsNzJpX8u3txhS6rF
         5Oa7ey31lk1YykckUtMkaVPXiV3xxW9KNTvnSKFLYk01pdX3W5jCGOTbnX7ozUpVr9b+
         i9TJo0TlqVqoK3sdyJmhg5FNpjBIQ5UaK2E4/rvOgpOjTNH8fV/ZL6qSqrpuClhHD/jA
         FqMA==
X-Gm-Message-State: AOJu0YzOHJ1UDdLMCkxxECZv8TeEFlLC/dQ9c/9YYBpQ12ilckER6N7y
	XRrghXT4sCtELO90Z6f+jcHTz9yvq5RvFxwPGaaRUYPjCMYZCLyEInzyOHtDDg9MACv6IwS30j8
	PPbHQMbPci3tH/JDdnf/Tj38IEOYlMU9Y7w7s
X-Gm-Gg: ASbGnctYlX+6iAZRFxJp+ENLNFv7lW0A8sPQHUE3HIjv6Uyt9vcMtoUfsCbKbZ9IRUM
	WBuXWFX8K5k5yrm7bGfQrww+viJlkPd9ftorzCtwvP5RuP4OUM3Qx3nkoYwBz7LJFvuuoyvtGKr
	Gw9Q3V9lvIvZMfd7Dc6iOo3w0kREGEa/YJKRnAd15ZXWb5TmbVxtAL5QOQLhUY/eUBjzmqZtK6U
	UNQsZ2V+A==
X-Google-Smtp-Source: AGHT+IE9ta0WonprcBEyyolLUcrysk6GeXNaApyA5efPavIDX3mDH/8rktPykMxsuDCFw2Ndx9zkXxQl85ensaUtD3Q=
X-Received: by 2002:a17:907:f509:b0:ae3:7b53:31b9 with SMTP id
 a640c23a62f3a-af8fd9bbc9emr1133794466b.35.1754001021121; Thu, 31 Jul 2025
 15:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Aug 2025 00:30:09 +0200
X-Gm-Features: Ac12FXxEj1dd-8Lbm2aeuYmX_ATw7b-a_rFQ3tI3uel2WR4hml5zeE4Dk7OP8xA
Message-ID: <CAP8UFD1gp0mT42e+UtbXLy=HCmVThNd_g4WbWBNTShgzCPtqJA@mail.gmail.com>
Subject: Draft of Git Rev News edition 125
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Aditya Garg <gargaditya08@live.com>, 
	Julian Swagemakers <julian@swagemakers.org>, M Hickford <mirth.hickford@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Erik Huelsmann <ehuels@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yao Zi <ziyao@disroot.org>, 
	Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-125.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/786

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
August 2nd, 2025.

Thanks,
Christian.
