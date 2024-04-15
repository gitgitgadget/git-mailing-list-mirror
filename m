Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969373171
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189503; cv=none; b=nktd5iIDMimkChGpngKWW+9HyYVAAMu8CuF+VJ4UI0Gt7RYAPpChpo9cb2/EcPDID5HHX6bejIBxcl0FFEZJuosrprKJP2z79NSybEVqM8Ph99iODzHdRGADu4JagpR583HU1gVNHvh9S1hA8gPJKmbpEZyEyZYnzjMh/b4NfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189503; c=relaxed/simple;
	bh=LORNKkWKhTUzi/hJcGrxKUBXDVdGs32otinSIpnsc+Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UgTAUXTTQypr1hb+aCVeTCEPb308cuTKzg4yXCTsGwgdALjpgT6q9AQlDVz1bGAwaQO5aWTs9IvGja8klmPg5hIn0D2C1bq3n4KLKxymbeenUQWz3yxBBF+WQZOGZEnHNuTA7fUk3Qi/RGzBIpknmPtWlwSmw0OQI5SUP+tEnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABlpPTk5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABlpPTk5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so24418665ad.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189501; x=1713794301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOxBCEWFVACITTil+pQtvDyOnpaQED2pnyF0bzP/EKM=;
        b=ABlpPTk5MQZk4a2q7A8O/GpY6dbjw6S//enQEu7I+78iUATldZyF+AwijkcVlmEkee
         AiIAO23fhPQ9zreRCMQwiMMD3MRkSl0ycQ/SvV4bBz1CwbEyFIjCv3hqcGOtSkqj/ZoN
         60IEo6oB1vzGhrzlnEvhQhLwXIf3/VtY7I3gst3i9AEa7Tb6eaHj06z928AZwoDNq4JR
         TwXY1blJTJRhLvPj+7TfYfbHxv8Ex1YAhhGmR8H0Neqf8v0Zyzug5cuILq3PWnjorpxf
         p4yggOSo688mjoCX62jvQIY4Idj+/DBhhBlORBPEk72FVxruxbAk+KzhBAFeHd12gU5k
         bszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189501; x=1713794301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOxBCEWFVACITTil+pQtvDyOnpaQED2pnyF0bzP/EKM=;
        b=ByCe/wOj1obFARch08W/0q6M0UcUuSELzyRzX+evg+a86EmUlUMj11esUvffvhKB50
         zLlmpTX07YK8lysDW2hGdbWNA3eX0eWlbnTenUQc9VrhwcR4acE1xPbfBXF6s8eG9tZ0
         4Gq9AFweBCSS5thKLtIuTAHq/Ui6+lp2kYpm/qSUlnLcvJ8iNugc5VSCJ/NKKVd4rk4p
         lbhwjsrCqw1y3nhyALkLWbJdtEmpZYn7lURcmA5mcZY1orc4CcpXSm/0YEyl7npLq2Hm
         /CoEz7FqFE1mOO2wMrDVCB7feOH5B8vFCd8RjISUOKQGNFemySqzo4ii+E/zC/DONvZ+
         Y8oA==
X-Gm-Message-State: AOJu0Yy16h/qsXWyhXD65cAMHk916Uhqi+V3I91JLgy4PDMfAeG7QrRH
	3ZxuEosFvd/XTg7pQJjTNjS8Th1x2eolA4xNcVAVwx/FMCIC3eqlsGK15OOOdtYGeoWBkyHI62q
	zxC2PwD7okskm/yNbZVR2DjalIxe5Og==
X-Google-Smtp-Source: AGHT+IFntNCKzHncWPx9KvzM8rVNUhpTDRCaJFQlsr8Jja9ZcY5rxi+Gb42EvILCfnHQ2QUC21JJnx40dako4LoNIDo=
X-Received: by 2002:a17:902:dac8:b0:1e4:ad9b:f770 with SMTP id
 q8-20020a170902dac800b001e4ad9bf770mr11972474plx.23.1713189501091; Mon, 15
 Apr 2024 06:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Toru Okugawa <castor.4bit@gmail.com>
Date: Mon, 15 Apr 2024 22:58:09 +0900
Message-ID: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
Subject: Unexpected behavior with the rev-parse operation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have encountered some unexpected behavior with the rev-parse operation.

---
What did you do before the bug happened? (Steps to reproduce your issue)

```
$ mkdir -p /tmp/example
$ cd $_
$ ls -a
.  ..

$ git rev-parse --is-inside-work-tree
fatal: not a git repository (or any of the parent directories): .git
```

What did you expect to happen? (Expected behavior)

If the current working directory is outside the work tree, the
documentation says that `git rev-parse --is-inside-work-tree` will
output false.
https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---is-inside-work-tree

```
$ git rev-parse --is-inside-work-tree
false
```

What happened instead? (Actual behavior)

It will output `fatal: not a git repository (or any of the parent
directories): .git` and exit with code 128. The `--is-inside-git-dir`
option works the same way.

```
$ git rev-parse --is-inside-work-tree
fatal: not a git repository (or any of the parent directories): .git
```

[System Info]
git version:
git version 2.44.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.6.0 Darwin Kernel Version 22.6.0: Wed Jul  5 22:21:53
PDT 2023; root:xnu-8796.141.3~6/RELEASE_ARM64_T6020 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/zsh


Thanks
