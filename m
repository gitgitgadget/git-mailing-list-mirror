Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31911F3D54
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267594; cv=none; b=ZIaV1t77Sez2wuG9isuugzq3UwEtK8L0bmAIlMn8omsZ+n+gB5PTgoHio9i3BC9YSm1FXvGX0XNcbl8+TO/RMlkMB38HJGAy/UEn7t+2Ly67grOBUgs9OdE/2JaIsktmBq96hVZJOuBX2yWiNaCeCnP7Wi/V+CQwXHmGhcp5v7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267594; c=relaxed/simple;
	bh=IpX3mveEWecY+usvP8ItYSttanYy8g+BPMARo+VKiuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNp9jtbDwCNwdzsQg1nW4xZu31ECkknklDhpppe/A2Ifl4/DLd5/5xrp3ItiovnrvpasTcb2MnuCu9BTjpjSExJCPzkCLD4JkJo96OqaB6JCErB1OiXEviAXNQMzCBrNETw7wTowaSenAts/b98v6lkH5AKflbQY0NJSzQOCMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuG0RnnS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuG0RnnS"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb9101419cso7877895b6e.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267582; x=1736872382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45Gqe4OnDOo4oUTO5M+4VaKgUfDz5ULVrhgRc8KQqn8=;
        b=RuG0RnnSyzRkEdKclJOAwNVfcV+zQkWN0GLiR16hHwufq2wI3PqMd3hOFWqCW0EZlK
         pgsjtsTjGUdZspfDRbDD9pYpr/7Gp7jXEtILIs/6TrM5h6vGjocwrwYfFv919VM9usW+
         2zR1Msba6v9IMTFlzxVahdo9orkJrluXrA+AmfbmBSnDmVwrgEM/+8uk0dLZQFHnurr7
         8bl8mlbB/KkvUjok2hQVydGWyyB8vcdCileH5aQSrjlTFRvCMOX4HdTGmFuMXjRF0Qg7
         FiJko/2K6TNeMEunrE4gnOSrKQTCMZv3VJnlQeOshvB+xYfc52lD2t36iVf9gPqFazAF
         WVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267582; x=1736872382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45Gqe4OnDOo4oUTO5M+4VaKgUfDz5ULVrhgRc8KQqn8=;
        b=OO3qsbchXLOasCt2cXopowZ1mVgwF/x5OZa0s1RT39c1gPBVEzUYHuQlvAq6P/5ftp
         ov/Q1ckMlC8G8NVxBnEBOI9sLWFwigOhRb9sTO7C6xYx5B/lxjJtWOJCdorbvGOHuxr4
         n64APuHyufuZweC1hd1QFuujMaMWP2sN2BvAC6LMbOUXPetV9BeqnohSX338EyAS1nOs
         lovjt8VFgusOk3PqAUr1411lBvbhsEzL11aEQ8o+JuhwRHHNgqF7y8pOL+qW5vR6mXyz
         gDBg4bEIAHhBNh4NBXoEK6FrTF5F0yRAzr15feVVrO36oU1SlnBNtRWaPiDOWUty/F5o
         ekPg==
X-Gm-Message-State: AOJu0YxkTLx8NxUr0orifjM5zprjpvlYirZUvyTXf1lHFg5Swc12u3Va
	igBiTYeKzzCgUlTT0z/z5CQhKOE+Vx+N69cAFYYcQ7821Z7kYiU8lPqNNg==
X-Gm-Gg: ASbGncs7xXz8XbrJ9CRnM85E8xUm7tPkyEf67kbD+Sz5HmmqXkZUCIvY3vTmswX+qhG
	I4Sh9qrjnmX1BXsNGmyY+nE8lAEM8Bfy5eQhB9fkYu6E63Lbnr1XnK9CUVW5G56vshtGDd0LteG
	c6uajtPrEZ90DcJRwPiqRNQUvkKZfnkUJSVUNrWfl1Ep8v5nk831zsdZHjDP/xJuQgvIQuHbVFt
	rpPldW9ZojVLb2iHdWOaPiPUBl9btxu8mX/XivZXnQ6s1AmWRlj7Zq47TeTheZB
