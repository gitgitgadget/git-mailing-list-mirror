Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229993EAC71
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144657; cv=pass; b=abYbQCcqgW7G/OEQyECxTxJ4ICC/S2n9nu+iHVQ25U3ElR6HFXT62PP5b/Jn1DRj801kSTELflsrbLiGGbOItE/V7lyF508iWFmYrcsBH1aZUXh/EdARzkoi79592cpJbIfivqUPL+DwjWkN6NLIReueIe9YE8DLdyZk7G15iLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144657; c=relaxed/simple;
	bh=rgvFg/1ofFbWPeWzE+4a8fyMXHZyHHCxm3nNie5W0p8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QqgJ6PWFcB+aLiNQ/+QHcTyTwCwwk3T8Ea0fI1FtZS3Chsq5faQR6+gkRBfPH/CzyRMB/lBwm3//0NBbQx6wVJLzUGIFNrYTSFS6KEl6YCc7mi7QDzgtvz4ZqT854N9mQd9k4ftctSMqi0LhtjNdhNFl3MF26Ztu3utjWD8+xuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev; spf=pass smtp.mailfrom=source.dev; dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b=WL782XMk; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=source.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b="WL782XMk"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-660a40aac63so322085d50.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 02:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144655; cv=none;
        d=google.com; s=arc-20260327;
        b=F4wyH1K3fF0dj5kpTamyzkyU0wJRQeLm9nbjF4/apelmxWK3rDCmlPkMTZJqSHaDpJ
         7IRodzUR0DrQfj985143HlFJ9yMVNzWtqE1t0yVVgSXBJ/sNInMjwi29eQ42JOtxORxe
         TG+mi6NnHDIWrMXqUJGyxMW08R/JcUzsWNL/yoUK3kl9OqP21SLXgJdnfTeK6oL6rNUU
         Y7T2op0L2YIlV5gt9a3V36WP7UEtKJhsBoR/4FS5qvFeHBEkHqfuLjf9gWwZcQ42dRSs
         mpFaLj+t//WqlutWuKeexhIO4eCaalWrMzBa0wvIi5HXNdTUwMFEmekgF8Xwkx2VUAfA
         Tf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pcRaHrHDNTf9JnulSWwblXIE2tuA8cVu2VTX0tWD+o8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=STf9q6/GAo2tJKwHwzPrEApFTlBfpavxzYYVB/BOxmjpiirXfz1Fz6WMG8kr5TGAQ0
         iSUCVVUi3H1bTZltHiQpObiMlb/s4hy4BV3wYoc3L98LGx2JlxuDNFt5UB/FJhj4DIcB
         XRRS0WFmsrnVawdge8CHB4LiHmG+vMQrncb895iMfnCSIbWFbRCaoqc+SkMdTHcuJild
         wYL//rZx4VTobWAxFCsL7K7bDDQrXTunnPJqBoch7AlezBtMFUUMGXaPkZclFmdDwTwV
         4qSfthXaXZ71nHLln5dppkOoF/k+zysiA2UlTTMTyPZgjVPqG14dQD0/IiO3TcQMpS20
         Vi4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=source-dev.20251104.gappssmtp.com; s=20251104; t=1785144655; x=1785749455; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pcRaHrHDNTf9JnulSWwblXIE2tuA8cVu2VTX0tWD+o8=;
        b=WL782XMkHS4t+oaSoDODeYLotJ62/Pj/qdjhKmJgU+7EuhM9K4eZ7p1KkP8SaTzrwG
         1i1OEBIAJIUK4Qnu/DLpGz6I7IOZXsmgXL91wApHmUk2tN4tX7czgoTsX+hIi7Bd11LD
         Zx5zPXuH0GQ60f9ii3UXWFOyHNuaITj2ynJVmjzwiHM1vQmYPgIejxqmzkKLJjdY4NOU
         scNVH5Zgm8j2MbxWInvXpQhwlIn3yfDPV8hgKzdhHGHqf/etaI868cQLBiskSnda67G1
         2rg+JLyagOxQOa+Ow4J3148kdulQWdQhIthCoLg8TqpSTgZ8FosxgSEWNk6b8kGX5F4z
         KwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144655; x=1785749455;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcRaHrHDNTf9JnulSWwblXIE2tuA8cVu2VTX0tWD+o8=;
        b=QYZvNQYplJCQYDlWvE1SExOhgCexTlXh2iWoh58E46ODp2Kt39P+pfDEJufmLLrb3d
         bOBIkQHG4/b2XOlgyc/duX88wfDc09BmAGLgKiCrXfvxMNrURGyu1WoOBajoIQGZJYh3
         QW0MkbBll13bUgDsMXj7HQJDN21iIr6KQmOeL3JxKgjUf9g3CbSwIlAwARsYz7Ho/bY3
         TmJAdQ/DgHL+OdJRExpScYPZMhy/lY1JhZw4t8gi/kPHo2eUQNVQA4cTguLIom/4l42B
         e+iZsRCGrhXCYgLkSRgrGU6ZAlrvRsZM0ZPJWrHALEcwDpKwmuioJyTqJTbVOuu/I5qE
         A8dA==
