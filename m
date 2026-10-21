Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561166;
	b=gXRq8MppwRcUXJ/RArFYmODRzqTZ5dXMiuBp3F7lP46rigaGEgEp4KEDZs0H63R6daJC
	 2mVnVYR52ByBRyfaORJ3C2uzgujK4eeJO81b/j/6jLMK3/An48mXyR/8DfGE3aWUkyQZC
	 LXi4bYsltUZjjIDEBI9Z/iAODkw+mFzTjh+Z6SKUjfm0YtiN8bcweSNRzogNjL7XBEkuw
	 G5BLwBbgYo3gu617Jf4IillrvPxh1dXAJ7Ncnl5x5544PM10nr5e8/uOvoUxWJrXxMbxQ
	 V2llbM8nv+hKYQeZZXNIQeGulQJN7H3T4N0iZiDgFalwSPGgtXpFtye81jXO9R1PQFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561166;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=wBnU+fwbbkenCs1k218L/zQ/8DagYEa9NNaUyRd1bq4=;
	b=fKRzsWCZQYatgCHk1j5tC+Dr/ANbDcxuPvHN2o5/fTuwyAEaIcIC9FWWkEU93gzveS/1
	 yhn3A9hmI8hrgrbWrm0XGVaI/W3gUie3DXg/4amH3b/87wLJ9rWqBIy6Eb6rV6M2wvYNV
	 amd/F7ac7dls5xvGJ2bYf/Ur0Dtz6N/JkEpNblvLtuZRElPfP62GYNf1c09Nje2b93qEu
	 2/G/ytr3MUumkytBg0PJKf7H3mSxqhx5Nc30/+tVxORvRCQD830lvLJ+jIOPH0YZAGJkp
	 pqJhn9WZeJwLzwYyFxQzXouPrrEvPKeguKMyXvzRF7+S9Na5Qzz7htshXJvXgZN3D5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="PrbesMs/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TmZWxrID;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B2606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516B2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PrbesMs/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TmZWxrID
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F8111D00036
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 01:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561165;
	 x=1792647565; bh=wBnU+fwbbkenCs1k218L/zQ/8DagYEa9NNaUyRd1bq4=; b=
	PrbesMs/Js4H5bGZAtf5jTny6KHQJ3ZvrcORiVZv4brsqoCNCvzbHabMLf7beKfL
	ooUvfg+hC+HFD3Vx1bW0xr2gXMd43zRX9GE3UqvefRxI0DUuU8P+SWAo6ExaR/Cn
	3Pxl7KPYCEPl5o7oVQliYAupA5FS9d6ar1XP0aL7ftKeBTODdXNd7g0uItTtA/r+
	qZjQ/h6kulwnVk61EgERcQoje9sU25nTTngF2GyE0cEzcsXTei0rdZ374NHD/oQK
	snoA+b+70KSq7XdlNU8p1qKlo2GM1ZyY4jTeBuyBIcJbpaxpwMG9N6lXxa5mVS0H
	p3MPhYr/0K8iYCStCa/o/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561165; x=
	1792647565; bh=wBnU+fwbbkenCs1k218L/zQ/8DagYEa9NNaUyRd1bq4=; b=T
	mZWxrIDBsIgAQawSO44ri/eOxomtgOw9GtlhGv8qMub6aQa7TZC/wtqnYekP78HU
	UbYR/lTCWLkBNDVQQDKLc7zcpwQyj3u09ZIed9EbI1KLXeyspIFNz/R/tkDAQ0dY
	HC8UF1JW4pSqb0R+CXO6SCQzB7mMKds4E8O0U467hF/KszuXGeqBK5aPa0JS70KM
	s7pTFcUponhfI6c18aPHq+a2rnfpA2dGtK9p1/4o9Jsy49W5kFC1FECyyCJfHOTI
	fYrjWpd8mJBdWeyjDBuH3ayP8E82qHL4poCLCj5Lh/22jSUBetzuFhb9HfFWxNxa
	1bAbTv6H+hqfGzkH571dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561165; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ADT9MjdbDPX6nxrma30sn2uZu6YFJAFotJh629Ck+81LlCR
	+qtiGxWF7lJBnNIIZYbusH8ARwbXY7sBE330OFsuGTMAkq0i/snL4yI2k/IxP7+p
	faAbt9PQ/Y7ySfcd9C5tP5kBFk+6a5rtZKJlan6zrtJP+VIcHftMXgfVb6qYU9ni
	aa0dNmvMZXiQXMGZ/xTcaZwxKELO0+tsvYXWQDAUF5dBsEKKVNofpv22SMW7046+
	Jz66ejUbt4pj6DQ5v/rqdXjchwg9blywEhhZrVxCZGy973ku6K4TfbMUz7b2nGgx
	ymKH5oVEwb/A3kBxFM04tMUdtjA+pviMgWIZkfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sMQVPCBZu7WJobsIcFygmE6B9Gz0Nsu4sLMpk2Plfyc=:NZjSYLMH2yfUtW+hDqUMqMLRdmvNVTUoNuMAp0gNSOw=;
