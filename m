Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188498;
	b=vesFc/S/T3u9lyf25pwhtSfgyCrOtVm7NdE7ern6rESzFaqioZk+VHDdkHaKHZAHZNUo
	 k0tRwWKmc5zcMvPgjKEpex6HBwljVLkFdAxZKl4s3twp2cGTkpUKEfVlMTKitWoU43OLV
	 3y7H/l2pmitFca6HlVikABP/cH6qWx9HWFWKs85md82X7R+RRYjc8OOY3t5AOjyU5N3eX
	 2qMsl0g6Mx0GQrEaACimNsonnN3/v+XDb+Qyq5oUuyhw17Z2e7kBuBrKn+9A+FKSSyFj0
	 Nhj5f6N4P9bKWeZZIAnbvT54AaUbT2+OQiIJK24oJDMMPCoXUOuiBClv/1xiAmRbFtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEC5kirNIgLEDf4gWTpbKQC/wyU3qjNcHLK/jX+/muA=;
	b=ZVugalNSevnwS2aICPKJTjHytdTCBykyz2QnoTD42sgSOAl+tNjZCYry92+k10IMdRuc
	 UHVl4pVE4oW6tLxoeby5Rqub+bhfBZBNbhrl7z4T7YQTCrCXXtt/APg2q5h02wJkeZK0b
	 Jw4Rz1qQpaUQlLsHMeGganYXfP0AatuvaYyCKeuJ+jlvorJFyi/fXPCaK3PlSKmZ8UMK3
	 IdZMQkP0Z0xo3W0qm2gTQ3CyJ+cgNMp0TkeZKips+sMEaLi3UPsVZPqYYf2cQJAzE1Qfk
	 Bax4VC33L+h0CPMp9kq1V95r14VVI2VBi4M2Okvf6hkLqsGGIBsa2qlduATz7M6PoBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZHxVx1u;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B497606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B497606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZHxVx1u
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so577574c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188498; x=1793793298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEC5kirNIgLEDf4gWTpbKQC/wyU3qjNcHLK/jX+/muA=;
        b=wZHxVx1uIVqopsUKyNGXZ1LeWyElpby0b6jNGEBxvTQhxIc7u96REpLGOcJxfV8exp
         S6nhoEdoyVM6LFZ4XpI8bv2q/GdBK5ONGHMl+1ndySzvNdJ41eJ8fdCAWNbgbc7Azm6a
         Gz0Y+uoBy5wZ3zDsHVLKRa0ntzh6IZJUzt7QWOCSabkeX5n5gGZSgKP8wOko6jnYA8Dz
         w8na9yakCEcDR7XQzdXhlkVobi97z17b0M6PK1kuljW1yC88X4MrFNP8EcA/kzDyn7/9
         0lCSQ9ftzGtdlv5jVDYCiO3fMtpQMCwuF0K20WPSXuPAqENV4VMIqry517DhpWl34ykC
         1SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188498; x=1793793298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEC5kirNIgLEDf4gWTpbKQC/wyU3qjNcHLK/jX+/muA=;
        b=hbBwAs1BSmAUabSNwvvnN2zIXwdLCd2azjRROlSDdKAfP65KqIhLJq9f1ZMUY859WM
         V6+EOiUVdfJZuAzcQHO6qXuBMAP+igLMbpLT/E72p7oaor1GhG07TJ1uEYP6qRt6xEt9
         ysruYrpbFo5XHJig+Ve0vXVxkHVPC4wX0EpdMZCJUX2D6wkaJpzj+aeHMrxHfOM+VcNV
         XzmR3bNnNQ6QNbrsjUqQFou/xgKVxQkR9LFaoUj6P7pBl7gJeG6f8yHiNNXC5RcBJB+k
         gqVle7w6L9wdqLFaATsuHhQmJOM61F1SRT/Yx6gJdbL697ESNPmHrAF/AHLynuHjj2Ao
         KvaA==
X-Gm-Message-State: AFq9FYIWSBA1N3Bh4j3RTOKRZcVM1/tlOOma1oYlO1PMNSLfc55QRgeA
	fTniKXaJcdXAH8b/pJ+JDhhjPrtIxhPdT2BwSn/Q3+4FxzPUGHEyH+ORheuplg==
