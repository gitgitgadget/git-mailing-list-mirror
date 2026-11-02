Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618439;
	b=Q4L6QNqJ7pauYN9U6ml32kHiN2dV/vEhMCgTXhExDbU/fwbL7YX0QLsqZ16TeoCy06Ck
	 sAdd/V6gADPuk3owSOPL0GZ+9w3fGvJIO7MbJLKG0I/Fvt1wtyRnUIOpf+t51ELhwCXlu
	 xgPOCwwCLYyOSwi30GsUyKJ8d0wmFnSh6wDbfjm5RWv6eSfUDab6kBQZyTL+3ijZ3FY52
	 XKwV9diA+/4zgR+N7kJWTMLvP7qyAveDXx1gTV/oBaXZxbxp7DWHve4n5QlGxzRpqvGd1
	 tXFqFhpZsceC9xaHRcx+biQlRm/qD7VyRbG91aRGRzOSTlBQLNsOSouytsr7iyO1RVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618439;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=u+R/q8fIgW0wQ0dGsFtuObvJ2SeWRESCTfmoz9pceEY=;
	b=BjOJFHEBR224GdywJelh/K2yX7PxBwzDJi0heUyESQmOBuB7lbdE4JwSpZjubyjULCK3
	 H4PPDZuocOGfBGy8RusgxzLgmkHTosjI6oBH6ImLqS2pZFAvEMMZTxkmIuzBz0TCUDnN3
	 XlajV61k2i2F2VPoLdVEUBTK0D0+DEIx3tWxiTxl9j9XlehIAP60j9CKOsYMluu/EfhgV
	 GTJXRLCBQSk6w6aAKEGVTkRRNhR7XRrPnHPgbAVgN31WdJkuT7ojf3r+5CUz/2/jDaYoL
	 x97SPLH677BHW8ygcoaoMya6MeEM/eB8RvQC1+laybtNjY8puY+AvA5VPwx8dMVOx/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DtjTJNPV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CxmpvwYI;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBF606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61DBF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=DtjTJNPV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CxmpvwYI
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C8B2A1D0020A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 06:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618438;
	 x=1793704838; bh=u+R/q8fIgW0wQ0dGsFtuObvJ2SeWRESCTfmoz9pceEY=; b=
	DtjTJNPVnPx7qCnNaXY4xLE7ViUi8A/SMNv00mn/gQs0sYz1nNHd1CykjrB7/nDa
	5yRq5xDVxri74sgUrCcVZq1AC0jrhlJ1+fUe48g2EhBKm5sWU0HTWpywHxd2KVvz
	ppryh3uz8lu5QY2QOGGcUcXrjLyw/LyWAh5hOcnOS9bBbjCpUuTatnEM+E/dHZ/E
	Bwgv8Oj/XhrpcKVDEyE+rAkcR+SCKPpN1rOlT1kzdyYOPFJsEd6BNBvbjp/sVlR/
	Bp0xB5mgUyqc6dbqQ5+2h3XzKeyh6GQrjGvOZTml4oJbWhS5KRKlVTiKGO256HIZ
	klxp/W/H+6tWuDc7f56U3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618438; x=
	1793704838; bh=u+R/q8fIgW0wQ0dGsFtuObvJ2SeWRESCTfmoz9pceEY=; b=C
	xmpvwYIHSSFeQxG/Jjd3/P11Q/IA+1itQYAukriDG3ziozj0BzSrlRouaFaZXSpL
	TzzV7+/KXuS0XUGbdAbfXpF+tsDwvjdOeYLLIRD5sKaBNEFbDsSb8qm/JoE+CTnA
	lzsC7CNWYQNJAUhOx6ratXYQSIRiwGH4QILl+RGnkKLF4NZennRfOyKYZwgWy1cA
	LUdzsEvn+trLUvQSAYzKtABQ0Z/+jsaAdi52kyo7G1t0DMd5CJkkqXeqtsp3Q3Xt
	w/EK9Qa/0TnPptX0q10uJ9X18d/m6D2WfsptgT8L8S8LyWTwiK48jFBpHyppQw3b
	aQkCJ3gqzPqdPuzEGRFOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618438; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sgdT1pTWIzg44eTjst3sk90sj/GeOiz1saqA+QtpD6FogyP
	61up3uHhceEP+YQzn9rffklGwk2/LUyHCB9fH4+aja+zw83a5xEG9v+UGyE9oeoE
	cwgIMHOaYXyVKXzNdOgNHAAQ8axA/AWEaf2Xo9+NE5xRPjy4N/JHKwp3YKnlTGkS
	+84n32JurTklRZUBCtN49y/CLyIe020iXwFEXHO/sjvSFlf5Z9BeN/FpPjTDfLiu
	tLyDl9mKevva+OlqqncHbtsY0FLcK5F9V369/ZMvl8RblTtvq7PHASzABpkWdvrD
	s6pnbNQTqN0AHX+TC6gQHc5EsiucnpV6Pv049kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uLSmVfIY0GbkYj1ejhavHUambZB//S2fhj+vN2ShcrE=:DnNjthCmbtiHbs2wUX2KeU1b+MBSAonr0dZWOAoXbOg=;
