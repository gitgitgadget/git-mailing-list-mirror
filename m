Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDF34FF7A
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465292; cv=none; b=nVCt2jsJJRA35FCM3Ox5vv4jvhQVoQdablUGd0NKBl5cJ0JIeJwbj95sENSRHjgE+0RCu6owFI/0iIRBCrmuFmciUU4umfP8cLTav1IsXam4zsJ4boboxyrs4ZFGqkQrsk7qTdF2yC45Mji8N4QvR2ELKq+ssX8Pqvqq6SBXyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465292; c=relaxed/simple;
	bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJxdyb7H0vzXQHWp5XVEuGY4JiQKDkrPkEYkgc/W+Nd5x1u8m4s83woZV6sJH4YOD4tlU/1F/k545Q69iTEd7OuFmaMzR1XULrfH9mIuas2wXAEC7UyqpkWsRSxOyfrrjtPkG6uxjCHc/SVX0X27D9cdf8UxPbketjFsfomgdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSMCGdC7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSMCGdC7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b737cd03d46so439870266b.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465284; x=1764070084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=TSMCGdC7353Zm3mRFQNHMkPjxzleo4CjHyw3ZEpbTyP+zt7hBOWgkQNLKcx19BPgTO
         Ga7UfwJ53Jo8aooZwxVrASWlOWIjsehIwn37W5q/biDjlTTb9xKXVNo4ECrZvZ+EEOmz
         LDDUFXFqNnmByFJVRXYbUkcj8htvRzSu7misk5UpAky/XOe3q3lh3AqbL5gcLvTOQubN
         efL48Hly0eFhm10Qcrb9gd8a5smnzJF7WxY1CEzz3o/EP233bw1832yWfKBfhoHkHa0A
         yxOpxonvi2IMFmwOeNPXZPy8JrhzpOgcn/xUVBhBzHlVB/mmR4EcfAUuRjP1R22WI5SP
         nnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465284; x=1764070084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnaAKwk7x7oDqcRXpULbV9nX0QVS5pHyYgmJtTViigs=;
        b=LQf2cts53+oCn5lc61ZPtjTefndodwUtk1o/pLU+8PHFRdAO2SV8iNZWBUhwJIDv/i
         WWCjFF9fZ7u+xkRBSWvPmUuavTdMDl6cg1qIDAAyiUgFYILzr3VND09hXI1SYGLz3cuE
         /MEfFWb6cmJbZ78/EnGEUo8SVyL7mChMpnZ9yNijIMmTqMoMO2Rc0o6dEKIh3oGi6UAf
         aEAlJrBfV9+aop0HzDW9wguCdc9GlT7fmydXx8/QuHVXssP0rk2qjtD5Z9zOWLbYBJC5
         qcAybTH09QsjJYbmNB5YItHzzmDHK25lC2Wk7PtxIndjOMh7imbGquW6LC8kl2z38+nO
         wBBA==
X-Gm-Message-State: AOJu0YxDx8uQXmyS1HeeujM0+f9jA9D5sTmR9o5m3rb+XZjv0F4ROJeY
	vTC/dQxbjpu16Nh55MTG28vuxzj6OnV3CgGOcLLi5HS/9h1wS1DH5ReZ
X-Gm-Gg: ASbGncuRYz3fDvWNhCm4ym2F6UH0R2OILSVhdeP7AjuVrK6qv77478Yvhwl0ui0iQlZ
	XUPTNzkwPV4MKIUNsCk/mgwSwtA8l0E2IhK+Edg181M6nqHXxlNJoksxR6Lx0NE8NSKefPMUOZh
	kHFueRA7zp5eu9x/NIsdBLc9WwQ29v+h97zDC8cTFA4PKabJnBzf+XwFvRnGkWykG/jQPzPhc8S
	bzK7guac4TayP+yxC3T4FyjeRt+wMvtcMU7KLOW0IPfs1AOIzxZHaQGRCtjCS/7myQZAUiEyxlE
	LrVm4B77Hc1QrqWMzc279Xb6vrk6Xw9+IfDo+KgZCknIU8lB07GqNFYXrpjPDX+Gn9WKBeZFy90
	cR5fE6t8uQBodcDR4M7ZYaee1sbpbQuaX2OHTe13WiaU3BUacZ1kb653BX/ZZq/429EF/Kvef7Y
	IsJr/M9TuVw0Pp7Bg=
