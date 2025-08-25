Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EF27E076
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148942; cv=none; b=iV5ImX+1bVQxsDNSWdFVB6wORnQFFDBMT8S3fRwsshCgFY8mG+79WQ6soqz0T58ss9tEqm/jpuE4+eIJklh6LVH+MiYaDc9ta0chuEyHwOKF1k0Mq3rjv//yp/JFi4bKzWkEnJECuDI1GIfBFy+VRkNpaO3MbYAfw/C6kOa/MMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148942; c=relaxed/simple;
	bh=rJLqSNi9Z1TpM5LoHa4cojdEfC4HoSW2mw5wkztk23w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BDV9sLfa7qMN+vVTztfC2ryfpv+dn2zA8z538nk9wvOFHvOP2byZc9WUrp1o3cEO1+8LkUV36ixGOQgz3dV3RZGpfdL9mD3XM1/4mN9mSA/pg6WaYdOX8FNp12BuY/sKZqsb/GVYS2tsCw0Xt0BdHxFBQN1NDpwv+T11Vj2X1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/yEOv+3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/yEOv+3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso2612305f8f.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148939; x=1756753739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTgD6xgDP/IV5c9yhqf+mSTNRuP09ztJlPdLraqJE+A=;
        b=a/yEOv+32NgWPAWnyFBolS1yRhqM9aviPyc201RJH1X7ME3bRVU0b66oe15Fq1zQ30
         XW/g5oTsOQE0XpoB/g6femfBXIJous9wwdZ9yoZMw9TRHh07EE+Tx4UkCEd6Pdx7c/gM
         HXxQvLMJV545TLvU8ZjLYh44klUjuDkzglfQqf3yftdKAQV4Wr8MvrZmqr9EGn89m9v2
         8L03WpPD7bDHy2q4Mez32G6g8w66gLmshkbEHw00de6cnvDly5YCXvQssFdk4578r4nJ
         4uwxDrLF4Jlaj7Gmf/MO669cD4SZSXKjZqamZgEkbxqbbWOfQrKWrSf2lRqZ5UVX6ehU
         zFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148939; x=1756753739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTgD6xgDP/IV5c9yhqf+mSTNRuP09ztJlPdLraqJE+A=;
        b=ts4HnmsbKAJCk85ZXHmjVjaFuI89Bt+3XsSxxVNTWn+hGN7prpWNz2uOYtkPhAy/O4
         Lun45vHIzSACdcRrM30EPHla+gskMH/FveST3MZlm8BV/AdXhYeR8rv0qKlAYZ4/qJ9a
         eAS5ILutJqmkK1h+170JuQBKzLaCHebU5evlbsrrRcHBEnXr6+0Uw+jizAt4X8kCUYJ4
         YYDv49F3L6n07cz4q5LTo5bGPTOs03L39+Yc2SVbmOgmaTvO58elN6rp02OHN78haXhw
         w7Vfshon+QrOToVMyD2MFNCozQedzy4MyatS9/x9iw8Gp0YtjLLvb9C6vf0VMHMtBNvl
         22FQ==
X-Gm-Message-State: AOJu0YzvLaC7OywoxOwophcEPDXsj2qeWAFAf1X6ch7Hr23DT4QaMA81
	ELcZBzs0mWkLdHhAOeFLuakxN8oJmXt/Mj19zwhd7Gpv0imzN737m7IOyCm7Bg==
X-Gm-Gg: ASbGncs7TTe+KYdPZBTEF1yt7rFOsKhi9/YfBTNxLt4CUkaEGH9OJ3ZUw4V3ERqaseV
	G/kCS2x5hSn7BDVUPev+0TJOgtWLjicFaB3LUlmI0VGdJ7PDXALYoy2qfvDoA7ywpSvJFT7ZU4m
	rQWDWYHn8k2uo0nvwF71MJAjudH18mSi+bS4SBIlXFoVbdEkGubr77L5DDukm+CDhTO/XBLvGJN
	NBr/DzURMngUTmlLlrLTdmsKdHNpt+FSC/4ulTg3P8vjqvu82zV084rjZNnUHnm6b3SbBkqB8kn
	M/Mu2BrB52g61fLw+bzdbeAceqH5aaFxJ5pKdiiBEqsbhneji7Qyt8d/uazFxCEz4/ifnm4NKgX
	jZTheNxd6+u1hQJSEwmx8QJyXjts=
X-Google-Smtp-Source: AGHT+IF1N60vjCNYo/5vforTCcDxFpxBHSjAlzsuLwsuoPAAKTFpp4Qw/MDReGEzghYXOcf07ThKzg==
X-Received: by 2002:a05:6000:288e:b0:3b7:9214:6d73 with SMTP id ffacd0b85a97d-3c5dbf69b9dmr10692520f8f.20.1756148938803;
        Mon, 25 Aug 2025 12:08:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6612c5b0sm436405e9.5.2025.08.25.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:58 -0700 (PDT)
Message-Id: <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:53 +0000
Subject: [PATCH 5/5] doc: git-checkout: clarify restoring files section
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Use the term "Restore" to mirror `git restore`
- Many Git users do not know what a "tree-ish" is. Clarify by using an
  example of each case, and by saying "commit or tree" in the text
  instead of "<tree-ish>"
- Many Git users do not know what the "index" is. Instead say "stage the
  file's contents" where appropriate, since Git often uses "stage" as a
  verb to mean the same thing as "add to the index" and it's a more
  familiar term.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index b343d292b30b..9f2b86ac5368 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -82,20 +82,21 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite the contents of the files that match the pathspec.
-	When the _<tree-ish>_ (most often a commit) is not given,
-	overwrite working tree with the contents in the index.
-	When the _<tree-ish>_ is given, overwrite both the index and
-	the working tree with the contents at the _<tree-ish>_.
+	Restore another version of the file(s) that match the pathspec.
 +
-The index may contain unmerged entries because of a previous failed merge.
-By default, if you try to check out such an entry from the index, the
-checkout operation will fail and nothing will be checked out.
-Using `-f` will ignore these unmerged entries.  The contents from a
+If you specify a commit or tree to restore from (for example `git
+checkout main file.txt`), this will restore the version of the file(s)
+from that commit or tree. This overwrites the file in the working
+directory and stages the file's contents.
++
+If you do not specify where to restore from (for example `git checkout
+file.txt`), this will replace the file(s) with the version from the index.
+If you check out a file with an unresolved merge
+conflict, the checkout operation will fail and no changes will be made.
+Using `-f` will ignore the merge conflict.  The contents from a
 specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
-
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
 	This is similar to the previous mode, but lets you use the
 	interactive interface to show the "diff" output and choose which
-- 
gitgitgadget
