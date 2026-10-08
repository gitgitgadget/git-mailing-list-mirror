Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6F346E5D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497449; cv=none; b=bhjRQDp2tbo9is2wswAXRKTipUpGSzJhx/Ovumrz+G6Ad+x7diWmTWDtzrla7now3BuU/p68QVuwYM3O7aUrWl5PuyFoG9ax6KWS4/QBtVr01ig+wDBinIAWZhov7UpQisi0zuSQofoyoav0b2viBMCnrCXxDiySBIRWD1jg8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497449; c=relaxed/simple;
	bh=G9qcreXNjQmtlaNeS8tyO557PX7vZOzgN5VObOVOjLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CJ7IMprrxokaNu2SF2axHMH2pBr1jlCNNQ9vqyW7+KenrKOMqHMHUZL85NmlZ1CrfIO2ApSmZzkStWg850tam6U3SQWlyYTRi2xYH2XYX28X0iUT1fBltZ8sPl8DIcyz/7dOKX7wmicDmWW0Z3sW9OddX99gDgYMJwgohF1kssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw5RQp80; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw5RQp80"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so29774425e9.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497446; x=1792102246; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4L4yfHpA/INvRku63kIJvtYZ8VRNFjPE0pK/Ney4Pm8=;
        b=dw5RQp806BkJbwS7DIRGs4QfcDgCZpg4zqx4M/m5LyK/5brHqCzotFxjzxZDmbYmjU
         3Eu1Mf5G8nX7KlIgFGjuWVjJVQD43/R/Upyv84YJWEJ8V2EVdXzMs/V0AunZt/k0bLlb
         GPftdXvpqhFED57FfrXGVrWrFlfBs62fED5KpRu9MBCqgj6D7rg8tnkxC+Oh5v6uUZXN
         ZmMqjR/Fr9pHm6lE1k1jFFWB8T/N7WCcwn9AbHyubGrqmAczCYZ0EWT4eDch0mg45Zoo
         NnK/iLquSOLJWlf+l9JiN5QUfJpQnaiCSGttIkOWx1qebOB+PtIe+DeZwPZHkykCfXaw
         9jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497446; x=1792102246;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4L4yfHpA/INvRku63kIJvtYZ8VRNFjPE0pK/Ney4Pm8=;
        b=FUHj1QpcvtRjo+xHoVLuTVneJuhZhskuJfFibGv/rBvCeiYJprC0gZPLBLjxDeovpV
         e//Dl6nZ000cQsYTBuiliIZ3rt6Kn/11I0Msp8eCkBpGsAe8NcDF44bnB+77mKsbovDd
         TWB8XZOWay96ptlW/z7h5XnzL8gcmIH+p5ibriqBucBffixwpcaMzGyeZ8OPHLnFhKvp
         Ig1DK7BPa5oAK3aG3ab1R/rm8Aryt1kl06rtjH5koTZ6PjjH7Ak1UvP6PSWiyxw3DrD0
         aWthWg3ijd+e+CDFKwgyahZhBgCLA4ayD++5+8DHVeIg6HhYi54VM8dV5geu3EmmlI6n
         kYHA==
X-Gm-Message-State: AFuF++ltIgfmQ1heOh98bVoqkqA1dj0VNwugIT8jblXNpDIsICNghhsZ
	4V7vYMVtTVLZ2sfkPTtNM8gWYGs3+AAufSsO1x0TMDhxn6YAE1quNLnzF9ldGg==
X-Gm-Gg: AYBFou0581eSAa0U5+qsKKmqId8yFhAT4DfBI7OyzHgJnzkd1Fs6dzg/DGH72LzhA7n
	P7bgxqa8OWqn/RjG/2ow5AjGr3sg1WTGCZxcm9BSb3v6haH+B/+SWeWub1lhsoslTEXocCCrPE1
	K4RzccU9V30cZmzZ1x75LBtZHv4cuiav5AJ17p8MU7KizrzXwlNNQj3lbCXnulMTaifLR9WQ1rt
	fIi4iPrbr/vl8nAH7WBk0yYcqI4sviX5PlLSxkc3KfV4NvtQpRP3ChwKP41tPIf/lRRaNbI9MIY
	CCLjngtFcnWITgGkIXXVj7FTx55T2Of7cCo8u04B4Gkb3NW9nHjMbltYZ6FPk7T64QXdPOz2K0l
	5SZBUL3CE1mvrMkXuDPhXEnCMXQGd045FjAyE1zmhjz1Sg55y2Oq80UAhTFMSwM4rvNoXtfQgas
	PvOuhwKmEtw+icgMq4qA5mlx5QBQvfDtOvkwOOcxf9CzCsjWcHHAvOufamnIwclEjfBZV/yLhz+
	O8e3MbHVbLhuKdly5nGAs/IRd81FSAwLx+uMw==