X-ME-Sender: <xms:DVDYaloVKnFZ5rxlWf0iHaOo5hZGsO66DHyaETlnq-zUpLn00UImDg>
    <xme:DVDYatqSpZFhmW2iMYdKlO4aFVZ3Ysxd5HYrIUbA5L4QhAF6RS28oNwUQ0DubGhoH
    J1uU0kll7Uc6Sox1l4FsMpaZWVcxGGFg7Rhn-3wmgoWS6UUgmwr8bI>
X-ME-Received: <xmr:DVDYav1YsGYV7qCF2UU4ngpQ1nm9im3KqC1tdFp93cnqbT0YaYPotw>
X-ME-Proxy-Cause: dmFkZTFjdiHAftcLcxym7iyS6GGrr/hwgFjz6lyXgvbwNBTSpUGjBHjsxHa7aWLwD6r8/y
    i2fuv7S9i1ADuywbn12Qket1cjLDXkJ8huziohbALlYFFv5IeSPdo64QwnwB3rK4fKY8wr
    6vG2mCCE9emAm7rwWxvUG3vs+lrefardrkhp+6NcddLYfYabalVLmpcdWs+HVZZxn+9RGQ
    GoZCIDcFFBIkpfsCmvOapl7dvlB/aeoZBxOJxhKRitBNLvf253VGsHLOlhed8EgJLNxlKS
    L5ApeOskZ0InMS3wHs4ISt+Rs2ia27LW4DilV75gqOCUTkCtNCrOfSgpi23lq1zKjF5SIR
    sH1LOMymZLDEETbuSIruaGpM9402ZaNKE5p4Iep9jbpxOsUycqUmo2Jg5AhwCx8JCQcIjp
    6SyDTJAyqq3F28IohRzykCwaAUYbLcVRAew+WE9ZuyzqV02DA9hjSDKsNA1R7sCLtNzQAw
    mxMDOmpE4k2qdZsFFqw1ov80c/assEud5nI4mS3ex9SsYj477a3mB5Zx6mkS2ekf7m5Uop
    ckhHEcHI/VToYrrzdZih4clOTpR6cNaqmXukrQPUIt3a/AL//euNRimhTZ0uVYrL8pT2DJ
    WksM9O1cV1YJo7NwlpcGIp1xWVCsfuquK0+bwJM+1A3iLCoQO4V5xyjqdtFQ
X-ME-Proxy: <xmx:DVDYasB6H8AoXVDNBVYnjQv5kx4PcymeSbQi6iVd2QIjYC8BiFAtiA>
    <xmx:DVDYandBdqh3zvQ7udLQI0fD95zvF8AOl_tOL1AgRHKOPiXIf7Wesw>
    <xmx:DVDYahi1diIGDaf6lXvKMGa4Wtpmr4C3ysApebBcJeQ3dR3Z8enH-Q>
    <xmx:DVDYavpd8_DQymdCzmxSt0Gt2eeTAXZJgD7Z-ThzXzvpEJ1xOZasWQ>
    <xmx:DVDYak49auW_zF6vwj-cbudvteD4anc3rJ49HCuoE4CDuzF6M9f8UoFK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abf5c3f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:15 +0200
Subject: [PATCH v2 2/7] setup: introduce object storage extension
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
Message-Id: <20261021-b4-pks-odb-extension-v2-2-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Introduce a new "extensions.objectStorage" extension that allows the
user to configure the primary object database source of a repository.
The value is a URI in the format "<schema>[://<payload>]", mirroring
the format used by "extensions.refStorage":

  - The schema identifies the backend that shall be used. For now the
    only supported schema is "files", which is the existing object
    database backed by loose objects and packfiles.

  - The payload can be passed to configure the backend, and its
    interpretation is backend-specific. For the "files" backend, it
    allows you to configure a different location for the ".git/objects"
    directory.

