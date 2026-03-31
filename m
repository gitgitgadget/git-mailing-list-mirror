Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0362D3EC1
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994009; cv=pass; b=gFcgX2ll4msddS+wp7bwsuawDtbQtQt2gWCNJPgCoo6lR7s3RgsR/iDnLcjh65rn8TCGaLwAXOPiqc1/IdwsAF/hqdJkEMRnFL96SvaZEQ8Eold3mIxJhUniu3/yiDy/2P2xbgBvJUr3/8NgH44/PMoxGdSGo/+WtFI0OkGD6TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994009; c=relaxed/simple;
	bh=XUwGfiVHlQbEx3vc6GsaIzbRGMdRw8HGQ6q6XJrlPn4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oPcGptlZ4XrDky4N4PtPC2UFhooxBT/MYrNHwbcDnkHAwFM9H+UZBUn+5aQCenD1l5Oa391TMeZG24pQSuqCnFezYTq0Jdmsm7axaZpvmJpzTsMu9Gp+S03WlNYiOIhi9sTTf4tFbgjjKfsP2QH/9knOsQyJ3pnriLPIBnR7aTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ8wPpG7; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ8wPpG7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79885f4a8ffso27040487b3.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994007; cv=none;
        d=google.com; s=arc-20240605;
        b=AUJj5VJ2I6fKUUzMkoKpGjlbgn391UrbAc6AFoyF1/taAiDr4DwkdygXqmo09cj6vS
         X3bZ/WixlAWTtWSQmpWXG8FGNNo6tEQclMeLHkErAQ14DfhzSqFBDLiWJqiVh8ozF1+3
         Ghu/n0AdI3DQbNVrwewpUn2nIStQB9Ue4khjMESm/4NErOZ1OqgiavBuA24Yhy4IFB60
         xd4rd/2c6rKzEo68/E39aI5DSJ3lPx79wZfzn0DHZhHb6nkmAX9TMbEuLF/BMjeuCz0A
         quXZSD+ZoADyzCmrmCXvCfLmKEtfP4CpcqByuTAscMaE/EKABmyig/TfWNQGyqoydDWS
         l4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Otus9W0VlO0fJosJcylZ8fjMbuSIQ5ve8j7en6KG4P8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=FNq8ELBNGaePy5bLCPpsZhRSeYuGdb2FgKSVL5Ar0NhcH28SvTT4qEc3fJH24hEaPu
         3j1eFAXFLkj5uw0byO2SxRV4Zb7fOj5OKGFWizh5PbMBG5VEpQOYS6QsrqZ8VDAjcmQf
         kReevYT94KSsVCeBfpJQSVu9LmN3PRPEbG5Z5AdD4EWyelAbZcm39/WNqc4OMokYWicP
         Ftr0lrw5W0pXRGqdTQo8jLiubLSynQUNwTwdleleza/SIbG1oaT2C2rah5991QuNsXRh
         iGEIdx2LhSg29roR8XWD8XF6CWYyJgRD8PwqbpKmbHYyDbze2u71uahvB4rrOi3LWyp1
         htcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994007; x=1775598807; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Otus9W0VlO0fJosJcylZ8fjMbuSIQ5ve8j7en6KG4P8=;
        b=kJ8wPpG7TN2kImFx0wfldUvOnEAJXzIZg14Z2Kr8qb6gLs/S4zSOo3TepTIQ0KaxsG
         yepif3jEbYmUu2sv1Mloq+fOuex3kD8e4U+86yK0oFjw4FcFT26BOBF1zPwrm51ZY6Ir
         JxtBte0AlDSE6+aG3c1QcH9/WbkjyRm2BblhJ7erqkV1JtmWPoyjVtGq5Q/AIf5mh81T
         09AgKCEfiwj7nDluVlsXVGPl2qPheq+EdKNAege7hg2qJ58RQWOjRt6GqS8gV1ML3Gom
         SI9CPGKNJt5zWIOA4gD24UN0qBukPSI0oIz+sM7KbyjTQSiRWWijJQSt17RPNUMEU8Lp
         JISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994007; x=1775598807;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Otus9W0VlO0fJosJcylZ8fjMbuSIQ5ve8j7en6KG4P8=;
        b=Tq6bE1q9ipck00npFb5gcz2TPedTo6t7q0OBHEEDjisq+dm9L4f7uOX2pnVWxoUVt6
         hxK/cK6Zf5haUoNkZ33QGVtuyfUA+IHOfJWpjtMG7AqP3Uu58HI5TnxlubdE6jp77bAt
         nBjtkAxhETL+QWcjjOgt5KfoFTcRcNI5R8ZXBrlMzDIah72UVNOkjQWLT5CfQ3knTm7G
         eZ8EVxZGsrbh/FEZgDb0LiWBfrJEMSdeaZleazlgIKD51c6MHc8zAJ6vRU51/7dCztUI
         SYC1wkEf0nQgDYjxEaHBrjyPVnIFBjSSCkwhFzDRd3i6PATu1xlsYoMO0ltDdKJx7/gD
         75+Q==
