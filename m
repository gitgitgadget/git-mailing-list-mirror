Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39511EEC5
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742777520; cv=none; b=HKhS1WUQQG5BqSeW+lTBNn2vgjRFQft2Ya/V7FKYlnll+XbOuzz7/NxJBWpTxs5Z4zyY25oXun2YvsY15gsJ1vGMKI2jRXMdRiA8AJJ0PW2+cvY4WyG1QE4AqLNM/KvJ5eyJjlueTkLQA2MigzYU4j8keOVjleMwh89iBmxwQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742777520; c=relaxed/simple;
	bh=TCjxJkTPKFfV2K0m75b8XbESMlz2AYDmYE7pAm+YnRw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYmA2qQkwnknhzlmV1xiofqSxWIdghhuIUUQR/9Czxs7M0m5HrdfNT3+zyZaDyBigLxt/oBbHhssZC3rRS0E4BFusEi8usQienOe4vwywdl2wvaF5zkhaGMKWE6A7dlGmKLssueiLv8CFhgVqDvSqNsAJx2Za88O35b0EBR61RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYyd5Trv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYyd5Trv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so35598305e9.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742777516; x=1743382316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF9yfF/l8OCbi67PL74KO/lBMKEaP3m+BTSgSK3X0I4=;
        b=LYyd5TrvzCymUe7+BI2sQd/50uyoTZuSTyGQcZ5V/yTfUb8Hkhyv8Dp6bb6pOdxfat
         pr58sVwIrWWVekEOWB/FnfYRSwIRPm2TZQ32j32kOrNW5/ir7it/yO1LfdBLLqiOSoD8
         OiNs3fnkHUpirJCdPyx4Oo9kNRXeTBw4PIHTibac+UJpbiv6z/XaNTrEvSZQ7NyaJjVQ
         sac2SZskoJXe0RNdmbdtRrdG47sXxhVlGNMES7p9RZJzaRUrz3TcLAMwyNMmko+7G4Dc
         RJCmbYgeAE/VBVNr8wSR5a+rjoyhopBD3U2o1H+sXFjvk0JxGgQNiiJFxTgOu/OvN+Oj
         Gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742777516; x=1743382316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF9yfF/l8OCbi67PL74KO/lBMKEaP3m+BTSgSK3X0I4=;
        b=Z/6lrC2Q481ckKKmiXvSboLiCWjGm+SAb/eI3I1w3IYM4uiFZgeyv1Op8MT3HwveEJ
         6miJbI+/eegSupGUaWXD2S6YWDOvMUPLnjqy513nRaOTqtWU2h8vJiv7OTsIpI4tuYG2
         /h9I12uU7/IWR/KWR5KpWz06H99V0bq0exymse0tYUs+yT9J97TaHBkuRaJ7dhp8WtNw
         jUOwgjv85+p1ohZh9ytKN7tb85kFyV+NFGk4UsLjgW2l6tZ5/wCWzOABGfrpo6g3QQt0
         CWctnHU64Bm5CAUavJv2xP3oyQG5iE9KxvVyZVj7NncJnrn51BCKNZyAqitCJZIvoZF1
         GuPA==
X-Gm-Message-State: AOJu0YxQ8W0QH3tafg8j6RZiJfhr0P/kOtygZmQ/DeXsn8UpW/ibJEXb
	dFY9aWqj+EOEZQhXs+vuraB6pnMPLjBpuKxdwa+eP9iPPowfv0idLj7Yzg==
X-Gm-Gg: ASbGncvTdbbPQC2Ajgoq1Zn7A+07l1jhAaiNUJA6k6jynp6uZZKUmHvpr6O4BXuKHbf
	3gZPGoxJh2/w/pytu+gzkEp2wJwhJzPgPPXWyivUVelrYdZ1tXACGl4y911LjhJQgCppXPe16QN
	JAypOJME59AQ1sIDnAkJxh88Gh2P1gtS3jPaylyOPEgeM/WpTO1TRqGAczaBrJOPZmj9qin0Axd
	si+Sh2+EysV4NvHG0/+sl0CVoUOdIlr7EoyNX7hcyZ52fYjfPRHvmTT65JxYFe8rd5GwQiFMqKi
	gKOnl2tDSrhWGuUfrjlD69CoEMqGZFNzg50UZNKAF9ZCoQ==
X-Google-Smtp-Source: AGHT+IFm6xxBEon77K3DAW+Xoo7Iepzx7YqOQzZkZSqq3VN9eOwQX97M1YClX9qVe0hS+M40eLVykg==
X-Received: by 2002:a05:600c:3502:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43d50a4f8d5mr103404875e9.29.1742777515805;
        Sun, 23 Mar 2025 17:51:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957d9sm9207648f8f.9.2025.03.23.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 17:51:54 -0700 (PDT)
Message-Id: <6ed537862fa7585928fde33d21b77367a7fb708d.1742777512.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
References: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 00:51:51 +0000
Subject: [PATCH 2/2] maintenance: add loose-objects.batchSize config
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'loose-objects' task of 'git maintenance run' first deletes loose
objects that exit within packfiles and then collects loose objects into
a packfile. This second step uses an implicit limit of fifty thousand
that cannot be modified by users.

