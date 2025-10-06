Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538421E0AF
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750543; cv=none; b=sCvhMxRGsbL87j58SD1w85fQKTjub8groQZbKqvc8Vtz32m9Mdsg4n30wBoPC0Yj8ympENzBUVtOk2bxTZuropq/CLA7OE5MOfEBSux5qlA0LsKG5mMJKbPX73Dg5EXIlBaVtR1Hr6UbgXFJ3sFrvaEfddgNbQYvYlpCakl9aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750543; c=relaxed/simple;
	bh=TLhH9bIUTp3Z8LQH9GiwLX1W+npC6qwfLBSwvDcpPx4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tlrVrhiPhHks0MXWYYYtjQF8r6BZXxawG9ZNX8znJD7IPTzLqcyebGlIPcvDS61ibGGMnjma4N2z+RIR6VmGXqeqNFaYwIH0qNMuQx8Ym3MEUJ6ErgS4WodM2/xqnmPNElJWd9DhDf3jmCT28FMntUdI25aaCgoWy7gCSvjXpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa72QVmL; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa72QVmL"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-92aee734585so184858339f.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759750541; x=1760355341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=60+AYGipJSXKHrCUg9zKjfc4wXNkBSoQb12EtGKq4zs=;
        b=fa72QVmLXVsLYRa9k7NnkzB+mi2iW3hrPK64JSxNZdRoUHd5gYFbyuQQQsFEaO7mI2
         S8ihZa/H0/FEXN2+YWHdHZNBEu5BLCKZpimhSSSyx9Kp+YxhJFb4UV57WxFUy5r9W0Yl
         lyK3k8CsxwIHPkAw57LIeZ2gdXwtqcqOlETQYwxuYqogsLHjPVjLwTXyO1GOz3HHpMXB
         RM3q/bBTavN1zmRRw51etYcxwukqYuQ3QID10pHm0Izd5WwWbgboG7SKBMyH90Wj16GC
         8D+ZiXCLzIe3N9nuC9Pxyk7wdIU9z7sZB2mrL+jEr6TrpedbvK5pm/hFsJ1OV1yVbjJj
         NdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750541; x=1760355341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60+AYGipJSXKHrCUg9zKjfc4wXNkBSoQb12EtGKq4zs=;
        b=aIXn6ihqVu8Crusp/hX73jCRhxOr9cbfFNUQ/ls9CsGFUA+mQLj/IBntrCtnAhPkFH
         OuFOXuNyB+MGJhrn1/y16XgnQkcyWcshqiA7SfO+fWSK5h/O8EE5hLzYixYLs7S3mMqF
         ISU/yOERwrOA868g5q0GS67L/0ZrS1IqSH7ReKpVpOrZZ5Fk1OtG2GnxcIMe344Ixf0n
         /IaOs7Bn4rh0YwEDZmAvwFR0vx56KFcgn6aTCNVhqFfN3eXPVlfez66xTFUc0B2llZQq
         tUVh67E+Uf4t1mzb0iiW2DaPNCbXoRCS27lcJIRoBtqk3/JBmV/4GJQcUkzKRTrz1jFo
         QFmw==
X-Gm-Message-State: AOJu0Yyvk1m/goas281nenxrPxtQwxzudvmm5xSr5wq4ZYzY3zSTOZcH
	Fr1K7ntFjxNPXMj5i1WYULxsSpKedo7RoC2iso6fAxkW/W2X7gLHeFPRl9dt6Q==
X-Gm-Gg: ASbGnct8ucfkMucjAb9egDf6D9J4Xmz+3hzVuEsmPTrb+4uQxlKclbXsuoaOSw3Htgc
	hgMaUNmYhEUCkzTwFdyKzQrXyVAvp9/gFFvzGc9o2yE92rysxMiFSpHe124swilwziYyFce+EXH
	Kjs4nu+Bd8JIb97N/p29z8q46fRjKzMGFswgBJ48XXBh3D+vOfV+hfo4Q4CMjESP3afTTLwH3Fr
	6vpM7M257DLxCpOwJrJSzSiHHUBWwkdRsj3n+aknluZhkP8pQLmMZDT7JbmRR/QwXwYLKBbvhES
	bPdDi9iWIPUPJfEpL2hdUR8ZSkJ+IIbepaAkQh44ea3+SlX4EYGUBXiydDhqB/6Fvsa6L3Z/xmg
	1czaaoLSo3fMDKyXTwyUW5QMeXMxCkpcctFw4uTNsh3ZvhU2Cmjc=
X-Google-Smtp-Source: AGHT+IE2eExViK+OxQc7OL2YWhgKeybdWNr8BYU4sbYKdvoHRbCHxaKXzdEf7n61NHoYQVjuTcyUDw==
X-Received: by 2002:a05:6e02:1527:b0:42e:7426:7cca with SMTP id e9e14a558f8ab-42e7acd27edmr142637785ab.7.1759750540774;
        Mon, 06 Oct 2025 04:35:40 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.208.147])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea300f7sm4755860173.16.2025.10.06.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:35:40 -0700 (PDT)
Message-Id: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
From: "Miroma via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 11:35:39 +0000
Subject: [PATCH] stash: don't show irrelevant entry count in status
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
Cc: Miroma <its.miroma@proton.me>,
    Miroma <its.miroma@proton.me>

From: Miroma <its.miroma@proton.me>

Currently, when status.showStash is set, 'stash pop' shows the
following, confusing, output:

    ...
    Your stash currently has 1 entry
    Dropped refs/stash@{0} (abc123...)

Signed-off-by: Miroma <its.miroma@proton.me>
---
    stash: don't show irrelevant entry count in status

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2067%2Fits-miroma%2Fstash-no-status-showStash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2067/its-miroma/stash-no-status-showStash-v1
Pull-Request: https://github.com/git/git/pull/2067

 builtin/stash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1977e50df2..2bd4b7d753 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -705,6 +705,9 @@ restore_untracked:
 			     absolute_path(repo_get_work_tree(the_repository)));
 		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
 			     absolute_path(repo_get_git_dir(the_repository)));
+		strvec_push(&cp.env, "GIT_CONFIG_COUNT=1");
+		strvec_push(&cp.env, "GIT_CONFIG_KEY_0=status.showStash");
+		strvec_push(&cp.env, "GIT_CONFIG_VALUE_0=false");
 		strvec_push(&cp.args, "status");
 		run_command(&cp);
 	}

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
