Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBD7DA84
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726826879; cv=none; b=ehAf7JvukAd8hCnGE/cNUhrTVEGoBl8Y1dvh12wlZWvk5cpmJe/IKo1lZ6E/bZV/ZEUvNUCbWpExdJ0pqzBI7Kez8yjMlFJ7BJvFWZLRC2ehVsYIWwtvq2KPgQS25bZvzF2o1E4KXgz2CDSl9A89a2dmh0Weptvw3nrEsMc/8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726826879; c=relaxed/simple;
	bh=GBpxR1xdOvvMu1kVEC05+B+ttK8K2dC1VGX68GqH4/Y=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=N3WvTG8c2qN1Qx3/nXX4SK1remLMRQrGu1Lj4LGy/EGudgr5drPTxllBVAwQdS+zyPvMTBQL3xOTjSFBzXnksuOZEztwt6XQ8WYwPlG0Cd6SHvnV341YRYM+MNFgo9HFMmkZ+MFvLuoKbQqFq6wnqRB8K81K9tqWpXW3UvjguAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYXFvmfO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYXFvmfO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso11752935e9.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726826876; x=1727431676; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBpxR1xdOvvMu1kVEC05+B+ttK8K2dC1VGX68GqH4/Y=;
        b=CYXFvmfOrJYDN9hSGD9JEGuAFaZTc8gw2/JrDBCzfUyHSSduvblHdeFfG+hoJoD0H6
         POZ+jty4RdSQHQQc7gmrqf+dK0aGx4KxGZR8xTBpzupHvSW9t3O8TkElG6r1D0NT+s9U
         NEQIgUEMSVK5U+9TQ0tkQS2g/DsuXXANJ91XB7DAplkoDxSI6GqflPYFWAcewRymLvry
         I2oPZnEict6sbwEgvvaHjKB3tILPYRb7l+gePig0j7NXh9iDcTrKTGJGS3wASp0c2TOU
         c4aS7qpelZwN/LHx2kNr2FBjW2Y1G7BMOH1vlrhzV24F/k/Z8Xx3pvMHdGKk913Ro/S1
         wpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726826876; x=1727431676;
        h=mime-version:user-agent:autocrypt:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBpxR1xdOvvMu1kVEC05+B+ttK8K2dC1VGX68GqH4/Y=;
        b=LPJgabvJ/BPL2r6Wo2CG2loqYYsh5lvhvNo1dCwwj/gcj8BnKwMClSny+a+wR3tN9I
         FC6KUzo4Wu3zvdoy40mDC+gP0ShmzPj4NoEYVIhfvx82v9VUCVrzIIWtCCwHUAPAI2TD
         DWWmBGF4alUcrdnRlz2xbyIxUML15eENY5jKce4JBpqjPAcYNl3kZPquXmY9D6Xvk/u2
         QyWVT0423JcpH+RLoFki6C/759KIGtxnCxODZWUe2AusvI0rXwzVJLjxGCaklijRVyFa
         GgOP538dCHklHiBZlYSQ8XHSHz3s+Cm/UC9XxG1TS0iAF4dgKU38cNl8N45QUNoQLZyN
         1dOg==
X-Gm-Message-State: AOJu0YyP5pTSlFlBgh3M7jI9HCOCpC4ZSvnqNVlHmDOqO7An7M8yy653
	iQJPjc5Qckz9WQWRg6v6N5Db5NQPgpuv+P90cvRX0wvMam65I+pn6dn6qPu/Dw==
X-Google-Smtp-Source: AGHT+IFHqfKGF2NWsMOXXRE2mbsjA4XinA6Vjf85Iv4eOxmPJPD1AgPIJO9QLqImi6I1t7jaqQn8EQ==
X-Received: by 2002:a05:600c:510d:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42e743f28f8mr36490245e9.2.1726826875818;
        Fri, 20 Sep 2024 03:07:55 -0700 (PDT)
Received: from ?IPv6:2001:8e0:3bcd:3801:7951:2497:3f96:12ee? (2001-8e0-3bcd-3801-7951-2497-3f96-12ee.bbcs.ip6.as8758.net. [2001:8e0:3bcd:3801:7951:2497:3f96:12ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800243sm17231821f8f.86.2024.09.20.03.07.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 03:07:55 -0700 (PDT)
Message-ID: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
Subject: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
From: Gabriel =?ISO-8859-1?Q?N=FCtzi?= <gnuetzi@gmail.com>
To: git@vger.kernel.org
Date: Fri, 20 Sep 2024 12:07:53 +0200
Autocrypt: addr=gnuetzi@gmail.com; prefer-encrypt=mutual;
 keydata=mDMEZkXiuBYJKwYBBAHaRw8BAQdAGuoC79ZXUA/zkkAgeLEElUIBjYsvKXPlkbWqF5RcZ
 q+0N0dhYnJpZWwgTsO8dHppIChFZDI1NTE5L0N1cnZlMjU1MTkpIDxnbnVldHppQGdtYWlsLmNvbT
 6IkwQTFgoAOxYhBPJPUqh3/IpkCoNuHfnjsP+dTnqBBQJmReK4AhsDBQsJCAcCAiICBhUKCQgLAgQ
 WAgMBAh4HAheAAAoJEPnjsP+dTnqBOsoBAMzBqtykviO+gsSRXCRLsoy2qtxZbZjR/ES9zZLTobhn
 AQDZJiTrILQTFNHNJ26NLVDM+Av+cjgeOezlCEcAa/N0Aw==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6aB4aea2L6OWjkLmtnjZ"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-6aB4aea2L6OWjkLmtnjZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your
issue)

I set `git config --global core.hooksPath ~/myhooks` and placed a
`reference-transaction` hook in `~/myhooks/reference-transaction`
with the content:

```shell
#!/usr/bin/env bash

set -e
echo "$GIT_DIR"
git rev-parse --absolute-git-dir
```

then I ran

```shell
mkdir ~/test && cd test
git init
```

What did you expect to happen? (Expected behavior)

The Git repo `~/test` should have been initialized (and the hook
`reference-transaction` would have passed successfully.)


What happened instead? (Actual behavior)

The hook `reference-transaction` crashes since `git rev-parse --
absolute-git-dir` with
```
failed: not a git repository: ...
```

What's different between what you expected and what actually happened?

The documentation says that `git rev-parse --absolute-git-dir` inside
the `reference-transaction` hooks read "$GIT_DIR" if defined (which is
defined!) so the `reference-transaction` should have passed. I assume
that hooks should be executed on properly initialized repositories,
right? Therefore I do not understand why `git rev-parse --absolute-git-
dir` fails -> Bug?

Anything else you want to add:

This came up with `Githooks` hooks manager
https://github.com/gabyx/Githooks where we use this command
to locate the current Git dir...

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-
5.2p32/bin/bash
libcurl: 8.9.1
OpenSSL: OpenSSL 3.0.14 4 Jun 2024
zlib: 1.3.1
uname: Linux 6.6.45 #1-NixOS SMP PREEMPT_DYNAMIC Sun Aug 11 10:47:28
UTC 2024 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /run/current-system/sw/bin/zsh


--=-6aB4aea2L6OWjkLmtnjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTyT1Kod/yKZAqDbh3547D/nU56gQUCZu1JegAKCRD547D/nU56
ge4LAP0Us4CeU4WryJ3noGupjmgUrFBKjsSdTR39Tn8w8MtrPAEA3AIT+u9y2hb5
5QXapy9174G9XpADfz8GhX7jSu1z2gw=
=E607
-----END PGP SIGNATURE-----

--=-6aB4aea2L6OWjkLmtnjZ--
