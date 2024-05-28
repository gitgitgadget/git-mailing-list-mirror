Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AF71722
	for <git@vger.kernel.org>; Tue, 28 May 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886889; cv=none; b=rpmOSae4gvT/hh/H1xj/3Qdd+H9pvbUGwZTz+7PFJb8sxFkePAeCYwhea/gDwz6C1r3Fb9rEUl2xJKlsc8wPIBRN1tE4ouU7CY7Qa3aIK3qG5U5V6eIilrisbvneGoR2ADRX295fJNCWonEwIEGE8D9ziwjmCAUPRo9/yY/uTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886889; c=relaxed/simple;
	bh=5RDuqhIi52BNZKU+0QhPRB13XXGBAZLWMCkjRYa6154=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KnAdUjVQs924oW0gZFJZpo0x/gd61jZTaQ0J/UR/v1NR0A0b4KnhK8kg0nsLIMs/+hm3UPNSkRl9fA6jItxaUFIcFv6JCl9ZogG1jBnxfUKoJ+7QRMNHAmGa09OsXKS/iilcU6py8nBcEFaGNIvbccRAMtMP7iGKHvXWwuSZ1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0uYlaNE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0uYlaNE"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785fc9c543so650035a12.1
        for <git@vger.kernel.org>; Tue, 28 May 2024 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716886886; x=1717491686; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wSrU/3XSS7Ghkt7cQedBOwQUL+Xb/DFJXtq6xTOjkmw=;
        b=U0uYlaNEYrFXOUHC9fs3y1gH90ZSJIGcW2np+qqe5QGG0yjxN0h6M8zx6nybNLLYUM
         TLlQJzHzLROtR0PrXu0B1zMWt2BGNvoudXAnMCucNnLC6dErnSS7ZGb5c93FVSL/j2NS
         PQPnRUbghnV61QhqixlA2sEb9K+fs7HenVBnLt25Zwbu1ZEJr4AIt0iBMBuH8ZrfWHB2
         AOc0Cv/9fWBFoFe5mzehiHU97AHBZKIrt92X1yopbbCnTkLmn69Uz7CckpvmXGc1CJzP
         k3wPj4wOSaMxRTU/p6NBoYMFDBb42/xl4epqTwnGRdl7iT2S+YQcQ+kLSn2pyqFsz8wx
         6Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716886886; x=1717491686;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSrU/3XSS7Ghkt7cQedBOwQUL+Xb/DFJXtq6xTOjkmw=;
        b=qIVTcTrk/0As0+tgMGxPdc+8fTlataNEinQMGyTZZXVKbASidEvRAEdgr4xAqHr4hq
         +M2W1nNxYIfCmR6XdByG6TmsO+e52TPU9pxrRPRho+/9sfKtZUDrOOKSonGvLbC5M8oC
         2J9Rss2eV1nb+OCbYRbYiBJuglCiZJVJjCMfvBiN4wq13kkK7CJ9aXP7VhRfIvCUy4Tx
         inIm4LVHMx+TxqTgRtM25MenNgUlmnTwYfrd69itJjKkuB2m03UHqQFUMvQiibG0Ofio
         xilMELQSsy/tWWC6WJzWEEz6GnyxoO75asN/FfWbuQNHuNjVCVRK3WGqZUyb5hnZt8Ah
         OAnw==
X-Gm-Message-State: AOJu0YxEpLxAwygHmNpvJLrqQJmWblrokYyugSpWpl8dliaG5V/fLtk/
	QtBA3ghH7WZnIesuzbRr3NIlQrObfj58AS5EU0B2qpeCVs0YqJsz+e44y1tCCx7YzceB1UsVj2H
	Do68Yrxh35DTopUfLSa9YukXsashlJPIG14k=
X-Google-Smtp-Source: AGHT+IGjX2u+334V1XJRXAkD/p9hgQRHBs4jicSQ/yli9ReDVkqC3CQkj5YIxKhd+/B3HcNvsTkBW/pskauPuago41U=
X-Received: by 2002:a17:907:868c:b0:a62:de58:b350 with SMTP id
 a640c23a62f3a-a62de58d301mr891508766b.59.1716886885518; Tue, 28 May 2024
 02:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Workshop BLE <workshop.ble@gmail.com>
Date: Tue, 28 May 2024 11:01:14 +0200
Message-ID: <CANXjuPnUr81bKGMqZMvDjVZ+1suddoR5-8-SZn8W4EehW5-siw@mail.gmail.com>
Subject: git hangs forever after updating to V.2.45.1
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
Upgraded git-bash (windows) to latest version 2.45.1

What did you expect to happen? (Expected behavior)
git works as usual

What happened instead? (Actual behavior)
git pull and git clone just hangs forever when remote is dev.azure.com
(did not try any other remote)

What's different between what you expected and what actually happened?
see above

Anything else you want to add:
When executing with GIT_TRACE=1 GIT_TRACE_PACKET=1 GIT_CURL_VERBOSE=1
it can be seen, that git connects successfully to remote, but hangs
after a cuple of this lines:
10:51:38.026547 git.c:465               trace: built-in: git config
--null --type=path http.dev.azure.com.cookieFile
10:51:38.065783 exec-cmd.c:243          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
10:51:38.071783 git.c:465               trace: built-in: git config
--null --type=path http.https://azure.com.cookieFile
10:51:38.110297 exec-cmd.c:243          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
10:51:38.116296 git.c:465               trace: built-in: git config
--null --type=path http.azure.com.cookieFile
10:51:38.155881 exec-cmd.c:243          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
10:51:38.161881 git.c:465               trace: built-in: git config
--null --type=path http.cookieFile


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.1.windows.1
cpu: x86_64
built from commit: 965b16798dab6962ada5b0d8cf0dca68f385c448
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22631
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
