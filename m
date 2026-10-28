Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793191768;
	b=Gvp58MN7c6t24+l1a+VTxZxxhd8MKIE0Do0yLVfiZnYXtNttle0dggLPLNZLBsWcwRsc
	 jLX2n2X3B1HgMp7JSay8YFY4/hJoHRNO1lengrRUyQ5hW6EyltSucqtJFDBoI8BzBoQZa
	 XV70lAutXKAvJWJG7Q4WvO8eW0jkpQp/6b+Wrter+SAA5fDDmDHRLOJt58Nxs01+6rATf
	 avip92LS2Fdc9kuW+/VkSDer2HuPdqTbdTiV1PYqcaLiXu4YGCpwsLRKPw6f6kZigEssS
	 lnOTvEhfWAjSsc37zwoAeAnDUiNt12Xxi8yGD0wwA6HVsyiEHhM3U44zS80IdiDXJ+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=BqT/x6WJPIQfvkBcLZNSbVVf2f3SXAifJnZ5MrsoTyE=;
	b=2ice+qNYnZ1huS1jRVOoDLPLZZMFWNoVjwHPN4CjE9l0GN/UyhYn6BeBGzH1ZV5CfHe6
	 LMJd9/U2GoHKSat3YR8u6mmJM+G665nY1RXA2yqC/WuPnoQA5td32PElj5qmZ/16SAju2
	 xjJ149UbgCBHQEYbCCOL9WBFqi+xTYyRXXBjVPLPQiO2w8tokhZyPhBb0NfGhgFC5sz/s
	 YXOJFuOcMkRzMVOCwv4EzGKEuq/5qyNV1JIMq0i9yifOWwa6M/IaB9OD5ks3lexk7gvc5
	 Z8L6nh4KsHmqEnJMiDLtkJMl1bV96pZsfad1fFehA65we+T6Dh2AYpDjQ4pnq1oSpIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ektq1k3v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E696606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E696606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ektq1k3v
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a89b4a59a1so1619583fac.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 05:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793191767; cv=none;
        d=google.com; s=arc-20260327;
        b=oy1sFB6Tx9Qrt25Z2yLB+0Uf/SODPEEQDyM4uH/enWJ5uEWeGCBDPJTlnqI9xiJc3W
         pw12Q1+vyzyWWURci34tyy0FZ3SBjxWS8GaSPo2WdSp6s4yfxpHWO7WapW0Uf6Zx8zMc
         bDPrl40UfP8QFQFKaDAKzSHOhTwomYpFPa70V6bK0bcXuvuRvt4oFvcSqPZOhK9+I4re
         aQm0BTVNeiX4qbckCVAaTzw7rYFlA+1YEq9zdQFgTzr7plIQI3IV/DzjgsPdW7b2E1wV
         xvHWyQ/xwltHZ2DR/iM/td1t8YUxls+EdSb5Wg7rW/YHNmiOjCHSC7ifBIwSsDVx0Qi0
         snYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BqT/x6WJPIQfvkBcLZNSbVVf2f3SXAifJnZ5MrsoTyE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=dhhDSG0mKzGasap8aBU87Mdiwbhw/RzCrS7HXUJXT800oF9BY7KdKCuLbWM04q2rJ7
         0tLZ0HS/3qxLoy7Y5cHT8n11ALmCdmra0Lh2Erpo+OIvOo2s+DQ3Yd/DG0a7/VG3zAJp
         kt5C61y7vNylUmP5FVTY7JfRVg6gUoFgN0r8KYvhvftJn28U1waWol3uR3mYJrp/dQWg
         NVRtVGB1WgqRA/nQNK6qxdqMHo/5r7usgxz9CYs/ptp11Nh6U3nh3sGRZT5xNtsKLK7K
         ctg6bG33hMG67ZA8trgMlOLyo2e59i2abPl4HztTSVdcStNa0LU+N0ert2f/L5WaJwVw
         nTcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191767; x=1793796567; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BqT/x6WJPIQfvkBcLZNSbVVf2f3SXAifJnZ5MrsoTyE=;
        b=ektq1k3vAXst7QAKNNkuCv+hbmDWSHxn+QaRKxjbK8Cu+2CcSiRqPfGqU9UO6LZibj
         vhZ/vk4ZWfh+R8CVMa8YXYm2RvAvDSObQOztEDSlX0WZUb3XFZl6ftq3wiSCF4SZoQEY
         LSCk7CrTfAMuZo3fJO9NNDbviRunPe+h2ySmw6CGH2xUjXp72X08LwwrDvuf/zNZYV3S
         L0WlRkFXRDZ2DWKwIaaa34SKDA0feNl4ThvanrmGzu0RVt+/2ZFF3lHdg1u2YdvXrOzN
         s8qHk4kLeC1PpiO616G6qcxBzJrgtxBrBdjGTDwBKUii7p075uAnR4+gF6jEL3VKdaKU
         OYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191767; x=1793796567;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqT/x6WJPIQfvkBcLZNSbVVf2f3SXAifJnZ5MrsoTyE=;
        b=2XTenKVDF2lj1B8z/qM1k2PbSgDWPyt8psULDvo/Qsv/TqS1fuGxnPbPfbc/0nMNmb
         e/Yz/5mcju6ran9cCg5AizmIm9Zp7xAl4H+Ckdo3kLhIDMVXrljFf3lBJ3pyrONXAavd
         V62f2uhY6Hkn1WHn9gmkvF3ZebokSEGifEHmZmSHhQArUAvLMrqV8axtD0w/bBGVYAyN
         bbtHjaP2p7LBZIDdhEhYyMs8JN+zZKoC0NPuHD3Q1z7KC/jT2VcMuKZNY9IpvwgfIC7B
         64N/SQi3nC1r0RSxoNLgLsicH+SpdsK1BU1avTtRCIaBWp7oi/m7URpdqodIgMfPpX3s
         gu4Q==
