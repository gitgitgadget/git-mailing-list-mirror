Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544F2E737E
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143865; cv=none; b=DSCSIgDNCoyuvCfdplYpYLsQ3SnwEuSePNonGrO8Ta+GJLMB4tom/oysNqfkcKx1qmOZRClD2Q4NdyimidR9/y68/+HqCia1vKdxAdVlMqBM+Sr+rPCLRamZLlmjeqedH205J5SLM3cxKcAwnTNAPtK5WbU7a/biPl3BH7v7cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143865; c=relaxed/simple;
	bh=kX4HM1BoD9IvcRmQ2eDWIeFgQbEN5JNjviAnkFmNcLY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A4NzczDbvFWBcPj8a2ciHwbmY+0aMV2h3Cvwbvvy+D6usGndpLaxrWf7q9PmII8W4DkC4dfSZylyEQHRNCqv2HUhNC/kCWuTVNoFhuhxw1Ma/8KpgFVx3tfuAut9v282fgLwqC7XOJo0kCtgu3z5Sf7+9t5DEGa88aP744Z7n74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtWkFW+W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtWkFW+W"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1061967a91.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143863; x=1787748663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=waZqAWN6KaA2aCjlmBNrkEVHEx+v09BuUVhkMlLdyj4=;
        b=DtWkFW+WMYmiHAklcY9VsvTeSeCdaI8jJoqGSAczlWnj53alrqxpGSCi5STgGRERr6
         4aQ3OzH5GbxmDBu10Pw3dTEm/iEW2yK3jcURdOtn9LPNwMisEHpkriduwi7ZvKhO1bMl
         KNxYfZWXSJyWfYsQzbHvTtfNcFwQDcqbO5L2dEFdYfUiqjyfZ3Y0iJQPRTdX0AVR9XT6
         3RVug3vxIG8Mac8fJ3sUrHNWYWiwlTEumEJyQVvzxJYQi9GvNzpWTe4JHCBhgMnF1nCH
         fGD1F3zAJ1Tr0s7dp2+SIrUC/amJSgIb8CWVAQigfWQ/AWYZMLrniZKV3t3OH/5jbsYD
         /ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143863; x=1787748663;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waZqAWN6KaA2aCjlmBNrkEVHEx+v09BuUVhkMlLdyj4=;
        b=EIPexzBmzTAeJE1178Qg7UaKTv6bwR6nSKzIX3kTwQysZtO0PAmGdGaxUaYUbAVUSu
         EGlPqpYpL3yD31rCOg+LTCd1EQoylKtsywPLytnEp9/qiIdusCffkgZqq7FSt77ku4Jt
         718TK6J4zE8uWxrwDkGg5e+DOeJ8MTLbJFM8uTfG1arXyLTt7yGnPmX+9MAkA/1QQEJN
         TB/FzmZeeXrwihCXGthCGje/wHQ6wPAXEGYznQjNimKxphs7CAl1/C0ATj0IUVxkfCyM
         XFH9EOdQLR/DNp7w96omC7pql1yWUYncIjAYaKIDsozZ4wa3Zwob6HtNlY/pv64r2p72
         VfMw==
X-Gm-Message-State: AFuF++kLKK54F5geKJ54XFZPa5Csx9dY0lEKQdmu2OUvtA1AFTiTsmhA
	Ys0T+A9NtTrA3F5KMMXMmQ8j19XUaW1pexoEdAX1qtb+rKDsUReDWpQs7mfXEA==
X-Gm-Gg: AR+sD11cdBYOzc0nnjVuWo0elwpOnyxmruB/JAaWLt+Nn0MkeZ1Hf0aVCVdgnzbkL4w
	K2Ku352rQ5sxfVjTvGFP8HCP0nln26zMz1XqJQS6ODMNVQbmCJ5jQJKY9wQIuxfbgR33IuBUAWH
	XtaSTSo0d7OQj9KFvIflTgv+78dNGyuomBUSgf0hNOY5PuWNaQFzamzDXL3PzWvQqub1/+pxYTD
	KdYl0WUf5WvijAAB0edRuUVXT+tA42ecD7iCav0DMudljDJOs00qsRoYUykF5hA9ozvCvo09flB
	PaElCBdAkcav+9oHduxQpVXeIxS0RqQ9zugOtRg0Wf/IYAzUqwN9VVl2CgdTtzWx0frM7F7JjiD
	tD7cMCs+YGxhQhkcsmnRokScrazT+JiD8K8uY5OpBWkuJCcnQmtapXn8jUEH6Zsv5TvpPY+eF/Z
	1Xen+XykbT2FldGoHd/CIjv565P/NbV0B8TAyYbVeFdXg94YkvGuBLxjMCBYI=
