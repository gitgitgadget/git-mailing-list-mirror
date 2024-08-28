Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57F1AB528
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887451; cv=none; b=jvXrjW1Wj2oZC+MySvtHEM5Gt7PdP8Klra6zczFFOt4nUoCFGqCGO895mGzsHGJkC0rsSVpSlDQrh6y3lkto6eRPo66rIk/Bt7Pz5+XrokDo9RLAPFs14NnqB3SYDAPcPiZxzpZWCFu52311YxB/Y8VV+NZtv1H/681c8qG6omI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887451; c=relaxed/simple;
	bh=f+6Be0W1XoMGMk3TivxEH5uc7pfmkVYuQ0M4OM9Vkws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hbu77LHbbiOG8B6G/e1dyFSpB7tGLCaNsOzzkbgj080WWuhYG7kIZw1t3SHBO3iA4e2NiY6+OcmkcVsZZwRbfIYKI5VO91UoFGAreJGLzKb4USqAV/m3ZQxDWN3aeXs2HpETV11p54Mf2gmmQTIv2Zkr2Jq85SXLk2AeeDZ0iSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuB6ywv+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuB6ywv+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4567d78ad2fso60351cf.2
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724887448; x=1725492248; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+6Be0W1XoMGMk3TivxEH5uc7pfmkVYuQ0M4OM9Vkws=;
        b=ZuB6ywv+gjRi66zEnfrhRwmERNf69Hv57dJq9Z5iLK3t7hSAxvBZ7wWlMeultkvqri
         HtuxEa5fXgOACUKBmfGBKoNo/KYcEW5rNkwyFMV2zQ+boxJL//fobWlz7Xwl3QmlCGYe
         KnvThnIFCq4PYXWMwqGhhbiAIKoASMvFO4zPxL6lCeop0rprBUA9hcah6GQ0Tc9oZXAv
         KYue94W05qxH2kR1szDKL0Uk1NizZxrM4fPNTiYUSqZUOnNjvZMfXA7E7UpQzGFuxp5G
         bKNfPYfZJ1UlqL0r/uZdSy6LZwji1JacNyIDdKbmm/H9gqo/rxhktAVgHgatUtedOnDU
         Efog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887448; x=1725492248;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+6Be0W1XoMGMk3TivxEH5uc7pfmkVYuQ0M4OM9Vkws=;
        b=HpvJJjWPlE+UalNCLLW6yebDkIYoj0NHRFfmLdii6q6chhYnxPTWijazAVrbfPc9xC
         FSNjhP6CVXWXpsWFzJRxTaaAjb895Zbq0ky+oalaAf/GUlsA3uVyjI+Knf0k9d9buNr6
         lTb/hQYZJ3v/VhZZMSDwSOxfB31iOKUFhL61tD5/QLIN2BYZSEwPhYoreR9WoP0cfGA/
         9IVY5KsrM+3EBPaoCpXPoSu77KMZDzxMORuylue0105DROTEfa+tfiEbBSFSk6L2c562
         5zotmkLMCJafVebUC7528FV3JiFvxNgmJq7pwd1tT3PMG9lLM26z1aTjFdD10JsEzYT4
         ZYTg==
X-Gm-Message-State: AOJu0YyJdMSYsK+rhq7OyYTfduobnWVyf9o3RZ2GYte/RNg+BMfhkG0f
	8GbfAEP0h6/WSz4kvwO2URtLtUrHqmZr3wpfgr/1WiEN3qAKWizD3M2y8ZqTmbE/1dBRS1yfY1A
	XPjie6dpUqcCadUOlDNq0TKrGul7lrcty
X-Google-Smtp-Source: AGHT+IF3plkPKJ9b4y7uP7HcLZQ5semHkLX/Jk5sPMIiRBVkEv4HbwX6jdBSPf6HqI8xVtvIPxY0xHxII5lPWGugGXA=
X-Received: by 2002:ac8:6f12:0:b0:446:5d42:1c1b with SMTP id
 d75a77b69052e-4567f59cabfmr12869571cf.38.1724887448015; Wed, 28 Aug 2024
 16:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Thu, 29 Aug 2024 07:23:57 +0800
Message-ID: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
Subject: Tags auto fetched by "git fetch origin" but not "git fetch origin main"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In using `git fetch [<options>] [<repository> [<refspec>=E2=80=A6]]`,
- when a branch is specified as <refspec>, no tags are fetched automaticall=
y;
- when no <refspec>s are specified, tags are fetched automatically.

This reproduces with both glob (`+refs/heads/*:refs/remotes/origin/*`)
or restricted (`+refs/heads/main:refs/remotes/origin/main`)
`remote.<name>.fetch`.

From the git-fetch doc in Git v2.46.0 [1], I don't understand why they
behave differently.

> DESCRIPTION
> [...]
> By default, any tag that points into the histories being fetched is
> also fetched; the effect is to fetch tags that
> point at branches that you are interested in.

> <refspec>
> [...] Since
> Git version 2.20, fetching to update `refs/tags/*` works the same way
> as when pushing. I.e. any updates will be rejected without `+` in the
> refspec (or `--force`).

> CONFIGURED REMOTE-TRACKING BRANCHES
> [...]
> This configuration is used in two ways:
>
> * When `git fetch` is run without specifying what branches
> and/or tags to fetch on the command line, e.g. `git fetch origin`
> or `git fetch`, `remote.<repository>.fetch` values are used as
> the refspecs ...
>
> * When `git fetch` is run with explicit branches and/or tags
> to fetch on the command line, e.g. `git fetch origin master`, the
> <refspec>s given on the command line determine what are to be
> fetched (...). The `remote.<repository>.fetch` values determine
> which remote-tracking branch, if any, is updated.


Steps to reproduce

```shell
# prepare a local upstream and fork it
git init local-upstream && cd local-upstream
for i in 1 2 3; do git commit --allow-empty -m "commit $i"; done
git tag v0.3
cd ..
git clone file://$(pwd)/local-upstream local-fork
# now local-fork has all three commits and a tag v0.3

# add more commits and a new tag to upstream
cd local-upstream
for i in 4 5; do git commit --allow-empty -m "commit $i"; done
git tag v0.5
cd ..

# try to fetch new commits and the new tag v0.5
cd local-fork
# this fetches commits only
git fetch origin main
# this finally fetches the tag new v0.5, but why?
git fetch origin
cd ..
```

[1] https://git-scm.com/docs/git-fetch/2.46.0

Yukai
