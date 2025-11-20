Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567619E97A
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681961; cv=none; b=iB6yPExFLitdRXDXla8VH0b66Jixd86Prt47+8G3oP3sk/RGjFWkU1ILSFb5uxNvJiti/QpXXBS1WP2gV+bSk1LyMxcLJqN59xqdJlpY/w2wNWFpMZJq2qolM8A55jCcS0lpRJYc65Cvv2eQYl2iVjWYHAJxVQ7pE3lyFVeP/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681961; c=relaxed/simple;
	bh=divaF9ycuvhqqj0LmVi96O9V7JfBgg812YB5U/DltfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oGa+I4ZtFHYt16JHQn3tzL8OEf4rnhSrYtXwjV9Uxh+4W25IWwmgyZqWI+MrV8ha/68rirWc/h5L2C8ADRPX6dxGrgWq2G3GGCpOpGxgkK98k553gKyIyUjVKOdK9xUtfqK/XJL601ICc4AQL5PAFWjTwjOHDR4M0cVvhIA35DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucsc.edu; spf=pass smtp.mailfrom=ucsc.edu; dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b=hX8nJczo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucsc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="hX8nJczo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eda26a04bfso13931941cf.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018; t=1763681958; x=1764286758; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvz9S9vnrWQ8kll/fYshVBVhy7B+TEkdQISgXBHHUpM=;
        b=hX8nJczooJHV1+PtWk3MxEOOrXku3TIayKX91h9jkG6PikoePni0zrMUw7a5tfbJDd
         IuSIFhDnhYauQp/1r4ucrqpNDmu45Q37rA16yD/xuoDJOz04HEXhJJyrTf8N4JbUnc5s
         keR6YwMNAUvGfy/bJ8wJaQn7uHvSSDIB1JcFoqu57ZweCWYHLOKol/zwKwm+jZuEHmqJ
         V7TeUsgOgKSbOu4sMZnbyeRmgxUPB89ipXlaq69NzFw0kGeO+2mgcFTctccZ5C2TOdMx
         Ex6xaZsZ7GFkKAKNdu+s7EcXvMHsizNdqLz0ql3f/HxlslHqAohdSV+mJ844Pm0JC2UD
         zdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681958; x=1764286758;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvz9S9vnrWQ8kll/fYshVBVhy7B+TEkdQISgXBHHUpM=;
        b=fqyUij8BqgF/kwyreU7arOVhEFCXu7FRDuM8xDnhQ3UUhNTZQbkcCRSaAcADkqHoQn
         wKMYv3B5bXQkiEN2PrG1vUhniaBlSdc4lfrrf1Wd+rH7GB8sSUPCKFhezmPLRgv8vbSv
         LCMdpVeVdh2vuPGdMSr2yt4hrR7jZXyrlbWtC+UTfASJAaJWr+mKniprzmtRu2vaRLKI
         qra+HVHyQad97BUO1phQgLXvsbDCRGKVVL5c/6YuIGKD2Xij9XNT7mSroVD0fFXcMdkY
         lf06h2BIkBA/vgxJvIfDW2zmUKaLbFhs2v9cd28WFeQef1s4X5PF/J0B/oxYuhpjTIP1
         dExw==
X-Gm-Message-State: AOJu0YzFMN09fs5204bUO1bLAnu92U5uuA12xGrxjNSIf5lz5Fvw7A6t
	d/xaQCmnG1+29xEDnn5OI85RZaup6vLfXwN91Dj3KMNUCk0aIyVg9oO+dz66SOSTuhiRz8f3OBT
	vTi7dVD/JGz2eJufpbn5+AyRF70AXotx/4Tv3tviIwFOAUTrxrH4WckI=
X-Gm-Gg: ASbGncvm7lQYu8K7X7Tv1FomBsttAvbBols8hTT4Bm/CjlaSgLL74O+RhtEjYlSQ7wc
	NHsXC86Ch9ldQOjJ2w3n0lCpWIHlDTJJacLAy9rz7OcDOXdv8dttULTW3/V0dWrEpUcQi2sGwGK
	Dc8pqqSYA7qo439KmATJowitBshfxxLp4v1rq7W1QMcgLiBfBbTmYR3tMHC2sFcN3baAXMsUL1c
	chR69S6h3cETP96GlpmLfJqeeQYukFGokesfrZuIKbWeVZRi95EaY6XlIH3cpriGVagLlDXlRuY
	SnbeXshcrN8w6SW2sWPot5avcfoGLM9qwse5dJ6KMPZp4SqMd3znF5inuLwMHEvd4k/Sa487zLP
	U9Sk5Qle7xJgKWw==
X-Google-Smtp-Source: AGHT+IEsJq34WhzmALN++9Yhgcya0koZVcL4Vc18IjTCClkIy+LLojeZjuY+Omlv2RFlNBf3GhlLNBidrB/hCbgPb2k=
X-Received: by 2002:a05:622a:83ce:b0:4ee:1c81:b1d5 with SMTP id
 d75a77b69052e-4ee5891161fmr4769281cf.46.1763681957637; Thu, 20 Nov 2025
 15:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Wintz <pwintz@ucsc.edu>
Date: Thu, 20 Nov 2025 15:39:01 -0800
X-Gm-Features: AWmQ_bkRb6LZWJfZiEOgswvy38Y4AIXvrhbD9aSNxWOdUBB9ESbJPct5J2MqMP4
Message-ID: <CADBJ995pDG9R8EJnK5nwWKPWAf-XF5P5KTY+bAx71EhdMvvO6A@mail.gmail.com>
Subject: [bug report] erroneous suggestion for "--add" option in `git config
 set` error message
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It seems that there is an erroneous suggestion in a `git config set`
error message when setting a value that already has multiple values.
The error message says to use the `--add` option, but this option does
not seem to exist. The `--append` option should be suggested instead.

Steps to reproduce:

1. Create a configuration with multiple values:

    git config set --global test.test 'hello'
    git config set --global --append test.test 'hi'

2. Try to set the value of `test.test`:

    git config set --global test.test 'hi'

An error message is shown:

    warning: test.test has multiple values
    error: cannot overwrite multiple values with a single value
           Use a regexp, --add or --replace-all to change test.test.

3. Following the direction to use `--add` produces an error:

    > git config set --add test.test "aloha"
    error: unknown option `add'

The error message should say `--append` instead of `--add`.

[System Info]
git version:
git version 2.48.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.12.1
zlib: 1.3.1
uname: Linux 6.14.0-35-generic #35-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct
11 10:06:31 UTC 2025 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-checkout
post-commit
post-merge
pre-push

--
Paul Wintz, PhD
UCSC Hybrid Systems Laboratory
Hartnell College, Adjunct Faculty
PaulWintz.com
