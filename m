Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E81357A25
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462043; cv=pass; b=YF1BDUoNacBCoddQ/PMlpxHJwmMoLMbY1Ol3aJyydkBBeuWxgoQk9fWJNe2F19mJMY/NdaoWeEgbXixF9UiZ/aXGSNLOqs3kpptd+Xg9HUufjiR+A1gVwF3EvxGz3zGIGTt0nhRlEaueQIUJ6xcXUgLIWkxA/GC5m1ikYywU2qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462043; c=relaxed/simple;
	bh=tSnaA4oZKW81j82H3E3gSLwSsA48XGC4CuzAjw7bQG8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AOsiDbWvOdDbJzHDGkXpmNvNtBv9Z56T/IhPjBCBsCzirseCs1PoFInpKRZdfpjPxM79zpoSf44xa7LGYBmVnfGKFYNHr/ZgjQ8d4CYclz1+gYMYZzRXKCZcM9YmYimLqP9lqJ0oMBWh2/oqWyBkYBV3NfUS4bWnfJUB7CvbVms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owenstephens.co.uk; spf=none smtp.mailfrom=owenstephens.co.uk; dkim=pass (2048-bit key) header.d=owenstephens-co-uk.20251104.gappssmtp.com header.i=@owenstephens-co-uk.20251104.gappssmtp.com header.b=Si7VZk7f; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owenstephens.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owenstephens.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owenstephens-co-uk.20251104.gappssmtp.com header.i=@owenstephens-co-uk.20251104.gappssmtp.com header.b="Si7VZk7f"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e91b06006so105144831fa.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 04:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777462040; cv=none;
        d=google.com; s=arc-20240605;
        b=AyhBQGr/ZpxUTJcCcLpfygtns8Yfof1ae7WeOUl0cYMo8hl7oeCRLQDoTviuLGTdHI
         cj5l+gbde83MjRLUlqdlPmP/bE9+CeXg6KXziinUr6SEbl2sLDSveXCW5zUpny0CUJkF
         +NkLiv0nJ+I4Ey3d2gD52okCG6rgQAga1j6XJg5Us6a/Azt2b3gvg9qDu+rjIHF2oZxz
         IqD6nsXZR7N4mk9ngIZlr25kyWCucpGFErMMXXtTLyfykaa72ZRJHsXGR2a1ME/DJWdP
         zyrlKJjl/DYdQKbED53Kvo0rrw2W9CpC/AIP5Wniv8xWuWARajWswZBqCQtfMn3cBjgE
         GbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MlpAMQmWEpFJHKn8PvoIPdYm0DSWC03Rt8GGOQfPtqc=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=NAxFAeJJB40RDtwjQgVXf7pVBfM9dEiR7J/i5FkUB9lfr6QeM8JF69hPvGp9rGiGsp
         3RL+hOJB3gAdR5F/tMid+zNzLE8L60MoJJGmx1n1U22u+goNA6M5XaaLoH0zmH7PCPqv
         r0edpIkwIcniCQLlI7S3u+dJv1AmGtKgyl3iYlR860txhs8KLr9IHy2nfzZJ1yN7BR4x
         MRT7Rv/3Y6obV4U8xELtMp3WQZ6JO4c5s3NtEbY6ZISNdiUZk67Mmbu/Fmj++xHCeOv3
         rUHzf8cqQ1Khhk+YFWbC5nx98yYF0AzdrE1FCHoX0njasT3wD1ThltYTcwwYzfBcW92y
         qkTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owenstephens-co-uk.20251104.gappssmtp.com; s=20251104; t=1777462040; x=1778066840; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MlpAMQmWEpFJHKn8PvoIPdYm0DSWC03Rt8GGOQfPtqc=;
        b=Si7VZk7fvjf4tRqg/6SjneDLAHQXqq2PnJrwk/Y6SYxS2Lrku+n8dHn10luYEGNshX
         gtgzklR4Vj7dJ9La+Ot9iJWRXeSWdo6RobxvWjBB9TTukve5wxSvGiYIx/t4FRsNCAeX
         lgw44MKnZswTao9jt+e7LMMMGS69FFTps+ilPXY0iVaSimZPOQ5N4IttH6VjSFF6X4Yn
         qKOSMEHvsi5ABpRSS4QX/SsAKJS5r+ASsV8KLi1XPpojhQYnVcTybLBvoT0vt7gG1eyZ
         SCCOfgIvtJJC+iheap4eGnxcwT+uuVrUuz1CzxyNF9OoLxNmFwx0yy0rU1yu/EOdmU7O
         y/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777462040; x=1778066840;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlpAMQmWEpFJHKn8PvoIPdYm0DSWC03Rt8GGOQfPtqc=;
        b=c16nqEkViysmWu/tSGmoGWliAqdHrO1s4RGZNyZvcMm+835eDSpb2KtU8aTfY1uRPJ
         fZidO/OaEl0TIIpcBbZu8IbWh3EauVJyMUq8UuzgNXSgfG96oJAZ8ft/26fyF+CxT9YH
         lInZBTZtttLmJRQ3JwRuzzflORhcjmtMOH3LkvN3Pu6Rf9WS71KQfRhLL36fMn7MSHTG
         sZQGzokCCw4xWJQNi9/kacjlcbfDRAMq3GY0U5okmeRD27Hb0YUm4Jqk8uOFIvR4Cci5
         Nrw/Gy2NBPEBE7fOOkZSVmVrWV1vrbSn0+sJJO1VxYhd13BQHj/Guz1K8wyKyTmvc/kz
         YT5Q==
