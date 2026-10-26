Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018411;
	b=kRUR5bGFmN5xBRbHs4QB5E6CgLcrEB/7SQmboRjUR3LO7ndIPky2Rwq+qCk8eR2sRMR5
	 49A5i4iNMyB1deDi6xKibJg7XPpeTqTcfF294Mvcat66GwGUyD/qPHB5qDDFADc/tg/EH
	 vCZgR+PbeemQ8/urfQ16TAZtHZcYBp3ItD934q24yvYwVAJeBjRKTZLP10czIC42MuvqI
	 lthkDfuWL2ixdEyFIzb/KpxnSkeWPJa1j/3F2v9CLKZFQyM5yrSYcFvo+JEA5XYjSBVvj
	 kiRMu2qm4YO2tj9OqS2xKr/q6ZCqsliN8pxTWsi/ioXrAENftQ1DfYDXct/V+Is1Hdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
	b=khGOGebg7rsUhYDxOaOGgekssaf0QgJYRITEXLi3Fd5zuMJANliRhGbqrIsQghQyx6dD
	 vLdvaA0YZhMXY/zOLXgyEHSu9Ah6Wr2QeKBC1iPpXhASXTIhw6CzvVXNWvkpynGG///PG
	 SLc8DA6hROYG1K9LXzn/sx5OhvsuPQiOJJ8UsW2fU6+RrHGBv72ll7i0V/aZPWOVuXgMc
	 hPLLHSWJ2fX33kZPeXJet28Sq8gMCQXx1SbbLKA9zEgrjtmQplt/AXvVE9XQO2kxOdiUu
	 F18yR7orywYGgQp/xIezRfST182b6CFBz2JzRvYx7GU0gmk6A2PzY83SHNDo0aVwlvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mmWAyScC;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08609606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08609606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mmWAyScC
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c445c95d553so376282066b.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018409; x=1793623209; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=mmWAyScCVx3Jkav+NjAtsvMyEDalvBoNxpfFeNOHyMoZegVFt+c5ohceiVwMfbETks
         UcP/lAw0jqtaWtr2GxEc0+MFSR9mgTyd0GhFdaylOk+F1uJ2cca4KTVgA8oiNaey815C
         DKKD+DtNGpP8UvLeqLR5aflC40FBDB3rSiR4FOvXr6a7Lo2XjJIxuULCmR7TzOjDHQBS
         QvSzy9ZkK6rujsZIasrl9fU0RBp+gkRTG27/oVryh+ZikNy1XHPkIbc+FcJoPD/1da0i
         k7uveacRvnOP7t8m+zgbyZHDOMGcaQUnkW7Q0LDMttjU6So8mCJJs3SFidwcBVx9OJ0Y
         1D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018409; x=1793623209;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=WClFkdbC7BBkjTKLkoSBOPcsuBLxZN4OEnWWTX9YqvahTQ2wQd2vpBg06Np2BLkdSj
         9WekERbh1LyOnzMwkkVZze39kDqEi78C1f07xMQimaYI0m836nMksw4RiuwSteem6WtO
         jRhZxV8k4pJyKzCiqHSHraqgosvrfDf+swqKfKdQ6x6sQ8Iqwas1G7onU22qLjKs8++H
         PgY2EmM50dpJLu9Uz0ZcO5LJ3+v4K5yXYZFgZYhlwAou1HDVrd/5npDCecat9xDjJ/el
         KoXLTtVcZiHCh4fxf2yAON0p2vQx0k2edCGdW4BzWDCN2Eb4ViShYcSS1iWlU3LDz2Uy
         ABtQ==
X-Gm-Message-State: AFq9FYIL7iYER+xMtZiI0xCs4DTuVwyP9Uo31xPzedgfbUxKKP1Xi0cn
	qLsyosnj9lZh2GHYFk2Kae5P2NNBUlv1cHPTsqAnAzIAPOxf3Whtu0XEIjGg6jLbjHU=
X-Gm-Gg: AYBFou0UbhMIe01IYqIS+iCC8f3eEnMuSQ9muy6kuU3LdI0Ewyx965XYF/GAp0jrK3L
	mepoPX7EgMUyi2t9ToioISmEjb8Obc4ViM6FPDk363saLb0PtLTw7ZqT4FJbxpEWg1zqyrLz8k/
	EiuJFhtcRbhS6kDTMdbvv0+rxJRkmvFi/hHP8BU2kIX7ZJ4AoyOP+dEgJJcix4ePa1E3t2njrI4
	UWh6RHdMEDTeTZI90FFDNm0luoFDCEaV7MJCHrRwTSND4wOVrH1P9GC/qGKIE9roSWFL3gvVkKi
	c3zdIpHBp41vQNL2UlIdSY+7TuI0olmT8Zashn9skYGzCIxLVDSJH5U/sA/bJy4Gk0ztYomjHOJ
	UYJTxHsFOWNv35F/z8N34UF6z8N8cTHfJBuVS5UYuieVdLbJk6XTsDuuWSpWGj364eY1nqIrueD
	cVs3e2R6MZCR4auZ9Kxr20Dma1+9TNJlCfGkdH2qV1g5dTfdpo7onnHTwkVHSJK/AtP989aL1BH
	658cFgv5/e9Lw2w1lM4UUvW3u0qP/BcGkjDcc4IU3sH6hH2aFicrgtxb0kT/xIppuiGl9gCwLFY
	giyUMQ==
