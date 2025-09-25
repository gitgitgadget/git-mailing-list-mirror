Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CE1F1518
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804881; cv=pass; b=EI3ntCaeJfOFa+tgC0OpqE8jMYDHHnkxjTC57EQpXwd55OBneKAlGfKEDF1Weq3A19Asnh0YfHHsqC+jKagXHeymIMSS5xULbQw4nSdnHuti7UCPO25gH8IcMG99R8JilaA9fLQVtFy0yVdE/+07nS+QTu3QIyl0H8q20C9FaaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804881; c=relaxed/simple;
	bh=ZkSgi0+KoQoQAgbPshgHViQWWJoJR/pAxi1TCN2UAnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLXtQG7cRmMuw02wVeol6o/mAvKe0yTe5YUns+vXvi1CeZMyhBBDKW5V4Qgbe1UKLN6bU0R2a+J2A+hzbVEL8a4K+fyYZ7GIjjTFai5xukflm/tKjDp7C06/O7NiY1G4f1ZpYoNN6QFJ0Q24ra37QzwLDu1p6/7eKmGZjHCxbH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VVwvhz1x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VVwvhz1x"
ARC-Seal: i=1; a=rsa-sha256; t=1758804869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RuIMvWtrch49qYGpIlGyKdeAikGXKYHGdck0cKikI/FxPG8GLOLwy4fPOkqaFB0Mdu/ZntXYW0zq0DLRSGmHzzpImOlBSa8SzoQYrmZ3V+twRKHKYBArhLLO4O7x75HvrvJP4sbo0EDZDjh+xwW0qRr3sLlT8H7JdUTzHyk5r8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804869; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IBgMjv02ouZ1QQrkGz/qOzWwd8qT/W+E3Ao1qQUjQv4=; 
	b=gZTsOEpWK8Sax7s5qhgltGsml03U8hVRhifePRDtbMMbNIp2vGNQ6YvJw7btMIMCEkNpMoQnIcMGPQfN2SywpnVe96rsUAsHlCythg2EENgqmixNpBsfbVtLjUK6Jvmxar2cG4/dtRfUdUOksu1Bi+EHWAxzJRXo0Io9MRxzOow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804869;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IBgMjv02ouZ1QQrkGz/qOzWwd8qT/W+E3Ao1qQUjQv4=;
	b=VVwvhz1xRDz6RlIYsvhfFOXfSEtpUnxXvkq/ntqFYH/EhQjs6nhdW8473AwSS3MX
	Y6/QTMdVB+AKAkR16z9Bfv2uCT8qCalw7TKswhJXByC7mOBfgSqvJoufKMOJEQGHsX2
	XR+ZogPrwalBsSNK3Ir9v6Z6phcD9IVfRGzJHaEQ=
Received: by mx.zohomail.com with SMTPS id 1758804867095541.8669279829327;
	Thu, 25 Sep 2025 05:54:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 05/10] reference-transaction: use hook.h to run hooks
Date: Thu, 25 Sep 2025 15:53:48 +0300
Message-ID: <20250925125352.1728840-6-adrian.ratiu@collabora.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 refs.c | 61 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..5a2b6ad1fc 100644
--- a/refs.c
+++ b/refs.c
@@ -2377,31 +2377,16 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static int run_transaction_hook(struct ref_transaction *transaction,
-				const char *state)
+static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct run_hooks_opt *opt = hook_cb->options;
+	struct ref_transaction *transaction = opt->feed_pipe_ctx;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
-	int ret = 0, i;
-
-	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
-	if (!hook)
-		return ret;
-
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
-
-	ret = start_command(&proc);
-	if (ret)
-		return ret;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (int i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		int ret;
 
 		if (update->flags & REF_LOG_ONLY)
 			continue;
@@ -2424,22 +2409,34 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 		strbuf_addf(&buf, "%s\n", update->refname);
 
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE) {
-				/* Don't leak errno outside this API */
-				errno = 0;
-				ret = -1;
-			}
-			break;
+		ret = write_in_full(hook_stdin_fd, buf.buf, buf.len);
+		if (ret < 0) {
+			if (errno == EPIPE)
+				ret = 1; /* child hook closed stdin, we're done */
+
+			strbuf_release(&buf);
+			return ret; /* run-command will handle the error */
 		}
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
 	strbuf_release(&buf);
+	return 1; /* no more input to feed */
+}
 
-	ret |= finish_command(&proc);
-	return ret;
+static int run_transaction_hook(struct ref_transaction *transaction,
+				const char *state)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+	if (!hook_exists(transaction->ref_store->repo, "reference-transaction"))
+		return 0;
+
+	strvec_push(&opt.args, state);
+
+	opt.feed_pipe = transaction_hook_feed_stdin;
+	opt.feed_pipe_ctx = transaction;
+
+	return run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
 }
 
 int ref_transaction_prepare(struct ref_transaction *transaction,
-- 
2.49.1

