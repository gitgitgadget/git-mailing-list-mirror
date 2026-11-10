Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296212;
	b=dh8gH/2LaCGiBhfizDkVe6BH8aqI/YwKfTmPfuzYIfpwSRxkuCc2A6om7GlPcYlFNZPJ
	 hnFCjWTd7wyOn8ssdOGrf6fX0IkcVlrOHUzxvD1n9fBIVr9RmIRHeApzsT8xfOtdFYz9D
	 mIcjyaunCNEliDAc6UjSp5f+auvJhXghz3Zsv2aQuSvaek/KczmRyLZ+Vg8QN9ybFuLph
	 k+FdNJF9fgDeTJVBgSDTQ7h6/RUfIubqka2skYctjzLcvwzJBxyE3PH2/ISMe9MuUoF/J
	 TcNWnXVc8vtkiV+zptArryTnFKIuxR1XcxAh3ybeYz1l1ZdiRcfVxjAnfC83jy+KLtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Y1Vi6+4/+Lg+Q276buTFpEMFb1da4YbBlBRL8mNGWzk=;
	b=FPmh/heNENp+YPtrAbhvVNatuG/FEOqdOwKsJyRytwCyAfVQ8DrBlNDwR6jaeeHgrdBv
	 B+yQG2SCnzUGLlPnTpT/ALkkD0KE4qbw5tya7UdgIvbv+m5OaHAuDPTItzED0jTXLLgUT
	 iQQRoEWpKlzvPZgjobYcFzH00q+wZITCGUCre7BC2EwFwF9GcgnIii89ygEtvZpvv8k0r
	 FMuH0SA5Tz39ilm+40PwcPlC9ytNtIPk6BJ1MN1zBgjXbafUBeiT1FTo3A0qDWEyUTfCn
	 /SlF4ZVNKh2usENz2JVUn/9Z4PwHO3oqEt1FwoyXJoNZHol+57N3K31K8CSUFnNrYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzB2LabG;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AF60A262A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9AF60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzB2LabG
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-85d363fb73cso938343a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296211; x=1794901011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y1Vi6+4/+Lg+Q276buTFpEMFb1da4YbBlBRL8mNGWzk=;
        b=uzB2LabGYlgzLmbQEFcbsHKVUs4R4tRQPUjkYyEMvv+YutoQndo/A5+pohdGdjEt/b
         0uKpQkjqiMfZMJAbOP8CUNUaTDPRWKLprgkaL9EZjKSLnWNy88LHgYNsaWsEDLNozBKx
         prDH6WckmqJ3WUY4dCCuDdZW9KzbMu6IC9zMhlruu8IwCAnna7V2I2zqejCbt33aZXUt
         vtcXQP3XnILmmWwWfGGMNb+azgnLEQQlNSAUwQkSU1cCFPIHkw/wPIxbeS5IxnNaCeAV
         ucOqYFZ0ROh92oWjXv/p+yfXnqTZ/pwz9QeJTrIA6folemUGTvrFyQ2eBqtNQsOkdesN
         nkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296211; x=1794901011;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1Vi6+4/+Lg+Q276buTFpEMFb1da4YbBlBRL8mNGWzk=;
        b=wAvkoc9lYuxnN8FSsbB+JtFwqEC1ejPZ3AImztlL6fT0le1+JUUKS9L9JSktjyzYzb
         zRxSu6SL7SjNwuFD2tvIlHK0cqcp5aXatHRYSTccH7ZXSRvOSDXiVExKbkVe3a7t6wE6
         HVM5gnLFi6l7aa2MR2mlbWwSvIVzl76cv7X0D7+hMMekymCRUjVvupf88PATPhaW7cUD
         zHIcFlG1ua9nyB85sZFc4vRU38AnGu04o0AzB0wFmcu4AhnJYF5x9PTOHeXTRWTrPy+F
         n38zw/ShOZfpWvuTMdo2F+RmjhvJ2IouJQXw+1mBHXyWBVrnKf1jRkYdfAfmlYAuYkd/
         NaLg==
