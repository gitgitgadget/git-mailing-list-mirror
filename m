Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561178;
	b=W9LCF2SgbONzL+3do9IVusk+sgRb8HkAaHhJKBAd0G18fM0hCPEAZZ8umGBv+Rg74CSa
	 HsYCSQyXdeSJaBxP8+X12rQdRLX8PWFZQjGCxr9hxjPuJHTaXb2LuxNFy7eWHq7lUZsFD
	 gFuuJ38mP3SjETtUXPPNyQS3Q5FjLz3lmAzFRGr8YOS/SElR44Y+G2Y6FB4lVIHrvAr4h
	 pwgFShPCLKSLTNu3Ef1PdtbCCvA2OVCtLmR5AaOD8u6vjAxXHVx6pbfSYj0hRSbgHOWXa
	 SE5vI9KTbgSKCTvfvTe7l/FbDzf8iaSBdbkb656ueoKbu0PPolDMmNBGVqZS/SjTH8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Tsk5VAEo1QssRtm2O8xCR878dW3t3g1nE+kVsA8Jdp0=;
	b=TkhdHSpL8aKv8ZSz+Wu/IQtJzCaU1yi3L5An7OEY7ZpZHJY7+YC3yKc3X7oqYQ8sBwe/
	 SEkQZagtwkjRZfWs1X4d2SsULiL3cqxZcBJ2grmyRL96T4bzPDCWQl3XMtdlgy1+1MR31
	 MaYA/53yrGE27ruElPEf9cgJXAp21Z8ujDzuZdUzTAswHCzNazJKzlGm4Fppa91w6JtrY
	 yPD3dkcrLRvu+3FewxiCKZ8b6jElR3nqJhj/y8xZySue940uid3XfrUHgQDWaoHmUbZFJ
	 AuRXELqdyh310S0eSUd1V0AK0OrJVA2+ZGk6jNulIou7R7ZsOx3AiKSZsMapFdFtKXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ekbp8Rk3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o7mMkCTt;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ekbp8Rk3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o7mMkCTt
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36B917A00BD
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 01:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561177;
	 x=1792647577; bh=Tsk5VAEo1QssRtm2O8xCR878dW3t3g1nE+kVsA8Jdp0=; b=
	ekbp8Rk3DiQG0cvjq8hjpKH41T0nNzpsS/FQ0tfbIuPCQVcsH0AHDpGJquDVJa3R
	6Gfq3UTafQKOIbRjFMe/sm7BSAdo55LhpRzas/2BxgaC6l9Ql5GYZWVtX1ZTUXC3
	D9J9DR4xQ9C+tVw0qFSgFg3r/ntQE7OrRmjIxeLa2+U9VgqCUaLy86TWJ5vyjOQm
	7dtTWFL6JmW17dwGh9DauhNRDaN/9fW+p/rMvCgSmsiJIHJDLaH53tsmol1b70No
	MVdwYfdhTJhjC4DELk2KgtCBPB2ErXHi8OTiMhKqUUR0DE0ACFdO3EBipde1vGT6
	dkkKH6yKKFMs7PaFL8oA2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561177; x=
	1792647577; bh=Tsk5VAEo1QssRtm2O8xCR878dW3t3g1nE+kVsA8Jdp0=; b=o
	7mMkCTtc/dl6Eh/SC9WsLSs2nrKNelXSjzi1uwnySugmBhJK/26Mn9NikWD0ieDS
	qRfKwY4BZgLUbbuGEuPTcdIS9Viuh8qlw+LHohDGLwOWap1pjsOam43jrM7mYCn6
	qXcpTS+8tKCXElTV44KAgA/AwKZ7qH/RpTZCzmE6N9aPqbhGKeSMiMeVk+A4RT7j
	JWcWgVjYi4TG/2nbLLHbS96OvfCSftQb0deNRHEvBqYfhk1h8+0A6EmfcTjBH8uT
	bwpdnjo6VMtdeLmsQX8L7yJaaE5ExFwY7mvUa0jRrGz143ovZQZi7ncIIRUYEXq+
	ieADWaWhSfMDwjr+UssQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561177; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xyq+XnWZL6ptGQLE39ady0z4lRlztHXzUoxq284vi9a5qyv
	TGmz7W55M9S11n9t9B2ZY3mzmh37m2VPjcQu5JxZUBkahe5c1OPnaEm1l2FnjbPJ
	hEI6mGeuDeF3BuVT0kAm3VxSFUqnsSz4bZ6D5U0Rze/UTTIe5P7hAZrXS1xYOHHN
	8CgSVvayiWnGpbsUmcgfsgVW94d+m8c9ZD5kN/rkwk9EhQ3K5ZbkQVxBjTOwK7wK
	53bj0GYPdyISvtt9f6ioaB7aAtDQ/r5eN2js/2EU0Wnf3PTFpARH7z1s5nweGxls
	KS/YzTmwKaw24mi95SN18ziwIZYGO38I162rONQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SntA4hBKLYlA5sy5tda8qOwagGL2FbZzPe4q1+uWD3U=:Ta+oMfJYsw7vCRTzxcQxMsjbB0iU/Ho6YywTtyyEJe8=;