X-Gm-Message-State: AOJu0YwiNvNye/T+kZkrCrGa3FJkDcCM82y1lRbmW6YrCAxvcY3GRaqf
	HLCwRBZ75IuXo/V1mmT7dTJmM8x1zuy6z9Rfz+SqV90FEuVsidpeYpB30dAEdKD06k3Hk18mxSP
	9jjRdO1VUVH2WkyFeedwFdLHWUwr1TV0Q0Hcc
X-Gm-Gg: ATEYQzwdxlGsM/fyS+K2kmOtvyE7DW7CpzzmaY4cPBIQBVZy4NLtc+Y9YH4eMhQGc6d
	QFZfcz0bBznoBoDvsdSL/ubkx0fGRejPPb2veMmXsFMuMzyYLg10Z0dlp8nlqiMNcp3KJuqz6+A
	fe+X7QqTufMPD+rFOCdZLDX7TKNnzpFfn6U92SDKtpr4WV8wf7cdwM5NylTO0AwZtWqDGwuJs/I
	Pcc6rZ0FYHba65OF4y3ZuIp6c+8PT7Og+LwtXLMbDBUBjHFaGVttBVG7KsVZGsPijCxoqs4k5Kf
	7V7k4zfdEydATixnFYwwo9YVwmRhFs4OUTWC6x7FbFUBB3QfgQ0RjX8UGUP1TOf7GEc4yA2Edg=
	=
X-Received: by 2002:a05:690c:e094:b0:79f:859b:a083 with SMTP id
 00721157ae682-7a21310379fmr10420137b3.51.1774994007217; Tue, 31 Mar 2026
 14:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Golden <nreesegolden@gmail.com>
Date: Tue, 31 Mar 2026 17:53:16 -0400
X-Gm-Features: AQROBzCWmiUAQhT-M-HAYJm8x61fTHZdvyqsN7jzSyxtNp-JyOX96uPXAbuMXZk
Message-ID: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
Subject: BUG: git commit -a crashes with "unable to stat" during unresolved merge
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I found a reproducible bug in `git commit -a`.

With an unresolved merge conflict present, if a different tracked file
has been deleted from the working tree, `git commit -a` can crash
with:

    fatal: unable to stat 'bystander.txt': No such file or directory

I can reproduce this reliably with Git 2.53.0 on macOS in a fresh repository.

To reproduce:

1. Create two tracked files with identical content.
2. Create a merge conflict on one of them.
3. Delete the other tracked file from the working tree.
4. Run `git commit -a -m test`.

Expected:

Git should either stage the deletion and then stop because of the unresolved
merge, or refuse the commit because of the unresolved merge, but not
crash trying to stat the deleted path.

Actual:

Git aborts with:

    fatal: unable to stat 'bystander.txt': No such file or directory

Reproducer script follows.

Possible cause:

This appears to involve rename detection during `add_files_to_cache()`: the
deleted file gets paired with the unmerged path, and a later index update tries
to `stat()` the deleted path.

Thanks,

Nick Golden
nreesegolden@gmail.com

---8<---
#!/bin/sh
set -eu

repro_dir="$(mktemp -d "${TMPDIR:-/tmp}/git-commit-a-rename-crash.XXXXXX")"
echo "Working in: $repro_dir"
cd "$repro_dir"

git init -b main
git config user.name "Test User"
git config user.email "test@example.com"

i=1
while [ "$i" -le 100 ]; do
    printf 'line %s: shared content that is identical across both files\n' "$i"
    i=$((i + 1))
done > conflict.txt

cp conflict.txt bystander.txt

git add conflict.txt bystander.txt
git commit -m "initial"

git checkout -b feature
perl -0pi -e 's/line 50:.*$/line 50: FEATURE BRANCH CHANGE/m' conflict.txt
git add conflict.txt
git commit -m "feature"

git checkout main
perl -0pi -e 's/line 50:.*$/line 50: MAIN BRANCH CHANGE/m' conflict.txt
git add conflict.txt
git commit -m "main"

git merge feature || true
rm bystander.txt

set +e
output="$(git commit -a -m test 2>&1)"
status=$?
set -e

printf '%s\n' "$output"
printf 'exit status: %s\n' "$status"

case "$output" in
    *"fatal: unable to stat 'bystander.txt': No such file or directory"*)
        echo "Bug reproduced."
        exit 0
        ;;
    *)
        echo "Did not reproduce the expected failure."
        exit 1
        ;;
esac
