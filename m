Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084392;
	b=0nI8VeCmkWqS/o7D12YLciFba4rfw7MyZjeQGqCHE9Rrtz9VISOlKw+ZlSPwHj+disYo
	 IkYI6vszH140UCSpKnwl8n5x1Z52DmWPKlYWdT4UGhJQVUtS3VeMItWQM5GO180+20R+B
	 5WpXEFGJOMo2vNdbrTbsrbLzPovIILgIdVD2zsqsRyyZCAzexEL405T6I5RKZP4YSudf5
	 qBGBpceLwgCe8wo8/4XGVo730oRKyfAlag/+c5QugaQS5GHnWF05AuzLDE4RKoD2yQXdL
	 1VU9ZU2HJCLHsehmnwm4KEcUcBrm1vmqfC7IwUEaNYmvnPTb8bGuTSbjsnY/TiKc/iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084392;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gO04DB9n+DnuRv1fhypY9rbTVxwsQ2vEc3AMbkpyLDc=;
	b=qh5hFBdfZheFmDSz5WHDc51B8pFBZJxxwgyyMHN579rCPpla/W5Pa8BnpA6XkC9rdHYM
	 K8nJEu5gsroE5RWf5lslZX1gdg6cCcTcYsmxS5cmbagaYLfG5kiLyu9PaQwb6jV8Q2o2d
	 Arrts+MkI6TmPyZSQKXs2HZOAsru0kSzxxGyCjdH7Yv64+TNs3ryVjLXT5wzdQEjtV7rV
	 x1rfHIjmQ/ATarN+e0VX0SP/cich6QonKLFTIitzYHG2Qr6a0ZfX4AVDai2Obs9eHliam
	 axMcvchx+hm3imxwhWhdTQvhCda6oSwTd1iZSQAgxAHIa4yySVlljUPXnjeSVdc8X+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=W4ZNOQ5O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LxQuuJWR;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09084606A334
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09084606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=W4ZNOQ5O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LxQuuJWR
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DDA11D0008A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084391;
	 x=1793170791; bh=gO04DB9n+DnuRv1fhypY9rbTVxwsQ2vEc3AMbkpyLDc=; b=
	W4ZNOQ5ORrO7P57MQvKhO6+AmdVMbijQ2cVPgYqobcoMqbeRr22Lm558DD1tvIfs
	5Mt96530zhIallsP8Jb5IJNq2IxBWbN6qo94sYSL8GxnkrQTFcrs5JJJ/FxEiRni
	h4QnblLMYxJ5Fnon7Id+qpyvcvWOUoJFtLyhs4zEURa9lRaIRhExomyKWSW3/I3Z
	jsZQYt2HEezOdE4gX81qG7R1WevQbc7bYhwMn0yhuxJiG/ONsxa8x4jOB/FmEpOT
	C80pZdRYhhEaEnk86PeQFi/93YKbpUlpLwaec//+eUBHPk7LEXVagEuHVUdZ6saW
	KWohBM7XKbQLe7hcbRbUSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084391; x=
	1793170791; bh=gO04DB9n+DnuRv1fhypY9rbTVxwsQ2vEc3AMbkpyLDc=; b=L
	xQuuJWRvCKzkdwFLmvkvYaMQ+aZGxiWuLN4gsSMmEMWNiDheE57LsoBtalmg7HtV
	rwg2Do3gkjKK7fVbAZWOsyp+RJE8i3qgV4hkq3Avo3x9eTjgGOk0hNm8GbQmucMx
	Di9RIRkqeNtfMdCZ7tnNAcxGz+xatAANZqZGx0VA3Uw8Y66LMoqnhyCA27PBvaNV
	nwyoAQfUix3DoX3WtTLz1BcTM7YziiwwUc0XJMZ807Qx3p0oMkEuSvUPrbHT7oPF
	rUsZhcZfTMsCxAtf3KA5T5B/KY0ZoYXU7/iSO55567mZgRhDeV0gcqzjgPvBvp0A
	DgR1PgRUmsIcxhkRF5p8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084391; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uaRqjHxlmCzBoJmhGRG4z9NApcPgCisHUcjIvhUNzKOMNLY
	0qmJ8KtscRZWFsIPGw4+sDC0RLYWLDBLPLeL3WBhGOlXRcV5L+rlIYTDoD4YCERg
	7Aipy2UVXmeBPYKw59ssXTzjZoHNPU0pLz+J3sueaIcab+VbZdn0Q+VY67/KldDT
	5V4e7A73RlQ+4OswXogmx7fc4wU3BeSgbAvmfV2z6nsxLyVSVEUu5ahRt89VEoPG
	EpjYPdLngRCiMBvIEuYnFqGIS0n/imm25PQpgiKQ7dS0/PkygMgU1V+RlcGmlIpD
	PtY+VFLFLaOBigjmqc8bYCQBzO6MoGqNVx/yvOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zsGYfgUOZ8cKo2XdsMm/XjFb0OLh1qh3nXxwwK7nX1A=:nod40MHERTZT6o+kmb4v1Dme8knNuc7Lf3Q+asGBIi4=;
