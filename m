Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAC30AAB3
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598839; cv=none; b=s4JmF1RL6mYnPefD2QlHwSmD8Fp+46/rkvN5MV//Zl6I7ACNBNfs4zVohG+VrbfnYxqMfEjQPpWBGahmMGGiyo9UItAQGOwzD9dxFVWb4zMHhiQ4u7K+2v+WuWhVSQRMflpjS8fj927kTAhQG7NNBTZA0ykwqnSK8qTUx2zgflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598839; c=relaxed/simple;
	bh=wv3Ur+P4oXks8vKU796VlZkPmJadl6J01y+zjlIdhZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bw/0hcUF9cMBq+ePGDEin+3qm5vQcmCZsHpdB1Wdwa16soPSiKHf3OA1VOsHtCV8hpc78rK+bL8U8pcjjQ/+CFGpkf/rnaCQFhS85Pd9aEZ3xylBWTw9jf4NdxwmLY7Q/8a8ls5dQownwJvLeihwgh9rbgDCAlYr8ZVe+A795d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty7HKAt3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty7HKAt3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so10325095e9.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598837; x=1769203637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7GPScBVSStWY5FuyUuy5LXa0II7eZiBZWTbPV4c3lU=;
        b=Ty7HKAt3gTKCgqUOVCqjHzHPH2cPlzg5tMpBt0qPizwmOWCGU4aU0ggXt5jFS7IWFC
         mynvcVYp8BGPbIzz5PBcyOxN4GftHfxEqWxBbvEHlGJvMJt2ixPQSzF6kYGx1iqcDPd1
         3+eCLPlBPJn7m/U28R9qdlkTajlqVpB9JZwO31jTRKae8O46VbHjxBNTjQFKoA17Zl/Z
         mI+HnBwcqblp/vnJGWSVajZkC3stp3H1DgYESmhM1prFkGy1uV1yHu+Q6297IDK5y3mV
         ipRFCR1fifujc0YKcNy0Lz5P6a3oqUO/pOloydJXLNKtlu/Rt8k5yRMmcQ8tAwmGRq7E
         32zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598837; x=1769203637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7GPScBVSStWY5FuyUuy5LXa0II7eZiBZWTbPV4c3lU=;
        b=mWyz+1b2tSjlKkjdRB4GP1lHZDE4S6q5obJLZFEu0TH9p5L3KmTxSHzjsv1lUbDKlW
         WfoU1JI9RqDkC2xfWWj+6K1NX+VQOKqAU9FfgXhqQOMn5lrgQA0EcgOx5jLePbiLbUY+
         FNw3QqOeCDdS0Nw3pHUHQTuEVHi0ExSexK1XtDZA78GnmCMjhvBzZ7hMVbSguM/Ylqs6
         4j7sEJnj6t9HfJ1WegjbuDBpsRF2T3ez+5fFABpDhrHyPNCk+g1Z/yk8mh7mCEpOcwX1
         k8VVX3KN5hZzbiE/lK6agiL900yjpfilEUCsRX7Eh52NW/YGeyNCXXwnFqg0UL8I70Ww
         Yfag==
X-Gm-Message-State: AOJu0YxXSjNCecdFmW757U2I0avz+HEmFff1/9Cy5DrBqR+zrQ9znkdU
	d3EKMjs3avqUJ0YdvTqy5D0TAkKwktTdDUvy1pGHvpPmOr0NzIO20WMx
X-Gm-Gg: AY/fxX5WLfY6fCOdNltdVOxqCoZRHPWJW+cEneptewcx2JeF/Do7W40+PjjVzllRFBe
	PS7tySW6I7u9qISTSqT1jJUMkbnvgRLkf4RqwT0prBK4RV8PKPlAe6j1rtEUFw1uRBrGmVTgy3Z
	ApHaNutbwpLyatTIaYGzya0jqaEX01xoov1jgbs3XUEsqLU/SHLBaf7DAOGW9JaMoQUT49fptSH
	fFiTzExRMCwUszs5oNeoG17sgBtNniTCM+J1b/g/wGIpQaFeE2VZBauKesOthPugHAp8LLva4Ld
	pRobLVL59XsaYCmxlpApv+ANlH7MbJaYsVcoJZ5NLHLch6rRZPyfRGd9NjwfgjlV2G2aN9upK5h
	++VBeAeR5dADElJp7N+E2DNRaoFTkdcgsz1T1oOpcYgDQyBB82ZN8mB1O8BBEqNu/455/0Ae83y
	/6Ibpl+xPV6ObsJX16udE=
