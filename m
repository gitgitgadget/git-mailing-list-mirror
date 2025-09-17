Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB1362074
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122730; cv=none; b=uZceuvvzuN2PRxmGZ9gFgEttooFUMSlLputRp6Z3QvScpyY4GNF9+9TCYZ5sGcVjvEvg1+3xSx8o7YtR6pNy6Xn311K7hjIv9JP0QZx1PoeLziM+pbVx5dOIQfRnPUq4dkXASvqMbbylpfPjkKeBJ3YFoNBgi751EG2Sl4xErxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122730; c=relaxed/simple;
	bh=iVp2tGka37Z9uuWEYawAiIueKJZHN8Wu26/8nEXn5Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZKEs1OxL3/GL8TVWaXRuPfOWY2+Hf65XdBI196x5qxOzpeTo4CdGjTs/iH6SYOuJq0/VInC5zwTDZWb4d6cgawX8G5P/L/kOjpLphWqx+xr3O8L3sRU/phIn+hWJh3QIGN1LB5Ut6Be71xgY0JXfHJEcH+7u7XiGNErspFcquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO2sY7aG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO2sY7aG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07e081d852so791911066b.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122726; x=1758727526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qinAQEvnpOf0Um7tC3qirAOjBie/EclZt0/3Qeo408=;
        b=iO2sY7aGK/Ec7HI1Pl49TSefzMLDBEyzv3iuAWdpgCp6Je7vjPZkJujAXR6Kh85V7I
         ERlo+VEl84bSyPeW93c+uiasbpFHeVp9FYtwHhkiC0MuuEcfsUH1ADn0HAql1cCvLAin
         Yb+r7qT3iJZrVXzsz78Yv+Z3JnDeL2Fl4/dGXVw8kgFq4WWloWFpQlx9/tLLOcRv8Xtc
         wUtBQckVm6vaL1sPQc8Ol6GkGjoWxgXkLNH5dzmfBJv6C9bLba4jovYuiAfjcvJTw1jb
         1dER36Sy5rMzxHmjiscEadwIi0atSjG0FifgwM/BabYMDt6bIZiag/1TMooiJkzm+fJV
         mMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122726; x=1758727526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qinAQEvnpOf0Um7tC3qirAOjBie/EclZt0/3Qeo408=;
        b=QF7p4DIkU54RlZbte2YH61SlE3eJds8x38YO8mcdqaxOZPsa1QsCrBjJVtufEB1ZRd
         PH8SbkCbX0s865re1XE+ZTtONDldH5qsmseaKN5ocVcAozxRXUfNslsT3tzOO9mzPb59
         ZXdyzbk7omzjs6DW/7LIthuvgt09fAeOc8j+rJlIfS4CHiTpDfQ6bhy7OBByoqVwPTbV
         1aS1qgz6azOwIcUV5Zspztnb2EEmo9mlT67u3hYXRNU53vTcD5K7hXwhkwQ5oZJXpYv6
         fn5+WX/8kbAFb/Qf4TlROjf+Tx3+iKvNCoUvu9XDYDE3zledanfNsW71Zqkcd+vbcntg
         UNLg==
X-Gm-Message-State: AOJu0Yx181C++82r617zFiU3t1BHM7jIY1aQtCMKJO/f+CN9fIg+rmu9
	9luvvoQV+zr2RBRqMh3WzDRsTm0mVi/T2M+cjj3Dsbokeuwb2o7PHlED
X-Gm-Gg: ASbGncvVoaHvqVBYCrc9lYpbNGZ2clbwUecEvWgX6rHyMSzbLBse8LaFvHhm0n6Cvoc
	s8jgTSsdIh5L2v3CZkw3aAC/gWSTNp95zNGLs75H4497K3AMsLMd5TXqHEE/B6bHdHtxTRuSGsU
	zUtv16jtPeZJMgCHC7o2PSDU3ulGHt6bArGZTeHxNTD1WGLrB8TKA2/M0oegkpnQPFEJfGg8VSR
	9BEakoRMyolSeVVpdv6UIx4roQkC2s/orvM/9c2i1vr+K1tCL02jim63IQFvCr25oBbO0ja5QWK
	M5nUMd4YdNyKoBRaHdFSQXYn3EmyFyWK9ncLB5tpL4DsFl0Kxm6ggEDznnyKDGFaZ2GMhBmTU3T
	RdBvJeTi8wyVS+4mbyptqaKVHBhQq
X-Google-Smtp-Source: AGHT+IHb2OnstRkwerYAS6jsL9vg+OhYq0G/aw2ZodATMxnbDWmJWYbfx1BcOrU+Oc6Z6I/RAyQ95w==
X-Received: by 2002:a17:907:3e1f:b0:b04:830f:822d with SMTP id a640c23a62f3a-b1bb9b212c7mr292231466b.63.1758122725966;
        Wed, 17 Sep 2025 08:25:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:bc15:cb75:326d:fed1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1410380566b.83.2025.09.17.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:25:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 17 Sep 2025 17:25:13 +0200
Subject: [PATCH v4 3/4] refs/files: handle F/D conflicts in
 case-insensitive FS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-3-da3c74a08ed0@gmail.com>
References: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com, toon@iotcl.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4289; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iVp2tGka37Z9uuWEYawAiIueKJZHN8Wu26/8nEXn5Qw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjK0t/7wxPHEDZAoUkXya/VnWSJ/M1Trj+DM
 LENdffFJ9P2ookBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoytLfAAoJED7VnySO
 Rox/gcAMAKJV1fM5S0xM5ko0rpuzMLcYtjz0c+6RMx2aNTk4muPlwwtJ5MVuvL4Bkh4RtzZGfSd
 tkLxy1MqbXzDAfFK75+2H1fXxf9mv8NShVJ2ATAVGQy+1bpT6AzIRsudxiD7otgGni8GfCFCxXp
 mzfcjmTmtcbqrcyqQTs0YrZhIyj3ioTPbxjFzvMTThS/GF8PojjtRjNyZDNSmLQyvJI5J8++piu
 wylfYzMHI51Y0ZVMrspLXJXM8PMaEY4HUj+JQfbniXpGaYDuIb62JNOHfi7M74lrB/uXgNmZPsF
 yf6KPUFLbzddMYexJjaS4l9nf32KjutpTLFzeP1+de7JYn9H44kVBCgVfE3oMfCwZe/txMpWrjL
 5FJfPCUE0tb532RkzFcrFGSHBz7caTZGL9AJ8rK66R+gO5HKJlGH85a6G78vcpN2JLVXbMOd/7p
 4o6BSve9uARFJSPe0GW3I6IcTvBZ+48Ns2Y7/OSL+Wp4kUFdbTKI0nh82GyszO8NH6HTYtZcyJ7
 8o=
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

To do this, simply use a `struct strbuf` to convert the refname to
lowercase and append it to the list of refnames to be checked. Since we
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
index d1af5d6bc7..bfdf85121a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -906,8 +906,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
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
@@ -2832,7 +2847,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
2.51.0

