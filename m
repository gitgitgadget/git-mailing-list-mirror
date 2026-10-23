Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756179;
	b=rdYC1RDR/oqEVn3geHKpWNmoRSZ4Cag3Vgcd7mjcHSltFVJ4mH3o0gGsKExs+T1PKV0m
	 NdnWHU4+ojJWRNpNv/D82jk3UMW4tcqKhSv5wacMVsA38OScoZNnkCbVn5CQIvHsqdX6+
	 6GoJ08XzGwNSi1CwamJAJnMSZ8UzdKo7RrkPoiO97ygKej0oD7RHw+cXj5gXdatch3G8/
	 NKbYwBQtdY73E/mEJVOK9QQk6FiQyTChdEfmeuKBHDn0+UY+7Y4RsQf9huNSlrMTwAcaH
	 lm8nRFnKz9asUOK8lqv2WFI7e0qox24xfE4AE85jxzD8izUzTueonuZZfk4s++LIYhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756179;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kU+Aqgjp14W6gR+Nhpp/hSQQqrgu9UhJxN2ApoFBJjA=;
	b=udD8x1qIEVV+1K/jx4SPyC1hxjb7LwemUpMihJPcr65qc+LMJhohwF+Atik8bVChrJhy
	 qiTjVNfZ3yaL5ISF3zmzqnPdZkzvfzbr5EvejYfyMcIb+65rZOp2uv+wa/oZr47Rv/JgF
	 3aoouMNLpN9cu/UKEd26TuyaPh6uaQTtpZv1MFmMs6QCg1mCuKqVk38gY8dMt/eRvfDoM
	 ZSey2X/u9rMpzJbhnmEAuAPQB+8SSi5Nm5mhs2Vjg0VjvcYWLAihrreUYFIBLHEcJXw6S
	 jQ2lFkAGZQYO2l0qN23r7qbRXICqfhAO3dV67OmUKd8q7AK48XStvfgGN77/DdZj4fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bjAVCcKr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yVV7NJgi;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB660A2608
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BDB660A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bjAVCcKr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yVV7NJgi
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A547140012E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 07:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756178;
	 x=1792842578; bh=kU+Aqgjp14W6gR+Nhpp/hSQQqrgu9UhJxN2ApoFBJjA=; b=
	bjAVCcKryeVtvRDrvlzenRnAvyZlSzV084UFPpidaFW8ykQhdUvnVEsJ8D8lZRTS
	1cVjm5oPLCppxg+SVZ0jCPtcg/pmh9JaBUrj/qI5SQ2S4q6XSdxZaBMeGecz4Viy
	7vEfrqFtZWeLKoJ8Bjxs5S5NNTZsYoccxOCRtQPeQq8KQduaqzAG/N4eSpcezAkL
	vcDlvM+yFpCZysJp/P2NIfFZwoAaLQaKjQM/MuoYlH4iEP6bvhYqJEVMBVr4nRu4
	5U+N5uN+vHrWHbbG4OUZCNXSY2wozvshPRSzoDWNH+Y4JTG0qUE5nQimHOIJJvSv
	AKaw5ebWkfeNTJwTg04e4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756178; x=
	1792842578; bh=kU+Aqgjp14W6gR+Nhpp/hSQQqrgu9UhJxN2ApoFBJjA=; b=y
	VV7NJgiYodFlGWqY+F36zvEFv8PrgOzuvLCsAB0/BKAQgy9XiUUGfi17x7J85DaW
	tfK4jObUKmFo/U6bq2pGkcMRkpcoK3vMeQDeaJmUqTF+di2JLDdwWM0Xy7duNLvB
	7VZB5uhglT2j8rkQkXChg/a/kWcXlrt/xmBsox42x77gLg82PmNb/mDW4boqUMaz
	tNwIKIAt2AG8uBWdSJsWUGLPW9xa2yZRpftbll/p1Z5vwhKZxNZBnbI/1Atq6DDt
	TUI4SzpjZF39pUnBeGqEZulXOm9Ml9lKjxD32BD0L7zbV9V4YqhijQU4gXhE73An
	Cu2z0yTMzOUO5NaPsmRSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756178; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oTaTqzGASc7fN6MnD/2w5RGhfheqbJHW3FUVQg/M7MwBrFA
	arH/tNGhSH+r48HUF7yl4B5I4jr1Evfjov79Y8JoR5DDtjWYCiT9N9paHkXEgoIF
	j5Gy7iDLRO4cYWDv/YjEMpEDo4n03kNV35KpbpYSzqt/uAqZpmh2e1d5ZGWF0klh
	3ziMcpX5b1Oi0HP9/BaU79BeBjg94r+chMvz75TCNTjHiCjD8+NKWJoWbYapZ3Mr
	26XlUpRXZa9IGyuzsap7MT1knpvLveQlIFmX6yzEtO5wWAmTB6MxL2DD9x9SJ4b5
	pZa+gM8XzG5hvIUwqFSk/oz4vwTBIipoVWEKyHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fOXWtEKc1LaSpR2e4FoYYVJXLGDe0nb6pIGVRpKDHyg=:PW1NkFK9kRdJ3SG+KD7w4HLLlfYoCZn/QUim9TFXIFw=;