X-Gm-Message-State: AOJu0YyngcMziaSXqaBg5TjIB/SBaML4jxRoaMjW4fpIgwZk1oweDw4x
	cl21FT20JweQtejoG/ucRJVzGUhXK6uUQobKRPqAx9u6bGp9MTmMvmgmhhoNEynAsW3uywSLPAW
	uH4zP7jucK56fB9i1SzDVLytu7I9D15s9d+GE5As2DNWrQzWKf0dFZQOJ6g==
X-Gm-Gg: AR+sD11MNvnaZIO8USJKsoHbZtKDChQ6Zi+0mkHZ7SyMb5UfYAUGQQXSsnWAmKKvv/Q
	jTMulnFabDLPHzijTr2dhB9rgdUY3YFeoha9dYalSzinrTo/e7Qvx/sXAKAFISgdB6A6RVCJwAV
	FQ0pW4QF/PRnh0ZYKtci61K43O45lg+Jac2TVRqgO9R45NEdPm4lS6B45da2Tn01Jze77HIiA3f
	Y38O4GRmCMnHZ/+MRe45arhfvL40PU4ynyX9xfEEbDbGEDHhCR5CDWrzALeVAIyY0DHtccmYF0+
	W+L48TFTwBqihTGTqLc=
X-Received: by 2002:a05:690c:9d:b0:81e:ba5b:97d2 with SMTP id
 00721157ae682-81f69cc634amr23602197b3.2.1785144654634; Mon, 27 Jul 2026
 02:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alan Stokes <alan@source.dev>
Date: Mon, 27 Jul 2026 10:30:43 +0100
X-Gm-Features: AUfX_myigaAFw6yMIgHsvTpJwX9nIRAZVC6Z6uJW60nxzlmvDoPlTiVPUJlo0_8
Message-ID: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
Subject: Assertion failure with git cat-file --batch-command
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I unexpectedly managed to hit this:
git: builtin/cat-file.c:387: print_object_or_die: Assertion
`data->info.typep' failed.
Aborted (core dumped)

(That's in print_object_or_die().)

Here's the bugreport.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

~$ mkdir foo
~$ cd foo
~/foo$ git init
Initialized empty Git repository in /home/alan/foo/.git/
~/foo (main)$ echo hello > hello
~/foo (main)$ git add hello
~/foo (main)$ git commit -m"first"
[main (root-commit) d62fc70] first
 1 file changed, 1 insertion(+)
 create mode 100644 hello
~/foo (main)$ git ls-tree HEAD
100644 blob ce013625030ba8dba906f756967f9e9ca394464a hello
~/foo (main)$ echo ce013625030ba8dba906f756967f9e9ca394464a | git
cat-file --batch="%(objectsize)"
6
hello

~/foo (main)$ echo info ce013625030ba8dba906f756967f9e9ca394464a | git
cat-file --batch-command="%(objectsize)"
6
~/foo (main)$ echo contents ce013625030ba8dba906f756967f9e9ca394464a |
git cat-file --batch-command="%(objecttype) %(objectsize)"
blob 6
hello

~/foo (main)$ echo contents ce013625030ba8dba906f756967f9e9ca394464a |
git cat-file --batch-command="%(objectsize)"
6
git: builtin/cat-file.c:387: print_object_or_die: Assertion
`data->info.typep' failed.
Aborted (core dumped)

What did you expect to happen? (Expected behavior)

cat-file prints the size of the blob and then the blob contents

What happened instead? (Actual behavior)

Assertion failure, core dump

What's different between what you expected and what actually happened?

The abort

Anything else you want to add:

I first observed this in 2.43.0, but it still seems to be present in
2.54.0.

Note that if I ask git cat-file --batch-command to include the
objecttype in the output it is fine (which gives me a workaround). Or
if I use git cat-file --batch.

IIUC git only fetches the metadata that it needs for each object, and
that is determined from the format. For --batch I guess the type is
always requested, since it is needed to print the object contents. But
for --batch-command that doesn't seem to happen.

I'm not sure what the correct fix is - always request the type in
--batch-command, or perhaps only if a "contents" command is issued?


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.54.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
gettext: enabled
libcurl: 8.5.0
zlib: 1.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Wed Jul  1 15:50:57 UTC 2 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Best wishes,

Alan