X-Received: by 2002:a17:90b:384d:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-395810cda44mr8641466a91.15.1787143861579;
        Wed, 19 Aug 2026 05:51:01 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.76.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae14162sm6861883c88.9.2026.08.19.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:51:00 -0700 (PDT)
Message-Id: <pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 12:50:56 +0000
Subject: [PATCH v5 0/2] worktree add: improve message for ambiguous remote branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add ../foo-dir bar-topic' fails to dwim when there are
multiple remote branches with name `bar-topic'. But it doesn't display
meaningful message as 'git checkout bar-topic' does under the same
situation.

We improve this by adding advice and modify the error message for worktree
add.

By Junio's suggestion, we include matched remote names in the advice. It is
applied to checkout, too.

The changes to 'checkout' are almost identical to what Junio proposed; I
have made minor adjustments to use the specified branch name. I'm not sure
how to handle the "Author" field in this case, so I've set it to myself for
now, but I'll correct it if that's not appropriate.

Yoichi NAKAYAMA (2):
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name

 builtin/checkout.c      | 75 ++++++++++++++++++++++++-----------------
 builtin/worktree.c      | 36 ++++++++++++++++++--
 checkout.c              | 14 ++++++--
 checkout.h              |  5 ++-
 t/t2400-worktree-add.sh |  4 +--
 5 files changed, 96 insertions(+), 38 deletions(-)


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v4:

 -:  ---------- > 1:  b838fdabb7 checkout: improve message for ambiguous remote branch name
 1:  f7c413b588 ! 2:  777862235e worktree add: improve message for ambiguous remote branch name
     @@ Commit message
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## builtin/worktree.c ##
     -@@
     - 	"\n" \
     - 	"    git worktree add --orphan %s\n")
     +@@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch)
     + 	return NULL;
     + }
       
     -+#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
     -+	_("Matched multiple remote tracking branches, you can list them by:\n" \
     -+	"\n" \
     -+	"    git branch -r --list \"*/%s\"\n" \
     -+	"\n" \
     -+	"If you meant to create a worktree from a remote tracking branch on,\n" \
     -+	"e.g. 'origin', you can do so by:\n" \
     -+	"\n" \
     -+	"    git worktree add -b %s %s origin/%s\n" \
     -+	"\n" \
     -+	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
     -+	"consider setting checkout.defaultRemote=origin in your config.")
     ++static void advise_ambiguous_remote(const char *path, const char *branch,
     ++				    const struct string_list *matched_remote_names)
     ++{
     ++	struct string_list_item *item;
      +
     - static const char * const git_worktree_usage[] = {
     - 	BUILTIN_WORKTREE_ADD_USAGE,
     - 	BUILTIN_WORKTREE_LIST_USAGE,
     ++	advise(_("Branches with the same name appears in multiple remotes:"));
     ++	for_each_string_list_item(item, matched_remote_names) {
     ++		advise(_("  %s"), item->string);
     ++	}
     ++	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
     ++		 "<remote>, you can do so by:\n"
     ++		 "\n"
     ++		 "    git worktree add -b %s %s <remote>/%s\n"
     ++		 "\n"
     ++		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
     ++		 "consider setting checkout.defaultRemote=origin in your config."),
     ++	       branch, path, branch);
     ++}
     ++
     + static int add(int ac, const char **av, const char *prefix,
     + 	       struct repository *repo UNUSED)
     + {
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
     + 	} else if (ac == 2) {
     + 		struct object_id oid;
     + 		struct commit *commit;
     +-		char *remote;
       
       		commit = lookup_commit_reference_by_name(branch);
       		if (!commit) {
     --			remote = unique_tracking_name(branch, &oid, NULL);
     +-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
     ++			char *remote;
      +			int num_matches = 0;
     -+			remote = unique_tracking_name(branch, &oid, &num_matches);
     ++			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
     ++
     ++			remote = unique_tracking_name(branch, &oid, &num_matches,
     ++						      &matched_remote_names);
       			if (remote) {
       				new_branch = branch;
       				branch = new_branch_to_free = remote;
      +			} else if (num_matches > 1) {
     -+				if (!opts.quiet)
     -+					advise_if_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     -+							  WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT,
     -+							  branch, branch, path, branch);
     ++				if (!opts.quiet &&
     ++				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     ++					advise_ambiguous_remote(path, branch, &matched_remote_names);
      +				die(_("'%s' matched multiple (%d) remote tracking branches"),
      +				    branch, num_matches);
       			}
     ++			string_list_clear(&matched_remote_names, 0);
       		}
       
     + 		if (!strcmp(branch, "HEAD"))
      
       ## t/t2400-worktree-add.sh ##
      @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '

-- 
gitgitgadget
