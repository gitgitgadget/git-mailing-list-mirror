Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF86745F0
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435921; cv=none; b=O1bxM2rUrxCvgXQxQNJs4RjanW0liA1ErHP5r0efBeZ1srNuUsXFwvD5bnsYq1IbOJxFFczPA5CSkhZK45yzRY2pJYT32cpA99oMoEzWnbM8IqIvLlCM1R594f0gjI/31APR8pSEj3TWQb5gV8EYlxKuF2+hFOD+AWAZQUrtHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435921; c=relaxed/simple;
	bh=Jp088MfIMEOnw29cX33HGPfnwxRBSYBQF/aD9Na5pmA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=heWyYZyZY9JK1+y/dFfPH59+3A7ZR4VM66Mn4cFbpbMG7C/jiEZ5QMbVELXjKOJwn0kzPeBOSF57FJ1BwTLa1cexGZor7AJyU0TdVl/nGcLuRud+/Ly1t2VOWssmXKkdmB+Ud4W91qI/fzfxJksfh/xuwG8whzdJsJQNLE39rUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEhNXm01; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEhNXm01"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41312232c7aso14464355e9.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435917; x=1711040717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+950LcQhRW1vCmmSO7Zn8avTlDwcE9OYM+5/FUHR48o=;
        b=mEhNXm01DERkdQX3Nv8dPoiZ5aEZSkz9XVqbNYsw7PaSULcS1NVSq12QDTLf8UNpEB
         C5YWQsJuXIH7hDFhrsADVppDJwJ8u8fYSqYkHlhgGPL0/YwdcjrR4AwWk5yDZZ/PfyYs
         SpRAwyi6luiphLTFaKfKt7EdT3Ks8lxsaaWOdMCO1xoAJvxGaBxgpeLt/f7zQ6rnNhCe
         nfTB3sM4YpWyXxgm/mDV6fxKFNiGaLZuvUcTwh0nsHfCEM8O53q9TfmCWV+sQUyA24OW
         eXIoLQ1cMLupKR1uOLjG2E/dKLOaoS9srPYPsbPrXodstuOZ655x0k9XLQLg5hGX+X3P
         8PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435917; x=1711040717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+950LcQhRW1vCmmSO7Zn8avTlDwcE9OYM+5/FUHR48o=;
        b=YWt5LsBEtuNO2Eie4BhlmuwNoZMXDZQIfF4bTYkNFpXDXXHAz+WqUJb5d7mAnPcPJg
         LViEoCnf5ZHhrPexESn7Rbl8ZKDNpYBagieM02c0sLOMa5g8ILTyPdiWygwqCrA860/T
         szn96QFYzqQXQj1lT7EBi3MDpvjuRw6nThgcbsm1+nZ3Of59/9yG1xA5/bABFps8o/9+
         jKujtKlF2xkmtl7DR2D3OcMdRjyWyFdX2E7p7bPhh5iM2I8GNCtlyt4v5EWlLNUxyK4F
         3RijWqdIXCLKCUCm9fxxAVtSMe+ovMQ4mkGOE9KCP1D30DWzHl0fHIRp2iNascC0ZYDA
         XfCA==
X-Gm-Message-State: AOJu0YyswyG8NunGQT1oF6SR5q5u6/EBuKlsjH0wemWukCV9neukVdRn
	kjufPyEvQtjhTgcTb7L6DNVXsvF2bd8RI5r1BErYF507uIKswfrs9bIbLPnB
X-Google-Smtp-Source: AGHT+IFePEINxrZJCt8lcorus3hmKHo//1PO3idSD1uAaoj5ezIpTKdkq0+zR2rD8M8hh0gDVNjFvA==
X-Received: by 2002:a05:600c:3586:b0:413:fae6:4d3b with SMTP id p6-20020a05600c358600b00413fae64d3bmr921636wmq.12.1710435917321;
        Thu, 14 Mar 2024 10:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b004132ae838absm3010852wmq.43.2024.03.14.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:16 -0700 (PDT)