X-Google-Smtp-Source: AGHT+IFZ3ow9p5xldyyYg9BFhLXeIvx2FyMKVCnzb5uawuO4eZ+fj+eq1RwMvqy5djzEUlgenXYt4Q==
X-Received: by 2002:a05:6808:1483:b0:3ea:4aad:a889 with SMTP id 5614622812f47-3ed8907bd78mr38520406b6e.26.1736267581964;
        Tue, 07 Jan 2025 08:33:01 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece24827d5sm10449176b6e.17.2025.01.07.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:33:01 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] fsck: reject misconfigured fsck.skipList
Date: Tue,  7 Jan 2025 10:29:15 -0600
Message-ID: <20250107162914.3756968-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Git, fsck operations can ignore known broken objects via the
`fsck.skipList` configuration. This option expects a path to a file with
the list of object names. When the configuration is specified without a
path, an error message is printed, but the command continues as if the
configuration was not set. Configuring `fsck.skipList` without a value
is a misconfiguration so config parsing should be more strict and reject
it.

Update `git_fsck_config()` to no longer ignore misconfiguration of
`fsck.skipList`. The same behavior is also present for
`fetch.fsck.skipList` and `receive.fsck.skipList` so the configuration
parsers for these are updated to ensure the related operations remain
consistent.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
This patch is a follow up to previous discussion in [1] regarding how a
misconfigured `fsck.skipList` without a path is handled.

Thanks,
-Justin

[1]: <xmqqy10w9x0m.fsf@gitster.g>
---
 builtin/receive-pack.c          |  2 +-
 fetch-pack.c                    |  2 +-
 fsck.c                          |  2 +-
 t/t5504-fetch-receive-strict.sh | 10 ++++++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c2e9103f11..0158faf537 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -174,7 +174,7 @@ static int receive_pack_config(const char *var, const char *value,
 		char *path;
 
 		if (git_config_pathname(&path, var, value))
-			return 1;
+			return -1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
 		free(path);
diff --git a/fetch-pack.c b/fetch-pack.c
index 3a227721ed..055e8c3643 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1867,7 +1867,7 @@ int fetch_pack_fsck_config(const char *var, const char *value,
 		char *path ;
 
 		if (git_config_pathname(&path, var, value))
-			return 0;
+			return -1;
 		strbuf_addf(msg_types, "%cskiplist=%s",
 			msg_types->len ? ',' : '=', path);
 		free(path);
diff --git a/fsck.c b/fsck.c
index 87ce999a49..9fc4c25ffd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1353,7 +1353,7 @@ int git_fsck_config(const char *var, const char *value,
 		struct strbuf sb = STRBUF_INIT;
 
 		if (git_config_pathname(&path, var, value))
-			return 1;
+			return -1;
 		strbuf_addf(&sb, "skiplist=%s", path);
 		free(path);
 		fsck_set_msg_types(options, sb.buf);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 8212a70be8..e273ab29c7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -167,6 +167,8 @@ test_expect_success 'fsck with unsorted skipList' '
 
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
+	test_must_fail git -c fsck.skipList -c fsck.missingEmail=ignore fsck 2>err &&
+	test_grep "unable to parse '\'fsck.skiplist\'' from command-line config" err &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
 	test_grep "could not open.*: does-not-exist" err &&
 	test_must_fail git -c fsck.skipList=.git/config -c fsck.missingEmail=ignore fsck 2>err &&
@@ -213,6 +215,11 @@ test_expect_success 'fsck with exhaustive accepted skipList input (various types
 	test_must_be_empty err
 '
 
+test_expect_success 'receive-pack with missing receive.fsck.skipList path' '
+	test_must_fail git -c receive.fsck.skipList receive-pack dst 2>err &&
+	test_grep "unable to parse '\'receive.fsck.skiplist\'' from command-line config" err
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
@@ -255,6 +262,9 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 
 	# Invalid and/or bogus skipList input
+	test_must_fail git --git-dir=dst/.git -c fetch.fsck.skipList fetch \
+		"file://$(pwd)" $refspec 2>err &&
+	test_grep "unable to parse '\'fetch.fsck.skiplist\'' from command-line config" err &&
 	git --git-dir=dst/.git config fetch.fsck.skipList /dev/null &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 	git --git-dir=dst/.git config fetch.fsck.skipList does-not-exist &&

base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.47.1

