Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFE35FF77
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020387; cv=pass; b=gg5+5k1TaRhnyExy3UfwjEnQoisOLD2Pjf3jvJzFC37x+8BrO8WQqqO00Qr6u8f8BrO2imJJT4J61QmqDBkdAwL6Y/tycyLjS0eSWQlgfdsDhVvmYg3bGadgvqAoZCtoBhjHqesRBrUMpfKol0o7po4hkudL2EHfL+Pma3QoOQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020387; c=relaxed/simple;
	bh=Gq9iQgNygty2ZNW3AKsD9uR4+pgWsd6wwOfgkarasII=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UZWoQpyHjY3TY1TBvGTkxo7W9dw8soPKoXmzI2UeSsd5XFnPFIcbo3creQ0PmlAoDfLhn3a/BN2PJ7MD1Nsvokho4MKnCz22Pjz2C1CbBDY8cAQB9NmAftLaCusb1eQVDcVkldtAqA6QYIynfp0kYp1ovFLkhDS4WddX3ErR2KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auu4r2NN; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auu4r2NN"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c93313721so68885b6e.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769020384; cv=none;
        d=google.com; s=arc-20240605;
        b=MEwz3UuqUwCNvbhxxRtP6ZVaXDdyWlmf2U/zq9YXlHT3BfuXcXw3uK4aVwVYJKaQf5
         01Yj+phsj82KVCQfgZMj8Ts266sUp45ST983Kudm9wgGljQPTvTZLcnAJwOQpiqV+MLA
         Cn8Os1OiqYJ3dGBU2YY436aOrljiAi5u+ODexyXnM3gmuaLba4YMwfVSJfWqWu+x8Ro8
         7dYVSqUZp66WQRP4G86UlEwzgiCB5Nr3hXs0Aqkl2BZ2SSMbIcx576yNicI7lTe2SbER
         097ufHjeXRbzNoaSGTA0YkQFUy8FKAGOc3lXn59tQBOe0Lre6mPrEM7VNzh56p8ZgQdY
         FBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=duTboA75S7FwJ8wjhEY6mMSqKhIgrC4N09SkwUn6oUQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=e6LDlUqRLtTo601axd4mlPiIbTFm8tKBzh9ES35b9ETGjHCmInDVh0ngROMoZhcqG0
         Y1mHXm/fV8M6Oa2gcd+rjxYT1y00/+ENb4EBjH5HsykkRROXaBVHJmY9M50buFZkRoN5
         VsLHAotdSSwsBTRDPqLYU4lVhyGXsw56xgAjzeDnfBZWJ8nDuoGWC321SqFexj+zpGj9
         a8xGZkPc7fJhKnJzLszcpocftyLm6HpfEaEaLxwCjXplRFuTND6QqyhDhHTw9xFmInN9
         YAZ03y+A5JoLaO4beNWPr1L+F2Cy7jd5Gz+0gtCStmIYZvbiXVBFRl8f8iPc6e/ZWPlA
         3DTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769020384; x=1769625184; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=duTboA75S7FwJ8wjhEY6mMSqKhIgrC4N09SkwUn6oUQ=;
        b=auu4r2NNqGDRBgJC46RbtT4obk0v6yYMuzPbVPjK9Mt0gH25vKkAWfcQvcUZEu5bpK
         2qTxojW9HhwwBoOLJJvgR99329i5wUSreVl22SqDjS7eJmmm68wcVno1oypsjCOShVMM
         C+UYfgAibhoeQn+2zEbxaIka5/45zV3EC8wZp8Q/zQeH5Z8uPPRLvB1jYdRROMHKIXWO
         H+9JbUOw8IaolaO+NvbQozWlhsinj/W6cOZ0xkatMbPNao19sJYk/CacgkUx05NvlRt7
         JTOmlPgp7baIUfKwMfh4AXFdev0z5nCQ2JtEyhwOiueW+SglyzGaYEWYtWd1f/Q9vl9M
         TTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769020384; x=1769625184;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duTboA75S7FwJ8wjhEY6mMSqKhIgrC4N09SkwUn6oUQ=;
        b=rEE+o6MzCHNpAJGFWKUjR4PxfDznlhrXZhA5W3lB9IaoYpkL4sR+UPoArvqB5eO3xD
         ZxJNqxmhuMQbpLFdDqwlirloW/9RWweuafkcvuqeMaEB4w6GecOtU1iUS8rvTcdmEslp
         8IwIqrUf0Dbhdyrd5lbTF8MgYlrLp8Lk8mCT/aVNy7Mg2HrmWfNT/00HFzy7+pju21L8
         0M44chDGdym+38uI0k0AaXj2VnAIqymjXuGEKBC/UYTiOgm3vHtOwT/8oJB3IFl5qhFN
         zzn/2QmC7YKn6mtU/9z+jSkGKZavkhv1nIwwp7FlpNEfuTxaNbFiXetUkFDwvD9swsDY
         VbLQ==
