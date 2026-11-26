Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686175;
	b=rohe62jFZn9smL9kQx/SyPHDpzikZDGVp6vugbhpAlHOwuHW8cN0ddtW5vqkQYdr/Zv0
	 YzsfJm4mBmvutk/ZK6oBb/EVLFvVlJ4pkGp+pj69X90NC3p8sbJXttEVYhlMPVLALNCaK
	 MPYJFxHBT/WA6N7zYUwMUPuekc6j+YItbOLqcj1/sBDK8JD5yyp3mOKbPGRZrImIfTtoC
	 n4/Q0V+gpe3Nq9G10tYTc4J9ess8qhCsIsc2zgTWpJoGV8KsfS9GZtCCEbfoV4AA/+WHV
	 bud9OkmlB5EFAZqP6xMOD2y2AvBE6UiwMhSKYq1Y7XJw2q/kLNTwOrlsNxiyLRI5YuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=oXHSBGBRFHjo6ApL7ayd7TSrqewFAhrNq7GR2L+70xE=;
	b=FZQqIULU7BPchiBdUP/JmCzfuvR0uxDUpSkLKqvB/kBf+BwaSxNbENaEsoFnreSAACWT
	 rxcDrJ5gTUQA2t4JMJKX+YheNOATo90CaYbEcc7k1DjVD5ipiSX8iqClZVdM8rjmQ36yw
	 FRsjBj/TuRw/5UrLoF0V3QE47g4qfGuz+wpudPDrLNA2UF1wZMcMJUG7acbqjIpXxELCS
	 6pr5A3WJBHR8om++9Rq9u4QZGZ3IiPWmcrRqo6EiM6WPXla5J9P/A15cfLLJTkYpQ8Jc1
	 1Krrqa57ynOm6xEADXur0vyzUR25AOG/p3tRtVsHGoCZrDTLpWKM0xgM3EGqdf/StOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXExCQ6c;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FD606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 09:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C3FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vXExCQ6c
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so4624711a91.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795686174; x=1796290974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oXHSBGBRFHjo6ApL7ayd7TSrqewFAhrNq7GR2L+70xE=;
        b=vXExCQ6cG9Xlz7I9zK5iCUbeM0zhS6mlwlWX34o11z9qzbH6Q3m2FXg/HXbRz/6btl
         cCIeyZhB3AllrqZTTXDp7GXjmA6LfWED8QXmap4RIsN9BwUM7q8nLZkBCEiycNxk7vJn
         FkGI+OTAlMYRqPg00zHxpAggPiHy9FWYqNKGSpfjNAUEz3RjRR2vttuZpwJY3c6ugxMa
         ykatINwprzZeTDHV1xsOfvs/gsK97D8dUWHp9/ZNEoAk6y+v+2IBg+r6i7jdHDRufUTJ
         Abvq+QOsv8UCG82iXc5bfOq2YN7nqx40Pmeu2o6sjfF8uAgnMu6RsJEX8eoXLLSd+cSs
         ys0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686174; x=1796290974;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oXHSBGBRFHjo6ApL7ayd7TSrqewFAhrNq7GR2L+70xE=;
        b=vZFd4eo+b+EGg2xdK4W10ABPYtTl81/2mGkvEY99PMVPQ4epV/WWtm5+Ch7W8EDGnc
         7zShCQelnIgq+C5DqPJlaslxRfJKCq4CO18xwrHVBMcp4EpbcBbtRIPZ8G2X3Cb5PhEZ
         FbrZ17sTfV6/gKaD0QwgK/8vSbEfduQ8oGGUGM1u11PRK/Eqn0h47Mu7uwzGvGFyEejG
         ugZ17x8GItiDTkdlP1p3opi4TlS6HfW7p0GJfoehB7PZ4wNxzPq4lsfB7IVipq04U9v4
         YTHfpQ1+0jqwzO1ojqSv2+YhrAymvjeC4TCsNoJJNU2qWjmehCmA52r9cwZzaN+mabQ+
         2Xng==
