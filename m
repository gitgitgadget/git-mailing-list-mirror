Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094F13D8BF
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503571; cv=none; b=LsNY3BzZs3Ud1OglkZfTwrxRr+L3yYlb5ZhQj7S4gqzQnSSLDW8LqzDE34WyYxwX9VUJ/5kgl8Mys1OsPAo5o4BJFrlFqoPP+TLyBqbhqNIAl0UPkk9bpOiIVfu42GJWRjRwnw1Wb7BuC/dh6HvxyZS1Efklm44O2CrdLDmzLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503571; c=relaxed/simple;
	bh=wdY4rbt9T8EYAx9TI09RrVo7QZ/qHqCI0oaCNEIBAN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ForJE3giMg2104SBwIJrUVQa9YqoQcjORpl3iVBoikDiN+3feOoSD+mJqIejJaGSsC7feTsfuZGIMkHCAJ9t1CuJkqEVXXutcC29g8yZqDQ3RpRKrUkFeSZwBmywHZnlikUhf+RgoLRcQY92TPj+YUaTmtOi+oXcQ2FILN/A6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euy/SCKk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euy/SCKk"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so17965045ab.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503568; x=1721108368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb1pmm0NzfzvlKCYkjSJOAkVlPjk8a1r8uay8brZ7Zc=;
        b=Euy/SCKkqUv+hwbpS/QYaEhWZ+OhNejFXD6/pFS0XTQiCPqr6VZxCr9mfZIx7zxXIc
         o/R2ywcltKT2zpPvbV4umsAOxWk+kmtg/oFkGM1QJxHl8CWJiuTYbFAfqsy5hQIaGlDj
         wbVPBhqpwr1iUvn2x7s4Eoj0XorZlMsYMm75Q/b4IedDrp3OQ7K0uae7fGouW61uX8jw
         PQaE7uexJ19QBDsVj8scnnusH50A7vs6j0AjMkX25ndtYL4v47JFtNPwhesDVS6RFBIA
         tPkgZKm8bDgDiFqwYXR3QhYtIBedkCalyzt5BMSepKlZCrwoyeyU30ntkC3H2FE8Z7f6
         /wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503568; x=1721108368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb1pmm0NzfzvlKCYkjSJOAkVlPjk8a1r8uay8brZ7Zc=;
        b=VuMfyqglLkDWhyDQdB6t2XQINAhGwVAzxxSDY8fgSkjH523QbKmsHa0l9BPkou3ZSC
         jpCYDvLgm0e6jSyE80gawc3AckDXDJt76QEULV/Zb871YNrCvC3EXxOum8KlW5KGDQgw
         HXA24D8pEGXqJtl97WtjGYnNzp6hyMKl2VCHW8DaWQ2yaCiGKrMIRagtrpWy+CscoEfn
         Ni5crIS5B5aUsEf1wmZjzLU634CkYK68IGZOQAc2v5Oscb30HdrE4Uv4MUKX47R01ERN
         odmejaZBb0vYtfPDLNt/jJb4hJV4cPKsoGglNmqK6PSNosiQW6Zb4lbTC+Xj7DnPkN/z
         nu0Q==
X-Gm-Message-State: AOJu0YylLfisEgEUGGdEPtNoTUe9CDia7Gz2wsD5RzTdHj3EgCEUq4mh
	UgbVwNy4ErHHV3aVC1FtC5+3+1+MApL8K2Swh1Wp3K5RjpaOmOtj9JFYQw==
X-Google-Smtp-Source: AGHT+IF/lr/WdSnThFgK0Z5fu6w9ViZGr8QkDgHlkkysVOGFzmYQ5ag6gQRx1dpNNmb0UK0Cn5WXFw==
X-Received: by 2002:a05:6e02:1a08:b0:376:24b1:174c with SMTP id e9e14a558f8ab-38a57213341mr20700805ab.3.1720503568103;
        Mon, 08 Jul 2024 22:39:28 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:27 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 4/7] t-reftable-merged: improve the const-correctness of helper functions
Date: Tue,  9 Jul 2024 10:58:43 +0530
Message-ID: <20240709053847.4453-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t-reftable-merged.c, a number of helper functions used by the
tests can be re-defined with parameters made 'const' which makes
it easier to understand if they're read-only or not. Re-define
these functions along these lines.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 85ebb96aaa..d151d6557b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
 
-static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+static ssize_t strbuf_add_void(void *b, const void *data, const size_t sz)
 {
 	strbuf_add(b, data, sz);
 	return sz;
@@ -27,7 +27,7 @@ static int noop_flush(void *arg)
 }
 
 static void write_test_table(struct strbuf *buf,
-			     struct reftable_ref_record refs[], int n)
+			     struct reftable_ref_record refs[], const int n)
 {
 	uint64_t min = 0xffffffff;
 	uint64_t max = 0;
@@ -62,9 +62,8 @@ static void write_test_table(struct strbuf *buf,
 	reftable_writer_free(w);
 }
 
-static void write_test_log_table(struct strbuf *buf,
-				 struct reftable_log_record logs[], int n,
-				 uint64_t update_index)
+static void write_test_log_table(struct strbuf *buf, struct reftable_log_record logs[],
+				 const int n, const uint64_t update_index)
 {
 	int err;
 
@@ -90,8 +89,8 @@ static void write_test_log_table(struct strbuf *buf,
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, int *sizes,
-			  struct strbuf *buf, size_t n)
+			  struct reftable_reader ***readers, const int *sizes,
+			  struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
@@ -116,7 +115,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	return mt;
 }
 
-static void readers_destroy(struct reftable_reader **readers, size_t n)
+static void readers_destroy(struct reftable_reader **readers, const size_t n)
 {
 	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
@@ -267,8 +266,8 @@ static void t_merged_refs(void)
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, int *sizes,
-			      struct strbuf *buf, size_t n)
+			      struct reftable_reader ***readers, const int *sizes,
+			      struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
-- 
2.45.2.404.g9eaef5822c

