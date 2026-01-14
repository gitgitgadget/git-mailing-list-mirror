Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA913A0B03
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405272; cv=none; b=dUe8FWj8FS2YTKGPZhGZP4OHQ2jSh7q1G1WLpGX7zlXl0wjW4cM4WKFEYOZQcJE32AEkRIsHzLxwTQHsAzzjxwO7MDx0U688zOO0AMD69O+vL/+UevRQJ+EeY45/CxjjXS+nbjqYrwq/Z6VtQihYzKC4RybFbpnypzCydDGUghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405272; c=relaxed/simple;
	bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7l2YmD0sVQvD3Nh+CrAgcsYAC6mSRBjOUK8iNLP4kDL6njlwBatLlmI524syfAmsKiiULF47peB49oxS0q9bviBQlSWzf9U6wE+8qXQli/ap/KZk87T4Z28FKEWy6NtpBJxX6KCQV8hQKJiFCGlBsqQJE8arAkmpQoQEmVVmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE6t6zUG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE6t6zUG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1861692366b.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405269; x=1769010069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=LE6t6zUG18zTgYbdc8IrHZG8JJs8KD45nCRMP1npQm3y90qnv2CJxdxQmz5e/e95HP
         AZtfaT1xPtPolqi6wzdYQOu5BAk/J7xniMUKSDIjUPjzrPPIj9yMV8x72DCYAeg/UR21
         SfVKVMs/lRhiTVVfOkh+yZma/ZsPWX9CQgDFItuzUF3t0HIQXAFmnGAnhhaK3652kJIs
         inoy7VtF650G4XF9sX9S9+ri60QU6k2UKQsZCeI84o2uFERdLKxvmoOQ/o+bF1ET/eFV
         dXsCXUc79jgyH5fnXY1Np52tf3V6myzR1ZUS150SuV9d3wD2k2PWz1i0JVgZt5bMhqk5
         Lzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405269; x=1769010069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=OF604LdEUPFbkn+2FjLEkNujUUmQQ1WrzT+KyfEaeiuYnB0b/Hbftc1lkybXblRIIF
         vI1Iax9eI9jBKYPA9qiVN7RvdRMgq2BuTTQkYRQURQ5ABWkfxB3W7NggbOviSkpSEKkM
         XisEw2E+BpiUr/q5anl3VdELyOuYZosXeR5DmvhNSK/535lYDTdLZ9itxBOwz7N87sQQ
         011hD7Lc/pX0cbBheO6m/Ck9JcjNPCe1UR50Nkzzqyzr5OXdVvl9dKJxzw0TGQT51z+0
         U4DlFtl8Q1fr55a34FrEBAWNLQbtjcMZTm5n/83EzLWPFBete8ZZ8PYhZcFeRX1XJo1T
         6K3g==
X-Gm-Message-State: AOJu0YwGjd5DK8qeKmSbU7x5oEfanA6gIxYL5wf8bNKFQ3J0Y4QFwdaf
	CT1VicYP7dXQNwDQED9ZrBLQkT4EF/8Cvwmrz9ez5A1T+HmdlBBCt0N5
X-Gm-Gg: AY/fxX6EaF3YGQqp5Y+3ENHKe4JAeupNXasylfcMoiqf+TWJuCXSjt7l2igIM+UvxVM
	nHsPQGnfo6a16EJI4wbrZ0rUb2WB1xXWCSItMl115K7OAxzFHuu9vZInO6b/OWXdo/pEolbL4mO
	aWh7j7rDYV5CqtOb4zKLJEdvFhhAojbuz0OYELHfPDaLWeN1m1AQZ6kgFIA1/5O0lICKfNrwjyv
	qgeunuaNx4xqYg0KFvkYbJvw6MIYx07yty8cyZlT1b2KEij3xbun/W6Oe4qKckCrSvqJSrWRoUm
	/WIMXGH6nvFa+bztTJIkUJD/uXyxuLXAem4MVrcgS9I9tR7osCpY8ZyhFpiRv2+4zfO63r3lETe
	JNFa57VCL1Jg+vl/RRnIemAeBB9OBmPFko43ECAUiFmOPDfcOSlbCs1SrpAfpG6cswcB5Y7gcCn
	hTB31ul7WDnprpfDJYUbA=
X-Received: by 2002:a17:907:a08a:b0:b87:31d1:4131 with SMTP id a640c23a62f3a-b87612dc12amr261646066b.60.1768405269254;
        Wed, 14 Jan 2026 07:41:09 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:46 +0100
Subject: [PATCH 5/6] fetch: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-5-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ8PUCewS8LwfG/R/Kc10XA+nL8Qb1vmJ
 rh5T/IXkDwcQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/syAL/ilaE7eax0Fe28+Rud1F4ZQYh4ctUV2vnQfZB3ybO3Ty8jvwd1It97JRKiM3IZa1X2z
 NKRhD0fe3MNk3tDn3wHBWDOaezYAG+JTVuI2fjtQtDesh/y9W13himFnq/0uxHNP5ufrMsXmMJo
 rP1PnCGGhl/Mg8XL6HogJC9m4v04aHfCoknHU8tQx61uQBUJOpkLVcy9ZjTXCIe2Jbf7Jnbkgex
 bluC2R9HsxQ5hOpriqUZiPQc5KX7JT7AWRxtnsMJ1LjL7gwFefOL9STTq2Y3vaC9ee9UxyihWhA
 Y7mNm9bMVoi5P8beJFI4+ooAO4VRvv51BmM1buk4tmPUf801g5lm8xte4I9mPwW/Ybfh1MrIy8/
 39PQozetqv0RFEOnBM0Qi2G8GEeHHg0NkIIHa4gVy88k6//E0Jb+m6+7RiTPbnutGf7DmWyWcsq
 ex6gMF8ypz+NAbKFc24/najjNrlcIHumKBepO07YklsoyxY6YK+FPR0r3spH345GtcNRGETaQB8
 2k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
git-fetch(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Similar to the previous commit, switch to using detailed error messages
if present for failed reference updates to fix this regression.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 10 ++++++----
 t/t5510-fetch.sh |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d427adea61..49495be0b6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,7 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
@@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"branches"), data->remote_name);
 		data->conflict_msg_shown = true;
 	} else {
-		const char *reason = ref_transaction_error_msg(err);
-
-		error(_("fetching ref %s failed: %s"), refname, reason);
+		if (details)
+			error("%s", details);
+		else
+			error(_("fetching ref %s failed: %s"),
+			      refname, ref_transaction_error_msg(err));
 	}
 
 	*data->retcode = 1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce1c23684e..c69afb5a60 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/branch >actual &&
 		test_cmp expect actual
@@ -1530,7 +1530,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_fd &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot process ${SQ}refs/remotes/origin/foo${SQ} and ${SQ}refs/remotes/origin/foo/bar${SQ} at the same time" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/foo/bar >actual &&
 		test_cmp expect actual
@@ -1544,7 +1544,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_df &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}./refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/Foo/bar >actual &&
 		test_cmp expect actual
@@ -1658,7 +1658,7 @@ test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 		git remote add origin ../base &&
 		>refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
 		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
 	)

-- 
2.51.2

