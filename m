Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1227E076
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148938; cv=none; b=p8EZmdrzWe38sIBRvS73zQ1TKFCvTBnG7sNCJ1KPRhlyewrNXids19CzjOoImgQy6MRl+LFfLpjj/tRaoMAzChdZu5VW6sGQeaZ+BB6s79zx/0QARi82ha9sMAHeTq0J/zDsZmEcqMP5Uu9Ycx0duwFg2COn/Vry27B20sNEO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148938; c=relaxed/simple;
	bh=yGSZTuBus2HqKIEA26k4LLn92l0JJhDXx1yGT1uKwEM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mdv2i1Bzo+gB4hlJznTlWok3+OOr+DgwkewPgHAGPBMmrlC3BxOBv+gcroEj1Z0A3bkRkKj4co+JzPQo9xdjOrkwrQGOSsyQXlnVS+Zqe/rjT31kj7MADwfZ/Dr0WgRhhG247azcqJ25vU85cKaLFJfD0k9fPb1MDPfj/fJOlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfM3dMQ7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfM3dMQ7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b6278893eso3227935e9.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148935; x=1756753735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Io7tSVjwaG5g5L8b9AGclzjNcrzYgEEZfBYYSZMV4o=;
        b=MfM3dMQ7QK0jZ5KcTQ/7P+pHx/dTk619DcMcABGSG6zk7PiHpFRg0ZlvxS9hfBwx6Z
         eTpls9BduducOQZ1RlSh385SxgrpNoXcgSqHjf3cETA8Q4JqHOZ0YLXCjNxMbPg7n37h
         /2X+8ER7wrwaB/jEepme6HIktPPZQ5U87UuWLTHHXpjG0UuU3qlKBfZ+FbjcBfjGaBCl
         1vRFoP+77znaFDAwClzrnvYgHwI4XeO1xXGhiqoxhVaFNqwpI1+wlsxxxiwBGfnEOO58
         8ZZP9Nrq2lv2k2w+EldCDQNmL0v/TCvtCxMh2HURlq8ncM0SgnrE0dosMIPCvXQD+alg
         TXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148935; x=1756753735;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Io7tSVjwaG5g5L8b9AGclzjNcrzYgEEZfBYYSZMV4o=;
        b=xERCl8A+uZ1K+u7687Kw4RbW9JPC8UV6JYlD7wjhi9NWYe1I4WbybILYiGPZBrRXpN
         IfJrx2JEUnJIV2i59mta4k86IXD9DR/eWcnRZy06MAWYWXjwAb8BmWn8cY47rs4YxQ0S
         QHzHQo0gDwJOBNUmk5KOK708DheyXStP7N5NovFQLrcADse8X/6PbtHgG9dOgAjy4GKo
         6A2krSKoONaM1Lq4IYdEBJSMj3I5G5zBzFpJ7uK8vXVvTENeetpXUSUsiVrjfU/CKxoo
         Z1IQViNLUGT+taEHvuYnG3WJoitco8Voo3aBoO2/h38ymLPNvaCxP+Idxg5G2ubxHawd
         +fGA==
X-Gm-Message-State: AOJu0YwwPOER7S5iHH0BUQBdD0BleMTfby3aQyOOpkKcWVPFC9khe2vR
	fD4rEXGk85RqtC3ZqGRohDP5J389Py+jjJPz/8f7jSq6RiVgdw9Veafuvgq+Tw==
X-Gm-Gg: ASbGncsQ4JwbLZfsLC0h4OHeW5PoKea9t7LP/DahbB3JO/G0xX2c7Fii72wk9d3P/xu
	TRntlvotKBJG4goRIunw76q6E5ysMgkpLq9rkunCmNUxNyXVSeFg6mSFn1DCQssFEaTRN3AaKvR
	Mnr81ZSowKOUlUg73UkiI8NT3VwSAwi+9LnMEmBD/df9qGP8AjyDXYhCpquNbzZmkcLpouUDQD5
	S69Kce8rr327sn82zKxd3fcXDSmgCPOelWw6/MwDDQA0S7qfrG3c5qS7cI0vYN9rbFF51H/lvdt
	SEyrMi/RG71upqegMyaoM/mV+Xvm6Y61Q+z+lgFyXWbMgMC+VmZJ1VuQ916e8Pcuq7nNqzr5g8J
	5c1ZLXgjwpbjDZvTwBlRcpPkqjiY=
X-Google-Smtp-Source: AGHT+IEOV1tThVsAahKb++D35px2AJ4CVqSGM/3b3kap4L06fG3QdQ1uD4GV3kXDZvsv9avhFhKG+w==
X-Received: by 2002:a05:600c:450a:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-45b517ad7f8mr79066875e9.14.1756148934955;
        Mon, 25 Aug 2025 12:08:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef568e5sm12542749f8f.25.2025.08.25.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:54 -0700 (PDT)
Message-Id: <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:49 +0000
Subject: [PATCH 1/5] doc: git-checkout: clarify intro
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

- Many users do not understand the terms "index" or "pathspec". Clarify
  in the intro by using an example, so that users can understand the
  basic idea without learning the full definition of "pathspec".
- Use the terminology "Switch" and "Restore" to mirror `git switch`
  and `git restore`
- Reference (and clarify) the ARGUMENT DISAMBIGUATION section

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 40e02cfd6562..ddda891c0ff7 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -20,10 +20,14 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, `git checkout` will
-also update `HEAD` to set the specified branch as the current
-branch.
+`git checkout` has two main modes:
+
+1. **Switch branches**, with `git checkout <branch>`
+2. **Restore a different version of a file**, for example with `git
+   checkout <commit> <filename>` or `git checkout <filename>`
+
+See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
+Here's a description of all of the modes:
 
 `git checkout [<branch>]`::
 	To prepare for working on _<branch>_, switch to it by updating
@@ -511,14 +515,17 @@ $ git log -g -2 HEAD
 ARGUMENT DISAMBIGUATION
 -----------------------
 
-When there is only one argument given and it is not `--` (e.g. `git
-checkout abc`), and when the argument is both a valid _<tree-ish>_
-(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
-or a directory whose name is "abc" exists), Git would usually ask
-you to disambiguate.  Because checking out a branch is so common an
-operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
-in such a situation.  Use `git checkout -- <pathspec>` if you want
-to checkout these paths out of the index.
+When you run `git checkout <something>`, Git tries to guess whether
+`<something>` is intended to be a branch, a commit, or a set of file(s),
+and then switches branches, switches commits, or restores the files.
+
+If there's a conflict, you can use the double dash `--` to distinguish
+between branches and files:
+
+* `git checkout <branch> --` will force Git to treat the parameter as a
+  branch name or commit
+* `git checkout -- <pathspec>` will force Git to treat the parameter as
+  a set of file(s)
 
 EXAMPLES
 --------
-- 
gitgitgadget

