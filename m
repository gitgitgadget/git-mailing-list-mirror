Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756168;
	b=G2dMN9/hbjvT/m6VY2KyP6sKffVK8xJAEMlqSsnhJ/b8Thdmk4271x8RU4/keQPp4npu
	 lYzvUSIKmfpa8FBng7d1A30BfYkq/BGVUZIKZa9TF5P6f4xDeGEWMu9wOrosM5Ht+fTqr
	 njo4s9VurerK7ph1L8CzOFW3SbodFLA2KGQewsFPsTwugyo+wS+e3c/PH88A7Df0/kWUH
	 WJCPCmcMETWxnklbF2BN+fRx0CyybAEvIR4+QqypAbD5AvuZ+uVukuw5PmkFjSZN5Opzk
	 OeiIt0naS+IlFYpwq1y+kTjZ/9Gl5hmV0ipJ9QSVJ6iVtfftNCEpYnBDzIvcGdWAk7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756168;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=dRBgK+UqIr2sTjzMxfZKzu05UZAPPB2KLgECIHmA0ok=;
	b=WyAZKF2TUiTGvjGkJr/sjNVQzQqIYzaqNZmZIXhjXGiOIY3/bZ7fokFGLdbzlRvMAWsq
	 SHTEZS94hZCbcGNdmOuCp7pMTEWtPgc2oJpfPc8OFSJQOqP+Gw6HkBREjLwdB32ltJWS5
	 KZ9hDY00KErv1hWDzbyrtD9VwdFhME8K4N9VZKe2shEP+k9ZwBMvGVY+Q2vNTjhh2TeDx
	 gpT5KlK1NOIoB1ObRE+FJdx/fFWX7sRhdc2bLNS4K2bD341rb2aEXn3cZ+c37Wl5ICIBJ
	 CsC21jsSvLuadMJBwSXFqTXqow0taAKYiW8fWi3zpvnXsupcIdDZbtcTV4AOr2gdLCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n0Vo86EB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="wOT6n/nA";
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12810606A337
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12810606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n0Vo86EB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wOT6n/nA
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 65326EC01D1
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 23 Oct 2026 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756167;
	 x=1792842567; bh=dRBgK+UqIr2sTjzMxfZKzu05UZAPPB2KLgECIHmA0ok=; b=
	n0Vo86EBoyZWYpjhAKLBzJRYh1ZbqzvRCbYmfTmI6cE5eMRKMfaZsJOm6/LgbmgF
	cABLThtIISR6RmgNYrowc0ILNXCDGQhiEZRV1Qso0OCEuSSGKqvEfPgnM5L1bu8O
	OGJXn7wxYmv+k6gg5LHSoxRv7W3royGsTX41GmM659on0rIzL6D52zqKFFPzXWqu
	0LjZsYSiKI3ExREgINVtkqhikgGbexSwG065YqFrKDzI4vIefRPuq/1NYVJT/uJm
	Qp4YMLUh3HwXlW15ixTQi7guOebi6kHOvDFpog0x3bBCLaERhFUDuMdpWEWi2rXx
	tcPanLxxau3XfnQVpsSCfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756167; x=
	1792842567; bh=dRBgK+UqIr2sTjzMxfZKzu05UZAPPB2KLgECIHmA0ok=; b=w
	OT6n/nAnb0A2j0DMIC8DES+VHFUHFi5xk713HmeSlxRyUeXymGYqYT0D49wK2Xks
	xy41ioEPT+w8RV9EN51xZYHEnjyyMJGutjeI2hxz/03DCy3HXna0h9iCwsRNUV+N
	apfJqwsRL4UyKhkga1An/hs6cpEejNHWb8i72vHcz/I+9z+uJJN1LSHtgm1aj9QL
	rCXsdGghP4g5hzhALAbKgmzaOVh9H2hTQBvwMdCQe2JZ40C+X6DEP18MUwwAHAWd
	8pRp3PZ5m/5ocVcucUHYCR0YW4wcnnsXkQOAhyXo/NpNAETT7BXIZWVBsOblZsBH
	aEsEawvx/X5EplDnKmejQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756167; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bTxXR5ipao1gNsFmRO0iXcOWermD/UQb+fG9GgZaQJ7w0Vt
	fn0MdEWJcpOURMlVNhH5RNZqk9pyp4T9saXl0CpXVIYfhfr2xP/ivnqaRLZw9VhR
	tVcAVpSh079WMjqKEGkoDd4d/YxJWDpufmojk/lvKVYzdUOsdfK86didZnquhpdg
	ZfTncThL2tPSHI/nwp5vBCZc6qDAMdP2+tjiS/Mtaa8OGBYJHBgPwVLneQ3kFWBI
	wUwzP3PrGrlbEt01XmOX7cG/lELD+JIx2aNXZ9zoWq/EXarwWbQWkxAiKrvbE8Ln
	jDqMeNrPqRg7rvCOp2czzn38edaj83lxpztGs7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0IUzpJrwzKa+9tePo+ZQIHO8hXiIOYF1QScPvv1qQow=:GOxu0stS/rJsIob2NbjBNhkdRqqzjXkX+EgYSz7R46g=;
