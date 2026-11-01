Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522702;
	b=Rh0Tej0RuhDPoNezGIBIZWSE0ZBXCOYc4s/sDpl9oU9fPbiA82rjhn9auJKh3IwY0/e5
	 Tc112dKcdbw2fCprBmO6rog4/zhXQjAKdImNpH8RE72F25eDLc/vc80WHulbenSF1SGL1
	 uBp9ma1EfUFm5wHxCOQeJJMBp9UJETvaXM5clP480n5IFL3Mf6CAWbvAh3uoflhy1vtPJ
	 bTbi1SxSck49BX4KVtlHyp+fAkoWO6Tti4GL9IGJmdN2Rf84tY7RLDv27COhr2XwhsSb4
	 4a9U9Wy2dMOQ+FB3dtvlL3kRGEmEeXGiwVOaKKrvfGKQzbnPH6lyjSgqgk4Mdr2x3iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R8HwYrlKXNsNuZzZQSnKn4vJj9RrE056XnL6lkokTp8=;
	b=Zx3+Mw6LWjmTolmis1FF04LpVWzQEkabWiZTHbSiU2X1i1neo2Erb7qYJp+eAGqSZDVk
	 iYGsVGi6m1r2s1Tf3NmE8rlKKnok8IGCCAq3/Gc/RUXrLByOdY++tEV0zYuwmOwSxxEyB
	 bS4STnL+U/bwcbJTNMKa22xo6k/mnbYJJVB8BFQ844/LIJzI0N99+c5hYVflecvbVeVtw
	 qKNFDuvaR26xQuMLuHoqFugVyN6UrKlxatzHT6+8QLdGN18JLKXSGJPpb6jWDbgR7H0AK
	 5I3nGG/k6X0QfSaoQ8wuzgbDmcIVQST+apwdtMaLNSpPC5mwq2BXaqg/XHiWDCqy9tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnczWKeJ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E43606A32D
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88E43606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnczWKeJ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1606969f8f.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793522701; x=1794127501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8HwYrlKXNsNuZzZQSnKn4vJj9RrE056XnL6lkokTp8=;
        b=rnczWKeJ9S5rNGD/cCSFOgOLfzj2oxsHEgGelHxqvy5qdpBffT61a+43fi7f9z2z8Z
         Knr65MPW/ieLMLy+CdZXBCqh32xW5QHyQjJDey8ovMmgXOomP7FJPX5PpmO356vZPaN2
         CNZMDSZaQSDyzTu4s60Gei/6sQ++EGMfCZGCZ8DHFqmp/eiosdEXLJlVFBuSFFO4Ov36
         g/HnA67HiBtrvNZf7utehPCXDqWqTGgj/23H5Sgv3DNW8LCB6ji70qmZ0mXyb7zn6R1+
         GTAPqIvZwJp8Y9XttSQSsjvAvtc8UX+cbJ1ygWpghQl6mg1dtjmyHTTNXkapdLlEtQF1
         4f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793522701; x=1794127501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R8HwYrlKXNsNuZzZQSnKn4vJj9RrE056XnL6lkokTp8=;
        b=Jq1ABMqDAYBqdcDQE1eBW5N7yL/cvRTJoao9p5bWq/5LtEV9JlktjdzeN3Yy6zCmXC
         qqINK/6clUdRTCJ26mOC836Y5vzE6w/3F0Lkg3+D14Su0zh+lkCQQnklVbE4Kf3dg8lr
         yJpVjzvouLZ5Qg3uxZItxDOJ0fNm+oidEX6SHJLUKNe05W5n1bmzpHbHJe0jujfrkigi
         oK+M58E33iO1g4EDCTbee7wmHpTXGGMXcWN11c0ZeN8LyMpLfAxkeXaS/SVuxWMiOKND
         p+Nc2yTM/jC97o2KXMy47yNWNyMoA82UxwsCUOXVlMTMcZ992I5h6dZDl2VaJ0Ee1mnb
         PKgw==
X-Gm-Message-State: APuU4Z9pU+AI0AXzf778qP4o6YazsKdaE+lQzRpuyvUg6ug8qHByEM7v
	iDJ3lI485UDZzmujA4tBK0jVqdRWFNi5y3HJXzdZPOrGHAmSk9FiSJ5LKbfAP141
X-Gm-Gg: AYBFou2IGlpn+gQuRP4FM41583xEM0W+1skxTg8k2R76E1JMatIMU9casRAhI+WTQLD
	xhMspCFlETa/PdEy+ZNGnOqpIEAXWsSSvwHk6L9M9d9XoWKJsPVJ2/ZWmgYz3jaEdUFvfLDkR91
	YVjmYT+UAml0S9Le2gXKbJnyYZjl0lsLLdjaZ8Xvt6k05AAlWdqXyk8LGJwRxgYTYleFdgCS8FM
	Qs4wAkTnB4hfDuwE/sF1GU9N0052VFZGNLkjCXHyb8/G+wYnnFqKWr9mPGtq59sXOT6vbRlDJxJ
	6orjcfycS46g3jEDYafJnpcGIqczFeKvvs4G2CPZJC8BO5qq4EEetqf80Gu+eRuyQiU/CHNmuA4
	r5hgCdH7fJO/xtCcGbuYSjEOWZ9hXbh9IH/CIV1LPEPj5a/tD9spqnduRlZ+kLBoJC/Qc/mmwT0
	Yl6wji0uOE7+UXdRGYbzhnT74hDyZhxa5+7To7iUkIy/3r3jK8NmCLrlrSZWWzBBH/q8pUpRYYy
	DqZGDOKrROLszZtKKD2rFu63lVawzj2AP8i1cksgMaJn7/TPn8XtpdvYu3A45aUhXvEfI0ZgTgv
	SC03CAIFPkh0l65HTh1+ulunI05j4fXSRbJ5S7oGSBNqCuwEoLw3S2/kQyPHCOs=
