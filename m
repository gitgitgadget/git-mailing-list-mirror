Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7336D51D
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764469844; cv=none; b=LqvDzOb7DJK9XfE5jbQXQHYHl8Rv63+EPOnyWhormi7tCM8PvMLW1bRjEeYnTLgOUb5JHhxXkOoPBBukm3Q1+Vhd+GISdw7QOuH6Do1VI4m3nSFwPMPsdA4VhfTpoholIN/uSv6ZloFoCcfA6A+ZA4AvuWL4Ovke5wyBITaxUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764469844; c=relaxed/simple;
	bh=/axcjEUPscoFYw/uzcHVz+dc8X6pVe6bd7/oEHB8HsU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jQU9O3U4+DdngFtWFtxD855FRSqZLLwdaS0b9RgcXjVu8kBV8fAQpNgZIrqd3ooep1h/wImDBQXpOTgtIgokWmSdmhxGF7toF5eL61sIV5VHjjJpOzPM4YuAMfL9Ber7lHkVk//xEz/h79dy/PUqgK1NThK92jkgyBiHACp6TVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl0+sE3Q; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl0+sE3Q"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-641e4744e59so3079226d50.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764469841; x=1765074641; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/axcjEUPscoFYw/uzcHVz+dc8X6pVe6bd7/oEHB8HsU=;
        b=Pl0+sE3QeNaAIUMNC6O43rQl3IEuAq78qp+Kn5A+0qeiOnJR7PAa2eaYC4M1LiPUyp
         lCXJ260W/BkGzDp7lj8L18quLzzz8RrpCuUwobTpQCnI0EmtA3eWXdEA/REh/VTLXeKH
         qCUgasycNs1rTuCfTYLlv3qM6zMwt2nnnPR4R25f31cLStIbdTHjYF5HfUHXuwuQqmn9
         3Wensv5TH28eSOsvA3rqWAQMC6RkTVJXRY6mlDPNfgG+OHSOcIk4HyXYDZ3XVFnAKnrB
         B0ByFsOYc80afl486VkFzZsWY/PF6TJkfjsuEytX/KMo/coF4CJdcf4IXtdPN3TJlLS0
         MEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764469841; x=1765074641;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/axcjEUPscoFYw/uzcHVz+dc8X6pVe6bd7/oEHB8HsU=;
        b=afhMdjjcWWk6Q+RECtFaci3weBlIrTgsI166Sl0/GNmhwzdC6+UexGgrI+oNJnyi2f
         kROPrT82ayysQRdWeeXdJRRjxUACwiUUj3tUpRzpPtoTaYits1reX0xwRkTmNaCzyxW/
         ew6UoPc9HJejda6Z+igmv9CXNwcdgoGJyNUV8z40CjzYX05AOfGCF8qL5y6WQPVGEdjI
         udsKkjp9MBM6KQreyyPmj1UUhG5FJK/yrMQOyAqxPmCasvnZEw0BwDSGjcx1AZPCwKbY
         zT+/vVfqJXnEa09PgryLgLIXBXT6Jgia4d+/5h0PD+9lB4XW61OB3RybZ6/9xkqVz+I3
         2ycA==
X-Gm-Message-State: AOJu0Yz+qiNdH+0waPhbdVjeXCi0AzBCzfAEeecU1hodZUGY/mV+AP9B
	TuPAvLuMfS0KD1i5OjSbxKPgZP8ilrVjagrOVbiqqA+5G7ItSSU5OysIxwE2MSlXXuQ9qhMrcKX
	DDHSS2swuV5yMMPLpYb7Rw06TlmyQJ/xfoblu