Eventually, this mechanism will be used to support alternative backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/extensions.adoc     | 23 ++++++++++++++++
 Documentation/object-storage-format.adoc |  6 +++++
 odb.c                                    |  2 +-
 odb/source-files.c                       |  7 +++++
 odb/source-files.h                       |  1 +
 odb/source.c                             | 45 +++++++++++++++++++++++++++++++-
 odb/source.h                             | 12 ++++++++-
 repository.c                             | 11 ++++++++
 repository.h                             |  8 ++++++
 setup.c                                  | 13 +++++++++
 setup.h                                  |  1 +
 t/t0001-init.sh                          | 30 +++++++++++++++++++++
 t/unit-tests/u-odb-inmemory.c            |  1 +
 13 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index be6678bb5b..4f3a66a454 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -56,6 +56,29 @@ preciousObjects:::
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
+objectStorage:::
+	Specify the object storage format and a corresponding payload. The
+	value can be either a format name or a URI:
++
+--
+* A format name alone (e.g., `files`).
+
+* A URI format `<format>://<payload>` explicitly specifies both the
+  format and payload (e.g., `files:///foo/bar`).
+
+Supported formats are:
+
+include::../object-storage-format.adoc[]
+
+--
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1]. Trying to change it after initialization will make
+preexisting objects inaccessible.
++
+NOTE: This extension is still considered EXPERIMENTAL and may be subject to
+change.
+
 refStorage:::
 	Specify the ref storage format and a corresponding payload. The value
 	can be either a format name or a URI:
diff --git a/Documentation/object-storage-format.adoc b/Documentation/object-storage-format.adoc
new file mode 100644
index 0000000000..4c4aef6dda
--- /dev/null
+++ b/Documentation/object-storage-format.adoc
@@ -0,0 +1,6 @@
+`files[://<path>]`;; for loose objects and packfiles. This is the default.
++
+The optional payload can be passed to specify an alternative filesystem path
+where the objects will be stored. Relative paths are resolved relative to the
+`$GIT_COMMON_DIR`. Defaults to `$GIT_COMMON_DIR/objects` when no payload is
+provided. The payload is ignored when `GIT_OBJECT_DIRECTORY` is set.
diff --git a/odb.c b/odb.c
index 98c5c862f5..6c07b3b671 100644
--- a/odb.c
+++ b/odb.c
@@ -757,7 +757,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 
-	o->source = odb_source_new(o, flags);
+	o->source = odb_source_new(o, repo->object_storage_format, flags);
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
 	return o;
diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..4a7cbbfd9b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1235,6 +1235,7 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
 }
 
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *payload,
 					      enum odb_new_flags flags)
 {
 	struct odb_source_files *files;
@@ -1245,6 +1246,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 	}
+	if (!object_dir && payload) {
+		if (is_absolute_path(payload))
+			object_dir = xstrdup(payload);
+		else
+			object_dir = xstrfmt("%s/%s", odb->repo->commondir, payload);
+	}
 	if (!object_dir)
 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
 
diff --git a/odb/source-files.h b/odb/source-files.h
index 837e890304..71e8db84ff 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -70,6 +70,7 @@ struct odb_source_files {
 
 /* Allocate and initialize a new object source. */
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *payload,
 					      enum odb_new_flags flags);
 
 /*
diff --git a/odb/source.c b/odb/source.c
index b25ef14df8..7917ecc990 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "object-file.h"
 #include "odb/source-files.h"
 #include "odb/source.h"
@@ -23,10 +24,52 @@ const char *odb_source_type_to_name(enum odb_source_type type)
 	return name;
 }
 
+static enum odb_source_type odb_source_type_by_name(const char *name)
+{
+	if (!strcmp(name, "files"))
+		return ODB_SOURCE_FILES;
+	return ODB_SOURCE_UNKNOWN;
+}
+
+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload)
+{
+	enum odb_source_type type;
+	const char *schema_end;
+	char *name;
+
+	schema_end = strstr(uri, "://");
+	if (!schema_end) {
+		name = xstrdup(uri);
+		if (payload)
+			*payload = NULL;
+	} else {
+		name = xstrndup(uri, schema_end - uri);
+		if (payload)
+			*payload = *(schema_end + 3) ? xstrdup(schema_end + 3) : NULL;
+	}
+
+	type = odb_source_type_by_name(name);
+	free(name);
+	return type;
+}
+
 struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *object_storage_format,
 				  enum odb_new_flags flags)
 {
-	return &odb_source_files_new(odb, flags)->base;
+	struct odb_source *source;
+	char *payload = NULL;
+
+	switch (odb_source_type_by_uri(object_storage_format, &payload)) {
+	case ODB_SOURCE_FILES:
+		source = &odb_source_files_new(odb, payload, flags)->base;
+		break;
+	default:
+		die(_("unknown object storage format '%s'"), object_storage_format);
+	}
+
+	free(payload);
+	return source;
 }
 
 void odb_source_init(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..c194b3254b 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -32,6 +32,14 @@ enum odb_source_type {
  */
 const char *odb_source_type_to_name(enum odb_source_type type);
 
+/*
+ * Parse the given URI in the format "<schema>[://<payload>]" and return the
+ * source type identified by the schema. If `payload` is non-NULL it will be
+ * set to a newly allocated copy of the payload, or NULL if the URI has no or
+ * an empty payload. Returns `ODB_SOURCE_UNKNOWN` for unknown schemas.
+ */
+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload);
+
 struct object_id;
 struct odb_stream;
 struct strbuf;
