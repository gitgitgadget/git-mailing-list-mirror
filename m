Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3530CD9E
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440914; cv=none; b=K4aF7b2isT7APp7z9bA2Gd2unGGSkgdeH+RTFrvZEnlmSAFwmhs5QvvPkEekj8PJM+tE0wwb4caAux39ss610S4CtKqJKvsvBrvlD0qF07X6LpBaELFkLpU6jjDnKknkiZy3wl6SeCAeModdUhNsCh+R31pwGuG1j+fOBEs6OD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440914; c=relaxed/simple;
	bh=TnwZkSxTTNL5cz6TgNMSreKILDUTjWvsn+uUSjaWgUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C1QI10KF2nOs0fTkGAuTLZ5Dqysmj+9+CEu5rwRIm5BEZZ/XZFh6Fsi3Q4OupUMuzoghwZ5zIs33PZRmBk7XZ+2puFftZ66y4K8QMN2dqD1z6GZ0aBetdPPgiw8rtcUAUtQWXx3nvMXt3be5QDGWPulsiNCyj/KNgS6T9Yq0e1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2s00m/E; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2s00m/E"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee13dc0c52so23855991cf.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440911; x=1765045711; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=Q2s00m/EUTuivLspjM6LNtZm1DJthrPZlWnDvZPJ03EPU4JmJu7gZ/BNLX7dqZ2zmL
         ZPmUoo7kxW+IkjWKhYUAyRlb26vNuJnM7ESm1lEGPkNVW3azbGilX5m6drdbwbQZxCit
         kQB4NezfhDi2QZd1IFtv5w224yiRodELIdP/PAJHWbGW0JSbvi6sBMfLzySe19UbTLXo
         JkZNHpOMZl7/i8AS+LCJ7aEi8s1dc8bAqJ+A7MGBF4jhmzyjG+Hc/BaY3fKyXXJjqdzS
         NEyeXZemjK/47zZ3vOzReNvNp9AU6Tsff27SmWAxTzy1gzmVQvv5JdpNtG8prMCF6hA+
         4hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440911; x=1765045711;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=rzz+k3o3MP4kr/Emy42Cod1LBcoepJ9PGNX3U9BXAgsA3kLq6i9QgfPMmYgXvp8ycq
         ze0Sk475hJ037hWFKABbrynC29lqYglYMPY9571pFcbOfnOnUKqSE0kZen9eUciKDUEn
         v1pCBnyUuPzdc3Yrt3+Ti5UFvcCE67ssH59N99cqEfDYOAMkC8tCvRBDl4KkxUd3Qyxr
         qq/Cu1dFpZSILr3DObj9EzDQA9Hf6VCWirYQO8qDRqXUzJ5N+j3tis5/prS2s2umNXbO
         87H48i4ZKxokZkPVyiXSBzwTSACXHaHeiflGRuABHRZoVtYncBl6OQ9S6YCSkiv6/n8z
         63dw==
X-Gm-Message-State: AOJu0YzrzCryjqJ8hSgmoI9KlfVxeKlg4l+M5egFmUcxoapogOe+7Y6H
	+88M4YL8rfBtR510yNpFErbqxjkd+Pdigyc01Q+Mf6mRmYWhU7qt5wrVQejUvQ==
X-Gm-Gg: ASbGncsb6rF5/3vM5Lbo1ibrYpRM0/LVc1jzlc5DpdytcUP3qSrmmsKgkL4VIErvTmn
	Fo75pGwZi2tDujz7ZT5WEES+4DoMCNS9Pcrr2d0bHQBGBFAiBSRbtjdDm8m8/2QF/itIuyMS+DH
	lycP7PsGzoZExdsCl8DgTXxvJV572V0FVXih6cmiQE7E6rskBo2fPqZ/dpumMYZXvoZmRLT2Kji
	yyR4dV0TOz66mD3u4Jtjqh9EW12CKdwIs7QNHZ14E9ObyW0o6Z5vqxpXkJYy7b/7KMp3w48AYtD
	yFW7dU8mLh14k/8iN04YZY28tdmBnTvi3CMW+Gzb2/+zdfCxzm/WbfNJaH7kA8windbzEwAIKlb
	HEkM/Pb8L1LEE2LuW0OGlEZgyEQqJVWqdy3qqZx4IqKYrMVATWD4SbLHrGjePv2/LTeKOYgjfcG
	Q/N6iT0F2f3SppcQ4C2SvIF5w=
X-Google-Smtp-Source: AGHT+IEB7NyRZIdXERA63rv/EJ89yc9s8k7O4AB/m6wdFSppRytgCxHbRyOYsmHdMZCgRgCUAiMDHw==
X-Received: by 2002:a05:622a:c8:b0:4ee:1ed1:43c6 with SMTP id d75a77b69052e-4ee58a84866mr373393001cf.10.1764440910538;
        Sat, 29 Nov 2025 10:28:30 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2fbc481sm46120481cf.10.2025.11.29.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:30 -0800 (PST)
Message-Id: <2d329837e34a88cfe28be728fe24bb5a2c6a9752.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:17 +0000
Subject: [PATCH 01/10] t9700: accommodate for Windows paths
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