X-Gm-Message-State: APuU4Z8jXRaVS40qVeSF5ssEDsHHjAk4FoPMgQUpICJHFfETJMxpQhQ/
	Ct4yftzHJ87EWUmWOWy+dNR6Gwwztlsu6OtvruiPZDq52dCNLiUZqpY9ySGJUA==
X-Gm-Gg: AZFdTZdw5p4Jp3fhLhskpeOizMUiztytQjcfRh6DvAJTJzEWs29ZLSa3v5VqarZCOnb
	S9RTZ58RJITMWSONuInc1IlzgNdPr/4h+0s6Tdh9ZuIG1XOV9UrLTnNRaGubrs8C5DWwAN2oe1M
	SFvznwcJn+VEIB8X18I+YjwVJiyuJkRom6uzzCHc/QLxZDMrH1peiIkQZ4oxXLmOAexIzWqxoOW
	LCQbJpWgVcnZcvi+6WkTrdrOtpYoSvIQlW4SgOf0WLlO+nxreRI3zknhawSU629OFLRkdxT3pJV
	VUxOdakniiFq+ShErdeOD8ay0LWV/tE50GFGv6B6rPAOSWU5ue8zuKjw0YMXtzzdv/vnmwxRGzI
	3GVo9oadiBQdMfiBfGpA+lVBl5a+IBrJJZvHgxg/vWRU/Ux8bGqkZzd9VIgoyDvKXdP7iBSAgpI
	XP/10ALd7dAjIU+96x642O/w6Q/W4hQTqpL7svDi3mijvKPj0aReXKNxOyNeUs0pqSHInOgMHht
	j85mtlnNJRoxs//vGVHJBEJq7eaEXybR6eQvHY3BZGCpml9EALSNdPQO1CDhCybehcj28HXP3DR
	ltrK6AKe9nzBFCC2iaX6EXFOb7UvqaQ=
X-Received: by 2002:a17:90b:2e8c:b0:3b3:b373:6a6a with SMTP id 98e67ed59e1d1-3b41c9e45c3mr20335886a91.28.1795686174342;
        Thu, 26 Nov 2026 01:42:54 -0800 (PST)