X-Gm-Message-State: AOJu0YwQQEf8JrUabp0Kv7XIZTHE2sm6vS6wrzdE1HtyvHtBfXyqCPx8
	XRSm2zPOecdQXiAAsD5h2NlU+xRJ1obDLy6OIl3RUgJlGjxtZvfRnKk9YSPwfjR+RlePGcruLDW
	eoXVzWy9kEd97AgjwCpHVUtEPWBtYwLgV+6nq
X-Gm-Gg: AZuq6aLZqM7/KWf53qVS+TlpQdiuKqxDAdXEzlsqtgD+brSCNqer7YrtWlH2Dn29hR8
	ryBlBXFk+dbXJ7aQdPRkfpOcm2KuYZSSFxUfnnGYo+zAYuzmLKrJYVkh5FQBtCQD+RJFh1bbVe/
	1bi2eCleWh+ucGvD/UZHlhY6nDefjDaVjHS3Foxcs47B+CAFvvl+LTczq+uxaVJA7cS4DrfwZhI
	HUynwGgY/skEfHzV8s+ophpR0L3bw2uERGpUOtdaet4/zBF5sCxx5lMqD2Ixk/AZf9z39yT3y1j
	Lqaj08VyH9cpdhrCCJdjW3yPIN5+
X-Received: by 2002:a05:6820:174e:b0:65d:579:95d9 with SMTP id
 006d021491bc7-662b0042090mr2376240eaf.41.1769020383609; Wed, 21 Jan 2026
 10:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alf Clement <alf.clement@gmail.com>
Date: Wed, 21 Jan 2026 19:32:47 +0100
X-Gm-Features: AZwV_Qh715NG_ceaHs9Ra6ssh3lQA4H-v68VJeSvxbAmhtyzReORToI66WMF7c8
Message-ID: <CAOQVjoi+Z7UgYP+CRVXFz-LWRcNOv571CNQTmLWBgB3ErhTRQA@mail.gmail.com>
Subject: .gitignore issue
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I found an unexplainable behavior - see below.

best regards,
Alf

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Adding an new line to .gitignore to filter directories.

What did you expect to happen? (Expected behavior)
I expected to see no backup_STOCKS* directory on git status.

What happened instead? (Actual behavior)
It also surpressed the backup/ directory.

What's different between what you expected and what actually happened?
When I surpress backup_STOCKS* or backup_STOCKS*/ I expect a backup/
directory still to be visible.

Anything else you want to add:
Here are the actions:

$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   .gitignore

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        asset_history_2025_20260114.csv
        backup_STOCKS_20260107_060326/
        backup_STOCKS_20260107_184151/
        backup_STOCKS_20260110_173702/
        backup_STOCKS_20260114_172546/
        backup_STOCKS_20260116_201409/
        backup_STOCKS_20260116_210037/
        backup_STOCKS_20260117_184437/
        backup_STOCKS_20260119_202817/
        backups/
        index.after.txt
        index.before.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ echo 'backup_STOCKS*/' >>.gitignore
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   .gitignore

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        asset_history_2025_20260114.csv
        index.after.txt
        index.before.txt
$ cat .gitignore
png/
__pycache__
mongodb.yaml
*.log
*.pdf
OLD
.vscode
ca.pem
py.pem
states/
.skylos
backup_STOCKS*/

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.6.87.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC
Thu Jun  5 18:30:46 UTC 2025 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
