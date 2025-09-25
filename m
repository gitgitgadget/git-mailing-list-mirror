Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005714A0B5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804885; cv=pass; b=SYTx4beu8Kdc6VDDP/bQR86FdIlpZ5bQX2qT0xBAn0oJihDHaUJu1X7WTseH/YR2A2k6qVB58eIHFkbIfVKpsb8KhXKlY7/v44LuCsOG5WVh42K0iSsJDn+z8adoJe8t3HnGDREt9O6xiEuD+ysdWfCepaewKpc/LCAyzbgMSKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804885; c=relaxed/simple;
	bh=U30Hd21G3RQ9Q4UnHtNQJCCFAqKMH6Hjl1EOuR3A2yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtJRgW7iWHvOxihOZQ50ECS5kL2DqUmTCMM4A1+w71HWq1+srEFUoqoeOj0mgbarlPB50Q9p7gD3beCnXrlf8Gm9foSMgVifQOQES5WCK8B1+HwEoiNEGV0lW9FvGkJyr6bSiCv45AcRBYZc+uxc7OTzYIzw7RZt5k6UbCULa2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Yte25eQt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Yte25eQt"
ARC-Seal: i=1; a=rsa-sha256; t=1758804873; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HpCVss2RdSyf/kThmpJ6w8Y7cIJXwAWIMdY/AIldkE8ohCNm5fDkPgf5uMSvmXgGqSi+mqnIrcME+je+h5Lcco9HS858puK41swEOp0g+22dgdCOHZjmivQd34nHTj63rggahziqyU4ooxfCJSqRPh6N76/Z1tMLexOvrBQpHiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804873; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W6/rOZrupQDJmcb/faV7xJPHlc48qCsNjCMaajHNE+s=; 
	b=GK19tCBNQpVsWuMAPKCKjq75eYqI3jQbWEDGt61BIC87Ki16nlcBTqX1QPuBdy3mAYSeTdA/KFdYDgcCXwtu5cuzkw31t0ImoGFax6tr3I1t+DBnxVRk7vh76oaT+bQLXPhZKIedl/heLadrrex7i8K6UQr4GHwf+fMoBUhf0P8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804873;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W6/rOZrupQDJmcb/faV7xJPHlc48qCsNjCMaajHNE+s=;
	b=Yte25eQtUpsas0gmDyB0khWJPN26mupjyHYpZDw/+kuERtBO7tMARNypY+GuSBNP
	aShjjKJRLGPu9Ygr89tGZDVNGBc5KG1lzPUvYthzr+aKNRwJ5ADfI7CYsaxmxLQV39c
	XD7JBOIN3O4XH0ae0MGz3C2WeK+AA0joNLIirm34=
Received: by mx.zohomail.com with SMTPS id 1758804872368956.8456739002638;
	Thu, 25 Sep 2025 05:54:32 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 07/10] hooks: allow callers to capture output
Date: Thu, 25 Sep 2025 15:53:50 +0300
Message-ID: <20250925125352.1728840-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
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
index 199c210b97..e15ee08f60 100644
--- a/hook.c
+++ b/hook.c
@@ -145,6 +145,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
 		.feed_pipe = options->feed_pipe,
+		.consume_sideband = options->consume_sideband,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
diff --git a/hook.h b/hook.h
index 8fdbc8c673..a862858c1b 100644
--- a/hook.h
+++ b/hook.h
@@ -56,6 +56,14 @@ struct run_hooks_opt
 	 * Only useful if you are using run_hooks_opt.feed_pipe. Otherwise, ignore it.
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

