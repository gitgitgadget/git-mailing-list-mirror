Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6282EEE79
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898866; cv=pass; b=odlNm7nP1UJ8gsnBRk/uSzszsmk2QIx/pzvVE9wPTBF2ISPt5Yc+TLs2Yg9o+JTDd7FVHwiHpzrCBPZyR48XI+wWJCVdphKmIrwsLGQ/kVwEzaeQq9Qa9/mGNvHmMXEuy1SCTAlqycrJWVB3LKbNT7TxAZkaWN++IF3EjIZnStA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898866; c=relaxed/simple;
	bh=b7F6uHs6OaI48yQGIvj3/icKVWmEI0m9RbaJ+2TmUK4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GWvVwIQrx35aS9Z63u47cJ6dTIbk6XbFFWAt6rCmqMPgwSmExG31JCrJMjGVJERCfXeft7LqWlfzmHEKFzFrXOJSl5h4DNEGKAJKSkQH3gUr3uM1O8KAPsC4iAevvPU+d+Jg72BQVlOkq32w4waghaT8co8ifL2ifC48Jn/f2Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6kx5uxf; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6kx5uxf"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e79c06622so807662eec.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 16:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790898864; cv=none;
        d=google.com; s=arc-20260327;
        b=RF+U68NHLJB1cQV6ifBMtw1Xn8o1SJcX/mgBMzRLeVpa4lo828GJfDxwiLuYR1Go2W
         9d3mRSdtr0C1rrgigqzc3DKE9pjdlMJHS5kYYcrEzUk4aOcIkIrd//KAuL4J7BDQHi2B
         enaJQe1CFDanOlSS0a0mBuKSDll548J1gHWFQbauYykN0AFn5yLez42jzKHTY/P/5vmk
         A7MtqMi6yy2nLYLaKexuWXuEc/j1ZCeEgMdRIdJjt3eDlgx0u5rQ9TPCJ/PeBMK88onM
         UnU48T9i7x1Wsq5q+jwX2F3XKy5x7wd+N1CRBz5eLs2yQDQLQ2XhOk4yGImZy4F5SPrC
         gAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KUweEk/9e7Fo228kF7aG0Xw+dMTq0V0eq8SdDMTxofo=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HPfEzG7aPCkXX3GkrnQere+37t5FW3c/txVXfOmwhqrcR74up71T7NeUFXiLhSr+N5
         F0YT6YRBn3SVwljpiSgIY1dMhaae4mYg45QnKtY0Q04WN2dYB4m8xISvM+1A9YWIFXzr
         v96ijSX+oJTQvv5hAjeH5Tmj6m6UWiAVIqsKfiLFy29napthZPfzfIB4MTZ/Ykeg56nC
         0M+sC2GBMf/Tj6ancc3iQed0b5akAb8HmlrEcLv4Ir/aR5A2FFtEA5FjemaoU9bx9ElV
         a8ApfHwQJ5NM54w/pbvxIDmh2CPW+oEH0ZsEtsdy6PZwHguhUu+RDbGM6AvRkFOUalhY
         k7jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790898864; x=1791503664; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KUweEk/9e7Fo228kF7aG0Xw+dMTq0V0eq8SdDMTxofo=;
        b=M6kx5uxfbqQ1MlQDa+W/GLIsZXPGG6y2frIjzsBpzUEZFAWOahqakDVhgxl+98k+SH
         iph0UgZEy7SDu/c7doxljDHs1m6THFpH81J2ZnNqdtBiqB79398Ez2XpwIUtncT9bQnG
         hkeODBTbcrS3nXhI/P10svt70cWuLyM9rxZ0c7EkQucrMzDAKKh526EGJY7/5mJa/NgM
         L3nRJvbJO0vJUSokt3d8I4ACT2pp12q7MdKnpxHfqlS41H8IBxZSqDacR9ElxQLmm+qG
         9psfUi3c9ihzDYPxW7Z5HSz5L6YM8COHLstz6uBHzJ0rHXta5fuRNJr23bjruO8xmteQ
         kzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898864; x=1791503664;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUweEk/9e7Fo228kF7aG0Xw+dMTq0V0eq8SdDMTxofo=;
        b=BB6WMrKrqQrslnBD2AVVvprJV86K2HMz+E75NlZBDiY6Rdi+a8VPs+vxPdocg7lHBH
         8MVqY9CPuLAO588iKSIGHiRLZrZy/yH4ccFCCovT+LnbAefvwbPOHokvNSIyb0I/lF0n
         batoSlsxkV+HeumbVggbJUlqUyGs208n6N9YA6C55TWXYjYpg3UsIqq9oHt/gtyjCp4v
         +hBPw38iZELDXQ3Kx/TVHL/8j+0v8wfxVS1BpKaMOEAK2uQaUqP7qeyJyeMbARMCKcLf
         qcuRgYeDpU1NHvPCYRTKzelKZkjFl+hFXJX0XeXhlBoGQEEEIaJ46d4drUpotKNzbjnC
         3v+g==