X-Gm-Gg: ASbGncsJvNaO1Dye372l3gJKN7L0gfPsJe5TWag8BqSJkS2rb/h5PO8fY4PI4jBGfXq
	DgkamiRUnoTQGvBez+52+7idqwf6QPV1iD6KzMT7xDd7Ejmainh06WcWdcSmt/nVwQMma2s8ORW
	XoZJXOhKlPcgXLwOM9CeGLBdguuBjVzhB48AYV7TBy1vyOOVnpLRlDYGByr1kkc46nwUp6tZT75
	rP3uHXuUHZXGFpDnnqkhPAgVhwERxL+dW04n3RU4wW+5hasxJGH798NBkEsEhn2uZmHXZYlrKSH
	9CIV1LN8+n2PIhSyEmfeeXPFFg==
X-Google-Smtp-Source: AGHT+IFPMDcPI1/HpDmLZ/zHvbpIGSwfrbRJ4mhnvTgTTuLmF8pU86Z8dOf3pcbMKGNJdicdOsiluwptH8c+I4YX69g=
X-Received: by 2002:a05:690c:6c92:b0:787:fb60:f021 with SMTP id
 00721157ae682-78a8b47a75emr283484207b3.4.1764469841664; Sat, 29 Nov 2025
 18:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 30 Nov 2025 15:30:30 +1300
X-Gm-Features: AWmQ_blndaiBu1Na_YrkLwZO4jKmzLGhcyh-gwq90gqo_zkzWnggLQM5GvpC58I
Message-ID: <CANrWfmRk-S1vF+pMH-cK6gUcDK_yeDpxvLOmGMFFZsGBATSSGQ@mail.gmail.com>
Subject: `git diff --max-depth` results in fatal error when comparing a merge
 commit with its parents
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

git init './repo'
cd './repo'
mkdir --parents -- './1/2/3/4/5/6'
echo '1' >'./1/2/3/4/5/6/7'; git add './1/2/3/4/5/6/7'; git commit
--message="$((++number))"; git branch branch2
git checkout -b branch1; echo '2' >'./1/2/3/4/5/6/7'; git add
'./1/2/3/4/5/6/7'; git commit --message="$((++number))"
git checkout branch2; echo '3' >'./1/2/3/4/5/6/7'; git add
'./1/2/3/4/5/6/7'; git commit --message="$((++number))"
git checkout branch1
git merge --message="$((++number))" branch2
echo '4' >'./1/2/3/4/5/6/7'; git add './1/2/3/4/5/6/7'; git -c
'core.editor=:' merge --continue
git lg --all --patch --diff-merges=separate

git diff HEAD 'HEAD^1' 'HEAD^2'
git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2' # fatal: object '...' is
not a blob! # $?=128
git diff --max-depth=6 HEAD 'HEAD^1' 'HEAD^2'

git diff HEAD 'HEAD^1' 'HEAD^2' './1'
git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1' # fatal: object
'...' is not a blob! # $?=128
git diff --max-depth=6 HEAD 'HEAD^1' 'HEAD^2' './1'

git diff HEAD 'HEAD^1' 'HEAD^2' './1/2'
git diff --max-depth=4 HEAD 'HEAD^1' 'HEAD^2' './1/2' # fatal: object
'...' is not a blob! # $?=128
git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1/2' # fatal: object
'...' is not a blob! # $?=128


What did you expect to happen? (Expected behavior)

`git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2'` and `git diff
--max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1'` and `git diff
--max-depth=4 HEAD 'HEAD^1' 'HEAD^2' './1/2'` all output nothing.

`git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1/2'` outputs a combined diff.


What happened instead? (Actual behavior)

`git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2'` and `git diff
--max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1'` and `git diff
--max-depth=4 HEAD 'HEAD^1' 'HEAD^2' './1/2'` all output "fatal:
object '...' is not a blob!", $?=128.

`git diff --max-depth=5 HEAD 'HEAD^1' 'HEAD^2' './1/2'` outputs
"fatal: object '...' is not a blob!", $?=128.


What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0.windows.1
cpu: x86_64
built from commit: 2912d8e9b8253723974b7baf1c890273b1a1c5bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.17.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
