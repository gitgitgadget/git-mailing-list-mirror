Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747720;
	b=w3OQMVb+OKCUBgtp1t3X91F60vLanhnNDfL7uQGqwLP2uItflziaMYoczBFdYIHn8yex
	 /c+JtKDiWi7tLs41j1Buti7ZezfLltkIL6h4lfqzZvZXAmhohFyDtyAPboyowqqT255Vp
	 qrR2JA+4BYwvS25dYTC7oFXLkJZFP1w0KWcrj6jMABc03zBJkUyydOTmBZiOI8TASevxY
	 i1rlvFh5laZQz4cF0j7B24chVWWy3n1whGrUiijeX5/w0nEr/IDqDLBqLEdL6qUeahWSI
	 UxRdfTSfJNSI6FrBvvyI0MfSxnDPR3M7x3JB9u4N8HK7C0Hp5uw7MPq07nQf6LvedpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=fxTwom2kAN5fMOfNwtqKlGUwosRIvnDm1aSJFsPlzh4=;
	b=gJRlsVbA1Lw5dsrmMujZYC0h53479giUkyB7Qe4WpuhKSEgod5ZmVMYpmWjiDKCWJef2
	 zttk9QHlcjmvxTUzBgF0ylQgkL/f6jp0kQcUMvIQZce7hzJHP8arXlzuHfJV81z7uW+Ew
	 J1Qy/g9o9z4OUyqfehNXOqDgw9qMf06qny2aKmCw81SVTMqDCKNL2SNy2xKMDSrkWCjP/
	 n0UIyvvHo0eYLRuoHB6vgYEE0J9V9jex41ssaOPJJTpR20brIrG9vLKFAQ8bkwVusRCc8
	 JZxwyFESnMO7t/E73omFHhX/1TXEjieS9IddwigLN062ds7kT2lbYsEzzfaOEJhB8aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXuifPRe;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6C606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 02:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXuifPRe
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso101482346d6.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 18:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795747718; x=1796352518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fxTwom2kAN5fMOfNwtqKlGUwosRIvnDm1aSJFsPlzh4=;
        b=uXuifPReequK+uRrqoUWCxpgfKQanETUdj1WwRk7NmsYte8CVcUVp5PfVihq4iG4ZT
         cKwW7id9UGQPo04kQwcb4NrBPZMByq0Jww9a/8UlwxOOIC0cL3xwg5YawyOc5WHijOHX
         3OehQVhFb/r/KF1SwBcrm2sZiru6Kfvk2D6Yumlnhd3LObwyxKJsFRpp3+7QN/B/vWVx
         55NmKk77UenEqSrpDYVyd+2RM/C1zDWC/nsFKD7MFaDFdAiymWzBRkt9nN6GSu5qsiWH
         1CEudpi5XVHv0RRiqL3reWgbcGRTJwj5zkPxKlgetJhIiF7xG0YUMOybBiIbX+F++Prs
         3BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795747718; x=1796352518;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxTwom2kAN5fMOfNwtqKlGUwosRIvnDm1aSJFsPlzh4=;
        b=CS5tiafYeekCuu7TF1AJeIjN6+EL4cTdEOTS9f/9Dc/Kq80Pw8JX57pLxCqoBte7fM
         vPBBtf/rTqVrtFKblacZhFtP8he/fx5Pd/kMXhXXdNK1Zka32kk5F3rfKVL9OLgxiFpP
         HPeJrCwPFBC0zvMOi9jh+DsS7JrYngScaTNjtStOYnFSzRHEBfYmDeAbeo9gQIqYYylV
         /Gajz2bQrMElabY4fKcQlHnSafPqkYkh6HEzoFrVKsb+qLQEBAbhGMhp7tMXTVJ/0NAt
         0ImdNO7BrMv+DSIVSO0Ofacw0z6okkDsfIiqegyncmJmv4VUfMBxj9mHNTxwZoAWaKKb
         CgGg==
