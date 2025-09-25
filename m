Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F71EFF9B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804878; cv=pass; b=NFGt2FBoQt+dHMjgcNPnywcNRcoSogl+pBrwAyJDFJR3MraXMiEA833/EEHPgUf0ZixI/gseaqQiObOUvt/6xHNruzQwD4FRNIJOp4rkPNTAk7772LMmccgZvcjues14Vv+bKfCl4nhh4GLbuhPrqL5B2T0USWP7SqWR52/CQyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804878; c=relaxed/simple;
	bh=0OWn4Hyn8PD4alceCaiQHCUt0k201lYTII3gfeUJLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEXYsyuZsuGux3UqF0PxPKfMo6U8hu7jjtBsSPjqIW94xvdkFBK0bNWlnGj7hxS8QsaeVbMchlIMhxMViOEso7PspCQfY/joilXx5yV65Wvctm7MksZGA816p5wHDb6pyQXPn31Z2eOm+/pE4ol00VBWWInDaQqLCcIAEuhSIF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SPoLRega; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SPoLRega"
ARC-Seal: i=1; a=rsa-sha256; t=1758804867; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R5Oh61azJtYNf9Ndm5hcq70UZG9U7o1SErXmfB5HQZk01/Zz7hX3/6SnxbyzmXguH0wNWsIa92fpGPkcv6ZhrjfTbkgOMGg7rZS1TExzK1RSbC7v/fEfU+kDCQL0VHX0zA95HaImsy63QaAlRrIaufgvhDi9Jr8anvaMKh+hruA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804867; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2uFALUsyqvhQL2cuVuZDzwfHG/6IAY6pKOHFEjcfjw4=; 
	b=GhaOZwvm3GhzeYl9ESo8STMfJChspiJKk496c8IrzyNfF6M0Eu7oWqrKl00qO31qqHmr26eJPNm4tA1x7bUj5TeOsyIo/DIXlHoQ0TeQ6IdntjO/i/1KQce3BbrR4/hSlepk8Y9cJemEls7XFjIbABy8AKp8juu+9TwNEePqwr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804867;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2uFALUsyqvhQL2cuVuZDzwfHG/6IAY6pKOHFEjcfjw4=;
	b=SPoLRegaVgPEBDTxDFMj8veAYqkTpeAwtqitkRUGvGtBaV9Q0bHJhVZVRPiTXU9E
	HlzYV4PgbG+TIE31Gt8RLXwPjm7+SuzgHo04SAV6qUxtTOw/oPGLmF3PcM2W3yzDf/E
	PifpKzq0UkVjTJiJJFE7SxYWdAGXlbvxyMlc/DcA=
Received: by mx.zohomail.com with SMTPS id 1758804864483136.47654844356464;
	Thu, 25 Sep 2025 05:54:24 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 04/10] transport: convert pre-push hook to hook.h
Date: Thu, 25 Sep 2025 15:53:47 +0300
Message-ID: <20250925125352.1728840-5-adrian.ratiu@collabora.com>
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

Move the pre-push hook away from run-command.h to and over to
the new hook.h library.

In addition to moving the signal and process handling, we use
a custom stdin feeding callback which preserves the original
behaviour of feeding stdin line by line, to avoid buffering
too much data in memory.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 transport.c | 79 ++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/transport.c b/transport.c
index 6ac8aa402b..241314806f 100644
--- a/transport.c
+++ b/transport.c
@@ -1316,67 +1316,52 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die(_("Aborting."));
 }
 
-static int run_pre_push_hook(struct transport *transport,
-			     struct ref *remote_refs)
+static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	int ret = 0, x;
-	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *hook_path = find_hook(the_repository, "pre-push");
-
-	if (!hook_path)
-		return 0;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct ref *r = hook_cb->options->feed_pipe_ctx;
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, transport->remote->name);
-	strvec_push(&proc.args, transport->url);
+	if (r) {
+		struct strbuf buf = STRBUF_INIT;
+		int ret = 0;
+		hook_cb->options->feed_pipe_ctx = r->next;
 
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
+		if (!r->peer_ref) return 0;
+		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 0;
+		if (r->status == REF_STATUS_REJECT_STALE) return 0;
+		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0;
+		if (r->status == REF_STATUS_UPTODATE) return 0;
 
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
+		strbuf_addf(&buf, "%s %s %s %s\n",
+			    r->peer_ref->name, oid_to_hex(&r->new_oid),
+			    r->name, oid_to_hex(&r->old_oid));
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+		ret = write_in_full(hook_stdin_fd, buf.buf, buf.len);
 
-	strbuf_init(&buf, 256);
+		strbuf_release(&buf);
 
-	for (r = remote_refs; r; r = r->next) {
-		if (!r->peer_ref) continue;
-		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
-		if (r->status == REF_STATUS_REJECT_STALE) continue;
-		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
-		if (r->status == REF_STATUS_UPTODATE) continue;
+		/* We do not mind if a hook does not read all refs. */
+		if (ret < 0 && errno != EPIPE)
+			return ret;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
-			 r->peer_ref->name, oid_to_hex(&r->new_oid),
-			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		return 0;
 	}
 
-	strbuf_release(&buf);
+	return 1; /* we ran out of refs: no more input to feed */
+}
 
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
+static int run_pre_push_hook(struct transport *transport,
+			     struct ref *remote_refs)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	sigchain_pop(SIGPIPE);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	opt.feed_pipe = pre_push_hook_feed_stdin;
+	opt.feed_pipe_ctx = remote_refs;
 
-	return ret;
+	return run_hooks_opt(the_repository, "pre-push", &opt);
 }
 
 int transport_push(struct repository *r,
-- 
2.49.1

