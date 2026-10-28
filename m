Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171524;
	b=5KH20j46QzkjSIvKVqrHESxUkungB6hYCc6rkfRQg1MZ+p9U7qQd0Hc/ku+OotttWefC
	 wIhF8hEYAFxG/fKk50/0vg8PzDQ/R01YK/p2SpGk0UzczP4zlWT4panPfmyDFeBal5q4R
	 TB00mx4lsDC67//4JK4LebpZFfTjPGc5LuuaPYSyMTae5WxGZm40GwRHBcubMknyOWo/E
	 kwFgBONK0RVQn4nc76IAvk3qjzFjGETrMRxc4AiF7WU6ltaSRTCTKCTN3INHwz1SPMjcP
	 ks4ffrBPeNTaZMjE/4zmN40mKxZc+ze5douCipD6T9D8EUFPj+vPDdX7HoDymMl2j0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171524;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=vY3C2xxw72O1b/IYM7lcUQuaBlpMShZLMvMBabukL5I=;
	b=UNJzz5DGw6hTWl8i6bUFDzP6YLMYR6QPGsv7Ap/cR7kOePURQFU4q7zguUGJ0XncUaRL
	 RjRqD0+IUja2SRPbu0wENd6qlnHVycq1Rr8ggBJdNdPb0QJzwebH81zGrYFFeYU+BFK6m
	 9p2W9aBWBASp+HNuZlEKBUc0HfhM1FTt3dXxD08trKm3cid7hYFh9RNQW68DmTtRxwq7g
	 KqRQNSRT4uAgM23vJim1a7PYMJEOexy/6wT8CV3f05SS2RKMK+L+au6IobvUfc0+53E81
	 Z40EmXVeXLEpFj4sEUbbtq4f5AwguGDrt2MKDrE/hWTiJop0sqNNdSfn3CeqHMUErZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Me8ORkk5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xu2I96N+;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240E606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2240E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Me8ORkk5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xu2I96N+
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D3BB7A017A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:12:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 03:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171521;
	 x=1793257921; bh=vY3C2xxw72O1b/IYM7lcUQuaBlpMShZLMvMBabukL5I=; b=
	Me8ORkk586GHfeRmA4DYwdcExhh0KiSBzPyDIZwBj4+mLDU07GqbpMKKqAF5oiV+
	d5Px/nMuxM7c/afCIsYJsX3kU2beiSsUlBM12Oc2e8vAOFykiJ8Op18Ykn8t/h/d
	sC0Sorqe0tPSagY+6vSGL0IW+9gA0E1V7K9M8xEipfWyEUMnLKfFdrMw9WAzYt3q
	6DQTGEBqLk2lRF4fm86Pdw5iCeG0+kwbTpjrWHAfQifqZM8hf67MVjoTr0nrkRft
	JOPS4iP6Yk1FqaPInJwPr+POCbaxtiORY/DOrsTzelMtkrCSFqyryjdXf3uKSIMJ
	UqwNtRCcwreQ9bVRzr7UVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171521; x=
	1793257921; bh=vY3C2xxw72O1b/IYM7lcUQuaBlpMShZLMvMBabukL5I=; b=x
	u2I96N+5c8d+WDr3Ev3NPXo5qJdOZZ1A9eJCR4PXesFggOQGpAjU2keMSXvLiwrF
	wVNz4ronrLESpKHIIN1VMQTpNthoaZ8aJaxu8iKwWLTsozOOo7xHzGqVwP1hp3gy
	ZFdBioeQbnne6rr6nV7YmPMvsnVNCyrmU5x7muTxihLvO8DdrQvntNd0lKUJe4F3
	15ia40jA31ZtIYtnuC6IuYWpygVHIIrBwpOeW4g2/cHr8VWEPqVYsagt8NuTozF2
	C3lSDQxZt45bb3BwG4fY7Gi4nsIbPIcMODZHHtZ31akr7MtVLwKU74g9iqTD9TUA
	1fhDblbFx7R9BrSsN+NQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171521; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uTueaM6tLLCXHmB6cd1e7vqSf4V0hf9cTUk0FBj0gMFWg/i
	CnxY6hsTHPCl25I//VPJfccARIw4mfDwjdU2xngtyds2OklQYnj1vsYdFPr8B0WD
	eQLwtLAtXv5vTD+27J54PJZBet4o0V1tXEwFW+wrW5Om1pyDA/EueW5Rhcp/vnV0
	/uOmVrQGG3W0oxnz8tBOsPYZfPO6f7qE1f9Chmtz7B0NxRoArBQHYWajjcGik5cY
	KHndHYnLl2AjnbGKMaBe8HCL+lUOvSejx9kX3TBdqFKdCJxXaD6ODN3meYkzdL0M
	quX2p5wz3AnnGbBv6JcSRt335B7xs+4nfCOO09A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+JLcoXUZPhG2CYoXLfOpBCtcYN9o3cgq/Va6xWQvyyk=:wHZOHX41ORkiO8gO1ffZw0b8f+C5FyQBjZfcEXteAiE=;
