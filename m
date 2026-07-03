Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE132B136
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054483; cv=none; b=g9plGI6JppOoAx5mo69nWnjiD/b0j05X+CFMI3TFqlYZtiHU1WHPIFX+iw7zKUeB/cVWp8nLKk4Laj+5gn4Pm0ts8hesKVfH/wf+AzstkaSrLDl6vApFnlImB8LtqKQmnv3R/vVcC0xuZS2sVmsCElY2vS90mNodQMS3+2EKSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054483; c=relaxed/simple;
	bh=qaB1nsiXAcgKjaL+Qht+y9BlAoNECNd5rcmEi+61Miw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RuZ80xQHtvV0tzkK28PFsww5QMK4uEGB/2nQgfZw7VgZzlw+0kBmZONytkCKcrW65caxf3kuGWxocMroQR8PRR1F+p78ZYWPNFQhWKtRZ6jxhI65o7mo8ijtqhAEiGh7AI7QrxeGT4UhZrZIE1RZlPW94GC3SdvT04pS3Z6yrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5KcVXlq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5KcVXlq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0ecfaee7so1063301cf.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054472; x=1783659272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=l5KcVXlqJsybSpScH8LqanEvvsN9AkEhB31F1B3vXkyFHX0gShf6m7NAppRjzsTAOL
         M2vsOd/3tmgwGwTcB+XldWr2K8o+CN1LiuPGtKGseH1GMUFt7E39P0w/62GystUSWYly
         ef+Wzv+XiIFW2NbOrVyTJQWXiiHUuE5Cl3pTOlwpoZL1DtCIGgeUB4ahoaUrul4bgFMz
         Y9gMZy1XfE+s+ji0OO9eOzrEuclXuhezqF24eNtp/MWyJdRv6F5sKv/Ebldw0/UBOesu
         wfTeiUrYKVe3zeLwA9aS+3agmeo3duQcUk0+LqAXGIXodJFNKu8Z4/iy83G1Duqhwt0N
         a9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054472; x=1783659272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=M2NkGhho9ONkO5UjVnZ2Ml35akHMA+GBsj1Jkk357qNKRH+ZwYoNZoGixPpPZLO7wM
         IkGHAlJGR6oKaEFSzRG2ErGxTNAIzZ4Wbi/Y8iLlYiyS9F6EF4dvLUX3Z4DJgZ6JWZ1Q
         Oko8usMjeOT5iqCEd4XMQXGFnYHjrJuk+WyKKu6D9NCltwbjOJhOgTKTKij8/s2bZq2o
         5mX+4/SnAlcD166vMAXGAb83WznkRdoAxeRMYfgd9ks2kKVd2PoP1CKBEXEKz5NcZx8t
         rMGlOb/85RS3UEBXDEk7qe8Cga5//pMzQc2Pk4M0VAs65UoDFoI8KFYfd+TShb5K+A9n
         RxQg==
X-Gm-Message-State: AOJu0YytFQNrMnCrNjr7GPslRjNwrVT+xoeZptZam1aPemyPj8icEfRE
	1b1r6fQm1vMrMkE8tQ9r7HPNp1lRfhR7aApG00N506PcVDp2crTgicMcdajbYQ==
X-Gm-Gg: AfdE7ckkBRhSvI3ZoJXAIDKIXbfA2FqYJSUWA9jfjYRXQglbhP2p+fIr6slYj0KN+rp
	agNsMFsvFQ1dVskNgPI7E8LItD8IHeCWulb+f/fFveIu400EyVpDCJs8QlixyeLze8svIVVMaSX
	Kc/eTc5pjqSCXdUNdv86FP+wsbgrog6jaPEuTIjH33XHDWxO3GUt5AWT2P8onsEyMQHkEKV05Mx
	f4Lc7+K8kQHhbKOlkHqDqi6X04nElrKReVbAYuM8XtN4wQwTDhCiPpOgVBIenvNM5idPkQfudGC
	rfYU3iKRM7jIGnqbziYm8NAmbwk5gnTQ3OuiPKFyQNlamUhAhDr3Vr8Ngqf/C6mW0FHiHieFNkF
	dj5jEBHi85yXrxJIkfWEy6gI6OteDRjV3RKcpj+CvybVt15Idvo/bdrNXRLenb4YtzUyU4HHLPH
	t/blaw8hHYOI5gW4M=
X-Received: by 2002:a05:622a:400b:b0:51a:86a2:7048 with SMTP id d75a77b69052e-51c26afe545mr114997561cf.43.1783054472423;
        Thu, 02 Jul 2026 21:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abe756sm7777591cf.6.2026.07.02.21.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:54:30 -0700 (PDT)
Message-Id: <7a837b77cdaf76052a68b03f643e791726e525a1.1783054466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jul 2026 04:54:21 +0000
Subject: [PATCH v3 2/6] t: fix grep assertions missing file arguments
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Three grep assertions were missing their file arguments, causing
them to read from empty stdin instead of the intended file:

- t2402: '! grep ...' should read from 'out', matching the
  grep on the preceding line.
- t7507: the closing quote is in the wrong place, making the
  entire 'diff --git actual' a single pattern with no file
  argument instead of pattern 'diff --git' and file 'actual'.
- t7700: '! grep ...' should read from 'packlist', matching
  the redirect on the preceding line.

Without file arguments these greps always succeed (empty stdin
matches nothing), so the assertions were not actually checking
anything.  All three tests pass with the corrected file arguments,
confirming the intended behavior is sound.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/t2402-worktree-list.sh  | 2 +-
 t/t7507-commit-verbose.sh | 2 +-
 t/t7700-repack.sh         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index e0c6abd2f5..93f92e854a 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -144,7 +144,7 @@ test_expect_success '"list" all worktrees with prunable annotation' '
 	rm -rf prunable &&
 	git worktree list >out &&
 	grep "/prunable  *[0-9a-f].* prunable$" out &&
-	! grep "/unprunable  *[0-9a-f].* prunable$"
+	! grep "/unprunable  *[0-9a-f].* prunable$" out
 '
 
 test_expect_success '"list" all worktrees --porcelain with prunable' '
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b53d71c086..acdb6b1455 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -163,7 +163,7 @@ done
 
 test_expect_success "status ignores commit.verbose=true" '
 	git -c commit.verbose=true status >actual &&
-	! grep "^diff --git actual"
+	! grep "^diff --git" actual
 '
 
 test_done
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..c6ff3aed30 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
-	! grep "^$coid " &&
+	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
-- 
gitgitgadget

