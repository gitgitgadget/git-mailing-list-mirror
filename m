Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084387;
	b=C+DLIF847h40BCX/EjpKsEg91i4X9m753tcJWBhnw6VWtRaOH0gxndDn5WaAamZTAyty
	 yzSr7ElHhFnwhmZzXHc+tJcexxwo5BVfycli1Da68ikAo2TyL2CUMJcb6ynzClhLBQGEx
	 71G4GkhMXkP1wlQ0wR16OiC/gBxZzaTeDAIpebXwyvY3sLfkr9v7wIt/typRURqZdhczC
	 eOyVL0Ij2iTBidR9PmRkAYzMBC1J5cktsjrUmm0i0Q6jig7OwDjW1drOhc66cx9w5SG1f
	 9JbFonu7jpklMYG/Jf+oIcRDAI9uyIg7mPo9vk+qtlbFefYJSEX0IarQPlq8cfol5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084387;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Pur26WguYA5a3JPR8NdTQJZmr8hfGP3x0U2h4+ej//w=;
	b=QdtBpn+UJFq+IuqjxgcCsQqaW8DN3nw8V7qg+eecqI1I+yk+xzSrXStscktEsObuccfJ
	 cDYhKxuhJ+BzND+tOwBfVUt+adTMs+bKaGxxj8wB8kOlnsVPwDOXkugQln46M7PiWtiXE
	 KegLljlcGYBOLIiHlV8fSRr7xBvy3ejd76ZviTa0PJB4DtM935ajUkt28w97vlQzENaMI
	 SNt5nc67PefpHj6MRvOQ3gi8nQQqaauEL2u73W16VIKvnz/GRrDw293YK6Rd4pv2r2Tyx
	 PpdK3FVFUkfXwxoioJRuXOml4FcdHcRnUCqDFSSWOdXKDseQhhLMb41kt5M72DImoRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=m3vB1UuM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v2lEB7l0;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C71606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C71606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=m3vB1UuM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=v2lEB7l0
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74EFF7A00E6
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 02:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084386;
	 x=1793170786; bh=Pur26WguYA5a3JPR8NdTQJZmr8hfGP3x0U2h4+ej//w=; b=
	m3vB1UuM5mrs1PVjVWedMd5tHNDYMAXAoa2lpBoyzBCcCwtGkB+QckKXqaQDP4yI
	oZa86OUGQ9lYR7mQBvyBL3gojDF2v+L2siL9T7cuKQeWRzpxa3vgRaegQzFbh+hX
	77zmMBRG/AzDJkScvCvzmAY6+mXn1EwreokydMsFqtc5VsP0e68a34YfMGGB2adc
	mq1wdSatQ2fysR+cq5yaTpfbKty1hv20m70Y2d/PdJuc0GcJ9Y/GN+pzFRq3pUM+
	qyIYlJOBAi7vNShqBFdsYrSuXLH7r+VYiU3CaPkY6JKlc1VG4Mz5CAxftxCeBlz0
	AQ9qZ77uSYSu3sQoaiPgxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084386; x=
	1793170786; bh=Pur26WguYA5a3JPR8NdTQJZmr8hfGP3x0U2h4+ej//w=; b=v
	2lEB7l0kdfSsf8wBfyR116Vh4sYcFS4pgXdBZqLmHl9jJb8bLtls61Q+8z79GhWP
	BQxMmFdV81UCeaFWvTse8qVNQzK24bbl6f6cxegPSasc+PCJ8j7MqOknPDWPzrG/
	Oddgn9vDWushoOfT++ALOc8ngxrCi3cyTLXgPrCGdgkjai4mvI3lDjfiDJ35NPGa
	VEy8sm5mcjYJNTZyd3cJF2tS/mfZX772Bu9FZaFpMbrmYTPkvBcjMW9Z1ByCx5M+
	A1rXoYiTFUy0SYtwupQbDV48V7dp3gsfKGjJJIa3Q64yV2bZv+xhvSNueMJc1QFI
	GgxhZhfCqeSQOhZ/NY1xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084386; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vGn8+grJZTAH2Ql89NybStAO2dVPplEjeDpupPdEpbCj6l4
	43xg3WTCHrIUnwMTkxwltm/QCwt2DhQwu+1ZNdo7iNX9KenwMGguwTgJvHRsx1Nb
	plhWSJcWA60cizlF7xFRqAUtDAYyCZ7Fk/w5tRcGMWnEGU7A5VriMMvuIvLKGvpw
	mtPJVI7yI35m5Y8VT/LhuPF1qefthMJ3OX/gC/cumQvxA2OZsKDX3GGKApkv0vPE
	0MK6Zp6ZqKMNDjDoiPsq8rgIfIZB5kxQjP5wkC0mPcZtOweJV9RJrd4SwW/D6rRC
	KUYNynEcFhTnYlNg4Uf0e2ryhRpE+WZmgWRkhdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hdbhZNbp5GnR/GkbeULsVsglrTy3klMDlG5piGN4oiI=:cllaBROOdg/236wnSy5r4Zlv2ncRhUBjQxJfKjpus6M=;
