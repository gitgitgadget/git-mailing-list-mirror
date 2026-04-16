Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C371DE894
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357260; cv=none; b=NkWJ3TG6diX9Scti9J0eKxxBr4N5jHGGAmPYYAEmuy/9ChY57RutYHl8R2tfrbmQ2dBInbczlX84w2A5jgPnBZipLafnPOcta5822Q5F030wA0NrWUMRjl0vOz1iVgdEyohg7VTnD5YO+xetxoZmqGcKC0LDIYC9BfH9PMIAPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357260; c=relaxed/simple;
	bh=6yLGLGdNT/btWSr+wkwW2HhjI5a6xJzuzZ3EVjtC8bU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Auca5JybLl9GCtIwiQ/E6ThCpN+PwAgFn4Ht9ino+faOsqs4o1iCvSoBiQBzLjwiXtp7l1DRQX71HCZoKW5wxAUJCtnzeYX2SxH2rzqwS7ZuhLsULmEswR+TAvD8US/iaa2EeS8LrIbhnUZk2ey5YBTpje7NlIQfeFoickfyQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DILGrogy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DILGrogy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so126878735e9.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357258; x=1776962058; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeCVzeql+c596VUl2Zt4k9G3frieqG1PFrCvUbsXOW4=;
        b=DILGrogypn7OtJqYH//DJ5OnkkbTZjUwmpFEuXqJPOQa5x1DWSwdP68E3ZiK4udnXC
         1B8HjjTgHkTkXVeof4dSErmOE5KaxOw4mX3SkM5XNU1XhqPrLhVFec3LKAzCbmVstgna
         irjwJmI2571k1NJeBIyVxjhVaiibN9szyc1pHc0Pi9MqtzNDuemnTqYCRe+n3POG0OYt
         k2ViM0sBMMM3RzO1VsJzUomLWCY0YwGtdBanAQk0soNW67t7COLog6QaX17cPAsyG8mg
         q7s6hvOzT693vgq+3uJ8AUTV7nrgx7QacSmnqaW4X8fkpDiWQ1YHgEbsmW1CYWwLbU7f
         v4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357258; x=1776962058;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeCVzeql+c596VUl2Zt4k9G3frieqG1PFrCvUbsXOW4=;
        b=pzhF8ZfY9RH1/ckqZHWBuo9sqzfNjXoBdYzu4E/yn+tSa/UNjWbNU21ucQC/zlTvIr
         AUmz61HmOCB9RSWtSu8DC+Y+DUuWEi9fdyOsySsSaj6fsLNKNglomO6NSnfoqLhNCVjg
         5ynMumZHZ5tcrsl2e/QUS7D0cTBN1D7v2CeVNjrSAs98z5TyGdSeQUYbgrcgCu4MB1/u
         RKb1B4oUW/56BnIo1T7lZTPUp/EsJIFwUs47w6dgqWvnMAVLZgiOuuntkQJYSJZ3Z9QC
         ZvYrv96ZA/dLJk7othcAEwVAyv1NIyIlq9SzKLjz1D6crltLPimNtepEOGVBnBLokgF9
         1FRA==
X-Gm-Message-State: AOJu0YxsBRtE6RuWudUN1axKzMEej857dDvEkIniNUvBKQe2Jo+xQOnE
	L2VRwj7Ohick22K52jgOZV6RLkO2grWCrSf00x998pVKfAl2i3L/XWHC8y0C9A==
