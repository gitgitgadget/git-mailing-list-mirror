Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759703;
	b=b/rDENU/zKOaSxRRJvcgMA3krUDtHXVX75fX05RbUlmB+BXsnpC/Om8OREBk17kjiQ8S
	 9rxEV8vZ0he+ldXixB2KtT2FL9Iwy6v87L3KGYc/SjTlO5qtjolo5705ZJYgo7MG3Sr4B
	 5gAObujoCLdm+6/QBx/aj3C2n0Ej4NBYtLkqpETer+pmi8a45H4VzNMQb5uRY3hzi/Tk/
	 Z70ebc68N+2bx9rG79jVbSOUrPlAF67Qtp40ic/5a3nIOKMl5XxeMA8E1oURzc+SiVZFQ
	 tlHFC+bVfGUkwimBt7pvLU46BxW/nC3JroVdkQ5C0PQVfBema3I5Qp1R6O4PcEB4Teg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759703;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nMUvXpXFFZLv3P83/lUj/UqsB41tAWNjmD5cOqlAsIg=;
	b=1C6s1BWxWwRWn9sCdKJtpJ0i/oS9FfADE1X2/No+voMRQL2fLxFSeQJzbwi0X2qU3qd1
	 A6Ip3vipGWWgdQ4+Kyad3StcExpwgF7GrwGw7aEWRdM57tw+WxEd/BDQnvq5+TuAy3Rwj
	 ruhw8iahb715od9RxqO8izh/6GKGDyk6bjQlNZUXHYSuUk82WBBZudwf5TAXFK8RR5be/
	 yJ6GOerDV8n/f/JJVdKCvNS6x5fC9cNEkhyqGaBze+4Iti1A5mjVdKQ/XG+DwbaE7oUDh
	 A3y1MOhlzvAowm/hvIK/jm8WFc0BIh5Ry/XxAcgeUKG/TNnrDX8nM57x6v48onIV/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EZAjYqFO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rFpYGutg;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB1606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=EZAjYqFO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rFpYGutg
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD5FC7A01FC
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 08:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759702;
	 x=1792846102; bh=nMUvXpXFFZLv3P83/lUj/UqsB41tAWNjmD5cOqlAsIg=; b=
	EZAjYqFOPvC9b6+Px3dDuo9qLkkdV5fe9gjnOoXXWnvgSdOx99l6QLfTAYvkRWos
	Yy3HZUsciSXXoXhFCknsw+usZJca2wUL+3UyDzbQDq2J0mHvLX8OA+vYNLYC1M+4
	vcn6d2s9PaS179PiNAq99QcWX5ees1VewfDeyYlO2xRoQu9EX07pwyHRx8aqj5au
	Ty+gtIhUpZ4ezZpHktx4kmMlVxvEI72w5Cd631Z0g2xNoMQHbRafC3RtpxTiL1Ax
	Ttm06WgJUxy8zWiOorrd2yz6utdBRLYeekMrEfavxsD6OQFs1crjsBqjAIjvmw3q
	493Y72R/GQ3zVoHuvNLkMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759702; x=
	1792846102; bh=nMUvXpXFFZLv3P83/lUj/UqsB41tAWNjmD5cOqlAsIg=; b=r
	FpYGutg91UEcn9CsCNuarRLm7kIyNhtwCHyJ0SxH/SfDxWI5dWxplpAPKhmtloJX
	lgPSDeq7io53basOxeUqOYS4GovOfYi12+iUIYmcj08bPx5+4faX7fsaL8T7uMB3
	j4XyMe4TuNJ+xWZcZqxUvdpTjRjqTlBcO8tgrggU+5sKeKmTl3Lb5T54hw1+7J8C
	X8NFyV0cruRFWv1c6Wl+M4UOkbV7nA00Grz+++y4TykGYjmfmSbOJiqvqgtF9CTI
	0rcn1tPOjRwfYqoU/8i08hBesd3PL3dOC6vnKDeqxzdwy3zDRncTPKwUyNyIn2VY
	6aXOQbJdurOQa7VoiBKBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759702; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rZNCxM9lzPAa5Jks8NTSy5ZUDYrppV2cgchNccWa2oZSqeE
	sT1aSRn1ldlAATWRfkrP9+T0We3GVp3EYmDHe5UVbtw6HHP7M8GdJjl9TnIjDQBQ
	YUhr6QvBMLemg3huzsyEufjxhMfvAu1dn+/ua5is7KlNTTlNpOMnKNqzNa0HKTXG
	ExbtBdAn6DCls//W4FamN+sP6z9yrz5ZN9zlCgC1Ab4GduL/Gax0XTliQxLZXPuG
	W7GoRuael7PDoolAzU4RCVG7oj4SjhHcUlLrJJsRIFbu4HWacolmG9YfqmmZOcwZ
	e+sShDUM1ugcwiQ86Hj7mHmd+NCtc4eVmiqyyAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tRboJHp4DVwE4SwJJutFePv/ASZ3vCWNOHehhXS+ro4=:Sl9areii0PLioOgKbhPD91on7bxm1Dwwkgm716xINy4=;
