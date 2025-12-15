Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5C328629
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832223; cv=none; b=VCVoEmEae72gZHrEmf4OdrCxlgI+pU40amBwvzzhw7IcIZ8X6wHPAJV2vGjRPK6xgd3tVHpVk3pDuC8YdCK6Hu5BBBwZXsXP675KrD8FupsIbH/UKblNVOkHvm1vkcEvPtpu1MowpoWNztBnRcFsG2+nxQezVCIhavFWguBFRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832223; c=relaxed/simple;
	bh=Lh6XvmICseeS6T39qju0VqG+LctCNsYkW3NjeZJo1tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQRj3l11k5UpfNXNimn17Dnn9OaIUPL8ZwlLDyNwgSQdaCBbK+ywAOvnGHyhGnYB7D3IrGkeZTp3QHE50gsuSGXkMb247also9DpS2nwX9px7ni3fWX3D2rN/94mgINuDWJzcqh23dc8zMFwyMAI4vNLJPlzo/LjDT2pErOGz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na4CKxIH; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na4CKxIH"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65b68c8c649so733273eaf.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832218; x=1766437018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHOsIDSQPo3Ds29GrxF/fZoiG0NdXMnWO1i+P9urVes=;
        b=Na4CKxIHGFDw39jNuA5TGu+wArojhRJgOwOyxIdkNEAECa0JSYNFX4PdEvi/KGrNcg
         s+LQWMH8Xx8UUzTOEDk58WCUBRWRjIxvQUMsKoYla5Bc5gNu2jdhlIHOHAOlg/QvUPwz
         cvTqOTx84kUT85bkRs+eKX+7fkGFQpwuqIUnK62crLPhhI/5BFrS23Z5IiZtq2Kvnk6o
         va2Xl5OyE0wKVbVBL8pw5JlzMlJk/2BegnLCXeQ7KQrAUUHHKfrcM6/PjHPn7qb+OusU
         oHsv14ztpqhmxxJ4SE4knStmIHDK83ah72rhIOQ4M1Wfjg/rP3y3zVQGU/tegeziQYZ2
         1vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832218; x=1766437018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHOsIDSQPo3Ds29GrxF/fZoiG0NdXMnWO1i+P9urVes=;
        b=mkaE3VUa7/ppRaCrm5cMpLGAwR/HQlg9kWGH4DCpPdbfZRxMrp7Ow4rBNiY6OQKE4A
         lsdWvWUCXrwWC/2d58i5oDqETgo4zr7xn6dXH2oFQmgUevyNAOn6JYiA/9DwEx27LZs2
         DQ7NDwQdDA/ElHo1dO54hUheUx3GEphn/FTt6YDWUKOG2xKk14wpFfopHIWB35RVz0P+
         wd9930c7G3IkGVjrr4LDAxM/F3EUGcefM9By7HlOUfkU0dcjwHEzknkJrJv0pQKQ9EiP
         dgksZci7vELHQ/ncFUxU7swHSP6n6PIPqKV15uhsm3eVqRIYu9lCkp8NJYYydErsDtpL
         lkeA==
X-Gm-Message-State: AOJu0YwbNv43g3AvH98Jd9nlccJg8P37wTWZE7A5/Pb9zZNmOSWSu4bd
	Idb5Lm+m7vJPOXYhgclsVxHFCDLepsnA96sVFij50eZu0fGM10iZdPvVMPQrlA==
X-Gm-Gg: AY/fxX6B/QaQXgkjOafC/lT3ozlTitozIQAofGgqYicsLDg1O0vbwkWDdTBiZDh+mWg
	fyNOzXmH/VE9V5xQJt+Ib1i/wJcCP9aAWabsZ4uwAXqKH7LqIybxBAqFgoMkAty4PqdsfVsi/o1
	5ZfTkCCXZE0AUS8kzFB4bhpOr1Ip/+oBpw3Nr/fMYtMsnH7BmR8FharrBwC9q6Yv5qhtAkPG7vj
	6dCnwks+iSBaBfDVDJkNyrGokDEYBbLR+vM1CTMbaYFUAMu0SIWdtLfKrUbZ5FWHw6OIpcpzmL+
	eJmLTQxn1uk4OjjYec+0CZoYEhcByzVy8kKxjC3ThuA3xgLDnB89ItcRnKgGsuSP8E5Y588w0PV
	knqa2fMnrbgx7oqTMnseOBhXYzEyZbCGV51DNIfbhJ6T09DSDv4dZMlJ892vpWipXqyMxYAEASM
	FW+WaR5D8zNKDWsOlb1+I=
X-Google-Smtp-Source: AGHT+IFRrytjoVT0c/kKpWs6lG/qHP8TudQw5oPilLrWX2MxUyodFHAapuIyx84ZF+h/cu891X5i2g==
X-Received: by 2002:a05:6820:198c:b0:659:9a49:8ed6 with SMTP id 006d021491bc7-65b45186e20mr5547351eaf.10.1765832218146;
        Mon, 15 Dec 2025 12:56:58 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:57 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 7/7] builtin/repo: add object disk size info to structure table
Date: Mon, 15 Dec 2025 14:56:39 -0600
Message-ID: <20251215205639.2700270-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, update the table output format for the
git-repo(1) structure command to display the total object disk usage by
object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 13 +++++++++++++
 t/t1901-repo-structure.sh | 26 +++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ed41bf9d4..a071d2fdfe 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -324,6 +324,7 @@ static void stats_table_setup_structure(struct stats_table *table,
 	struct ref_stats *refs = &stats->refs;
 	size_t inflated_object_total;
 	size_t object_count_total;
+	size_t disk_object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -358,6 +359,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	disk_object_total = get_total_object_values(&objects->disk_sizes);
+	stats_table_size_addf(table, disk_object_total,
+			      "  * %s", _("Disk size"));
+	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index dd17caad05..64db191234 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -5,8 +5,18 @@ test_description='test git repo structure'
 . ./test-lib.sh
 
 object_type_disk_usage() {
-	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
-		--filter-provided-objects
+	disk_usage_opt="--disk-usage"
+
+	if [ "$2" = "true" ]; then
+		disk_usage_opt="--disk-usage=human"
+	fi
+
+	if [ "$1" = "all" ]; then
+		git rev-list --all --objects $disk_usage_opt
+	else
+		git rev-list --all --objects $disk_usage_opt \
+			--filter=object:type=$1 --filter-provided-objects
+	fi
 }
 
 test_expect_success 'empty repository' '
@@ -35,6 +45,11 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|   * Disk size        |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -58,7 +73,7 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		cat >expect <<-\EOF &&
+		cat >expect <<-EOF &&
 		| Repository structure | Value      |
 		| -------------------- | ---------- |
 		| * References         |            |
@@ -79,6 +94,11 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Trees          |  15.81 MiB |
 		|     * Blobs          |  11.68 KiB |
 		|     * Tags           |    132 B   |
+		|   * Disk size        | $(object_type_disk_usage all true) |
+		|     * Commits        | $(object_type_disk_usage commit true) |
+		|     * Trees          | $(object_type_disk_usage tree true) |
+		|     * Blobs          |  $(object_type_disk_usage blob true) |
+		|     * Tags           |    $(object_type_disk_usage tag) B   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

