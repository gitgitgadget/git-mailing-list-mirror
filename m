Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614F356764
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323585; cv=none; b=Cm7ZmAkQ/i/AsrADavIxD50AymkT/uFFTEMMOV9H3v5ePm4WN2KFCF1FV75gATe+c4SU0gIJ1lKCKvX4xmdnbymvQmQ+AZ0z1RnVgKrbyZWMnyOfJ61OPPrHP1pY2x5hnJj4Q8fzUhK8PCY1DST+CvB/sFlKtS1eiSzFUtz9dMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323585; c=relaxed/simple;
	bh=qaB1nsiXAcgKjaL+Qht+y9BlAoNECNd5rcmEi+61Miw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ile4f/OROyY6kliKIlTFQdPpHWde8eQVf+x50adYm5Sa2A2DJph+NjBPZBcW1k2Rh2k31IWXGRsTGfS+PE4yMHJY/IGGiaG6Qsr4qK9hIZ2QUDhOuGovh1LbThnbjVPZEiszsnw4RTuxTFsSVibtCEvT0fLrUUG5EOS56vvEgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVXQ/93M; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVXQ/93M"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3075ce9c05aso3745109eec.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323583; x=1781928383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=oVXQ/93Mj30anpWnYCCbJhIsZZuqJt//nDrHH/VJOrlVJF1riI53SvfCNB4SO+W3td
         i0R99c0Ca2GC7j/MqbcNO2k95YVhDd3FG3d0yjQ2VcoMwIBUIlSZQPfRfgmCiWk1EGiM
         CUqUUY+8KSQeGvISq52BdmVBt+9pBSZrUV4h8fdT+wUcSW1+0xmy73qbQvi50r9JNKzs
         JtxNM6pkB440znPbtBEWvlbW7IZTybv6CBCyIyVxORAeicSoWV9G0C7/dr90gvUi3Vlm
         6EHeu6YAZJ0EO6sRFWwyl7CCR/jmhd50nBcR+iH8fnSpZR3oBmnjtJzKWezCA6Tm4V4M
         6kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323583; x=1781928383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=dnWWgQ6snnVFUCdFe7/t3rSbuLqePXXK3gOP8dsdnFn/HI6pCarw85+xSMsg9geHiu
         I0yXT8oWjr5Re4wVb2KcrcFfnl2PLnMq2t/1kCAz0w9a/cmAj9yJWWeOBtg91uDVxV4P
         6QiKAXQnSHiD+vW0ciLKjft4Yg0N2maJYG2FjinuGmCzPvFMZMEVxMYh57ZXFPS+X04S
         0L0RKoZTfxfL0vOsgX1l9EkORHVlxWoNOw4hmNnGgTRtr0WTHICRHRcZPD13Xd006aJ2
         1U06moageXBdmmvPeJH7vbNdwcQvRnftZKkIKIqCIbd+vlgjCFSR9Bsk7txGbCMLCkl3
         JaDA==
X-Gm-Message-State: AOJu0YxyH9vNVPphPutKc4RJQ7Do5dyRjrzRcsI0wadkL+G24zmbfi7Q
	OwuCuquEiGxe2MISj3ILkrfK3Hivyff2vGa67aHsNi9b5f3MkuPHPalfXN9kfw==
X-Gm-Gg: Acq92OGW2/OVRsqb4DKBH3QcjGbEgnyCOJSfPo9afc4lH0wvwN8sXWGY/WtygdV4itT
	oqtRI3Fo93KOJRzfWKSPr2r1l9Ab9QldY7NYjeiTiCCIAKiZ0W2Zjaop8DEPvX0nLII1JyfI/4y
	RC6S1F8dvVL3xrS/cDRpsmd8LsD5CeycYyz4kcRqVli4XuBeFvLD8cF+ngXheYQYW+YT7m1cvrM
	fkpRGPTrEvqK6Lw+ra9yGPEbg3UcBCVa1nUEw4F55FOoASpXa8RpVMviKlesX/YLS34IagXvtVt
	GTuPuvbsdTUw2z6/gC0fmtohAeW76brdXp+Z3YTeEbmVtsesUJ0LooWdrkmkKg8NS567rfur0dD
	Z29wRx+Ppxi9nDjn6a97nPVUbdjBAe6qUKqfOkPKQLuavYFwQkNJw3Xqw6rdyRt6Ll0Ejnsxx1J
	eEedG1r2zZLtTZltthQxDOx5Ii
X-Received: by 2002:a05:7300:5b83:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-3081ff55ceemr3527187eec.4.1781323583214;
        Fri, 12 Jun 2026 21:06:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm6098524eec.17.2026.06.12.21.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:22 -0700 (PDT)
Message-Id: <f3e8e19e6ea318e25ca05574a86003b7f241c995.1781323575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:11 +0000
Subject: [PATCH v2 2/6] t: fix grep assertions missing file arguments
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

