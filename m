Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08461339398
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221893; cv=none; b=J80Rn1Cs+48pesLBjWiD+dtk0dvLPtVQHoNKQme5RnSKRj/st/nKP2AnPs5EQNoT5vUSfQY50QjDZWDYMD1r6Sn+X7S1/yXc+6lJzuUdelGo6L0aNwBfoayalQoFa6spoSicT1MgQ6fBN66w2we1bJYrdcGbV9kuU47bTJgJUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221893; c=relaxed/simple;
	bh=4F5kc6ytFrcuk7i9Pucef54vaVosDjzELGLEUas4elI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jmDZqpV1PivZUkjhEl5gP8n6dspW269Qw5CVwrGJr3y5HQfJJoGsXv6gs2ZJCvWf+6Ts6l774rYXcFDTENA92qoqZAFqfq6GVkCoc3r96+ZLoF6QBr+DEw7ChZGVP94gEIIqk2w7k3h4YSIydzHSxBA38XO26KbyiQV60kaapVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5/KWspv; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5/KWspv"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f0e5e36912so14204996d6.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221891; x=1787826691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4p5Q1lX61jnou3WisU3/yk2BXnf54y61IUtOCOhxxq0=;
        b=k5/KWspvNtitJflQorQqUILjnA2MMtR2xxaocmwVkqPZX68LEVDSX8WKfb052iuOcG
         I+4cfTceg0NW/vjeS6PI9gwOxB6pv1KkEyOUfOk0Rt9eORQzpt5R6ESIrLFBjAqYJe3t
         tOA5Vv05zM54V2r49hnK03F8ZmbmYVxrAoz4IBoHB2nkZ6NvCblZmP17oxscz9/J6f3d
         BLJUXQF+G/2SJKGtFx/k0dLmjdeTh+uVRRMd6P0oHj/kk4mGqqUfK+3DUWzkiD/wBpGh
         axzEWl/wG7UmFDPLBPqqCem4RYZXRxqjC0cDDHDyhDKlarGJAkggwG7uVxyQZHzelgNS
         bhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221891; x=1787826691;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p5Q1lX61jnou3WisU3/yk2BXnf54y61IUtOCOhxxq0=;
        b=IzZv+c4rZXSwt5NjabWRB/e0+pGRZBHGgUpZ2HyiiS6iwG/odUbO2jk8+AqHMDoBuo
         aNHM6jl5VlOQtVNo13O1hnakZK/taz1yQ83eNFrvC8nWxTH17GU3cpkKdtsiL5y/RIee
         gzSWVgmhCLV3gkCCx0gsWx+n24SkSHhZjAb2dDCkyS75pGtbgPws9jEaoVdtnr58ezfb
         GyUKbNk6KzMOeCe++iaxCtd0Wy7Zinwy1JNCs7I7mmdAc5tuUL3qbsxmHhE2h2A0NEZp
         onUBsUJteFZjgMwiO6WHxE0yYs/m0Z/nAVWkmwWHDviEGRFmMMVLRFcWl+0iLqJ04D5L
         Gmvg==
X-Gm-Message-State: AOJu0YwnyYtY8KqtDRBIVmcQhpJBuwpMpwD7684ivlowU68KJbCqfYtp
	3G1rbfdZtUvF/NyIMyWRl3GOW4AxpJ/7YEc6GLDSTezENIw3AcgwaN2R14lhtQ==
X-Gm-Gg: AR+sD110SavcC1q5BgFDvUqVrejew77vNkm8xxjNImytQfGhTvmNnya10w0G30HnjcU
	+jrZ4nw3flkXg5lOgaY3WPvYXfzfLxmBBpAkNRvbAmSACI4iNfE4exOGCZ5xXQCvMdNACRVBHeN
	uUD5OPdrNuh7iyYDHle8egL9WaxeKWgJ7uOTvmmezm9hIDq6mHrnclJDuU0KBX+jOVaH7Hml5S5
	HyfswlK9NsyrAWUeddCT1ZQNXMcRBmQJ2AzxZQVpM6CLNjI3MlYm7TdQjvi8nme0RHni3gxiAOV
	rccEfRGIJmbAZ1+DU2+Lbl/BDjOEEgXhdFOkZWq3EuE8hFgBCwZ4vbcl9x/y6RkoUYm+stMJCQM
	OSrkCFwJgfy+5lmyI4r/NHFl+nFI869QLLi6/DkW6aDCw/XLdhJzswQBXCbGrfKz20sVzgYfnvY
	VfzSrw2fvFAvCneI81khChEGCAiUvcP6+N26eTtQYFoXxC31Y9F5dydddV/a7hP4Lg