X-ME-Sender: <xms:4kvgal-QbO92ckwMZEYOvEclp4ePV32WDLyqfOIHWdIs0Q0rGVea4A>
    <xme:4kvgahLKVKYOHEzTywBfmbPe79zd2yHWE2-0Ct0FeVZuYfFkF_-fDOghTl22FaVkT
    9sgl13jrajv70RJ3e5MuqQF-_ugspH9jfvj4nKt7pGeEhmkYx66oA>
X-ME-Received: <xmr:4kvgagY-vBirkf840FuGK1N3d_ukdCGURMxQKU0OOKihAkndmQd0vA>
X-ME-Proxy-Cause: dmFkZTFiJTMoZfENaBRamlYo6jUwqtatctngIl80GnvY560Z60MghnxUHqRWClEMaPNhjz
    GTSfIyE1WJQoctVHBHcB9oqzxn29/aS/wxltoM3v+Eddp3vW0tFqELsNHqwHObuah6wXaK
    Tv3W/aRFBNzMbwsyJh8klZVQRosY4pcaM90kygnealj6l6R7jKJW7rGBVCVOU7IlyofFzz
    PYAHj6mARsrC4ZeY3KSSkM1y2Ytx8T8H97lr6BJSTinbAhHkAZvYaI2wZD8NLtlhQzoz9x
    R4bAE+ZnGpJDEvL6xN5pIz6CQbk0/nuwRaGJWxk9ubc9HnjcaEiwOb9xwryuT8o9+oUBPE
    FQ/ok3UIVpx0gkA0NJrFT4CVJREQi8eHcfzqejFx4IO2sBHpudhhGnX8nN6KKIerj8b5O/
    10e64qDkxEpa8QK4Z/8DKP46Ip/DwOJ/6EDmMliUwlodRkKV6yiWCszV4vKKrZUQm38T8u
    RYzCgVDJcd3kl/OJSOFgBm75UDQUeJZBcOVSUgtk6zvyKnfT7QnSq2c7CR4dfvBWU9rro3
    uqIrATBHs1e02ufnVMg09uB3gP6Q8H0LF9F+eIEwxyLZI+ScHYqMFfKfXAN94bwN7BMg4w
    KgBbK7YGUl8vtUN5X/uSVXaNSBDzHXJhFptAH7qDpoVevWKohHjn3BIzjx0A
X-ME-Proxy: <xmx:4kvgajJQMvJ_yoLc0m1zf-dRaFAVYrpHKsNUPYW4ZzW3n_6D0P0zOQ>
    <xmx:4kvgauCM8gf2QGTS1yxbVQcWFCX0I2-gIOmBtGMc5T90C_DJqt_5-Q>
    <xmx:4kvgaoq86HX9qQjWKENttAsQP0C9go1h1IVDhtW_F1UZbsppyLry7g>
    <xmx:4kvgaphMhzaBYBBRXY-GtxB94n1CPDWbUEr8lVUnwNX08pNd-_48SA>
    <xmx:4kvganlzt3FZvVcOiLDtHCGU20uidtMuGedMWuWcPRNvv53FbByOXRns>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f839d59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:28 +0100
Subject: [PATCH v4 4/7] builtin: expose the object storage format
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
Message-Id: <20261027-b4-pks-odb-extension-v4-4-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
index cb8c1e72927..d2dc9b7a69b 100644
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
index 5b866af66a1..9103d54d53d 100644
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
index 84e012f83f6..b73dff898f1 100644
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
index ec33c19bdfc..d2154eac8d2 100644
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
index 0649622bc6f..a0866e6c889 100644
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
index cb0505334a4..1340f606327 100644
--- a/odb.h
+++ b/odb.h
@@ -37,6 +37,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err);
 enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload);
 
 enum object_storage_format object_storage_format_by_name(const char *name);
+const char *object_storage_format_to_name(enum object_storage_format format);
 
 /*
  * The object database encapsulates access to objects in a repository. It
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5e7c25e42cc..d080ab04a82 100755
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
index d115d2d9f98..493a78f2302 100755
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
2.56.0.341.g393f52fd96.dirty

