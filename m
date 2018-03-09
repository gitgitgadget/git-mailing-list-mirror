Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97B21F404
	for <e@80x24.org>; Fri,  9 Mar 2018 01:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCIBk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 20:40:57 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38654 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCIBk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 20:40:56 -0500
Received: by mail-pl0-f68.google.com with SMTP id m22-v6so4396976pls.5
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f0/g13VbUkmcnMPD3GN11gXFgHiOMcuEOi3z2bSst7Q=;
        b=ElZw82hglSJSznpR01RsT0WBpyHMRJNNg+jSah0MnSZHk/YCE5haGY93UxE0hxYOq8
         gygB4yf4opD79yLIR1ofvvM2rTgNf7+45BFpwiSkoRQrV1FGNMOiUyNn4lL3mUwV22d7
         lsaNx/ZGYSc8l4JtmILc/52WrJP8rH/HFA2T3S/8vDtdskW7NUPMuuYQOIfA+HfKWHKc
         CbVF6bTFtZ3TtNC9A34zwgUsPE6Uo/i20rcSkeF+eFrICABBoWNGiIuGhpEK1fNXwLLz
         T5lty1QeFnIzSXDXLUFUwIA3tHd+5XqET9uEKgPHriKi4IbwE+VDR10gdJugp084UALQ
         995w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f0/g13VbUkmcnMPD3GN11gXFgHiOMcuEOi3z2bSst7Q=;
        b=PMg93rH8ZunC13C11ibVGkbl0LWLxxbgA8drng0YFoZ39VPrrizNpCuW4v3vrfTsn3
         derB5r4bPNrZgIt5rYg1ZORkLp+ZXJ5EduYVnXVHdyue9PJnh06oVtWkob1hho8RuUz/
         zANTZjz7zbhQ7dL2DUaLVhQyO6PHrTrQ+qwbBDtT5G7qaq+m8Y+fF/Toy7UqTbA3+wmg
         ieTVdDI2S8xvH2tmuYt9qcDyh75TTGQauhJWcigQLpbzn9BipRzHkycUeCm4mYD9RPOl
         Sc9dYbKWxvFA1Obea9JJV42hwvLZnbB/cswqNVRGu3D0tTp0FvZL/MhZI3wyOVBc/KiS
         LH6A==
X-Gm-Message-State: APf1xPD/xPmSu0izfx3Xe62zd+raRIkhwupEmZ6H1FUDhqlyyUGnjwF1
        yG8aIY4iNJE8MQV+/kkhBI7a+A==
X-Google-Smtp-Source: AG47ELvCkn54nb1f4HVNFYkYLUBy2oiSQXJNt0zPVvTHKO21x1/ZGqC10hbzzCTyhqnaCwcO02KTDg==
X-Received: by 2002:a17:902:2843:: with SMTP id e61-v6mr25962638plb.437.1520559655436;
        Thu, 08 Mar 2018 17:40:55 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id c4sm28361555pgt.24.2018.03.08.17.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 17:40:54 -0800 (PST)
Date:   Fri, 9 Mar 2018 08:40:43 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeremy Bicha <jbicha@ubuntu.com>
Cc:     git@vger.kernel.org
Subject: Re: feature request: git-config: Add conditional include for
 gitbranch
Message-ID: <20180309014043.GA9506@duynguyen.dek-tpc.internal>
References: <CAAajCMbFEF+1i8+MOpOfdMgChi0FfdA1CoCjKLjjKMT2m-58KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAajCMbFEF+1i8+MOpOfdMgChi0FfdA1CoCjKLjjKMT2m-58KQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 08, 2018 at 07:23:00PM -0500, Jeremy Bicha wrote:
> Use Case
> ======
> Jeremy is a developer for Debian and Ubuntu. The same repository is
> used for both Debian and Ubuntu packaging but with different branches.
> For commits to the debian/master branch, Jeremy wants to use his
> @debian.org email address. For commits to the ubuntu/master branch,
> Jeremy wants to use his @ubuntu.com email.
> 
> Proposal
> =======
> The includeIf feature of git-config could be extended to offer a
> gitbranch conditional include in addition to the gitdir conditional
> include it already offers.

Interesting. It looks quite simple to do this. My prototype looks like
this.

-- 8< --
Subject: [PATCH] config: support conditional include by matching ref pattern

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt  | 12 ++++++++++++
 config.c                  | 30 ++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea8..4e8fb6d99c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -143,6 +143,18 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file sytems)
 
+`ref`::
+	The data that follows the keyword `ref:` is used as a glob
+	pattern that matches against the current branch. `*` in the
+	pattern does not match `/` and `**` matches multiple levels,
+	the same as .gitignore syntax. The branch is a full reference
+	(i.e. with `refs/heads/` prefix). If HEAD is detached, the
+	pattern will be matched against the value "HEAD".
+
+`ref/i`::
+	This is the same as `ref` except that matching is done
+	case-insensitively
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index b0c20e6cb8..72ff2da667 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "refs.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -202,6 +203,31 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	return prefix;
 }
 
+static int include_by_ref(const struct config_options *opts,
+			  const char *cond, size_t cond_len, int icase)
+{
+	struct strbuf pattern = STRBUF_INIT;
+	char *branch;
+	unsigned flags = WM_PATHNAME;
+	int ret;
+
+	if (!opts->git_dir)
+		return 0;
+
+	branch = resolve_refdup("HEAD", 0, NULL, NULL);
+	if (!branch)
+		return 0;
+
+	if (icase)
+		flags |= WM_CASEFOLD;
+	strbuf_add(&pattern,  cond, cond_len);
+	ret = !wildmatch(pattern.buf, branch, flags);
+
+	free(branch);
+	strbuf_release(&pattern);
+	return ret;
+}
+
 static int include_by_gitdir(const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -268,6 +294,10 @@ static int include_condition_is_true(const struct config_options *opts,
 		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
+	else if (skip_prefix_mem(cond, cond_len, "ref:", &cond, &cond_len))
+		return include_by_ref(opts, cond, cond_len, 0);
+	else if (skip_prefix_mem(cond, cond_len, "ref/i:", &cond, &cond_len))
+		return include_by_ref(opts, cond, cond_len, 1);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index d9d2f545a4..27ecfc74b7 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -296,6 +296,32 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 	)
 '
 
+test_expect_success 'conditional include by refs' '
+	git init inc-by-ref &&
+	(
+		check() {
+			echo "ref: $1" >.git/HEAD &&
+			echo "[includeIf \"ref:$2\"]path=bar8" >.git/config &&
+			git config test.var >actual &&
+			test_cmp expect actual
+		}
+		cd inc-by-ref &&
+		echo "[test]var=matched" >.git/bar8 &&
+		echo matched >expect &&
+
+		check refs/heads/foo refs/heads/foo &&
+		check refs/heads/foo "refs/heads/*" &&
+		check refs/heads/foo "refs/heads/f*" &&
+		check refs/heads/deep/in/foo "refs/heads/**/foo" &&
+
+		test_commit one &&
+		git checkout --detach &&
+		echo "[includeIf \"ref:HEAD\"]path=bar8" >.git/config &&
+		git config test.var >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.16.2.903.gd04caf5039

-- 8< --