X-Gm-Message-State: AFq9FYLK5+ADhOGOn9Y1fSpfgtNZUxaZ8iuUkvX5ahS5DXCObVzZdRkp
	TS3N/UWyndYW5TlyASTUrUeMZ3P59n8+z3ZZpio95CG4rArG0NBNjX6SJFg2MolEGumX1bDid8c
	Nv4zz95bKVV3MFPnLSnbvg1bKhxXSTvn8hzHC
X-Gm-Gg: AYBFou3gGQLs0qgIDK1sp9kqZ3rGX6W9s+fDkCvt2mgHEodNB//XnAKrjY45sVbfQgx
	TZFY4Pq//5VmbgBOZ/pRpKolAoyQHHYlfsDWVyWk9n0T5E8WG58Ys/VUmcTOyVUSqHa1VMgy29V
	AxwK16qUh9ZrGsD6QPrYLlwN6KBCtzpGl9t9pAxje7keyWdroWwpZXD7FlO6wAMP5G5mTvEhAZS
	KqJERUFyUJm9nwLmTv+GvIP8tmJkVb8EhRFsr2Y8i0CFeFi0vmWHvHQ6PkDPrRQXhLhQA0ktQ4x
	l3EcvIIOwQ3a13BeulcOFKPOZByCn28rEwpca5gvvxrLphqTZSdhJfJzuywNDmI2ho8dwnlT4c5
	5cA==
X-Received: by 2002:a05:7300:2d04:b0:33e:4e49:d08d with SMTP id
 5a478bee46e88-34f150248dcmr1961428eec.1.1790898863381; Thu, 01 Oct 2026
 16:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Coy Geek <coygeek@gmail.com>
Date: Thu, 1 Oct 2026 16:54:12 -0700
X-Gm-Features: AclHuK_j58RsnYNlLI1-RW8WGNPNJoH52p5uWhl71g221PB0h4spJYGUghavsqw
Message-ID: <CACgTecNrMKHGexWTkm1bqpVzL7SVWD5Hwo17wVokVGe3_Rnx0A@mail.gmail.com>
Subject: [BUG] merge-ort: --no-overwrite-ignore overwrites an ignored file at
 a directory-rename destination
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Consider the following ...

`git merge --no-overwrite-ignore` is documented to abort rather than
overwrite ignored files. When directory rename detection moves a file
that was added on the current branch into a path that holds an ignored,
untracked file, the merge replaces that file's contents without any
warning.

With merge.directoryRenames=true the merge reports success (exit 0).
With the default, merge.directoryRenames=conflict, it stops with a "file
location" conflict, but the ignored file has already been overwritten. A
direct collision with the same ignored path is correctly refused, so the
protection is bypassed only for the destination path that rename
detection generates.

What did you do before the bug happened? (Steps to reproduce your issue)