X-ME-Sender: <xms:x0nbagaPiXHBrCT_JiVuKs7uzLFdwnc82seE7oUqi6xizVydpuhOpw>
    <xme:x0nbahbpLNSE5R3wdRX41YffWzy4Wa_j999qDKGjxvrFpWqiWsZ3wEPA5LSnWDW3f
    ghwOhpcjcjT45m8Pt-CCXOn4KqM8aQVsMCrF2qOoC_SvGYfba6VWwE>
X-ME-Received: <xmr:x0nbaon4Gdm_JllfL6PM56ZNHTAuoF7bCiEdb7eKlXeJgYmDpWDfMAKi03v2O3Mwfrw4zw>
X-ME-Proxy-Cause: dmFkZTG0+hTO+i6gMx2nVhgf75DkCE1cTt5MaS7zW1lcYP+Rtj9tZnDxzJFmwNUv7xIeFf
    pq00VhSt35RIBrEctxEBpEoN1WAdHAyzZxJpjxxR5jr7PtrISGHynyftfiUGGvyMi5UU81
    VDfcqG7TD1ZL1HjC9e+v1QSHzDDF0WmiZLwGJmjNDj1Um6RpRoLNDl31SYJ1C3FmFei4fA
    Wf+h2HH22/lslJXbXX6Kw17T5UYX/uKBinBzam/dkd89JikzU4X5/r3f/Hcw1+14lRRCb5
    IwvHBJkMXVWCT9c35EPAdsKZhlNTZNJrjBEowMV0M9iEHP91FDkgj83CRwzVxUUBq4/ktU
    dynt8VGdidnDFtsX+Y2Jt7FS1cx1F26OROGJ+7Njb9wySOe6UgD8sCVjmwysZGapSvVVmn
    2l1P+RqiYQwnH058Ka4S222DZ9jPMZl63UvuJa7Yd8b4X/IV12DdJyWbbpraDV4bAcHx3H
    vDOIMIK6M38s0nVkL2o2oNM+r9GACbHvliPstkP0i2O483EbZ8AIXGho1pHWoveBy39YSt
    7YG7Gzsot8OFHaQRhsStUmiAQEJ5I6FL0KYYmS3BN/Omtq1NpQ7NErTjUPEbcaRQCOU811
    wYwn5TTgENahgdbMJFPPcBMzt1atsQ0IkhVpSDA2HBoncC9zw0qhbc/16kSw
X-ME-Proxy: <xmx:x0nbalwxgNnnPHKrBpdpqUThZ6nuR4XLVTPS_ANmcVuoTru1kcxdRQ>
    <xmx:x0nbauMphPrs8aZVdwNgPnpRR8hsiBEj-peXAZ4KtfXxsXJzz1nPSQ>
    <xmx:x0nbahSzw3ykoPHMY-VAL9BV4mvG3zf8Poj3Bh4-FUWidtxL6eRFZw>
    <xmx:x0nbakbqOzy91BODhVtKoEDPrF9DilNhgK46CJJnqQTgENuBvaRNvQ>
    <xmx:x0nbamKKk1kaOnJMsDoi55JS3PSxNdsKfz0A7PHlUHwoU6w14m5oavP2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44a0232b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:11 +0200
