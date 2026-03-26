Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFD2116F4
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529152; cv=none; b=pqnflMNsbFOpCz1CAlv0R+FSdloEz9pYWlm8wqb4DkRW9eVaJi1PuApCiQDMoUCzBtpDjn3gAOjF6/ttTJD5F9tnOcLCc5X5y58oTyZbcOhfVQ3zl6wj4OrMJCBZwxBsmf7yIiOTbeEGgLMCkykQiggqYDrznGALZPqmynvRBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529152; c=relaxed/simple;
	bh=FIdHZ68tXmLQcIGnDbH1XMkVBfrnw1hgiBTBGwUeypE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ncBjpBlXQfjKsr9MrAk4U51QByZhT5iX5DYsejLyaIRawzJN2sXfMp3rxtLHyZqY6NYPcZN00PzxQ0bIPFcu7nSaQNMHCluQuucwQta/LA6GQgAknipidmx0WSqogMRZxKCB2Rp9VQBCAA9G8sUfo8m3nE3a8LbwkdFzGid5ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRDWOGXW; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRDWOGXW"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c175635a33so400335eec.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774529150; x=1775133950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ny0kHt3mmsV2rjY1iuDKl/sWdLkixOX5A86Z2/VLsak=;
        b=XRDWOGXWKIfl6ig/4Fi/s/TNxJ6PUMH061lie938PuH4LlfGzJt/1ZEJ6HizUbb8kJ
         g2eWmw+pzHGVmfY2t4nw0KXNbZpqqIZram5gsgy7ubhutjk1YUmn/MYtGzKpeduOIAqt
         HETzvdr32BcBWTKzLuQuIpGidp2MHBrjEAGZX7WA303OleWAwk8vlWwn/www+dBq0MU6
         2raObsHB1lJpCROTMO9CeVGSlSuFdCk70rO0DnuU3D+Mklyq/HrtXmxMMndzjYrFUMpx
         ulNLhuNyQ7Zq4XJ1VwUcak2LL7rGZSWxQ9xmj53zVoYgp8dQ8gVIEGNFcZMl2X61Jx8f
         aJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529150; x=1775133950;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny0kHt3mmsV2rjY1iuDKl/sWdLkixOX5A86Z2/VLsak=;
        b=oPelte34OvkHEPgeV79IlZMThNBrx3GSLnCkMA/e8EHf+VYkcaHaOnLzoV8oYvTJ3c
         5IC9dFaADjeNL4TtkWTny7b3WZ7UM8f7e9yWChZYU5cEJDI5d2yI2Bp1GKZmh8LxPfd3
         YrN/MvDxced4njrR4u44NSfgUckJwYQjApBn+3rEz9cs4JAIYne7wl3EtF/0nW8a4ZuM
         wehZO7WFhrU9InqE1KdCFFmTj6HEo4zMCk/m+NisQMUwY449ZxCm0j8yZ142vfZuxZ3q
         8vMKYb2QYenxRPSpChqqPyL1Pojdghhin8+8kI4leGt7Kf9ueqb+3rf8vJQUb/EfXZRD
         D2lA==
X-Gm-Message-State: AOJu0YwrGnWEdUECLFE491K8mdJTHsUrPN8JIZG8F5tJovoiD6lOYtgo
	XUkD0ZLPU2iieGnuMiHn+qDGoiyenkwcY/lfBh8uQXtvGzczsYtJA87fm68L3A==
X-Gm-Gg: ATEYQzynPUlj79D3kjEqi/YwyAhcTFUZLJAvzdUxw8Skb+lf26MQH3o1nmfcmsQFQ9j
	8DeyXVlU0N+zE8Zr0dqpqk0v8AkqJJuVh15r/7TE1S7OssIBJGXaZzdW1JwDcR5vIB7A6fdeCy1
	S8+3SCt6JN7mCVLUDCbHLHbO8TRDfri22kmScxIuzP1ZduES7sWyFN/n7tAan2JfbzZ0JYBoz2b
	iq1H2NQju1eaFdiztfJGoTZQWcxVD6POQiOF2TsHLvP27tJ13/W9kFLEl8yEpRLfZjplC0UNOB+
	nv/3SH+MvdxTdtvvNxdmzVPS4YzRHZfOocXkMjTZ0azz2iRjoISJMuzLOHnvlBRtCb5UVMD8QRg
	5LTZlLeQ7GSGwDFwPzTVfF37ZjqTMbYrryOlW3wrfUpgzYSSYD38EBZSx10YycMXfrwujJkOB2g
	1L/tATAmO3LFRdjfJdlQmTO6DFlQ==
X-Received: by 2002:a05:7301:6794:b0:2ba:6c66:1f0d with SMTP id 5a478bee46e88-2c15d2a1f45mr3788490eec.14.1774529149686;
        Thu, 26 Mar 2026 05:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0458sm2419178eec.21.2026.03.26.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:45:49 -0700 (PDT)
Message-Id: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
From: "Quentin Bernet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 12:45:48 +0000
Subject: [PATCH] docs: fix git stash grammar
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
Cc: Quentin Bernet <quentin.bernet@bluewin.ch>,
    Quentin Bernet <quentin.bernet@bluewin.ch>

From: Quentin Bernet <quentin.bernet@bluewin.ch>

Grammar incorrectly did not include `git stash -m`
and other valid `git stash push` flags

Signed-off-by: Quentin Bernet <quentin.bernet@bluewin.ch>
---
    Fix git stash grammar

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2255%2FSporarum%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2255/Sporarum/patch-1-v1
Pull-Request: https://github.com/git/git/pull/2255

 Documentation/git-stash.adoc | 4 ++--
 builtin/stash.c              | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..41086c21a4 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -14,10 +14,10 @@ git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
 git stash apply [--index] [-q | --quiet] [<stash>]
 git stash branch <branchname> [<stash>]
-git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	     [--] [<pathspec>...]]
+	     [--] [<pathspec>...]
 git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
            [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..0d27b2fb1f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -50,10 +50,10 @@
 #define BUILTIN_STASH_STORE_USAGE \
 	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>")
 #define BUILTIN_STASH_PUSH_USAGE \
-	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
+	N_("git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n" \
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n" \
-	   "          [--] [<pathspec>...]]")
+	   "          [--] [<pathspec>...]")
 #define BUILTIN_STASH_SAVE_USAGE \
 	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")

base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
-- 
gitgitgadget
