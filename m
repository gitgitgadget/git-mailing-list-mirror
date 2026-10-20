Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486521;
	b=B7Kzs3GM9dqI3O4lsNg+SmMCmhs0cJz2u/JoQ/ACRQu02rmzp3jLz9jTEb9DhBJXoVkM
	 w0fHqlf0O2BKycLU9TrorkQnfHefpojL+SBGj96SiCg1HAU3PiCQf3fgL4x4Nu7/yf1UC
	 XZwXRIibQj588N8gltiRKhRI57pImfa/XMb2S2OwExLWTJIjdY++KtKMWvFszamD6Ob/B
	 2ioKgQ7kfbYAIEdFLbhGFay8KaUh12rB+rRLlFAPZX3xisKcMuxwhb5EJYZIasdpb4qWt
	 q2uSimcQBE8gLtgqQXg6c0L94sqFjQCqC809DTzlaFpIcHgURUl8JwMQlS93f2BXEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486521;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Mum+3x76F9zjE5v1lv4en1FrEenSz8AYLIWUxipGFyc=;
	b=u1PPhEf/lIDg+BzzBicpfFXn2w//cViRDwzG/GXKtrOtyopVi0WDmpOJAbc3pCESVp2J
	 JwexVyPR7VH20PUTu/fEbdF++wTdD4cNSK0K+ZQvfFgHPTKP+YkMVb0BBtQqx1IQoHJc8
	 nO28b5fcoyGG2lrM31JAgv1tFZYTsgDSHP7hDtJkHYjO3QMLGJMBcR3MTNVyyr5n5OhTR
	 pGNDoDXlWN5B9EDYbBZfSLh3200vT8VEOU3IBOzYl0eEcpMoSCbsfOFfzuErwEQfaRC1z
	 V4m0pBXe9Tyf9FSWmk75K6/hyLafD2VU9n4GWjafERuXnarBFgS9eFSPL7iKKKMntMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AXHP3mJX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=C9lsWjfM;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5557606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5557606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AXHP3mJX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=C9lsWjfM
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3412BEC00C9
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792486519;
	 x=1792572919; bh=Mum+3x76F9zjE5v1lv4en1FrEenSz8AYLIWUxipGFyc=; b=
	AXHP3mJXxkm5JQmdSHRgJOXSYbRK2kaOSUkcqQMYW/7iLgtCzKRLZDtbT/ahDCcc
	z/UbrhzQQjEtATMnQWjQR1hng/NIpg8SSGHfPHqFGnTKxZx6ZEglbYmDAx64Ct9w
	H6+ktW/UDGUhf+M43pb3F8m8lQr2foojQqR9BQ/ObVYkYVsZ+rgxJ2dmeM7pWnn6
	IAaYOEQzgvnHXL/+Axxhl1vAfL3gww4vdNM1voTYVwwDJm5U+5r6Y2jgiNzPFqYh
	f+Fg6jIfnubA///Tz3PQqqFubp2TOtXOFbKF0Gd+CDVSRU6w//0byeH21g3ENgS3
	aGhCxMb+TstdzXs7FBf/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792486519; x=
	1792572919; bh=Mum+3x76F9zjE5v1lv4en1FrEenSz8AYLIWUxipGFyc=; b=C
	9lsWjfMsVT7gTPMMpXbr4fBX0WYGA2nSbT68TLSKFUkH9mSe5vNNwMxZ88Cgn8qS
	72ABHTVx5128cc3Q5SbwxCuGA17DihBPn18r7ICoUpfqIF+WDJBozJkdz7IzK4C4
	e3xcE5C6NQEuOO3KhrbGEYO1y+s2SCDEAWfjvfLtagS/Wm57IQXBtG3E0Etsk/K2
	Tb+GRofM44aj7czqjdL4lXHrMxJBWcecPtRg4dwHOuwx0dyUSByvD6t+gPS2rTmG
	Plhuyf/pyx+Rz6KW7oq/09T/E4AnHB36/W5h0LY2hwxi8cJ1b8KlMyslJPXty0+b
	NItWnZix43cJyjLTivPaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486519; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KrAvhg+WWVWvfGAdEO2DNssoU3ECTmKv/kmW2O1qoo08mws
	pT3rQHSu6hnTW/uK5qnW+bBsO3R2K9+LH4jn7oYjWLeqPVyE5/oQnCzL7jqdHoR/
	hRkQ8uh5GXWiJP/bWDm+yXqAO2oq2Aez7PC2pBz7TnIr/cQpWZMK8bAz33NAVlvP
	cgp+1u/JhKvxfaqsLLDnvIK+fpkhKiuPBesGK3EBfXV/zs06LVka7IcamjVG8qy7
	EcuoMQReJa9O3HPWlnt6Qb7K9cKF+JrULSIwQXpLmf9lpeIZODDhS/RenJDpB4I7
	bwbyOPWhgj/lObN0rZp8qTNzOqNyNQZt1e18wIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QgNOd5QIvUtnf7tFHD4u+XIGz9/Tjc8HNdabn3okY+k=:DyUF1MSx5HRzencAzj0O9x8TtupO54J77nExHKSxgxQ=;
