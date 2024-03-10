Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7916FF49
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096419; cv=none; b=Tq87adtEy7voIuBFa0iVepAgMhBMsB1UZX7tb+0+zoGpC74xPAR8uXp8S8KmEvfuNOLrJASpqDf5PL7Q2hFhyqyrrwSEI6saJg2fOwRgDgXOO4B0wZCji/62vetfXURf8mAF2e5ngPGG6Y625r5e6yGoGvnuD/INVIs2nRn1Sgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096419; c=relaxed/simple;
	bh=39+4gv6/FCCDEk90THgcn709kzBs8JVSgMrSJtIx8pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTBNeam56SEzeXNhBP/IW5mWWgBdxsZ/CrFIeGugv09O5H5D1pzeeJjj/ZcszR4oM1wQBW6AIzDTKqvUk62uyQ7klS5GyhwzzIy9zsOkcXyy8RXQXD8ID334onOV/BV79Ejpx0b4uB+dJaPfAVv+RYWcIydctJpK0n72lYsIqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYVuE3zx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYVuE3zx"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e51bc7640fso627666a34.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096416; x=1710701216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3zuGx+Fp90BMDHVWU5Fd6NFteo7C720Cesw8+xmBFg=;
        b=GYVuE3zxjFxSzLjHI7jrxlZuBYFsD+RhD5hMd+0tKi0GVurgbUiiWRvBIv1ec72gf3
         /OLgt6LY4NWZgL9HvjEN72y0muJWB9+Ucilm1FMUzWrEiS0iZQwyfKCU3+Nab4Tt4jLR
         Ah35OqIMjmk3cKKrhtt8S4xCdjcCV4IgycMd80qvqiXfceiG6JmpL2LIlHCw+Qf03O54
         yM4r58VR1S57tOyzu5Vo1WlHwQbsMdZ5Cw4dLWGwnwXIj/fON1e6IOtaxK5HAIQSNxRY
         qWxK4iI/zVsxe47sJUtVKmdfm4hEx+991wKrE8lOETsp1GAfLtzPrprrFRijWTQdhf+1
         o0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096416; x=1710701216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3zuGx+Fp90BMDHVWU5Fd6NFteo7C720Cesw8+xmBFg=;
        b=US6hUtZVMrcI+fHOscHzB9sACW8eIF5of8DsknigfevU2/8FO60vRGIxyOOgBPsgDp
         gpkD3zhaprgShu4oMBgjEsw91i5XV3WbmDASNRUJOquM6u8nP/wtNWUDQKCmZXOhPEWs
         Z8QB/PFIXtXKCmmFaFtd21WvkINfq3N0aMGjED+LjwGZOGuBH3yHxeCHS8vLCWh8RQzg
         //DNhFr4Ip6KhWR7Pw3lVDvY89ryoa0m/uAjO3UkWUmLzjo0VtvAWFm2aeywcCb/GkX0
         yPsXx+S56MGhx6LNE3/7+1UG6d0gi5U60CuW/czHW6dcHbxkB34y3+fBKmnXPDdo4/8+
         FDqA==
X-Gm-Message-State: AOJu0YyC8nzFZYJPO0/DCR/Moq6VWL6rONuD9UfaO1Jzkol2AjTX72RY
	I/gGL56TR2EP9h0+crEY8dmM+DapSVLGvRgDt5I04jCWgOAcs8aPcGSjeTm/duc=
X-Google-Smtp-Source: AGHT+IFcXFoeC94QGxZVtOVDU9tcrvNUgp1GFGQ8zWv2cN9ltpf5PgpkHnFWOVt1eDNFey6AV0ds3w==
X-Received: by 2002:a9d:63cc:0:b0:6e4:94d9:6aa3 with SMTP id e12-20020a9d63cc000000b006e494d96aa3mr5802487otl.28.1710096416019;
        Sun, 10 Mar 2024 11:46:56 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:46:55 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 2/7] docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
Date: Sun, 10 Mar 2024 13:42:01 -0500
Message-ID: <20240310184602.539656-3-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these pages document very similar `--empty` options, but with
different styles. The exact behavior of these `--empty` options differs
somewhat, but consistent styling in the docs is still beneficial. This
commit aims to make them more consistent.

Break the possible values for `--empty` into separate sections for
readability. Alphabetical order is chosen for consistency.

In a future commit, we'll be documenting a new `--empty` option for
git-cherry-pick(1), making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-am.txt     | 20 +++++++++++++-------
 Documentation/git-rebase.txt | 25 ++++++++++++++++---------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e080458d6c..f852e0ba79 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,13 +66,19 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---empty=(stop|drop|keep)::
-	By default, or when the option is set to 'stop', the command
-	errors out on an input e-mail message lacking a patch
-	and stops in the middle of the current am session. When this
-	option is set to 'drop', skip such an e-mail message instead.
-	When this option is set to 'keep', create an empty commit,
-	recording the contents of the e-mail message as its log.
+--empty=(drop|keep|stop)::
+	How to handle an e-mail message lacking a patch:
++
+--
+`drop`;;
+	The e-mail message will be skipped.
+`keep`;;
+	An empty commit will be created, with the contents of the e-mail
+	message as its log.
+`stop`;;
+	The command will fail, stopping in the middle of the current `am`
+	session. This is the default behavior.
+--
 
 -m::
 --message-id::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3334e85356..0b0d0ccb80 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,17 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(drop|keep|ask)::
+--empty=(ask|drop|keep)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
-	upstream changes).  With drop (the default), commits that
-	become empty are dropped.  With keep, such commits are kept.
-	With ask, the rebase will halt when an empty commit is applied
-	allowing you to choose whether to drop it, edit files more, or just
-	commit the empty changes.
-	When the `-i`/`--interactive` option is used, the default becomes ask.
-	Otherwise, when the `--exec` option is used, the default becomes keep.
+	upstream changes):
++
+--
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified.
+`drop`;;
+	The commit will be dropped. This is the default behavior.
+`keep`;;
+	The commit will be kept. This option is implied when `--exec` is
+	specified unless `-i`/`--interactive` is also specified.
+--
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
@@ -704,7 +711,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(drop|keep|ask)` option for changing the behavior
+also has an `--empty=(ask|drop|keep)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
-- 
2.43.0