Save the script below as repro.sh and run it as "sh repro.sh true", "sh
repro.sh conflict", or "sh repro.sh default" (no -c override). It works
in a throwaway repository with empty global and system configuration.

    #!/bin/sh
    set -eu
    mode=${1:-true}
    unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE GIT_COMMON_DIR
GIT_CONFIG_PARAMETERS
    export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
    tmp=$(mktemp -d)
    cd "$tmp"
    git init -q -b main repo
    cd repo
    git config user.name Example
    git config user.email example@example.invalid
    echo new/private.dat >.gitignore
    mkdir old
    echo seed >old/seed
    git add .gitignore old/seed
    git commit -qm base
    git checkout -qb incoming
    git mv old new
    git commit -qm 'rename old/ to new/'
    git checkout -q main
    echo 'committed local bytes' >old/private.dat
    git add old/private.dat
    git commit -qm 'add old/private.dat'
    mkdir new
    echo 'unique ignored bytes' >new/private.dat
    git status --porcelain --ignored
    git version
    status=0
    if [ "$mode" = default ]; then set -- ; else set -- -c
merge.directoryRenames="$mode"; fi
    git "$@" merge --no-edit --no-overwrite-ignore incoming || status=$?
    echo "merge exit status: $status"
    echo "new/private.dat now contains: $(cat new/private.dat)"

Before the merge, `git status --porcelain --ignored` reports only "!!
new/": the worktree is clean, and new/private.dat is ignored and
untracked.

What did you expect to happen? (Expected behavior)

As for any other merge result that would overwrite an ignored file under
--no-overwrite-ignore, Git refuses before touching the worktree, names
new/private.dat, and leaves its contents as "unique ignored bytes".

What happened instead? (Actual behavior)

With merge.directoryRenames=true:

    Path updated: old/private.dat added in HEAD inside a directory
that was renamed in incoming; moving it to new/private.dat.
    Merge made by the 'ort' strategy.
     {old => new}/private.dat | 0
     {old => new}/seed        | 0
     2 files changed, 0 insertions(+), 0 deletions(-)
     rename {old => new}/private.dat (100%)
     rename {old => new}/seed (100%)
    merge exit status: 0
    new/private.dat now contains: committed local bytes

With the default configuration, or merge.directoryRenames=conflict:

    CONFLICT (file location): old/private.dat added in HEAD inside a
directory that was renamed in incoming, suggesting it should perhaps
be moved to new/private.dat.
    Automatic merge failed; fix conflicts and then commit the result.
    merge exit status: 1
    new/private.dat now contains: committed local bytes

In both cases the ignored bytes are lost. They are not in any commit, in
the index, or in a stash, so `git merge --abort` cannot restore them.

What's different between what you expected and what actually happened?

Control case: if "incoming" instead adds new/private.dat directly (with
`git add -f`, no rename involved), the same `git merge --no-edit
--no-overwrite-ignore incoming` aborts with exit 1 and leaves "unique
ignored bytes" intact:

    error: The following untracked working tree files would be
overwritten by merge:
            new/private.dat
    Please move or remove them before you merge.
    Aborting

So --no-overwrite-ignore works for a direct collision and fails only
when the destination is produced by directory rename detection in the
ort strategy.

This matters because --no-overwrite-ignore is the only merge-level guard
for ignored content such as local configuration, credential files, or
build inputs that users deliberately keep out of history. A user or tool
relying on it can lose unique, unversioned data, with no error at all or
with only an unrelated rename conflict message.

Anything else you want to add:

Reproduced with identical results, in both modes, on:

    git version 2.56.0.138.gc61827130   (built from next)
    git version 2.56.0.50.gc46c1e3772   (built from master)
    git version 2.56.0                  (Homebrew)
    git version 2.55.0                  (Homebrew)
    git version 2.54.0 (Apple Git-157)

all on macOS 27 (arm64, APFS), using the empty-configuration environment
shown in the script. I am happy to test a patch.

Regards, CoyGeek
