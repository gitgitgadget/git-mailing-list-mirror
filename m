Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188960;
	b=yUn9YmqmJ3L/35ikmfTBoM4p5XTAW6/F6sxICgb3PA3VUcrq9lJ2/ZzEpW6ONOWWXjXb
	 f/aiXl8n0hMCpKXn6tfd5d+34SU1Hb4K/SVOAbc/hAMRNFdXnFOBqcqTNy6H1XvGbOxY6
	 vkGw9ocNvO0Lthy3eccoYUdUypqw9hSvGJIoVTywSPCeQDHMx5nRJ0K3vWl/Pk6UPRIWQ
	 8A+qGGigreKtJXu7gtDfQFPp/WFWmSS38IwtvqnUQyXycNm1IsOxj2WcoxWS4WtYV9yD1
	 kDF1YeuEzhOBvfL1G6qJbf2b1HOMlkMz3hz7mnDr19SRMSNsUhQKrnJCH/Bjb1lZH/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188960;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=z6TSXyeicbFhQOrwJ+znA8UONhDmB71ZRTH+HItthN8=;
	b=p+1VRG7A4kd+/nnfiZD07pb59Doj/jvBCNVy6+ibA+PXnqtZSIyHG68Qafx7tplopSMO
	 b7WE50LZMacv2ZYaHrhs2TK2HZ/9qOD98CyQ1Tp4vQqAi6Kgb5OB4+jW4bjM4QDXuG46r
	 oq7nwZzkJnwnwVDsIRc0sqSZe3Cb/nfSgsaL6a19CJwx8SbKPvRVYVXYSbVtO/+NrxZjp
	 5TS7xqPFwMknz2l7rcNB1W7XWhibN0Wf8iSxk8ZWv6fMaZMyshxvQxCBwzgYQJ9rCOoLv
	 bCr5SSCnDlKIMn2zCtTWgl/xcbmtk2NzwoTcAVAV8aY6Gx//xwYKbxQlISKg3r4fVgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="JLBI/6Eq";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=h2ouky8F;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC08606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC08606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JLBI/6Eq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=h2ouky8F
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 05D19EC008D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 08:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188959;
	 x=1793275359; bh=z6TSXyeicbFhQOrwJ+znA8UONhDmB71ZRTH+HItthN8=; b=
	JLBI/6Eq9hVWvchPH8hsRIhjVW3oXZ9ktho7cypXJaF7lIsRV5Wmz4KEmO+hnuVL
	arZTvDxpQsgn/BFYBWZgGM6oC62MBDz38oIExjdBzI9Gb4Tk5mbixk/RhBDuHrvA
	44brH8/9drZNjD8dpHaW7bG/zi3yPTilQWXpeFp/X7idBqA9W2bqVImModq7W6hc
	ZuF6PXhkhQ37nYmojs5LC2AsMnNe9qt4C2QjOfEwKJVNtXPw5uaZ1OSOPTpYsVZz
	AYeEVApU2PVtGx48jMILjGjUzj7T/iqmQb4ckxadJYYwsgTohTEYY/2YOZ4GKV0A
	2QxBPgZVRqlK1sWjGCaz/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188959; x=
	1793275359; bh=z6TSXyeicbFhQOrwJ+znA8UONhDmB71ZRTH+HItthN8=; b=h
	2ouky8FBlWzxy968dSvVqhdwKBFsuhgtwC1v198JU5JwSPotvuyubw3vVsDQs+rS
	wNt62VS5J74CwyHt52pllXZGQevRHdvX36NQGH4zt60LL3E5xVulngbfPMLhuYsb
	weG+DCayh+qpUKXEubj9Ug+WsowHNS2rhLCjP3NuB0sgbicXzaC5JQ6r6LI9oief
	sJFyELpTDsYtls0Tn3pidscadEWYikFeAqUjWnmlFWYm2TpzVaLA2bDyZy/D4pI0
	EBKkta49SlZNA/5yFiT/Lxh3rxIj7HoFchdD3jmuVe4b6zY1YgzhrPvkECfJEhLu
	cQM+H+6JgqqirlXxivgqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188959; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F6hPZpEfvljzzoSsFJCpGmf3zE3X6qay/TLP3RWQWv13IhN
	ulFEkDRLJEPX/dZ02ASvs11CDPbUW1XHpkTggarJwLy3TiTA7+IFkCsMea1oDM8Q
	4ABsWWufVczoKGerMXfW5kSWg28EEqms1JFj2mvbVChUfHfpznZGdPCarEZ+LcNQ
	4jJ1QDaANmvZnyTMMgzOvL61c2r3LNVXT2ra1MDSew2ePpY2HXdQPpwzVwrDHjBM
	iqkkRBjzHfBmTI/9aHr1Pe6aHPAWzh92NgsylX9FefiyIpfBS895kYXA6kUe+AI3
	foNIIlElSqV1j2fpTUn1VmJ4e7BCiHQTg08Ry9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0VEGd/78FyRBtqA0XUV4IeGxo6i/Xe/tDRMHeWu664E=:GV6C9R0Ubc4ju3ANJYb5qQ0DGZQov7axxXw92lmPPPY=;