X-Google-Smtp-Source: AGHT+IHkfP6HWagC3KYta7D3CxSkUr632WJa4m1iPzXjrY9zGlg3XWxjgIURd/nqTvWCCWav1Hsszg==
X-Received: by 2002:a17:907:97c3:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b736787e089mr2089833366b.5.1763465284287;
        Tue, 18 Nov 2025 03:28:04 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:118:b28a:3b78:ce56:def6:5cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73718fec4csm1005451066b.39.2025.11.18.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:28:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 18 Nov 2025 12:27:56 +0100
Subject: [PATCH v6 2/3] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-fix-tags-not-fetching-v6-2-2a2f15fc137e@gmail.com>
References: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
In-Reply-To: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2k7HhaIYOOs3BXh12x4/laVna60CmztFvFCcmQaKggU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkcWD3Zbx0iq9UdNHO4eB69SKzT9/f510rA/
 Sf4kmYGgXkgp4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHFg9AAoJED7VnySO
 Rox/s5EMAJsaQYtwzaFXxnXR8Qew0+OrV/Ic2A/YFkcSTCaryBM3N9ZIJkyOklbYtWSiLJAJz3b
 JOnk85iJJH0mubxkCf4XD71Spp6D3QxrkoVYMamfZPWfUB0Getr579hIksRxr6Xaxd0yXgFy4hb
 e20i3EICMA/FPbG56MczdVEuiwqPz4wIA75QvNteLJb5SVn+c8PEswg1YlAaLpiOK4uEq6Tu9b8
 cIpq5a9AX+/NdnkdIUyWWYxuCJWRCDtTJg4002gffsRyU9woxPMU/Owls7wEORC2JiRDeXm/Ka9
 GWRz+QiwWRfpqmACcOgVgW4FJ37H8gxnsBgz6F4OGL4X6VkZPZbdl2ZvaIGJgRaFdQGAgxd5Aw1
 iaTxUJiJwTi2OXDlL8cNUeZZdstTcLPyq3wTtjNtE2wlrL7K1w4iXn8pBBr/n4D6yvF+M2Xln5V
 WfYaI0zu2d5WnnsXS3QvQnBrTlSy+RfO9B20dxF4+VDSBGphRpxde4euhwPrxJztAQQrZnrpjN5
 2g=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
updated the 'git-fetch(1)' command to use batched updates. This batches
updates to gain performance improvements. When fetching references, each
update is added to the transaction. Finally, when committing, individual
updates are allowed to fail with reason, while the transaction itself
succeeds.

One scenario which was missed here, was fetching tags. When fetching
conflicting tags, the `fetch_and_consume_refs()` function returns '1',
which skipped committing the transaction and directly jumped to the
cleanup section. This mean that no updates were applied. This also
extends to backfilling tags which is done when fetching specific
refspecs which contains tags in their history.

Fix this by committing the transaction when we have an error code and
not using an atomic transaction. This ensures other references are
applied even when some updates fail.

The cleanup section is reached with `retcode` set in several scenarios:

   - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
     `retcode` before the transaction is created, so no commit is
     attempted.

   - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
     cases this fix targets, both setting a positive `retcode` to
     trigger the committing of the transaction.

This simplifies error handling and ensures future modifications to
`do_fetch()` don't need special handling for batched updates.

Add tests to check for this regression. While here, add a missing
cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  8 ++++++++
 t/t5510-fetch.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f90179040b..b19fa8e966 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1957,6 +1957,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
+	/*
+	 * When using batched updates, we want to commit the non-rejected
+	 * updates and also handle the rejections.
+	 */
+	if (retcode && !atomic_fetch && transaction)
+		commit_ref_transaction(&transaction, false,
+				       transport->remote->name, &err);
+
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..4b113d7c27 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-1 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-1" out &&
+	git -C repo fetch --tags &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-1" out
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag-1 &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-2 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-2" out &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag -f tag-1 &&
+
+	test_must_fail git -C repo fetch --tags 2>out &&
+	test_grep "tag-1  (would clobber existing tag)" out &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-2" out
+'
+
+test_expect_success "backfill tags when providing a refspec" '
+	test_when_finished rm -rf source target &&
+
+	git init source &&
+	git -C source commit --allow-empty --message common &&
+	git clone file://"$(pwd)"/source target &&
+	(
+	    cd source &&
+	    test_commit history &&
+	    test_commit fetch-me
+	) &&
+
+	# The "history" tag is backfilled eventhough we requested
+	# to only fetch HEAD
+	git -C target fetch origin HEAD:branch &&
+	git -C target tag -l >actual &&
+	cat >expect <<-\EOF &&
+	fetch-me
+	history
+	EOF
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.2

