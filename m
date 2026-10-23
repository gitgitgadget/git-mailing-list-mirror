Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756166;
	b=nfR/e/HDyqBrBJXoFA++YW0VX8SuUzUpwEAipnWDazBwnFYAfyiGb3lE+VGh47eqaxmU
	 jgbrOtCswkWz5U8AQkwD2BXRFHMsAoriR7XSmmESVW7deq75Aem7zeLIFR817u3PSriaK
	 J7smd7ZdU9i8DUQR4YZ4+WBCTI135G4jafSHa7+Sd6tmc3LGO1PzlWOgyRCgQychjMBlp
	 mVMTxhV3BqebPVMAKW66PHjDh8GUfy3X/gGnR/VFxDrBAg9f74uMjci8IaLcP0NsD352u
	 c20i50+6lQ6qbV3Ixklg/jik163wUw0IVcKkOyo9fd4z2TjgPzsrcTUl03yH3+gsqcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756166;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=X3gybv+Q5tmWzbL5H0i/Jd1Bg8YoYoCojSjMLrY0hmg=;
	b=KhNXaDFjkzOjJ7OdMSZTTji2geuLcTGXF/iNR910GKU60Snpdy1z5mTj3Q50wxXbbcs6
	 GdUSWEkxQKjgaRLCMniAD3OFpkuaZv7cUGBR1vJZ4fFEiU1XJQ7X0Q/fk8uQ3NntS9qy7
	 087HbfuIzUJyozkQhirhnOVOO22DzI075/ijjjLBjcsRudHQ16h5fz+poDYOK5iSYKWuo
	 cT8EnhB8yXEVdfs+sypypuGW/8GFckRPPJUelPAoehS0mgAaR3FPdE7FYev25dYvsvj2R
	 uxXfB6xOPnTAK7EFKEMjrUzzl2l9DEutlao17TKiZNvCcSZ/76P0a/l6qzDKpx8upbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="d/U8Qgj7";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KztxIIdA;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A67606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d/U8Qgj7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KztxIIdA
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFD961400026
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 23 Oct 2026 07:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756163;
	 x=1792842563; bh=X3gybv+Q5tmWzbL5H0i/Jd1Bg8YoYoCojSjMLrY0hmg=; b=
	d/U8Qgj7sOZm1aXl/pljVifRQCi0U9rCrtS5WfUFjdwcgRFmVKpC4wKVJF47+UYw
	qhHOe7j3lwGXg0gYY78Tx9X8nfNvUUTr6z4JcUyZDeL23Z5YgQRfZ+dwo5mstnGK
	fN4a3Sa7/VT20+wMvQU3dlnMZZjz8TIp3W+FcwNx37QB8YxMc5r7Qw2Ho4weZqJ8
	4chKNK16S29ZyiXgFRhGrmmHc6mO/O2ZDASrLk4kPr8R/W9qC2xMr7PUQM4bUlET
	B0slzZm++EUvpup9Dkp5tNIKg0NmaG6NlED9bnySyIpFe+lgqYC/9xqG6kqGagq+
	yAn5mKFvd36uwq8g0HKa1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756163; x=
	1792842563; bh=X3gybv+Q5tmWzbL5H0i/Jd1Bg8YoYoCojSjMLrY0hmg=; b=K
	ztxIIdAOKquwbQj+KutzofVvYWO28Z+SvrZITm6phNQ4ZNy1PJPuCCh0mN3euDV0
	tT29SPslAcx0Pl5l/vENTjs2hCL4JYlsmH65XdlTadaME7LVC6x0EeeEnaftkif+
	GS/AduGfTgYPBImm2qsODz5kiJEHrjeX3q6qJmkblsQNbnBdEcw8Sz+Ke3EQS0k3
	L6IqDJRQ7bMb0r6dUHZa6f1XtqIQl42HKYbbn/h0jkMH+04dhhz1/M76VCpAZpL3
	aT8llKq51IZhMQsMLyL+O/EZA1a817QN3/VsFpfnEhc6s5m+5GgRJDFV4FHn8e44
	7eWIyxVOTcJsHoaDIxIJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756163; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nCayynWhb/nT6vUILPCVL+RDTuxMg0GhUVawd4jIEcNU6ul
	acWVsW+NwaqfZzIzWX/G6T+m/H32FXBhNxJiWQnONIQL/PPHCIBOPQhVRhuB1oQi
	l+SIWx/NrFmYUcPm2bz3MMCGEgnh1j+wjKq8mpxPg4XvpVG6Gx8ALg5qUBBK+LEF
	g/H8mQaJh5v47vZz295iJGdBGINvmUVJKwmPWXoNUXkMeBZi336PhM2ZFQkAEi/s
	J9DwEV2rTVnj9iix/rmQ9UewTha6zyocuupfoLgUKH8pLZiIHrZbdMExi7Q2KT41
	fl1yiODNAYKZzoijetz4bOknhiv2Of0HDUyN1Vg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:srKTIM33kYBGgO8vQ8XN+VQTwsJTez3l35ZGRZDGxmc=:vga15e2ILYHjxITNwMnR7ohnELVpzccoBBWyweGldMM=;
X-ME-Sender: <xms:w0nbavQ6IC4Vf8IOGvPr5nR7GPyjWw8fTL2xCQr-IYYEFZQobD7lEw>
    <xme:w0nbamzxM2IQ58RUyxjri80iobXdnI6oyVGxuIJcCv-6O9UhJQE5-xnXDLLVedleZ
    s1u9b7Hw2PK7t3uzI6rhPx17rioT_NX29FOgZt86JhUSLsN23GWNw>
X-ME-Received: <xmr:w0nbaifJ3eajHB171m3qqwKdd8dZYpS4DSmMGFhQZ-Ags5oB1bHGK1PdD07xCvy5og_4AA>
X-ME-Proxy-Cause: dmFkZTEL1sxY5yaNUqGsHQHxuKGz7xUl/W+xvp0vQlVCNrgDaLGgZKiKH0Z/aI1jBcUELb
    iVA5tIGPS/3ROp2Vu0sJXMadxTOGStVh1l9MTbVf3hQKv1DrA7wdwVmoY4ewyCQomTKSD3
    gFXM0bn0/fnK6RTKIK8GrvCSBaaNOV/CaFqBghoWQpQNBmxO1MQwD7KEyNMhiGOrRYfp81
    ylwG6rEi2juJCoK4ODDq/y5NmM4jYrHTe45kvz2qA9DlvFFfW67ZKBwLVgEBtQK/Hzboh4
    dqsiGilYkGtKf7zOZSHZwSaOGhdY1xgUZjkOFSR8Lxqz/05mb1B92/jlKZ+ULEfXgQMsP6
    +UiFPIelcuLCO+1WgGNJbdca2mpP6M+7SbAouWZLWIqn7Wa1QHe16I9TNUi39u4AhtjbI0
    bdYgTxzM8KT8h9+NXSWrJl6tMSus3xbhsZTI4UuPiUr1uDOGJ1sigG8tgkZzAq3I9jVGaO
    /O0cPKdix1oVSgTSx8lYtOHJmgvuPaHjU8Dy2MMf8pw8phiDs13x7pRGDjXLgmEwcuJvz0
    9EqwK0kc06Ty4Y4Ac/S2CWj92nWSIaN+yfhF3PNmGCsbf0287dH9zwyuhQAQQADtDz7EpH
    w1bJgnjsVwKaU49krj9BThSLDz+2JzqJxA2t0xOHnJj6HA+9W/OAxjZt3kEw
