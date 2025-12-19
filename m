Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A13548EE
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103877; cv=none; b=WacyFlshGVaRVm4ApMXVlvvUPdhxCZy5C+cwyDWzWaZpGryi3E7PTE2l+1BjyJLNJogf6+yZNNhpqENl5HwkLCqJevu4GaNAgsFGWWOAagPQ24fFGmiieA0L+4UR17tNCmXROoi+n/9Kn6L2FHAEl4YrV9H8bgQuDYYBzd/RdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103877; c=relaxed/simple;
	bh=ZKOv6sx9hcpywlpzL/dWFHO8lfXDnjQHIOY5OTqs5l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOVaIO5baFdH8wcoFf+NAzCZv6NbOzoqYGKmdOk7Chq/T1k+C3tUnBR8w2vEGPZuGZ+wuLp7wDnRgNsGeMQREh1ym/uCcGQbSelY8VmVo8m1KdTedPmK6sRwuVnZ7Lnt0IsOiiDFS9fFdcpyDjfqsISB57AaSKprrZVA4wsHL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcbM8HDA; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcbM8HDA"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446fcddf2fso1131419d50.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103874; x=1766708674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iinxM5fDBlaty+vW3/N+wztVof3Mx1tB1RHBVcTy1j8=;
        b=QcbM8HDAwkcD0KHhrmPdWbYeEwAoUIJw3UA4OiVCp6PDv8ANo/xUnGfmbepFSAog6s
         HFQ8ztEthDcXJUyb2w9suP+pvduKFZ3X97Wkzd0AdfHI/r5A5IUC7Kt+oaYRyDOMY3lE
         xDz93SYgzsuGPuUjKfo2HuJG8lHsIxStnTuMRJEnjoJPlMOT2GepR7Tf3coNG8WGfU79
         geTEv3Ih3EnN5LN2FVj4aBwdo3rHIPFuLKcZr0tqz5+AWZB5tC85oxXNneLIWk+tSwD4
         coLKKvDxXZMhujjshwXTky0Ic0A/umDGXpz9Wn8K2QUK7jdI7hjnfcTQW6WE66yspgnu
         7CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103874; x=1766708674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iinxM5fDBlaty+vW3/N+wztVof3Mx1tB1RHBVcTy1j8=;
        b=H1iY//0IljsTc9YaDkNhnev21350rMSdIfsk/5Z6lMCvr/DCgsYjCco90jTubS9T6f
         B9n2HyIsKE94Om2qep4Kp6kdRK2Ydl0RXNF7O8tfXycJamLT4i91/XeQDzaX+4QcfCSu
         skN8+qzRb3FVSMF/YKMPGkSUc8R/3s578cdk6DzKWrbDbpDm3tSNPcL8G+1cjUn+yX3g
         lhbDx5Rcco/W3NxmplFd3nf5dlS+Jn9FXnwCi4L50IHDY5FtGMSEvnkUW0XMOjuafNmz
         rUB8zdDHdEIOMqujSxrM7SXRt4C2xTlgIKob6WzX88GtAjvR19j9B/lWnFjxsLQX8Tzi
         5wpg==
X-Gm-Message-State: AOJu0Yxl+um/839pxhrQa1B24qjf1bwmPWue0+9njXWhFbveEnj3sejq
	fUHLVWRh4CM8zjCEmHymDe7Dy4c0E+RQQesOzOJFQxgCyRxTNSnqHemMZlnPgA==
X-Gm-Gg: AY/fxX6sCgJ4s3cgsM0X6xV7FlBJwKRFeaA3YhTKAB9XEnpPJi3MutcE5Ch62Bp+xqU
	aKHRwY95am7Vbj23Fv6WNW48+BRz/I7xPiJJ9pdQENXzACfa6rKMWc5Fz53dkDjZtNo5ILRwidt
	lwyWMjawBiubvFuC7VzyxoJCNsckG/M7M225QlNLa+SOJl/iHZXRBaVtRhiojK8GUPiwJ4X3jo9
	dBdejqtTR6zkJ4l0cXhgXlhXWGY+L4yWQOmn6pqyb8vKxSTaBqRySaRFOwi6os4/XOYX5s+CiMR
	TKID1iBBt3gZbSoS+S2yFSRg6dvgMI4yN73CAPzdK/8hZGiontAC2Tc6+GWVnoOI2+xJwjyG7MG
	7Hpz5T7q+0ILeowSopGTDacEnRnEETUYbV8lq/IYaivRythnOG63/kNngcrUDQ7rNwB+p0OlNAT
	eZd6SCqcVhx2IGPZE=
X-Google-Smtp-Source: AGHT+IEclCzB7YqNx3Jh4LMZAO74/XTiOXN2v67vcSfzPGyDxKXtSFhYQ/5NsIWrUjZjSjH/h+JhiA==
X-Received: by 2002:a53:ad05:0:b0:640:b501:d7c9 with SMTP id 956f58d0204a3-6466a849f6amr865733d50.21.1766103874186;
        Thu, 18 Dec 2025 16:24:34 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0dcdsm3658427b3.30.2025.12.18.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:24:33 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 2/4] doc: git-reset: clarify intro
Date: Thu, 18 Dec 2025 19:23:54 -0500
Message-ID: <f90be8559f7d1d8362077a6f888687ee8be063b4.1766103827.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
In-Reply-To: <cover.1766103827.git.ben.knoble+github@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com> <cover.1766103827.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback, there were several points of confusion:

- What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
  ("I have no clue what the index is", "I've been using git for 20 years
  and still don't know what a tree-ish is"). Avoid using these terms
  where it makes sense.
- What "optionally modifying index and working tree to match" means
  ("to match what?" "optionally based on what?")
  Remove this from the intro, we can say it later when giving more
  details.
- One user suggested that "The <tree-ish>/<commit> defaults to HEAD
  in all forms." should be repeated later on, since it's easy to miss.
  Instead say that HEAD is the default in each case later.

Another issue is that `git reset` consistently describes the action
it does as "Reset ...", commands should not use their name to describe
themselves, and that the word "mode" is used to mean several different
things on this page.

Address these by being more clear about two use cases for `git reset`
("to undo operations" and "to update staged files"), and explaining what
the conditions are for each case instead of forcing the user to figure
out the pattern is in first form vs the other 3 forms.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 9843682e81..71e8f52430 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Set HEAD or the index to a known state
 
 SYNOPSIS
 --------
@@ -15,10 +15,13 @@ git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-In the first form, set the current branch head (`HEAD`) to _<commit>_,
-optionally modifying index and working tree to match.
-The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-In the last three forms, copy entries from _<tree-ish>_ to the index.
+`git reset` does either of the following:
+
+1. `git reset [<mode>] <commit>` changes which commit HEAD points to. This makes
+   it possible to undo various Git operations, for example commit, merge,
+   rebase, and pull.
+2. When you specify files or directories or pass `--patch`, `git reset` updates
+   the staged version of the specified files.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

