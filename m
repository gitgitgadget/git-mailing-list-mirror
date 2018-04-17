Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57521F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeDQSNU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:13:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36689 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDQSNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:13:18 -0400
Received: by mail-lf0-f65.google.com with SMTP id d20-v6so28724495lfe.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vp/pHZEfiyZVV8eUs+HhGYyF7Ietw50v2a0Lk5o8x5Y=;
        b=EBAzB9N0U2/jGBrxuC81Z5z6VujyyEST+C3nNUwyG7QT1PZ2B0+70Pfa9d7Y0LE6a6
         ysmMIPkI+JCStHfW2EY+bUNioAdsBPCKOUxvD4BfwWJmBGxyHOP9GA8ofwL951M9h+W4
         u1GYiJjvA2SuO/V/IS63FUqfY+AakO/zoSj8YWuAX1/CH/M0R9t4LaRyPlOYPR9nbNgJ
         EQeQ5VQ118Ny/ZRlUczIUA45bPGW3lQLTjbh8Jcy98PLsszWnhC9cFs6+3GqKb490MaV
         O8xm2AgsSe+Kcvui+gsIAZoZbKUoxcWzP3dOh74Pe7yX26wPIKdYQ/1/rEs6wz/qsgOg
         3lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vp/pHZEfiyZVV8eUs+HhGYyF7Ietw50v2a0Lk5o8x5Y=;
        b=nNBZkvsB9tJWEOhqwZlWU+7BE1HjgT9UO8pM+zvkVaCu/nJ2FobL51yRwfFfIeXayR
         X7EMo4ENK/P/stgioop9G6eNbiBnFMY0a9sCCGZDNJpq7tLj5eHrwd6eg+ZsEcK5I/w4
         6JVPylMCzO/nb+AuIULLpt+MKhb333dvswqtwg9+0kMk3TZStCCN6+YiyHCPagMl+i74
         UxP3bGF6tZ/0QL8K+LLx3mUUnmpgI87oFi1yQO6ehPWWXNdM7orKD8y4Owj3ACRrQ6YM
         hXo6Qkz+VbK9NSb38s1Kg8B911/drlCSmmvZ8UrBcH7b321vlTBVGfIO8CDqO4KHIjfM
         7HJA==
X-Gm-Message-State: ALQs6tA27ufjopXEHLNXB1l90kyo6h9hWxRLgyXIJMeIpTevJPZ8NizP
        AefMUKlhI7uUftNpQdpZsOdZTA==
X-Google-Smtp-Source: AIpwx49QxwvxxBTiShZBLlMTlpF+SqSHa0MYLIbvWZAgFTWkLZLwIVo7c7BupQTkEul4P55uM662Ig==
X-Received: by 10.46.84.66 with SMTP id y2mr2073990ljd.11.1523988796268;
        Tue, 17 Apr 2018 11:13:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i62-v6sm3497964lfa.45.2018.04.17.11.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 11:13:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] completion: complete all possible -no-<options>
Date:   Tue, 17 Apr 2018 20:13:00 +0200
Message-Id: <20180417181300.23683-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not a complete topic but I'd like to present the problem and
my approach to see if it's a good way to go.

We have started recently to rely on parse-options to help complete
options. One of the leftover items is allowing completing --no- form.
This patch enables that (some options should not have --no- form, but
that's easy not included here).

The problem with completing --no- form is that the number of
completable options now usually doubles, taking precious screen space
and also making it hard to find the option you want.

So the other half of this patch, the part in git-completion.bash, is
to uncomplete --no- options. When you do "git checkout --<tab>",
instead of displaying all --no- options, this patch simply displays
one item: the --no- prefix. If you do "git checkout --no-<tab>" then
all negative options are displayed. This helps reduce completable
options quite efficiently.

Of course life is not that simple, we do have --no- options by default
sometimes (taking priority over the positive form), e.g. "git clone
--no-checkout". Collapsing all --no-options into --no- would be a
regression.

To avoid it, the order of options --git-completion-helper returns does
matter. The first 4 negative options are not collapsed. Only options
after the 4th are. Extra --no- options are always printed at the end,
after all the --no- defined in struct option, this kinda works. Not
pretty but works.

After all this "git checkout --<tab>" now looks like this

    > ~/w/git $ git co --
    --conflict=                   --orphan=
    --detach                      --ours 
    --ignore-other-worktrees      --patch 
    --ignore-skip-worktree-bits   --progress 
    --merge                       --quiet 
    --no-                         --recurse-submodules 
    --no-detach                   --theirs 
    --no-quiet                    --track 
    --no-track                    

and all the no options

    > ~/w/git $ git co --no-
    --no-conflict                    --no-patch 
    --no-detach                      --no-progress 
    --no-ignore-other-worktrees      --no-quiet 
    --no-ignore-skip-worktree-bits   --no-recurse-submodules 
    --no-merge                       --no-track 
    --no-orphan                      

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 25 +++++++++++++++-
 parse-options.c                        | 40 +++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..85b9f24465 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -266,7 +266,7 @@ __gitcomp ()
 	case "$cur_" in
 	--*=)
 		;;
-	*)
+	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
 			c="$c${4-}"
@@ -279,6 +279,29 @@ __gitcomp ()
 			fi
 		done
 		;;
+	*)
+		local c i=0 IFS=$' \t\n' n=0
+		for c in $1; do
+			c="$c${4-}"
+			if [[ $c == "$cur_"* ]]; then
+				case $c in
+				--*=*|*.) ;;
+				--no-*)
+					n=$(($n+1))
+					if [ "$n" -eq 4 ]; then
+						c="--no-${4-} "
+					elif [ "$n" -gt 4 ]; then
+						continue
+					else
+						c="$c "
+					fi
+					;;
+				*) c="$c " ;;
+				esac
+				COMPREPLY[i++]="${2-}$c"
+			fi
+		done
+		;;
 	esac
 }
 
diff --git a/parse-options.c b/parse-options.c
index 0f7059a8ab..f6cd7ca8d2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -427,13 +427,11 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
-/*
- * TODO: we are not completing the --no-XXX form yet because there are
- * many options that do not suppress it properly.
- */
 static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 			const struct option *opts)
 {
+	const struct option *original_opts = opts;
+
 	for (; opts->type != OPTION_END; opts++) {
 		const char *suffix = "";
 
@@ -465,6 +463,40 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 			suffix = "=";
 		printf(" --%s%s", opts->long_name, suffix);
 	}
+	for (opts = original_opts; opts->type != OPTION_END; opts++) {
+		int has_unset_form = 0;
+
+		if (!opts->long_name)
+			continue;
+		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+			continue;
+		if (opts->flags & PARSE_OPT_NONEG)
+			continue;
+
+		switch (opts->type) {
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_CALLBACK:
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_COUNTUP:
+		case OPTION_SET_INT:
+			has_unset_form = 1;
+			break;
+		default:
+			break;
+		}
+		if (has_unset_form) {
+			const char *name;
+
+			if (skip_prefix(opts->long_name, "no-", &name))
+				printf(" --%s", name);
+			else
+				printf(" --no-%s", opts->long_name);
+		}
+	}
 	fputc('\n', stdout);
 	exit(0);
 }
-- 
2.17.0.367.g5dd2e386c3

