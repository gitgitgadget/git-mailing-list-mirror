Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7A1C27
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659763; cv=none; b=nRB2QhK3YQQSTf3pubqFwOFdNoUR4nt/yjU+8KZmDfIAgvMfzUJp6yDb5PeaWae4CrUYqc23Zpwf6XuUJq9dsNCu/X/2SKSeZi6s17vjCLUPgfLNvaWA19Bmh+AtDELx3O/O2zi2udjPncAI6HYdfzUblDWzJ5iE/HhYBpp9KGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659763; c=relaxed/simple;
	bh=IKYlDOo37YHnRlYMjmLythRTvtiJEEd20JDK3LPH8G8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uCc4XLLrPVeBO7U5Hby+hVYg/UGTrF2TtXLeRD0U9K6fV9N2YDEm8bkS7doyXwhzV/HPfPGbbNU/gjjdeumpPABSlQcNbJi0Vgx/BWw+ffNuTY9Bj6/ei4yBdKAmk9djrhN/MgLZH7beUM/zAH3hVP8xpH1hvkxVk82ARJbYDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zimmerman.io; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zimmerman.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37634d352dfso14598701fa.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659759; x=1761264559;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksdXAqKEcCdG5pa01zKua6v9K5mhncLuSPN4el+WQtg=;
        b=msKtvQZr5Gii38BUROOzTkyo+iIfDoHKuKEn9DQv0CfecezGOQ6uub5mcyzxNrvaK/
         20JNdwW0XO4EVW9OU5Ry+2O/xvmuE3LfKTC2s/XmHXi2iLPjydqJDM3oouZk0UC4jv7a
         SFCF7pX6ESpQn3X0mWiuQTreT2Jqfyv6VcG9B2QqZMkA/fTlAi/4u7xmgWK7wEeF00Le
         vnUc4CNLWOgYfBu7jntFBadwv3XF1hTQZk9tgDIL3x36/ve/EMXdWbPw8aNiU7TCGBqx
         hZASikld0n6ml7SJHzj64V5sPFoHhMKpipECEmq21C017OYKfCnNhYzvWrePv99rM2rb
         AizQ==
X-Gm-Message-State: AOJu0Yy0uVHGtuViW9TeQSZInpRt9u0UYV6HcwhcWFiQczTxMzVlB+bg
	meQVIFawom2wQ4sXaLTg+Yi+cua1azR8wnR7EhcU6+ZstahPCPbgtssm3zF8Va3kH1vVNs6ZMcE
	SRmldCIzd22ALgeoailDC42OfmqarhGpkOJrVCyc=
X-Gm-Gg: ASbGncsSFV5KV9ua7eZWDURqDnaGN2A+3npQFo+0HYe2vyFpQOtVC9cW8yHEqHcbYcl
	foaF0zaxCL0siZEJjZXHKO3qcx0NqPKqY4ZvomwaaMzvj/zRH1ykKu+iu1h0rJXCWK/4KFov+B9
	XpdEQI/BvTk2QUQ6czXekuzifMN6xrgV41Oa2d00hlZYaMT4PoCKP5qXMKr3t9ukZznakoPelvP
	DHm0ltbO4ikyfrvxRl77Ue4vlEIwZCqnDF6WpXGtVwli1PLiRJHk0TZIPS0M756L4ROTjE=
X-Google-Smtp-Source: AGHT+IGdd6Hr78KS7d/zyI27VOq5LqWPNUlyI3I0K6P12eMeuGCzd8JDgaxMlyqYB2ahmgKI6NKi7lOVnQG/XnQwat8=
X-Received: by 2002:a05:651c:554:b0:338:8:7275 with SMTP id
 38308e7fff4ca-37797a3f77emr6118031fa.25.1760659758462; Thu, 16 Oct 2025
 17:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jake Zimmerman <jake@zimmerman.io>
Date: Thu, 16 Oct 2025 17:09:07 -0700
X-Gm-Features: AS18NWDdFCm5fyEZTj-mExGmglZBOyOZ4A6AcZhItubNXyI-RIK7w4alaPRADS0
Message-ID: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
Subject: Regression in `git diff --quiet HEAD` when a new file is staged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In git v2.51.1, `git diff --quiet HEAD` will actually print something
if the diff output includes a new, staged file.

## To reproduce

    =E2=9D=AF mkdir foo
    =E2=9D=AF cd foo
    =E2=9D=AF git init .
    Initialized empty Git repository in /Users/jez/foo/.git/
    =E2=9D=AF gc --allow-empty -m "Initial empty commit"
    [master (root-commit) 858966f] Initial empty commit
    =E2=9D=AF touch foo.txt
    =E2=9D=AF git add foo.txt
    =E2=9D=AF git diff --quiet HEAD

On git v2.51.0, the output of the last command is empty.
On git v2.51.1, the output of the last command is this:

    diff --git a/foo.txt b/foo.txt
    new file mode 100644
    index 0000000..e69de29

## Expected behavior

The stated docs for `--quiet`: "Disable all output of the program," so
I expect there to be no output, like in older versions.

## Likely cause

I ran a git bisect and isolated this commit:

b55e6d36ebce69136559add8fffd1a65df231518
( https://github.com/git/git/commit/e1d3d61a45bfdc5031d2066c0e4505ebd814577=
7 )

"diff: ensure consistent diff behavior with ignore options"