X-Received: by 2002:a05:6000:2997:10b0:48e:5e63:bd23 with SMTP id ffacd0b85a97d-48e6e2ef96fmr11473279f8f.30.1793522700727;
        Sun, 01 Nov 2026 01:45:00 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm13330965f8f.35.2026.11.01.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:45:00 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 1/2] grep: use size_t for the size of buffers to search
Date: Sun,  1 Nov 2026 09:44:56 +0100
Message-ID: <bdf2f51187093544959ba7028b86187b56b2dcaa.1793521916.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793521916.git.gitter.spiros@gmail.com>
References: <cover.1793521916.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct grep_source tracks the size of the search buffer in an "unsigned
long", while grep_source_load_file() reads worktree files into memory
using size_t. On platforms where "long" is 32 bits but size_t is 64 bits
(such as 64-bit Windows), processing a file of 4GiB or more truncates
the size, causing "git grep" to search only the first "size mod 2^32"
bytes and silently miss matches beyond that threshold. With gs->size
truncated to 16 bits, "git grep" and "git grep --no-index" find nothing
in a 100KiB file whose last line matches, while grepping the same file
as a blob finds it.

Use size_t for struct grep_source.size and across the internal matching
engine functions in grep.c and grep.h. Additionally, remove the
cast_size_t_to_ulong() call in grep_source_load_oid(), allowing grepping
blobs of 4GiB or more to succeed instead of aborting.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits but size_t is 64 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 grep.c | 16 ++++++++--------
 grep.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/grep.c b/grep.c
index 1d75d31421..a8c01b4737 100644
--- a/grep.c
+++ b/grep.c
@@ -864,9 +864,9 @@ void free_grep_patterns(struct grep_opt *opt)
 		free_pattern_expr(opt->pattern_expression);
 }
 
-static const char *end_of_line(const char *cp, unsigned long *left)
+static const char *end_of_line(const char *cp, size_t *left)
 {
-	unsigned long l = *left;
+	size_t l = *left;
 	while (l && *cp != '\n') {
 		l--;
 		cp++;
@@ -1454,7 +1454,7 @@ static int should_lookahead(struct grep_opt *opt)
 }
 
 static int look_ahead(struct grep_opt *opt,
-		      unsigned long *left_p,
+		      size_t *left_p,
 		      unsigned *lno_p,
 		      const char **bol_p)
 {
@@ -1567,7 +1567,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 {
 	const char *bol;
 	const char *peek_bol = NULL;
-	unsigned long left;
+	size_t left;
 	unsigned lno = 1;
 	unsigned last_hit = 0;
 	int binary_match_only = 0;
@@ -1735,7 +1735,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			goto next_line;
 		}
 		if (show_function && (!peek_bol || peek_bol < bol)) {
-			unsigned long peek_left = left;
+			size_t peek_left = left;
 			const char *peek_eol = eol;
 
 			/*
@@ -1854,7 +1854,7 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 
 static void grep_source_init_buf(struct grep_source *gs,
 				 const char *buf,
-				 unsigned long size)
+				 size_t size)
 {
 	gs->type = GREP_SOURCE_BUF;
 	gs->name = NULL;
@@ -1865,7 +1865,7 @@ static void grep_source_init_buf(struct grep_source *gs,
 	gs->identifier = NULL;
 }
 
-int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size)
+int grep_buffer(struct grep_opt *opt, const char *buf, size_t size)
 {
 	struct grep_source gs;
 	int r;
@@ -1935,7 +1935,7 @@ static int grep_source_load_oid(struct grep_source *gs)
 
 	gs->buf = odb_read_object(gs->repo->objects, gs->identifier,
 				  &type, &size_st);
-	gs->size = cast_size_t_to_ulong(size_st);
+	gs->size = size_st;
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
diff --git a/grep.h b/grep.h
index 13e26a9318..0bd705dfc0 100644
--- a/grep.h
+++ b/grep.h
@@ -212,7 +212,7 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *orig
 void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
-int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size);
+int grep_buffer(struct grep_opt *opt, const char *buf, size_t size);
 
 /* The field parameter is only used to filter header patterns
  * (where appropriate). If filtering isn't desirable
@@ -235,7 +235,7 @@ struct grep_source {
 	struct repository *repo; /* if GREP_SOURCE_OID */
 
 	const char *buf;
-	unsigned long size;
+	size_t size;
 
 	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
-- 
2.53.0