X-Gm-Gg: AeBDieteSYX6dwb7/pbwtbookRZ6bVbSCZ5m+p4C7kdds+tpqezLgyBwo5iUxy2/R37
	xrPBQwh6wRSa5rXKU5jM6WFybewnEevfAUEnJswyp9XCu61e0eCruJfyfmIsIgbPY4WU4jVXoOH
	omSEPZiCCr7FBdFSIpqCDkG9sfHU46awHE9Y5SXqHcPibSEuJpzRcS2SNsDFghntRb32uTVbVKv
	l4QfVB3zHjwKoQuWurXi6Ze8EgEZpFVbS356mVode7BMoua441IhfX551gRHrS4w42WfwtcULZ8
	ndmFFklcIOomBEdukWGmueLeFqI6gciYEXPvuTTnGKFWkbwvOMxy3pl+eegt7QeDU8invJgQ1wm
	TW0cg3zczBJko7uEGPbjMi1yam6P3oDgNlruGK/DjFLS6sJnAi1gO0q+XKMq+sx5T2PDLBE3yqJ
	LVHZ22gTHSxGhaU5UNuxAVsDJ6C1gSFHUXsig0BGESlQfwFJYhzMvsI9bP2wVXMnMshG58UFG8G
	l/53S16yKq+et5JSaDzSkRU91c=
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr370231115e9.28.1776357257482;
        Thu, 16 Apr 2026 09:34:17 -0700 (PDT)
Received: from RTX ([79.117.197.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fa6727d6sm1557385e9.7.2026.04.16.09.34.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:34:16 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:34:14 +0200
From: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] worktree: add --recurse-submodules flag to worktree add
Message-ID: <aeEPGNJ0Ge72l94j@RTX>
Reply-To: CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

git worktree add leaves submodules untouched: the linked worktree is
checked out but its submodule working trees are empty.  Users must run
"git submodule update --init" by hand afterwards.

Add a --recurse-submodules flag that does this automatically.  After
checkout_worktree() succeeds, a child "git submodule update --init
--recursive" is run with its working directory set to the new worktree
path so that $GIT_DIR is resolved correctly.

The flag is incompatible with --no-checkout (nothing is checked out, so
there is nowhere to put submodule working trees) and --orphan (the
branch has no commits and therefore no submodule configuration to
follow).

Signed-off-by: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
---
  builtin/worktree.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4fd6f7575f..f3dacb0e5c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -123,6 +123,7 @@ struct add_opts {
  	int checkout;
  	int orphan;
  	int relative_paths;
+	int recurse_submodules;
  	const char *keep_locked;
  };
  
@@ -593,6 +594,20 @@ static int add_worktree(const char *path, const char *refname,
  	    (ret = checkout_worktree(opts, &child_env)))
  		goto done;
  
+	if (!ret && opts->checkout && opts->recurse_submodules) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		cp.dir = path;
+		strvec_pushl(&cp.args, "submodule", "update",
+			     "--init", "--recursive", NULL);
+		if (opts->quiet)
+			strvec_push(&cp.args, "--quiet");
+		strvec_pushv(&cp.env, child_env.v);
+		ret = run_command(&cp);
+		if (ret)
+			goto done;
+	}
+
  	is_junk = 0;
  	FREE_AND_NULL(junk_work_tree);
  	FREE_AND_NULL(junk_git_dir);
@@ -823,6 +838,8 @@ static int add(int ac, const char **av, const char *prefix,
  			 N_("try to match the new branch name with a remote-tracking branch")),
  		OPT_BOOL(0, "relative-paths", &opts.relative_paths,
  			 N_("use relative paths for worktrees")),
+		OPT_BOOL(0, "recurse-submodules", &opts.recurse_submodules,
+			 N_("initialize submodules in the new worktree")),
  		OPT_END()
  	};
  	int ret;
@@ -842,6 +859,12 @@ static int add(int ac, const char **av, const char *prefix,
  	if (opts.orphan && !opts.checkout)
  		die(_("options '%s' and '%s' cannot be used together"),
  		    "--orphan", "--no-checkout");
+	if (opts.recurse_submodules && !opts.checkout)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--recurse-submodules", "--no-checkout");
+	if (opts.recurse_submodules && opts.orphan)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--recurse-submodules", "--orphan");
  	if (opts.orphan && ac == 2)
  		die(_("option '%s' and commit-ish cannot be used together"),
  		    "--orphan");