X-ME-Sender: <xms:QaDhaudagyz55uZ_55k5olC8BKfEN3Z5f6VpaBUZdFhdEa56GGnzGg>
    <xme:QaDhauPdIO-l5pOEKhyIT1oPR1lnpQKvZzx3fZ6tDOhatedXsx0w5VJth1qQAXXIZ
    rFVx67zzzb4MFm9EZlTfWkxdN2Zbn6ufpRJtWxCIj5XzS2NL6j_-Vc>
X-ME-Received: <xmr:QaDhatJh5fNfGboU3_oh-LT9518nEWMiRcM5v-rc9w0hdsL0BgCHcw>
X-ME-Proxy-Cause: dmFkZTGpalRMAGWFCRIc8d6tcoFeMg6s2TcFjaOBFDSBQ6SxmCPvNkl9aoA8Qw13l8FjpT
    4zDpH7d+W6T98c/+huCH8VuoF4R7QaFYdm5ReK5p24eZfxrurKwaatPaFUmPFS3F7wG19G
    F0VlHLzJknGGKdpi9CuEt1yGcbO9zT4RKL+DDS47ROClRJTiJdnjfKI2+fOcjW0fbfuDZU
    obTzkwHzqjLPyqyaIRZ+7Oa7UVjOG0FC2U6fbAFfo4oGh3R8xEBeR+rOBlorkmPpVhXpIn
    Ma8LbenAbpVxr/qNIlRjipaYge/mfS+SWGbrvuxvt4L/T3Yr7sVIgNbKEvmxjHpXjj5WHA
    cOoxCKBPdABCii5yAEhHdG2Fy5Y1zp9FyMxoaXpFukugi6ESHFJTWhnrr2AQi13WoFdVG4
    AF8xgFSlxImtCdnykJfV5IucE5gRxwh91BCjZw1DpVFTLLai++Z3PbD4qa6yYdlf9ZsMO9
    fcDydYRfyDA6UKaTxtCF46AC++DNA89XhGKEZQra2GkCk5QOfvIYjMsHU2ntLSymaNDjtR
    reqiOZ8XO0UQMrQkvhWAAe1Lqx8dduMsgVuYpnYjyi7+Az9HIFVSjmei7ioVH4wK+Ih8gr
    q+2YDXJlC4PetfEZxZbh6Wj9+lSuN35sgUwbrIoEfshTCyo4+EeYYboQ6jBg
X-ME-Proxy: <xmx:QaDhanGb_1_j_xPeBHwJJpnXTF_McNJqDYUb9OMA-W_mDkDkD7RAhw>
    <xmx:QaDhatQyb7ltrLKh2o_YCHffTtQwi7Am3iOSlWSobW_jQvmy2ieHCQ>
    <xmx:QaDharEHCy0Tt63gWwkojaonyIx_cK5gitS-SI28WQ_P4Ah4LobCug>
    <xmx:QaDhah__W4fcFgCVPJYLZEIVI9Neztaf2ZXo81RSy8hKbmy5CdKIbQ>
    <xmx:QaDhalNsx7Hk3dBqWGgWpFJz1XDJR0L2dSCzgCXSCYBTy4yxGrdqw3R7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:12:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08f588a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:12:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:44 +0100
Subject: [PATCH v3 6/6] odb/source-files: only reload alternates when the
 file has changed
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-6-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