X-ME-Proxy: <xmx:w0nbaqL49fgGbyThGLmyPYkEHTzAcUx_pNt4ku_iZ8C4WsIATdG0tg>
    <xmx:w0nbarHmOpn9tqo2B-o8IsZvxiMmAX3OByV-vSvXi-XqZ_vLZ813rw>
    <xmx:w0nbasoqG_BfheB-7hFEnFDU3oZm4VVIbspWzpV7iWvMRxFjwcV0cg>
    <xmx:w0nbasRmzx0beQGUnQrGvbPhe0fo3LJ8QPuaNBw7lhKpXvqSGqIxsA>
    <xmx:w0nbajDFHoGLBGO776AMZZZHWoT2kPzdvFCTmpbVj11u70Aw1pyJM_bY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f62bb73b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] odb: introduce object storage extension
Date: Fri, 23 Oct 2026 13:49:09 +0200
Message-Id: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ6CMBQE0KuYrq3pb6FQV97DuKD0I9UIpMUGQ
 7i7LRrjQpeTzLyZiUdn0ZP9ZiYOg/W272IQ2w2p26o7I7UmZsIZl8CYpDqjw9XT3miK04hdGlA
 hDUoltFaZIHE6OGzstLLH0yv7u75gPSYrNVrrx9491t8Aqfe+APX7IgBlFDJR5UoKXRTNIXZ29
 kaSH/iXwOGPwKNQ1g2AljmaqvwIy7I8AYOjk5cJAQAA
X-Change-ID: 20261006-b4-pks-odb-extension-36de693bb943
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series introduces the object storage extension. The extension
is of course similar in spirit and design to the ref storage extension:
it can be configured via "extensions.objectStorage", has the same syntax
with "<schema>[://<payload>]", and we have the same mechanisms to
configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").

For now, we only support the "files" object storage format, so not a lot
of stuff really changes. That being said, its optional payload allows
you to configure a different location for the ".git/objects" directory.
So if you specify "extensions.objectStorage=files://objs", objects would
be stored in ".git/objs" instead.

The series is built on top of c51408889c (The 6th batch, 2026-10-16)
with the following dependencies merged into it:

  - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08) merged into it.

  - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
    (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
    `read_alternates` callback, 2026-10-08).

Note that these two series conflict with one another. The conflict can
easily be resolved by just deleting the whole conflicting sections.

Changes in v3:
  - Split up object storage format URI into object storage format and
    payload. This matches how we do it for the ref storage format and
    thus brings us much closer to it, where we mostly use the exact same
    logic. For now though this restricts a couple cases, like for
    example submodule clones do not pass down payloads to the submodules
    anymore. This is intentional so that object and ref storage format
    have the same behaviour.
  - There's an en explicit `enum object_storage_format` now, matching
    how we handle this for the ref storage format.
  - Link to v2: https://patch.msgid.link/20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im

Changes in v2:
  - Ensure that `repo->object_storage_format` is always populated.
  - Link to v1: https://patch.msgid.link/20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      loose: drop unused `repo_write_loose_object_map()`
      setup: introduce object storage extension
      setup: allow overriding object storage format via environment
      builtin: expose the object storage format
      builtin/init: introduce handling of object storage format
      builtin/clone: introduce "--object-storage-format="
      builtin/submodule: propagate "--object-storage-format="

 Documentation/config/extensions.adoc       |  23 +++
 Documentation/config/init.adoc             |   5 +
 Documentation/git-clone.adoc               |  11 ++
 Documentation/git-init.adoc                |  10 +-
 Documentation/git-repo.adoc                |   6 +
 Documentation/git-rev-parse.adoc           |   5 +
 Documentation/git-submodule.adoc           |  10 +-
 Documentation/git.adoc                     |  10 ++
 Documentation/object-storage-format.adoc   |   6 +
 builtin/clone.c                            |  63 +++++++-
 builtin/init-db.c                          |   7 +-
 builtin/repo.c                             |  10 ++
 builtin/rev-parse.c                        |   9 ++
 builtin/submodule--helper.c                |  40 +++++
 environment.h                              |   1 +
 git-submodule.sh                           |  18 +++
 loose.c                                    |  46 ------
 loose.h                                    |   1 -
 odb.c                                      |  46 +++++-
 odb.h                                      |  13 ++
 odb/source-files.c                         |   7 +
 odb/source-files.h                         |   1 +
 odb/source.c                               |  14 +-
 odb/source.h                               |   5 +-
 refs.c                                     |   3 +-
 repository.c                               |  10 ++
 repository.h                               |  18 +++
 setup.c                                    | 133 ++++++++++++++++-
 setup.h                                    |   5 +
 t/meson.build                              |   1 +
 t/t0001-init.sh                            | 225 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh                       |   3 +
 t/t5601-clone.sh                           |  68 +++++++++
 t/t7427-submodule-object-storage-format.sh | 104 +++++++++++++
 t/unit-tests/u-odb-inmemory.c              |   1 +
 35 files changed, 872 insertions(+), 66 deletions(-)

Range-diff versus v2:

