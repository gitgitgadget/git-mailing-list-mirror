Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834481;
	b=yAc9Z2FF3FrKSXfO8mxlwFBjJIQ2VurF/o+ygoY61QS2OwtUjylwUvDL+q+xunoF8JE+
	 Hg1WGbmZUwDPKH85Q2CQTg2DFywumXeAUiljsRy9TFDTWuo9ALdbGc8HvF/+CLtvawQxT
	 xaszbkv6Tea9+83D+IFd2Vx6WtAJl2Mrx2hlMahvDe+X7EcjVZBsTOydlRbEMJ/XugZJ2
	 kjYwq+3eVFd9jmKy2Y3iUxVWAF+F+fbklrWYK7CusodEIit4kiXJZFsowiVAG7GQjFyqK
	 aK/NsZFOdoOl/QvLZDiJVyAsH3qrOrJ8hw07b5QsGo2Q7dxS4Jg2IPztby17n/zC1sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834481;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LAxkXf7OXzxSeOdcgr04xplgj5lOn8Vk/IdlFkj1RHg=;
	b=HQaaWMsTTU/740mzQLRg9KOkMlbG1cSZjE/wgN4tWpJw+4hYvgo3wz7NvErF87DpzxP9
	 h+Vvav+8S3LijQy9veEm2JL87zv9ZjuEYG9aFt8MWlc3+7I+5l/aO3pvcR9E8pT9VpAbv
	 fbBw3Hs1J3myNtQjYksFewx5H74CgBDC3Y+03wBOGbK2XmJu0wAwreIzydw6TGCtOABHm
	 CJw/LWyQHYFDqXugM4cdtR/5q1E7da8y0N1XxWRooYoLj/iHRtBvqOF40Qlkyxv6aJ/Ox
	 w4TtAXmcV5dab9CN4E4i/38T76Wnb5WC2DVPnOpNmd+1gjbB+mI9r07jem612PqWF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T6AFMoj9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="QIr/TbWY";
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4638606A339
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4638606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=T6AFMoj9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QIr/TbWY
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DA094EC0102
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834479;
	 x=1794920879; bh=LAxkXf7OXzxSeOdcgr04xplgj5lOn8Vk/IdlFkj1RHg=; b=
	T6AFMoj9s5kWUQpSX5hlXhXJ1vPm0AMHvw3Us/+BWB5HZUTfATXTmgG91V0iEVHI
	Jfg3QrAiUVZhxyVK0cctrCfGyaEjR+fswjDNuHyB3cRdcPGdH8x2BmQLcxxzhrDh
	/eJCZV3mrhr7h2fDmmekLJvENR9hjEqcqvo/i9RcnfKMqnNNXhOcijnYePom+Yg0
	OCkjEEOAB59XnnAcVP06vRvtshsPPMUOngkgGp1V/UkDukNEQa3blq9LnjCQKtDF
	pucveTnWELydWR7rK5e+cGQX/X4G7YGtqptd231EfBq1Nq5YV++E6KbPFf9j1A7T
	SxSv5lJ+3VKJa7y0FcuMjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834479; x=
	1794920879; bh=LAxkXf7OXzxSeOdcgr04xplgj5lOn8Vk/IdlFkj1RHg=; b=Q
	Ir/TbWYipTQhyscJcg3IfIDfHpNpEivfhCI3xSHHoaIk8Ov9VpS5GZMuqWnTs1HY
	gJGC0wopa24AEwD3ocG66W/JVN9mePIiQlLoEKvPy4IEfTs2UDXtLWI8qXeWhAkY
	qgyXU00DGGK/VxuUsUtCwdjbRlFpICA6eeU8PFaL2kRfeWbI2hT7u6F8zf3B6krT
	53Ag2YoAbgSckuSAjrrtpLz0YhXpXiboIy3x2wahCRzyBa6rv9gMmH+ocKpljTmW
	pAlehpB1ZRRjylkO2KKd0yf0V8H8twaLzHqvMdGXeL7HrAQmkzQfpG9P2U/esQfg
	S8Dpwb/+ss0RU4Nht2YZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834479; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZU/3Q/olWNs6Em988m04qXGT9jdRotacf1Vs8uJQXfC1iCl
	a/TkKGhNEcxWLs+wD8VqAeEXWOxsvMzpgZXU5h+5FAfFVqoAn4NX9ayloKkVgU4v
	To9MYTMCR0rbSbUIPNixPdYcUQDT78biYQl7YD4oYPg9OKFg5I5SbemJKzKN9d9P
	99zMLIZwRJe5YyoUI8dwHVHF/ZljOqEUpGxdlJjgGgtdfW50z5vo1u2+3rjSxTH6
	1Fv+UitH2e7pMJ4YjR6RoOdaCxpDPNdizo7ikSau0dDz2/DPKStdN8MNdK3EL0/v
	rYxtFzMIVActFGfcTqVPlxSnG8nhqsFu3uS7O1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MsQOODwLqb2h9THwe4pOfqkbRDuEpLS4VGrdLUla/Ts=:MqFGUYb28BdfspWKm3yMMFIO63Jpv4ewfNKhFfDlheI=;
X-ME-Sender: <xms:LwD7as8cTGKBaV4Er_H3ZqwfecjUcQn6r_mosTRk10WnWS_FKzypbg>
    <xme:LwD7arpSvvMsGe-c-_xtjBdokL5xC3OAcfUr3HrKGzqjbCrfeb5Oa3eCJJlW0MnlI
    qZAEch3AEodoY76sK7KPPNedkJup3RE2_NRehmKXgZ37Z2MQoDEIwc>
