Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354345;
	b=0y6pylrgKpTuHpxaNSUxC5WxsMTWUwGyMCaNXDr2NeDGYVGHhLsmcRR7dkeafkRcDew1
	 1ADPht4jlWXpDBLaNtrn/uqc0GLxo/0VMNn+g9k0Gq5ln+aSTjMPJPQY3wIoelEdnxwzo
	 kZkrTBKa/oUZlOSaP10+1n+eCX4LpNZMvgNlTrcKItW3/rdTm3zG418JnOrJTwrBPLMLZ
	 Ut2pAniaQk0tv5ECUT7jrDhCEQY9tL4CYNtbAq9S1+xAoLOb7+CXpqTauGXJdI3wXwI5f
	 kxE9nzS5YNUtgYmPRhoR20j5+vLiVNzVennVtjDFn/Ls6ao8fV+ah7mHL1A3UKPMZDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
	b=soMhF3k3NF7XsKKZ+7bRifTPLuld//lG9CpTDftmuI8OZeeylbf4RgH9hcLa6VdTxrj9
	 WJZ6IfN/RIKkJR1LUDF9R1Ax6fIXu4jAkE03XEvV8qNrJW9mIC/Um//m0CqfRxEpUfqK0
	 DRIKqEJoSIQ3CgHN9JQ24TpoM7pMxr/vt7DwnG3prL1pEaIv3p1bN0JToZJbxSxnKFWN0
	 UWJjFu/cJUHF5gze2pRwTNXTq0gv4c+6IQAqZufxNNzk3Xtf4NVfDVC09i7l04zelAbsd
	 1nKtmeCwVmrCI6UgmcqoHMednEACi/29XPt51GRxj6hxXSRMbdKvfVu0/EHgo2ae+1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2pKI2Ov;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AE606A325
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 507AE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2pKI2Ov
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e09aa5264so231011f8f.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354344; x=1793959144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=d2pKI2OvDqEoFuixVIUuG0aE1ZuQURUKd1KVMJkG0TboaPw5ZjcW4x4jYTBLMXbTh0
         NlBWwEQS/uoK6GewIBKqjezLSHe8OB/0xXGQibA5IYkdckl7VZAB4W0h87iQUbbBsTM0
         4zOttIkh/g6vUGhE2CNv/0kkl8UYYQIOk2yfiKnIvfejljMyDP7UVkwuwIfB1Lu/nrDs
         5m9U2XnPAIks35dUXqD2U6mKznnNGjtI5Uu0DNUwzDdgANWAShrfVc269p1q/iB9zTdd
         TXwL5nH1mFe7eMy7Kem5VBNOFEWbH9bkIFYf7liBBjXGCpbCOAX2EEmPSW1ZXXDt2SYc
         Zpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354344; x=1793959144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YB/dY1/JncGppmuxvNSdbjIP5bvqd49CyeqBNY5NcXQ=;
        b=J6nlFNx+bmimzwi22kCt0vWQhOJeYbv4PRoarFFzj/HOrujejCmOw3cH9nbLjgmn5k
         TcRtwsWvVO83qRArEBZkPyv16aureh/1hU3GLRGZmscLEMmCRE9WcKrsrVXQ08gE3w+8
         TNT6QnrwDA1a9b5T43jp0Br99SU53Iehuyi0cKjbB2A0t2C1cgQTzse59nb0x1oGSXVo
         ysXxTQuIaAjD/Pe2VewySwnKXPhJ5roRx+qHSwczpmHbrWgzboIyzr38mOfG4uxipKAN
         GkuOYGu5PntMEc6oDfdy942bwXdm9XiuZrceyxeukjew9D6qmptwWCDOk0+2AZHWcvOt
         dYDw==
X-Gm-Message-State: AFq9FYJNhwQd8g/qHme4Xyom050NwjtHDyIVXVZnP+hV6f9SDIL01+FA
	UcqfIjqEPMucq5qAe0FjzF/ql1U+GYy5YDcUAbu6VQP/i4lTJ5hWvNC+17Q8eHPC
X-Gm-Gg: AYBFou2gSQP7+bS7oLkyyBxuuVS+vSHd7JlSyMp7NfA5DQWiHK8n8x7rqMwNP9ArFq9
	e3OdWbdBgDDhEgLbod69GQcZnzn1KRAekWRSYezt+O8KrHy36/4sTu+SbHfo2K2cj4jmT9zbJ56
	dEPbOEaMvtZWNaYxEQJGlHYWywk6FfYzMdp51wTK+GOE5BVH94rr/7S/dWIjZiyrvK6f+msxmur
	WYh2ARApUW7Rn3uszLJNYbhxz6tdou9Wgl3xeLpZm536Oy9VlrZRDY4P/33/JFTErsi6QvVmJ0m
	tk5itAYltdY0o9mVaLG57m2siyzUhQV2RSXebXeQ/JEjdJgUUAY4S6wzzCe+O38ZZux2Di8ERfv
	W/Lq/SGn+61+P/5HlTMfRFPren1S8yzn56lW1bWROyRckwaJ6bB10FVsUqI9JyRxy+BuqLF/l91
	SoJ17iSF2gKtP79Twvw2sN+ifl7RaAWLP08gL1lp7NISvnABNnfu3bBGsfzaAKs/cjylsExnwnq
	xJ9PDWsPGI2OXSDTuMCgQFxD+PBlcpyXlGbf/sEGhuS9kupKimu5qgbLChyhNtxT/9nEA10VEIp
	ANqjRdAhAX1z/SG8/rYnD+YAbcPggU+qvr+vl41Wj+q+Poet8w==
