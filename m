Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834503;
	b=efFFtMnusFfh14dJyTJEPslmLFlpGR/8t+13y7WE3yUMLMcNWCZItIJNpUWBDGXuHifg
	 oTZuDqfvtjGTMNBOC7b7xkYU2IHEgGql4tMnvSzjBfbkIMaT7oHSyYMJBWDaIRcBt/5un
	 nJNW9F2DeIKO6Ahzu2RZzE3Wy/tYVXpDC8acFW3i2WzI5vp18RWYG6CuQRsi9BpzAnzKJ
	 fSAW7k0bO0v+1awJhbEd5PZIZbdc1Zbi2IovPImndjQOColulSmBkX+lRzuqJNakzvqGI
	 mFACDYyGToDuCHN8wHzCZe27k85+1J8yGCWlGar0Fk9JnJCYAu2qewLklQXwYjE15Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834503;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0ilDgdb+IAMjNYkY/YeYnD+0bnTAh3GiUxIgnE1M8/k=;
	b=sgU5TVi9FG4FzfDj42BirHdVyxkt2g6vUyb7ZzPKf+21TUtVrl+UfJnSuk0VSiej1KFr
	 udl88SP+7G3P21cgfM8DNXrP71iadwT27c44cptnwgOEkiPZQr8AglKpJxIkch+YcqA+2
	 nQBoJDWKmW8gKzWQwZrzUmxC9vw0Tzb0Ssqima+6B+a/cIDRhU0ecaumQIFA20NOM/Rjg
	 m1tbzIuEcpfHfUimcBDWyezyGfkXV7qzDqKsJpPR+RM38D/rrq1aPuUFhoQfnpw1JRv5T
	 krqUuYHdh91hy4U3yEkaU4gPZAN7jwnSY4yQUvZIWptHGwC1FP7oig2vnH3rDzwPMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=V7dN69ba;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ir4x5LfZ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E4606A89B
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031E4606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=V7dN69ba;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ir4x5LfZ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16E961400043
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 08:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834501;
	 x=1794920901; bh=0ilDgdb+IAMjNYkY/YeYnD+0bnTAh3GiUxIgnE1M8/k=; b=
	V7dN69ba19WNntFz1r/7XbnPQ1DhzRc782ASnZL/+Y7X2Vqir1b5dbRbwRl7E1V/
	eNTaErHc6x/JjzVmWdGgxFKRnIM3fYshjBx2Xk71CTgQUAezMvuvpptbKbWpS9zk
	KB08JVDxKzKQaNJBgp4rN74Vv4ssJXZv7np6U4PBYjYnriWG8lqpkNqTQKfSfrbY
	CF9FJvIKtNnNPfhYJI/JgdEFq/vChjCb72Ol8GgvFxSVqS3AfUx4f2VxWUoE6H5p
	DoEhHaU0AGIyE+M+rEyQKo+fmtTQNrVZXaFHCjRnfXqAKjIyAWIcPUN48DGKmpNO
	/4cCH83mzHKIGj/QttaLBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834501; x=
	1794920901; bh=0ilDgdb+IAMjNYkY/YeYnD+0bnTAh3GiUxIgnE1M8/k=; b=i
	r4x5LfZUAfOjW4kJtfFH+PPeT/nobM5Iw63rn8A1f6XPTr6h49BpXODXqX6eJgXB
	c9FMvuqgXalSF7e3Q27wVzGUgsmgQwR+3LhbIH4a4M6MKPzblJXdPGpSUgwtSq0T
	qa+KKMitukxLhdY9h6kxIeh+ACR1GvT2e1ENeZXMLv4b67uoH5pm/mRGaredBL62
	o3srFlsAjK768gcfYdrpUKeO/EqES60Yz1x1T5lJpkzhaHnXnFwFRB06jy0Y0gdD
	hP4COxfKel/5eEsNWvpeGqxFmEPL3KRoHaYyJMjzDUy0ygzqQk/hNwnSnXRadI2a
	56eQ+c+C49/plXG39S9EA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834501; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:KIVkDHldxDji4mhGkCiYE3Bm3jVrDnFGpcteAhLHabb8uYw
	LUezG8XPa2w+WV5Dibm87q4/0Sb+DOWmTwxFaMA5CVHI4QFxupwG6fxjtlk87RBi
	/Hz0MI8pklJM8gJChhKNJ3eGCVO7lRb1TZMnXevZlOJ7b+C2IV3j9J+Yy5u9Dc78
	JU1wRAxkgazxF8rAOBcQPszRo5/YyXSTH5cQB66FzosqXzakrpFIDPPNucw6VkuJ
	R2KFALTiikPKT+uLCF5Ez8O1Avj3FlAW/r+q9mTSSYT5Jgxu+4aNPLDTy+MySIzS
	1G6TuRRZcBQ/7E7Uju0fuFCyGXpbmvIk05N9gzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J+Ofgxti8CBsK2Soq1vWw5Y0ChStLg4jxRakYZ8WVr4=:Wr16v8z9CK3H6elhSGntwyxm+4xr0PtHit+W5/FLyfk=;