X-Received: by 2002:a17:906:7952:b0:c24:adf4:5c73 with SMTP id a640c23a62f3a-c46bdaa744dmr759808966b.1.1793018409270;
        Mon, 26 Oct 2026 05:40:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4ea351sm313694266b.28.2026.10.26.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:08 -0700 (PDT)
Message-Id: <3dc763a2a2f10f453102ad3b9232d9291e7cca75.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:01 +0000
Subject: [PATCH v5 2/6] doc: git-merge: link to new merge conflicts guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

All of the info about merge conflicts has been moved to the new guide

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-merge.adoc | 125 +----------------------------------
 1 file changed, 3 insertions(+), 122 deletions(-)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index a055384ad6..5b7b41cd10 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -49,7 +49,8 @@ a log message from the user describing the changes. Before the operation,
 A merge stops if there's a conflict that cannot be resolved
 automatically or if `--no-commit` was provided when initiating the
 merge. At that point you can run `git merge --abort` or `git merge
---continue`.
+--continue`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 `git merge --abort` will abort the merge process and try to reconstruct
 the pre-merge state. However, if there were uncommitted changes when the
@@ -231,127 +232,6 @@ git merge v1.2.3^0
 git merge --ff-only v1.2.3
 ----
 
-HOW CONFLICTS ARE PRESENTED
----------------------------
-
-During a merge, the working tree files are updated to reflect the result
-of the merge.  Among the changes made to the common ancestor's version,
-non-overlapping ones (that is, you changed an area of the file while the
-other side left that area intact, or vice versa) are incorporated in the
-final result verbatim.  When both sides made changes to the same area,
-however, Git cannot randomly pick one side over the other, and asks you to
-resolve it by leaving what both sides did to that area.
-
-By default, Git uses the same style as the one used by the "merge" program
-from the RCS suite to present such a conflicted hunk, like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-=======
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-The area where a pair of conflicting changes happened is marked with markers
-+<<<<<<<+, `=======`, and +>>>>>>>+.  The part before the `=======`
-is typically your side, and the part afterwards is typically their side.
-
-The default format does not show what the original said in the conflicting
-area.  You cannot tell how many lines are deleted and replaced with
-Barbie's remark on your side.  The only thing you can tell is that your
-side wants to say it is hard and you'd prefer to go shopping, while the
-other side wants to claim it is easy.
-
-An alternative style can be used by setting the `merge.conflictStyle`
-configuration variable to either `diff3` or `zdiff3`.  In `diff3`
-style, the above conflict may look like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-<<<<<<< yours:sample.txt
-or cleanly resolved because both sides changed the same way.
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
-or cleanly resolved because both sides changed identically.
-Conflict resolution is hard.
-=======
-or cleanly resolved because both sides changed the same way.
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-while in `zdiff3` style, it may look like this:
-
-------------
-Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
-or cleanly resolved because both sides changed identically.
-Conflict resolution is hard.
-=======
-Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
-And here is another line that is cleanly resolved or unmodified.
-------------
-
-In addition to the +<<<<<<<+, `=======`, and +>>>>>>>+ markers, it uses
-another +|||||||+ marker that is followed by the original text.  You can
-tell that the original just stated a fact, and your side simply gave in to
-that statement and gave up, while the other side tried to have a more
-positive attitude.  You can sometimes come up with a better resolution by
-viewing the original.
-
-
-HOW TO RESOLVE CONFLICTS
-------------------------
-
-After seeing a conflict, you can do two things:
-
- * Decide not to merge.  The only clean-ups you need are to reset
-   the index file to the `HEAD` commit to reverse 2. and to clean
-   up working tree changes made by 2. and 3.; `git merge --abort`
-   can be used for this.
-
- * Resolve the conflicts.  Git will mark the conflicts in
-   the working tree.  Edit the files into shape and
-   `git add` them to the index.  Use `git commit` or
-   `git merge --continue` to seal the deal. The latter command
-   checks whether there is a (interrupted) merge in progress
-   before calling `git commit`.
-
-You can work through the conflict with a number of tools:
-
- * Use a mergetool.  `git mergetool` to launch a graphical
-   mergetool which will work through the merge with you.
-
- * Look at the diffs.  `git diff` will show a three-way diff,
-   highlighting changes from both the `HEAD` and `MERGE_HEAD`
-   versions. `git diff AUTO_MERGE` will show what changes you've
-   made so far to resolve textual conflicts.
-
- * Look at the diffs from each branch. `git log --merge -p <path>`
-   will show diffs first for the `HEAD` version and then the
-   `MERGE_HEAD` version.
-
- * Look at the originals.  `git show :1:filename` shows the
-   common ancestor, `git show :2:filename` shows the `HEAD`
-   version, and `git show :3:filename` shows the `MERGE_HEAD`
-   version.
-
-
 EXAMPLES
 --------
 
@@ -406,6 +286,7 @@ linkgit:git-reset[1],
 linkgit:git-diff[1], linkgit:git-ls-files[1],
 linkgit:git-add[1], linkgit:git-rm[1],
 linkgit:git-mergetool[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