X-Gm-Message-State: APuU4Z91L3dAmjlTedAzu95Iq8d9G0pRY1ciN45IXAxMTXDck/0zy8y7
	MYUYwjVgCZZYoDwws8T6eKBVCnkBD7ImM/LemiE83uvvFbY8EMR2iTgN2/Ar/g==
X-Gm-Gg: AYBFou2GoNcBWQOZGKgj2jrW8b9UcKQK31asJ+vKODjI4HjdFEP5AUbfrhvZ+mb8nsX
	od4UBaSFlUL2yi2YikTjN6PtehMDqv+YB089GIIMzAiyx0rSiTAGms1USP776drcKpTmkcMm/J0
	yAGh5tWCvfe66KXxGm7BkFcHMH6Ohpoa2HJgijthR3cFRwjsapX0TLlRBniZ0Fpw5druh/lXInS
	/19qcZczzFs1KcYSCjWUYiJ7VmiFoOiFsC0xjpPrLbB+3FFBPEKAxDECS3RUOaWNtl7Dzn+MOab
	vRGqRBeMFBf1xof/S+o6MuBGDfrfX2IJ4bpFy9iW8Be7hxv7jRbuc+YPek24qmVJSpEZXDG4yk8
	pNPYvtpO3YvR9xMODXZo6n5QpsfCac3CNss/l2hLgM0qPi99zUX6jHN3uaNHrU3svSgDSqEjMB6
	rdEeHKv2ZtsWOFxKN+DFPAin8gj9UbiRzTsnd5nrfQvDytP8Rgj5kSkWMNzzW5DwWiVmJqJHiXJ
	jjKK6vloohAhlurA8E4wiIKaXzoVXb/yrBnrGzCeZbmzSTXWfU2TBIeai6Fjbfh3ayfLhvN0haR
	MfAgYwqj1/hZz1LEkpLqCYuA7WA2ePmHD5KM
X-Received: by 2002:a05:6830:2647:b0:81c:5aac:798a with SMTP id 46e09a7af769-860dc7a7840mr1259513a34.13.1794296211364;
        Mon, 09 Nov 2026 23:36:51 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca41bdcsm1397620a34.2.2026.11.09.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:36:50 -0800 (PST)
Message-Id: <47224a9893e9cf87c0ee16bd1a79cf1355694175.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:31 +0000
Subject: [PATCH v2 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A rebase.missingCommitsCheck without a value, as in

  [rebase]
  missingCommitsCheck

or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
segfault as it writes the todo list: get_missing_commit_check_level()
passes the NULL value to strcasecmp().

The setting takes "ignore", "warn" or "error". An unrecognized value,
perhaps one meant for a newer version of Git, gets a warning and is
treated as "ignore". Treat a missing value the same way.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 rebase-interactive.c          | 10 ++++++++--
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..9eb70b09b3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -30,8 +30,14 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
-	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
-			!strcasecmp("ignore", value))
+	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value))
+		return MISSING_COMMIT_CHECK_IGNORE;
+	if (!value) {
+		warning(_("missing value for option "
+			  "rebase.missingCommitsCheck. Ignoring."));
+		return MISSING_COMMIT_CHECK_IGNORE;
+	}
+	if (!strcasecmp("ignore", value))
 		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
 		return MISSING_COMMIT_CHECK_WARN;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b3ee96f560..5b9fc67c19 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1562,6 +1562,18 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i warns about and ignores rebase.missingCommitsCheck without a value' '
+	rebase_setup_and_clean missing-commit &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 3 4" \
+			git -c rebase.missingCommitsCheck rebase -i --root 2>actual
+	) &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
+	test_grep ! "commits may have been dropped" actual
+'
+
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
-- 
gitgitgadget

