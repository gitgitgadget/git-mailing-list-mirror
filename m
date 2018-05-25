Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D91F1F42D
	for <e@80x24.org>; Fri, 25 May 2018 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967303AbeEYQoA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 12:44:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38120 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967291AbeEYQn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 12:43:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id n9-v6so2521771pgq.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2r4C2zDRc7cUHntG5BmlUUXjS4lL1l/+1EYsfbt1m4=;
        b=kqkjgp6u65h5zz477PUWlldSp0Ykm3BUkRIKDqW3Za9pz0JqSDe7slhek9AB8MJnYE
         y5DcZCcMBOC54300UAcIr85C9Rv1opSeGfS+d6IY0f97CJTA82bCxO8R94C8btUqis2E
         38VXsoJ0pB2F24CZK2DcF5chfA8DH6+aobslFHdGBe2csX+nGfco1NUA2ZPJDLW/UrNk
         0RFATJrVuWTEvz3cDxhObC5OeJdS8FbTlCaU094g9BywByY6aYFyj8MGiuuFiIIXt+9d
         adtYP5wxkRnBdx6uOdyALFFnCaMGgZzldtagM5dkFEHGg05+hS+1g58ArPzQ37JtX2qs
         35Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2r4C2zDRc7cUHntG5BmlUUXjS4lL1l/+1EYsfbt1m4=;
        b=dsn0Z9fWuJvEziBnXD7cUg6U0kyqjdDXNRmi8DNUCYlJLPwjMQ1clKu0DfJBcCw8a2
         AHZEKPFZie7ugk9N7qPhgpY6Bo06pQuq3RAJDvjZ3Ic2yafEo0S2QedHByocgiypCdim
         9yOBvPA9e6UPzcwBqMdP49Hbe0ElTGo/hcANt6bawpLVyBrrQfNJtdO7eohx1lPndrm+
         +ioiCRGBXps/p3nG2X3NJmMpSnlTsb1UmtAHDd0lPfiXau1e7EXS551NNXtfkTnU+9S8
         QjkfIfHFaUZUjBIiapGLJrVKC2BRveSpAXrM756jlIPENBq+7QKpMfYsDc7HvBg5xqGr
         jc/w==
X-Gm-Message-State: ALKqPwdGUm1ZGzciTrvR/iD2rT9GzBDTVpkrNpaGzhFWB/Rolpgof2zi
        vuHSMZ7KXIf/Xn65hJrsWug=
X-Google-Smtp-Source: AB8JxZoA7zuxyITxHjtSBnONU526yRk7N6ejtDhT5LLFfeQqrumAZUCmlI5ofhgH/+kB1YUupc/hLA==
X-Received: by 2002:a63:bc0a:: with SMTP id q10-v6mr2637776pge.141.1527266638883;
        Fri, 25 May 2018 09:43:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d22-v6sm4311120pfk.126.2018.05.25.09.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 09:43:58 -0700 (PDT)
Date:   Fri, 25 May 2018 09:43:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: turn --ita-invisible-in-index on by default
Message-ID: <20180525164351.GA192362@aiede.svl.corp.google.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180525033942.GA234191@aiede.svl.corp.google.com>
 <20180525143042.GA10607@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525143042.GA10607@duynguyen.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:

>     $ echo haha > new; git add -N
>     $ git diff
>     diff --git a/new b/new
>     index e69de29..5ad28e2 100644
>     --- a/new
>     +++ b/new
>     @@ -0,0 +1 @@
>     +haha
>
> Notice that the diff does not tell you that 'new' is a new file. The
> diff with this patch gives you this
>
>     $ git diff
>     diff --git a/new b/new
>     new file mode 100644
>     index 0000000..5ad28e2
>     --- /dev/null
>     +++ b/new
>     @@ -0,0 +1 @@
>     +haha
[...]
> One consequence of this is you can't apply the diff generated with ita
> entries because the diff expects empty files to be already in the
> worktree. This to me does not make sense.
>
> Of course there's other things that also go along this line. Like if
> "git commit" does not add an ita entry, why should it appear in 'git
> diff --cached', which should show you what's to be committed.