Add a new config option that allows this limit to be adjusted or ignored
entirely.

While creating tests for this option, I noticed that actually there was
an off-by-one error due to the strict comparison in the limit check. I
considered making the limit check turn true on equality, but instead I
thought to use INT_MAX as a "no limit" barrier which should mean it's
never possible to hit the limit. Thus, a new decrement to the limit is
provided if the value is positive. (The restriction to positive values
is to avoid underflow if INT_MIN is configured.)

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/maintenance.adoc |  5 +++++
 Documentation/git-maintenance.adoc    | 18 ++++++++++-------
 builtin/gc.c                          | 10 ++++++++++
 t/t7900-maintenance.sh                | 28 +++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 72a9d6cf816..42f9545da0e 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -61,6 +61,11 @@ maintenance.loose-objects.auto::
 	loose objects is at least the value of `maintenance.loose-objects.auto`.
 	The default value is 100.
 
+maintenance.loose-objects.batchSize::
+	This integer config option controls the maximum number of loose objects
+	written into a packfile during the `loose-objects` task. The default is
+	fifty thousand. Use value `0` to indicate no limit.
+
 maintenance.incremental-repack.auto::
 	This integer config option controls how often the `incremental-repack`
 	task should be run as part of `git maintenance run --auto`. If zero,
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 0450d74aff1..c90b370b1fc 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -126,13 +126,17 @@ loose-objects::
 	objects that already exist in a pack-file; concurrent Git processes
 	will examine the pack-file for the object data instead of the loose
 	object. Second, it creates a new pack-file (starting with "loose-")
-	containing a batch of loose objects. The batch size is limited to 50
-	thousand objects to prevent the job from taking too long on a
-	repository with many loose objects. The `gc` task writes unreachable
-	objects as loose objects to be cleaned up by a later step only if
-	they are not re-added to a pack-file; for this reason it is not
-	advisable to enable both the `loose-objects` and `gc` tasks at the
-	same time.
+	containing a batch of loose objects.
++
+The batch size defaults to fifty thousand objects to prevent the job from
+taking too long on a repository with many loose objects. Use the
+`maintenance.loose-objects.batchSize` config option to adjust this size,
+including a value of `0` to remove the limit.
++
+The `gc` task writes unreachable objects as loose objects to be cleaned up
+by a later step only if they are not re-added to a pack-file; for this
+reason it is not advisable to enable both the `loose-objects` and `gc`
+tasks at the same time.
 
 incremental-repack::
 	The `incremental-repack` job repacks the object directory
diff --git a/builtin/gc.c b/builtin/gc.c
index 6672f165bda..817081e1a50 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1163,6 +1163,7 @@ static int write_loose_object_to_stdin(const struct object_id *oid,
 
 	fprintf(d->in, "%s\n", oid_to_hex(oid));
 
+	/* If batch_size is INT_MAX, then this will return 0 always. */
 	return ++(d->count) > d->batch_size;
 }
 
@@ -1208,6 +1209,15 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	data.count = 0;
 	data.batch_size = 50000;
 
+	repo_config_get_int(r, "maintenance.loose-objects.batchSize",
+			    &data.batch_size);
+
+	/* If configured as 0, then remove limit. */
+	if (!data.batch_size)
+		data.batch_size = INT_MAX;
+	else if (data.batch_size > 0)
+		data.batch_size--; /* Decrease for equality on limit. */
+
 	for_each_loose_file_in_objdir(r->objects->odb->path,
 				      write_loose_object_to_stdin,
 				      NULL,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1909aed95e0..834ddb5ad68 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -306,6 +306,34 @@ test_expect_success 'maintenance.loose-objects.auto' '
 	test_subcommand git prune-packed --quiet <trace-loC
 '
 
+test_expect_success 'maintenance.loose-objects.batchSize' '
+	git init loose-batch &&
+
+	# This creates three objects per commit.
+	test_commit_bulk -C loose-batch 34 &&
+	pack=$(ls loose-batch/.git/objects/pack/pack-*.pack) &&
+	index="${pack%pack}idx" &&
+	rm "$index" &&
+	git -C loose-batch unpack-objects <"$pack" &&
+	git -C loose-batch config maintenance.loose-objects.batchSize 50 &&
+
+	GIT_PROGRESS_DELAY=0 \
+	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
+	grep "Enumerating objects: 50, done." err &&
+
+	GIT_PROGRESS_DELAY=0 \
+	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
+	grep "Enumerating objects: 50, done." err &&
+
+	GIT_PROGRESS_DELAY=0 \
+	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
+	grep "Enumerating objects: 2, done." err &&
+
+	GIT_PROGRESS_DELAY=0 \
+	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'incremental-repack task' '
 	packDir=.git/objects/pack &&
 	for i in $(test_seq 1 5)
-- 
gitgitgadget