X-ME-Sender: <xms:dyzXapR7EV_wcNDr_jjmT-3PnVvT2lSc7-j4tZibROi_1hfMKFjQbQ>
    <xme:dyzXapuqiBppTlM2SqgwHPlgq59CfzKNuABQ8IP4P1eI8lOIW2Dk2proHIkG85P68
    09r-oC8_HTxe8X2MCBBsOXruut4xD8KZCdm415i2qTMRxreUFJnlk5H>
X-ME-Received: <xmr:dyzXakdRfkLnQg7UBLVkwPvWStWIGOuaXxGX2Jx8MpBc-jaYlsqnoVE7C93ovhmvd-yLTA>
X-ME-Proxy-Cause: dmFkZTE2cJrqgCpoRI20+EoEWmKWYPcCsVeWiOYuIRY+/gCBTEwVV2xtdDqU3QnFvX6HGv
    iNUGQBuX0WUf5iUnKIyMtRYl//SSRMSrYWZ5DKEwvNC24PSoUGktDOlOXA14hX9D9r6crQ
    JmOVAHYS2JGM24i45ueGXokmcQt9qT0o2sEb7dk00lFFkadQumUCNcaJt34jgXSIya+K8X
    kdlAsaDjaFNnY7V5F1SVsxszLWz3NZQxwdmXYwB7YOYG8zM8V5Msn+al2UR0+dFLeeYw7/
    99NNg6F5B3OnUlskF0k3ExwqRijBSKUL2VbLyOpYrM+uGC+vLkyKOqbmZ9SXkeDmJVAsq1
    xdN7HdqcwO+nI9Bjcq0okWhQonYt5y8zZRTdIlq81FkvYHdQdDdsCy+G8gQjOTI8gbH6P8
    9ismySe3/wODbUWNtGMVCq6mMG4FUtSAeuRgOqxJRxrsyiGrbJ+kE5PN5l1xxXveKI2uGE
    1OqvP5OcytB+7/FdPXomZLJT6dNoAaiHNV3IKVT20Gu5hyUSlCR0cacALbbeqQjeAtBl8t
    CpFDZVOxOT5ub7+/Q/OTMKwy/ZHsg0S58FafelkYewEl0SSBIyEe6jJmMsZe2HU4vbvoj7
    Gpn/aexXbExjhjP15dHjrotOLBqzA2G7ek+BtVYObhR24wd9keUFUN4gqqeg
X-ME-Proxy: <xmx:dyzXamLmt7TJsM5zIvMrR_tjwnESONFmPVyK6iS9PnjmibiArePPtg>
    <xmx:dyzXaiYZxiqD8E8hmGfHxDNL_P3epFdSiZeIrTMR0lTHaex1epNLrQ>
    <xmx:dyzXahvGoxWUTs1NhCurri4siXpn07HJF20C5xrFxHiTd-gULndnLQ>
    <xmx:dyzXavukmnRGSS_Nhn51FZ_O7LDJZC7xVcEn9Lhh0qiv5cQCN1gznA>
    <xmx:dyzXalSS2tgeePn2CmInI8dPX7UCGIaYCMdTmQEYRVmm6U9qH3gGua-K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e93a223e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Oct 2026 08:55:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Oct 2026 10:54:55 +0200