X-Gm-Message-State: APuU4Z81bkrk309Sb7Vo2dD3KRNk36vkj7R259/Eg/71kWQ5qKpxNunl
	jSPhpTLzp2vR8P1jfWwNpSmhrgIiAhHd/sJqu2HtH1FM9O4vEiVKrQkaHa9hTQ==
X-Gm-Gg: AZFdTZf6djKqRF3pbCZiw4e0Ex1hlU3fD2bkkVcUaXD3e5+ye6bH3aguhgJhbf1Oh8o
	BO2XgHvCfUkRWCjmDLXnrhE5ZUBhb6f+8pgbiL6RbuZYaJUjs/fckglqP+sK3rnYAXTuDKU57uw
	8WNceUEgPaIEDzBVhD20vunLZL5b10aBadpJT4YaaaY3GtqtifrITxIha3pLivrrr33uNegrDI1
	RYyD6b8LhEUZYVm2dH16qgjrvDItRG6W6PFOFCM1FzH/4Jnq96BByiotwATu7ohBtDFdQo9qoI2
	Rqw9oF4eJ0Rn7ByPA8KJ3CHbyRl3u8r5jEwYUEilfLK6goSoKrEm1OVC9Kk0gokNpQtwygAhItk
	zaA8mHu1pLJdQclDPVimfnCtcoKScI2W9WJIYWH/MCOuDuMqz6r/S9/+FmtNaU+aULA7nHoQvPp
	HSIb/vPCA2NNRA43AJS2WBtQ2Gz5TBUFPxOT+6OuMR8+wG0TNnNF730+ZU7p4Ux406K1I16OpKJ
	yM+0e9qWxlC8zgku1cxwmDaQ6QG+TZIvc5A+qHddN8vNBblaNCk+8eU0VbuMiPlBbYH+d2Lusfw
	s3Ziqw7/vQlvEsJgI9vj5FIhS55EnBA=
X-Received: by 2002:ad4:5d67:0:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-92134bb3187mr445522056d6.55.1795747718209;
        Thu, 26 Nov 2026 18:48:38 -0800 (PST)
