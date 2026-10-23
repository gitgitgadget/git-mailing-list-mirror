Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756176;
	b=Vxy6rjmotJn1kaNBgzeFaW8XT2EZyPfkovrNbNxRARxOTUdoy4QAfmZN4MQBMmToWoxE
	 YXvW8LasyUCsToP3p0OsyfDekqk2rvFMom6xyZVA2B7DRVdwumVBoGqiJGD0EfqdcE4vi
	 c9n8xmybhd4ViBW6zQG2OrY/Levi/wIg9WohzdLDqwaWuONfKG1/qiWxOtQIU1HkuVBgw
	 ZS3ywghbVoSUMl5iw9iNskXfWiOWmI/3mUx+ogzg2ClFoNa6x0xrS3ErZakYwZLWKoTnm
	 nEldingdlzNFIDFANTr8UOy7rGRi7FjYYCsTLmX4ZAe8WMjZV2Akz4Zo9GtW8wcF98w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756176;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=onVWnBNd4eAUaWL3CJaOM6Xvefm1nuzcLZ2Gim+ZIT0=;
	b=lTlxmFLlcbobmjnY6FdWyWXO5CTN4YwtsgNE8D5WiDCE4cxuvHQC4PVc/MxxUaePwHHu
	 JMrZloVti21PVPB3GaeUOf3aA/KmCVcWwNc4evccMCxTRkP7chN+oh+5UOsJ/+4G24v25
	 yzjdYnDepeA2TCMKrud+qEk7dhcOfoB0wPYfh2bF2bsWMh5Re2wkVZwLIE2I6+GJSgqrv
	 VQpPtWXfmtiBjRDEpWFpbb/qj2LaNWM4zLL6Flr5rDkjoOC5s6iNssUfHm19Kih0pcSxC
	 NDQv+J0XZbopjEjkEqlhjj53OAlsp0NQO41AVraITf3YybnMhQQJ2sdKhLgg0OJVefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JIsAOxeT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VjI9TsWa;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA3606A322
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AA3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JIsAOxeT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VjI9TsWa
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5AF0140012B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756174;
	 x=1792842574; bh=onVWnBNd4eAUaWL3CJaOM6Xvefm1nuzcLZ2Gim+ZIT0=; b=
	JIsAOxeTYOhC8AE+NRzXTAMw3q8J4+L+aQ5EscwAGZgx/3JWfdCa2GIfolGpNLtV
	y1mQi+e+GbHhNpt0s5/V9kQjEiVQBNc7msssw7ABlv+IgcUaxZvmx3vysi67piSw
	hUd/6s/WLh2kJ14IQanSO8VJwZ79v7V9fBUeCiL2mkdtcHn4Uv1Y3ic5uxD7kGJu
	yUAB9ulhbgV7+srwG+9aMIlBWtCDCsQZUgRUDFSTXaksjP8bh0iFi9Rx1GWxXWc8
	YOtas1wtBNw4IloqoINqN445LOHuQqm+FsAl1aUxLtKhFwmDvm1Fp6tKhNZm2PnP
	NBAQ0Qn69pvUeMHQ0TnlGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756174; x=
	1792842574; bh=onVWnBNd4eAUaWL3CJaOM6Xvefm1nuzcLZ2Gim+ZIT0=; b=V
	jI9TsWamIoYurrswHk6o7qHYrVOB1iG/0ZZ33Rv8+RtoVDW5wkKNcdtDziCK6k+S
	i2/xh1eeooTHxj71l4An/46jmW/6ojHzVNm4CG5D73Hq9C0HZEDfRNzQbNh1M4L6
	vUuyLs5LQc+mHEA/AMoXAh4qZ1BVAYbY40o+yNC/KBIolxoOdfgey/bTirHjAlBv
	SN3CWTjFDP5BL4IRhcNJIGipdeCDF/Iq0TdtxxTC+UiKCpTkFaW90jnLZxKoxEW8
	/ICuyp5MU9t9EfwHo0yqGauoQRxcRr1jfn0uTEXPvTgF6PV0Ff9tNRjBxS9LVpbd
	/nEYQtVKCOVT7q5R/Hg3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756174; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Rt2jKw5QQa8hkXzImdRm+rI1ocAe14WZBxgnZAhfnmytsen
	u6YP75gO4wedymHgGpXRRMWD60wQivPZanyn2wFPetehCcD7j+E70eyK9TdWBwgD
	Hg/f1qYdlLER35i7rOG3GSPz54kBtKCVyriX8AlhFN9pIj70S1MpkEVWM60YWsjj
	gaTo3ArxjK0E6UrFhcFyCw4/c7LZgl271Ec/EGyWgULzSUoOVr1GnaBvfxPgbB0E
	hsijt+QlvXqZDSeoukIcKv/U2JUlilOrJFZzA1CDlb1WAt3ktYXnqwqZiF0vadzG
	4812c0O/+4VsnzpRJ40Wu2cb7yJViFXk5V/KXfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:S2w+Nh100ji7FJ+l8p+ccO5Q6ALyc+ZDkqV+yGgCdpQ=:vEFADKo6lBFW5XhvN9DjRVMBajIMrSIXDQgq30cK1rM=;