X-ME-Sender: <xms:llfbavcAG9QDwNN_S_we8xCYmWCr3jj8U8QhbkOLddEzmhJgPD_hZw>
    <xme:llfbarPypICS360sqo4K2JWgk5GF0PMhhsZNlz8EVp0SFdvOg3XpsGqryvXaTVyE4
    Gj-WcXPsuqTjCpDpa9vMF9w8mU9qmBWlucSeaGT0Gs3AmvWfjBpug>
X-ME-Received: <xmr:llfbamIelSO30uuQPxlyAkNKEgxolPh7FB4i8_BqnfRhnJDxzji-6vrLMgfZKqaf8wiSfA>
X-ME-Proxy-Cause: dmFkZTERjVndipZI05ExAfC2SQcVx39za3feiN0k2x+Tn1bAVIHtH6ktteF/RkeURQ4L6P
    I8tFh7yhf84sU36WbN2My9CJw9BIOYGy0iw1rbCyvRq5Z3xBvqB+fW+qn10DGstYxNaYNp
    mp/y9etl6hQO1iP+0eInGU3pZRR3URs5e44ksatypJJ3X0b2r/Nx6Rfko899v8suiawKAi
    AxNieAQaIEpIUKOQgtd1+vyg8HNvIyt+rgRuRqHM7TQVCdJIp0Z9rVB4116S/RLkevaYBP
    VErz4T4bOXXEeTXkNB0el9CuZthNd76NH2hShqCZbdnUS6gtSdD43jY+mS0PzxwJDQwlLc
    yQgGiQuYPzFvEza5vsVw41CnSu445aZjVIZ9arHsmIHXOn/bcXvlvTM9L6x6zgqOjNueDc
    FTT9ObxgXO5WRnm0iT8jjaGayrUHzfLKMRg4lcK2E0Z4v4cnS68CuXDPaQByPthV77Tklg
    kQKSu4KovbiXcvS1i9jbN4d+fHhthnCX2xnxaS/VSwFPUB4pOWTL6jor4wp58cgDVC4Zvr
    H0ePeYDntKYJRgfjQXgW7lOjD2PyAJPXoV2sLCypeHVdeCfMVl4hG59LU7ezu9S/uwxvRY
    FlfqtP+9Sqn1R2V1QqrPZNl99TRI+Cj6HNE04q4J9OKu8ncurusT4kfv+HOw
X-ME-Proxy: <xmx:llfbasFE_EVjhLZlvAtrkT2lxlEtpazNf9Fma9oSfN38oMlnZz0BDw>
    <xmx:llfbauQp4RvbhT3MTZpplpkaotl4X_PSZX1cTn9LTs5ZyB6Rkjnldg>
    <xmx:llfbaoGZSR4NWP_9XTH8UnwttZHxir8cWZa7cTv0i-Xti5vTwqxW7Q>
    <xmx:llfbaq_0wEG9meck5tQYBOpP213-R8lYmdaTnXRcDRxk5HHEsPClyw>
    <xmx:llfbamPzbiyP25dDMLsjH50bfrBqN9dquYBGFIt3wNKVopITckNgZDdz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53852df2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:05 +0200
Subject: [PATCH v2 6/6] odb/source-files: only reload alternates when the
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
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-6-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
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
 odb/source-files.c | 39 ++++++++++++++++++++++++++++++---------
 odb/source-files.h |  4 ++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index f7eb4a9df7..6b4ac3e6be 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -73,6 +73,7 @@ static void odb_source_files_free(struct odb_source *source)
 		files->dirs = next;
 	}
 	strset_clear(&files->dir_paths);
+	stat_validity_clear(&files->alternates_validity);
 
 	odb_source_release(&files->base);
 	free(files);
@@ -298,22 +299,41 @@ static void parse_alternates(const char *string,
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
+		} else if (strbuf_read(&buf, fd, 1024) < 0) {
+			warning_errno(_("unable to read alternates file '%s'"),
+				      path);
+		} else {
+			parse_alternates(buf.buf, '\n', object_dir, out);
+			successful = true;
+		}
+
+		if (validity) {
+			if (successful)
+				stat_validity_update(validity, fd);
+			else
+				stat_validity_clear(validity);
+		}
+
+		if (fd >= 0)
+			close(fd);
 	}
-	parse_alternates(buf.buf, '\n', object_dir, out);
 
 	strbuf_release(&buf);
 	free(path);
-	return 0;
 }
 
 static void add_alternate_recursively(struct odb_source_files *files,
@@ -345,7 +365,7 @@ static void add_alternate_recursively(struct odb_source_files *files,
 	}
 
 	/* recursively add alternates */
-	read_alternates(alternate->abspath, &alternates);
+	read_alternates(alternate->abspath, &alternates, NULL);
 	if (alternates.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      path);
@@ -364,7 +384,8 @@ static void prepare_alternates(struct odb_source_files *files,
 	struct strvec alternates = STRVEC_INIT;
 
 	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
-	read_alternates(files->base.path, &alternates);
+	read_alternates(files->base.path, &alternates,
+			&files->alternates_validity);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		add_alternate_recursively(files, alternates.v[i], 0);
diff --git a/odb/source-files.h b/odb/source-files.h
index 8695b6ee91..de058edaed 100644
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
2.56.0.307.g5fe7bd680c.dirty

