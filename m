Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764302;
	b=Gj6vAFxPZiXsehbsS2mXBHLyalVm4qz78geMOHzpnNkcXbktbg3W/n5xXQr6/dnr0PiT
	 WCvBMgTA8/5t+CesRS4CEnXc/SBBtV3g+taT5FPUoXtgvSTGvGojUJ9Mka7/k2EO8W9bl
	 3pmoUQJR5C9xlE5C9rJz7cBOBG334BE8voRlDEZWloc1mb04WJmv2nQC6i7eO7XzhTD0s
	 6FJ1PqKzthzQB4idIO/5qJaLGN/Dp/m2Y6EYWKPfsKDmKjnCMi5wHxWVCqOF0/wB0wy9V
	 I+Ir1mNZ+daGrSEC6vBm4U+j65uBRZZ6BfksGdUXEiKXoyWxsxTVVUY7JiE/CHKBbew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
	b=TK8ucJRhpqQePw7ROkyUsutDo7CuUgsLxGI8DygucG5txwnEMAR19pc9IJEhHCKGrh1r
	 7Odg+dtitn/rtMvaf/wjQCjlJOI//iyTWv1LTfNT8mSa6EAUDtuUdfkFi5QRNJ2VB7OlX
	 CnG6t9HAzuxpKxe5XD6Nrm2QtCvnOEMfZD+R4EBTQhpLmn2xo+/SCtv0HJEZeZ1iOmmDe
	 CZ1E/halCxXgrPDYhH1Dx40QwNgslLuI5Qu/zfh0nkUV5ZivNgKKGhzEZV/rWWQE1TLPd
	 LO+iSdyjrtX3LsrJKM2+jvNGxa1A4K0mVJOjtfLzE5hhep4DscGNc/bdX3ShGjrWMEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GV0IMgup;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B75606A325
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B75606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GV0IMgup
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364c951da4so8019881cf.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764300; x=1793369100; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=GV0IMgupjJrCLVuCqe5DcfflPPS1n0zEXV7NhhtUAYSknrGxF6AtUX7aatq9mK003U
         9od+A/JX1UrStmR6ge1iYD0403aT3mp+m5YHwGnncX7aRndYssrqJXrzEbzWpUkiX1dV
         78dfe1totuooh8C+LRA9xyK3brM/4V+ZZNCfuq6LFp2eRt4kbLekjqVDDsROvp1KHgVx
         41gXKkZy0Mh1lgeFAe+jTZmldq8szMn5ETrOF/eHPnGqEb353alP1N8p0gB5hTI+XQmL
         beDCcrZxj6+D7Epv022ZVrXbBXk0r14LOeSHRDHgTZh6cixXEqXDS8XzP4kmyzb6QMmz
         Wr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764300; x=1793369100;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7Uh+pWqPKvAUTaGhd5kOTyN5HRS0QYmdbI4NNYYCM8=;
        b=RiVq+jxnt8iQxQ5FdiIOWjG3SHgq8MFxJurqZusNXWEiJEelzvTKCgmffqMrmx+dkL
         cmmFa0vc1D0hxnxlVoONPQA+Qw2VY/Suu/+SUepHCsQ9XEVsRSofOhdIVw/xocukgo2d
         VIhnerF6kfjeJQykg3Vnl1ogNU8jKucvQnRtm0OkN659yDhLemAOCtuSA3PxiFybn1/a
         zlVYJTgUG8Iv4huepOGgW3/iN8KQXZpSkAwEdnwYtOboJxOeUJSoeOakAGJY8f79AgGN
         +fJBY7oaqF6JrokhpN+axrZhqvRNKJGInp/XacpCPKPIu+t4N3LYrr8igLh5zxNxIxPY
         MidA==
X-Gm-Message-State: AFq9FYJirVj9Ebyo7BcKBJ+zjF+ZaawrZK0koHc5SJKVMP+xWymLI9aG
	OqAsSmfiEOjTiuAYYTfPnfNo7IQ+lfKTaVMecj93VdXiTUDum485Q6jlKlKkIvB2vl4=
X-Gm-Gg: AYBFou1xDHwOpcDdtzhRFcT6HSq8EkaCEaiYObXmfyJ5m1YtrEBfuYJYMOq7GQD0JlF
	6lWDDppYfZH49u26LxOY/Go3M32PJ3IloP6RACUyMCmC1hsRfonZB0Ua/lHwfEwsM4jL1p7P918
	13UX313t3hWQDCdGjs82m5LOFSPfZfB7ymoeHFXICM4HXWqaELLTCi7H5rHaHBj66QLn9ojbAFs
	M9NlrkwrUfja0dwlv57smF55tBsj+YVbTWDmCG2IBppYJyOHcjq2C1xxLBFqV2R+EG8CRdIpoXC
	x6+homee9Y8Bqi6MMoZZ9GmMIIbtIXl9eCsOlsivrK3fXIw75g5i71pxH9LspQ9Ovmj4H2/amYa
	8VQ32pxeuGgSGbhbpYf43f1e1vTwucIIbHMX/V45Nyfw/sdaodkBBYR47AYwVzCz56LuPaWfGYm
	G7w47zWdg8tkMjcAfcCzOMCJfTj4WCHxxqtbb/1SLv4eIZrmsmMxPiMCVseMJlJI49XgBwqx/dO
	9MTCCVXkuA2N77LzpqNVm9XZ+XrBBiZUkhaFcIRKwOUQ/rAb2qzIqlMpg==
X-Received: by 2002:a05:620a:2691:b0:93f:3343:8026 with SMTP id af79cd13be357-93f6f91e3dbmr448900885a.29.1792764300025;
        Fri, 23 Oct 2026 07:05:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940476255a1sm24995185a.17.2026.10.23.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:04:57 -0700 (PDT)
Message-Id: <6862cb4f04350e5b4443c1b93539794660cc56fe.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:49 +0000
Subject: [PATCH v4 2/6] doc: git-merge: link to new merge conflicts guide
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