@@ -304,9 +312,11 @@ struct odb_source {
 
 /*
  * Allocate and initialize a new source for the given object database. The path
- * of the source is derived from repository paths.
+ * of the source is derived from repository paths or from the object storage
+ * format.
  */
 struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *object_storage_format,
 				  enum odb_new_flags flags);
 
 /*
diff --git a/repository.c b/repository.c
index 970d181828..5b1f1460e0 100644
--- a/repository.c
+++ b/repository.c
@@ -217,6 +217,16 @@ void repo_set_ref_storage_format(struct repository *repo,
 	repo->ref_storage_payload = xstrdup_or_null(payload);
 }
 
+void repo_set_object_storage_format(struct repository *repo,
+				    const char *uri)
+{
+	free(repo->object_storage_format);
+	if (uri)
+		repo->object_storage_format = xstrdup(uri);
+	else
+		repo->object_storage_format = xstrdup("files");
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -382,6 +392,7 @@ void repo_clear(struct repository *repo)
 	free(repo->worktree);
 	free(repo->submodule_prefix);
 	free(repo->ref_storage_payload);
+	free(repo->object_storage_format);
 
 	odb_free(repo->objects);
 
diff --git a/repository.h b/repository.h
index 2a348012e8..e9a3a7f18b 100644
--- a/repository.h
+++ b/repository.h
@@ -178,6 +178,12 @@ struct repository {
 	 */
 	char *ref_storage_payload;
 
+	/*
+	 * The object storage URI in the format "<schema>[://<payload>]", as
+	 * configured via "extensions.objectStorage".
+	 */
+	char *object_storage_format;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
@@ -255,6 +261,8 @@ void repo_set_compat_hash_algo(struct repository *repo, uint32_t compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format,
 				 const char *payload);
+void repo_set_object_storage_format(struct repository *repo,
+				    const char *uri);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index 3ee19f3e3c..499b5bbe3c 100644
--- a/setup.c
+++ b/setup.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
+#include "odb/source.h"
 #include "refs.h"
 #include "repository.h"
 #include "config.h"
@@ -687,6 +688,15 @@ static enum extension_result handle_extension(const char *var,
 				     "extensions.refstorage", value);
 		data->ref_storage_format = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "objectstorage")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (odb_source_type_by_uri(value, NULL) == ODB_SOURCE_UNKNOWN)
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.objectstorage", value);
+		free(data->object_storage);
+		data->object_storage = xstrdup(value);
+		return EXTENSION_OK;
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
@@ -694,6 +704,7 @@ static enum extension_result handle_extension(const char *var,
 		data->submodule_path_cfg = git_config_bool(var, value);
 		return EXTENSION_OK;
 	}
+
 	return EXTENSION_UNKNOWN;
 }
 
@@ -864,6 +875,7 @@ void clear_repository_format(struct repository_format *format)
 	free(format->work_tree);
 	free(format->partial_clone);
 	free(format->ref_storage_payload);
+	free(format->object_storage);
 	init_repository_format(format);
 }
 
@@ -1786,6 +1798,7 @@ int apply_repository_format(struct repository *repo,
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
 				    format->ref_storage_payload);
+	repo_set_object_storage_format(repo, format->object_storage);
 	repo->repository_format_worktree_config =
 		format->worktree_config;
 	repo->repository_format_submodule_path_cfg =
diff --git a/setup.h b/setup.h
index 7a3efe5e48..9145aacc5f 100644
--- a/setup.h
+++ b/setup.h
@@ -192,6 +192,7 @@ struct repository_format {
 	char *ref_storage_payload;
 	int sparse_index;
 	char *work_tree;
+	char *object_storage;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
 };
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..c7c464d3a2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -839,6 +839,36 @@ test_expect_success 'init with --ref-storage-format=garbage' '
 	test_cmp expect err
 '
 
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage is not allowed with repo version 0' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set extensions.objectStorage files &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "repo version is 0, but v1-only extension found" err
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files backend' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set core.repositoryformatversion 1 &&
+	git -C objstorage config set extensions.objectStorage files &&
+	test_commit -C objstorage A &&
+	git -C objstorage rev-parse --verify HEAD
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set core.repositoryformatversion 1 &&
+	git -C objstorage config set extensions.objectStorage garbage &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage${SQ}" err &&
+
+	git config --file objstorage/.git/config extensions.objectStorage garbage://payload &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index a8da278c68..d7261b9e0c 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -12,6 +12,7 @@
 
 static struct repository repo = {
 	.hash_algo = &hash_algos[GIT_HASH_SHA1],
+	.object_storage_format = (char *) "files",
 };
 static struct object_database *odb;
 

-- 
2.56.0.307.g5fe7bd680c.dirty