X-Received: by 2002:a05:600c:4448:b0:477:b0b9:312a with SMTP id 5b1f17b1804b1-4801eab9db5mr45214525e9.7.1768598836504;
        Fri, 16 Jan 2026 13:27:16 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:11 +0100
Subject: [PATCH v2 6/7] receive-pack: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-6-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=wv3Ur+P4oXks8vKU796VlZkPmJadl6J01y+zjlIdhZI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS3y5JxJvQ+VoD6woW+7bjDTS5NuSYtMy
 A9jEoYjoeT2ookBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/XOEL/iYEUqGJLwCNefUGSZDslFTDCALl8ZPb7iS+okBWG4n0lZf9mujn5MnISDvmVgVN8f6
 2182uwOKuYt1L80mYytndbPe8vBc59y/1KJ0kShchsx+NBwEsqP7KYW+krQuRMNbMjRwxLpgeTf
 NfKMTNd0+vkvL/Pj2drTzNaIpkK38FL7A2EHBxlR1bAPLp7cIQRVbCDzZOQHrthX74YS47+XAUT
 KYNH2OSetcpPSSR5s+4gngYvXDfqOG+RBxYXWIEENKfx5/aeuem9SXDo97hObOasUjV6p9rF7QO
 RGON4EYsaockF6gE9x2GanYlKWcuIegskAu1dtpcwSnLlw0r5LqzjUN6WNdOlpR8taobAyxDhed
 8ickl6H9iiVeDRf1Agktb/L6dcUXzvfA8Dtxcb+Z3NaJzr2Q3PdDINB1/6xNElM64hGuNXmaYua
 YXse1rLCIcJxXg7UzEL1f0KI39qoraMKvmH5B2VwzTbmNmA+LlK+ZfcRD7cYRacUz+Ia77j6z16
 aM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19),
git-receive-pack(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Now that the updates also contain detailed error message, propagate
those to the client via 'rp_error'. The detailed error messages can be
very verbose, for e.g. in the files backend, when trying to write a
non-commit object to a branch, you would see:

   ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
   branch (cannot update ref 'refs/heads/branch': trying to write
   non-commit object 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d to branch
   'refs/heads/branch')

Here the refname is repeated multiple times due to how error messages
are propagated and filled over the code stack. This potentially can be
cleaned up in a future commit.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c |  8 ++++++--
 t/t5516-fetch-push.sh  | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d3e73cee..70e04b3efb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,11 +1813,14 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
 
+	if (details)
+		rp_error("%s", details);
+
 	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
 }
 
@@ -1884,6 +1887,7 @@ static void execute_commands_non_atomic(struct command *commands,
 		}
 
 		ref_transaction_for_each_rejected_update(transaction,
+
 							 ref_transaction_rejection_handler,
 							 &failed_refs);
 
@@ -1895,7 +1899,7 @@ static void execute_commands_non_atomic(struct command *commands,
 			if (reported_error)
 				cmd->error_string = reported_error;
 			else if (strmap_contains(&failed_refs, cmd->ref_name))
-				cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
+				cmd->error_string = cmd->error_string_owned = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
 		}
 
 	cleanup:
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 46926e7bbd..45595991c8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1882,4 +1882,19 @@ test_expect_success 'push with F/D conflict with deletion and creation' '
 	git push testrepo :refs/heads/branch/conflict refs/heads/branch
 '
 
+test_expect_success 'pushing non-commit objects should report error' '
+	test_when_finished "rm -rf dest repo" &&
+	git init dest &&
+	git init repo &&
+
+	(
+		cd repo &&
+		test_commit --annotate test &&
+
+		tagsha=$(git rev-parse test^{tag}) &&
+		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
+		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
+	)
+'
+
 test_done

-- 
2.51.2