X-ME-Sender: <xms:0knbaq-gnwgfipfeayLZcVmYtcInlum5BnJwfvTTzClCPBwOtid9JA>
    <xme:0knbagtEPNL05A-CEUtNPbNZQ8Wo7CKwDI8EkgQZ2posY2W6KEERFvX6qKYxYBhcB
    9PkiXoD2seLyl2WhG8DtgRXOv8bbOUxS_idd42M029CuFxglGOYMA>
X-ME-Received: <xmr:0knbatrQNyHeJRu0552Fl0HYKN50SlMfZfmWprmDvs3MhY1IbJFFSmoqDMYdn7O7spxrig>
X-ME-Proxy-Cause: dmFkZTGa2Vk/qUsPFGOPILY6jTACZirSZ7sJ4VbIfzbsiGzv+aAAdJHloGLRKHVbSWH1Z5
    m4YVh5Pr4ucOYIjztGWhIZL8SHixoQFYX9UVNhYr+3Ycfu5jnPIGHyJw6RDVH7CaQ/CfGV
    bQGtB8Fn+p5t2/EpLvjH7RuWxAx6a0i7YzwgVZzWPNSCaD4hazd32Z9s8X11q/peu6BAI3
    o64CYdJc4el84YVLM/KYzzH/WsA9JCevRziVM9S4T3xp/bPFAGGDvVyMB0Xef5O/aWrpCS
    iiJu5p3o9eHwY7nLkCq2WF3Imqz5GdqWa51OWQV4rDU+i//RXMnttEMjjyetB20v2DXwTY
    gjnAjsdGm2H8hDj1cBV5PWuMtdb8VFLUmQ6ECYSrg45i2zdEoZ6HZvGy0dMDPnivFWFUnv
    qXs127slZRRM95rGguyz+jxVZKMjSQG2dUka+j+fWEyC6XRlgKnnZE0WI4TOaW2KPBpo1+
    Pkx77YY1hk3Bdboqk2UdQEOy0drVkQgPFzU6zQzXaHJ/fCnRdK7f3CffqoofPwQ5PIVn2R
    e80WO+LPspagYtJjkc6HGCWEcQ0nXwYrDPz9qKE1aDsSC3Sg2MGW60qICi06y7azVoVCEz
    uMB4WdiI6E6c+QJ0ntwr2V+zYuwl1j2UX1zmLjibYHx+2OkcTkCMH0p4d80g
X-ME-Proxy: <xmx:0knbatkROgeiQfLr3kLVX0Y5QY1LNRnZ8RTduMcLgF-5l3eTZAdVMw>
    <xmx:0knbahwNlct4u8C4I9xeEjiS7H3zUcFwCvHKeCasD8tN8pzzefVFaA>
    <xmx:0knbalmopZMpMkVyYvNHE9K-1wrCC7kH_gYEOaCkoFhsQuBVpVYutQ>
    <xmx:0knbaqdWae5b9FORJgiaK2kLajAg-zgwncMcBPdZLqippGLboPp-OQ>
    <xmx:0knbao_ZXN7EZzYkDpF52JIAHls20lKJeOMQvpCtWSTw2GxAGjVRyDJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebf3ef38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:15 +0200
Subject: [PATCH v3 6/7] builtin/clone: introduce "--object-storage-format="
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
Message-Id: <20261023-b4-pks-odb-extension-v3-6-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 07f7cf1a98..dd3b44817a 100644
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
index 95e641b1a4..437dd2b277 100644
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
index 06f6121f82..85f439d6b6 100755
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
2.56.0.307.g5fe7bd680c.dirty

