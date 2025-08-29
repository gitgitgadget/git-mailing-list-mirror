Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF730314A60
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467945; cv=none; b=jBl3DbhSPmTEaDAxvNZGA2gGkuLzZfRQiieyJO2xWJXRtlhMyST6gwd25dGGKcRZYCnXJd5aV5qoBFm826YAahXmXmrmEp7aYCUdEwogkEBeuE0e6YmsD18uOqBR4ZjI0hpDtbnb4WrePoE/KtTzSZ2oQQ0/x6dt6y35OG6nmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467945; c=relaxed/simple;
	bh=vjkzOqhJ+NNxQOfCTL+NTydKBVye4+AfgiVMBN7uhMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nxU8ir6DqTOjrTWiC3deljCcN+6dvw8FTrao9kI/yQscR9wQzrr/4BHccPGv44W03uOS+Y9/BBH0MJW4Qhl7umpX39awKGd4xmP0U+W+jFFLH/nZx4F1x4wQbb4431EcYKOSQcZJpoMSgWWFTKWyBSa7fipcApVwl8jrLn55M8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey3CBxTU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey3CBxTU"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70df91bdc53so13307696d6.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467942; x=1757072742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRi80fmboFgw5P+aXXDQjmf/YzIXEvyhIqZh12MFWl0=;
        b=ey3CBxTUszA8Ts+rvN4JxIzUqY/O2XO+fz/rN6/hWP+8aF04b6NQC0txi5nYmGRSUV
         8Oxsta7M1XcCZnNnNpBa47VJ4bwurtUxFGyRQe3xSi45fNuygEuCrEC9KqPFOajhoe3E
         gM/vwThP43kC96LwshGlmnYfTiehpGDR/K4/L1WjzsENt31nNXJwLSeOFlkdHNiNr1zR
         D8RtKGlOtkjllC2voEO3TFeEPGkWMIUPUKaEsmry9vQZXzm8pD4nEqIpU8oZakZZrdmY
         DI2nXFIoKkVay/1HhD+T5scxm5ZroapecD0ol9+S8797lsxxTZUtwCohE2A+a9fHCl43
         Bekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467942; x=1757072742;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRi80fmboFgw5P+aXXDQjmf/YzIXEvyhIqZh12MFWl0=;
        b=XKuNweyUltb6IiKBsvq3DRsJvzw65DQtYGktAHw58p4sSHTjoC1wSQ/jgvX/kpYfNJ
         u1x8KQbZf2JTFIZmPonE/iCpJlRf2siY4D74iVXUrrX7WroM3d51uQp4azapnduhwqdo
         uIsv6KUNCiuZepY0TKexKgGQbkcm8BVW+ddseThyAjE3tgFio4JPYxBz1kebWTi3+UD7
         xHb4MgTZrdd9HKo8x0l0kDRkfrBrBnhWRH2I/Q0UuiaZptIqQGsgV0FKyDfdQnvF16VU
         VntEXV5inExm2YHMkTGBWNyutXi/9zexe9bTs/gtl4RgKj9vVcBIdS76o06uLhFdZAm9
         0u4g==
X-Gm-Message-State: AOJu0YylspCj5Y4UCeeT1pmSnA3B3XPw2iVALOjkbL10h6dyPTG9Yu92
	gzIGipd2M1raB+4180JfZdVBKnD8vKOaaBp7VQ4HoXjN753B3VYxlyTgi1yuadVegaY=
X-Gm-Gg: ASbGncvP3EfvdsvnsIGfmAneXyjQl9NZGVX0iLx6jKuOBCZ7XnVlDl76G0uJhuXHOlM
	Ww5XhoI3K+mn5dlId1J1Hr7jryP1+CNCuFbNTxQpF8kwfQiLmaliZgcAp7BXFKrCzDimE9He1+8
	Lebf5ETvt7Pqzu6pxzneByYhKz4e8ari/z1uAD/0jGQRsfgyNfcULjkoLYXTZWsLRdR+lVHUW1P
	NmrQOnvNBsV0gqJuPupxhL7064FlPnKUvtZs2X2dOAJuI+AWuGD2IZKNhfRRK+bgrJevDWGbHNA
	b5e7upI/8KI9xxfAnPL4NSzskT+y9XEkYCovJDRMtKnTk0t61CtsmqMVitFjIaroAest9/fZ+mh
	tv6Gxt7jumFMM5hmSzUxku8jt7nrNotBywg==