X-Received: by 2002:a05:6000:1619:b0:48a:fd58:a7dc with SMTP id ffacd0b85a97d-48e6e2f2b25mr3347957f8f.12.1793354343613;
        Fri, 30 Oct 2026 02:59:03 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm2359421f8f.47.2026.10.30.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:59:03 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] convert: use size_t for buffer sizes
Date: Fri, 30 Oct 2026 10:58:52 +0100
Message-ID: <88ca2ceb801f93f39eabac3bf0b51f53fd04e4d0.1793352943.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793352943.git.gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com>
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

The conversion code receives its buffers with a size_t length, but the
helpers that scan them, gather_stats(), gather_convert_stats(),
gather_convert_stats_ascii() and count_ident(), take an "unsigned long".
On platforms where that is 32 bits wide, like Windows, they only look
at the first "size mod 2^32" bytes of a file over 4GiB. The decision
whether a file is binary, or contains CRLF line endings or "$Id$"
keywords, is then based on that prefix, and we may convert the line
endings of a file that is binary further down, or not expand keywords
that appear after the first 4GiB.

read_blob_data_from_index(), which feeds has_crlf_in_index(),
get_cached_convert_stats_ascii() and the reading of .gitattributes from
the index, gets the size of the blob as a size_t, but hands it out
through cast_size_t_to_ulong(), so on such platforms "git add" of a file
whose staged version is over 4GiB dies when core.autocrlf is in effect.

Use size_t for all of them.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 attr.c          |  2 +-
 convert.c       | 14 +++++++-------
 read-cache-ll.h |  2 +-
 read-cache.c    |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/attr.c b/attr.c
index 0e63f1b6de..1acb4ef430 100644
--- a/attr.c
+++ b/attr.c
@@ -793,7 +793,7 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 {
 	struct attr_stack *stack = NULL;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int sparse_dir_pos = -1;
 
 	if (!istate)
diff --git a/convert.c b/convert.c
index 036506842c..ca5594cab0 100644
--- a/convert.c
+++ b/convert.c
@@ -42,9 +42,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };
 
-static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
 {
-	unsigned long i;
+	size_t i;
 
 	memset(stats, 0, sizeof(*stats));
 
@@ -102,7 +102,7 @@ static int convert_is_binary(const struct text_stat *stats)
 	return 0;
 }
 
-static unsigned int gather_convert_stats(const char *data, unsigned long size)
+static unsigned int gather_convert_stats(const char *data, size_t size)
 {
 	struct text_stat stats;
 	int ret = 0;
@@ -119,7 +119,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 	return ret;
 }
 
-static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *gather_convert_stats_ascii(const char *data, size_t size)
 {
 	unsigned int convert_stats = gather_convert_stats(data, size);
 
@@ -141,7 +141,7 @@ const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path)
 {
 	const char *ret;
-	unsigned long sz;
+	size_t sz;
 	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
@@ -223,7 +223,7 @@ static void check_global_conv_flags_eol(const char *path,
 
 static int has_crlf_in_index(struct index_state *istate, const char *path)
 {
-	unsigned long sz;
+	size_t sz;
 	void *data;
 	const char *crp;
 	int has_crlf = 0;
@@ -1077,7 +1077,7 @@ static int read_convert_config(const char *var, const char *value,
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+static int count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 066dd8bc3b..d279059b5f 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -416,7 +416,7 @@ int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 int index_name_is_other(struct index_state *, const char *, int);
-void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
+void *read_blob_data_from_index(struct index_state *, const char *, size_t *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..635dad1ba3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3472,7 +3472,7 @@ int index_name_is_other(struct index_state *istate, const char *name,
 }
 
 void *read_blob_data_from_index(struct index_state *istate,
-				const char *path, unsigned long *size)
+				const char *path, size_t *size)
 {
 	int pos, len;
 	size_t sz;
@@ -3503,7 +3503,7 @@ void *read_blob_data_from_index(struct index_state *istate,
 		return NULL;
 	}
 	if (size)
-		*size = cast_size_t_to_ulong(sz);
+		*size = sz;
 	return data;
 }
 
-- 
2.53.0