X-Gm-Message-State: AFq9FYJy5J6K3Xl6CaxXI9NOs9TUfaAC28nood67j+iB//5EatjxpWJG
	yQxpYdJ/K5YsB0IALR9/xaLrt3HEz48XW8B/rAhx4EVyMcxIcMtbE3k4t9dA6TfBkipHrlWyDq9
	xdCxwB7RjBbAtol5a89INwTrTM6+dum7H689NQPw=
X-Gm-Gg: AYBFou1wu/2EoO7o5jqMKOzUsc6MQd+l+Ri/wvYHO1Lv3cWvDH/AtYb0VeLosuV/Xdj
	8LZrnbHqhBw7qhISHf+sSp0d6v6RFAoYg7QgHyZv0OC3h5abnmhJT4apL5jHup9HtgCawSd0qnQ
	3/L0hxWeFMecfEd4CBGw70/dKgMOiqSXgPfl89bFP61+orN2zQg9zQ/fQ1lLegrfEYOy8Ji9PKK
	guxyM443auDWtKoEQ5cxpIF+oIRPg8c/JOGiz8Wgiv+ZC6EwdxwvhdNV5yyr5vpVI8F0RfX+N9V
	Zz6hoKVGO9v1Bru0mJr5XJW7idQGVOJBH5wLBZsO6ylm46ZxcoFVpRlNvXvk4L2RfTJ/b2EcuJi
	rGbEM0QWYbapAx9qFtKQoxQfnI5jcnP1+98BRnWL7kOTgolxjc9ymagywczI/pIRDt3AG
X-Received: by 2002:a05:6870:5352:10b0:494:8edc:477d with SMTP id
 586e51a60fabf-4a8c89ea413mr406092fac.0.1793191767176; Wed, 28 Oct 2026
 05:49:27 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mike Beaton <mjsbeaton@gmail.com>
Date: Wed, 28 Oct 2026 12:49:50 +0000
X-Gm-Features: AclHuK9qh2o1FN_XZJStCzL_0-dOTDZVps8N6zOOk70RYI1K6aUZ9wNbJblsrOA
Message-ID: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com>
Subject: [BUG] check-ignore matches trailing-slash paths against CRLF blank lines
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

## Summary

With a .gitignore containing a single blank CRLF line, `git check-ignore -v`
reports paths ending in `/` as ignored by an empty pattern. Replacing that
blank line with an LF-only blank line removes the match.

This occurs with both ordinary names and dot-prefixed names. In the tests
below, real files inside those directories remain visible to `git status`
and eligible for `git add`. The observed issue is therefore an incorrect
ignore result for the trailing-slash path spelling, rather than demonstrated
loss of files from normal status or staging operations.

## Versions and environment

Reproduced on Linux using Git 2.56.0 built from the official source tarball,
and also using Git 2.51.1.

The 2.56.0 build used:

```sh
make -j8 NO_RUST=YesPlease NO_GETTEXT=YesPlease NO_TCLTK=YesPlease \
    NO_CURL=YesPlease NO_EXPAT=YesPlease git
```

The 2.56.0 tests disabled system and global Git configuration using
`GIT_CONFIG_NOSYSTEM=1` and `GIT_CONFIG_GLOBAL=/dev/null`.

Originally observed independently in a WSL working tree under /mnt/c.

## Minimal reproduction

Run in a shell with the Git executable to be tested on PATH:

```sh
repro_dir=$(mktemp -d)
cd "$repro_dir" || exit 1
export GIT_CONFIG_NOSYSTEM=1
export GIT_CONFIG_GLOBAL=/dev/null

git --version
git init -q --template=

# Exactly one blank CRLF line; no ignore patterns.
printf '\r\n' > .gitignore

git check-ignore -v foo/ .foo/
printf 'exit status: %s\n' "$?"

# Same paths without trailing slashes.
git check-ignore -v foo .foo
printf 'exit status: %s\n' "$?"

# Replace CRLF with LF and repeat the first check.
printf '\n' > .gitignore
git check-ignore -v foo/ .foo/
printf 'exit status: %s\n' "$?"
```

## Actual result

With CRLF, the trailing-slash check reports the following (there is a tab
between the final colon and each pathname):

```text
.gitignore:1:    foo/
.gitignore:1:    .foo/
exit status: 0
```

Without trailing slashes, it prints no matching patterns and returns 1.
After changing the blank line to LF, the trailing-slash check also prints no
matching patterns and returns 1.

The behaviour also reproduces when `foo` and `.foo` are existing directories
containing files.

## Expected result

Neither path should match a blank line, regardless of the line-ending style
or whether the pathname has a trailing slash. Both checks should print no
matches and return 1.

The gitignore documentation states: "A blank line matches no files, so it
can serve as a separator for readability."

https://git-scm.com/docs/gitignore

## Checks with actual files

In the same temporary repository:

```sh
printf '\r\n' > .gitignore
mkdir foo .foo
printf 'hello\n' > foo/test.txt
printf 'hello\n' > .foo/test.txt

git check-ignore -v foo/ .foo/ foo .foo foo/test.txt .foo/test.txt
git status --porcelain --untracked-files=all
git add --dry-run -- foo/test.txt .foo/test.txt
```

Only `foo/` and `.foo/` receive the unexpected ignore matches.
`git status` lists both test files as untracked, and `git add --dry-run`
reports that both would be added.

## Reporting references

Git's reporting instructions direct bug reports to git@vger.kernel.org:

https://git-scm.com/community

This report concerns upstream Git, as it reproduces on Linux with an
upstream source build; it is not specific to Git for Windows.
