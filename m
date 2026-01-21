Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0243C062
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032525; cv=pass; b=hvDBgWIMF9JRs85SNTeNb0nFUhdFHMCVuCBGIKFAbEe4yApvb3Ywv7TGRDcwFmM9djLNcfnpWLo2NLJkBX+cqClMqO4zYkRHFcSWf6vo48uk6W+nLDtcMkX5hPoOJzoIZNkjIN/5sRjy/tzGZ/KdO5cyBvXiPW8wbzRVlQAXZok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032525; c=relaxed/simple;
	bh=R9v/tTZhQV14vswkIh05xNPuwkSdUDilPfcd8sofwVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwdBRKiKmu2vjOUGs6HcA2ga6li7KiWGGRMKtSmwZV3PADq7K5+xvPTw7a51T/1nZ88xUhC1fqhLHVH0mXwmwqWIQtiRgMY3TZYuq9cr+KvPX8K9kcqPYVm09H/t6zlU4Ej7OBGJr1NOxxFrf7ThSX415t8+MZ5tUBGGCTPh2zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=EFiHPIzj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="EFiHPIzj"
ARC-Seal: i=1; a=rsa-sha256; t=1769032509; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JloyECcAkcgyHH1/E/pDERl3yKs4JsX4HOKkXHtg+Li6Dfqo9K/Jfjs15t8Z0GBI5HeGFhAbYGX78/kFSGwKwBsxsq0kObMlmioBJp9Fg12uaDBf7M6vgzJDO/o5hfRMTlmKMZulqqcdIz8Y3soPl+kMIhBLmotF9+FJNtrhWF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032509; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5DDhv87bVqWhzN+LaagRboHDNcX+beNbZhJei9mSY0k=; 
	b=cqVs0TV6hu6/JQh1lDeGLUgiiKpmmUnHe6sI0kF7JN47Ry0vkzbFRvBixp9GJRR9r5WFdOKZWTxs9qkMYU4js6hBkiwRbP8wGuniKZUV+Ni9XATgGqqUiLmSPy8onoolZHs2GVMqHNpnA/qfER12Ao6hRXIK9jRYYOCL0jcCAto=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032509;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5DDhv87bVqWhzN+LaagRboHDNcX+beNbZhJei9mSY0k=;
	b=EFiHPIzjfIGQPxC21rtDnFOYDyW7fdbZBxmSaqjEMk7UBXc4zWS1rrwQeo/0kXGF
	WVIZqXueBPw5gRRVU53h+yM4SfS9rDqsTLULiCmS5kzV0ILDBakkkM86H2SRXoab+ap
	lctS3zqSUCXOgMHHgy5QspS/U14qOX2k4AYLrPYE=
Received: by mx.zohomail.com with SMTPS id 1769032508151454.4550148547356;
	Wed, 21 Jan 2026 13:55:08 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Emily Shaffer <nasamuffin@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v7 08/12] reference-transaction: use hook API instead of run-command
Date: Wed, 21 Jan 2026 23:54:32 +0200
Message-ID: <20260121215436.1473800-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Convert the reference-transaction hook to the new hook API,
so it doesn't need to set up a struct child_process, call
find_hook or toggle the pipe signals.

The stdin feed callback is processing one ref update per
call. I haven't noticed any performance degradation due
to this, however we can batch as many we want in each call,
to ensure a good pipe throughtput (i.e. the child does not
wait after stdin).

Helped-by: Emily Shaffer <nasamuffin@google.com>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 refs.c | 102 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/refs.c b/refs.c
index 627b7f8698..1e2ac90018 100644
--- a/refs.c
+++ b/refs.c
@@ -15,7 +15,6 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
-#include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
 #include "odb.h"
@@ -26,7 +25,6 @@
 #include "strvec.h"
 #include "repo-settings.h"
 #include "setup.h"
-#include "sigchain.h"
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
@@ -2465,68 +2463,72 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static int run_transaction_hook(struct ref_transaction *transaction,
-				const char *state)
+struct transaction_feed_cb_data {
+	size_t index;
+	struct strbuf buf;
+};
+
+static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
-	int ret = 0;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct ref_transaction *transaction = hook_cb->options->feed_pipe_ctx;
+	struct transaction_feed_cb_data *feed_cb_data = pp_task_cb;
+	struct strbuf *buf = &feed_cb_data->buf;
+	struct ref_update *update;
+	size_t i = feed_cb_data->index++;
+	int ret;
 
-	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
-	if (!hook)
-		return ret;
+	if (i >= transaction->nr)
+		return 1; /* No more refs to process */
 
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
+	update = transaction->updates[i];
 
-	ret = start_command(&proc);
-	if (ret)
-		return ret;
+	if (update->flags & REF_LOG_ONLY)
+		return 0;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+	strbuf_reset(buf);
 
-	for (size_t i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
+	if (!(update->flags & REF_HAVE_OLD))
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+	else if (update->old_target)
+		strbuf_addf(buf, "ref:%s ", update->old_target);
+	else
+		strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
 
-		if (update->flags & REF_LOG_ONLY)
-			continue;
+	if (!(update->flags & REF_HAVE_NEW))
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+	else if (update->new_target)
+		strbuf_addf(buf, "ref:%s ", update->new_target);
+	else
+		strbuf_addf(buf, "%s ", oid_to_hex(&update->new_oid));
 
-		strbuf_reset(&buf);
+	strbuf_addf(buf, "%s\n", update->refname);
 
-		if (!(update->flags & REF_HAVE_OLD))
-			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
-		else if (update->old_target)
-			strbuf_addf(&buf, "ref:%s ", update->old_target);
-		else
-			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
+	ret = write_in_full(hook_stdin_fd, buf->buf, buf->len);
+	if (ret < 0 && errno != EPIPE)
+		return ret;
 
-		if (!(update->flags & REF_HAVE_NEW))
-			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
-		else if (update->new_target)
-			strbuf_addf(&buf, "ref:%s ", update->new_target);
-		else
-			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
+	return 0; /* no more input to feed */
+}
+
+static int run_transaction_hook(struct ref_transaction *transaction,
+				const char *state)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct transaction_feed_cb_data feed_ctx = { 0 };
+	int ret = 0;
 
-		strbuf_addf(&buf, "%s\n", update->refname);
+	strvec_push(&opt.args, state);
 
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE) {
-				/* Don't leak errno outside this API */
-				errno = 0;
-				ret = -1;
-			}
-			break;
-		}
-	}
+	opt.feed_pipe = transaction_hook_feed_stdin;
+	opt.feed_pipe_ctx = transaction;
+	opt.feed_pipe_cb_data = &feed_ctx;
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
-	strbuf_release(&buf);
+	strbuf_init(&feed_ctx.buf, 0);
+
+	ret = run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
 
-	ret |= finish_command(&proc);
+	strbuf_release(&feed_ctx.buf);
 	return ret;
 }
 
-- 
2.52.0.732.gb351b5166d.dirty