X-ME-Sender: <xms:50vgaiCQkVrKpIR2jp2AMgxI3KSqaQTSMsyosA1KQiSokXw_3zu_sA>
    <xme:50vgaj8Vyabq6yRfbS6WMSkj_IFAIyL3bliG6VxC_zk74K_8WXhBAjmQmBBYlSA-Q
    frL20uEl2RqZxE_4A-brZmyNuiQD9RKP1LVR01bUnIGZ1oPWiwTOgI>
X-ME-Received: <xmr:50vgai-uRhkwvh3jaWcJzm4yUx439jMdNHzSWGR0UKRk4nV5XSLtxg>
X-ME-Proxy-Cause: dmFkZTFdAx1Kb/Rt5xZ5JGvxKgxHT+05wvq5MYh/dlyjwhPl/J5goSmirBj+lxUlhK5dmz
    N3Fp5zomvm5ydlBgqs8+RmQ7bJWR17EABYD5P0VTOWWecHt/AsCVdMtMSVtAOFDd0GnHsR
    5U2cYLzwDEVBbfMj2xC5zK7WuoQ8CMOlvqRZyD+ZwnahQvbfQaWaUXnhJwsBuOTG4HM2/w
    rwF1jsZzo5/5bjsc//rEiiQCHjRjFA76GREzIAhlar+B4rbTTSAOxNTqwFceBwgg4w2Xp4
    TFr0+6ggbUkDOQzl7nAhA/vP7b52VLFPGTj2sXTyoo4sITc8QH+xu9KpiD8q+tW+/bWEDM
    G2/+g4djD0VQM6jWPcrWmUHQatRE43hhFUwZTtlKIsH66LMrrvu90VP68s7726y1HGaiul
    OuGWwlLw2XpFXqB8mymhvclsbSql92N3JOM1qDHeQIG0makE8p8SEkZaWzZLFu3+QUOi+f
    /LkuMp9PCmAxgCT/ZZ66IFU/MvkKxwqOGGmSdAbceXAo09Hw1tvq9gWvM4x7qBjm/U113i
    cUv3XQkgBcxOVLU+S/MoWyKqm2VJ9p2ELaC1EbOt1Oslffic+Kuq1AOQybqjEEaQPNNc90
    MiHoyN7wklRY5O1hmOj4oU6Fk4ImJRE2Y5yD98dNfzVM6lMjKaNiaNQizaBw
X-ME-Proxy: <xmx:50vgaqfntIES8Te9A1_sgWFBF1Drv16YJUQc0jWyr42ICP0Yhz4UAQ>
    <xmx:50vgarEnfIxEMNJ5UkjZ2XjgBZUsXNWDFYZFLob-dB9HSBzBGJPQgA>
    <xmx:50vgaodtQ3zGFXvLPrQjfIZt_krhBmI9J3oc3WJyg1td19udn0lECA>
    <xmx:50vgalH2Y_V3AgWDZZsM-2nZZEx9k1WjxMGH4OMajY4e_uHmxPvtwQ>
    <xmx:50vganbpLyNs_2HPfEBRDL6pMUGXFqboctjzlNf6JlaLVdJIoS5z_n4b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7dce0635 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:30 +0100
Subject: [PATCH v4 6/7] builtin/clone: introduce "--object-storage-format="
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
Message-Id: <20261027-b4-pks-odb-extension-v4-6-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

Wire up the new object storage format in git-clone(1) via a new
`--object-storage-format=` option, same as we have introduced in the
preceding commit for git-init(1).

Note that "--local" clones will not work if either of the object
databases is not using the "files" format. This is because we hardlink
loose objects and packfiles into the new repository, and that is
something that simply won't work with alternative backends.
Consequently, we either downgrade to a non-local clone with a warning,
or we die in case the user has explicitly asked for a local clone.

We _could_ in theory handle the case where the "files" backend has been
configured with an alternative object directory path (that is, with
"files:///path/to/dir"). But that's left for a future patch series to
implement for the sake of simplicity.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.adoc | 11 +++++++
 builtin/clone.c              | 45 +++++++++++++++++++++++++++--
 t/t5601-clone.sh             | 68 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 07f7cf1a98d..dd3b44817a7 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -360,6 +360,17 @@ include::ref-storage-format.adoc[]
 `--ref-format=<format>`::
 Deprecated alias of `--ref-storage-format=<format>`.
 
+`--object-storage-format=<format>`::
+Specify the given object storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a path or a connection string identifying
+the database that shall store the objects. The valid values are:
++
+include::object-storage-format.adoc[]
++
+Local clones (see `--local`) fall back to the regular transport when either
+repository uses a non-default object storage.
+
 `-j<n>`::
 `--jobs=<n>`::
 	The number of submodules fetched at the same time.
diff --git a/builtin/clone.c b/builtin/clone.c
index 95e641b1a49..437dd2b2776 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -378,6 +378,24 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	dir_iterator_free(iter);
 }
 
