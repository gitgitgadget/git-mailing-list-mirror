Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084382;
	b=y9kwud+wOaCA+KQdVlqUpuoIc2q7UkQ2O1E94FrbLLJtoI2/t3GQYuhrqD7t/BPvojXA
	 0mFoxxXm0Bt2X3Gmjth1M7uvKneosOz9UYx9YT2I4ypBCBWZsmVJybfW9z6qs/VwL6B23
	 UqAV+hQ3C4d7ADPbrFVRw3pmevAo2qX/oYTDOZSfAY620knfBko21y92oU1AreHThm0X4
	 pS/dINvxB4Sup+WD38ovlt0nDgeXiXf84sJAJ31XGkuVKIq/YlP0cikw8G+JdB9yDjWh1
	 m4UFQBjGQ+XLdz0DVuFpNjrapuMrz1csgh5DMz6oEFjJMkdJfT0/VSrz/d5tgaLjAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084382;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JJIfDN57/BOHylYFRz6xdpN+Tb5pzoQaHn6vIL9TH+k=;
	b=Zr2MIjFcvSrMT1kfcBui96VL+Rkqo+m7zH7RJSEpv2ZukFAwMlqJNyk0tf3VMLuzCQqr
	 z4KGA8SyBgPzvtIirK9+eFVQT0sRQQgYjb/3I1+7gKgdLUNs/UpqSFF2ImqF3ko/FlIvd
	 yeAvzoLILAzWe9qEzIWupMaZz4Pf2/Tb0ozV9elG0/cGw/fAETsEbiEvjf9q8j1qf1CSA
	 BUPn/U23zp5ACqirth1JNPthhxoqaKsQATujVPRHtFCLhvA+o+Jxj+bMG/eX7yyO2Gpo6
	 FMu2SigoYdjpLVjJdnqednllJ1TKfAEK8cxKdfmOjvGmQ9OGyd8sthUpeXeaEYSxpJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Gld3RlkI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=w1nYAPm1;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CE606A324
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314CE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Gld3RlkI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=w1nYAPm1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C93F7A00AE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 02:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084381;
	 x=1793170781; bh=JJIfDN57/BOHylYFRz6xdpN+Tb5pzoQaHn6vIL9TH+k=; b=
	Gld3RlkI7n+oCBCiSJVv7H0YsR/G5D0p61IQgivOvq7r6HA6IqpEW5DQdezOP55g
	K433qVRIW9jlFu5ajdA69CSSR2Seegg28AcCckwtbz5+3meU9F4mlt7fJQAGRaPK
	OWJFrtLW4o8IUC9XJKf+STLrLUBKCm8XAAaASnRcd3Lae1rXXxCRWItXwYr4w07p
	sEgpoY+Zj+ucurd1t1NzZM0LrbieixNfRztq/xMXVnx2JDtoYN6F/kqrj9M/hI71
	KqH8EzbU1z8L0jN96+ZUQkBI6gY4TSLNWinxDebwHTG9/NLfbELRRvuEG/l1jEfD
	NmHx/CBHwpYJZxUIPFcq1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084381; x=
	1793170781; bh=JJIfDN57/BOHylYFRz6xdpN+Tb5pzoQaHn6vIL9TH+k=; b=w
	1nYAPm1sFxSFyF17M2bPI3vjd5F0dN/tMY4d3SVYMj4m3Pjs5wfaTg1wuXU7qRyt
	92ykhcdKctd6UbK+XwxCzTYekK5C5ICVxRPcMCOk0lhYccLHMFiEQta8+SRRmphC
	HmC2RuaY4pp2QIRyxsz6S51CLuPDIBfqiYOAabXvJLp4s0sCfS7QnLKZ+y3Zo+HG
	JTP+j4F0rkGKaNjKq3NapWwpyVtwdtkFcerHjha99iEs3NJqVClLInDqb67g5Rib
	HMgpLEpvFgtemSnbsqYzw4YmGQ3wD1JHGtp7zqbA11MLiUqLggYjYwZqFYU352RW
	pxXmLC2RImClVB5raueqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084381; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RxDl+O6MU0oYtpOdcxkZX2z6/HdkVL4bxsmesFJxz5fG2z0
	Jp3xehubbKNhDxaK37lW1zuFTMDjusGeolFJbi8bN0VXpE8etDx3tp81EHfeiPCs
	iZG6f4FECaSqNltAman6OOi9at5J5W7woia8rqdoBZDwW3sy+evNj+BRw5PRPLVq
	8QDOalxm1lDvA+68KoysqarUoRIKx/jM/aDqTX8DtO/r+WLR2h/N5XkXrtTl0BeC
	FfdW4KG49k9m9EONZr4IqZT74Bz1KR0VsZ0tXd/glgCx8gsjIvBtcIKNYxrbny26
	bNGrkWyUL5+ML3R0hmrWONPFZU6Ru+PPU3Y9Ciw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZIN+/LHpCt65QqNoWV0wulBZkx9yk4k0NAXQlwh57iU=:b+8VFcXuuaMfaBIFQIthfK3Qv1gHElW8SUmS6nmWJpQ=;
X-ME-Sender: <xms:3UvgavVATR47xKxOWkHTH-nbCKEq-nXmZ8zS5_RsFapHu6hGwX8P4g>
    <xme:3UvgavC97ljvMWN08H3PAo0wKRarG6tpvjESp7YXaX93WZNJLIOmnSpaqRfr-u7Qw
    NHf24sY4JIB0EOQiNUg6GuQSANR9LYpxqMPioQVaBsHh5qBiNjasA>