X-ME-Sender: <xms:XuThaqJ6amGBYDsiBsfYlzpu4Adh7pt6DtV6SRg8fTiJ2sH0usiDMw>
    <xme:XuThapHXe1TRs_jqBCfzLcEo5j2p5fIKhJGd6eH4npwlrwhT_c9eWSXIpfiVO_NGR
    LMxzGoFBxqB5vnrIzIGVCh1vmfNXFBbvWOuPozdyD1RJtwXi_6GUr0>
X-ME-Received: <xmr:XuThagV6NTCgsi2bFPW1TWkalwM4ZfS-Rw-h9zVTfkL65joCrf9GpQ>
X-ME-Proxy-Cause: dmFkZTF2Mc3g8z5gD8+pUCnfHo0lMqlp5+WCfQ6DsmMs7ZRLfmLWaPAYb3OxASUOPEyWii
    rrGgpP73XAFgqgFdZiQVcNzt70BknD6/ZmmrBAMiD3EdIwO8hYWgJwBghKUmNI97PfWjJD
    dgtYN9YY/E9q22Yhy2fa1Ym1d7UZTvT8Vq/JeZlfbe+TNu5Z8lvZt2oScPfQq0wGB7wmKU
    8IuWikhTGkGoqr4o6kk9jMI6s5BGPq64SYLjB8oDNH2FzUqfRY7ONmZsx4k/2aG8zqU7e+
    d/F1HDktwSDIEvNqnYSx2X+hHzOrsWqsioMfYGiJmCA0Ad0vys5hak9zDzQvBEnHvC85mN
    yCNw1VawN/9CNFHHU5SumeO4c7wenymeB9cHBO4kAvhdSjIuPJRSXo3pB/t/HUA7zyayZR
    D87uTM/CHE7sN6uKwKIqpqPHSKK6aSiMnSsyAvpnOH5c4O3ECn53oh1TjCQLqbYD/j1of4
    +c2SUbS3L0lGT5B6cQBXNfAnvPqEh2rHMahAZ0zjv+lKf7Pjy5m4hKG49ORViIpvIWz/O+
    FxY6KZJEGQ1SaDNNgGgSBiUkSaZNH05d4gIUyn2zvCiDOQpFSS1Jp69Lp8c31TH695Ba1g
    cl7kS82y986jAkkgfEKofgI9WJdNfJA9tHsXoxMipXXViM8MgwGbKU51JRpw
X-ME-Proxy: <xmx:XuThakjzds1EIasz5bQtEbKnp_jSFs2XyE6lGvBKsLt014SjqxXk1g>
    <xmx:XuThahQ7vbEcyMnIIk00hScDozMKarB3hEy8WbA2s5HReiQLbbIafw>
    <xmx:XuThanEMwUA6RCS8xa7K29VkFNKX4jJ8FjJn6_u6PYkClgQwGwJ2nw>
    <xmx:XuThapnbioh_-N_dtznFwnlTcuTCkAFsjQwiYReDyUCUaUv1HHzK1Q>
    <xmx:X-Tharqkrrc6EkAZy5rtgI44516kPXJv-p_b-SI6hZYDBWqUkqxsbLIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcc444b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:53 +0100
Subject: [PATCH 1/7] builtin/commit-graph: rename subcommand functions
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-1-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Subcommands that we wire up via `OPT_SUBCOMMAND()` are typically called
`cmd_<command>_<subcommand>()`, but we don't follow that pattern in
"builtin/commit-graph.c". Rename the functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ff244c866fe..415eb6afee9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -65,8 +65,10 @@ static struct option *add_common_options(struct option *to)
 	return parse_options_concat(common_opts, to);
 }
 
-static int graph_verify(int argc, const char **argv, const char *prefix,
-			struct repository *repo UNUSED)
+static int cmd_commit_graph_verify(int argc,
+				   const char **argv,
+				   const char *prefix,
+				   struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
 	struct odb_files_dir *dir = NULL;
@@ -224,8 +226,10 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 	return 0;
 }
 
-static int graph_write(int argc, const char **argv, const char *prefix,
-		       struct repository *repo UNUSED)
+static int cmd_commit_graph_write(int argc,
+				  const char **argv,
+				  const char *prefix,
+				  struct repository *repo UNUSED)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -362,8 +366,8 @@ int cmd_commit_graph(int argc,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_commit_graph_options[] = {
-		OPT_SUBCOMMAND("verify", &fn, graph_verify),
-		OPT_SUBCOMMAND("write", &fn, graph_write),
+		OPT_SUBCOMMAND("verify", &fn, cmd_commit_graph_verify),
+		OPT_SUBCOMMAND("write", &fn, cmd_commit_graph_write),
 		OPT_END(),
 	};
 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);

-- 
2.56.0.341.g393f52fd96.dirty

