Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AE3A6EE8
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259663; cv=none; b=CQnNOuHI5HRlmRl5p9eKNHBGp6fLFVOFk0sYQhOoxEGj5sbm2+TAjix7QVpgjweoG0AsVL25sLylEzMRPTAnfH44UtwT9DfZcTyljmzS6KX+SsKwbA5W/JehsYSy65PLV4kFBdsJbGqanK8tvU6uGv0t0fabwRvR9zYIC4gcz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259663; c=relaxed/simple;
	bh=+0VeIHqwzwZmptq94LAw7RIKI8hY/dS2wdaSgzM96nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A9Vnha/bmwaPKT9wj7qoFKHzNESUTdmap05AVknfCrCCWrNnsrpKZxFxl2v1Av2UNMtCclJOSLxbQOu4aYNjvIUrJln1v3mklkZKwojoLpunfHaM/xretObtN+dD2TGQe0Z20fZzQy3/I2Pp50CQZF1XOmeHEkz3Uw8AT4ViEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze47mIWU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze47mIWU"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d933da14f0so719039385a.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259661; x=1776864461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6J2UP+JFyOl8pGid9gElHAR0aN/3eruWN5LN76LVLk=;
        b=Ze47mIWUNZbfAYbw9HjQ0HuUPUgGUXuLvXXFdX1JejZpLi4/xrCyYG04eTRZARj8Ox
         FZZmyxeWwc+uiurkongOw8bRrngv48OiTCwEALfZAZ2Bgq0j0D7wNrwEIab4s5LsVRhg
         EhAlqZMeErngOE35ICHcNQLzXoeFhlPtvP14AY9nKKBW3w98n8cUWDDKkhf6QxcxS5lx
         BlrsgpOfTWjEe/+ITYWL5qFvRIVKf1jsLsHfI7hPb4GK/qSYOqHJ7JAsdp65ackeX5Yo
         P2pgdkACs1cTur921UYpwA2BwBL9OskGofVKT45OXVBPi0Te117mplfvYTcgahmLa2hG
         5EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259661; x=1776864461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6J2UP+JFyOl8pGid9gElHAR0aN/3eruWN5LN76LVLk=;
        b=BOcwCYh6xcSaGCDL67okH8/MTa50/3gT4pMz81A01vrLwGdZPamSMdIImLod0FdGRY
         unoqp3RAobX76kwZSIdbkXBCZ1ZKOlWlvgZ2HqqmCjLgOL9XfiZzowy0jIBl71rxfkR3
         Dmsa7pErNS4ykSg5JdPQOBezkJfZ6fdzTXpHMijeI/YSFVeFRSg1uKNA/aEK64pI5ZW/
         fZqNEj5nXblMowUpwoFribX90vw9uTpjdjmK1mqKBLXTwy5ojWWbek6Io0SuYVD+NfWb
         EjPSGBPr43MKA+tdK/d5h1LM72r9Rcspdywkeuack845xL8U+F5ONYxywcrovXTWrZZt
         Dt3w==
X-Gm-Message-State: AOJu0YxmLI8S9RlAlKVtZZRZ8o6epQ0GOUp5hKr6eYUS2li0XO0ALZXj
	s62rosUqyUB1QDJW4iCeHw/xvkVCyEVNfbnSm5L9xSkbGQtV8rf7O83S8cCRoQ==
X-Gm-Gg: AeBDiesCVxFQnS077mEQoVZjTx+WkDcbS0pAAhhOmc43QXjWQcOt+9Ue8t3iVOFObKe
	9STI2DkIhTlnHj3jFk1wx7AUB5am3Cos0VIYFKuHJTlZTx6vgTyhtEtYVRFfihf0c6YY0ohxVvK
	b2925aijmdkc1lvwLEkRX/2OSFqxuJClc7opm7akeJMov1ZlH+HhpiBY+SbV+Yh450Gd2zphz3s
	FleNaRdYoRA0/pgfrqNlsCEGCjqf3CQrtwy0vq7Kw7RzEg1n6aKFtbM1zpuk95G21hj9GTUVff3
	uwSOXF+2taKJ/h/inf1skv55Bb+foO5bI70z+b8oQNqwIPOzWZpfIS49FQOXaGReQR4m6BoCgos
	+oLq5OP6KSRk7EXa6EEmcVwxahiZNXsL1iWWgCCFCHt+/AHCasXchL4+b0F12HfUh23sq4gx7Vq
	SG4cJz+tckwTer1CsCXkWB9YM1Sw==
X-Received: by 2002:a05:620a:4081:b0:8c7:c25:9e69 with SMTP id af79cd13be357-8ddd069727emr2964050585a.66.1776259660562;
        Wed, 15 Apr 2026 06:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f243f1fbsm111978585a.31.2026.04.15.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:39 -0700 (PDT)
Message-Id: <721a95142337db84209fdfe76b2fe34c98ed34ee.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:25 +0000
Subject: [PATCH v15 01/13] t9210, t9211: disable GIT_TEST_SPLIT_INDEX for
 scalar clone tests
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

index.skipHash (Scalar default) and split-index are incompatible:
the shared index gets a null OID when skipHash skips computing the
hash, and the null OID causes the shared index to not be loaded on
re-read.  This triggers a BUG assertion in fsmonitor when the
fsmonitor_dirty bitmap references more entries than the (now empty)
index has.

Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
this: tests 12, 13, and 22 in t9210 (matching the existing
workaround in test 16), and all of t9211 (every test does scalar
clone).

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 t/t9210-scalar.sh       | 6 ++++++
 t/t9211-scalar-clone.sh | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..f2a6df77ce 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -152,6 +152,10 @@ test_expect_success 'set up repository to clone' '
 '
 
 test_expect_success 'scalar clone' '
+	# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+	# incompatible: the shared index gets a null OID and fails to
+	# load on re-read.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -182,6 +186,7 @@ test_expect_success 'scalar clone' '
 '
 
 test_expect_success 'scalar clone --no-... opts' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	# Note: redirect stderr always to avoid having a verbose test
 	# run result in a difference in the --[no-]progress option.
 	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
@@ -307,6 +312,7 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index bfbf22a462..2043f48a1a 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -8,6 +8,11 @@ test_description='test the `scalar clone` subcommand'
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
 
+# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+# incompatible: the shared index gets a null OID and fails to
+# load on re-read.  Every test here uses scalar clone.
+sane_unset GIT_TEST_SPLIT_INDEX
+
 test_expect_success 'set up repository to clone' '
 	rm -rf .git &&
 	git init to-clone &&
-- 
gitgitgadget