X-ME-Sender: <xms:GVDYavSKipBElYDwht9oS4rVg2bTh5vW06B1oQA-DwBL71V12avp5w>
    <xme:GVDYamwBWI1sPeBtzeFfvtkesjBFtyEFds48G1HD6rGVY4DO5DtoRsS4JTOVKcovZ
    rVP7IKFPOxQ-zJvAf8egCeVetLIdS76_awW4YM-P_ltn2wdJ9UJ-bc>
X-ME-Received: <xmr:GVDYaieZmGtR1BNXHO5Yvhl-DD_31spHgQJpRuMli2tzHZIZeVo4wQ>
X-ME-Proxy-Cause: dmFkZTE0M5GoZUQYJtNvenl/k2oAozh4DGHM8dAWSmISTqiJXpbiDj7koGqIym3CTMbmuq
    NVJyBD1CU/Rd8wfxuYQYr+4dheScMW8czLIAlx+8ZNoU8F7W3j2aE5qyZKcXJnMG2Ju5up
    vmzEquJv1BiFDhW9rK2x1PcYBYw9Cha7NuhOLLOhMQUMaCR0UJ07ULUyzCV4r666DQlN1t
    43VH3m1QyLdzPT2QmE9aaDTvlGnHbD1k96/cMWSArRLZ7j+6VjlqL5bFR7hrHe6IyJtgav
    euEgvB//s4yiaii23qwTA2lQmpUdR56x49Og7UGzaBB6BV3gL3ebecBIXZd1XT7S+DcRiN
    cigUGOenyKPQaPKPZyCSqFbGGT9lj8pdbPlzndLLIbNBYpXmlfn0nNRX7Nfe4eCv6IZzLc
    7LEeAqGonAoMYFtCcsJGG+NXjEW+blauObkmDPU84HRtjoDKv4g3AtCjTvnxLdKzk56Rsc
    AZawx9NesVo5SynN+EPlXevFkAfOgA8pLHd872y3YHfiZwbNq4el0KWrCQAxmT7gAdl7UH
    PERc4TImg8ZssT/Ud/cUnToHd9avXl6HSsU0ShKy0I6uUcgiQa1WUtfObnt8YO9x5Z+dY0
    BaesIrikMRZ3yjItTY7jSFtH3CIkd0hSnyqwuyScJPoXOqrx0CW+wI7Po/dg
X-ME-Proxy: <xmx:GVDYaqKIYBND6G4rugS46BHQvVSRmlG01pO2x8njeQn1b8CsIalPPQ>
    <xmx:GVDYarE2-lUYqOpztcVI-ck19x9KsJ2-OkqyvTMHi6XeEZpt0L6UKw>
    <xmx:GVDYaso6cO9zaJaavYgCp880ao3fKZaeF1LQ-DdmdsxVfOxJ-v367Q>
    <xmx:GVDYasQ2ZwETCzAgfknZqhhQOYzn1bMG9yV2s3X52Dlm46a0Vs8Twg>
    <xmx:GVDYajAVrhU-kP8iil10PK-zilSK3ajdsDw-kcDcfcx0m-OXbXmqcFgO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 68a7f9d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:19 +0200
Subject: [PATCH v2 6/7] builtin/clone: introduce "--object-storage-format="
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
Message-Id: <20261021-b4-pks-odb-extension-v2-6-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
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
 builtin/clone.c              | 50 ++++++++++++++++++++++++++++++--
 t/t5601-clone.sh             | 68 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)

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
index ba4fc16def..85c124dc37 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -26,6 +26,7 @@
 #include "refspec.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
@@ -378,6 +379,28 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	dir_iterator_free(iter);
 }
 
+static bool is_using_default_object_storage_format(const char *repo_path)
+{
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
+	struct strbuf config = STRBUF_INIT;
+	bool uses_default_format = true;
+	char *payload = NULL;
+
+	get_common_dir(&config, repo_path);
+	strbuf_addstr(&config, "/config");
+	read_repository_format(&format, config.buf);
+
+	if (format.version >= 1 &&
+	    format.object_storage &&
+	    (odb_source_type_by_uri(format.object_storage, &payload) != ODB_SOURCE_FILES || payload))
+		uses_default_format = false;
+
+	clear_repository_format(&format);
+	strbuf_release(&config);
+	free(payload);
+	return uses_default_format;
+}
+
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
 	if (!option_shared) {
@@ -927,6 +950,7 @@ int cmd_clone(int argc,
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
 	const char *ref_storage_format_uri = NULL;
+	const char *object_storage_format_uri = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -1008,6 +1032,8 @@ int cmd_clone(int argc,
 			   N_("separate git dir from working tree")),
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
+		OPT_STRING(0, "object-storage-format", &object_storage_format_uri, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
@@ -1060,6 +1086,10 @@ int cmd_clone(int argc,
 			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
+	if (object_storage_format_uri &&
+	    odb_source_type_by_uri(object_storage_format_uri, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), object_storage_format_uri);
+
 	if (option_mirror) {
 		option_bare = 1;
 		option_tags = 0;
@@ -1213,8 +1243,9 @@ int cmd_clone(int argc,
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
@@ -1362,6 +1393,21 @@ int cmd_clone(int argc,
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