In a preceding commit we have fixed a regression where we didn't re-read
the alternates file anymore when we hit a missing object. But while
correct, this change significantly hampers performance, even though
we're roughly at the same level compared to before the regression.

But the checks are unnecessarily expensive, as we always read and parse
the alternates file even in the case where it has not changed. This of
course translates into a lot of busywork for the common case, where the
"objects/info/alternates" is still the exact same.

Improve this by using a `struct stat_validity`. Like this we can easily
short-circuit reading the alternates file in case we can determine via a
stat(3p) call that the file hasn't changed. This significantly improves
performance:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    288.5 ms  ±     2.3 ms     284.9 ms  …   293.7 ms
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    185.3 ms  ±     3.4 ms     181.2 ms  …   200.1 ms           -35.8%  (1.6x faster)
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB           -0.1%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    262.7 ms  ±     2.7 ms     257.1 ms  …   268.0 ms            -9.0%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.5%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    199.5 ms  ±     2.5 ms     195.4 ms  …   207.8 ms           -30.9%  (1.4x faster)
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.0 MiB           +4.3%

We're significantly faster compared to the original state now and are
almost as fast as the broken state where we don't reload alternates at
all. This is probably good enough for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 38 +++++++++++++++++++++++++++++---------
 odb/source-files.h |  4 ++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 4a2b9039784..5f5e6bfd7d8 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -73,6 +73,7 @@ static void odb_source_files_free(struct odb_source *source)
 		files->dirs = next;
 	}
 	strset_clear(&files->dir_paths);
+	stat_validity_clear(&files->alternates_validity);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -315,22 +316,40 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static int read_alternates(const char *object_dir, struct strvec *out)
+static void read_alternates(const char *object_dir, struct strvec *out,
+			    struct stat_validity *validity)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
 
 	path = xstrfmt("%s/info/alternates", object_dir);
-	if (strbuf_read_file(&buf, path, 1024) < 0) {
-		warn_on_fopen_errors(path);
-		free(path);
-		return 0;
+	if (!validity || !stat_validity_check(validity, path)) {
+		bool successful = false;
+		int fd;
+
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			warn_on_fopen_errors(path);
+		} else {
+			if (validity)
+				stat_validity_update(validity, fd);
+			if (strbuf_read(&buf, fd, 1024) < 0) {
+				warning_errno(_("unable to read alternates file '%s'"),
+					      path);
+			} else {
+				parse_alternates(buf.buf, '\n', object_dir, out);
+				successful = true;
+			}
+		}
+
+		if (validity && !successful)
+			stat_validity_clear(validity);
+		if (fd >= 0)
+			close(fd);
 	}
-	parse_alternates(buf.buf, '\n', object_dir, out);
 
 	strbuf_release(&buf);
 	free(path);
-	return 0;
 }
 
 static void add_alternate_recursively(struct odb_source_files *files,
@@ -362,7 +381,7 @@ static void add_alternate_recursively(struct odb_source_files *files,
 	}
 
 	/* recursively add alternates */
-	read_alternates(alternate->abspath, &alternates);
+	read_alternates(alternate->abspath, &alternates, NULL);
 	if (alternates.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      path);
@@ -381,7 +400,8 @@ static void prepare_alternates(struct odb_source_files *files,
 	struct strvec alternates = STRVEC_INIT;
 
 	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
-	read_alternates(files->base.path, &alternates);
+	read_alternates(files->base.path, &alternates,
+			&files->alternates_validity);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		add_alternate_recursively(files, alternates.v[i], 0);
diff --git a/odb/source-files.h b/odb/source-files.h
index 595a4e78eef..99217bc0a53 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -2,6 +2,7 @@
 #define ODB_SOURCE_FILES_H
 
 #include "odb/source.h"
+#include "statinfo.h"
 #include "strmap.h"
 
 struct odb_source_loose;
@@ -61,6 +62,9 @@ struct odb_source_files {
 	 * determined by "core.ignoreCase".
 	 */
 	int dir_paths_icase;
+
+	/* Stat data of the "info/alternates" file. */
+	struct stat_validity alternates_validity;
 };
 
 /* Allocate and initialize a new object source. */

-- 
2.56.0.341.g393f52fd96.dirty

