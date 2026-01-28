Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65133A9E0
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636426; cv=pass; b=YnXz9Vrpbv1Ab3nflXyyrtCc0DjUfIKKv9B9qY28kGpmGf50brfRZ1LoJDLw7cK4GfTvZHgUqQutuZo494CQMJMkmNFfNMYWZ3z3V9V4+PqCQNin0aPKiMudHYmsjzbRJkuVWMMu+az46lDAyT/ozr06P7l0Uc0Bp0t5i6Zzr+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636426; c=relaxed/simple;
	bh=b2U6ZC1yHbAxMPuPjFE6Lp/pMwziKYTDqF5quahFvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+T45cu24btAXQ3EWP15D0OJnPFfK4HudEtKErTOKvUWmae3JFBJniKKA4mj4QAQCFAGoJ32OmV9CCpH3wl1Xk3zToFagr2VRW8J4aCkcTK31aOIIcSA76KRSId9qC7ciw9B+uRMHFFc6L7Vi3D16Z80BwX5LtYZ+kGVxCv4Hic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=R6q0x3SP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="R6q0x3SP"
ARC-Seal: i=1; a=rsa-sha256; t=1769636409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ktf9jRoIygv2E8PNzauZZrxqAiGPd0C3HBDiEuCAY7OGXqt0CU89QU+OhUqOHvJ/ml9zTnIoQjaZRmPEDD2HUqf1JI11h20AvL45iUhZYWtg/EAeGUXAncwIgj9lMv67eoDxKD0g8iI0BdVe8bVTqm7C7+ccKZyFmzT0RGZo53c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636409; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0wY+N8ie+ZrUKi/h1gPOQs0mf85rTjzVDbBlyXiPRoU=; 
	b=dXEk+IorU4IvihQdZZLmculZzOryiusi5QM6afNsEmVFGQIsNDkERA7rHEemAC1DR5Gek5B3b8fyxbgVDtEduqwnNcyLGgxmjcAyEjtv3XrIS7Sr7FGZzHml2FnaH0OrwsAqkSY2WqPMFT033u8qi+JOFzX8WONT/WwpI3bIhNc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636409;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0wY+N8ie+ZrUKi/h1gPOQs0mf85rTjzVDbBlyXiPRoU=;
	b=R6q0x3SP4eAX1z7NgMrtDVfF4VigFXvATG4SK0VIocOHe2YH7URHmbQPBIysM1Cz
	rREweT0Hol6kSQeIVUb9mQQ34TA1mX5Qmy4uwOqeIEaK3t1dq/avEHgZivIOpR+zkw/
	5sHQ1JgksCt8ya0hAsciMoO5x+uYsnCbTOwBuwCQ=
Received: by mx.zohomail.com with SMTPS id 176963640846482.37295331187215;
	Wed, 28 Jan 2026 13:40:08 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 07/12] transport: convert pre-push to hook API
Date: Wed, 28 Jan 2026 23:39:22 +0200
Message-ID: <20260128213927.3026875-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
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

Move the pre-push hook from custom run-command invocations to
the new hook API which doesn't require a custom child_process
structure and signal toggling.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 transport.c | 95 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/transport.c b/transport.c
index c7f06a7382..e876cc9189 100644
--- a/transport.c
+++ b/transport.c
@@ -1316,65 +1316,72 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die(_("Aborting."));
 }
 
-static int run_pre_push_hook(struct transport *transport,
-			     struct ref *remote_refs)
-{
-	int ret = 0, x;
-	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
+struct feed_pre_push_hook_data {
 	struct strbuf buf;
-	const char *hook_path = find_hook(the_repository, "pre-push");
+	const struct ref *refs;
+};
 
-	if (!hook_path)
-		return 0;
+static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
+{
+	struct feed_pre_push_hook_data *data = pp_task_cb;
+	const struct ref *r = data->refs;
+	int ret = 0;
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, transport->remote->name);
-	strvec_push(&proc.args, transport->url);
+	if (!r)
+		return 1; /* no more refs */
 
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
+	data->refs = r->next;
 
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
+	switch (r->status) {
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_UPTODATE:
+		return 0; /* skip refs which won't be pushed */
+	default:
+		break;
 	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+	if (!r->peer_ref)
+		return 0;
 
-	strbuf_init(&buf, 256);
+	strbuf_reset(&data->buf);
+	strbuf_addf(&data->buf, "%s %s %s %s\n",
+		    r->peer_ref->name, oid_to_hex(&r->new_oid),
+		    r->name, oid_to_hex(&r->old_oid));
 
-	for (r = remote_refs; r; r = r->next) {
-		if (!r->peer_ref) continue;
-		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
-		if (r->status == REF_STATUS_REJECT_STALE) continue;
-		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
-		if (r->status == REF_STATUS_UPTODATE) continue;
+	ret = write_in_full(hook_stdin_fd, data->buf.buf, data->buf.len);
+	if (ret < 0 && errno != EPIPE)
+		return ret; /* We do not mind if a hook does not read all refs. */
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
-			 r->peer_ref->name, oid_to_hex(&r->new_oid),
-			 r->name, oid_to_hex(&r->old_oid));
+	return 0;
+}
 
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
-	}
+static int run_pre_push_hook(struct transport *transport,
+			     struct ref *remote_refs)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct feed_pre_push_hook_data data;
+	int ret = 0;
+
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
-	strbuf_release(&buf);
+	strbuf_init(&data.buf, 0);
+	data.refs = remote_refs;
 
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
+	opt.feed_pipe = pre_push_hook_feed_stdin;
+	opt.feed_pipe_cb_data = &data;
+
+	/*
+	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
+	 * them to keep backwards compatibility with existing hooks.
+	 */
+	opt.stdout_to_stderr = 0;
 
-	sigchain_pop(SIGPIPE);
+	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	strbuf_release(&data.buf);
 
 	return ret;
 }
-- 
2.52.0.732.gb351b5166d.dirty