X-ME-Sender: <xms:RQD7aj8jVMQoMSNyTjQPLPVuK9pMOwDtF6f_79KB-ojbi-Ie2xgBJQ>
    <xme:RQD7amqwMfbtgn9rBBwazJrZ01z7VCUOCkmgTwk-mGZbShy9UsDSkRe-idtI_rPJr
    RLKf7aqXQXqRf1KJhMyAaybbwwx5NiPmCcfD1KvPre4cjeUVo10Nyc>
X-ME-Received: <xmr:RQD7amrEgYHGWIdK_CymMnWdA5iasxtWbYRg3ZC_9ZsRs-TXJ54ygUgzgsGWbEEVboFxmzA>
X-ME-Proxy-Cause: dmFkZTGziUKUgJYsbiHWfb5HWuWorQnHHq6YP0ByYpkZ6e9sVItzSNrjxVNiJjpykGt6EH
    +Wo+jZCDwFt+/bcnf++syQUvL1OVsCKhGqPwr3BK64IVWifW0xci0pdI+2+/Q2cKlJ86Bw
    MPjq5Gxm3EfNjPHHZxB/qKmy2lYBxm28RGRVDzQY/DL8x0mrFRQC08IpgtrlSdKQSvTTzK
    jI4Dzrh8Ro4PE+97yI0qzoNNhqp2HeoBh5o/zQx/r+4v+GKIjmbaBlrMKGm2iApi+hz2OH
    ZU0TLEDo5HjB+hj+++nQGClhpGKhIpSL+UXhvZrJuTSG26O5MqYj9dLI/adyQM7bNfpGsG
    44uvTLU7WLaJk9CCcaus6ubeYullY0dn1sxHhZNnWazkCA2VSqmCChc6MWkW41kONyLXiV
    sMnEp3xij6rag4GD3SBVNZ4PVPyQOXvQADYoXhHC1tjlCyoseaaqNKotvRhIdlomwrXC4S
    M64gkOEG9OCjIxWrpV/dVKbk2RFbnAFSTSxjZJeepWwT27ouv3NDuctYNRhYB5YQrqGsjh
    kycuVgtuzZC45mWgL7xKlqm88yZ4PuYrd+/oJte3LHAkMFqyJR+7lg5UZ20pKI4U1DUXwf
    EgfUdXOhwsaQqZ4CXMXXNcIZx4A54yInUnDUsaNbmQtjADO60G2WGP40YMfw
X-ME-Proxy: <xmx:RQD7akle5SA66wznzAza_iwSpiO3-necaCyRC1qHqCk_UrWuDGYpUg>
    <xmx:RQD7aoGwz-4eQJnvyQiPGvSVzkcw6aCC9bq98OxQKIrmfcdj5DX-XQ>
    <xmx:RQD7atr5mJ1jsRumBdHkx_z43UsrptY8RuC_NnBw17LpEwW0MespmA>
    <xmx:RQD7ak5Hk_oGYAig6to2S7r2lvsl260SLoujVKBiRHESvmSRm0dFNg>
    <xmx:RQD7avvRAaCDEfeiU6S-dHFRW1Tl4XjmgSfegm9Uy4RRSbaFPXtQ8jJe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e9a46cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:46 +0100
Subject: [PATCH 10/12] odb/source: make commit graphs pluggable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-10-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The location where commit graphs are read from and written to is
hardcoded to ".git/objects/info". This indeed makes sense for the
"files" backend, which also stores all of its other information in these
directories. But other backends may want to store commit graphs
differently, if they even want to support them at all.

Give backends control over how commit graphs are stored by making the
ability to both read and write commit graphs pluggable. Adapt callers to
use the new, backend-generic functions where possible. The one exception
is "builtin/commit-graph.c", whose "--object-dir=" option allows the
user to specify the target object directory. This is highly specific to
the "files" backend though, and consequently we only support that option
there.