X-ME-Sender: <xms:zknbagXVM3OD0EWkDqkKpIQdsUoNUmBZwDWh3SO9Hrw6ndIJYMxcpA>
    <xme:zknbaqnQoy1ziSOEBlWd1449fziRbrpnOipkKZryRkUn59t2f9b86slBOpW4cAhL6
    1ma5PFBvopowGqP3tgP6kbN_HKvwXrYjlMfRjfIMc--Uj-NTkWE4Q>
X-ME-Received: <xmr:zknbaiCkTLq4s4SWRJj30ZvkEs5m1IUmfjX9TZQOdukyuy_DcVmR9_0S_mttFct-WiI4hw>
X-ME-Proxy-Cause: dmFkZTG1+As82yAbF834ydg6yjNIYCA7X0cTkXYvbrp0+wAtexR4xRjjvul+rx8ESl/vg8
    46xzFI+wwkqYRmG4YN4EI4vGCzBf2zhFpU1ljJMYEWpprg35ujaRC7D2kA1QgoBI4Scz0y
    obz5S3BlVZsegTqnXYSGgLjS5xLYXR4Sh8mSkKOVojgB8kz+dMp9hokwaTPRu4VNdHG8Jo
    8DSm10r1MvNL2xlP4VFacrpvWXBjzneHTCSevpvFo1jZL+EXX8eAdCPMVjvY1cXF3HhcrB
    60iAGl8YGOl+7OvHJJXDEfrFrEEWAhUbELl1aEkUZ0qFHoHt7c7dqucEoB8lK2wMn0qOQE
    FD0qFwDq2ufmb3Ks0+qR/3ij2cOIy3UJeFk2mDZnFOMZsa2JO4vmwqEQfhodGeLdvDB0Mk
    wO7/6QDPeUCWJRIeFeHfGeJVczDlNZZ2ftboO2VUZoxqfhMWplahmvRs435fmTcu65EruG
    GKibNZjFYkraWCvCHKNuuM+girrZsoS6cZ0ID/p5mmoF7te3dCku4zNvLsF3A5umGd4ICI
    BDLHEA5+DgefucuqyA436OrW9l6J5XcYlCLo5u/W3Zh/aNUcGUT72tMrsaP9NkXU2ptBoF
    B68ZRsfIzvQznVifzegvzdAOEJc7FI7c9BwPWajWLNF7NntV2oKgViBQ+uTg
X-ME-Proxy: <xmx:zknbaqfqcGMwze-tUeuZA9JLQTElicjGSfg19DULdMB5rxaSy38kgw>
    <xmx:zknbatJwoNfqQvkMVuUp6A12ZozhAijhBmiN3aGMkcAq4CFphSzK7A>
    <xmx:zknbateg3K9WZX2NDKYs4De2Po9GN7xtniG8UAN3eBWS9DwaiVf20Q>
    <xmx:zknbak1YOq1umByEWgrUP2ncNzDGM5_3TvBr3oG0WJ5bL6DjR8KQbA>
    <xmx:zknbalHYaW0KPD7e0KpPm8j7U_-3wMQD-M5FKIrNP6WnB1YhZWLWyxog>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16fb69e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:13 +0200