+static bool is_using_default_object_storage_format(const char *repo_path)
+{
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
+	struct strbuf config = STRBUF_INIT;
+	bool is_default;
+
+	get_common_dir(&config, repo_path);
+	strbuf_addstr(&config, "/config");
+	read_repository_format(&format, config.buf);
+
+	is_default = format.object_storage_format == OBJECT_STORAGE_FORMAT_FILES &&
+		!format.object_storage_payload;
+
+	clear_repository_format(&format);
+	strbuf_release(&config);
+	return is_default;
+}
+
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
 	if (!option_shared) {
@@ -927,6 +945,7 @@ int cmd_clone(int argc,
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
 	const char *ref_storage_format_uri = NULL;
+	const char *object_storage_format_uri = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -1008,6 +1027,8 @@ int cmd_clone(int argc,
 			   N_("separate git dir from working tree")),
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
+		OPT_STRING(0, "object-storage-format", &object_storage_format_uri, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
@@ -1060,6 +1081,10 @@ int cmd_clone(int argc,
 			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
+	if (object_storage_format_uri &&
+	    object_storage_format_by_uri(object_storage_format_uri, NULL) == OBJECT_STORAGE_FORMAT_UNKNOWN)
+		die(_("unknown object storage format '%s'"), object_storage_format_uri);
+
 	if (option_mirror) {
 		option_bare = 1;
 		option_tags = 0;
@@ -1213,8 +1238,9 @@ int cmd_clone(int argc,
 	 * their on-disk data structures.
 	 */
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
-			  option_template, GIT_HASH_UNKNOWN, ref_storage_format_uri,
-			  NULL, do_not_override_repo_unix_permissions, NULL);
+			  option_template, GIT_HASH_UNKNOWN,
+			  ref_storage_format_uri, object_storage_format_uri,
+			  do_not_override_repo_unix_permissions, NULL);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1363,6 +1389,21 @@ int cmd_clone(int argc,
 			is_local = 0;
 		}
 	}
+
+	/*
+	 * Local clones copy or hardlink the object directory of the source repository
+	 * into the destination. This only works when both repositories use the "files"
+	 * object storage format.
+	 */
+	if (is_local &&
+	    (!is_using_default_object_storage_format(path) || !is_using_default_object_storage_format(git_dir))) {
+		if (option_local > 0)
+			die(_("cannot perform local clone with non-default object storage format"));
+		else
+			warning(_("falling back to non-local clone because of non-default object storage format"));
+		is_local = 0;
+	}
+
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 06f6121f82e..85f439d6b62 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -181,6 +181,74 @@ test_expect_success 'clone with garbage ref format' '
 	test_path_is_missing ref-storage
 '
 
+test_expect_success 'clone with files object storage format' '
+	test_when_finished "rm -rf object-storage" &&
+	git clone --object-storage-format=files --bare src object-storage &&
+	test_must_fail git -C object-storage config get extensions.objectstorage &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	echo files >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with object storage payload' '
+	test_when_finished "rm -rf object-storage" &&
+	git clone --object-storage-format=files://objs --bare src object-storage &&
+	git -C object-storage config get extensions.objectstorage >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	test_path_is_dir object-storage/objs/pack &&
+	test_path_is_missing object-storage/objects/pack
+'
+
+test_expect_success 'clone with object storage payload and bundle URI' '
+	test_when_finished "rm -rf object-storage src.bundle" &&
+	git -C src bundle create ../src.bundle --all &&
+	git clone --object-storage-format=files://objs --bundle-uri="$PWD/src.bundle" \
+		src object-storage &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with garbage object storage format' '
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git clone --object-storage-format=garbage --bare src object-storage 2>err &&
+	test_cmp expect err &&
+	test_path_is_missing object-storage
+'
+
+test_expect_success 'local clone into non-default object storage bails' '
+	test_when_finished "rm -rf object-storage" &&
+	test_must_fail git clone --local --object-storage-format=files://objs src object-storage 2>err &&
+	test_grep "cannot perform local clone with non-default object storage format" err
+'
+
+test_expect_success 'local clone from explicit files object storage succeeds' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone src object-storage &&
+	git -C object-storage config set core.repositoryformatversion 1 &&
+	git -C object-storage config set extensions.objectstorage files &&
+	git clone --local object-storage object-storage-dest
+'
+
+test_expect_success 'local clone from non-default object storage bails' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone --object-storage-format=files://objs src object-storage &&
+	test_must_fail git clone --local object-storage object-storage-dest 2>err &&
+	test_grep "cannot perform local clone with non-default object storage format" err
+'
+
+test_expect_success 'local clone from non-default object storage without --local warns' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone --object-storage-format=files://objs src object-storage &&
+	git clone object-storage object-storage-dest 2>err &&
+	test_grep "falling back to non-local clone" err
+'
+
 test_expect_success 'clone to destination with trailing /' '
 
 	git clone src target-1/ &&

-- 
2.56.0.341.g393f52fd96.dirty