Received: from [127.0.0.1] ([48.217.36.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d383asm204089626d6.22.2026.11.26.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:48:37 -0800 (PST)
Message-Id: <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com>
In-Reply-To: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
From: "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 02:48:37 +0000
Subject: [PATCH v2] push: shell-quote names in suggested push commands
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
Cc: Nahid Hasan <nahidhasan141400@gmail.com>,
    MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>

From: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>

Branch and remote names in Git may contain shell metacharacters such
as '&', ';', and '$'. When `git push` fails and prints a suggested
command to copy and paste, those names are formatted without shell
quoting. Copying that suggestion into a POSIX shell splits the line;
for example:

    git push --set-upstream origin feat-&-test

backgrounds `git push --set-upstream origin feat-` and tries to run
`-test` as a separate command.

Format the remote, branch, and ref names in the suggested `git push`
commands in `builtin/push.c` with `sq_quote_buf_pretty()` so names
that need quoting are wrapped in single quotes while plain names stay
bare. A HEAD:<dst> refspec is quoted as one shell word, and the
detached-HEAD hint in setup_default_push_refspecs() quotes the remote
name as well.

Signed-off-by: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>
---
    push: shell-quote names in suggested push commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2336%2Fnahidhasan141400%2Ffix-push-upstream-quoting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2336/nahidhasan141400/fix-push-upstream-quoting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2336

Range-diff vs v1:

 1:  5494c805c1 ! 1:  dad0b1673d push: shell-quote names in suggested push commands
     @@ Commit message
          Format the remote, branch, and ref names in the suggested `git push`
          commands in `builtin/push.c` with `sq_quote_buf_pretty()` so names
          that need quoting are wrapped in single quotes while plain names stay
     -    bare, and add tests for each hint.
     +    bare. A HEAD:<dst> refspec is quoted as one shell word, and the
     +    detached-HEAD hint in setup_default_push_refspecs() quotes the remote
     +    name as well.
      
          Signed-off-by: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>
      
     @@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
       	const char *short_upstream = branch->merge[0]->src;
       	struct repo_config_values *cfg = repo_config_values(the_repository);
      +	struct strbuf quoted_remote = STRBUF_INIT;
     -+	struct strbuf quoted_upstream = STRBUF_INIT;
     ++	struct strbuf refspec = STRBUF_INIT;
     ++	struct strbuf quoted_refspec = STRBUF_INIT;
       
       	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
       
     @@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
      +
      +	/*
      +	 * Quote for copy-paste into a POSIX shell. Ordinary names stay
     -+	 * bare; metacharacters are wrapped in single quotes. die() does
     -+	 * not return, so these buffers are intentionally not released.
     ++	 * bare; metacharacters are wrapped in single quotes.
      +	 */
     ++	strbuf_addf(&refspec, "HEAD:%s", short_upstream);
      +	sq_quote_buf_pretty(&quoted_remote, remote->name);
     -+	sq_quote_buf_pretty(&quoted_upstream, short_upstream);
     ++	sq_quote_buf_pretty(&quoted_refspec, refspec.buf);
       	die(_("The upstream branch of your current branch does not match\n"
       	      "the name of your current branch.  To push to the upstream branch\n"
       	      "on the remote, use\n"
     -@@ builtin/push.c: static NORETURN void die_push_simple(struct branch *branch,
     + 	      "\n"
     +-	      "    git push %s HEAD:%s\n"
     ++	      "    git push %s %s\n"
     + 	      "\n"
     + 	      "To push to the branch of the same name on the remote, use\n"
       	      "\n"
       	      "    git push %s HEAD\n"
       	      "%s%s"),
      -	    remote->name, short_upstream,
      -	    remote->name, advice_pushdefault_maybe,
     -+	    quoted_remote.buf, quoted_upstream.buf,
     ++	    quoted_remote.buf, quoted_refspec.buf,
      +	    quoted_remote.buf, advice_pushdefault_maybe,
       	    advice_automergesimple_maybe);
       }
     @@ builtin/push.c: static const char *get_upstream_ref(int flags, struct branch *br
       		}
      +		/*
      +		 * The prose keeps the raw branch name. Only the
     -+		 * copy-pasteable command is shell-quoted. die() does
     -+		 * not return, so these buffers are not released.
     ++		 * copy-pasteable command is shell-quoted.
      +		 */
      +		sq_quote_buf_pretty(&quoted_remote, remote_name);
      +		sq_quote_buf_pretty(&quoted_branch, branch->name);
     @@ builtin/push.c: static const char *get_upstream_ref(int flags, struct branch *br
       		    advice_autosetup_maybe);
       	}
       	if (branch->merge_nr != 1)
     +@@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remote *remote)
     + 	}
     + 
     + 	branch = branch_get(NULL);
     +-	if (!branch)
     +-		die(_(message_detached_head_die), remote->name);
     ++	if (!branch) {
     ++		struct strbuf quoted_remote = STRBUF_INIT;
     ++
     ++		sq_quote_buf_pretty(&quoted_remote, remote->name);
     ++		die(_(message_detached_head_die), quoted_remote.buf);
     ++	}
     + 
     + 	dst = branch->refname;
     + 	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));
      @@ builtin/push.c: static void die_if_repo_looks_like_ref(const char *repo)
       {
       	const char *slash = strchr(repo, '/');
     @@ t/t5523-push-upstream.sh: test_expect_success TTY 'quiet push -u' '
       '
       
      +test_expect_success 'no-upstream advice quotes a branch name with metacharacters' '
     ++	test_when_finished "git branch -D \"branch&name\"" &&
      +	test_when_finished "git checkout main" &&
      +	git checkout -b "branch&name" &&
     -+	test_when_finished "git checkout main && git branch -D \"branch&name\"" &&
      +	test_must_fail git push upstream 2>stderr &&
      +	test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}" stderr
      +'
     @@ t/t5528-push-default.sh: test_expect_success 'default triangular behavior acts l
      +	test_config branch.main.merge "refs/heads/upstream&name" &&
      +	git checkout main &&
      +	test_must_fail git -c push.default=simple push parent1 2>stderr &&
     -+	test_grep "git push parent1 HEAD:${SQ}upstream&name${SQ}" stderr
     ++	test_grep "git push parent1 ${SQ}HEAD:upstream&name${SQ}" stderr
     ++'
     ++
     ++test_expect_success 'detached HEAD advice quotes a remote name with metacharacters' '
     ++	git remote add "weird&remote" repo1 &&
     ++	test_when_finished "git remote remove \"weird&remote\"" &&
     ++	test_when_finished "git checkout main" &&
     ++	git checkout --detach &&
     ++	test_must_fail git push "weird&remote" 2>stderr &&
     ++	test_grep "    git push ${SQ}weird&remote${SQ} HEAD:" stderr
      +'
      +
       test_done
      
       ## t/t5529-push-errors.sh ##
     -@@ t/t5529-push-errors.sh: test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
     - 	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
     - '
     - 
     -+test_expect_success 'suggest quoted branch when the slipped name needs shell quoting' '
     -+	test_must_fail git push "origin/branch&name" 2>stderr &&
     -+	test_grep "hint: Did you mean to use: git push origin ${SQ}branch&name${SQ}?" stderr
     -+'
     -+
     - test_expect_success 'no suggestion when prefix is not a configured remote' '
     - 	test_must_fail git push not-a-remote/main 2>stderr &&
     - 	test_grep ! "Did you mean" stderr
      @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous refs early' '
       	test_cmp expect rp-ran
       '
     @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous refs early' '
      +'
      +
      +test_expect_success 'no-upstream advice quotes metacharacters only in the command' '
     -+	test_when_finished "git checkout main" &&
      +	git remote add "weird&remote" remote.git &&
      +	test_when_finished "git remote remove \"weird&remote\"" &&
     ++	test_when_finished "git branch -D ${SQ}feat-&;\$name${SQ}" &&
     ++	test_when_finished "git checkout main" &&
      +	git checkout -b "feat-&;\$name" &&
     -+	test_when_finished "git checkout main && git branch -D ${SQ}feat-&;\$name${SQ}" &&
      +	test_config "branch.feat-&;\$name.remote" "weird&remote" &&
      +	test_must_fail git -c push.default=simple push "weird&remote" 2>stderr &&
      +	test_grep -F "The current branch feat-&;\$name has no upstream branch." stderr &&
     @@ t/t5529-push-errors.sh: test_expect_success 'detect ambiguous refs early' '
      +	test_config branch.main.merge "refs/heads/feat-&;\$name" &&
      +	test_must_fail git -c push.default=simple push "weird&remote" 2>stderr &&
      +	printf "%s\n" \
     -+		"git push ${SQ}weird&remote${SQ} HEAD:${SQ}feat-&;\$name${SQ}" \
     ++		"git push ${SQ}weird&remote${SQ} ${SQ}HEAD:feat-&;\$name${SQ}" \
      +		"git push ${SQ}weird&remote${SQ} HEAD" >expect &&
      +	sed -n "/^    git push /s/^    //p" stderr >actual &&
      +	test_cmp expect actual &&


 builtin/push.c           | 48 +++++++++++++++----
 t/t5523-push-upstream.sh |  8 ++++
 t/t5528-push-default.sh  | 17 +++++++
 t/t5529-push-errors.sh   | 99 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..3908f5f532 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -18,6 +18,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "quote.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