Received: from [127.0.0.1] ([52.233.87.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7a8c64sm14246758a91.3.2026.11.26.01.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:42:53 -0800 (PST)
Message-Id: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
From: "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 09:42:53 +0000
Subject: [PATCH] push: shell-quote names in suggested push commands
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
bare, and add tests for each hint.

Signed-off-by: MD Nahid Hasan Sagor <nahidhasan141400@gmail.com>
---
    push: shell-quote names in suggested push commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2336%2Fnahidhasan141400%2Ffix-push-upstream-quoting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2336/nahidhasan141400/fix-push-upstream-quoting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2336

 builtin/push.c           |  38 ++++++++++++--
 t/t5523-push-upstream.sh |   8 +++
 t/t5528-push-default.sh  |   8 +++
 t/t5529-push-errors.sh   | 104 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..a28138fcba 100644
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
@@ -155,6 +156,8 @@ static NORETURN void die_push_simple(struct branch *branch,
 	const char *advice_automergesimple_maybe = "";
 	const char *short_upstream = branch->merge[0]->src;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct strbuf quoted_remote = STRBUF_INIT;
+	struct strbuf quoted_upstream = STRBUF_INIT;
 
 	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
 
@@ -173,6 +176,14 @@ static NORETURN void die_push_simple(struct branch *branch,
 				 "won't match the local branch, see option "
 				 "'simple' of branch.autoSetupMerge\n"
 				 "in 'git help config'.\n");
+
+	/*
+	 * Quote for copy-paste into a POSIX shell. Ordinary names stay
+	 * bare; metacharacters are wrapped in single quotes. die() does
+	 * not return, so these buffers are intentionally not released.
+	 */
+	sq_quote_buf_pretty(&quoted_remote, remote->name);
+	sq_quote_buf_pretty(&quoted_upstream, short_upstream);
 	die(_("The upstream branch of your current branch does not match\n"
 	      "the name of your current branch.  To push to the upstream branch\n"
 	      "on the remote, use\n"
@@ -183,8 +194,8 @@ static NORETURN void die_push_simple(struct branch *branch,
 	      "\n"
 	      "    git push %s HEAD\n"
 	      "%s%s"),
-	    remote->name, short_upstream,
-	    remote->name, advice_pushdefault_maybe,
+	    quoted_remote.buf, quoted_upstream.buf,
+	    quoted_remote.buf, advice_pushdefault_maybe,
 	    advice_automergesimple_maybe);
 }
 
@@ -204,6 +215,9 @@ static const char *get_upstream_ref(int flags, struct branch *branch, const char
 
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name) {
 		const char *advice_autosetup_maybe = "";
+		struct strbuf quoted_remote = STRBUF_INIT;
+		struct strbuf quoted_branch = STRBUF_INIT;
+
 		if (!(flags & TRANSPORT_PUSH_AUTO_UPSTREAM)) {
 			advice_autosetup_maybe = _("\n"
 					   "To have this happen automatically for "
@@ -211,14 +225,21 @@ static const char *get_upstream_ref(int flags, struct branch *branch, const char
 					   "upstream, see 'push.autoSetupRemote' "
 					   "in 'git help config'.\n");
 		}
+		/*
+		 * The prose keeps the raw branch name. Only the
+		 * copy-pasteable command is shell-quoted. die() does
+		 * not return, so these buffers are not released.
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
@@ -669,6 +690,8 @@ static void die_if_repo_looks_like_ref(const char *repo)
 {
 	const char *slash = strchr(repo, '/');
 	struct strbuf name = STRBUF_INIT;
+	struct strbuf quoted_remote = STRBUF_INIT;
+	struct strbuf quoted_ref = STRBUF_INIT;
 	int code;
 
 	if (!slash || !slash[1] || file_exists(repo))
@@ -680,11 +703,16 @@ static void die_if_repo_looks_like_ref(const char *repo)
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
index 22d3e1162c..484565d7cb 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -134,4 +134,12 @@ test_expect_success TTY 'quiet push -u' '
 	test_must_be_empty output
 '
 
+test_expect_success 'no-upstream advice quotes a branch name with metacharacters' '
+	test_when_finished "git checkout main" &&
+	git checkout -b "branch&name" &&
+	test_when_finished "git checkout main && git branch -D \"branch&name\"" &&
+	test_must_fail git push upstream 2>stderr &&
+	test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}" stderr
+'
+
 test_done
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 2bd8759a68..313f0628d4 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -294,4 +294,12 @@ test_expect_success 'default triangular behavior acts like "current"' '
 	test_push_success "" main repo2
 '
 
+test_expect_success 'simple push quotes an upstream branch name with metacharacters' '
+	test_config branch.main.remote parent1 &&
+	test_config branch.main.merge "refs/heads/upstream&name" &&
+	git checkout main &&
+	test_must_fail git -c push.default=simple push parent1 2>stderr &&
+	test_grep "git push parent1 HEAD:${SQ}upstream&name${SQ}" stderr
+'
+
 test_done
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 5f8aa1ed19..8f4705cae6 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -67,6 +67,11 @@ test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
 	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
 '
 
+test_expect_success 'suggest quoted branch when the slipped name needs shell quoting' '
+	test_must_fail git push "origin/branch&name" 2>stderr &&
+	test_grep "hint: Did you mean to use: git push origin ${SQ}branch&name${SQ}?" stderr
+'
+
 test_expect_success 'no suggestion when prefix is not a configured remote' '
 	test_must_fail git push not-a-remote/main 2>stderr &&
 	test_grep ! "Did you mean" stderr
@@ -94,4 +99,103 @@ test_expect_success 'detect ambiguous refs early' '
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
+	test_when_finished "git checkout main" &&
+	git remote add "weird&remote" remote.git &&
+	test_when_finished "git remote remove \"weird&remote\"" &&
+	git checkout -b "feat-&;\$name" &&
+	test_when_finished "git checkout main && git branch -D ${SQ}feat-&;\$name${SQ}" &&
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
+		"git push ${SQ}weird&remote${SQ} HEAD:${SQ}feat-&;\$name${SQ}" \
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
