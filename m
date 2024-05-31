Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426738173C
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155533; cv=none; b=eaMTxCuKCFcREAJiePmwFHzzCO1sgI7bE9xTzwivlQLmua2ONeG4+4nOQVGhQK/lrky0+dHTqeLq0vWhEclHEDjluA3c9AJ3OCgZq5d+s5sPfCRG1Qv0mfIum5RX4Zwx541Grf1d7XH8TMfl7M1/m1Xh1Q3vfylpyUCjhA+SMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155533; c=relaxed/simple;
	bh=fCMrSSoMF5YOaKsTKEF052C9y2nscUn+TiLv3P2LRRE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oDRh0k30FdPKziZycf8sFmgiGFFqesGGnh55B3JBkVQoYX/06mdBFikJzP+iQ6H2Dr1YsqOXWcIAjQN+Fgt3MVmaxd9da0li9WuDXicO4XcEMX0EWjJIGAHCu0nzEmP4xEk7rQRwtLVtsnjAPvUwRqMpSqBeNWASu56MFKhXNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAuJBUKu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAuJBUKu"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa59c35e44so2001818276.3
        for <git@vger.kernel.org>; Fri, 31 May 2024 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717155531; x=1717760331; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCMrSSoMF5YOaKsTKEF052C9y2nscUn+TiLv3P2LRRE=;
        b=bAuJBUKuMoZY5uy/zgyOd2OdL7K8yDKGB8o+6zgTXGuqfv2xKYj/NDb+Ic6I2M9GMK
         CigCIkuOYr6r5bwzhMTWFazfjCOjfIak0qIQKMsP/G0NWwBMqsR9C86tBbqmbDP+j2cC
         Aqm9YrLPSpEHy9ri0O3FCEqU7PCsBH3/eYYhmE9BIfbAolJXJHUgD0ZwvUyzDZlf7Gje
         BiFGHwd+IS1qiO1pYLT16GM1lr/WA301KUr2pswpgO8lPe1a1NJ1yHwxIvWZ4/wXAjVU
         j+F8wJYIfJJtMYiUd+RrBIRSDSYr0s/Ter2le28xZetJF7C1Iy0jqhm/0UkifOI86Ss5
         AbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155531; x=1717760331;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCMrSSoMF5YOaKsTKEF052C9y2nscUn+TiLv3P2LRRE=;
        b=Gz4vf0mA13QLT//2ybs9wBPFSsgwlYS/XULEMb4bhwKrdPlL3IxxnywBSFRQn/zwEX
         1sFuBHO+K1YMduP+jac2LAb5jUOQOfmhjYJpW2NmksZlYwrGCstDPa8WEGPipD6hGx6T
         ZiKVpthaAk9VrqznnAlUJXr5FLyhvF9kEWP4NArz+6sJyrAuj5V5jeATj1KshSbBDILU
         sEEHIfUwRStshrsHms4inCC79ho3RpXgfP7sbGtfucf5bVeM0TMnx+wAxfmRqcYuf8Gr
         dzXZddmK2Kmdq7Xb8iKYHGFEpv1QSSXsIRtvy2fNpRJIRMpWTV49dJMQ7t5Mt4dN68TA
         oHQA==
X-Gm-Message-State: AOJu0YzrF+MwvkPsmMYNfy22HKwRh0O5VZFMbwt8W0XLoKeGXJWt/dZ1
	BwSw62NmzJCa/6+E1iwDeDOU+D+FBnEoS2y+u53FgcbF8oyyy3oLjuenomEWdRDRj427yake45R
	/uxvJrxxuAtoZz3kcxw314GRVSYFA7Vo=
X-Google-Smtp-Source: AGHT+IEcUrWNIAMgTgZI7V0KqaEAJm1Meu6BolnFdToXFBrHSc2f1oS1huNu8Dn4gFzd1aqH+irwf2+b4XyTg1vpofA=
X-Received: by 2002:a25:ab45:0:b0:de8:a770:4812 with SMTP id
 3f1490d57ef6-dfa73db2ab8mr1496486276.40.1717155531018; Fri, 31 May 2024
 04:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antoine Bolvy <antoine.bolvy@gmail.com>
Date: Fri, 31 May 2024 13:38:40 +0200
Message-ID: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
Subject: [bug report] git diff --relative not doing well with worktree in hooks
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I noticed a weird behavior when using git diff --relative with worktrees and
hooks. When called from a pre-commit hook from a worktree, the relative option
has no effect.

Here is how to reproduce the issue:

```bash
mkdir hook-repro && cd hook-repro
git init test && cd test
mkdir folder && touch folder/.gitkeep && git add folder
git commit -m 'init'
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash

cd folder || exit

pwd # display the current working directory

git diff --cached --relative --name-only
EOF
chmod +x .git/hooks/pre-commit
```

```bash
echo "foo" > folder/bar
git add folder
git commit -m "test"
```

Displays
```
/home/arch/git/awfus/hook-repro/test/folder
bar
```

Now creating a worktree:

```bash
git worktree add ../worktree && cd ../worktree
echo "bar" > folder/foo
git add folder
git commit -m "worktree"
```

Displays
```
/home/arch/git/awfus/hook-repro/worktree/folder
folder/foo
```

The path is no longer show relative. This causes issues with more complex
scripts.

Git version: 2.45.0 (x86_64) on Arch Linux, shell is zsh (bash for the hook
script)

Let me know if you need any more information :)