@@ -155,6 +156,9 @@ static NORETURN void die_push_simple(struct branch *branch,
 	const char *advice_automergesimple_maybe = "";
 	const char *short_upstream = branch->merge[0]->src;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct strbuf quoted_remote = STRBUF_INIT;
+	struct strbuf refspec = STRBUF_INIT;
+	struct strbuf quoted_refspec = STRBUF_INIT;
 
 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
 
@@ -173,18 +177,26 @@ static NORETURN void die_push_simple(struct branch *branch,
 				 "won't match the local branch, see option "
 				 "'simple' of branch.autoSetupMerge\n"
 				 "in 'git help config'.\n");
+
+	/*
+	 * Quote for copy-paste into a POSIX shell. Ordinary names stay
+	 * bare; metacharacters are wrapped in single quotes.
+	 */
+	strbuf_addf(&refspec, "HEAD:%s", short_upstream);
+	sq_quote_buf_pretty(&quoted_remote, remote->name);
+	sq_quote_buf_pretty(&quoted_refspec, refspec.buf);
 	die(_("The upstream branch of your current branch does not match\n"
 	      "the name of your current branch.  To push to the upstream branch\n"
 	      "on the remote, use\n"
 	      "\n"
-	      "    git push %s HEAD:%s\n"
+	      "    git push %s %s\n"
 	      "\n"
 	      "To push to the branch of the same name on the remote, use\n"
 	      "\n"
 	      "    git push %s HEAD\n"
 	      "%s%s"),
-	    remote->name, short_upstream,
-	    remote->name, advice_pushdefault_maybe,
+	    quoted_remote.buf, quoted_refspec.buf,
+	    quoted_remote.buf, advice_pushdefault_maybe,
 	    advice_automergesimple_maybe);
 }
 
