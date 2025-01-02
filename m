Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB93FE4
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735820256; cv=none; b=lEg3QBn6iZn4flLXqKcbARZ177t3sW+6jO15uz3qGwEsv+t5zYBuZ14HAnZV8zQPbbXJNSoZQ1pNS7gdLime02KRpyyHn0BLHwR4VzTFhNeQJ31hsJxYh/SsoTTrZU+gEWN6jEw+Rxv9qCJiWzO5mp5vPYrXFk4PDqdDYY3KEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735820256; c=relaxed/simple;
	bh=n7PIMdDUox41u807sw/HF4ZWooVrzRJ3Kv52wQm9QxA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=c/vf0bB80dwKzPlnfkhO3g4ZfrFIfSMmp3AvE2qjSe43WHeYPBi70zg8fTENCkFgX0EX1ev6bqi+Pe/VJgM9NMTmATOX4LOXyOPguejJukbizF4YjaHf0KFrQBgEqK5n2JD/9gi+mioQST0gyvJDRVEAroWoTuqJTSvKH1bFWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9v2FRVm; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9v2FRVm"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e2766994bso5822617a34.3
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735820253; x=1736425053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4wNNsgPLq3ibBiBv5MdibYjyL79STySLJCH2aSMM/c=;
        b=d9v2FRVmmfuk/VanvkODEPIVGuuMakia3qplal3yNpyUFKt8I1xVid6yoHv6cqCBJf
         nYKr9569TM3I5hLiH54OGQH1dGCyZrsNGE5J45ArHNDWYUaa/xulg2brfnZTDbo4HZRO
         h2S9sgvzZDl6hmI0eVAMr2xYNU7LzNrPsbUAIMMG8oWg7dTeiiKh2AY4avq/WUJLqaLl
         rbe5sathzTXnr0lw7pytRe0VeWLkxjUEOI3w4ozLDkbaL97iyAcM0TPZ8bi64xM8vHHz
         YZX9K5M6nxTiRVfmdR13q8PRzjQUGUjeqk9iKF9QaKkI7BGSvceKMFYkLstp6e81j6+8
         QERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735820253; x=1736425053;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4wNNsgPLq3ibBiBv5MdibYjyL79STySLJCH2aSMM/c=;
        b=w58GSqCAMxfiLsDCxQU7UU/73OEz8/AqLpSaVU5Fj1w3oKMKj6fbzcT4mpWFZfYrUe
         hf2MmoxS5JCdp9UMj4NtSGBeX9CLYE8UkAoCCxvTTD2TZClGl1Y62TIOl3QBKDga8ADj
         ddwMEyUdFefapYjCrAlv5XBXOKQKH26+YwUodCs67dgHVi2ZuHy877rDMXC6rerPR17/
         eVvCE8XISoybbJRheyqWOlqOSi1r1QYfdapY2vbyq9n8dKoQ1T5heaP97dvHiY/1ibf5
         kPma74jEuuMbMPToPrPCIawDrXyRswlbulhTzQNA7LZRoDThj7rzEHsUequAAswA7Q0L
         1Otg==
X-Gm-Message-State: AOJu0Yz4AE9Ty04mlPQAQzawodidshWT8DXc3bIbY8Dp/pWyiNVZrsBJ
	QCd9aUCmARHx4p9MeJqkdApQhOLJM4iftJG9LBaO4IFoXjMfdGaJ15x7YXM52r1i19ofFs22Wh1
	vuhR2LrLWHW/HQ/BvBbWbl6lpAiOSghMa
X-Gm-Gg: ASbGnctdhMUZDJt6XvQep5+O5CzaE1gGmi1rDRBiWbJX6J6fYSYMvP+xZweTLTJfkyS
	z5yZ2tWOe+MBVWbEtFjMoCC5ILZbfK+ZYBXuJyQ==
X-Google-Smtp-Source: AGHT+IFBiCDjMujCP7lxnHX9weK7GT78pzg1u6+QSkmSJ+XU9XJhNqe8gvHyyM8kNgQZSQ6geW0r503W3WMCyKrM8hc=
X-Received: by 2002:a05:6870:430d:b0:29e:8485:197b with SMTP id
 586e51a60fabf-2a7fb00afd6mr24861376fac.2.1735820253551; Thu, 02 Jan 2025
 04:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 2 Jan 2025 12:17:22 +0000
Message-ID: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
Subject: meson-test syntax error
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

The new meson-test rule in t/Makefile causes a syntax error when the
default shell does not support non-standard process substitution:

  make[1]: Entering directory '/src/git/t'
  rm -f -r 'test-results'
  /bin/sh: 10: Syntax error: "(" unexpected
  make[1]: *** [Makefile:119: check-meson] Error 2

Due to this line:

  diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");

This can of course be worked around with 'make test SHELL=/bin/bash',
but is that expected?

Kind regards,
Andy
