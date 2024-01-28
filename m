Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4A31A79
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706473495; cv=none; b=eL971K6EtoOeQg+zBYPD96tBY0UfGmqVqJ+0Fo2ExWTnHwZ6xaEQh9urdX86j9Sfz1chm6Jj4MsWOBhivl89JkZl/TqafpJMuN5lKqQpY5w7tZZFVs1ILQ/yaX0LtgyRg7dDah/+9xRZdneVNdHl4oX0GeZEIX81rZ8D89e/Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706473495; c=relaxed/simple;
	bh=okkraYjDUc+y7YYiqa/I4jBONf18fviKueTwwMtKCSU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jmdnlR0Gj0sGCeMHQrmUiuTzdpK/3EPnPZnls5e/PbSW1LBrCep5w05c9I+OljHafrTKjIpMGI8nRz5F5kPF2htAFycW7Ae2SXEiQw+G5HvLHTPU5yGRbDCn1vwoTI2F5E5WKvFNCj7Izq/Q56Unqse7OAvLWRcqys4KfgDWotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wilfred.me.uk; spf=pass smtp.mailfrom=wilfred.me.uk; dkim=pass (2048-bit key) header.d=wilfred-me-uk.20230601.gappssmtp.com header.i=@wilfred-me-uk.20230601.gappssmtp.com header.b=FwlXgIWa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wilfred.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wilfred.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wilfred-me-uk.20230601.gappssmtp.com header.i=@wilfred-me-uk.20230601.gappssmtp.com header.b="FwlXgIWa"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51030667cedso1652998e87.3
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wilfred-me-uk.20230601.gappssmtp.com; s=20230601; t=1706473490; x=1707078290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wbXrb5CpDt08qK56SehFn+29lbezdbe/FOjgi/QucF4=;
        b=FwlXgIWawhn+ov91VqGrcp0UTwSIRq9NorENFAacApx9f/acQqG44HlVntxP+1Xeiy
         nHNpIowokMa8/mk3HALc4ay3L4izNz56lPHxZEtTJFQHs+g9LAZgJD8nmJmCRK6r+kpo
         B8Dw1wUItN5YMDKOsIHKRRLXLkHo0i5vF461U7hRgf2WX6tYA3AUWAQVnIj0cf0moAfK
         WHgVVwpxHN2/EyFQJZ/uZwZBzaanNCazm21zGUPRjss7CyucTIsBb22Dh1Ot6atzh9f7
         ffxZcCH+c8DQE+nVhRrY4RBF+qrHBQpNg20ZtCYNm1ySR7alVnh9aHwfrczxlZw03QHp
         T5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706473490; x=1707078290;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbXrb5CpDt08qK56SehFn+29lbezdbe/FOjgi/QucF4=;
        b=XTFCqPC5iYH4wvI8WFR1FXEDGUykqmsrP/scXVNeFtmchgrNj1n3t9JqrYbUuUh/JC
         d6jf4RxDMAps0JIRERxjA7q5npd9wK4zF+B3O6RBmKUGZtQm3Ncb0ywcnHE90YMp9AxQ
         amANKXJh3jU3M/wEvenz2zKoy2p+vWD9HcKA/75wfkjMiVPHVSpW06UdWJCkNxtcA44P
         DLxgGlHD5RJ3NhO5yTE0lpIMBbIsJ4gAjO8plYNf3NdEFrf9BPvrNvAAIIHR9BnKcG4U
         ptH0n9kXmyMR57LM1iOIw09uqiuByns8/DCkN2R/EiyAv6K/UwO0aT2fjI4QK5LJ1Jrc
         5Y/A==
X-Gm-Message-State: AOJu0YxPwmawyzU4+lPpB/dS81/k0gk38IXWPgaIzlo36m1AZf5Hq6F4
	J7zEetuulQBD0Ob4rKFnoa69REohcI2Q4kW5kWE57LTa3hT6x+ULkBbkQa8LaB0NSCrGOudK6MJ
	0eA+qUp69UCLK57KDbHkHAmTW/G+zUIsu5nX+aGcpRyP/2LtB69o=
X-Google-Smtp-Source: AGHT+IFP6D9ifEzwtD5Lxjstp8EO2DxaSrq1s/3iDU2m6gy69MiGTn0ql0CK5skn+yrRaATy0+uXwMv4Q9pUrdkJk8w=
X-Received: by 2002:a05:6512:4010:b0:510:2e35:5e with SMTP id
 br16-20020a056512401000b005102e35005emr2256047lfb.49.1706473490392; Sun, 28
 Jan 2024 12:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wilfred Hughes <me@wilfred.me.uk>
Date: Sun, 28 Jan 2024 12:24:39 -0800
Message-ID: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>
Subject: Git segfaults with diff.external and comparing files with different permissions
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks

It looks like git crashes if diff.external is set and the user
compares files that have different permissions. Here's a repro:

$ mkdir demo
$ cd demo
$ git init .
Initialized empty Git repository in /tmp/demo/.git/

$ git config diff.external /bin/echo
$ touch foo bar
$ chmod 755 foo
$ git diff --no-ext-diff --no-index foo bar
diff --git 1/foo 2/bar
old mode 100755
new mode 100644

$ git diff --no-index foo bar
zsh: segmentation fault (core dumped)  git diff --no-index foo bar

This was originally reported as a difftastic bug[1] but it seems to
occur regardless of the value of diff.external, hence my repro with
/bin/echo.

[1] https://github.com/Wilfred/difftastic/issues/615

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.7.0-zen3-1-zen #1 ZEN SMP PREEMPT_DYNAMIC Sat, 13 Jan
2024 14:36:54 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/zsh

Thanks
Wilfred
