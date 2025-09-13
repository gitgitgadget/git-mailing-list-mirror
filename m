Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECC261393
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796881; cv=none; b=RmC5C6BczK8p2yggATUNzGs1e/DJhYH72Pm9Kxs+e9sWbWQx/eYhffIFXdKktlAmM/j2rt5rlHDWo4aislRa/HrkjUMmKhfj79p9kNz4CrI8xVTKHhCXfdZAreY7M/7732BJEKWlLXr7AFVeZHYDcdNqPiRjFz7tJ3ZxBXTcVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796881; c=relaxed/simple;
	bh=HNsKTCXVXQnjQdgAJqBAH6WF1n0o6ZY6eQKb7uqT21M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCNRn9NMy/68FwblHO2RJwrGwIIUHgg2QHhWas+QhCgQwZv+B76GqZucueEIxacg2GmQiaKCbW4osJboyo13RY/AP0iF9dZkxkVbMljmpgSWzPvyfUkUyLJ/Qvh0kBd+BT3h/fEgW2asf7HLbKJ7b0Dpjp+BzRmevrrQFtylcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg6/aezV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg6/aezV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b079c13240eso488007466b.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796876; x=1758401676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKREtk2oSoLLPPHF+BJ9H9OGH1UTirl3rb/sP60BrW0=;
        b=dg6/aezVTeUzv3OxZsYT2L/G1gFZHWa5UUaJ91vc85kisxkIxisZiRTQjru+WGN0gc
         Mym/BRC+1MiuNqBClevCrYgJKKaoeE+it/FuhhyeemxLZjpCnKvsbYUrC0IvB0iDbcMi
         OUa4g3vF9qEEjIlEYv4OfPJbNSXLrSccPwA3OJ8M1fjSLZXu3g6viy4XlDA2zsKmpaxr
         io454qepXvRx4fvQwzUaMyaw2MbLyKpKbSlfgDYVcCpKiLt/hootb7puigALnAhR96iA
         au6RuNFObW7drHVsbnwqKbuemikxuoTiXHcRgLgZfJVAOoXN7ne5vGnqrrLNFtQUUuKC
         Q5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796876; x=1758401676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKREtk2oSoLLPPHF+BJ9H9OGH1UTirl3rb/sP60BrW0=;
        b=fVyD42Od/ZhEHJmcLCxukLxyrMQdBmE+qHNxo014VVAGkP7gc9iWPmNA3YCOMJW6V2
         KjVJLgsdHKDbZeG2gx1FQPiRuze332IHImMLNMhtZUwUmWmjNMoOxyCGL0pSeEiFXUZh
         3smojEYDK2HJd2mox4r+sZ2fqGyD0PIETY85G0W0j3Jt0sA0J8dChSDKwMov08HKYegM
         g42zay4/QYpK4TszYFsm03m2rftmQ27/2Wg4jdcaPe8Weo+tGbPmAJHYB8o4soaSbtZC
         YwFNFMN6Y31RfYuY8usNkgqVXivwYDFEWLVCSbYktSl2EXyT1VOIiCUOtzxlnD+TZzPK
         KTcA==
X-Gm-Message-State: AOJu0Yw6IDtclwFm1QDQxa3vOfullj8afPKohqmYgl0ldHt0ySz4hQ/r
	ZO4MA12pWrJfRraU6zOwQgtqNTZMSoVloFYOMaC+NYEgqWKB5gLMgUyC
X-Gm-Gg: ASbGnctTKKHmniYpl5LOzN8HLWeHxZpttLJi2PB1q9AkY27FX82TUQT6sNoRvHKTMP2
	dMkQTrxM8rg1Qfo4OidkFqtbhaI1x1GiJgRpVSYunA/o5sJOv1VvPDIQwyiuFclGpm3TTuJ8piE
	TncHXZ0TtjS8sIbz6wmd4Oae5gTwoixc82xyuVZsv/o+DS0xqip9UBjVSMqk8CJ7Ga4g3zXOG/w
	rmdZNbMZgdPVr5U8vpbeaSjHjEpePFAANuxQzHYru9oJOAWiRV2Z2M5PRLSDEGzND+KOUwLpWog
	cFjKfPMKxl9Chlp/LMFnXdNmgxbMw56L5MEkvpaVVDmL6U9xZeHKlioGNZVIt7h6BvPZuZ9jDL/
	zbu1AVR9W84X7NFcnWShb7BdFEIzeMMQYfMM4VCI=
