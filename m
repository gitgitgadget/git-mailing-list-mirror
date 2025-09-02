Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D22E9EBE
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802087; cv=none; b=lPmQtUxVWMi3EJmkXMARA1aPGQMSXcNymVdec14R6ru4hDK1TN9wT/AqdyuZwQrcpUm6fU/5xyyDkVXx/uhV7lLLZJuPYDGjPIKLeqDnLirmEikDvJZcSq17KKWiRaHzA7zbDbSuPB2iIZNgfsl7i4UXuvTAyapT9JAEHfoPUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802087; c=relaxed/simple;
	bh=/3jkdz3WFLf7j4W2qdsl6IiU4zfi2c55QvWAYYf51rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDSrnKlBRFEhmZsHqZN7FLVyF1bDhnHxHbNvmsTWn+MeYDD4BUMV6Ci/jJMz5al/LUWv15sjy4MpYl5I9L2M5TMnCdBuYhkePz6Q1vjWlVvo8qUQl4SHaHQlz/3lPgwgJsAZpRzeqYzbnJOT7YhQhqH6sD4O8L5iRE3VM4uVlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKItPqyq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKItPqyq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0449b1b56eso104697466b.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802084; x=1757406884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uE1LBptDhczMeMbPC6NapSzySd7qpoo8etCiua8VLUI=;
        b=YKItPqyqan0lIy/SvdtSxw2QSPYC7LKVw8AvyHo/h6r+afEKdsO8+3QK+x6t2PQ4Ab
         BrstIk0WUHAhtRPijqxHQxFR6/Jhl9UDZZOHFcTolTTSkydAGpSuHnS3fFL3kL2V/fc/
         ISkczg/hM2kyDXQGfylOcuvWyC6g5BurBnvM5Uw2L93TxngfDD/sJjz2OwiCaaIhou1O
         fH6Ee8AsSt+ZFDkSHnoDzPVg3tCDqBC2QTSdR3RrkpU6BTcawyCTNKvSOfb18MXvQZw5
         zrR0s9Z4qli4Hv16GKSbAdRun0dBBwOkW+dtLDp4xzrfaKa5NypXKWWYck/mYvuhNB1l
         e8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802084; x=1757406884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE1LBptDhczMeMbPC6NapSzySd7qpoo8etCiua8VLUI=;
        b=oxYSXM4KDzKDJRgHZ3iNtnRfxqrbOwVkqryRs4HGmXpU2VJAtHaxPRcyEXFzFuB4pJ
         WxAtY3tZNKq97NoNwzJMlSuHDaaVnDGUtsfbkwiAn0RSXXj37hOzKYYtHAzVxHINyqS6
         rTWF2u5ZYDlzSO2dUDY6ZAO5nISMD+Uj/qcQmuleJ91Ur0ftGJ8+AO2CYyVu2W44nnfj
         7ejBVLcCFsekYlIg0OoIyzSIxJX027jkR+50T772jHufPidCU05cZcMFmPZfp3Y+0Tao
         ftOcf+Cmz5HAdSPAyxqBid+b9G7RpfwvKzJDu7KbbHYndgGTrv9+yqY3YMQ9agBrJt9h
         xo9g==
X-Gm-Message-State: AOJu0Yw92Nh65hHU/5qalHjllPUVrYjrg6QRDQKgP/21TP4LRfrBEo38
	yilih1ue67eB9hGpfeTIXGftxfvCNeC2e3DBgfR/DSqIZYLIAaVQYhOJ
X-Gm-Gg: ASbGnctbUhgmOpXB227QpFd36XMFvb2yKwjK7HhgKhVYe2V+GOFFZIkBDp6/feGst+1
	VZ68T4r6N1ODtL994//vAYjyEfDY62EwlVsCtMgguZSp6idVfWZoMkfJ5P54SdXfFGQHGKtseO1
	kwb4dWxv2DYNhMRutknbd1k/SIk6/D5RzJFo/EH09rewc4v+/rDVwHofMQDy3ce0iNUR2AaklA2
	brXnmmcbpjtIGhPfmOphXl9rWcxIY4G+ytAAjv+H9wJiH+kagPgxhJnsES7pM+6yZWtvkSDAay/
	WwgvC2mtAn7aKLAqjn9cOKHaGbjkKAI7bKaw4RpepD7kwFdaipEbuHGnkk5jVBRE8zch7Gj8hs0
	cP6iB5oG+UQfu5Xr67+ZBbJKPiDXOVLTE5qn7m1M=
