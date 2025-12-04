Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BD347FE2
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857776; cv=pass; b=NEXylROk5uyuHUUNfJ3GbZPxb285yAPz+LdCfQhU81Afi3iLp0JqWB4ZVlJZ3zigEYcHm7sIfLGKdX0twAUVH+vgACFJ4iFGLZL3/Rp/sHzLn2IigiYGHG/zwW6uIX4RBXWIcTR/dU1y8/yvIWdAUBlZC2PjgBmRAuP0Bjcj1Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857776; c=relaxed/simple;
	bh=Ij85HUjoBvm6j2ILzoUoQPgz5CKor0HvMV7JH+v4jRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It/nj9HzY+37J+9Evw54KGl4msSz5c7Kgfpccs1U6TPmNqyywvL3pJ3iutIcOf63jCIjBU585OgbK3cRHjSD39nx/bq11eXxnqdpu6VwfCXUwRi7jsRjyzFCEOoglowdp9J5csdJrFL31dxiTfsql2r1sHQaUSt21RV3LrHFA9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gXPgPEbp; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gXPgPEbp"
ARC-Seal: i=1; a=rsa-sha256; t=1764857763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gs0ylX8ek3/OtFNLoO3tJCOsmvTQdZ2G3W2H3E8e9Jf0yv0vWoboHSOT3kYk19JFTx610sVpL7klCjEjCREVDnmuWnq9lVSFQOL5d/jNwoRg6QWOzTIAxJcld51VcJ4aY5Ct4g22EfOVBgfAIgKAcKa5u1jRZ/5aERIBN+9/udo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857763; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r9poDe2TwzfwDWMu85JQBiZxpw8UHT9rDbYUdaez+ng=; 
	b=Oi/YHf1R54gs+p7LKDXEucH7UPOq9jj6feYEUvtYuyIZK2rUUVjixghg/KxO0XK9U2jDiX7zmZzg9cMicjX3KBKLQAE07+ZLm+605Yb1A1KiKsgprFfxOchvaT7H/QQ2BOcWCa7JxLHs5Yi5j0wTFhGXI6JBE83t7ttdDL9WFlk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857763;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r9poDe2TwzfwDWMu85JQBiZxpw8UHT9rDbYUdaez+ng=;
	b=gXPgPEbpZyOotabZ5eKab/Pfepi99RzaDC0xcbHPimDDgAJAm/jOGAi3TIfO8zEw
	ltEIVtUgNet0QhyrBxUy2morCGsqu3nO8yYW6q11qxt1ZR1AXXzZnJHSLpfKThqNb1w
	3Iz0l8vC1CoGXKObijy2tPQ8/f98uQT8XppNdScw=
Received: by mx.zohomail.com with SMTPS id 176485776063552.32072096045715;
	Thu, 4 Dec 2025 06:16:00 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v4 05/11] transport: convert pre-push to hook API
Date: Thu,  4 Dec 2025 16:15:29 +0200
Message-ID: <20251204141535.1986263-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
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
 transport.c | 94 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/transport.c b/transport.c
index c7f06a7382..047f2cefba 100644
--- a/transport.c
+++ b/transport.c
@@ -1316,65 +1316,71 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
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
+	case REF_STATUS_REJECT_ALREADY_EXISTS:
+	case REF_STATUS_REJECT_FETCH_FIRST:
+	case REF_STATUS_REJECT_NEEDS_FORCE:
+	case REF_STATUS_REJECT_NODELETE:
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_SHALLOW:
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
 
-	sigchain_pop(SIGPIPE);
+	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	strbuf_release(&data.buf);
 
 	return ret;
 }
-- 
2.51.0