X-ME-Sender: <xms:BnLoakral-703LKyvHKRManpuEm7wRiDAKH8_p0CVXopFOz5cbljeg>
    <xme:BnLoahmCnhNjrfx1JILPOKBmRhPXRgAlZX04NM0PQDJRYzjvEL3cUk3yvbKjj5r6w
    7gFF2Qnnggr-4ZI9oJchKSUjsPP7A2LSTOq1HEmV9GPehWFE-GzLjs>
X-ME-Received: <xmr:BnLoau1FjtwrWIn7ezkDwv2pA77jfWfJ54EXVDl53ujV12FkVDlrExQXCoKnXMqjf8LKtQ>
X-ME-Proxy-Cause: dmFkZTFmjoZME9HE3u2FhWOW93LgHNK2jOXSy8KSI2Ds1OqzKZFqUYOKZ4B1+3GD2EwvqX
    c0NwthNEyE/Nc95k4wpPTDNJumy9ygiYf2B9dzpzhflTI9GCeW3Lk12nJMlnySeAbjQWll
    aQqWOxMQz1mpijmu/11bUj26lhCpefnojaTrVKX4hZiset8hXkX++ENs5cKG1+TRNxiDQC
    G8/gOCe8/jtEExcnDQz0Rn6DLL8yFZq8jka8pVCZ04lkg3WdePdBzuJr3NN2MiqZ0Eayxn
    hqQvXYLdUO3I9/mCddciQnKH75kgN9ZSxSJuVUwYXibUPRJ23EJSgwAUqEz2hcAzbWLBkZ
    iSLivgA9K69/Jrprkn2fIdx12o/izVkJ7UvNFSQg+Sn/eujwCzUpuUZNEH7c+/30y9sGJ/
    q06LtMkEGVQBzEXvT6L5D/S3ubD0UTSmSoiumC4nbrpGIw0M8cJnGiTef4SUJXeku9PGBP
    IEnwOElt6PPMu0+jm9JgN81UKSUcG9/jZh9DhIr501nMx1yPjVWuSPpAAG67jyo26wPI0S
    hZobGQ4fiFBgoCrcpvCk8S2n3jAwtFobk+AKryBhd03EE7bs+flq4qehFwcb033HMPof6L
    kJ7v0mchKv7osOuRCs7aFkjgB73YThcmlXFNKcMNhGUHVPDy8LkBYNxJ+xYg
X-ME-Proxy: <xmx:BnLoahA1WCCcDc6phcHr7nUckF2xQwu0wY-qxnn-5TtI9I0_CVimmg>
    <xmx:BnLoajztH3FKAhxHM9ScWh7SSy_BKRIY7WRj-XjtyieSjWhd_uJ9EA>
    <xmx:BnLoannXtlYLUF_EhImBoZlUWBabNKfOLPe9F6hC8vNc-ON4C9zjeg>
    <xmx:BnLoagF--9Ec-XAZx682tttLJBMVDCzc5RrX9rIy4b3ym6rw6dzYvw>
    <xmx:BnLoaoLoA1Q1akbLk0OyLV3wzbDXOycYvZxvzUIRWCpMqmDotRb_qy7z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7916ad08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:19 +0100