X-ME-Received: <xmr:LwD7anrA9tE5_sJrXCditIpxEDNgym92pqNFMIvCNmSYtqQVBnV8dhIdm_6DXHeDN0AhSZw>
X-ME-Proxy-Cause: dmFkZTFZEY3dRZaxYHKztVo3PV5exS7LC5so/OemZvN+WRzyMAuPxUkF0s8DXR9rm3sIft
    TNy3msB44N8fedNp8OEKsFykHBMtYYTrfbK0L+IwZ5LKw3S98nfrCPUmkqNy5t4VRzNB1H
    O1k+n5la66tVUCb3ERJIwzKtcyG8zt2k7Nq63bv8Bsb1mnjRJ95cbEfwctWmirTzT7W0Vv
    +wbH8aDjSJMImH6U0aTopBPlpGclwtUfOlL0sb99rKBTgdFJT1iNWAATNvrbto6s5wHgrA
    pyryLSwJgJXsiTvNzA0Sp3b/jhixtqv/ivz+VDrfFpK2d437jTBw6zWR21v5KA2lf8++VY
    wjfEuIpF8mtSIu73T6Erd16WHlMu1UDy+W3NdpYLuDGEZL5Qz6nZEMk5JRII0Nvrc3DtSC
    y2S7fGNN1RerdxJClLqr3OrkzaYTR/wDpjve5GXbcElOfdrFkCy7knOgg+KKZSU9Nthjtz
    9tlKFhxC4mvGLsOlmtrAJy6HFuuLSNsfg1cuPtbQjBLPugygEdqFXU7HqKWN8eUql+nt6m
    ymW0hdVJcoTlr2h6/k3VJZawReO1x/CaM9BdjtzNKzomYectaWf8QY4TjBeLGjHEphRAAi
    RyQMom+Pp+C/DTDSOJHxpIsRuLVXp63ffucj3grY0b6ohDsLwfrTFvXOO5oQ
X-ME-Proxy: <xmx:LwD7ahkR67s7y5syR0WdKaaxpR8rhn5kWKqGd02XV45fU26X1dwUCQ>
    <xmx:LwD7ahGzo0bQslzmbGWwUH2bwzIgoM7INrj9xpSsyVAMT-TRLPDqHA>
    <xmx:LwD7aipx67mBjPp6sSb8Q2t8p6rg-FHQ4GA_IngixgxtB6B9PytaDQ>
    <xmx:LwD7al70oX6RlxIKr3Nlt5wc8VcuMXpT8cgtOYoifAi5gJkgI3JE7g>
    <xmx:LwD7asvYGQ54wnJkDqAI1urceeTemL4nTuM3Xgve_x21swXa-4dv07I1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 753023e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:07:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:38 +0100
Subject: [PATCH 02/12] commit-graph: simplify reading a single commit graph
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-2-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In a subsequent commit we're about to move the logic to locate commit
graphs and commit graph chains into the object database backend. With
that change, the responsibility of the commit-graph subsystem changes so
that it only provides the functionality to read and write commit graphs,
whereas the backend owns the locations those are read from and written
to.

The function `load_commit_graph_one_fd_st()` is responsible for loading
a single commit graph layer from disk. It receives as input the file
descriptor and the directory it is being read from. While the former
makes sense, the latter doesn't: we already populate the graph's file
name in `load_commit_graph_one()`, so we populate paths in two different
locations.

Besides that, the actual paths are about to become a responsibility of
the backend. So arguably, generic functionality that loads the commit
graph should not be exposed to it.

Stop passing the directory path and instead populate it in
`load_commit_graph_one()`, which will later on be moved into the "files"
backend. While at it, rename `load_commit_graph_one_fd_st()` to
`commit_graph_read()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  2 +-
 commit-graph.c         | 15 +++++++--------
 commit-graph.h         | 12 +++++-------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8194a528406..2a5a75dc22f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -111,7 +111,7 @@ static int cmd_commit_graph_verify(int argc,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(repo, dir->abspath, fd, &st);
+		graph = commit_graph_read(repo, fd, &st);
 	else
 		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st,
 						      &incomplete_chain);
diff --git a/commit-graph.c b/commit-graph.c
index 94c761907a0..c427a6f90f7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -257,9 +257,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
-						 const char *dir,
-						 int fd, struct stat *st)
+struct commit_graph *commit_graph_read(struct repository *repo,
+				       int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -276,9 +275,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
 	close(fd);
 
 	ret = commit_graph_parse(repo, graph_map, graph_size);
-	if (ret)
-		ret->dir = absolute_pathdup(dir);
-	else
+	if (!ret)
 		munmap(graph_map, graph_size);
 
 	return ret;
@@ -508,9 +505,11 @@ static struct commit_graph *load_commit_graph_one(struct repository *repo,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(repo, dir, fd, &st);
-	if (g)
+	g = commit_graph_read(repo, fd, &st);
+	if (g) {
+		g->dir = absolute_pathdup(dir);
 		g->filename = absolute_pathdup(graph_file);
+	}
 
 	return g;
 }
diff --git a/commit-graph.h b/commit-graph.h
index f0e7cc93461..8660c7fe698 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -117,14 +117,12 @@ struct commit_graph {
 };
 
 /*
- * Load commit graphs from the given object directory `dir`. The directory may
- * be given as a relative path; it is canonicalized internally so that graphs
- * loaded from the same directory compare equal regardless of how the caller
- * spelled the path.
+ * Read a single commit graph layer from the given file descriptor. The file
+ * descriptor will be closed regardless of whether loading succeeds. Returns
+ * NULL on error.
  */
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
-						 const char *dir,
-						 int fd, struct stat *st);
+struct commit_graph *commit_graph_read(struct repository *repo,
+				       int fd, struct stat *st);
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);

-- 
2.56.1.763.g16177fe143.dirty