X-Google-Smtp-Source: AGHT+IGeQv0cKHri12pVX+bBTBosjC8ZMsN91uoiBF+pg/X6JuQSHVvIcgY1jeEusG99yY42BPhF5w==
X-Received: by 2002:a17:907:6d08:b0:b04:26a7:f77e with SMTP id a640c23a62f3a-b07c3869126mr703470466b.51.1757796876503;
        Sat, 13 Sep 2025 13:54:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5b4f:6b96:ff06:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm635383466b.73.2025.09.13.13.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:54:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 13 Sep 2025 22:54:31 +0200
Subject: [PATCH v3 3/4] refs/files: handle F/D conflicts in
 case-insensitive FS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-3-195569740b57@gmail.com>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=HNsKTCXVXQnjQdgAJqBAH6WF1n0o6ZY6eQKb7uqT21M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjF2giLGcwB78z/Ug7jhpD7N3laVgq0vuMjY
 vLqkCcYcI2b0okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoxdoIAAoJED7VnySO
 Rox/jNAL/ii0ZUeBmaXvt3L3GdxN0fEqLjKi4kQ5adxT+4LJm1J3jUwFSttJP3PZMr1WH2Sd3mO
 maJlImq10DbvZjPadq/F8jRUtfT2D95Ye3gTzD9+KOPnL0ymiXnCuqSr8rMtoeECD5pDhlCS7/5
 0PKrPcyTNBPiTlsSinL9FCk5+gvHI7rKpDH3Eq6XQAooRntrBM7g6HaVIz++Jb6ulRib5/jju/V
 dRoI8ZDDyqU8gCx5SU2C2EZmrnaot8q2xB8S+vp2fbtDPogtDOQM6OtJv27c16ykhEA37RBzjVC
 GvScYglHHiU250ZGrkhUtoScJ494oSQNCsFez8eWnq8prEvjmtkQOKNjqiTHYz4ZemSLtBxjlVH
 Xb8MfC6r799K9cQSDee3xU3jCKgK21xdltwkL+LcDFM/NnSr0F+TK+8oLw/9FwbStJlc83F5cLC
 iUgOjoiZtMWRJJcVCGToC60acEHAKEmTF3NdxHrxe8o7BLoF3zc4LbutrmWW2yuvOLKifiglvG7
 Vs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When using the files-backend on case-insensitive filesystems, there is
possibility of hitting F/D conflicts when creating references within a
single transaction, such as:

  - 'refs/heads/foo'
  - 'refs/heads/Foo/bar'

Ideally such conflicts are caught in `refs_verify_refnames_available()`
which is responsible for checking F/D conflicts within a given
transaction. This utility function is shared across the reference
backends. As such, it doesn't consider the issues of using a
case-insensitive file system, which only affects the files-backend.

While one solution would be to make the function aware of such issues,
this feels like leaking implementation details of file-backend specific
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
index 69e50a16db..817b56f4ce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -905,8 +905,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
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
+			item = string_list_append_nodup(refnames_to_check,
+							strbuf_detach(&lower, NULL));
+		} else {
+			item = string_list_append(refnames_to_check, refname);
+		}
+
 		item->util = xmalloc(sizeof(update_idx));
 		memcpy(item->util, &update_idx, sizeof(update_idx));
 	}
@@ -2831,7 +2846,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_DUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6f8db0ace4..08dbea6503 100755
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
 
@@ -1572,6 +1578,20 @@ test_expect_success REFFILES 'existing reference lock in repo' '
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

