Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034129;
	b=qlWyHcskvd2eIjM9DDC+dWMeI9WOT9oHm4ORhvZqYgL4LYCvsRzq8tB0G2/onAOLWea+
	 BuyfHNEmxG2Ckg16h+isfIiZqvS266Eykqgq+vgQ311ORadFnT+9MxSRtOEAFCnkGUgAW
	 +vJGlITFJi2JpnzIdArUBGzM9BVW/6WOopc3a03VnrFT5SA3U1cJZDA8W5mNZqC1C3jmv
	 Vv1Ur4TIjJLZPzq1hgUk6KpFkGGv0IvKW6918CV1Xkn4GbT52WgMHKqBRZ1FxTqQxw96f
	 gF8yByPSirtsmv+gEZCgBb5ezJHDnjRQktK/JyvfgAUhVYElS6NWQYo9SD6LOyGhi9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034129;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=HgWz28NJgGHbHQexF/jD9tI9uYuVKSDXX/wiWKGg8t4=;
	b=HPGw0DE8uc+dHDFgBnghMgk3mb3vi+JkovS8hxs/u4Rzy3zbdP8zVGA1C7UT1EdFYKvD
	 LhzwDHyR7DPV0d+H9Yn9JyOaEWUULDxSnI7SORiQjYpTJG69YQVt+ZAeYkJ2n5Fu6McnV
	 jOiWbYe//MD4wIS7Wr+vT+9sQbSXF4oL0rfdui+xurmvPk2h+/rbG1Ri/Lu1mUH4JnphU
	 iGVadbzzbFKIpke3uQaxlqvBPvP0udTD3dSUOo+KC1APQrOSjgcIfIZXYqG59aRi5RGk8
	 XFFEPUQLQCbCagPnwudHcACtp6VpIXi1v/zPzd2V0vv/CIL0rhgh5xQI6r11sl+BCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=BXPTvM3h;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mAo3j8K7;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4B606A33E
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 20:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C4B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=BXPTvM3h;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mAo3j8K7
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E94287A009D
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:35:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 15:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1795034127; x=
	1795120527; bh=HgWz28NJgGHbHQexF/jD9tI9uYuVKSDXX/wiWKGg8t4=; b=B
	XPTvM3h1bes2toJ06ig9gr/Y5t/PaRqsfvF1JvkRl6eYke94lVFoWZOAd5G+PtJz
	b5omat7sOH+6LMfQM0vTFS4VitM0GXTe7JlWPsYWD3/4XP9Bk5yDza/w6yKOAa8i
	tH8Xx3p9YHt0OPHaqwL9R0YLvoApkctflxJ7N1VUZA7/i7wA7lfP9h2XRlWqOC7V
	U3S2iYV9UXGtvs8mz1FQBWRFLFhuq5qmrAEZGuNw6WzeFGOhAtGmt2qbeaUP56jB
	5s1Ptjo/V+RM9srHOWk6lVeEl8qG3wPYs9MOHlvgX8nzXSjdJW2sZodd4AuiqpDD
	bMylf2gnBosY96pm+2DHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795034127; x=1795120527; bh=H
	gWz28NJgGHbHQexF/jD9tI9uYuVKSDXX/wiWKGg8t4=; b=mAo3j8K7YusXwhg4K
	vPiDPkxaT8o+codJLOBPb/K/GytROoX1aNUglfmG/0KyeBAq0FcbHb5ILFOpsC5F
	bqUmnBMT2w5eR5L/BBLo5niVfKb3q8rEd+GQnvh9kqdc2a4LUu0IqRmQzshWZKPG
	rfW45zwUeAvSaYrNtJTYXN2a1Q6jyNN3UuteXBChyaTnkUlG1EioBfb1lVqaFvpb
	q4jt20RaJAb2qAC+Kp6OPHTQ47CVs0BAqWNt09p34yQcEk+aZGud2qgaArElHhCC
	74gCEn2a24EtigRozyS68U9nW1ihrWNstaJq4rPR4jEwSaA+wW5DUnzyy9FWStTD
	hp5Mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795034127; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HwDP7lD1QF2ep1syO6cEvOo7IxKmkZ2HsXEr4zi8MsJQxRo
	lyeDJe2EpyrtYSPOocM5c4eK/m/ouQX4pwQgW42BLOlCEAxHXLdbEPrzbdtLmTi3
	rovGvLT8Er8h2wTnp/g7BTK8ohNddBFV6ho7LRKZ+tsX2FBaCCQVJIFaSH876TAu
	/VIxaEmhH895W56FgkvXKG80jAOERWjT5PMcyMEoqycuOpyjheDjdBvc7NNGxhGB
	dfxTwl6TyLttNijk6xzjFIUeUVZObd76sitUlgf88h5XsPuaEb7qfuZBKZH3nCPF
	/tPevdo3DkZU1ysqIEeB10/VhYlKa26NTtFrJog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8nsfEHBVenrF0SLhLGLJ6mQga2uNDGlEz0ILpHzcM7U=:TzXewENxff8us3Z08aYNM8HmhzRTILlRuFsCD1C82sA=;