Subject: [PATCH v3 4/7] builtin: expose the object storage format
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
Message-Id: <20261023-b4-pks-odb-extension-v3-4-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The ref storage format of a repository can be inspected via both
git-rev-parse(1)'s "--show-ref-storage-format" and git-repo(1)'s
"references.storageFormat" field. Introduce the equivalent options for
the object storage format, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-repo.adoc      |  6 ++++++
 Documentation/git-rev-parse.adoc |  5 +++++
 builtin/repo.c                   | 10 ++++++++++
 builtin/rev-parse.c              |  9 +++++++++
 odb.c                            |  7 +++++++
 odb.h                            |  1 +
 t/t0001-init.sh                  |  5 ++++-
 t/t1900-repo-info.sh             |  3 +++
 8 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index cb8c1e7292..d2dc9b7a69 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -105,6 +105,12 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`objects.storageFormat`::
+	The object storage format used in the repository, as configured via
+	`extensions.objectStorage`. The valid values are:
++
+include::object-storage-format.adoc[]
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5b866af66a..9103d54d53 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -338,6 +338,11 @@ The following options are unaffected by `--path-format`:
 --show-ref-format::
 	Deprecated alias of `--show-ref-storage-format`.
 
+--show-object-storage-format::
+	Show the object storage format used for the repository. Prints the
+	value of `extensions.objectStorage`, or `files` when the extension is
+	not set.
+
 
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..b73dff898f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -128,11 +128,21 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      object_storage_format_to_name(repo->object_storage_format));
+	if (repo->object_storage_payload)
+		strbuf_addf(buf, "://%s", repo->object_storage_payload);
+	return 0;
+}
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "objects.storageFormat", get_object_storage_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ec33c19bdf..d2154eac8d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -17,6 +17,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "odb.h"
 #include "refs.h"
 #include "quote.h"
 #include "object-name.h"
@@ -1138,6 +1139,14 @@ int cmd_rev_parse(int argc,
 				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
 				continue;
 			}
+			if (!strcmp(arg, "--show-object-storage-format")) {
+				const char *format = object_storage_format_to_name(the_repository->object_storage_format);
+				if (the_repository->object_storage_payload)
+					printf("%s://%s\n", format, the_repository->object_storage_payload);
+				else
+					puts(format);
+				continue;
+			}
 			if (!strcmp(arg, "--end-of-options")) {
 				seen_end_of_options = 1;
 				if (filter & (DO_FLAGS | DO_REVS))
diff --git a/odb.c b/odb.c
index 0649622bc6..a0866e6c88 100644
--- a/odb.c
+++ b/odb.c
@@ -40,6 +40,13 @@ enum object_storage_format object_storage_format_by_name(const char *name)
 	return OBJECT_STORAGE_FORMAT_UNKNOWN;
 }
 
+const char *object_storage_format_to_name(enum object_storage_format format)
+{
+	if (format < 0 || format >= ARRAY_SIZE(object_storage_name_by_format))
+		format = OBJECT_STORAGE_FORMAT_UNKNOWN;
+	return object_storage_name_by_format[format];
+}
+
 enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload)
 {
 	enum object_storage_format format;
diff --git a/odb.h b/odb.h
index cb0505334a..1340f60632 100644
--- a/odb.h
+++ b/odb.h
@@ -37,6 +37,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err);
 enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload);
 
 enum object_storage_format object_storage_format_by_name(const char *name);
+const char *object_storage_format_to_name(enum object_storage_format format);
 
 /*
  * The object database encapsulates access to objects in a repository. It
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5e7c25e42c..d080ab04a8 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -853,7 +853,10 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files bac
 	git -C objstorage config set core.repositoryformatversion 1 &&
 	git -C objstorage config set extensions.objectStorage files &&
 	test_commit -C objstorage A &&
-	git -C objstorage rev-parse --verify HEAD
+	git -C objstorage rev-parse --verify HEAD &&
+	echo files >expect &&
+	git -C objstorage rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index d115d2d9f9..493a78f230 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -69,6 +69,9 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
 test_repo_info 'object.format = sha256 is retrieved correctly' \
 	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
 
+test_repo_info 'objects.storageFormat = files is retrieved correctly' \
+	'git init' 'objects-files' 'objects.storageFormat' 'files'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false

-- 
2.56.0.307.g5fe7bd680c.dirty