1:  04226610d7 = 1:  deda9d5530 loose: drop unused `repo_write_loose_object_map()`
2:  34afb43448 ! 2:  f6a73a7934 setup: introduce object storage extension
    @@ Documentation/object-storage-format.adoc (new)
     +provided. The payload is ignored when `GIT_OBJECT_DIRECTORY` is set.
     
      ## odb.c ##
    +@@
    + #include "trace2.h"
    + #include "write-or-die.h"
    + 
    ++static const char * const object_storage_name_by_format[] = {
    ++	[OBJECT_STORAGE_FORMAT_UNKNOWN] = "unknown",
    ++	[OBJECT_STORAGE_FORMAT_FILES] = "files",
    ++};
    ++
    ++enum object_storage_format object_storage_format_by_name(const char *name)
    ++{
    ++	for (size_t i = 0; i < ARRAY_SIZE(object_storage_name_by_format); i++)
    ++		if (!strcmp(object_storage_name_by_format[i], name))
    ++			return i;
    ++	return OBJECT_STORAGE_FORMAT_UNKNOWN;
    ++}
    ++
    ++enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload)
    ++{
    ++	enum object_storage_format format;
    ++	const char *schema_end;
    ++	char *name;
    ++
    ++	schema_end = strstr(uri, "://");
    ++	if (!schema_end) {
    ++		name = xstrdup(uri);
    ++		if (payload)
    ++			*payload = NULL;
    ++	} else {
    ++		name = xstrndup(uri, schema_end - uri);
    ++		if (payload)
    ++			*payload = *(schema_end + 3) ? xstrdup(schema_end + 3) : NULL;
    ++	}
    ++
    ++	format = object_storage_format_by_name(name);
    ++
    ++	free(name);
    ++	return format;
    ++}
    ++
    + int odb_mkstemp(struct object_database *odb,
    + 		struct strbuf *temp_filename, const char *pattern)
    + {
     @@ odb.c: struct object_database *odb_new(struct repository *repo,
      	o->repo = repo;
      	pthread_mutex_init(&o->replace_mutex, NULL);
      
     -	o->source = odb_source_new(o, flags);
    -+	o->source = odb_source_new(o, repo->object_storage_format, flags);
    ++	o->source = odb_source_new(o, repo->object_storage_format,
    ++				   repo->object_storage_payload, flags);
      	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
      
      	return o;
     
    + ## odb.h ##
    +@@
    + #include "oid-array.h"
    + #include "oidset.h"
    + #include "oidmap.h"
    ++#include "repository.h"
    + #include "string-list.h"
    + #include "thread-utils.h"
    + 
    +@@ odb.h: struct strvec;
    +  */
    + char *compute_alternate_path(const char *path, struct strbuf *err);
    + 
    ++/*
    ++ * Parse the given URI in the format "<schema>[://<payload>]" and return the
    ++ * object storage format identified by the schema. If `payload` is non-NULL it
    ++ * will be set to a newly allocated copy of the payload, or NULL if the URI has
    ++ * no or an empty payload. Returns `OBJECT_STORAGE_FORMAT_UNKNOWN` for unknown
    ++ * schemas.
    ++ */
    ++enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload);
    ++
    ++enum object_storage_format object_storage_format_by_name(const char *name);
    ++
    + /*
    +  * The object database encapsulates access to objects in a repository. It
    +  * manages the object source as well as auxiliary data structures required to
    +
      ## odb/source-files.c ##
     @@ odb/source-files.c: struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
      }
    @@ odb/source-files.h: struct odb_source_files {
      /*
     
      ## odb/source.c ##
    -@@
    - #include "git-compat-util.h"
    -+#include "gettext.h"
    - #include "object-file.h"
    - #include "odb/source-files.h"
    - #include "odb/source.h"
     @@ odb/source.c: const char *odb_source_type_to_name(enum odb_source_type type)
    - 	return name;
      }
      
    -+static enum odb_source_type odb_source_type_by_name(const char *name)
    -+{
    -+	if (!strcmp(name, "files"))
    -+		return ODB_SOURCE_FILES;
    -+	return ODB_SOURCE_UNKNOWN;
    -+}
    -+
    -+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload)
    -+{
    -+	enum odb_source_type type;
    -+	const char *schema_end;
    -+	char *name;
    -+
    -+	schema_end = strstr(uri, "://");
    -+	if (!schema_end) {
    -+		name = xstrdup(uri);
    -+		if (payload)
    -+			*payload = NULL;
    -+	} else {
    -+		name = xstrndup(uri, schema_end - uri);
    -+		if (payload)
    -+			*payload = *(schema_end + 3) ? xstrdup(schema_end + 3) : NULL;
    -+	}
    -+
    -+	type = odb_source_type_by_name(name);
    -+	free(name);
    -+	return type;
    -+}
    -+
      struct odb_source *odb_source_new(struct object_database *odb,
    -+				  const char *object_storage_format,
    ++				  enum object_storage_format format,
    ++				  const char *payload,
      				  enum odb_new_flags flags)
      {
     -	return &odb_source_files_new(odb, flags)->base;
     +	struct odb_source *source;
    -+	char *payload = NULL;
     +
    -+	switch (odb_source_type_by_uri(object_storage_format, &payload)) {
    -+	case ODB_SOURCE_FILES:
    ++	switch (format) {
    ++	case OBJECT_STORAGE_FORMAT_FILES:
     +		source = &odb_source_files_new(odb, payload, flags)->base;
     +		break;
     +	default:
    -+		die(_("unknown object storage format '%s'"), object_storage_format);
    ++		BUG("unknown object storage format");
     +	}
     +
    -+	free(payload);
     +	return source;
      }
      
      void odb_source_init(struct odb_source *source,
     
      ## odb/source.h ##
    -@@ odb/source.h: enum odb_source_type {
    -  */
    - const char *odb_source_type_to_name(enum odb_source_type type);
    - 
    -+/*
    -+ * Parse the given URI in the format "<schema>[://<payload>]" and return the
    -+ * source type identified by the schema. If `payload` is non-NULL it will be
    -+ * set to a newly allocated copy of the payload, or NULL if the URI has no or
    -+ * an empty payload. Returns `ODB_SOURCE_UNKNOWN` for unknown schemas.
    -+ */
    -+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload);
    -+
    - struct object_id;
    - struct odb_stream;
    - struct strbuf;
     @@ odb/source.h: struct odb_source {
      
      /*
    @@ odb/source.h: struct odb_source {
     + * format.
       */
      struct odb_source *odb_source_new(struct object_database *odb,
    -+				  const char *object_storage_format,
    ++				  enum object_storage_format format,
    ++				  const char *payload,
      				  enum odb_new_flags flags);
      
      /*
    @@ repository.c: void repo_set_ref_storage_format(struct repository *repo,
      }
      
     +void repo_set_object_storage_format(struct repository *repo,
    -+				    const char *uri)
    ++				    enum object_storage_format format,
    ++				    const char *payload)
     +{
    -+	free(repo->object_storage_format);
    -+	if (uri)
    -+		repo->object_storage_format = xstrdup(uri);
    -+	else
    -+		repo->object_storage_format = xstrdup("files");
    ++	repo->object_storage_format = format;
    ++	free(repo->object_storage_payload);
    ++	repo->object_storage_payload = xstrdup_or_null(payload);
     +}
     +
      /*
    @@ repository.c: void repo_clear(struct repository *repo)
      	free(repo->worktree);
      	free(repo->submodule_prefix);
      	free(repo->ref_storage_payload);
    -+	free(repo->object_storage_format);
    ++	free(repo->object_storage_payload);
      
      	odb_free(repo->objects);
      
     
      ## repository.h ##
    +@@ repository.h: enum ref_storage_format {
    + 	REF_STORAGE_FORMAT_REFTABLE,
    + };
    + 
    ++enum object_storage_format {
    ++	OBJECT_STORAGE_FORMAT_UNKNOWN,
    ++	OBJECT_STORAGE_FORMAT_FILES,
    ++};
    ++
    + #ifdef WITH_BREAKING_CHANGES /* Git 3.0 */
    + # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
    + #else
     @@ repository.h: struct repository {
      	 */
      	char *ref_storage_payload;
      
    ++	/* Repository's object storage format, as serialized on disk. */
    ++	enum object_storage_format object_storage_format;
    ++
     +	/*
    -+	 * The object storage URI in the format "<schema>[://<payload>]", as
    -+	 * configured via "extensions.objectStorage".
    ++	 * Object storage information as needed for the backend. This contains
    ++	 * only the payload from the object storage format URI without the
    ++	 * schema.
     +	 */
    -+	char *object_storage_format;
    ++	char *object_storage_payload;
     +
      	/* A unique-id for tracing purposes. */
      	int trace2_repo_id;
    @@ repository.h: void repo_set_compat_hash_algo(struct repository *repo, uint32_t c
      				 enum ref_storage_format format,
      				 const char *payload);
     +void repo_set_object_storage_format(struct repository *repo,
    -+				    const char *uri);
    ++				    enum object_storage_format format,
    ++				    const char *payload);
      void initialize_repository(struct repository *repo);
      RESULT_MUST_BE_USED
      int repo_init(struct repository *r, const char *gitdir, const char *worktree);
     
      ## setup.c ##
    -@@
    - #include "hex.h"
    - #include "object-file.h"
    - #include "object-name.h"
    -+#include "odb/source.h"
    - #include "refs.h"
    - #include "repository.h"
    - #include "config.h"
     @@ setup.c: static enum extension_result handle_extension(const char *var,
    + 			return error(_("invalid value for '%s': '%s'"),
      				     "extensions.refstorage", value);
      		data->ref_storage_format = format;
    - 		return EXTENSION_OK;
    ++		return EXTENSION_OK;
     +	} else if (!strcmp(ext, "objectstorage")) {
    ++		enum object_storage_format format;
    ++
     +		if (!value)
     +			return config_error_nonbool(var);
    -+		if (odb_source_type_by_uri(value, NULL) == ODB_SOURCE_UNKNOWN)
    ++
    ++		FREE_AND_NULL(data->object_storage_payload);
    ++		format = object_storage_format_by_uri(value, &data->object_storage_payload);
    ++		if (format == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			return error(_("invalid value for '%s': '%s'"),
     +				     "extensions.objectstorage", value);
    -+		free(data->object_storage);
    -+		data->object_storage = xstrdup(value);
    -+		return EXTENSION_OK;
    ++		data->object_storage_format = format;
    ++
    + 		return EXTENSION_OK;
      	} else if (!strcmp(ext, "relativeworktrees")) {
      		data->relative_worktrees = git_config_bool(var, value);
    - 		return EXTENSION_OK;
     @@ setup.c: static enum extension_result handle_extension(const char *var,
      		data->submodule_path_cfg = git_config_bool(var, value);
      		return EXTENSION_OK;
    @@ setup.c: void clear_repository_format(struct repository_format *format)
      	free(format->work_tree);
      	free(format->partial_clone);
      	free(format->ref_storage_payload);
    -+	free(format->object_storage);
    ++	free(format->object_storage_payload);
      	init_repository_format(format);
      }
      
    @@ setup.c: int apply_repository_format(struct repository *repo,
      	repo_set_ref_storage_format(repo,
      				    format->ref_storage_format,
      				    format->ref_storage_payload);
    -+	repo_set_object_storage_format(repo, format->object_storage);
    ++	repo_set_object_storage_format(repo,
    ++				       format->object_storage_format,
    ++				       format->object_storage_payload);
      	repo->repository_format_worktree_config =
      		format->worktree_config;
      	repo->repository_format_submodule_path_cfg =
     
      ## setup.h ##
     @@ setup.h: struct repository_format {
    + 	int compat_hash_algo;
    + 	enum ref_storage_format ref_storage_format;
      	char *ref_storage_payload;
    ++	enum object_storage_format object_storage_format;
    ++	char *object_storage_payload;
      	int sparse_index;
      	char *work_tree;
    -+	char *object_storage;
      	struct string_list unknown_extensions;
    - 	struct string_list v1_only_extensions;
    - };
    +@@ setup.h: struct repository_format {
    + 	.is_bare = -1, \
    + 	.hash_algo = GIT_HASH_DEFAULT, \
    + 	.ref_storage_format = REF_STORAGE_FORMAT_FILES, \
    ++	.object_storage_format = OBJECT_STORAGE_FORMAT_FILES, \
    + 	.unknown_extensions = STRING_LIST_INIT_DUP, \
    + 	.v1_only_extensions = STRING_LIST_INIT_DUP, \
    + }
     
      ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: test_expect_success 'init with --ref-storage-format=garbage' '
    @@ t/unit-tests/u-odb-inmemory.c
      
      static struct repository repo = {
      	.hash_algo = &hash_algos[GIT_HASH_SHA1],
    -+	.object_storage_format = (char *) "files",
    ++	.object_storage_format = OBJECT_STORAGE_FORMAT_FILES,
      };
      static struct object_database *odb;
      
3:  05c6ce2866 ! 3:  54090c50c3 setup: allow overriding object storage format via environment
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
     +			 */
     +			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
     +			if (object_storage_uri) {
    -+				if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
    ++				FREE_AND_NULL(discovery.format.object_storage_payload);
    ++				discovery.format.object_storage_format =
    ++					object_storage_format_by_uri(object_storage_uri,
    ++								     &discovery.format.object_storage_payload);
    ++				if (discovery.format.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +					die(_("unknown object storage format: '%s'"), object_storage_uri);
    -+				free(discovery.format.object_storage);
    -+				discovery.format.object_storage = xstrdup(object_storage_uri);
     +			}
     +
      			if (apply_repository_format(repo, &discovery.format,
4:  487e927a5c ! 4:  f6b57aa2fe builtin: expose the object storage format
    @@ Documentation/git-rev-parse.adoc: The following options are unaffected by `--pat
      ~~~~~~~~~~~~~
     
      ## builtin/repo.c ##
    -@@
    - #include "hash.h"
    - #include "hex.h"
    - #include "odb.h"
    -+#include "odb/source.h"
    - #include "parse-options.h"
    - #include "path.h"
    - #include "path-walk.h"
     @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
      	return 0;
      }
      
     +static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
     +{
    -+	strbuf_addstr(buf, repo->object_storage_format);
    ++	strbuf_addstr(buf,
    ++		      object_storage_format_to_name(repo->object_storage_format));
    ++	if (repo->object_storage_payload)
    ++		strbuf_addf(buf, "://%s", repo->object_storage_payload);
     +	return 0;
     +}
     +
    @@ builtin/rev-parse.c
      #include "gettext.h"
      #include "hash.h"
      #include "hex.h"
    -+#include "odb/source.h"
    ++#include "odb.h"
      #include "refs.h"
      #include "quote.h"
      #include "object-name.h"
    @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      				continue;
      			}
     +			if (!strcmp(arg, "--show-object-storage-format")) {
    -+				puts(the_repository->object_storage_format);
    ++				const char *format = object_storage_format_to_name(the_repository->object_storage_format);
    ++				if (the_repository->object_storage_payload)
    ++					printf("%s://%s\n", format, the_repository->object_storage_payload);
    ++				else
    ++					puts(format);
     +				continue;
     +			}
      			if (!strcmp(arg, "--end-of-options")) {
      				seen_end_of_options = 1;
      				if (filter & (DO_FLAGS | DO_REVS))
     
    + ## odb.c ##
    +@@ odb.c: enum object_storage_format object_storage_format_by_name(const char *name)
    + 	return OBJECT_STORAGE_FORMAT_UNKNOWN;
    + }
    + 
    ++const char *object_storage_format_to_name(enum object_storage_format format)
    ++{
    ++	if (format < 0 || format >= ARRAY_SIZE(object_storage_name_by_format))
    ++		format = OBJECT_STORAGE_FORMAT_UNKNOWN;
    ++	return object_storage_name_by_format[format];
    ++}
    ++
    + enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload)
    + {
    + 	enum object_storage_format format;
    +
    + ## odb.h ##
    +@@ odb.h: char *compute_alternate_path(const char *path, struct strbuf *err);
    + enum object_storage_format object_storage_format_by_uri(const char *uri, char **payload);
    + 
    + enum object_storage_format object_storage_format_by_name(const char *name);
    ++const char *object_storage_format_to_name(enum object_storage_format format);
    + 
    + /*
    +  * The object database encapsulates access to objects in a repository. It
    +
      ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files bac
      	git -C objstorage config set core.repositoryformatversion 1 &&
5:  096441cb3f ! 5:  6f1ac304eb builtin/init: introduce handling of object storage format
    @@ builtin/clone.c: int cmd_clone(int argc,
      
      	if (real_git_dir) {
      		free((char *)git_dir);
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 	 * This is sufficient for Git commands to discover the Git directory.
    + 	 */
    + 	initialize_repository_version(the_repository, GIT_HASH_UNKNOWN,
    +-				      the_repository->ref_storage_format, 1);
    ++				      the_repository->ref_storage_format,
    ++				      the_repository->object_storage_format, 1);
    + 
    + 	refs_create_refdir_stubs(the_repository, git_dir, NULL);
    + 
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 	 * ours to the same thing.
    + 	 */
    + 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
    +-	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
    ++	initialize_repository_version(the_repository, hash_algo,
    ++				      the_repository->ref_storage_format,
    ++				      the_repository->object_storage_format, 1);
    + 	repo_set_hash_algo(the_repository, hash_algo);
    + 	create_reference_database(the_repository, NULL, 1);
    + 	startup_info->have_repository = 1;
     
      ## builtin/init-db.c ##
     @@ builtin/init-db.c: static int shared_callback(const struct option *opt, const char *arg, int unset)
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      	create_object_database(the_repository, NULL);
      
     
    + ## refs.c ##
    +@@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    + 	 * repository format so that clients will use the new ref store.
    + 	 * We also need to swap out the repository's main ref store.
    + 	 */
    +-	initialize_repository_version(repo, hash_algo_by_ptr(repo->hash_algo), format, 1);
    ++	initialize_repository_version(repo, hash_algo_by_ptr(repo->hash_algo), format,
    ++				      repo->object_storage_format, 1);
    + 
    + 	/*
    + 	 * Unset the old ref store and release it. `get_main_ref_store()` will
    +
      ## setup.c ##
    +@@ setup.c: static int needs_work_tree_config(const char *git_dir, const char *work_tree)
    + void initialize_repository_version(struct repository *repo,
    + 				   int hash_algo,
    + 				   enum ref_storage_format ref_storage_format,
    ++				   enum object_storage_format object_storage_format,
    + 				   int reinit)
    + {
    + 	struct strbuf repo_version = STRBUF_INIT;
     @@ setup.c: void initialize_repository_version(struct repository *repo,
      	 */
      	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
      	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
     -	    repo->ref_storage_payload)
     +	    repo->ref_storage_payload ||
    -+	    strcmp(repo->object_storage_format, "files"))
    ++	    object_storage_format != OBJECT_STORAGE_FORMAT_FILES ||
    ++	    repo->object_storage_payload)
      		target_version = GIT_REPO_VERSION_READ;
      
      	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
    @@ setup.c: void initialize_repository_version(struct repository *repo,
      		repo_config_set_gently(repo, "extensions.refstorage", NULL);
      	}
      
    -+	if (strcmp(repo->object_storage_format, "files"))
    ++	if (repo->object_storage_payload) {
    ++		struct strbuf uri = STRBUF_INIT;
    ++
    ++		strbuf_addf(&uri, "%s://%s",
    ++			    object_storage_format_to_name(object_storage_format),
    ++			    repo->object_storage_payload);
    ++		repo_config_set(repo, "extensions.objectstorage", uri.buf);
    ++
    ++		strbuf_release(&uri);
    ++	} else if (object_storage_format != OBJECT_STORAGE_FORMAT_FILES) {
     +		repo_config_set(repo, "extensions.objectstorage",
    -+				repo->object_storage_format);
    -+	else if (reinit)
    ++				object_storage_format_to_name(object_storage_format));
    ++	} else if (reinit) {
     +		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
    ++	}
     +
      	if (reinit) {
      		struct strbuf config = STRBUF_INIT;
      		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
    +@@ setup.c: static int create_default_files(struct repository *repo,
    + 		adjust_shared_perm(repo, repo_get_git_dir(repo));
    + 	}
    + 
    +-	initialize_repository_version(repo, fmt->hash_algo, fmt->ref_storage_format, reinit);
    ++	initialize_repository_version(repo, fmt->hash_algo, fmt->ref_storage_format,
    ++				      fmt->object_storage_format, reinit);
    + 
    + 	/* Check filemode trustability */
    + 	repo_git_path_replace(repo, &path, "config");
     @@ setup.c: static void separate_git_dir(struct repository *repo,
      struct default_format_config {
      	int hash;
      	enum ref_storage_format ref_storage_format;
    -+	char *object_storage_format;
    ++	enum object_storage_format object_storage_format;
      };
      
      static int read_default_format_config(const char *key, const char *value,
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
     +		ret = git_config_string(&str, key, value);
     +		if (ret)
     +			goto out;
    -+		if (odb_source_type_by_uri(str, NULL) == ODB_SOURCE_UNKNOWN) {
    ++		cfg->object_storage_format = object_storage_format_by_name(str);
    ++		if (cfg->object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			warning(_("unknown object storage format '%s'"), str);
    -+			goto out;
    -+		}
    -+		free(cfg->object_storage_format);
    -+		cfg->object_storage_format = str;
    -+		str = NULL;
     +		goto out;
     +	}
     +
    @@ setup.c: static int read_default_format_config(const char *key, const char *valu
      	struct default_format_config cfg = {
      		.hash = GIT_HASH_UNKNOWN,
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    + 		.ignore_repo = 1,
    + 		.ignore_worktree = 1,
      	};
    ++	enum object_storage_format object_storage_format;
      	enum ref_storage_format ref_storage_format;
    ++	char *object_storage_payload = NULL;
      	char *ref_storage_payload = NULL;
    -+	char *object_storage = NULL;
      	const char *env;
      
    - 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
      		ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
      	}
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
     +	 *   6. The "files" format.
     +	 */
     +	if (object_storage_uri) {
    -+		if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
    -+			die(_("unknown object storage format '%s'"), object_storage_uri);
    -+		object_storage = xstrdup(object_storage_uri);
    ++		object_storage_format = object_storage_format_by_uri(object_storage_uri,
    ++								     &object_storage_payload);
    ++		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown object storage format specified via command line: '%s'"),
    ++			    object_storage_uri);
     +	} else if ((env = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT))) {
    -+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
    ++		object_storage_format = object_storage_format_by_uri(env, &object_storage_payload);
    ++		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			die(_("unknown object storage format specified via %s: '%s'"),
     +			    GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT, env);
    -+		object_storage = xstrdup(env);
     +	} else if (repo_fmt->version >= 0) {
    -+		object_storage = xstrdup_or_null(repo_fmt->object_storage);
    ++		object_storage_format = repo_fmt->object_storage_format;
    ++		object_storage_payload = xstrdup_or_null(repo_fmt->object_storage_payload);
     +	} else if ((env = getenv("GIT_DEFAULT_OBJECT_STORAGE_FORMAT"))) {
    -+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
    ++		object_storage_format = object_storage_format_by_name(env);
    ++		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			die(_("unknown object storage format specified via %s: '%s'"),
     +			    "GIT_DEFAULT_OBJECT_STORAGE_FORMAT", env);
    -+		object_storage = xstrdup(env);
    ++	} else if (cfg.object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN) {
    ++		object_storage_format = cfg.object_storage_format;
     +	} else {
    -+		object_storage = xstrdup_or_null(cfg.object_storage_format);
    -+	}
    -+
    -+	/*
    -+	 * The "files" format without a payload is the default and thus doesn't
    -+	 * need to be recorded as an extension.
    -+	 */
    -+	if (object_storage) {
    -+		char *payload = NULL;
    -+		if (odb_source_type_by_uri(object_storage, &payload) == ODB_SOURCE_FILES && !payload)
    -+			FREE_AND_NULL(object_storage);
    -+		free(payload);
    ++		object_storage_format = OBJECT_STORAGE_FORMAT_FILES;
     +	}
     +
      	/*
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
      		    strcmp(ref_storage_payload ? ref_storage_payload : "",
      			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
      			die(_("attempt to reinitialize repository with different reference storage payload"));
    -+		if (strcmp(object_storage ? object_storage : "",
    -+			   repo_fmt->object_storage ? repo_fmt->object_storage : ""))
    ++		if (object_storage_format != repo_fmt->object_storage_format)
     +			die(_("attempt to reinitialize repository with different object storage format"));
    ++		if ((object_storage_payload || repo_fmt->object_storage_payload) &&
    ++		    strcmp(object_storage_payload ? object_storage_payload : "",
    ++			   repo_fmt->object_storage_payload ? repo_fmt->object_storage_payload : ""))
    ++			die(_("attempt to reinitialize repository with different object storage payload"));
      	}
      
      	free(repo_fmt->ref_storage_payload);
      	repo_fmt->ref_storage_format = ref_storage_format;
      	repo_fmt->ref_storage_payload = ref_storage_payload;
     +
    -+	free(repo_fmt->object_storage);
    -+	repo_fmt->object_storage = object_storage;
    -+	free(cfg.object_storage_format);
    ++	free(repo_fmt->object_storage_payload);
    ++	repo_fmt->object_storage_format = object_storage_format;
    ++	repo_fmt->object_storage_payload = object_storage_payload;
      }
      
      void create_repository(struct repository *repo,
    @@ setup.h: void create_repository(struct repository *repo,
      		       int init_shared_repository,
      		       int *reinit_ok);
      
    + void initialize_repository_version(struct repository *repo,
    + 				   int hash_algo,
    + 				   enum ref_storage_format ref_storage_format,
    ++				   enum object_storage_format object_storage_format,
    + 				   int reinit);
    + 
    + /*
     
      ## t/t0001-init.sh ##
     @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides ext
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FOR
     +test_expect_success 'init with --object-storage-format=garbage' '
     +	test_when_finished "rm -rf objformat" &&
     +	cat >expect <<-EOF &&
    -+	fatal: unknown object storage format ${SQ}garbage${SQ}
    ++	fatal: unknown object storage format specified via command line: ${SQ}garbage${SQ}
     +	EOF
     +	test_must_fail git init --object-storage-format=garbage objformat 2>err &&
     +	test_cmp expect err
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FOR
     +	test_cmp expect err
     +'
     +
    -+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs' '
    -+	test_when_finished "rm -rf objformat" &&
    -+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs git init objformat &&
    -+	echo files://objs >expect &&
    -+	git -C objformat rev-parse --show-object-storage-format >actual &&
    -+	test_cmp expect actual
    -+'
    -+
     +test_expect_success 'init with GIT_OBJECT_STORAGE_FORMAT=garbage' '
     +	test_when_finished "rm -rf objformat" &&
     +	cat >expect <<-EOF &&
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FOR
     +	test_when_finished "rm -rf objformat" &&
     +	git init --object-storage-format=files objformat &&
     +	cat >expect <<-EOF &&
    -+	fatal: attempt to reinitialize repository with different object storage format
    ++	fatal: attempt to reinitialize repository with different object storage payload
     +	EOF
     +	test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://objs git init objformat 2>err &&
     +	test_cmp expect err
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FOR
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success DEFAULT_REPO_FORMAT 're-init with default object storage format drops extension' '
    ++	test_when_finished "rm -rf objformat" &&
    ++
    ++	git init objformat &&
    ++	git -C objformat config set core.repositoryformatversion 1 &&
    ++	git -C objformat config set extensions.objectstorage files &&
    ++
    ++	git init --object-storage-format=files objformat &&
    ++	echo 0 >expect &&
    ++	git -C objformat config get core.repositoryformatversion >actual &&
    ++	test_cmp expect actual &&
    ++	test_must_fail git -C objformat config get extensions.objectstorage
    ++'
    ++
     +test_expect_success 'init warns about invalid init.defaultObjectStorageFormat' '
     +	test_when_finished "rm -rf objformat" &&
     +	test_config_global init.defaultObjectStorageFormat garbage &&
    @@ t/t0001-init.sh: test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FOR
     +
     +test_expect_success 'init with init.defaultObjectStorageFormat' '
     +	test_when_finished "rm -rf objformat" &&
    -+	test_config_global init.defaultObjectStorageFormat files://objs &&
    ++	test_config_global init.defaultObjectStorageFormat files &&
     +	git init objformat &&
    -+	echo files://objs >expect &&
    ++	echo files >expect &&
     +	git -C objformat rev-parse --show-object-storage-format >actual &&
    -+	test_cmp expect actual &&
    -+	test_commit -C objformat A &&
    -+	test_path_is_dir objformat/.git/objs/pack
    ++	test_cmp expect actual
     +'
     +
      test_expect_success MINGW 'core.hidedotfiles = false' '
6:  77586494fa ! 6:  35b38d75e8 builtin/clone: introduce "--object-storage-format="
    @@ Documentation/git-clone.adoc: include::ref-storage-format.adoc[]
      	The number of submodules fetched at the same time.
     
      ## builtin/clone.c ##
    -@@
    - #include "refspec.h"
    - #include "object-file.h"
    - #include "odb.h"
    -+#include "odb/source.h"
    - #include "tree.h"
    - #include "tree-walk.h"
    - #include "unpack-trees.h"
     @@ builtin/clone.c: static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
      	dir_iterator_free(iter);
      }
    @@ builtin/clone.c: static void copy_or_link_directory(struct strbuf *src, struct s
     +{
     +	struct repository_format format = REPOSITORY_FORMAT_INIT;
     +	struct strbuf config = STRBUF_INIT;
    -+	bool uses_default_format = true;
    -+	char *payload = NULL;
    ++	bool is_default;
     +
     +	get_common_dir(&config, repo_path);
     +	strbuf_addstr(&config, "/config");
     +	read_repository_format(&format, config.buf);
     +
    -+	if (format.version >= 1 &&
    -+	    format.object_storage &&
    -+	    (odb_source_type_by_uri(format.object_storage, &payload) != ODB_SOURCE_FILES || payload))
    -+		uses_default_format = false;
    ++	is_default = format.object_storage_format == OBJECT_STORAGE_FORMAT_FILES &&
    ++		!format.object_storage_payload;
     +
     +	clear_repository_format(&format);
     +	strbuf_release(&config);
    -+	free(payload);
    -+	return uses_default_format;
    ++	return is_default;
     +}
     +
      static void clone_local(const char *src_repo, const char *dest_repo)
    @@ builtin/clone.c: int cmd_clone(int argc,
      	}
      
     +	if (object_storage_format_uri &&
    -+	    odb_source_type_by_uri(object_storage_format_uri, NULL) == ODB_SOURCE_UNKNOWN)
    ++	    object_storage_format_by_uri(object_storage_format_uri, NULL) == OBJECT_STORAGE_FORMAT_UNKNOWN)
     +		die(_("unknown object storage format '%s'"), object_storage_format_uri);
     +
      	if (option_mirror) {
7:  9071a404ef ! 7:  3b5c33b7ad builtin/submodule: propagate "--object-storage-format="
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      		    int filter_submodules,
     -		    enum ref_storage_format ref_storage_format)
     +		    enum ref_storage_format ref_storage_format,
    -+		    const char *object_storage_format_uri)
    ++		    enum object_storage_format object_storage_format)
      {
      	struct object_id oid;
      	char *head;
    @@ builtin/clone.c: static int checkout(int submodule_progress,
      			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
      				     ref_storage_format_to_name(ref_storage_format));
      
    -+		if (object_storage_format_uri)
    ++		if (object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			strvec_pushf(&cmd.args, "--object-storage-format=%s",
    -+				     object_storage_format_uri);
    ++				     object_storage_format_to_name(object_storage_format));
     +
      		if (filter_submodules && filter_options->choice)
      			strvec_pushf(&cmd.args, "--filter=%s",
      				     expand_list_objects_filter_spec(filter_options));
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 	int submodule_progress;
    + 	int filter_submodules = 0;
    + 	int hash_algo;
    ++	enum object_storage_format object_storage_format = OBJECT_STORAGE_FORMAT_UNKNOWN;
    + 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
    + 	const int do_not_override_repo_unix_permissions = -1;
    + 	int option_reject_shallow = -1; /* unspecified */
    +@@ builtin/clone.c: int cmd_clone(int argc,
    + 			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
    + 	}
    + 
    +-	if (object_storage_format_uri &&
    +-	    object_storage_format_by_uri(object_storage_format_uri, NULL) == OBJECT_STORAGE_FORMAT_UNKNOWN)
    +-		die(_("unknown object storage format '%s'"), object_storage_format_uri);
    ++	if (object_storage_format_uri) {
    ++		object_storage_format = object_storage_format_by_uri(object_storage_format_uri, NULL);
    ++		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown object storage format '%s'"), object_storage_format_uri);
    ++	}
    + 
    + 	if (option_mirror) {
    + 		option_bare = 1;
     @@ builtin/clone.c: int cmd_clone(int argc,
      	err = checkout(submodule_progress,
      		       &filter_options,
      		       filter_submodules,
     -		       ref_storage_format);
     +		       ref_storage_format,
    -+		       object_storage_format_uri);
    ++		       object_storage_format);
      
      	list_objects_filter_release(&filter_options);
      
    @@ builtin/submodule--helper.c: struct module_clone_data {
      	int depth;
      	struct list_objects_filter_options *filter_options;
      	enum ref_storage_format ref_storage_format;
    -+	const char *object_storage_format;
    ++	enum object_storage_format object_storage_format;
      	unsigned int quiet: 1;
      	unsigned int progress: 1;
      	unsigned int dissociate: 1;
    +@@ builtin/submodule--helper.c: struct module_clone_data {
    + #define MODULE_CLONE_DATA_INIT { \
    + 	.single_branch = -1, \
    + 	.ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN, \
    ++	.object_storage_format = OBJECT_STORAGE_FORMAT_UNKNOWN, \
    + }
    + 
    + struct submodule_alternate_setup {
     @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
      		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
      			strvec_pushf(&cp.args, "--ref-storage-format=%s",
      				     ref_storage_format_to_name(clone_data->ref_storage_format));
    -+		if (clone_data->object_storage_format)
    ++		if (clone_data->object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
     +			strvec_pushf(&cp.args, "--object-storage-format=%s",
    -+				     clone_data->object_storage_format);
    ++				     object_storage_format_to_name(clone_data->object_storage_format));
      		if (clone_data->dissociate)
      			strvec_push(&cp.args, "--dissociate");
      		if (sm_gitdir && *sm_gitdir)
    +@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix,
    + 	struct string_list reference = STRING_LIST_INIT_NODUP;
    + 	struct list_objects_filter_options filter_options =
    + 		LIST_OBJECTS_FILTER_INIT;
    ++	const char *object_storage_format = NULL;
    + 	const char *ref_storage_format = NULL;
    + 
    + 	struct option module_clone_options[] = {
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix,
      		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
      			   N_("specify the reference storage format to use")),
      		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
    -+		OPT_STRING(0, "object-storage-format", &clone_data.object_storage_format, N_("format"),
    ++		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
     +			   N_("specify the object storage format to use")),
      		OPT_BOOL(0, "dissociate", &dissociate,
      			   N_("use --reference only while cloning")),
    @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
      		if (clone_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
      			die(_("unknown ref storage format '%s'"), ref_storage_format);
      	}
    -+	if (clone_data.object_storage_format &&
    -+	    odb_source_type_by_uri(clone_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
    -+		die(_("unknown object storage format '%s'"), clone_data.object_storage_format);
    ++
    ++	if (object_storage_format) {
    ++		clone_data.object_storage_format = object_storage_format_by_name(object_storage_format);
    ++		if (clone_data.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown object storage format '%s'"), object_storage_format);
    ++	}
    ++
      	clone_data.dissociate = !!dissociate;
      	clone_data.quiet = !!quiet;
      	clone_data.progress = !!progress;
     @@ builtin/submodule--helper.c: struct update_data {
    + 	struct submodule_update_strategy update_strategy;
      	struct list_objects_filter_options *filter_options;
      	struct module_list list;
    ++	enum object_storage_format object_storage_format;
      	enum ref_storage_format ref_storage_format;
    -+	const char *object_storage_format;
      	int depth;
      	int max_jobs;
    - 	int single_branch;
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
      	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
      		strvec_pushf(&child->args, "--ref-storage-format=%s",
      			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
    -+	if (suc->update_data->object_storage_format)
    ++	if (suc->update_data->object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
     +		strvec_pushf(&child->args, "--object-storage-format=%s",
    -+			     suc->update_data->object_storage_format);
    ++			     object_storage_format_to_name(suc->update_data->object_storage_format));
      	strvec_pushl(&child->args, "--path", sub->path, NULL);
      	strvec_pushl(&child->args, "--name", sub->name, NULL);
      	strvec_pushl(&child->args, "--url", url, NULL);
    @@ builtin/submodule--helper.c: static void update_data_to_args(const struct update
      			     ref_storage_format_to_name(update_data->ref_storage_format));
     +	if (update_data->object_storage_format)
     +		strvec_pushf(args, "--object-storage-format=%s",
    -+			     update_data->object_storage_format);
    ++			     object_storage_format_to_name(update_data->object_storage_format));
      	if (update_data->filter_options && update_data->filter_options->choice)
      		strvec_pushf(args, "--filter=%s",
      				expand_list_objects_filter_spec(
    +@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix,
    + 	struct update_data opt = UPDATE_DATA_INIT;
    + 	struct list_objects_filter_options filter_options =
    + 		LIST_OBJECTS_FILTER_INIT;
    ++	const char *object_storage_format = NULL;
    + 	const char *ref_storage_format = NULL;
    + 	int ret;
    + 	struct option module_update_options[] = {
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix,
      		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
      			   N_("specify the reference storage format to use")),
      		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
    -+		OPT_STRING(0, "object-storage-format", &opt.object_storage_format, N_("format"),
    ++		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
     +			   N_("specify the object storage format to use")),
      		OPT_BOOL(0, "dissociate", &opt.dissociate,
      			   N_("use --reference only while cloning")),
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      		if (opt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
      			die(_("unknown ref storage format '%s'"), ref_storage_format);
      	}
    -+	if (opt.object_storage_format &&
    -+	    odb_source_type_by_uri(opt.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
    -+		die(_("unknown object storage format '%s'"), opt.object_storage_format);
    ++	if (object_storage_format) {
    ++		opt.object_storage_format = object_storage_format_by_name(object_storage_format);
    ++		if (opt.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown object storage format '%s'"), object_storage_format);
    ++	}
      
      	opt.filter_options = &filter_options;
      	opt.prefix = prefix;
     @@ builtin/submodule--helper.c: struct add_data {
    + 	const char *sm_name;
      	const char *repo;
      	const char *realrepo;
    ++	enum object_storage_format object_storage_format;
      	enum ref_storage_format ref_storage_format;
    -+	const char *object_storage_format;
      	int depth;
      	unsigned int force: 1;
    - 	unsigned int quiet: 1;
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
      			string_list_append(&reference, p)->util = p;
      		}
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
      		clone_data.dissociate = add_data->dissociate;
      		if (add_data->depth >= 0)
      			clone_data.depth = add_data->depth;
    +@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix,
    + {
    + 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
    + 	struct add_data add_data = ADD_DATA_INIT;
    ++	const char *object_storage_format = NULL;
    + 	const char *ref_storage_format = NULL;
    + 	char *to_free = NULL;
    + 	const struct submodule *existing;
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix,
      		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
      			   N_("specify the reference storage format to use")),
      		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
    -+		OPT_STRING(0, "object-storage-format", &add_data.object_storage_format, N_("format"),
    ++		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
     +			   N_("specify the object storage format to use")),
      		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
      		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
      		if (add_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
      			die(_("unknown ref storage format '%s'"), ref_storage_format);
      	}
    -+	if (add_data.object_storage_format &&
    -+	    odb_source_type_by_uri(add_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
    -+		die(_("unknown object storage format '%s'"), add_data.object_storage_format);
    ++	if (object_storage_format) {
    ++		add_data.object_storage_format = object_storage_format_by_name(object_storage_format);
    ++		if (add_data.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown object storage format '%s'"), object_storage_format);
    ++	}
      
      	add_data.repo = argv[0];
      	if (argc == 1)
    @@ t/t7427-submodule-object-storage-format.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'add submodules with different object storage format' '
    ++test_expect_success 'add submodules with explicit files storage format' '
     +	test_when_finished "rm -rf submodule upstream" &&
     +
     +	git init submodule &&
     +	test_commit -C submodule submodule-initial &&
     +	git init upstream &&
     +	test_object_storage_format upstream files &&
    -+	git -C upstream submodule add --object-storage-format=files://objs "file://$(pwd)/submodule" &&
    -+	test_object_storage_format upstream/submodule files://objs &&
    -+	test_path_is_dir upstream/.git/modules/submodule/objs/pack
    ++	git -C upstream submodule add --object-storage-format=files "file://$(pwd)/submodule" &&
    ++	test_object_storage_format upstream/submodule files
     +'
     +
     +test_expect_success 'add submodules with garbage object storage format' '
    @@ t/t7427-submodule-object-storage-format.sh (new)
     +	test_cmp expect err
     +'
     +
    ++test_expect_success 'add submodules with object storage payload is rejected' '
    ++	test_when_finished "rm -rf submodule upstream" &&
    ++
    ++	git init submodule &&
    ++	test_commit -C submodule submodule-initial &&
    ++	git init upstream &&
    ++	cat >expect <<-EOF &&
    ++	fatal: unknown object storage format ${SQ}files://objs${SQ}
    ++	EOF
    ++	test_must_fail git -C upstream submodule add --object-storage-format=files://objs "file://$(pwd)/submodule" 2>err &&
    ++	test_cmp expect err
    ++'
    ++
     +test_expect_success 'recursive clone propagates object storage format' '
     +	test_when_finished "rm -rf submodule upstream downstream" &&
     +
    @@ t/t7427-submodule-object-storage-format.sh (new)
     +	git clone --object-storage-format=files://objs --recurse-submodules \
     +		upstream downstream &&
     +	test_object_storage_format downstream files://objs &&
    -+	test_object_storage_format downstream/submodule files://objs &&
    ++	test_object_storage_format downstream/submodule files &&
     +	test_path_is_dir downstream/.git/objs/pack &&
    -+	test_path_is_dir downstream/.git/modules/submodule/objs/pack
    ++	test_path_is_dir downstream/.git/modules/submodule/objects/pack
     +'
     +
    -+test_expect_success 'clone submodules with different object storage format' '
    ++test_expect_success 'clone submodules with explicit object storage format' '
     +	test_when_finished "rm -rf submodule upstream downstream" &&
     +
     +	git init submodule &&
    @@ t/t7427-submodule-object-storage-format.sh (new)
     +	git -C upstream commit -m "upstream submodule" &&
     +
     +	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
    -+	git -C downstream submodule update --init --object-storage-format=files://objs &&
     +	test_object_storage_format downstream files &&
    -+	test_object_storage_format downstream/submodule files://objs
    ++	git -C downstream submodule update --init --object-storage-format=files &&
    ++	test_object_storage_format downstream/submodule files &&
    ++	test_path_is_dir downstream/.git/modules/submodule/objects/pack
     +'
     +
     +test_done

---
base-commit: 0d31382da9336683214372ba328fe9ecbc8bcb9a
change-id: 20261006-b4-pks-odb-extension-36de693bb943