Subject: [PATCH 4/4] odb/source-files: only reload alternates when the file
 has changed
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
Message-Id: <20261020-pks-odb-files-reload-alternates-v1-4-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commit we have fixed a regression where we didn't
re-read the alternates file anymore when we hit a missing object. But
while correct, this change significantly hampers performance, even
though we're roughly at the same level compared to before the
regression.

But the checks are unnecessarily expensive, as we always read and parse
the alternates file even in the case where it has not changed. This of
course translates into a lot of busywork for the common case, where the
"objects/info/alternates" is still the exact same.

Improve this by using a `struct stat_validity`. Like this we can easily
short-circuit reading the alternates file in case we can determine via a
stat(3p) call that the file hasn't changed. This significantly improves
performance:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)
    Time (mean ± σ):     280.7 ms ±   2.1 ms    [User: 95.7 ms, System: 181.0 ms]
    Range (min … max):   277.9 ms … 285.0 ms    10 runs

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd)
    Time (mean ± σ):     179.5 ms ±   1.7 ms    [User: 60.5 ms, System: 115.6 ms]
    Range (min … max):   177.6 ms … 183.2 ms    16 runs

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)
    Time (mean ± σ):     257.2 ms ±   3.5 ms    [User: 94.8 ms, System: 158.3 ms]
    Range (min … max):   252.6 ms … 262.1 ms    11 runs

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
    Time (mean ± σ):     197.4 ms ±   3.8 ms    [User: 66.9 ms, System: 126.7 ms]
    Range (min … max):   192.3 ms … 203.3 ms    14 runs

  Summary
    ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) ran
      1.10 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
      1.43 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)
      1.56 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)

We're significantly faster compared to the original state now and are
almost as fast as the broken state where we don't reload alternates at
all. This is probably good enough for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 31 ++++++++++++++++++++++---------
 odb/source-files.h |  4 ++++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 917f5e9d25..8ac4f7f380 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -73,6 +73,7 @@ static void odb_source_files_free(struct odb_source *source)
 		files->dirs = next;
 	}
 	hashmap_clear(&files->dirs_by_path);
+	stat_validity_clear(&files->alternates_validity);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -329,22 +330,33 @@ static void parse_alternates(const char *string,
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
+		int fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			warn_on_fopen_errors(path);
+			if (validity)
+				stat_validity_clear(validity);
+		} else {
+			if (validity)
+				stat_validity_update(validity, fd);
+			if (strbuf_read(&buf, fd, 1024) < 0)
+				warning_errno(_("unable to read alternates file '%s'"),
+					      path);
+			else
+				parse_alternates(buf.buf, '\n', object_dir, out);
+			close(fd);
+		}
 	}
-	parse_alternates(buf.buf, '\n', object_dir, out);
 
 	strbuf_release(&buf);
 	free(path);
-	return 0;
 }
 
 static void add_alternate_recursively(struct odb_source_files *files,
@@ -370,7 +382,7 @@ static void add_alternate_recursively(struct odb_source_files *files,
 	hashmap_add(&files->dirs_by_path, &alternate->by_path_entry);
 
 	/* recursively add alternates */
-	read_alternates(alternate->abspath, &alternates);
+	read_alternates(alternate->abspath, &alternates, NULL);
 	if (alternates.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      path);
@@ -389,7 +401,8 @@ static void prepare_alternates(struct odb_source_files *files,
 	struct strvec alternates = STRVEC_INIT;
 
 	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
-	read_alternates(files->dirs->abspath, &alternates);
+	read_alternates(files->dirs->abspath, &alternates,
+			&files->alternates_validity);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		add_alternate_recursively(files, alternates.v[i], 0);
diff --git a/odb/source-files.h b/odb/source-files.h
index 837e890304..b0795cd384 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -2,6 +2,7 @@
 #define ODB_SOURCE_FILES_H
 
 #include "odb/source.h"
+#include "statinfo.h"
 
 struct odb_source_loose;
 struct odb_source_packed;
@@ -66,6 +67,9 @@ struct odb_source_files {
 	 * determined by "core.ignoreCase".
 	 */
 	int dirs_paths_icase;
+
+	/* Stat data of the "info/alternates" file. */
+	struct stat_validity alternates_validity;
 };
 
 /* Allocate and initialize a new object source. */

-- 
2.56.0.269.g68944adf51.dirty