X-ME-Sender: <xms:Dwz-at2eO_ZShqxs6AoZJRuR7xhGPbFmuh0oqP3ZbLayEZKJc4H79A>
    <xme:Dwz-aq8YBp2CL7le-1R5LioP6SEx8n2Q4dYRQYdFSIIrNxZwNw_DBnOuQAZ8Oj2o7
    XxzQFtSHgz4kBkexQfo1y3xbh1KEMNDhLZ1SWPxrboVYplPsRW5mKf3>
X-ME-Received: <xmr:Dwz-amNPLHwLPBq6TQ8xHjevyiPn6KooGQEObL1UCBMjloRCMN6i21qCkeed1mpn26gpzAmpFY9E4flr-s1du9QUL94v-YNRWOPuB-Ns-wyA>
X-ME-Proxy-Cause: dmFkZTGAIk21bHN0AIVnYkgw/oOlVgDkS5K+FQGX3YD1+BPh0mhGqAk7T9DtzPd0SkUaF0
    h004OLIXmGtW0fw51CSsE9lG3ThjrJ9vO1g+AJnb3JcmhQr7lB2Y8YGsLSvi59dLseKnak
    /lQZHAIDAXtf7w/z+v7k8vtlI4O6j6Lx6VViw48fnlVZgJtxSdj+gVCwJhchfu45MVNwoH
    MAwOYfzZ2BCU0AnRupnYNz9yOUGBpWrIhXWcroKNo4c4Vsb0A4N7iDp20s3+4qEYkwxOu+
    iQ0jRELvgam5Va8Cu0xI2BE1H1RTvTAcnuXPtVvKqQEFQTKVmQRWE+ukhjc3DSvVKLhiF1
    1h23VOtV7WhGj66Na5VTZw0M7pLdE6BMMOC/w+y00rpasWi/pECWEhjlh/x0ciYhpvEXne
    3BY7u5AeKba4nGVb9mhOtD+XNvW3p6rr0FonLOzkM2Heh03zhRRu9+Ehr8Je0RoRzoZKDU
    aKILGI0piYMRgN6LzraNP+3gsvVbKNE8POkgVmL+cghBAIWG7c7js0oNKTf7MktxPajlZi
    cfslMwOj0hcF6VXpJHZpvrDU5t1zj1GMBXUx5wuTCtea2V2N1duIdyKs1mRXH9US8xb7jx
    ZdnMy0xfVGHmRCxFm6TGUIsoTSdaZ540XMw3q1AcSv/PEyR3KA1/9x0C8yWg
X-ME-Proxy: <xmx:Dwz-amfpFT1OwpGtcOreHi-DyllPT7ReVFzgKl2UK-2LHmICCl7drw>
    <xmx:Dwz-atWnEGQX27xJEwnpgTExvT3D8UN8VeYIpQChIKhR6v3DiSg67g>
    <xmx:Dwz-amgtOQTivn9VaiJeMA_xIRk_P5pCQFlY9bkNDjSHXbsNwgHCig>
    <xmx:Dwz-ak8NPY2xVTgT0vRbFcqAWEV9Eg_o5rG9e7R5Hm7yj8Eoar5p7A>
    <xmx:Dwz-aosl2rgyLmb6OPS9GICysLMrnuFVHFzCb1wReNMdJ4kH6c62Psse>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 15:35:27 -0500 (EST)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v8 1/1] repo: add filtering options to "repo structure"