@@ -204,6 +216,9 @@ static const char *get_upstream_ref(int flags, struct branch *branch, const char
 
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name) {
 		const char *advice_autosetup_maybe = "";
+		struct strbuf quoted_remote = STRBUF_INIT;
+		struct strbuf quoted_branch = STRBUF_INIT;
+
 		if (!(flags & TRANSPORT_PUSH_AUTO_UPSTREAM)) {
 			advice_autosetup_maybe = _("\n"
 					   "To have this happen automatically for "
@@ -211,14 +226,20 @@ static const char *get_upstream_ref(int flags, struct branch *branch, const char
 					   "upstream, see 'push.autoSetupRemote' "
 					   "in 'git help config'.\n");
 		}
+		/*
+		 * The prose keeps the raw branch name. Only the
+		 * copy-pasteable command is shell-quoted.
+		 */
+		sq_quote_buf_pretty(&quoted_remote, remote_name);
+		sq_quote_buf_pretty(&quoted_branch, branch->name);
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
 		    "    git push --set-upstream %s %s\n"
 		    "%s"),
 		    branch->name,
-		    remote_name,
-		    branch->name,
+		    quoted_remote.buf,
+		    quoted_branch.buf,
 		    advice_autosetup_maybe);
 	}
 	if (branch->merge_nr != 1)
@@ -249,8 +270,12 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
 	}
 
 	branch = branch_get(NULL);
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
+	if (!branch) {
+		struct strbuf quoted_remote = STRBUF_INIT;
+
+		sq_quote_buf_pretty(&quoted_remote, remote->name);
+		die(_(message_detached_head_die), quoted_remote.buf);
+	}
 
 	dst = branch->refname;
 	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));
@@ -669,6 +694,8 @@ static void die_if_repo_looks_like_ref(const char *repo)
 {
 	const char *slash = strchr(repo, '/');
 	struct strbuf name = STRBUF_INIT;
+	struct strbuf quoted_remote = STRBUF_INIT;
+	struct strbuf quoted_ref = STRBUF_INIT;
 	int code;
 
 	if (!slash || !slash[1] || file_exists(repo))
@@ -680,11 +707,16 @@ static void die_if_repo_looks_like_ref(const char *repo)
 		return;
 	}
 
