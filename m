Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE714A0A4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459334; cv=none; b=G+sp7/CRAabYHcanTUW4XD3+hnFvepAmtAh42OF3KnmZiRYP8laaAm+wKLurd1GaSQNoL/6/pPExkelsAzJvZsWEMeVQmOBlU+NkFrVzkpIQwh5ctYNJdiwBUvrDxntbQODBRTaWUfD9kuJRriYOfxPVfzrTEnnKCahm1T93L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459334; c=relaxed/simple;
	bh=n8QJY//FrW+m9t8o02TMg+E95kTvYSV523Jk8yGGo6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K2uTm7fv3ktqkOhlmvm/466mauq9QTlvkPJ1p/eu9fHTugt30Z9TYhE3PKECMnCClQPA55DwBN+ODX3OcZCu7vSMRvL912AAvmpc6n4QvA52f7ZGQAx0TvvWhYg7qQfvQQLphjIGbwNVNwzdrvFyvuZuQYmWSd7yntLr9okkCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To71Dpow; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To71Dpow"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso6543847a12.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708459330; x=1709064130; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T//VWm6YXdWhGgLmD3bmm76GKZ6SnnKkef2X77krYgw=;
        b=To71Dpows/zCBuzb+WkI9RZOeafVF2/stLu9egEe3hnfrShQePJMaOjf7PlC0ybbWH
         7tBIYfpYMi4NadlZ/MCh9MQWVLY21SYBixPk1OysAcwPibWZA3lM1fCOcMKb2EmRVsY+
         i5TwGYV5G82v4NfXxGbsN02myejCUBirDKtIkgZefx8hLC9klAV09WGnh9zog+sVBSXr
         5eeM9tZVQ2q7hi0vpWXslQUjCA0ipPrJndTcmHMsh4xhnOmqJ76eJ9w0oVv0NkFwcxvu
         DIMSv2ujAjxkPdTSPS7w+xkmC/HaiKP8iLna+N55qq/YmVXyw641qDjISefYNL5NUwd6
         zMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459330; x=1709064130;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T//VWm6YXdWhGgLmD3bmm76GKZ6SnnKkef2X77krYgw=;
        b=I/XhIVR2HKBHcgBQbiA3v8PmvHlmYw2HudhOXUfp/5BWk1KfEZYCDl7HkFDGXWMbkg
         Pyhty6/FaOhcSFt0nvRQBp/nfu5ChjXtJDqCyv6YsW0B78Li2gDPHoXW7zJ23EUslXCm
         1jdShuV1djbv64k8tzVfV4QG5sO736LK6v6fxpUQPuIOxd+tMsh6jTOyJarTV/5ADdJq
         dTexNjRrNWQQAzssNtz5560PvFB7DMjapGnIchLIIeyWDmjQhfegYFtU2JyqaRWnV/98
         qJZDCjxJEZDjFEnEKhrRcJZXPn88nXvkML3g0NRFPDYyrmaOk8Kk16DSzI2zssHA8wds
         c3hQ==
X-Gm-Message-State: AOJu0YztRIl4RO2160raF3e9Xgu5hVpSG4109vLIro0RXsj2QvBRedHJ
	sDywgvWm1kjdq9JdPCWcFoMqdy1QWcGRxZvcFlVR8+HM9PZNmdjdwKaVtqvtkV/2hs6p6Liv4hc
	uIv4oeAhBXYMrW2Q9D13OIy5xNgQc5sQAS0eBtA==
X-Google-Smtp-Source: AGHT+IEM4Mj8Xgb24c53zeVCkB/L5U6oRFzuJyLMVw5JoMnEHDP2KMBfF+a109+w3ZgnszaAa6817BnA6EgIycYGT9g=
X-Received: by 2002:a05:6402:b2a:b0:564:a91e:2b68 with SMTP id
 bo10-20020a0564020b2a00b00564a91e2b68mr3214193edb.22.1708459330405; Tue, 20
 Feb 2024 12:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Gabo <charleforalia@gmail.com>
Date: Tue, 20 Feb 2024 21:01:59 +0100
Message-ID: <CALPZ9FGr8K=AdqOzX2P7A3T8+_V25SOjcHA5kY-Fg5TUFEvh7w@mail.gmail.com>
Subject: Git rebasing attribute the change to the wrong file [bug]
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I think I found a bug in git, where a change get attributed to the
wrong file when doing a rebasing.

# Short summary
Assume `master_branch`
```
.
=E2=94=94=E2=94=80=E2=94=80 parent_folder
    =E2=94=9C=E2=94=80=E2=94=80 project_a
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
    =E2=94=94=E2=94=80=E2=94=80 project_b
        =E2=94=94=E2=94=80=E2=94=80 file.txt # the 2 file.txt have the same=
 content on master
```
Assume `feature_branch` from master
```
.
=E2=94=94=E2=94=80=E2=94=80 parent_folder
    =E2=94=9C=E2=94=80=E2=94=80 project_a
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
    =E2=94=94=E2=94=80=E2=94=80 project_b
        =E2=94=94=E2=94=80=E2=94=80 file.txt # this file got modified with =
a feature
```
Assume `refactor_branch` from master
```
.
=E2=94=94=E2=94=80=E2=94=80 refactored_parent_folder # got renamed
    =E2=94=9C=E2=94=80=E2=94=80 project_a
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt
    =E2=94=94=E2=94=80=E2=94=80 project_b
        =E2=94=94=E2=94=80=E2=94=80 file.txt
```
then rebase `feature_branch` on `refactor_branch`,

```
.
=E2=94=94=E2=94=80=E2=94=80 refactored_parent_folder
    =E2=94=9C=E2=94=80=E2=94=80 project_a
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.txt # the feature got move=
d here !
    =E2=94=94=E2=94=80=E2=94=80 project_b
        =E2=94=94=E2=94=80=E2=94=80 file.txt # instead of here, where it sh=
ould be !
```

# Reproduction bash script
```
#!/usr/bin/env bash

# tested on linux, git version 2.34.1, 2.43.2.

set -ex
# create a master branch
mkdir -p git_repo
cd git_repo
git init
mkdir -p parent_folder/project_a
echo -e "1\n2\n3" > parent_folder/project_a/file.txt
cp -r parent_folder/project_a parent_folder/project_b
git add .
git commit -m "initial commit"
# we create a feature_branch from master
git branch "feature_branch"

# we create a refactoring_branch from master
git checkout -b "refactoring_branch"

git mv parent_folder refactored_parent_folder
git add .
git commit -m "refactor"

# we create a new feature in project_b
git checkout "feature_branch"
echo -e "1\n2_some_new_feature_in_project_b\n3" >
parent_folder/project_b/file.txt
git add .
git commit -m "new feature"

# we rebase
git rebase refactoring_branch
cat refactored_parent_folder/project_a/file.txt
# refactored_parent_folder/project_a/file.txt contains the line
2_some_new_feature_in_project_I think I found a bug in gitb, which is
WRONG !
# It should have ended  up in refactored_parent_folder/project_b/file.txt


```
# ENV
tested on linux, git version 2.34.1, 2.43.2 are affected


[System Info]
git version:
git version 2.43.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-18-generic #18~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Wed Feb  7 11:40:03 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh

[Enabled Hooks]
