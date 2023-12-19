Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21A225A5
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVkUfvDH"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ca02def690so55416941fa.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004846; x=1703609646; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvAE3Su2pwykJ9SUDLPeC/l3i/XOMbQOwIxv4CiYTyY=;
        b=XVkUfvDHApTtV4cYt002/uXXYenWDR2+o2VYFXcy/Gr/NTnQit3wLHMbcti9CCaKxE
         gP/sSdZMXWen2Kr//IUDtxxpk+PD1kHC46Ci76Jh3vLE50RZIEDScybHo8yoPQ3r0IvS
         2oujk7LJr9yzDftFydy/QmmeoWRrGMpsK2EGMcBffJQvfOC5g8QOOBS2UzC55MKAT11C
         4wvqsEMYfnWzPsmo2t2nY88jHhWGUNAVhT+nzpMRRTwHm/a5n6RCgaMxzfP4Zb+nmOAF
         Qas2hr26Lt4t6FZr6F+mC6pcVhx1s5M2Z4zFeuv6okqVBo0mvrNG7qmTNMiar9P5wxVE
         jB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004846; x=1703609646;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvAE3Su2pwykJ9SUDLPeC/l3i/XOMbQOwIxv4CiYTyY=;
        b=HyRTrBw4U3R4auUZgVu01JADleVxOq2LYPiktMMPhS6nUwHjag0gTxSkM8iyFHsZpP
         W4xmD04kzqQbtkf5CEhA3ebvgRhCQ6/FRbSns3XbK4JuXXDifU9vJ+nUEY6ayJT00tKM
         smYhNv+1tGQguxEoDXjFAkrmnotktVHSi75s2HjwXkkRkBq0hkB6k79NIgBdPMQ5RsI2
         aUke5Txm59B3KGaSwibn0FLFEjr6/ULEzpyanakGs7HXq7Dw/KjojQf1Z3kklnUvDUJ0
         ubtfY+xliwJB78ogCd4h6bHCqQ3zJpQokpTyPpTbeTHaqAq0MJH2X4UAqxi5+0690yBb
         T72Q==
X-Gm-Message-State: AOJu0YzuP2BhrYLX1FfziNi/+WHkoRafEUBFe6LzX4vjzoGPJ2qeXxQ3
	ITn4+8xTDsCaxxv2auRrYlmM1ITI+CxPqBqAd4O6KCv5O/8=
X-Google-Smtp-Source: AGHT+IFRrq54q8P/Z9FT4v7z686yMwvu3hT5c+Yc2/dsZLZxXI5yyHeRBzcpu9Albe589+A6LiyN9R4RNt36OH+KlB0=
X-Received: by 2002:a05:651c:a0e:b0:2cc:8481:f213 with SMTP id
 k14-20020a05651c0a0e00b002cc8481f213mr674640ljq.36.1703004846243; Tue, 19 Dec
 2023 08:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Reed <jriddy@gmail.com>
Date: Tue, 19 Dec 2023 11:53:54 -0500
Message-ID: <CAELOy+5AsRyLEs-WdYw1spqkmMDKjKSQzbogAoRBFe-zGLjvXg@mail.gmail.com>
Subject: git diff-files bug
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

> bash
=E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --patc=
h; echo $?
0
=E2=AC=A2[jreed@toolbox example-project]$ chmod g+w README.md
=E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --patc=
h; echo $?
1
=E2=AC=A2[jreed@toolbox example-project]$ git diff --exit-code --patch; ech=
o $?
0
=E2=AC=A2[jreed@toolbox example-project]$ git diff-files --exit-code --patc=
h; echo $?
0


What did you expect to happen? (Expected behavior)

Git diff-files should likely ignore group permissions changes, or at least
its output should be stable across the same worktree/index state.

What happened instead? (Actual behavior)

The command `git diff-files --exit-code --patch` fails with no exit code wh=
en
a file mode has changed in a way that the rest of git commands ignored.
Furthermore, subsequent git commands seem to change the behavior of `git
diff-files` in this regard, so it's hard to tell what is the expected behav=
ior.

What's different between what you expected and what actually happened?

The `git diff-files --exit-code` command is inconsistent in how it behaves.
I suspect it should ignore irrelavant mode changes like `g+w`, but even if
it should report them, they should produce a patch or at least have stable
results when we re-run the command.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.41.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.10-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Nov  2
19:59:55 UTC 2023 x86_64
compiler info: gnuc: 13.1
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
pre-commit
pre-push