X-Google-Smtp-Source: AGHT+IF1aBLUIrMCURmk2FWvlx9RuvV+JPEzpSni/wlZDNPv23lttvV2YX9TSzizh6h7qQgXGFxo7g==
X-Received: by 2002:a05:6214:2483:b0:70d:f384:4266 with SMTP id 6a1803df08f44-70df38442d7mr66532696d6.59.1756467942210;
        Fri, 29 Aug 2025 04:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e624d1750sm13670106d6.41.2025.08.29.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:41 -0700 (PDT)
Message-Id: <9c0119e70d6bdb49a8b46ae74e12c4827a7a9173.1756467934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:34 +0000
Subject: [PATCH v2 5/5] doc: git-checkout: clarify restoring files section
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Split up the forms `git checkout file.txt` and
  `git checkout main file.txt` to match what's given in the SYNOPSIS
- Remove `-f` from the SYNOPSIS for the second form, since according to
  this man page it is not relevant in that context
- Many Git users do not know what a "tree-ish" is. Clarify by using an
  example of each case, and by saying "commit or tree" in the text
  instead of "<tree-ish>"
- Many Git users do not know what the "index" is. Instead say "stage the
  file's contents" where appropriate, since Git often uses "stage" as a
  verb to mean the same thing as "add to the index" and it's a more
  familiar term.
- Use "Discard unstaged changes" instead of "checking out paths from
  the index" where relevant

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 45 ++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 4d522a5f75..dababe452a 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -12,8 +12,8 @@ git checkout [-q] [-f] [-m] [<branch>]
 git checkout [-q] [-f] [-m] --detach [<branch>]
 git checkout [-q] [-f] [-m] [--detach] <commit>
 git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
-git checkout [-f] <tree-ish> [--] <pathspec>...
-git checkout [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
+git checkout <tree-ish> [--] <pathspec>...
+git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
@@ -75,25 +75,36 @@ that is, the branch will not be created or modified unless
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+`git checkout <tree-ish> [--] <pathspec>...`::
+`git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite the contents of the files that match the pathspec.
-	When the _<tree-ish>_ (most often a commit) is not given,
-	overwrite working tree with the contents in the index.
-	When the _<tree-ish>_ is given, overwrite both the index and
-	the working tree with the contents at the _<tree-ish>_.
+	Replace the specified files and/or directories with the version from
+	the given commit or tree.
 +
-The index may contain unmerged entries because of a previous failed merge.
-By default, if you try to check out such an entry from the index, the
-checkout operation will fail and nothing will be checked out.
-Using `-f` will ignore these unmerged entries.  The contents from a
-specific side of the merge can be checked out of the index by
-using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
-file can be discarded to re-create the original conflicted merge result.
+For example, `git checkout main file.txt` will restore the version
+of `file.txt` from `main`. This overwrites the file in the working
+directory and stages the file's contents.
 
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] <pathspec>...`::
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+
+	Replace the specified files and/or directories with the latest
+	committed or staged version.
++
+This overwrites the file(s) you specify with either the staged version
+or the version from the current commit if there is no staged version.
+For example, if you've been editing `file.txt` and you want to discard
+your changes to it, you can run `git checkout file.txt` to replace it
+with the latest committed version.
++
+This will fail if the file has a merge conflict and you haven't yet run
+`git add file.txt` (or something equivalent) to mark it as resolved.
+You can use `-f` to ignore the unmerged files instead of failing, use
+`--ours` or `--theirs` to replace them with the version from a specific
+side of the merge, or use `-m` to replace them with the original
+conflicted merge result.
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
-	This is similar to the previous mode, but lets you use the
+	This is similar to the previous two modes, but lets you use the
 	interactive interface to show the "diff" output and choose which
 	hunks to use in the result.  See below for the description of
 	`--patch` option.
-- 
gitgitgadget
