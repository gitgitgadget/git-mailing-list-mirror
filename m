Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07812F693C
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710655; cv=pass; b=JQYgIaqo7rIaefN5kT9h/a8z5FrMezv5iF7oGc7tacDy54iCvg6FijJGeWzgbsP6cSxMyobRyFG8whD7DSR0Avrag3Ug3r5IWG3m3r6uEJxSD/WIsCNLmXeijx9ybCUM9DdyJd/SCfTiURafI1Uulj0caE3PjIEccqbfhotCO6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710655; c=relaxed/simple;
	bh=i9F5NyoV+NKadSad1fbHlycRu/w3DjShuYlBWEPRz+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYw8AwWg55417YfY/qATQudY5AI3+urQ3uoq76dxMbEdBvLq89ywkJbBzc4NS0IQCI7brCaJGtLa9l141iF8Y+5B3tJM+mmJpbHCFv+LrzBSFLdqW+FZ4rb6YzMQ/eYh54nZ5zJnVXrTns6NOzXRmngTaIWwrDLxGCPve9O+lek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AyP3CAv4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AyP3CAv4"
ARC-Seal: i=1; a=rsa-sha256; t=1760710643; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QQ5YluXR1NA8Fk0P6AUY6dIECGjoU3Zp2OrINIyRRHbSZ70kxOxlqgga0FvtKrrWVjKR8RnsDsGbOSM2+KF0hsrWIirhHyj399i1Rdo8aM694asb5jkMARYF9vE/v/BhDJmaN6YuD0Vjc/8plvkrzgn1hQ0p5i1y8JxZ9J5Z6WM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710643; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eflcbe9plz/lcEE9/ckLKm1AabMsANb+RIKLhEiRu6s=; 
	b=Vh78j1he++6ZHR9owy6siTGCy6FFxiwyZUdZ4ELFFn+5nP5EgWentbgMGrzBDhr1H4QXLvi+BZUIhi+8e9rIxgNDxRx2hwgeX//luffeSZ/tvzlONgkgXff5OZftvWD+AJgULXDEFkdACo7G2MqUScUJT/ZxLnrE/sk8mZcmJ9w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710643;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eflcbe9plz/lcEE9/ckLKm1AabMsANb+RIKLhEiRu6s=;
	b=AyP3CAv4CoYYPkvXINIbTe8i5tSmweIT9PMhPVograpirwEUR7Jk0ZnYRFJ+SSAS
	wm66KEhwTftdnR1PncBDRMUsot1MLt5aMzFj17d9WtQeOccS4ffcFQtp+sI6HOvuOnH
	1EdBy0DH7YJU9JQbkyoigUj+3Lmfi3o1MBISbjoc=
Received: by mx.zohomail.com with SMTPS id 1760710640974660.1454495543286;
	Fri, 17 Oct 2025 07:17:20 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Emily Shaffer <nasamuffin@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 05/10] reference-transaction: use hook API instead of run-command
Date: Fri, 17 Oct 2025 17:15:39 +0300
Message-ID: <20251017141544.1538542-6-adrian.ratiu@collabora.com>
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
 refs.c | 101 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/refs.c b/refs.c
index 965381367e..5b042ff89b 100644
--- a/refs.c
+++ b/refs.c
@@ -2405,68 +2405,73 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-static int run_transaction_hook(struct ref_transaction *transaction,
-				const char *state)
+struct transaction_feed_cb_data {
+	size_t index;
+	struct strbuf buf;
+};
+
+static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
-	int ret = 0;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct run_hooks_opt *opt = hook_cb->options;
+	struct ref_transaction *transaction = opt->feed_pipe_ctx;
+	struct transaction_feed_cb_data *feed_cb_data = opt->feed_pipe_cb_data;
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
2.49.1