X-ME-Received: <xmr:3UvgaoyHCspduiJ0ZBQ4KJDB2OB_TZSteOLFAdGcrUm_NBLl354Ulg>
X-ME-Proxy-Cause: dmFkZTFiJTMoZfENaBRamlYo6jUwqtatctngIl80GnvY560Z60MghnxUHqRWClEMaPNhjz
    GTSfIyE1WJQoctVHBHcB9oqzxn29/aS/wxltoM3v+Eddp3vW0tFqELsNHqwHObuah6wXaK
    Tv3W/aRFBNzMbwsyJh8klZVQRosY4pcaM90kygnealj6l6R7jKJW7rGBVCVOU7IlyofFzz
    PYAHj6mARsrC4ZeY3KSSkM1y2Ytx8T8H97lr6BJSTinbAhHkAZvYaI2wZD8NLtlhQzoz9x
    R4bAE+ZnGpJDEvL6xN5pIz6CQbk0/nuwRaGJWxk9ubc9HnjcaEiwOb9xwryuT8o9+oUBoa
    5W0rSMEx4Grndnfdmt7B6srbmvP199C0PTkQ9XZVn6BHWto2vdenMRha6TykUwG4aOTK+V
    Z+n9sGR5lwTAmfxwgzDAnbrx+hIXdEAyqkxNjsVx1CS+RfpiCX23k/0kZt7mDQ16hftpcJ
    sNiCLRSekdqcBglCo2N7sitnj+yV870nvgqhSe0ekq9V6yJ6U0NvzKg1Ylx+MnZT3aV+yL
    KMjoQhBGuNALh1UBREMFy3Zt6lOBUtATjc+CLt/Rj4LKUxNICGAHKOFIG7thvwKhjCuqKf
    +8IUFZhssI6HL+w+5AGAWQy7ccsNECbX7MigoGtm5IBklxqlHl4gBGJcjgDQ
X-ME-Proxy: <xmx:3UvgakACHsLKMuH8yKO1WsLkyZwC1SdvXf6iKq7aiGIIp76-DfD4bQ>
    <xmx:3UvgatbwLZoURg70V5dUcCs3KJ3XrMGmzZRf2UTaNnF5Wz8awH1vbg>
    <xmx:3UvgakhQyY_JONW3mYE7EDs3rvkXWk7yGrjLG49fY1MVsvcgCaUz3g>
    <xmx:3Uvgan7oCvdkaJRZga_vuhZXOEt2ft-bzLQDiUYYPMNslpM6cCjQRw>
    <xmx:3Uvgajf1tEcdamf3xF4QV5wIQVAM6e0VqweWMHlpURFAEaNhE7DzXrxY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00692ea4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:26 +0100
Subject: [PATCH v4 2/7] setup: introduce object storage extension
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
Message-Id: <20261027-b4-pks-odb-extension-v4-2-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

Making the location of the "files" backend configurable is not he most
thrilling feature of this new extension. But it gives us a couple of
advantages:

  - It allows us to start exercising the payload logic in our tests so
    that we know it's working properly for backends that will need it.

  - It allows us to easily detect tests that are broken with the new
    extension because they for example assume that an object is a file
    in ".git/objects/". Testing is not part of this series yet, but will
    be done in subsequent patch series.

  - It aligns with how we handle the ref storage extension, where we can
    also change its location to an arbitrary path.

  - It allows for some very esoteric and edge-case-y gimmicks. For
    example, you can initialize a single repository "skeleton" and then
    multiplex therein by setting both GIT_REF_STORAGE_FORMAT and
    GIT_OBJECT_STORAGE_FORMAT to point to different databases. These
    edge cases won't matter to many people out there, but we will use
    this for example as a building block for migrations.

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
 setup.c                                  | 18 +++++++++++++++
 setup.h                                  |  3 +++
 t/t0001-init.sh                          | 30 ++++++++++++++++++++++++
 t/unit-tests/u-odb-inmemory.c            |  1 +
 14 files changed, 184 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index be6678bb5b5..4f3a66a4543 100644
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
index 00000000000..4c4aef6dda6
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
index 98c5c862f56..0649622bc6f 100644
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
index 0ccc47ee73f..cb0505334a4 100644
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
index 455f409db04..4a7cbbfd9bb 100644
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
index 837e8903044..71e8db84ff4 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -70,6 +70,7 @@ struct odb_source_files {
 
 /* Allocate and initialize a new object source. */
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *payload,
 					      enum odb_new_flags flags);
 
 /*
diff --git a/odb/source.c b/odb/source.c
index b25ef14df83..a2a6d97ccd8 100644
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
index 1867347dfcf..1ab32088882 100644
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
index 970d1818281..77ecf6b604e 100644
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
index 2a348012e8a..8c4437762e4 100644
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
index 3ee19f3e3c6..99ead7d90c1 100644
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
@@ -864,6 +878,7 @@ void clear_repository_format(struct repository_format *format)
 	free(format->work_tree);
 	free(format->partial_clone);
 	free(format->ref_storage_payload);
+	free(format->object_storage_payload);
 	init_repository_format(format);
 }
 
@@ -1786,6 +1801,9 @@ int apply_repository_format(struct repository *repo,
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
index 7a3efe5e483..a4afa8910ed 100644
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
index f1d227f2716..c7c464d3a26 100755
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
index a8da278c681..c4412949c12 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -12,6 +12,7 @@
 
 static struct repository repo = {
 	.hash_algo = &hash_algos[GIT_HASH_SHA1],
+	.object_storage_format = OBJECT_STORAGE_FORMAT_FILES,
 };
 static struct object_database *odb;
 

-- 
2.56.0.341.g393f52fd96.dirty