Thankds for this context.  That helps a lot.

[...]
> Since this commit is already in 'next', it's too late to update the
> commit message now.

I think it should be reverted from 'next' because of the unintended
change to the behavior of "git diff HEAD".  Here is what I have
applied internally.

-- >8 -- 
Subject: Revert "diff: turn --ita-invisible-in-index on by default"

This reverts commit 992118dd95b052bc82a795fd3a8978bea0fe5c0e.  That
change is promising, since it improves the behavior of "git diff" and
"git diff --cached" by correctly showing an intent-to-add entry as no
file.  Unfortunately, though, it breaks "git diff HEAD" in the
process:

	echo hi >new-file
	git add -N new-file
	git diff HEAD

Before: shows addition of the new file
After: shows no change

Noticed because the new --ita-invisible-in-index default broke a
script using "git diff --name-only --diff-filter=A master" to get a
list of added files.  Arguably that script should use diff-index
instead, which would have sidestepped the issue, but the new behavior
is unexpected in interactive use as well.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/diff.c          |  7 -------
 t/t2203-add-intent.sh   | 40 ++++++++--------------------------------
 t/t4011-diff-symlink.sh | 10 ++++------
 3 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index b709b6e984..bfefff3a84 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -352,13 +352,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
 
-	/*
-	 * Default to intent-to-add entries invisible in the
-	 * index. This makes them show up as new files in diff-files
-	 * and not at all in diff-cached.
-	 */
-	rev.diffopt.ita_invisible_in_index = 1;
-
 	if (nongit)
 		die(_("Not a git repository"));
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1d640a33f0..d9fb151d52 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -69,9 +69,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only --ita-visible-in-index HEAD -- nitfol | wc -l) = 1 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only -- nitfol | wc -l) = 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
+	test $(git diff --name-only --ita-invisible-in-index HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only --ita-invisible-in-index -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
@@ -99,13 +99,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 
 	: >dir/bar &&
 	git add -N dir/bar &&
-	git diff --name-only >actual &&
+	git diff --cached --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual &&
 
 	git write-tree >/dev/null &&
 
-	git diff --name-only >actual &&
+	git diff --cached --name-only >actual &&
 	echo dir/bar >expect &&
 	test_cmp expect actual
 '
@@ -186,19 +186,7 @@ test_expect_success 'rename detection finds the right names' '
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
-		test_cmp expected.3 actual.3 &&
-
-		git diff --stat >actual.4 &&
-		cat >expected.4 <<-EOF &&
-		 first => third | 0
-		 1 file changed, 0 insertions(+), 0 deletions(-)
-		EOF
-		test_cmp expected.4 actual.4 &&
-
-		git diff --cached --stat >actual.5 &&
-		: >expected.5 &&
-		test_cmp expected.5 actual.5
-
+		test_cmp expected.3 actual.3
 	)
 '
 
@@ -234,27 +222,15 @@ test_expect_success 'double rename detection in status' '
 	)
 '
 
-test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
-	git reset --hard &&
-	echo new >new-ita &&
-	git add -N new-ita &&
-	git diff --summary >actual &&
-	echo " create mode 100644 new-ita" >expected &&
-	test_cmp expected actual &&
-	git diff --cached --summary >actual2 &&
-	: >expected2 &&
-	test_cmp expected2 actual2
-'
-
 test_expect_success 'apply --intent-to-add' '
 	git reset --hard &&
 	echo new >new-ita &&
 	git add -N new-ita &&
-	git diff >expected &&
+	git diff --ita-invisible-in-index >expected &&
 	grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
-	git diff >actual &&
+	git diff --ita-invisible-in-index >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 108c012a3a..cf0f3a1ee7 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,13 +139,11 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	new file mode 100644
-	index 0000000..d95f3ad
-	Binary files /dev/null and b/file.bin differ
+	index e69de29..d95f3ad 100644
+	Binary files a/file.bin and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	new file mode 120000
-	index 0000000..dce41ec
-	--- /dev/null
+	index e69de29..dce41ec 120000
+	--- a/link.bin
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
-- 
2.17.0.921.gf22659ad46