X-Received: by 2002:a05:600c:540f:b0:49e:6249:268b with SMTP id 5b1f17b1804b1-4a180648fe6mr124184945e9.32.1791497446368;
        Thu, 08 Oct 2026 15:10:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e3c6:3c82:8122:2772])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bbaf68esm30272305e9.4.2026.10.08.15.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:10:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 09 Oct 2026 00:10:37 +0200
Subject: [PATCH] fetch: commit references fetched before backfilling tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBAAwK/InrsQU1DSr0gPSdyYLaKSjVoQ/
 25sj3OZA4QSk8CrOiDRxsLzVFA/KvDRTgMh98WglW5qpVpsjUGJdhznHQNlH3HnHDHbQbBvtHt
 ScNoEBWVYEgX+/vbu/bes7kM+3yWc5wWbgu1dfwAAAA==
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
To: git@vger.kernel.org
Cc: =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=G9qcreXNjQmtlaNeS8tyO557PX7vZOzgN5VObOVOjLQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrIFOV0Y5wQwICqAKXpCzSfB5R8KeqhnmJxD
 KlzWUefAEA9fIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqyBTlAAoJED7VnySO
 Rox/6sMMAJ0hHqVlGelTwvk9RhzyPsxZvcdok150vJ4mRHTabYjQFH2NvHlymo22JC+FKBtfs6M
 gZ0Qnn5/crz2fhG2aT8ahDDyF5J/txlrzDkRM+7MHqGyr4JGqebDQxsnNJFLUToaaC3AwgpH9no
 tur9Uo04cMomgnTPO/RxvVgPZMKZcRHptD2AneRioSH2vF2BhalbGH8TmsURMiC/3Ect/odXVuo
 NHBZ/5FiuF4tg2+W3tt0pmdvaeKgFUc1AdaiGJjE7mwqBG110wRGDQpSgS72eQIv4w44g11JEe1
 WMcy7FSMZGQ1wa138i9TwGb1iyYxWF1XFPzgA3OBObRiZpMHN0ZCxomSgizRY9zepVlEIx0N1bi
 E6hQQm2pv+6fnPEyb99k4orTHMn9itiNnOIfRB9BnUdhrNdI3mqj+kKaecBD9VHQJWjU9FJSy98
 q94ftp+0526AuMUfsHFlDiSF76z+dd0X0g1DuTui5BHynePRedr8YCFZEu5XxKfeBfO/GuejYQ5
 Kk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
fetch code was modified to use batched updates to provide a good
performance improvement. Wherein batched updates were used to fetch both
references and backfill tags.

When using batched updates, the references aren't yet committed to disk
when we start backfilling tags. This means in situations such as shallow
fetching the negotiation during backfilling tags, the client doesn't
have any references to report in the 'have' section. Since backfilling
doesn't use a depth limit, this can cause the server to send all the
objects present in the repository.

Fix this by committing the previous batched update and initiating a new
one for backfilling tags. Also add a test which captures this regression.

While this does make it a little slower than master, due to creation of
two transactions, It is still faster than not using batched updates:

Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
  Time (mean ± σ):      1.468 s ±  0.041 s    [User: 0.839 s, System: 0.587 s]
  Range (min … max):    1.427 s …  1.558 s    10 runs

Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
  Time (mean ± σ):      84.4 ms ±   1.7 ms    [User: 60.9 ms, System: 25.8 ms]
  Range (min … max):    81.4 ms …  88.6 ms    29 runs

Summary
  fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
   17.38 ± 0.61 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799
---
 builtin/fetch.c  | 21 +++++++++++++++++++++
 t/t5510-fetch.sh | 17 +++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..68b04d0f8a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2076,6 +2076,27 @@ static int do_fetch(struct transport *transport,
 		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
+
+		/*
+		 * Backfilling tags has no depth limit. If we don't commit
+		 * the fetched references, the backfill will report no refs
+		 * in the 'have' section of the negotiation. This can cause
+		 * the server to send all objects.
+		 */
+		if (tags_ref_map && !atomic_fetch) {
+			retcode |= commit_ref_transaction(&transaction, false,
+							  transport->remote->name,
+							  &rejected_refs, &err);
+
+			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+								  REF_TRANSACTION_ALLOW_FAILURE, &err);
+			if (!transaction) {
+				free_refs(tags_ref_map);
+				retcode = -1;
+				goto cleanup;
+			}
+		}
+
 		if (tags_ref_map) {
 			/*
 			 * If backfilling of tags fails then we want to tell
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..81865c1ecc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1942,6 +1942,23 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success 'shallow fetch does not fetch objects again for tags' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --depth 5 origin &&
+
+	test $(grep -c "fetch> command=fetch" trace) -gt 2 &&
+	test $(grep -c "fetch> have $HEAD_OID" trace) -eq 2
+'
+
 test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 	test_when_finished rm -rf base repo &&
 

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