Subject: [PATCH v3 2/7] setup: introduce object storage extension
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
Message-Id: <20261023-b4-pks-odb-extension-v3-2-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
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
 Documentation/config/extensions.adoc     | 23 +++++++++++++++++++
 Documentation/object-storage-format.adoc |  6 +++++
 odb.c                                    | 39 +++++++++++++++++++++++++++++++-
 odb.h                                    | 12 ++++++++++
 odb/source-files.c                       |  7 ++++++
 odb/source-files.h                       |  1 +
 odb/source.c                             | 14 +++++++++++-
 odb/source.h                             |  5 +++-
 repository.c                             | 10 ++++++++
 repository.h                             | 18 +++++++++++++++
 setup.c                                  | 19 ++++++++++++++++
 setup.h                                  |  3 +++
 t/t0001-init.sh                          | 30 ++++++++++++++++++++++++
 t/unit-tests/u-odb-inmemory.c            |  1 +
 14 files changed, 185 insertions(+), 3 deletions(-)

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
index 98c5c862f5..0649622bc6 100644
--- a/odb.c
+++ b/odb.c
@@ -27,6 +27,42 @@
 #include "trace2.h"
 #include "write-or-die.h"
 
+static const char * const object_storage_name_by_format[] = {
+	[OBJECT_STORAGE_FORMAT_UNKNOWN] = "unknown",
+	[OBJECT_STORAGE_FORMAT_FILES] = "files",
+};
+
+enum object_storage_format object_storage_format_by_name(const char *name)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(object_storage_name_by_format); i++)
+		if (!strcmp(object_storage_name_by_format[i], name))
+			return i;
+	return OBJECT_STORAGE_FORMAT_UNKNOWN;
+}
+
+enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload)
+{
+	enum object_storage_format format;
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
+	format = object_storage_format_by_name(name);
+
+	free(name);
+	return format;
+}
+
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern)
 {
@@ -757,7 +793,8 @@ struct object_database *odb_new(struct repository *repo,
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 
-	o->source = odb_source_new(o, flags);
+	o->source = odb_source_new(o, repo->object_storage_format,
+				   repo->object_storage_payload, flags);
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
 	return o;
diff --git a/odb.h b/odb.h
index 0ccc47ee73..cb0505334a 100644
--- a/odb.h
+++ b/odb.h
@@ -6,6 +6,7 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "oidmap.h"
+#include "repository.h"
 #include "string-list.h"
 #include "thread-utils.h"
 
@@ -26,6 +27,17 @@ struct strvec;
  */
 char *compute_alternate_path(const char *path, struct strbuf *err);
 
+/*
+ * Parse the given URI in the format "<schema>[://<payload>]" and return the
+ * object storage format identified by the schema. If `payload` is non-NULL it
+ * will be set to a newly allocated copy of the payload, or NULL if the URI has
+ * no or an empty payload. Returns `OBJECT_STORAGE_FORMAT_UNKNOWN` for unknown
+ * schemas.
+ */
+enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload);
+
+enum object_storage_format object_storage_format_by_name(const char *name);
+
 /*
  * The object database encapsulates access to objects in a repository. It
  * manages the object source as well as auxiliary data structures required to
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
index b25ef14df8..a2a6d97ccd 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -24,9 +24,21 @@ const char *odb_source_type_to_name(enum odb_source_type type)
 }
 
 struct odb_source *odb_source_new(struct object_database *odb,
+				  enum object_storage_format format,
+				  const char *payload,
 				  enum odb_new_flags flags)
 {
-	return &odb_source_files_new(odb, flags)->base;
+	struct odb_source *source;
+
+	switch (format) {
+	case OBJECT_STORAGE_FORMAT_FILES:
+		source = &odb_source_files_new(odb, payload, flags)->base;
+		break;
+	default:
+		BUG("unknown object storage format");
+	}
+
+	return source;
 }
 
 void odb_source_init(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..1ab3208888 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -304,9 +304,12 @@ struct odb_source {
 
 /*
  * Allocate and initialize a new source for the given object database. The path
- * of the source is derived from repository paths.
+ * of the source is derived from repository paths or from the object storage
+ * format.
  */
 struct odb_source *odb_source_new(struct object_database *odb,
+				  enum object_storage_format format,
+				  const char *payload,
 				  enum odb_new_flags flags);
 
 /*
diff --git a/repository.c b/repository.c
index 970d181828..77ecf6b604 100644
--- a/repository.c
+++ b/repository.c
@@ -217,6 +217,15 @@ void repo_set_ref_storage_format(struct repository *repo,
 	repo->ref_storage_payload = xstrdup_or_null(payload);
 }
 
+void repo_set_object_storage_format(struct repository *repo,
+				    enum object_storage_format format,
+				    const char *payload)
+{
+	repo->object_storage_format = format;
+	free(repo->object_storage_payload);
+	repo->object_storage_payload = xstrdup_or_null(payload);
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -382,6 +391,7 @@ void repo_clear(struct repository *repo)
 	free(repo->worktree);
 	free(repo->submodule_prefix);
 	free(repo->ref_storage_payload);
+	free(repo->object_storage_payload);
 
 	odb_free(repo->objects);
 
diff --git a/repository.h b/repository.h
index 2a348012e8..8c4437762e 100644
--- a/repository.h
+++ b/repository.h
@@ -22,6 +22,11 @@ enum ref_storage_format {
 	REF_STORAGE_FORMAT_REFTABLE,
 };
 
+enum object_storage_format {
+	OBJECT_STORAGE_FORMAT_UNKNOWN,
+	OBJECT_STORAGE_FORMAT_FILES,
+};
+
 #ifdef WITH_BREAKING_CHANGES /* Git 3.0 */
 # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
 #else
@@ -178,6 +183,16 @@ struct repository {
 	 */
 	char *ref_storage_payload;
 
+	/* Repository's object storage format, as serialized on disk. */
+	enum object_storage_format object_storage_format;
+
+	/*
+	 * Object storage information as needed for the backend. This contains
+	 * only the payload from the object storage format URI without the
+	 * schema.
+	 */
+	char *object_storage_payload;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
@@ -255,6 +270,9 @@ void repo_set_compat_hash_algo(struct repository *repo, uint32_t compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format,
 				 const char *payload);
+void repo_set_object_storage_format(struct repository *repo,
+				    enum object_storage_format format,
+				    const char *payload);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index 3ee19f3e3c..249bd67876 100644
--- a/setup.c
+++ b/setup.c
@@ -686,6 +686,20 @@ static enum extension_result handle_extension(const char *var,
 			return error(_("invalid value for '%s': '%s'"),
 				     "extensions.refstorage", value);
 		data->ref_storage_format = format;
+		return EXTENSION_OK;
+	} else if (!strcmp(ext, "objectstorage")) {
+		enum object_storage_format format;
+
+		if (!value)
+			return config_error_nonbool(var);
+
+		FREE_AND_NULL(data->object_storage_payload);
+		format = object_storage_format_by_uri(value, &data->object_storage_payload);
+		if (format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.objectstorage", value);
+		data->object_storage_format = format;
+
 		return EXTENSION_OK;
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
@@ -694,6 +708,7 @@ static enum extension_result handle_extension(const char *var,
 		data->submodule_path_cfg = git_config_bool(var, value);
 		return EXTENSION_OK;
 	}
+
 	return EXTENSION_UNKNOWN;
 }
 
@@ -864,6 +879,7 @@ void clear_repository_format(struct repository_format *format)
 	free(format->work_tree);
 	free(format->partial_clone);
 	free(format->ref_storage_payload);
+	free(format->object_storage_payload);
 	init_repository_format(format);
 }
 
@@ -1786,6 +1802,9 @@ int apply_repository_format(struct repository *repo,
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
 				    format->ref_storage_payload);
+	repo_set_object_storage_format(repo,
+				       format->object_storage_format,
+				       format->object_storage_payload);
 	repo->repository_format_worktree_config =
 		format->worktree_config;
 	repo->repository_format_submodule_path_cfg =
diff --git a/setup.h b/setup.h
index 7a3efe5e48..a4afa8910e 100644
--- a/setup.h
+++ b/setup.h
@@ -190,6 +190,8 @@ struct repository_format {
 	int compat_hash_algo;
 	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload;
+	enum object_storage_format object_storage_format;
+	char *object_storage_payload;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -207,6 +209,7 @@ struct repository_format {
 	.is_bare = -1, \
 	.hash_algo = GIT_HASH_DEFAULT, \
 	.ref_storage_format = REF_STORAGE_FORMAT_FILES, \
+	.object_storage_format = OBJECT_STORAGE_FORMAT_FILES, \
 	.unknown_extensions = STRING_LIST_INIT_DUP, \
 	.v1_only_extensions = STRING_LIST_INIT_DUP, \
 }
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
index a8da278c68..c4412949c1 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -12,6 +12,7 @@
 
 static struct repository repo = {
 	.hash_algo = &hash_algos[GIT_HASH_SHA1],
+	.object_storage_format = OBJECT_STORAGE_FORMAT_FILES,
 };
 static struct object_database *odb;
 

-- 
2.56.0.307.g5fe7bd680c.dirty