Date: Wed, 18 Nov 2026 15:35:19 -0500
Message-ID: <20261118203519.2379494-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118203519.2379494-1-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261118203519.2379494-1-markchucarroll@fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to
filter this information to get focused data about the specific
part of the repo that's exhibiting a problem.

Update "git repo structure" to use rev expressions
to filter the set of objects to be processed.

This implementation makes an awkward trade-off involving
"setup_revisions" which results in doing the ref-walk twice when
revisions are specified on the command line. In order to accept
the standard revs parameters, it uses `setup_revisions`, which does a
ref walk and populates the pending objects list that will be used by
"repo structure". But this ref walk doesn't count refs in the way that
"repo structure" requires, and because "setup_revisions" doesn't support
a custom callback for its ref-walk, that's not changeable.

So in the cases where a user specifies revs, "repo structure" does
an initial ref-walk as part of "setup_revisions", and then a second
ref-walk in "count_references" in repo.c to count by reference type.
Further, if the user doesn't specify a revs parameter, "setup_revisions"
is not called, so the "count_references" walk needs to add objects
to the pending list. A parameter is added to "count_references"
to allow it to distinguish the cases where the pending
list is already populated from the case where it needs to
populate it.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..819202dc4e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [<revs>...]
 
 DESCRIPTION
 -----------
@@ -56,7 +56,7 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z] [<revs>...]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -66,6 +66,11 @@ supported:
 * Total disk size of reachable objects by type
 * Largest reachable objects in the repository by type
 +
+The set of objects counted can be filtered by specifying a collection
+of revisions to select which objects will be counted. These parameters
+follow the same syntax as the parameters to similar commands like
+`git log`. Defaults to all objects reachable from a reference.
++
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
@@ -141,6 +146,28 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+* Generates information about storage usage in the repository:
++
+------------
+git repo structure
+------------
++
+
+* Generates information about storage usage in the repository omitting
+the branch "foo":
++
+------------
+git repo structure --all ^foo
+------------
++
+* Generates information about repository objects reachable from
+the references "x" and "y", but omitting anything that can
+only be reached on a path including "xchild":
++
+------------
+git repo structure x y ^xchild
+------------
++
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..78638c2dcd 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,7 +27,7 @@
 	"git repo info --keys [--format=(lines|nul) | -z]"
 
 #define REPO_STRUCTURE_USAGE \
-	"git repo structure [--format=(table|lines|nul) | -z]"
+	"git repo structure [--format=(table|lines|nul) | -z] [<revs>...]"
 
 static const char *const repo_usage[] = {
 	REPO_INFO_USAGE,
@@ -740,6 +740,7 @@ struct count_references_data {
 	struct ref_stats *stats;
 	struct rev_info *revs;
 	struct progress *progress;
+	bool add_to_pending;
 };
 
 static int count_references(const struct reference *ref, void *cb_data)
@@ -766,10 +767,12 @@ static int count_references(const struct reference *ref, void *cb_data)
 	}
 
 	/*
-	 * While iterating through references for counting, also add OIDs in
+	 * While iterating through references for counting, if we didn't already
+	 * populate the pending list in setup_revisions, also add OIDs in
 	 * preparation for the path walk.
 	 */
-	add_pending_oid(data->revs, NULL, ref->oid, 0);
+	if (data->add_to_pending)
+		add_pending_oid(data->revs, NULL, ref->oid, 0);
 
 	ref_count = get_total_reference_count(stats);
 	display_progress(data->progress, ref_count);
