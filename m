Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CE21CC51
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649741; cv=none; b=RbjQNLfKQdKbn7h7vJ0xbjwzBg4Dyz8MN2K+hUpWQlhsFW4yFDROFxIVfFypEn+VCYUVIArbBcP80rKZ0YwOxbDCFUwLqgIrYOBaCdZaSUvLP5X2w9zX2e7J6YMwDx426XoSg8D8nX6RFll4xocrgQ/HVL0my3iyDW0H4cHuH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649741; c=relaxed/simple;
	bh=SNyKKQy5QITE4s8uRq8V6iLEXPEFLa3mYAmQGMYdBzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl8a8o9JJcInxM8GXIm8eTtmKlsrU80jQHMbRHSUtpfinQX/HhGHrXAFnXufc550QV6Q2Y21z/IeKPg2pSrBgvsKG+6Vw6IX02aBvpBcK8GqdkKm3B9bUF895JKXcrUTwi0nr+g37KZuIbqwGrP/w9iUnR+UXIG/4NZec4NRnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBjk/Kbs; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBjk/Kbs"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64455a2a096so304314d50.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649738; x=1768254538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZisRXe9V1e/Mq3z0KtpgxUl33VjvsblTS+PYmnWGJdk=;
        b=PBjk/KbsYrERll+wS/7gs+iBls39qQI34ueWGl7J26tBwnn37YU0xKP1lVp5yIadyu
         SsqD1cIYABp+FEPCNSe5A8tF8BsKjd4STOPf7Edu9mPy1slzp/zzMuMPPK8Cu4OeLKuK
         pdfB/IIsmfw/zibYPwKwoE5plY6YPm43fWDhiJbvEv5Ao3X12YE8gU52uHiKhSnSYjGu
         NjmCZFjihr9jNHBphKd5qbN0NzA/RRQwCMcM/yZ0riTyxW2f+8cIqRTV+bYA+YcX5wEs
         D/qsBaWXHHsQNACk+AFiLMyoWmWDycGah8uE3I4YgfuNcJsMVNF6ahQ02Apl+jY+vJbh
         ZQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649738; x=1768254538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZisRXe9V1e/Mq3z0KtpgxUl33VjvsblTS+PYmnWGJdk=;
        b=oqGEfIOuVQE3sv+UERRBGaBgoVmwswEgBKzs96tefnsIp3/zDdVC0EQmyCOJftGtbQ
         qDyMx4sntcKS6tunNU5cUdEhgEEFjxlK22xUgm/Xm0/OQcuZQuwAm/9PZKj8rXkaSXNi
         WocBsmBpUI4kziVJkWPLK3IaF9vS2C3P5P7b0C2K4dObXj2hOSk1Z0imW9YrUl1c9gg0
         Ll1VjAyYkWXtTPfvRzkVwhO5fLRpZsBEIe9qMKEumh8p2VKwk2M40KrsnBtPIkOFMD5h
         28y0sPTgO3czhd9/ot7I2HIDu03NXcJivVoVRNKubNxYdx5jdSA8vRy1txhOzV8qA5Fl
         VCfw==
X-Gm-Message-State: AOJu0YyHGoUd/I+XfFzLZoOzMIbNKeDk6HKoD7xv/RYb85y3TisTUCS1
	3oL9hgE251oA8tIKcqwkfzli1PFxhAzRef+17+ByVWmkkwuGwOOudt0P7tLm9g==
X-Gm-Gg: AY/fxX7Nn3G5lghNe2LuImRXvriyIWLMGDWH2BmEibRlgI2zrdUeAV7lSRqrYzCygDD
	iTsWwm3+1pkSuALU5kkP+ZFKYqQJjPeGfV/RNm52rPbSpZth1i6OWKF4oYefw2TjXKHASKCsqAb
	OrTuMt19ObmqIs+pCT2ul+HONJ1S2yOIcv3WTUCNJbNyANKDM/xZqw96FD83FQqiWACSEQHVA1Q
	vp+V/OqtP0Tb0ZOv3ZhD9y4mlb8RptITEYhVM6hyctoiTzAnphekkby4Wm/abVlrOo5KkzqWXL/
	Ru5jLc5rEsOIVaKlvKTvLCseehRZCCJ39k66ZhiGWbJTr8hiUEaDsSHcTGBiMuPmdh5WN1c/yWp
	L8CcxjMm5kl0LFuT73QRGDwbBfn4SSVds5ce3ockW5Zff7PzuYu5GFUY8e56WahLa6HIPNLKhV6
	iuzvaeDc7zmnH8wBk=
X-Google-Smtp-Source: AGHT+IFNDtUoCxn7MSrlHLJDPMKm5jFtyMgwEah340O9+kZuhnkMekM32pjBaX8BbRMfvhnvIt5ESw==
X-Received: by 2002:a05:690c:f09:b0:786:5926:ed9e with SMTP id 00721157ae682-790a8a75ebcmr20768987b3.25.1767649738344;
        Mon, 05 Jan 2026 13:48:58 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm706737b3.32.2026.01.05.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:48:57 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v4 1/4] doc: git-reset: reorder the forms
Date: Mon,  5 Jan 2026 16:48:15 -0500
Message-ID: <a558c5a8684639a2e888866a650357f54f29f2a6.1767649692.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767649692.git.ben.knoble+github@gmail.com>
References: <cover.1767307382.git.ben.knoble+github@gmail.com> <cover.1767649692.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback: three users commented that the `git reset [mode]`
form is the one that they primarily use, and that they were suprised to
see it listed last.
("I've never used git reset in any mode other than --hard").

Move it to be first, since the `git reset [mode]` form is what
"Reset current HEAD to the specified state" at the beginning refers
to, and because the `git reset [mode]` form is the only thing that
`git reset` uniquely does, the others could also be done with
`git restore`.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 3b9ba9aee9..9843682e81 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [synopsis]
+git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 git reset [-q] [<tree-ish>] [--] <pathspec>...
 git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first three forms, copy entries from _<tree-ish>_ to the index.
-In the last form, set the current branch head (`HEAD`) to _<commit>_,
+In the first form, set the current branch head (`HEAD`) to _<commit>_,
 optionally modifying index and working tree to match.
 The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-
-`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
-`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
-+
-This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
-+
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
-
-`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
-+
-This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+In the last three forms, copy entries from _<tree-ish>_ to the index.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
@@ -98,6 +72,32 @@ but carries forward unmerged index entries.
 	the submodules' `HEAD` to be detached at that commit.
 --
 
+`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
+`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
+	These forms reset the index entries for all paths that match the
+	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
+	the working tree or the current branch.)
++
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
++
+After running `git reset <pathspec>` to update the index entry, you can
+use linkgit:git-restore[1] to check the contents out of the index to
+the working tree. Alternatively, using linkgit:git-restore[1]
+and specifying a commit with `--source`, you
+can copy the contents of a path out of a commit to the index and to the
+working tree in one go.
+
+`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
+	Interactively select hunks in the difference between the index
+	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively reset hunks. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