Subject: [PATCH 3/6] object-file: move iteration over loose files into
 backend
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
Message-Id: <20261102-pks-odb-loose-cleanups-v1-3-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The logic to iterate over files part of the "loose" backend is contained
in "object-file.c" even though it's an implementation detail of the
backend itself. Move the logic into the backend accordingly.

Note that the function is a bit on the weird side: it accepts a generic
`struct odb_source` as input and doesn't cast it down to its backend at
all. This is because all it requires access to is the `path` member of
the source, and from thereon it knows how to iterate the subdirectories
of the "loose" backend.

We should adapt this function to accept `struct odb_source_loose` to
properly reflect that it expects a path to a loose object database. But
that would require changes to a bunch of callers without much benefit.
So for now, the function signature is left as-is. But eventually we may
want to change it once we have reworked a couple of its callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c |  1 +
 builtin/gc.c            |  1 +
 builtin/prune.c         |  1 +
 object-file.c           | 92 -------------------------------------------------
 object-file.h           | 44 -----------------------
 odb/source-loose.c      | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-loose.h      | 33 ++++++++++++++++++
 prune-packed.c          |  1 +
 8 files changed, 129 insertions(+), 136 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 3f7b20fde53..aae040567e3 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -14,6 +14,7 @@
 #include "quote.h"
 #include "packfile.h"
 #include "object-file.h"