+	sq_quote_buf_pretty(&quoted_remote, name.buf);
+	sq_quote_buf_pretty(&quoted_ref, slash + 1);
+
 	code = die_message(_("'%s' is not a valid push target"), repo);
 	advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
 			  _("Did you mean to use: git push %s %s?"),
-			  name.buf, slash + 1);
+			  quoted_remote.buf, quoted_ref.buf);
 	strbuf_release(&name);
+	strbuf_release(&quoted_remote);
+	strbuf_release(&quoted_ref);
 	exit(code);
 }
 
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 22d3e1162c..23b20b0419 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -134,4 +134,12 @@ test_expect_success TTY 'quiet push -u' '
 	test_must_be_empty output
 '
 
+test_expect_success 'no-upstream advice quotes a branch name with metacharacters' '
+	test_when_finished "git branch -D \"branch&name\"" &&
+	test_when_finished "git checkout main" &&
+	git checkout -b "branch&name" &&
+	test_must_fail git push upstream 2>stderr &&
+	test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}" stderr
+'
+
 test_done
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 2bd8759a68..0c009f3543 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -294,4 +294,21 @@ test_expect_success 'default triangular behavior acts like "current"' '
 	test_push_success "" main repo2
 '
 
+test_expect_success 'simple push quotes an upstream branch name with metacharacters' '
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge "refs/heads/upstream&name" &&
+	git checkout main &&
+	test_must_fail git -c push.default=simple push parent1 2>stderr &&
+	test_grep "git push parent1 ${SQ}HEAD:upstream&name${SQ}" stderr
+'
+
+test_expect_success 'detached HEAD advice quotes a remote name with metacharacters' '
+	git remote add "weird&remote" repo1 &&
+	test_when_finished "git remote remove \"weird&remote\"" &&
+	test_when_finished "git checkout main" &&
+	git checkout --detach &&
+	test_must_fail git push "weird&remote" 2>stderr &&
+	test_grep "    git push ${SQ}weird&remote${SQ} HEAD:" stderr
+'
+
 test_done
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 5f8aa1ed19..57d50d8950 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -94,4 +94,103 @@ test_expect_success 'detect ambiguous refs early' '
 	test_cmp expect rp-ran
 '
 
