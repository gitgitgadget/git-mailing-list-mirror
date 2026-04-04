Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94534405C
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332211; cv=none; b=TGWrqDJYgm5tdRylvpn3cacfENCHY83wHN8IcyExTei9DUYfyYv7sfTr0MMgtpECHp/p2uoGP/sgUruYwBvrG6YufhTdVcUdom+OwWL3LqvGbGn81T3AuSN4p655oo2SOUU8tRqaMB8Eq0vNKqPS11e6qNkS2RfffdlsB+npx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332211; c=relaxed/simple;
	bh=8uw7kObl5KOcBicJq5x2U9BULp4QBQ4NOeK4/WfnuXg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s1uZiacP2XDH74iS9KJ7FWtc0VIxvAQIttZMOZ8j2duYyBYH1aiQxaIOlns6dtXLYx8yz9NfDlFaDi8D/xaZwyXs9pS7MKPUBFlEAoC4A7cpGXpA+acbarHKR0KXKsqt+UgfMpyqoCeGwzzht0TvCm/3DO8zdOPeKplRU21Y7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPz7rYJX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPz7rYJX"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso39769766d6.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332208; x=1775937008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNiyN+0I1E+n88lbn0W36AflR2LQgGLc/FSYbdHEJVE=;
        b=oPz7rYJXVATexsaex2EOdqIOuDNsYobNKkMQoVnADXr4PuSoO+hUj3U55v7E/HJjth
         LY+0h4J2d0HJVFPge9zlFUTnTf8M8Lr9AL/W+XX01E9IRVlaUB2WyogqofJVAyddACov
         9qIyOWTgrJha1o5xtdFfaEH/Fu9dKhYXK/CnvhQVhcEPe0Uj5RIwUcvZR4HLsp4BIWiY
         l8QgBV3282XXTJ+boItSPYdGNzqniRaXbbw7EIkLR+kBKJbDw9FOTBLJxwqyn/35ArRY
         kYVb9gvTEWrp8gk/xwYjzdnLPzf9IR7gvQ9fCoCk7ieppF3HtjlcBngpyA1TIuNGJT2a
         UWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332208; x=1775937008;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNiyN+0I1E+n88lbn0W36AflR2LQgGLc/FSYbdHEJVE=;
        b=OW9qzb5qi/IXP9rzbT+HKJ6lstyG+dzAe3XYvHnWenyAY9jpye1MaPbQjF5+AxMWxX
         0YxkVkcjYV7K9EPMLUp12RwRX01rXI4Y4rffJxG+nWW1yGBeRHUy9bM5wCrKGKYOIPFO
         O0YkgjHYY7QXZe33s2D8iznnR/AKeebGIL1s12bEDGfE2TujWW4BVqBnumIHW7478AwA
         zC12+YrYTFXNNLfpN76wYhdtUBN8K5IMrCyltPOky/zb0h8EGL7/arJ7AiKhnJ1+wK/A
         7m9NmX8t3ECQtGoeR9PbIm2bzhTsDPw1TCel0c5Kk7Oyi27Qm0xuNEhaMbp8ntabhPw0
         WWLg==
X-Gm-Message-State: AOJu0Ywu44GG2OaZ7xOwcS13fnQXSlq8ERjwywnwd2fAvN+9PllzcP1J
	QUctIPRA/PNy4o2mbv+qPW/QDLD1E+vlp3ohn7mnZlSS4GsSZ4rF28zCW8wj4LXZ
X-Gm-Gg: AeBDieuPPKBaMeLtGApjQY6a07UYyaP/FxHqdBTKQcLiSLYRfptmDWJ9kBhY51+sGXt
	VtLjxAcWKK8qroqykiZu1ZF/j0I6BLt0Pi5/+UxfmgYNOuXPqTqZ87yZ0csfSOFQ0615VFRUkhd
	coRXIAIrDgONhA9GnBQNIxsW57z6+/g6jSdUusaUuoXju4gQF5j3JJV11ic+qLfDdkckvqtzG9U
	AynmqSb270rfKH86xeaj/8QIrZky5COn/MdiYFQxgZt+3Q99FPF2591/faXE9m5LmHSbQJn9ybc
	w8LorXXWayJ8OTYwfXV4JhlX6M2vac2vOYWQMOP8PZYgFZddZf4HH2NzZQTCsY6LiJQMjoJ8TH9
	x5+pbDxeVvRdAvakPJohEtvW0wW5GwEy7NUQvsb5n8U/TgCIXVPyntcttClXsqa7LqjAsinypEz
	GtKXIdk3S0ViXERCimlRlBucabkok=
X-Received: by 2002:ad4:5c47:0:b0:89f:1423:999d with SMTP id 6a1803df08f44-8a7043efd0bmr126619476d6.43.1775332208450;
        Sat, 04 Apr 2026 12:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596915986sm88475036d6.24.2026.04.04.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:07 -0700 (PDT)
Message-Id: <2905e000c526e6fe7140bec7a7ead152b495db65.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:48 +0000
Subject: [PATCH v2 08/17] t2406: use `--git-dir=.` for bare repository
 worktree repair
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), the test case t2406.10(repair .git file from bare.git)
cannot rely on the implicit discovery of thee bare repository. Simply
add a `--git-dir=.` to the invocation. The `-C bare.git` argument is
still needed so that the `repair` command realizes works on the intended
directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2406-worktree-repair.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index f5f19b3169..cac448b575 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -84,7 +84,7 @@ test_expect_success 'repair .git file from bare.git' '
 	git -C bare.git worktree add --detach ../corrupt &&
 	git -C corrupt rev-parse --absolute-git-dir >expect &&
 	rm -f corrupt/.git &&
-	git -C bare.git worktree repair &&
+	git -C bare.git --git-dir=. worktree repair &&
 	git -C corrupt rev-parse --absolute-git-dir >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