Message-ID: <b771b29e45abd1992e46c174dcaebe20ca8a41f9.1710435907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:07 +0000
Subject: [PATCH v2 5/5] checkout: fix interaction between --conflict and
 --merge
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When using "git checkout" to recreate merge conflicts or merge
uncommitted changes when switching branch "--conflict" sensibly implies
"--merge". Unfortunately the way this is implemented means that "git
checkout --conflict=diff3 --no-merge" implies "--merge" violating the
usual last-one-wins rule. Fix this by only overriding the value of
opts->merge if "--conflicts" comes after "--no-merge" or "-[-no]-merge"
is not given on the command line.

The behavior of "git checkout --merge --no-conflict" is unchanged and
will still merge on the basis that the "-[-no]-conflict" options are
primarily intended to affect the conflict style and so "--no-conflict"
should cancel a previous "--conflict" but not override "--merge".

Of the four new tests the second one tests the behavior change
introduced by this commit, the other three check that this commit does
not regress the existing behavior.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/checkout.c | 10 +++++---
 t/t7201-co.sh      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d6ab3b1d665..b8ce1904897 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -100,7 +100,7 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
-#define CHECKOUT_OPTS_INIT { .conflict_style = -1 }
+#define CHECKOUT_OPTS_INIT { .conflict_style = -1, .merge = -1 }
 
 struct branch_info {
 	char *name; /* The short name used */
@@ -1635,6 +1635,9 @@ static int parse_opt_conflict(const struct option *o, const char *arg, int unset
 	opts->conflict_style = parse_conflict_style_name(arg);
 	if (opts->conflict_style < 0)
 		return error(_("unknown conflict style '%s'"), arg);
+	/* --conflict overrides a previous --no-merge */
+	if (!opts->merge)
+		opts->merge = -1;
 
 	return 0;
 }
@@ -1742,8 +1745,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->show_progress = isatty(2);
 	}
 
-	if (opts->conflict_style >= 0)
-		opts->merge = 1; /* implied */
+	/* --conflicts implies --merge */
+	if (opts->merge == -1)
+		opts->merge = opts->conflict_style >= 0;
 
 	if (opts->force) {
 		opts->discard_changes = 1;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index e1f85a91565..42352dc0dbe 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -631,6 +631,66 @@ test_expect_success 'checkout --conflict=diff3' '
 	test_cmp merged file
 '
 
+test_expect_success 'checkout --conflict=diff3 --no-conflict does not merge' '
+	setup_conflicting_index &&
+	echo "none of the above" >expect &&
+	cat expect >fild &&
+	cat expect >file &&
+	test_must_fail git checkout --conflict=diff3 --no-conflict -- fild file 2>err &&
+	test_cmp expect file &&
+	test_cmp expect fild &&
+	echo "error: path ${SQ}file${SQ} is unmerged" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'checkout --conflict=diff3 --no-merge does not merge' '
+	setup_conflicting_index &&
+	echo "none of the above" >expect &&
+	cat expect >fild &&
+	cat expect >file &&
+	test_must_fail git checkout --conflict=diff3 --no-merge -- fild file 2>err &&
+	test_cmp expect file &&
+	test_cmp expect fild &&
+	echo "error: path ${SQ}file${SQ} is unmerged" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'checkout --no-merge --conflict=diff3 does merge' '
+	setup_conflicting_index &&
+	echo "none of the above" >fild &&
+	echo "none of the above" >file &&
+	git checkout --no-merge --conflict=diff3 -- fild file &&
+	echo "ourside" >expect &&
+	test_cmp expect fild &&
+	cat >expect <<-\EOF &&
+	<<<<<<< ours
+	ourside
+	||||||| base
+	original
+	=======
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
+test_expect_success 'checkout --merge --conflict=diff3 --no-conflict does merge' '
+	setup_conflicting_index &&
+	echo "none of the above" >fild &&
+	echo "none of the above" >file &&
+	git checkout --merge --conflict=diff3 --no-conflict -- fild file &&
+	echo "ourside" >expect &&
+	test_cmp expect fild &&
+	cat >expect <<-\EOF &&
+	<<<<<<< ours
+	ourside
+	=======
+	theirside
+	>>>>>>> theirs
+	EOF
+	test_cmp expect file
+'
+
 test_expect_success 'checkout with invalid conflict style' '
 	test_must_fail git checkout --conflict=bad 2>actual -- file &&
 	echo "error: unknown conflict style ${SQ}bad${SQ}" >expect &&
-- 
gitgitgadget
