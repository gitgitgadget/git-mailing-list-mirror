Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CD33CE86
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259842; cv=none; b=NsiUkF79hZUhAN0U9AVSxFte7Phx82vURVPE5U3vB/CXQ+Yy89tRtygtGD5jU2aSI9n8H8VZB7TgDV0+LJIXsvth9knCSQNC00l5NPakJY6TvcwtDx+d8w/S5i2GDR1kgYULq+ar9f8u+qnyxrTP9vxNVXXX6tEYvx3yVonEBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259842; c=relaxed/simple;
	bh=e4CbwGiVQ2My3uq7pPUHvXXVw1yAbBNgSTl8duu13mk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uUTlOc7Mt9vdvGfnPVCMigmhCtvZDwlnGIlWLCgiRO9RWrZPGZeoifJ4epI0fTwAVlOLmC3PIsikoT+zop2/LEZFteNIgQ9CzGQodT7syWSwE+fliNPpUTace7RY1NLyCmv3456JhV/bKrb5ZK6JCcAoLgX4ZY2r/S2JMeQY5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqHM7yI6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqHM7yI6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so337289a12.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259840; x=1787864640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4F5owZGGqSgaVXJinsULYEBGmFs/GdBKfmSV43N5HiY=;
        b=CqHM7yI6Uaqjd/nc+4ZfU551qnFbDyEmLCJPcrJlcvBlTgS92uraLXzHeznbl2L0pm
         6DCtIRPvG2DD4nMRZ3Sz372rrs5BD7LHF22ELuwj7rwnNOs2oWNgQwkwP4KtpR9WMM8I
         EMXE0vyxeAX9ES9litx46SNtY4YUgci6Fe5KqpRuXOgHYGwizNm0kaCK8M/iYk8+D67n
         FabXS+5WBc4Z+0dsfyPiXoyrBUCIg4UhSTrHQHWwwgpU3wwnBPgVgk/0g1rtwkD2wvbM
         0RSohh+O3ZQfICKPmKKXgg59Z2NG4JkT32hiCw1+2+wCD7cNUu94u7wz6StzeowPOjDq
         y1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259840; x=1787864640;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4F5owZGGqSgaVXJinsULYEBGmFs/GdBKfmSV43N5HiY=;
        b=Ky0cgA0auNztnA1pCINi6mCyPoBl6USDA/bMXkuJkolRwXRm9BQit95QS6T2GVEh6x
         b9otUnO6B415RdgDQKXE9QUOvv2wawhEgp+BOxX+mVoAos27roB5Y+fL6HV9Iv2M0BjH
         8UU5cxdaAgBzZCeM6i9S6m2lxMzwLL2Gi8fNLNmFnKnrg3p+qat+BjubtBgyfzfVrEQj
         e+DIUisdCw6OwmMFT8Y0LLYpObgNemTwi7NQ1UoQBwXN/MHiSeZj2SfF2VlEOj52R97S
         4MB1f+t5uxrwVjW3dOl3AHgs8+OXK4E5FiDRa6H22XhQ4reHtfcqNqGEq+lPc+CLgzEu
         ux7A==
X-Gm-Message-State: AOJu0Yxz7uLWkauzZXt9BIDkAdETDF1qbISzqoU/731Nz92NhbcujBvk
	ezrAKR/+Z0F9fOgkH9ywtG60ydKZjjvZ0aGnHMJdG4RwEpeJCIa7//QXmAyrZg==
X-Gm-Gg: AR+sD11/o5MejTHV3nzEOn/tP4LNPY4RTxCA3UAlq7Hm3tUTG1Yu7VQ7DwSv9nYc081
	Ir7DYATS1KcOQOI5HYTQ5oVKHgA2akI1cnJsPMrKEyxa0eYWLnDWMZtA0yf/UlK22MQp2hfvBvz
	A3AY3RKBhB8f748yFpn8V4iU2G0tRy9QTGty6072tGcFfOuoa/e1YewNaj6YqNaBMIluYoOpWWm
	KDSDH/q4e5WR5vyxpqb+IcM6IRhTUeUszmo5zmhh6P+ZdVapQQnaHwCyzB7Et/5QluDt+UP9pDj
	P6Fptm4m8EAscpIMpOR5D5/ROoaR68+PvIFlIxbRW72u/p1h16xZ26gjL69RXRxyndNgUvTY8Rz
	4i28M5eJMhTarlDUautPbr7pGAtEl/91DP+vELJvk3bAFPx+Zrqwx/YfKLg5fAKdzDxK7+mBZyN
	ABKUaltbTrtY6XvoCQpwFX5y0lC+gZ34uIv0Iz7jbsVksAiFZY/XRmdHe2CpdJ2HyWYip9WS8=
X-Received: by 2002:a05:6a20:da11:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cd2fd037c6mr2642826637.2.1787259839811;
        Thu, 20 Aug 2026 14:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cb5a9831sm12642465eec.21.2026.08.20.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:03:58 -0700 (PDT)
Message-Id: <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 21:03:55 +0000
Subject: [PATCH v6 0/3] worktree add: improve message for ambiguous remote branch name
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

