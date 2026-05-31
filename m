Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46D1F1513
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268588; cv=none; b=YHHsv3uhUE/filGTJEBXI58jBcWqKLxyKB9gbQY7Fv2pLzF913y3QXBtt62Wm8zR4y+Eynq9GrJh/nWOqBmyOy04R0nWUo/VrvzXQJ+hDZnoPtbGQg6r8zHvCmN9qGP2cSuJnzGkbeKAvr/MeITeHtRvOB9H5Zg4hR81C3+zVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268588; c=relaxed/simple;
	bh=iR4pD9/euYpLeA2OvgJFOAKXc1ocuC0xgAaZRcWoTJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKDbLcspUMa1hrkiCcEMUjDOleiwonkYcJlu+L7s8FTBU++/YWb9CQa6LTOeL6LZRxkc1NFDQBQtOnazavfCF5w5lYMfj/Ruhdgg8eubWiyGRpwmh/KeVp2uYfNE3EAHeSD/S9sZRFdP6BNqVhiVOju+9tVFn85/lXc3a52PfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcBO5Dw7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcBO5Dw7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d61baff3so105640141cf.0
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268586; x=1780873386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCKxjRQ95jTU9TCc3m7Wg6laH+SeQMjQl4mFv86x3/s=;
        b=BcBO5Dw7jX2r1Uj1rVxyBPt8/ZMsVWE/XSoRx/kYU3+pQ5CguxCz6zMswb/jw0Qc0L
         1SlHaijJ59fvq0Y1yX3IdZe0eSeBOxxFEDfzGpru8Zgaazg3GPNgs8q5yoOEdVLLUPsN
         EOmuYiCzGE3shEOumbNIYKKWOtdyV93mCxbD+0qf1YWutCUJ7QqWCA0SAQ17r3qx8NsT
         cupDkakjjErccQsI8mv4444N6rhhp7S9zfbO5Z+3uZkFzeX+95MdSh4MsB5eBTJCiX8R
         JILu5H/WlToQ7iMds4rA1xtEiBgJC48RgZfTS9nBi8lbb5q2xJ/Kgn6LCshUcym36/TA
         pGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268586; x=1780873386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCKxjRQ95jTU9TCc3m7Wg6laH+SeQMjQl4mFv86x3/s=;
        b=DqlGnNnny+jDOJdwcWVf1mZq8hwIEo3m5VgKDRXcuhn5WdPWHW2eoTc799H/4+Kygy
         /lnqBv2U9doJnlyaiBlrwPL/E+q4SzII4kfo0gxme95evPYpwWfBr+Gz/6f8G2VjRcRo
         e9ckrHIYhxZGQCs5yBKULu7iIoHC4AHd9XlI/nLTixQGP3/7l1kiBg64isGQdhoJO6m9
         JR54u0NUj/uPf5nEsM5VWbDgmOQdxnsUyX46fUvmbui++bpYQjYR9M5ICj+tRTvx/Qvs
         LOi6n4Z8Qziei4k/5h7L3/i9kYScOARp6/XJ45EWiVhrwWBnBGFSEKowpeFRKeClAMiY
         +NKQ==
X-Gm-Message-State: AOJu0Yxw3zIBVpNLaK6UiGK7ukmqgtbrZ8Z6kGRHo81eqZUNPOo+pIpj
	0yGVD1gYuulpbTK2WbZM9IJYTKSUc9GCWUfDI3pogtb98QuUhyKYk0LxuiTXEBdQ
X-Gm-Gg: Acq92OFL+tCSy3nNLwESGqHJA8rl3Xx8zUp5y+XtCgl1PGfQS2bDo9J+NbqN/9MKP8p
	uzcHSpRVo/BcjpYXoVUATzGGkcVpdd/MyYs76wk6nff8GX5b4ZuonmHiVYcYKExiuS3XguX3Okf
	0rhSmg482wrStQTwLqEPCIv0lfyRLAhzxaWIvDvs/WZPtnpKJHU2TPe2q49ym0HJsa6Xw5HjsCl
	RMqG7MkOhYdSNpjZ8LcvATpEabWkII3t2TosOa8oIr2xjWTvDfPTJMzPGNIxmlPedNG2u/1633U
	CVC4XV6eHuR3YN+bLugqoPnOu1lkkz1zl2wOesxmD74FfXanHH6ixqpukAkLiNC8eg8SW11+dkR
	+yNtsqs+QvSxs1umWrmgo65dE3tSOWjs3/SRgNk42uOzXmJD1VvkTmEeKsmJp8EV//gEccCXmpN
	MSoFVqmfXwQRgEqVfcYu6DO8PDoB70x0qNK5qx
X-Received: by 2002:a05:622a:a591:b0:50e:578e:bb18 with SMTP id d75a77b69052e-5173a884280mr136171321cf.47.1780268586415;
        Sun, 31 May 2026 16:03:06 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:06 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 08/12] git-gui: simplify [is_bare] to report if a worktree is known
Date: Sun, 31 May 2026 19:02:21 -0400
Message-ID: <20260531230225.126817-9-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui includes proc is_bare, used in several places to make decisions
on whether a worktree exists, but also in discovery to tell if a
worktree can be supported.

But, is_bare is out of date with regard to multiple worktrees, safe
repository guards, and possibly other relevant features known to git
rev-parse. Also, is_bare caches its result on the first call, so is not
useful if a later step in the discovery process finds a worktree.

So, simplify is_bare to report whether git-gui has a worktree or is
working only from a repository.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 53b6859345..abee222903 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -372,7 +372,6 @@ if {[tk windowingsystem] eq "aqua"} {
 set _appname {Git Gui}
 set _gitdir {}
 set _gitworktree {}
-set _isbare {}
 set _githtmldir {}
 set _prefix {}
 set _reponame {}
@@ -524,29 +523,7 @@ proc get_config {name} {
 }
 
 proc is_bare {} {
-	global _isbare
-	global _gitdir
-	global _gitworktree
-
-	if {$_isbare eq {}} {
-		if {[catch {
-			set _bare [git rev-parse --is-bare-repository]
-			switch  -- $_bare {
-			true { set _isbare 1 }
-			false { set _isbare 0}
-			default { throw }
-			}
-		}]} {
-			if {[is_config_true core.bare]
-				|| ($_gitworktree eq {}
-					&& [lindex [file split $_gitdir] end] ne {.git})} {
-				set _isbare 1
-			} else {
-				set _isbare 0
-			}
-		}
-	}
-	return $_isbare
+	return [expr {$::_gitworktree eq {}}]
 }
 
 ######################################################################
-- 
2.54.0.99.14