X-Google-Smtp-Source: AGHT+IGfA/IXjT7FPE7NuEBM7lVuG1u5nwsZ3FN8E9WB6WBdkVBVcbSRtyBBE/G0k5WjsXHNSK98iA==
X-Received: by 2002:a17:907:7f89:b0:afe:d62a:f053 with SMTP id a640c23a62f3a-b01d8a322c4mr1028584366b.10.1756802083803;
        Tue, 02 Sep 2025 01:34:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:d13e:1f84:4afd:ec5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041800e89esm594785366b.30.2025.09.02.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:34:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 10:34:26 +0200
Subject: [PATCH 2/2] refs/files: handle F/D conflicts in case-insensitive
 FS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4323; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=/3jkdz3WFLf7j4W2qdsl6IiU4zfi2c55QvWAYYf51rw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2rCAE3MeyGi+AGgM4ShkOPrz4DrxTjZOCa
 u6pVQ4MAYLwC4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotqwgAAoJED7VnySO
 Rox/a50L/iCfSDk2E1m9aG1ktomzBrRL4nfMa9XFSkF5WUKE2T1gIU++tYjaSCAecFyk5iwX8h7
 I/a8lxTRrP/QKqZRdHn56VQlOgpKKvlebM3zL5HJkc03x5E3F4rkYRQGn3q0rVbCvG1udQpDCKn
 NOEP5WCgi3IrtveZ0LA1Ub8Um5oo5mvKuSI4kG2Ay2Da/XmAnqxNPBwXlipgyJeeGwZ0/pzz33H
 4A4D5Dr66u7w8X3+AKYBcEneCVGmxnV2pw5/Rqx8BOlgTlSvRos2wl2iegNq/T3zyYWmZiH0u0z
 6cqcfCylccs9SmZRAjArnmOWnRZVoZKpTdsb5wKcVgWlw9rrcbhv7XMRQOpZVPoS6S16i2R7xQC
 SPqoL+iHOapNjEOwE8TwJQvcSjppRH5IFloCzXt5dPepQF/tePHvboGmsN7KQO5yQ6m56N//p41
 aCraTIdxxe2pntCCaXAEZftXnaiv2u9fCFz3VFoi9xN3BdYERyl0fXcPJfN+9N4oaQDz4TcZbk4
 tQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commit, when using the files-backend on
case-insensitive filesystems, there is possibility of hitting F/D
conflicts when creating references within a single transaction, such as:

  - 'refs/heads/foo'
  - 'refs/heads/Foo/bar'

Ideally such conflicts are caught in `refs_verify_refnames_available()`
which is responsible for checking F/D conflicts within a given
transaction. This utility function is shared across the reference
backends. As such, it doesn't consider the issues of using a
case-insensitive, which only affects the files-backend.

While one solution would be to make the function aware of such issues.
This feels like leaking implementation details of file-backend specific
issues into the utility function. So opt for the more simpler option, of
lowercasing all references sent to this function when on a
case-insensitive filesystem and operating on the files-backend.

To do this, simply use a `struct strbuf` to convert the refname to a
lower case and append it to the list of refnames to be checked. Since we
use a `struct strbuf` and the memory is cleared right after, make sure
that the string list duplicates all provided string.

Without this change, the user would simply be left with a repository
with '.lock' files which were created in the 'prepare' phase of the
transaction, as the 'commit' phase would simply abort and not do the
necessary cleanup.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 19 +++++++++++++++++--
 t/t5510-fetch.sh     | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9f58ea4858..466cdfe121 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -869,8 +869,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		 * If the ref did not exist and we are creating it, we have to
 		 * make sure there is no existing packed ref that conflicts
 		 * with refname. This check is deferred so that we can batch it.
+		 *
+		 * For case-insensitive filesystems, we should also check for F/D
+		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
+		 * the refname.
 		 */
-		item = string_list_append(refnames_to_check, refname);
+		if (ignore_case) {
+			struct strbuf lower = STRBUF_INIT;
+
+			strbuf_addstr(&lower, refname);
+			strbuf_tolower(&lower);
+
+			item = string_list_append(refnames_to_check, lower.buf);
+			strbuf_release(&lower);
+		} else {
+			item = string_list_append(refnames_to_check, refname);
+		}
+
 		item->util = xmalloc(sizeof(update_idx));
 		memcpy(item->util, &update_idx, sizeof(update_idx));
 	}
@@ -2796,7 +2811,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_DUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 57f60da81b..84dc68e5f3 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -53,6 +53,12 @@ test_expect_success "clone and setup child repos" '
 		cd case_sensitive &&
 		git branch branch1 &&
 		git branch bRanch1
+	) &&
+	git clone --ref-format=reftable . case_sensitive_fd &&
+	(
+		cd case_sensitive_fd &&
+		git branch foo/bar &&
+		git branch Foo
 	)
 '
 
@@ -1546,6 +1552,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive_fd &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "failed: refname conflict" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/foo/bar >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