X-Received: by 2002:a05:622a:148c:b0:51c:164b:b242 with SMTP id d75a77b69052e-52dd57bfa81mr90555661cf.15.1787221890674;
        Thu, 20 Aug 2026 03:31:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.175.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd86f33b5sm28284641cf.19.2026.08.20.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:31:28 -0700 (PDT)
Message-Id: <pull.2192.v4.git.1787221888406.gitgitgadget@gmail.com>
In-Reply-To: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 10:31:28 +0000
Subject: [PATCH v4] worktree add: shouldn't dwim if -b or -B is given
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
Cc: Jacob Abel <jacobabel@nullpo.dev>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add <path> <branch>' DWIMs <branch> to a
remote-tracking branch when neither -b, -B, nor --detach
is given.

However, 'git worktree add -b <new-branch> <path> <branch>' can
still DWIM <branch>, causing <new-branch> to be ignored.  This is a
regression introduced by 128e5496b3 (worktree add: extend DWIM to
infer --orphan, 2023-05-17), which appeared in Git 2.42.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: shouldn't dwim if -b or -B is given

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2192

Range-diff vs v3:

 1:  477ea27c8b ! 1:  512b037bb7 worktree add: shouldn't dwim if -b or -B is given
     @@ Commit message
          is given.
      
          However, 'git worktree add -b <new-branch> <path> <branch>' can
     -    still DWIM <branch>, causing <new-branch> to be ignored.
     -
     -    This is a regression introduced in v2.42.0
     -    (128e5496b325640f0a09cc1d5b1e346c069b410f).
     +    still DWIM <branch>, causing <new-branch> to be ignored.  This is a
     +    regression introduced by 128e5496b3 (worktree add: extend DWIM to
     +    infer --orphan, 2023-05-17), which appeared in Git 2.42.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
     + 
       		/* DWIM: Infer --orphan when repo has no refs. */
       		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
     ++	} else if (ac == 2 && new_branch) {
     ++		if (!strcmp(branch, "HEAD"))
     ++			can_use_local_refs(&opts);
       	} else if (ac == 2) {
     --		struct object_id oid;
     --		struct commit *commit;
     --		char *remote;
     --
     --		commit = lookup_commit_reference_by_name(branch);
     --		if (!commit) {
     --			remote = unique_tracking_name(branch, &oid, NULL);
     --			if (remote) {
     --				new_branch = branch;
     --				branch = new_branch_to_free = remote;
     -+		if (!new_branch) {
     -+			struct object_id oid;
     -+			struct commit *commit;
     -+			char *remote;
     -+
     -+			commit = lookup_commit_reference_by_name(branch);
     -+			if (!commit) {
     -+				remote = unique_tracking_name(branch, &oid, NULL);
     -+				if (remote) {
     -+					new_branch = branch;
     -+					branch = new_branch_to_free = remote;
     -+				}
     - 			}
     - 		}
     - 
     + 		struct object_id oid;
     + 		struct commit *commit;
      
       ## t/t2400-worktree-add.sh ##
      @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '


 builtin/worktree.c      |  3 +++
 t/t2400-worktree-add.sh | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..15a1c9624a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -897,6 +897,9 @@ static int add(int ac, const char **av, const char *prefix,
 
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
+	} else if (ac == 2 && new_branch) {
+		if (!strcmp(branch, "HEAD"))
+			can_use_local_refs(&opts);
 	} else if (ac == 2) {
 		struct object_id oid;
 		struct commit *commit;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..ba3bec078f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> does not dwim with -b' '
+	test_when_finished rm -rf repo_upstream repo_dwim wt &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	(
+		cd repo_dwim &&
+		test_must_fail git worktree add -b branch ../wt foo 2>actual &&
+		test_grep "^fatal: invalid reference: foo" actual
+	)
+'
+
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&

base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
-- 
gitgitgadget