+# How a POSIX shell splits a copy-paste command line.
+shell_split () {
+	line=$1
+	eval "set -- $line"
+	printf "%s\n" "$#" "$@"
+}
+
+test_expect_success 'no-upstream advice leaves ordinary names unquoted' '
+	test_must_fail git -c push.default=simple push origin 2>stderr &&
+	test_grep -F "The current branch main has no upstream branch." stderr &&
+	test_grep -F "    git push --set-upstream origin main" stderr &&
+	test_grep ! -F "git push --set-upstream ${SQ}origin${SQ}" stderr &&
+	test_grep ! -F "git push --set-upstream origin ${SQ}main${SQ}" stderr
+'
+
+test_expect_success 'simple push mismatch leaves ordinary names unquoted' '
+	test_config branch.main.remote origin &&
+	test_config branch.main.merge refs/heads/other-name &&
+	test_must_fail git -c push.default=simple push origin 2>stderr &&
+	printf "%s\n" \
+		"git push origin HEAD:other-name" \
+		"git push origin HEAD" >expect &&
+	sed -n "/^    git push /s/^    //p" stderr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no-upstream advice quotes metacharacters only in the command' '
+	git remote add "weird&remote" remote.git &&
+	test_when_finished "git remote remove \"weird&remote\"" &&
+	test_when_finished "git branch -D ${SQ}feat-&;\$name${SQ}" &&
+	test_when_finished "git checkout main" &&
+	git checkout -b "feat-&;\$name" &&
+	test_config "branch.feat-&;\$name.remote" "weird&remote" &&
+	test_must_fail git -c push.default=simple push "weird&remote" 2>stderr &&
+	test_grep -F "The current branch feat-&;\$name has no upstream branch." stderr &&
+	test_grep ! -F "The current branch ${SQ}feat-&;\$name${SQ} has no upstream" stderr &&
+	printf "%s\n" \
+		"git push --set-upstream ${SQ}weird&remote${SQ} ${SQ}feat-&;\$name${SQ}" >expect &&
+	sed -n "/^    git push /s/^    //p" stderr >actual &&
+	test_cmp expect actual &&
+	shell_split "$(cat actual)" >actual-split &&
+	printf "%s\n" 5 git push --set-upstream "weird&remote" "feat-&;\$name" >expect-split &&
+	test_cmp expect-split actual-split
+'
+
+test_expect_success 'simple push mismatch quotes remote and upstream names' '
+	git checkout main &&
+	git remote add "weird&remote" remote.git &&
+	test_when_finished "git remote remove \"weird&remote\"" &&
+	test_config branch.main.remote "weird&remote" &&
+	test_config branch.main.merge "refs/heads/feat-&;\$name" &&
+	test_must_fail git -c push.default=simple push "weird&remote" 2>stderr &&
+	printf "%s\n" \
+		"git push ${SQ}weird&remote${SQ} ${SQ}HEAD:feat-&;\$name${SQ}" \
+		"git push ${SQ}weird&remote${SQ} HEAD" >expect &&
+	sed -n "/^    git push /s/^    //p" stderr >actual &&
+	test_cmp expect actual &&
+	{
+		while IFS= read -r line
+		do
+			shell_split "$line" || return 1
+		done <actual
+	} >actual-split &&
+	printf "%s\n" \
+		4 git push "weird&remote" "HEAD:feat-&;\$name" \
+		4 git push "weird&remote" HEAD >expect-split &&
+	test_cmp expect-split actual-split
+'
+
+test_expect_success 'slash-slip advice quotes remote and ref metacharacters' '
+	git remote add "weird&remote" remote.git &&
+	test_when_finished "git remote remove \"weird&remote\"" &&
+
+	test_must_fail git push "weird&remote/feat-&-test" 2>stderr &&
+	test_grep -F "hint: Did you mean to use: git push ${SQ}weird&remote${SQ} ${SQ}feat-&-test${SQ}?" stderr &&
+	hint=$(sed -n "s/.*Did you mean to use: //p" stderr) &&
+	hint=${hint%?} &&
+	shell_split "$hint" >actual-split &&
+	printf "%s\n" 4 git push "weird&remote" "feat-&-test" >expect-split &&
+	test_cmp expect-split actual-split &&
+
+	test_must_fail git push "origin/feat;id" 2>stderr &&
+	test_grep -F "hint: Did you mean to use: git push origin ${SQ}feat;id${SQ}?" stderr &&
+
+	test_must_fail git push "origin/feat\$name" 2>stderr &&
+	test_grep -F "hint: Did you mean to use: git push origin ${SQ}feat\$name${SQ}?" stderr &&
+
+	test_must_fail git push "origin/feat & test" 2>stderr &&
+	test_grep -F "hint: Did you mean to use: git push origin ${SQ}feat & test${SQ}?" stderr &&
+	hint=$(sed -n "s/.*Did you mean to use: //p" stderr) &&
+	hint=${hint%?} &&
+	shell_split "$hint" >actual-split &&
+	printf "%s\n" 4 git push origin "feat & test" >expect-split &&
+	test_cmp expect-split actual-split &&
+
+	test_must_fail git push "origin/feat${SQ}test" 2>stderr &&
+	test_grep -F "hint: Did you mean to use: git push origin ${SQ}feat${SQ}\\${SQ}${SQ}test${SQ}?" stderr
+'
+
 test_done

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
gitgitgadget