+#include "odb/source-loose.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c3..d3ba6f0c9e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 #include "path.h"
 #include "reflog.h"
 #include "rerere.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 97f4c1418bc..af2a547d931 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,6 +17,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 #include "shallow.h"
 
 static const char * const prune_usage[] = {
diff --git a/object-file.c b/object-file.c
index ab919f03fef..d3ddcbf309c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -12,7 +12,6 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "convert.h"
-#include "dir.h"
 #include "environment.h"
 #include "fsck.h"
 #include "gettext.h"
@@ -838,97 +837,6 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algop,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data)
-{
-	size_t origlen, baselen;
-	DIR *dir;
-	struct dirent *de;
-	int r = 0;
-	struct object_id oid;
-
-	if (subdir_nr > 0xff)
-		BUG("invalid loose object subdirectory: %x", subdir_nr);
-
-	origlen = path->len;
-	strbuf_complete(path, '/');
-	strbuf_addf(path, "%02x", subdir_nr);
-
-	dir = opendir(path->buf);
-	if (!dir) {
-		if (errno != ENOENT)
-			r = error_errno(_("unable to open %s"), path->buf);
-		strbuf_setlen(path, origlen);
-		return r;
-	}
-
-	oid.hash[0] = subdir_nr;
-	strbuf_addch(path, '/');
-	baselen = path->len;
-
-	while ((de = readdir_skip_dot_and_dotdot(dir))) {
-		size_t namelen;
-
-		namelen = strlen(de->d_name);
-		strbuf_setlen(path, baselen);
-		strbuf_add(path, de->d_name, namelen);
-		if (namelen == algop->hexsz - 2 &&
-		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  algop->rawsz - 1)) {
-			oid_set_algo(&oid, algop);
-			memset(oid.hash + algop->rawsz, 0,
-			       GIT_MAX_RAWSZ - algop->rawsz);
-			if (obj_cb) {
-				r = obj_cb(&oid, path->buf, data);
-				if (r)
-					break;
-			}
-			continue;
-		}
-
-		if (cruft_cb) {
-			r = cruft_cb(de->d_name, path->buf, data);
-			if (r)
-				break;
-		}
-	}
-	closedir(dir);
-
-	strbuf_setlen(path, baselen - 1);
-	if (!r && subdir_cb)
-		r = subdir_cb(subdir_nr, path->buf, data);
-
-	strbuf_setlen(path, origlen);
-
-	return r;
-}
-
-int for_each_loose_file_in_source(struct odb_source *source,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int r;
-
-	strbuf_addstr(&buf, source->path);
-	for (int i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, &buf, source->odb->repo->hash_algo,
-						obj_cb, cruft_cb, subdir_cb, data);
-		if (r)
-			break;
-	}
-
-	strbuf_release(&buf);
-	return r;
-}
-
 static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 			       const char *keep_msg, struct tempfile **out)
 {
diff --git a/object-file.h b/object-file.h
index 3cfcaefa420..83d3f38a540 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,50 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct odb_source;
 
-/*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_loose_file_in_source(struct odb_source *source,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algop,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 0f29162d752..a90268e200a 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "dir.h"
 #include "gettext.h"
 #include "hex.h"
 #include "loose.h"
@@ -39,6 +40,97 @@ const char *odb_loose_path(struct odb_source_loose *loose,
 	return buf->buf;
 }
 
+static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				       struct strbuf *path,
+				       const struct git_hash_algo *algop,
+				       each_loose_object_fn obj_cb,
+				       each_loose_cruft_fn cruft_cb,
+				       each_loose_subdir_fn subdir_cb,
+				       void *data)
+{
+	size_t origlen, baselen;
+	DIR *dir;
+	struct dirent *de;
+	int r = 0;
+	struct object_id oid;
+
+	if (subdir_nr > 0xff)
+		BUG("invalid loose object subdirectory: %x", subdir_nr);
+
+	origlen = path->len;
+	strbuf_complete(path, '/');
+	strbuf_addf(path, "%02x", subdir_nr);
+
+	dir = opendir(path->buf);
+	if (!dir) {
+		if (errno != ENOENT)
+			r = error_errno(_("unable to open %s"), path->buf);
+		strbuf_setlen(path, origlen);
+		return r;
+	}
+
+	oid.hash[0] = subdir_nr;
+	strbuf_addch(path, '/');
+	baselen = path->len;
+
+	while ((de = readdir_skip_dot_and_dotdot(dir))) {
+		size_t namelen;
+
+		namelen = strlen(de->d_name);
+		strbuf_setlen(path, baselen);
+		strbuf_add(path, de->d_name, namelen);
+		if (namelen == algop->hexsz - 2 &&
+		    !hex_to_bytes(oid.hash + 1, de->d_name,
+				  algop->rawsz - 1)) {
+			oid_set_algo(&oid, algop);
+			memset(oid.hash + algop->rawsz, 0,
+			       GIT_MAX_RAWSZ - algop->rawsz);
+			if (obj_cb) {
+				r = obj_cb(&oid, path->buf, data);
+				if (r)
+					break;
+			}
+			continue;
+		}
+
+		if (cruft_cb) {
+			r = cruft_cb(de->d_name, path->buf, data);
+			if (r)
+				break;
+		}
+	}
+	closedir(dir);
+
+	strbuf_setlen(path, baselen - 1);
+	if (!r && subdir_cb)
+		r = subdir_cb(subdir_nr, path->buf, data);
+
+	strbuf_setlen(path, origlen);
+
+	return r;
+}
+
+int for_each_loose_file_in_source(struct odb_source *source,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int r;
+
+	strbuf_addstr(&buf, source->path);
+	for (int i = 0; i < 256; i++) {
+		r = for_each_file_in_obj_subdir(i, &buf, source->odb->repo->hash_algo,
+						obj_cb, cruft_cb, subdir_cb, data);
+		if (r)
+			break;
+	}
+
+	strbuf_release(&buf);
+	return r;
+}
+
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 8d4cdac0d50..20f6ec7fa08 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -57,4 +57,37 @@ const char *odb_loose_path(struct odb_source_loose *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_loose_file_in_source(struct odb_source *source,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+
 #endif
diff --git a/prune-packed.c b/prune-packed.c
index b6749b8d132..d0a8a062b97 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "object-file.h"
+#include "odb/source-loose.h"
 #include "packfile.h"
 #include "progress.h"
 #include "prune-packed.h"

-- 
2.56.0.500.g5d06dc02cd.dirty