X-Gm-Gg: AYBFou07GVlnctzo/hOhjHSY8if5wq7zS9eSfSbNVVNtVC88HI9s2tOLGpHRnYV1m8p
	ZtMsXbA2X/eg16gatv9T4nbrGez82dPbRIOmAgJL9talvFxaxBf5ufY696nMF3RAFubQWb6uAW/
	B0C0Q8OjcVTmAME8+4U9UU3UHzqpVi9BjFPnSv2xrNap3yZqz7TQTLKGwJlJGAZb+DFTadoizN/
	YfVCzZDO3o5OGsVcVPPvrXNnrCfLhjxMpI2NuZt0ET7PUA/5LibEbtt54v43+E98fB/uAgy4nSa
	uYCEItYzKL/0FRwr7NNS6JVMGPQBPI+7Wv2LTYuR08VDx73Kh48hwTNu0Of+HIi4dXTJmglXmkl
	9kz6ZOBD4MlBr3xN8RAJcJ9+V0sENsKqM7wSNSp6GYLqBH2Ad/XjT3R37ldM/bNVVEH0+NCTg5D
	nYfxV12XSnQ0FWUnzisvjuavIJZ2F/WkQgiJM2P6/NRdJZzun2P7PbLiaTnRlWQb5k3Yv3ERzQ8
	1uFf8ktcos1win6WGMHw5wZNf1ib/PGaYnh1c8iiBjn7mkMSHLbCgNan7gLAIY1yr/uJ9pUeHaf
	ym8VQLA2GrK4bi4bzi7dljiu3jbfun2k17rbsYuTefOgEpv3isX1FvAqHA==
X-Received: by 2002:a05:701b:4511:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-1a6cc819e39mr3091707c88.19.1793188497539;
        Wed, 28 Oct 2026 04:54:57 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:54:57 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/5] setup: provide hint about the source of the explicit git directory
Date: Wed, 28 Oct 2026 17:24:01 +0530
Message-ID: <20261028115412.169748-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git directories can be specified explicitly by setting the GIT_DIR
environment variable or by passing --git-dir / --bare before a
sub-command. When discovery fails in these cases, the error message
that we print is a bit unhelpful. This is especially more pronounced
when someone sets GIT_DIR and forgets about it.

  $ cd /srv/git
  $ export GIT_DIR=project.git    # saves typing --git-dir on every command
  $ git log --oneline -3
  $ git for-each-ref --sort=-committerdate refs/heads | head
  $ cd ~/src/myproject            # later, same terminal
  $ git status
  fatal: not a git repository: 'project.git'

The blunt message does not help the user understand where 'project.git'
came from. They are on their own in figuring this out.

Improve this error reporting UX by giving an additional hint to the
user that the path comes via GIT_DIR. With this, the user would see
the more helpful hint:

  ...
  $ cd ~/src/myproject            # later, same terminal
  $ git status
  fatal: not a git repository: 'project.git'
  this path was taken from $GIT_DIR (which can also be set with --git-dir or --bare)

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c                       | 8 +++++++-
 t/t0009-git-dir-validation.sh | 6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 4789b2d79d..8f6b609240 100644
--- a/setup.c
+++ b/setup.c
@@ -1152,7 +1152,13 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 			*nongit_ok = 1;
 			goto out;
 		}
-		die(_("not a git repository: '%s'"), gitdirenv);
+		/*
+		 * TRANSLATORS: The first %s is a path, the second %s is the
+		 * name of the environment variable it was taken from.
+		 */
+		die(_("not a git repository: '%s'\n"
+		      "this path was taken from $%s (which can also be set with --git-dir or --bare)"),
+		    gitdirenv, GIT_DIR_ENVIRONMENT);
 	}
 
 	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index bc607e6c2a..fed1b045bb 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -78,13 +78,15 @@ test_expect_success 'setup: --git-dir pointing to an invalid directory is reject
 	test_when_finished "rm -rf parent/empty-dir" &&
 	mkdir -p parent/empty-dir &&
 	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
-	test_grep "not a git repository" stderr
+	test_grep "not a git repository" stderr &&
+	test_grep "taken from \$GIT_DIR" stderr
 '
 
 test_expect_success 'setup: discovery fails when GIT_DIR points to an invalid directory' '
 	test_must_fail env GIT_DIR="/path/to/does-not-exist" \
 		git rev-parse --is-bare-repository 2>stderr &&
-	test_grep "not a git repository" stderr
+	test_grep "not a git repository" stderr &&
+	test_grep "taken from \$GIT_DIR" stderr
 '
 
 test_expect_success 'setup: command that does not need a repository stays silent for invalid GIT_DIR' '
-- 
2.55.0.1003.g10538fe699