Yoichi NAKAYAMA (3):
  checkout: extract function to display advice for ambiguous remotes
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name

 builtin/checkout.c      | 76 +++++++++++++++++++++++++----------------
 builtin/worktree.c      | 37 ++++++++++++++++++--
 checkout.c              | 14 ++++++--
 checkout.h              |  5 ++-
 t/t2400-worktree-add.sh |  4 +--
 5 files changed, 98 insertions(+), 38 deletions(-)


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v5:

 -:  ---------- > 1:  e3f7d88520 checkout: extract function to display advice for ambiguous remotes
 1:  b838fdabb7 ! 2:  97e99ae31e checkout: improve message for ambiguous remote branch name
     @@ Commit message
          To make the advice more feasible, we will provide matched remote names
          for the specified branch name.
      
     -    To achive that, we add an optional feature to the
     +    To achieve that, we add an optional feature to the
          `unique_tracking_name()` function that allows the matched remote name
          to be exposed to the caller.
      
     @@ builtin/checkout.c: enum checkout_command {
       	CHECKOUT_RESTORE = 3,
       };
       
     -+static void be_explicit(const char *branch,
     -+			enum checkout_command which_command,
     -+			const struct string_list *matched_remote_names)
     -+{
     -+	const char *cmdname;
     +-static void advice_disambiguating_remotes(enum checkout_command which_command)
     ++static void advise_disambiguating_remotes(enum checkout_command which_command,
     ++					  const char *branch,
     ++					  const struct string_list *matched_remote_names)
     + {
     + 	const char *cmdname;
      +	struct string_list_item *item;
     -+
     -+	switch (which_command) {
     -+	case CHECKOUT_CHECKOUT:
     -+		cmdname = "checkout";
     -+		break;
     -+	case CHECKOUT_SWITCH:
     -+		cmdname = "switch";
     -+		break;
     -+	default:
     -+		BUG("command <%d> should not reach parse_remote_branch",
     -+		     which_command);
     -+		break;
     -+	}
     -+
     + 
     + 	switch (which_command) {
     + 	case CHECKOUT_CHECKOUT:
     +@@ builtin/checkout.c: static void advice_disambiguating_remotes(enum checkout_command which_command)
     + 		break;
     + 	}
     + 
     +-	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
      +	advise(_("Branches with the same name appears in multiple remotes:"));
      +	for_each_string_list_item(item, matched_remote_names) {
      +		advise(_("  %s"), item->string);
      +	}
      +	advise(_("If you meant to check out a remote tracking branch on <remote>,\n"
     -+		 "you can do so by fully qualifying the name with the --track option:\n"
     -+		 "\n"
     + 		 "you can do so by fully qualifying the name with the --track option:\n"
     + 		 "\n"
     +-		 "    git %s --track origin/<name>\n"
      +		 "    git %s --track <remote>/%s\n"
     -+		 "\n"
     + 		 "\n"
     +-		 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
      +		 "If you'd like to always have checkouts of an ambiguous name prefer\n"
     -+		 "one remote, e.g. the 'origin' remote, consider setting\n"
     -+		 "checkout.defaultRemote=origin in your config."),
     + 		 "one remote, e.g. the 'origin' remote, consider setting\n"
     + 		 "checkout.defaultRemote=origin in your config."),
     +-	       cmdname);
      +	       cmdname, branch);
     -+}
     -+
     + }
     + 
       static char *parse_remote_branch(const char *arg,
     - 				 struct object_id *rev,
     - 				 int could_be_checkout_paths,
     +@@ builtin/checkout.c: static char *parse_remote_branch(const char *arg,
       				 enum checkout_command which_command)
       {
       	int num_matches = 0;
     @@ builtin/checkout.c: enum checkout_command {
       	if (remote && could_be_checkout_paths) {
       		die(_("'%s' could be both a local file and a tracking branch.\n"
      @@ builtin/checkout.c: static char *parse_remote_branch(const char *arg,
     - 	}
       
       	if (!remote && num_matches > 1) {
     --	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
     --		    const char *cmdname;
     --
     --		    switch (which_command) {
     --		    case CHECKOUT_CHECKOUT:
     --			    cmdname = "checkout";
     --			    break;
     --		    case CHECKOUT_SWITCH:
     --			    cmdname = "switch";
     --			    break;
     --		    default:
     --			    BUG("command <%d> should not reach parse_remote_branch",
     --				which_command);
     --			    break;
     --		    }
     --
     --		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
     --			     "you can do so by fully qualifying the name with the --track option:\n"
     --			     "\n"
     --			     "    git %s --track origin/<name>\n"
     --			     "\n"
     --			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
     --			     "one remote, e.g. the 'origin' remote, consider setting\n"
     --			     "checkout.defaultRemote=origin in your config."),
     --			   cmdname);
     --	    }
     + 		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     +-			advice_disambiguating_remotes(which_command);
      -
     --	    die(_("'%s' matched multiple (%d) remote tracking branches"),
     --		arg, num_matches);
     -+		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     -+			be_explicit(arg, which_command, &matched_remote_names);
     -+		die(_("'%s' matched multiple (%d) remote tracking branches"),
     -+		    arg, num_matches);
     ++			advise_disambiguating_remotes(which_command, arg,
     ++						      &matched_remote_names);
     + 		die(_("'%s' matched multiple (%d) remote tracking branches"),
     + 		    arg, num_matches);
       	}
       
      +	string_list_clear(&matched_remote_names, 0);
 2:  777862235e ! 3:  dcb84a69a6 worktree add: improve message for ambiguous remote branch name
     @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
       	return NULL;
       }
       
     -+static void advise_ambiguous_remote(const char *path, const char *branch,
     -+				    const struct string_list *matched_remote_names)
     ++static void advise_disambiguating_remotes(const char *path, const char *branch,
     ++					  const struct string_list *matched_remote_names)
      +{
      +	struct string_list_item *item;
      +
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
      +			} else if (num_matches > 1) {
      +				if (!opts.quiet &&
      +				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     -+					advise_ambiguous_remote(path, branch, &matched_remote_names);
     ++					advise_disambiguating_remotes(path, branch,
     ++								      &matched_remote_names);
      +				die(_("'%s' matched multiple (%d) remote tracking branches"),
      +				    branch, num_matches);
       			}

-- 
gitgitgadget
