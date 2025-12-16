Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B834D4E4
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885583; cv=none; b=XeBb1ONNlW4BP5gIqn0y2AvSw3jLEDGscOv+QPA58HX6pvLuUWLW5Vth3MguYq56SM9tuo0s7jSNXLyLUzQ27mThsbxKlFtB5gUmcuGdVntWY2XdvBL1OxX51v4cIeItz+MS+aai07K/8gcCwUy1irst1RuUUCohR/jmREFhlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885583; c=relaxed/simple;
	bh=TnwZkSxTTNL5cz6TgNMSreKILDUTjWvsn+uUSjaWgUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m+bJbRff85og9v9RakQx7d0jPT+gQHH5q8MugQ21L55pRErtXf2TcPPBntI50qFu+SFzq/Y1cOeD95mXkEff5shlu9C/48uvSZgk53VmfOfQIBTatmeS9Hr0pb3KSdGTwkSTYOklWnvHp2ke7HrIcetXRVejvkN/fWEkZvi9PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuNbbQGK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuNbbQGK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b80fed1505so4421248b3a.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885580; x=1766490380; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=AuNbbQGKpnfNwpzWAtQYdOo1p7FgAo7wARvgkZMvKHOMOn+w1RHF+xmEngAEo+8xB+
         LlxxpsZMfGyNd8vNVTmflEXXWOYW56jt7mGjHg5yaAnhlevAwf3xXP5C7lkD/tgyY8M/
         Vp6ov3ScWbyEMCNBu4rvlUkvIrlUIZy0UickXkLjyQmQjoG+dyMhp4r8xpRpDV1aU7gQ
         R9IMWYx4ZcZvfIDJEtPFAJVpi/H9ZFJinhoXc+ht2pprH+cfBguJ+CHaJ25GhH05bXdZ
         EOX18ZSdxvCKR84a8Y6Wt2LkpFfVJ2nWApwK7LKb6tsFYZmwEj8xQXXdI4VFNpns5+XC
         GZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885580; x=1766490380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+gahIf3OI+po5aM7+4m/0772/i2Gf2zNdbfP4SS9mU=;
        b=LiuCzkw44ru/llc0KCbBthGdWkKRpqxWQkoQaNtAAvvoI+UXjthCnlzgeWw/EGRCHD
         6qhhfv1gZr4LxRH1G6dw4bFj/fV7zfK6DmW1Wf9mustBxjmkMZgT0uu6xFH6TxoQoMEu
         XmFevkiUOuEElPTq7/Go+jn3XLv/mOaEdsFx4OcbaJRWd+DSDKtBCkhiV+caCKK5xX5r
         5BHLvY9UMWtwvYOXmq6eimLwPF606qRpsIw8qqZGhHM/PqqbMC4MCRyVlv1CsmxscQCz
         jFqVERnd3hHNCkwJ+Ccz71RGa8RMqPS4N0BzRZiRZsG3FAZ15/2z5fjK0FEET4fYdnJ5
         5fdQ==
X-Gm-Message-State: AOJu0YyStboxb4Nx0cZ1eCLTfWUJAXmxdywPVCymuTzmLPLGnmBjQI4c
	WtbJulMTTrUjqr3dLM7XFDrHRuqT/0e2WeL6CvxAJyb6ee9/KKkxpIZ/6FkCNw==
X-Gm-Gg: AY/fxX6bBAdGfVPP2F2foTC/oQCnyv+Qr9fr6O5Zy3j4nft+st3w7J2NdzBJInr4bFJ
	8yVxyaGvv3LHFDc/kK5zrAKxpoUkY0KYZxP56P0ozhkVSu81/B5x7xKPWsy7bIHmrdcS4j7mwlx
	AzOFAB/demfLYXAHqjsJxG6yOTfeC1Ermo9Zf8xLi38TZaOxjbYpmQxg8KP0/O2f3qD9aNiCEyU
	Oa4y1knz3gsebdUpxV4VO/F4wRy+8vYqR9UP1483UNj0lgz0sfmtIdkh7aA6x6aB3SknLxuBkE8
	biCzfqV74Yg9eb680leAR00zkSEdKK7hxnk2S5A6vSvknDYqNstRpy7PdTfP1vU05SH1hFTDGQP
	tMKgiuVz9wcUMxmj+S9HKyN/81YHPUToNMQNnbyvH6buWTfMuV0yWRiT1yZxXHki0vWgj8CvSFj
	dCa2UTvpOKx9IF
X-Google-Smtp-Source: AGHT+IG0xLlKlsCBsGb1JHPs/sCWom87e702SNfy3FXtvDgoxCRuGdMrn8Sx2rFJnGTrxW7KWbnNOg==
X-Received: by 2002:a05:701a:c96d:b0:119:e56b:957b with SMTP id a92af1059eb24-11f3487876amr9158500c88.0.1765885580301;
        Tue, 16 Dec 2025 03:46:20 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm53088728c88.2.2025.12.16.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:19 -0800 (PST)
Message-Id: <2d329837e34a88cfe28be728fe24bb5a2c6a9752.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:08 +0000
Subject: [PATCH v3 01/10] t9700: accommodate for Windows paths
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