Note that the logic that locates commit graphs is still hosted by
"commit-graph.c" right now. This will be fixed in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c     | 25 +++++++++++++++-------
 builtin/fetch.c            |  4 +---
 builtin/gc.c               |  3 +--
 commit-graph.c             | 13 ++++--------
 odb.c                      |  6 ++++++
 odb.h                      | 10 +++++++++
 odb/source-files.c         | 27 ++++++++++++++++++++++++
 odb/source.h               | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-read-graph.c |  3 +--
 9 files changed, 119 insertions(+), 24 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5ecce4b6caa..6ee644d8487 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -277,23 +277,27 @@ static int cmd_commit_graph_write(int argc,
 
 	if (!!(write_opts.flags & COMMIT_GRAPH_WRITE_REACHABLE) + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
-	if (!opts.obj_dir)
-		opts.obj_dir = repo_get_object_directory(repo);
 	if (!opts.enable_changed_paths)
 		write_opts.flags |= COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS;
 	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		write_opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
-	if (!dir)
-		die(_("could not find object directory matching %s"), opts.obj_dir);
+	if (opts.obj_dir) {
+		dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
+		if (!dir)
+			die(_("could not find object directory matching %s"), opts.obj_dir);
+	}
 
 	if (opts.stdin_packs) {
 		struct strbuf packname = STRBUF_INIT;
 		size_t dirlen;
 
-		strbuf_addf(&packname, "%s/pack/", dir->abspath);
+		if (dir)
+			strbuf_addf(&packname, "%s/pack/", dir->abspath);
+		else
+			strbuf_addf(&packname, "%s/pack/",
+				    repo_get_object_directory(repo));
 		dirlen = packname.len;
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
@@ -323,8 +327,13 @@ static int cmd_commit_graph_write(int argc,
 		stop_progress(&progress);
 	}
 
-	if (commit_graph_write(repo, dir->abspath, &write_opts))
-		result = 1;
+	if (dir) {
+		if (commit_graph_write(repo, dir->abspath, &write_opts))
+			result = 1;
+	} else {
+		if (odb_write_commit_graph(repo->objects, &write_opts))
+			result = 1;
+	}
 
 cleanup:
 	string_list_clear(&pack_indexes, 0);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c646bc6698d..b7606016817 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2978,9 +2978,7 @@ int cmd_fetch(int argc,
 		if (graph_write_mode != GRAPH_WRITE_SKIP) {
 			trace2_region_enter("fetch", "write-commit-graph",
 					    the_repository);
-			commit_graph_write(the_repository,
-					   the_repository->objects->source->path,
-					   &write_opts);
+			odb_write_commit_graph(the_repository->objects, &write_opts);
 			trace2_region_leave("fetch", "write-commit-graph",
 					    the_repository);
 		}
diff --git a/builtin/gc.c b/builtin/gc.c
index 68cb04a672d..f9a15912d0e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -741,8 +741,7 @@ int cmd_gc(int argc,
 		if (!opts.quiet && !daemonized)
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-		commit_graph_write(the_repository, the_repository->objects->source->path,
-				   &write_opts);
+		odb_write_commit_graph(the_repository->objects, &write_opts);
 	}
 
 	if (!daemonized) {
diff --git a/commit-graph.c b/commit-graph.c
index 0ae9f586f21..7fea94689a1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -42,7 +42,7 @@ void git_test_write_commit_graph_or_die(struct repository *repo)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (commit_graph_write(repo, repo->objects->source->path, &opts))
+	if (odb_write_commit_graph(repo->objects, &opts))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -747,8 +747,6 @@ struct commit_graph *read_commit_graph_one(struct repository *repo,
  */
 struct commit_graph *prepare_commit_graph(struct repository *r)
 {
-	struct odb_source_files *files;
-
 	/*
 	 * Early return if there is no object database or if the commit graph is
 	 * disabled.
@@ -778,12 +776,9 @@ struct commit_graph *prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return NULL;
 
-	files = odb_source_files_downcast(r->objects->source);
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		r->objects->commit_graph = read_commit_graph_one(r, dir->abspath);
-		if (r->objects->commit_graph)
-			break;
-	}
+	if (odb_source_read_commit_graph(r->objects->source,
+					 &r->objects->commit_graph))
+		return NULL;
 
 	return r->objects->commit_graph;
 }
diff --git a/odb.c b/odb.c
index 5dd277761b1..ec5064c3cd0 100644
--- a/odb.c
+++ b/odb.c
@@ -839,3 +839,9 @@ int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
 {
 	return odb_source_fsck(odb->source, options);
 }
+
+int odb_write_commit_graph(struct object_database *odb,
+			   const struct commit_graph_write_options *opts)
+{
+	return odb_source_write_commit_graph(odb->source, opts);
+}
diff --git a/odb.h b/odb.h
index 857637f9805..099ba998faa 100644
--- a/odb.h
+++ b/odb.h
@@ -221,6 +221,16 @@ struct odb_fsck_options {
  */
 int odb_fsck(struct object_database *odb, struct odb_fsck_options *opts);
 
+struct commit_graph_write_options;
+
+/*
+ * Write a new commit graph layer into the primary object source. The source
+ * is in control of where and how the layer is stored. Returns 0 on success, a
+ * negative error code otherwise.
+ */
+int odb_write_commit_graph(struct object_database *odb,
+			   const struct commit_graph_write_options *opts);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/odb/source-files.c b/odb/source-files.c
index 0bf15031c87..5ad27fd4bc7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "blob.h"
 #include "chdir-notify.h"
+#include "commit-graph.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
@@ -1230,6 +1231,30 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
+static int odb_source_files_read_commit_graph(struct odb_source *source,
+					      struct commit_graph **out)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		struct commit_graph *g = read_commit_graph_one(files->base.odb->repo,
+							       dir->abspath);
+		if (!g)
+			continue;
+		*out = g;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int odb_source_files_write_commit_graph(struct odb_source *source,
+					       const struct commit_graph_write_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	return commit_graph_write(source->odb->repo, files->dirs->abspath, opts);
+}
+
 static int fsck_commit_graph(struct odb_source_files *files,
 			     struct odb_files_dir *dir,
 			     struct odb_fsck_options *opts)
@@ -1335,6 +1360,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
 	files->base.generate_pack = odb_source_files_generate_pack;
+	files->base.read_commit_graph = odb_source_files_read_commit_graph;
+	files->base.write_commit_graph = odb_source_files_write_commit_graph;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 7b56f51b827..bc9604f7df9 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,7 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+#include "gettext.h"
 #include "hashmap.h"
 #include "object.h"
 #include "odb.h"
@@ -32,6 +33,8 @@ enum odb_source_type {
  */
 const char *odb_source_type_to_name(enum odb_source_type type);
 
+struct commit_graph;
+struct commit_graph_write_options;
 struct object_id;
 struct odb_stream;
 struct strbuf;
@@ -285,6 +288,29 @@ struct odb_source {
 	 */
 	int (*fsck)(struct odb_source *source,
 		    struct odb_fsck_options *options);
+
+	/*
+	 * This callback is expected to read the commit graph of the source,
+	 * if any. This callback is optional. Sources that do not support
+	 * commit graphs shall leave it unset.
+	 *
+	 * The callback is expected to return 0 on success, 1 in case no commit
+	 * graph exists and a negative error code otherwise. On success, `out`
+	 * must be set to the commit graph.
+	 */
+	int (*read_commit_graph)(struct odb_source *source,
+				 struct commit_graph **out);
+
+	/*
+	 * This callback is expected to write a new commit graph layer with
+	 * the given options. This callback is optional. Sources that do not
+	 * support commit graphs shall leave it unset.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 */
+	int (*write_commit_graph)(struct odb_source *source,
+				  const struct commit_graph_write_options *opts);
 };
 
 /*
@@ -540,4 +566,30 @@ static inline int odb_source_fsck(struct odb_source *source,
 	return source->fsck(source, opts);
 }
 
+/*
+ * Read the commit graph of the given source. Returns 0 on success, 1 in case
+ * no commit graph exists, and a negative error code otherwise.
+ */
+static inline int odb_source_read_commit_graph(struct odb_source *source,
+					       struct commit_graph **out)
+{
+	if (!source->read_commit_graph)
+		return 1;
+	return source->read_commit_graph(source, out);
+}
+
+/*
+ * Write a new commit graph layer into the given source. Returns 0 on success,
+ * a negative error code otherwise. Sources that do not support commit graphs
+ * cause an error.
+ */
+static inline int odb_source_write_commit_graph(struct odb_source *source,
+						const struct commit_graph_write_options *opts)
+{
+	if (!source->write_commit_graph)
+		return error(_("object source '%s' does not support commit graphs"),
+			     odb_source_type_to_name(source->type));
+	return source->write_commit_graph(source, opts);
+}
+
 #endif
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9642e55b8c0..d6174bb55f4 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -85,8 +85,7 @@ int cmd__read_graph(int argc, const char **argv)
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(the_repository, source->path);
-	if (!graph) {
+	if (odb_source_read_commit_graph(source, &graph)) {
 		ret = 1;
 		goto done;
 	}

-- 
2.56.1.763.g16177fe143.dirty