@@ -780,11 +783,13 @@ static int count_references(const struct reference *ref, void *cb_data)
 static void structure_count_references(struct ref_stats *stats,
 				       struct rev_info *revs,
 				       struct repository *repo,
-				       int show_progress)
+				       int show_progress,
+				       bool add_to_pending)
 {
 	struct count_references_data data = {
 		.stats = stats,
 		.revs = revs,
+		.add_to_pending = add_to_pending
 	};
 
 	if (show_progress)
@@ -935,6 +940,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	bool included_revision_args = false;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -947,16 +953,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
-	if (argc)
-		usage(_("too many arguments"));
-
-	repo_init_revisions(repo, &revs, prefix);
-
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (show_progress < 0)
 		show_progress = isatty(2);
 
-	structure_count_references(&stats.refs, &revs, repo, show_progress);
+	repo_init_revisions(repo, &revs, prefix);
+	if (argc > 1) {
+		argc = setup_revisions(argc, argv, &revs, NULL);
+		included_revision_args = true;
+		if (argc > 1)
+			return error(_("unrecognized argument: %s"), argv[1]);
+	}
+
+	structure_count_references(&stats.refs, &revs, repo, show_progress, !included_revision_args);
 	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..e901023cb9 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -144,6 +144,203 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
+test_expect_success SHA1 'repository with branches' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+		git repo structure --format=lines >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		cat >expect <<-\EOF &&
+		objects.commits.count=1046
+		objects.trees.count=1006
+		objects.blobs.count=1006
+		objects.tags.count=1
+		objects.commits.inflated_size=231976
+		objects.trees.inflated_size=16578431
+		objects.blobs.inflated_size=11962
+		objects.tags.inflated_size=132
+		objects.commits.disk_size=163722
+		objects.trees.disk_size=284547
+		objects.blobs.disk_size=21022
+		objects.tags.disk_size=126
+		objects.commits.max_size=223
+		objects.commits.max_size_oid=0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=132
+		objects.tags.max_size_oid=4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=df6400c01440c329f1011669c4c26cc0c7852887
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success SHA1 'filter by a positive rev' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=1025
+		objects.trees.count=1005
+		objects.blobs.count=1005
+		objects.tags.count=0
+		objects.commits.inflated_size=227371
+		objects.trees.inflated_size=16578363
+		objects.blobs.inflated_size=11958
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=160455
+		objects.trees.disk_size=284462
+		objects.blobs.disk_size=21003
+		objects.tags.disk_size=0
+		objects.commits.max_size=223
+		objects.commits.max_size_oid=0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		git repo structure --format=lines grobble >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success SHA1 'filter by both positive and negative revs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=20
+		objects.trees.count=1
+		objects.blobs.count=1005
+		objects.tags.count=0
+		objects.commits.inflated_size=4411
+		objects.trees.inflated_size=33063
+		objects.blobs.inflated_size=11958
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=3122
+		objects.trees.disk_size=53
+		objects.blobs.disk_size=21003
+		objects.tags.disk_size=0
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_size=33063
+		objects.trees.max_size_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=c1d3cb6c863e93a546c657ccecdf0f643d2e18af
+		objects.trees.max_entries=1005
+		objects.trees.max_entries_oid=60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		EOF
+		git repo structure --format=lines grobble ^master >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success SHA1 'filter by object type' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git checkout -b grobble &&
+		test_commit_bulk --ref=refs/heads/grobble 20 &&
+		git checkout master &&
+		test_commit_bulk 20 &&
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		objects.commits.count=0
+		objects.trees.count=0
+		objects.blobs.count=1006
+		objects.tags.count=0
+		objects.commits.inflated_size=0
+		objects.trees.inflated_size=0
+		objects.blobs.inflated_size=11962
+		objects.tags.inflated_size=0
+		objects.commits.disk_size=0
+		objects.trees.disk_size=0
+		objects.blobs.disk_size=21022
+		objects.tags.disk_size=0
+		objects.commits.max_size=0
+		objects.commits.max_size_oid=0000000000000000000000000000000000000000
+		objects.trees.max_size=0
+		objects.trees.max_size_oid=0000000000000000000000000000000000000000
+		objects.blobs.max_size=13
+		objects.blobs.max_size_oid=97d808e45116bf02103490294d3d46dad7a2ac62
+		objects.tags.max_size=0
+		objects.tags.max_size_oid=0000000000000000000000000000000000000000
+		objects.commits.max_parents=0
+		objects.commits.max_parents_oid=0000000000000000000000000000000000000000
+		objects.trees.max_entries=0
+		objects.trees.max_entries_oid=0000000000000000000000000000000000000000
+		EOF
+		git repo structure --format=lines --objects --all --filter=object:type=blob >actual 2>err &&
+		test_grep "^objects" actual >actual.objects &&
+		test_cmp expect actual.objects &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.53.0

