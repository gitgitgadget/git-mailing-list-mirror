Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E93361DBA
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981132; cv=none; b=bWdvU7toFP9VnWu4qlYOMUukdnQFaSDCMH+5wzpD0UYtqs3o9njQFM20KyvCc1VhBuu+kMOyPofrMKXqHhn5rDhrsDt7ROLY1tntrREAqHf2UHP0cjfNdxyuaJQSrv3l/ldhAiWamRQHuxwi6dxr9/T10LG8PGsVkPUahjjiYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981132; c=relaxed/simple;
	bh=TnwZkSxTTNL5cz6TgNMSreKILDUTjWvsn+uUSjaWgUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uLNiIdqkgOS+q/9DKpLjBg/gdTZmx6zNwV3L6Cw3BxwdUR6pS5qa56u9OZKPoPXgUk5CRSK2UGTdxdtviLtPtdO6x4SA1YiU6YrdNdtioqDNs8I/wqf4dtb+shmSIKt5SMMK9cEVSJ/+9Z8uCQIkww8VvklcGqhRf/ZPX2KpxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol84bl8j; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol84bl8j"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ece54945d9so2139776fac.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981129; x=1766585929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=Ol84bl8j6kIQd8d2kThKJE1GamW+eUyC/X1rN13bXDsSN5emKlLum6du7xH0PoUylI
         lj6v2cJH4bYPZb5D0jWMOAp3y27XZHLa7xHcfQTZ7+yw3n67+Fy0Mc7fXBpXLU3lT5Gs
         B5jvJxTH7pXeM6w2dpQu+McTP4cPqVWQa/0YZrZHj7CEfFkBxjL0iyedR8H2hQbJWSam
         JAAwoDykjlYaPQRH3DgLyAaNmvsH658nxw4dkF/xOk+2w1QBYZYRnI1um3dH7KNe0uai
         ZGozPpBF3iAcX7xbvU8h72UFrrJyaDAENTOHQdJ39WdqiDtTjU/KrUqFnlTOy4CwRsbb
         GVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981129; x=1766585929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=K9x9M7edsHk7SAajHldvQm5xVHnUZo2K2cqfKxswr9kjPBDQx689TIllLXGe68VZ1Z
         c7QwMp3ZCdpcqoMivD8/RdzfxrApT+Z3Xy8D9uwTOb75FIfCK5WoSrd0eDHSAYQbfVeH
         rFez8GTJrY3znI75Ct9OHiQxzFVxtiaVZXOCs2mdK7mZMJaIcrASsbVfBJp7L/uRtPEq
         LmO/9w2FmPhycc52hGc3a+uow/IGIQl6lTsB9hwdQ5BBK+9ci4UahRSuhGMwGK3hfDnQ
         EPyM+ayeK/Bv9MfzVH/VmMqufOeci5bd8XMN2EhEeeq/A29tfsMnGaA1q/Cf66MKiNhx
         4nJQ==
X-Gm-Message-State: AOJu0YzKo5SgFXxJRoXkJP38Jmj/wBTnv4UAYX2nvhOrX3pWYpovWg/K
	ARrJFpiGwaaTrnOJeXBeYW+Hje3UsywgL+maKSK+81CNB+JAidG7ZxjvkalcAUUVFzjLjg==
X-Gm-Gg: AY/fxX7MlZMhj2e8NgsaLqwsJkqaxFwYss7JMlcC7BM39j+cpLYQDWD6HTB8Zrs2msK
	IEiLTwvKOFZr6Nev/sNwZKY73ndTIsDWtBn5iNSAcP/iCb8C1T9kDsRjnNNaJ8KHZ9JNyKb05my
	uLUi3FtnSq8e7/l5FCKQwSsyki+f3/mOY5aIANySO0IIaJvjO8rtmXuYB7Z4wRhY2x6sJnE7kWt
	gs+3dSV/hQOc3PS2w4Dy0JocquTVI+K5JwJnfsOCtB3sRb2ybk2s7VFVU7EB9TER3nhhSqP0ogy
	AfRi8AhUYFd6503A45xN8k1S9jUJUeAfjJZveAlXp03+3fqKjO9mpPvkFDPVhxAEAG1w2ZZaLeh
	Tkm/XA5IObymaGdA2S0Mv5M4MGi/ot7LyenYweSqKFXu8PS/xUgt4j8N6Fx+7dYF3zyql+kpvm2
	UImMqL9LUKvT8e