X-Gm-Message-State: AOJu0Yy8RKGEfeCI1Fr5yHhWrCkQ2Ikimn2W1BEkEcSdJT478AlIVSD8
	n/RsiVvnV+0m0gcVCr7v4rzjcYkUhRyCWe7oaEcj51L6XGEKZ0PIC6RtCtYt+lMIStKPwpU124V
	4p34K0UzSQl+GIQ8eGkfZV1zmh4i2Ha/4lIICz7F/eCS/ejvZowQOmHg=
X-Gm-Gg: AeBDieucex4HPD6K6RyxhUvCi+fAtTEv6nJci7nvNvR1eU+9Ey9YiZNEhF97BEkht8q
	pUq6sWA6m5l+VQ/RH8x2jnKO4QFbPnbJEW1cOgIlWOkKTBkHaKoQOfzfut2RWt8MbKPHcfZurSB
	E9i7G2E1SIYYuRaYSAQox1eQcl0ODV72Vu8EREaROmbR49pkzpinkdB734VXpCLYFrzOwmb7b0k
	RSyxXQnL56fQQwWYjB+HePOxIb9xxSRh3ifVD+2WsdPX/XMNwxRXcDEFywW0kC66Ui04h4mU5Ri
	Jw5zamM/ne6Wa9m0
X-Received: by 2002:a2e:a812:0:b0:38e:81e9:bf11 with SMTP id
 38308e7fff4ca-39240cc695bmr23782961fa.9.1777462039750; Wed, 29 Apr 2026
 04:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Owen Stephens <owen@owenstephens.co.uk>
Date: Wed, 29 Apr 2026 12:27:08 +0100
X-Gm-Features: AVHnY4LCdkpd5SyTWKWTrwqAegj8mQGCfq2K19rT1CEKJmVdZuom8eD0gAsHmnY
Message-ID: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
Subject: [Bug] fetch --deepen truncates history in v2.54.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What did you do before the bug happened? (Steps to reproduce your issue)

Repeatedy called `git fetch --deepen 2` inside a shallow repo that was a
file:// clone of another repo. Once all commits had been fetched, a subsequent
`fetch --deepen` appears to "reset" the repo back to being shallow with a depth
of 2. A reproduction script is included below. This issue appears to have been
introduced in v2.54.0.

> What did you expect to happen? (Expected behavior)

I expected `git fetch --deepen` in a non-shallow repo with no upstream commits
to be a no-op.

> What happened instead? (Actual behavior)

`git log` history is truncated to two commits, and repo is considered shallow
by `git rev-parse --is-shallow-repository`.

> What's different between what you expected and what actually happened?

The previously-present commits in `git log` are missing, and the repo is again
considered shallow.

> Anything else you want to add:

Commit 3ef68ff seems relevant.

The following script reproduces the issue in 2.54.0, and does not reproduce the
issue in 2.53.0:

```
mkdir repro.git
cd repro.git

git init

for i in $(seq 1 4); do
  echo "$i" >> file.txt
  git add file.txt
  git commit -m "Change $i"
done

cd ..

git clone --depth 2 "file://$PWD/repro.git" repro_clone.git
cd repro_clone.git

echo "Shallow repo? $(git rev-parse --is-shallow-repository)"
git log --oneline

for i in $(seq 1 3); do
  git fetch --deepen 2
  echo "Shallow repo? $(git rev-parse --is-shallow-repository)"
  git log --oneline
done
```

The key lines in the output are:
```
Shallow repo? true
63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
864e13c (grafted) Change 3
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 6 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (6/6), 351 bytes | 175.00 KiB/s, done.

Shallow repo? true
63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
864e13c Change 3
3e05d14 Change 2
1d9fe14 (grafted) Change 1
remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)

Shallow repo? false
63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
864e13c Change 3
3e05d14 Change 2
1d9fe14 Change 1
remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)

Shallow repo? true
63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
864e13c (grafted) Change 351
```

N.b. that 1d9fe14 was present after the second iteration but missing after the
third, along with `--is-shallow-repository` changing from false back to true.

[System Info]
git version:
git version 2.54.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 25.4.0 Darwin Kernel Version 25.4.0: Thu Mar 19 19:33:25
PDT 2026; root:xnu-12377.101.15~1/RELEASE_ARM64_T6041 arm64
compiler info: clang: 21.0.0 (clang-2100.0.123.102)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
