Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA033507A
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710663; cv=pass; b=TV8rYqrjtbM9wrEuDD+qVxsRTpITlFHDaD8CwHk8/c3xyYO0L6K7QGptLznJYJEdmOZs3O5Q2DUlgviiGeVQWSwNnGozyh6saXVcFB4f1Y6iGyE8qmeFQhucMgJqRiSD/iSdB/sUC5+UPpSf3vFp/FuNGir5jYP/37wSVrrDEtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710663; c=relaxed/simple;
	bh=OB1xbnmJV7z1sQ+0dmX4iOyxjYhcTxnpV8w/5lR2NS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMOd7njiSGBHt7XaUiisoXQ6VS67zaOd8r/csOOP95jrUt7hAmxz6r6oVTDZb8xcVPcS6I7N3lgSXfFBl2qc6bVwxLOxaBaM7vZ1cjmNMFl83CT47ye/vobGB/1MdlhCs957nW8Y2A0bbXeBKZTI3n6KT7yveneH5TrBvfU1geI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c5L0hp15; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c5L0hp15"
ARC-Seal: i=1; a=rsa-sha256; t=1760710651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gvqx5snZP0gUNvUisHVSlC2I7/yLX/Gd1DNgfGYIABXZzyibQ8lgB/F+93IoTyc6k01g/oJpNcWFjJgdiePIkgJqYJ3tVjNLpm91YyYKP0kwaqux/8BCNrHRVe99rpil1EvFHl2+au+JXN4zHtdmkmDhjdfOCcYLUR+NhckvVgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sotVp5U0IEhXBStqyXs8Chtq//skg4G32dYKRvhOeyo=; 
	b=HG+bHJkAy96hCYhQZK/2my2TpcUXBinqqCiyCupz9EI76eFj83PheTZC8gLO46zKxmgSU3u1Yze18Dxx4A4wHNUI0JQBpz15fVdEs90xAVWGcjuzM23EafpjHWD793FXt7aIMyzOjM3zh0bi7EG4kRxvla8C2oM0mYKKV+yfU/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710651;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sotVp5U0IEhXBStqyXs8Chtq//skg4G32dYKRvhOeyo=;
	b=c5L0hp153PSBcSn60T/V770ns4MWi7yUrY/8McVxtBhcxTr+hZw/p/+cqoOaoeSi
	nBD0Mu4T8djI/eRaIA420bSLb4851ku7i2ukk2pIFxvmYCeV2j7MOTc91ey4FfE6H+r
	IwiZDt249CJHKFMMhMmfenFw1j4G/WQskapP/KNQ=
Received: by mx.zohomail.com with SMTPS id 176071064960123.86943232838405;
	Fri, 17 Oct 2025 07:17:29 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 08/10] hooks: allow callers to capture output
Date: Fri, 17 Oct 2025 17:15:42 +0300
Message-ID: <20251017141544.1538542-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 1 +
 hook.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hook.c b/hook.c
index a325c7cb8c..fb452b5369 100644
--- a/hook.c
+++ b/hook.c
@@ -152,6 +152,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
 		.feed_pipe = options->feed_pipe,
+		.consume_sideband = options->consume_sideband,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
diff --git a/hook.h b/hook.h
index 82b3d1dd27..a84e97db34 100644
--- a/hook.h
+++ b/hook.h
@@ -65,6 +65,14 @@ struct run_hooks_opt
 	 * Only useful when using run_hooks_opt.feed_pipe, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.49.1