X-Google-Smtp-Source: AGHT+IF71Wl7lpCeCo8tYSXcXgCfXpNimorZA6Bh/taEYZIgM6M+WMa2Wn3wPouXEqKu1puxtqeHxA==
X-Received: by 2002:a05:6870:d40c:b0:3af:6b4:1232 with SMTP id 586e51a60fabf-3f5f8bfe032mr9054062fac.35.1765981129435;
        Wed, 17 Dec 2025 06:18:49 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614e374ffsm8372873fac.16.2025.12.17.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:48 -0800 (PST)
Message-Id: <2d329837e34a88cfe28be728fe24bb5a2c6a9752.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:37 +0000
Subject: [PATCH v4 01/10] t9700: accommodate for Windows paths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since fe53bbc9beb (Git.pm: Always set Repository to absolute path
if autodetecting, 2009-05-07), the t9700 test _must_ fail on Windows
because of that age-old Unix paths vs Windows paths problem.

The underlying root cause is that Git cannot run with a regular Win32
variant of Perl, the assumption that every path is a Unix path is just
too strong in Git's Perl code.

As a consequence, Git for Windows is basically stuck with using the
MSYS2 variant of Perl which uses a POSIX emulation layer (which is a
friendly fork of Cygwin) _and_ a best-effort Unix <-> Windows paths
conversion whenever crossing the boundary between MSYS2 and regular
Win32 processes. It is best effort only, though, using heuristics to
automagically convert correctly in most cases, but not in all cases.

In the context of this here patch, this means that asking `git.exe` for
the absolute path of the `.git/` directory will return a Win32 path
because `git.exe` is a regular Win32 executable that has no idea about
Unix-ish paths. But above-mentioned commit introduced a test that wants
to verify that this path is identical to the one that the Git Perl
module reports (which refuses to use Win32 paths and uses Unix-ish paths
instead). Obviously, this must fail because no heuristics can kick in at
that layer.

This test failure has not even been caught when Git introduced Windows
support in its CI definition in 2e90484eb4a (ci: add a Windows job to
the Azure Pipelines definition, 2019-01-29), as all tests relying on
Perl had to be disabled even from the start (because the CI runs would
otherwise have resulted in prohibitively long runtimes, not because
Windows is super slow per se, but because Git's test suite keeps
insisting on using technology that requires a POSIX emulation layer,
which _is_ super slow on Windows).

To work around this failure, let's use the `cygpath` utility to convert
the absolute `gitdir` path into the form that the Perl code expects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 58a9b328d5..570b0c5680 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -117,7 +117,12 @@ close TEMPFILE;
 unlink $tmpfile;
 
 # paths
-is($r->repo_path, $abs_repo_dir . "/.git", "repo_path");
+my $abs_git_dir = $abs_repo_dir . "/.git";
+if ($^O eq 'msys' or $^O eq 'cygwin') {
+  $abs_git_dir = `cygpath -am "$abs_repo_dir/.git"`;
+  $abs_git_dir =~ s/\r?\n?$//;
+}
+is($r->repo_path, $abs_git_dir, "repo_path");
 is($r->wc_path, $abs_repo_dir . "/", "wc_path");
 is($r->wc_subdir, "", "wc_subdir initial");
 $r->wc_chdir("directory1");
@@ -127,7 +132,7 @@ is($r->config("test.string"), "value", "config after wc_chdir");
 # Object generation in sub directory
 chdir("directory2");
 my $r2 = Git->repository();
-is($r2->repo_path, $abs_repo_dir . "/.git", "repo_path (2)");
+is($r2->repo_path, $abs_git_dir, "repo_path (2)");
 is($r2->wc_path, $abs_repo_dir . "/", "wc_path (2)");
 is($r2->wc_subdir, "directory2/", "wc_subdir initial (2)");
 
-- 
gitgitgadget

