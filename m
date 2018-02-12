Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD491F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBLUBG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:01:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56231 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeBLUBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:01:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id a84so461992wmi.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fjZIrvgu85qj5Uk6pDpgkTOYyC5wuE4a1F8JsYgowJQ=;
        b=QSY20UmUyhSZDeSA8gnx/bZQIe9iWILkcxwO6G1TUq0fkm9ZnGmBOTReXZXIqaVJf+
         x8nmbSZBf0zqbdbQgv2EM4N4BwrqhpRw7wfE4lPInc0iiwv6TdlyhENGbukZ/tgsFXxU
         5LamjEQZufqjvQ/XKTHf+Lyu7sundsBlYthEaRaadKk5tzqTpHriYZhRARnQovPEn+ha
         mo+Xa9Evhcr6utl4XHgm247fJYbdja/x0RMYQkzmfU4BMEHjR2cK+wVCOwwHmcvsOVU+
         kVub3LE3y/9LKOuTWq2+3+VylhNAvhEdjf7bwYoytea9pebZUpRBBi2UGWyUC30TH5e4
         4DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fjZIrvgu85qj5Uk6pDpgkTOYyC5wuE4a1F8JsYgowJQ=;
        b=bRShQV9RAZnfIU5XiMfdWl6kA8cQ/To46KWe8McqvpNRhIEOCjyQvSDJUa9Zseb2Fm
         QGzNs6ijtyDcmMEa+cNp13Yofm/RHCVoZZLq9V4iVstYagVYmTTKLc28gvVwhoamZJ+T
         fylPHKOhk/WE1YR4QWMbiJd5QCPGx9yj8Q7ktbFwmUwei8eWWw4HMo+9d9TimQ+L4N/E
         XwKvdy6xgz6djD5yWdYXO2Uki2E6nbjVETe1s/vrVHSbtZxWmETmgnUxpFOdcKKZZCPK
         oMI8daAbZQxlk7YvRroI+7+SUfI7eidSW9+GsUIkJBMBagaM/aM2yRe4QmF5jnu7nT8m
         EVgQ==
X-Gm-Message-State: APf1xPBnlG3QEl1+Zs6rYaJRIalkjUFYFDptuwmWyn24Lfq2bf8+QaR3
        5ubqoerqmyjw8uMg4ybYCtc=
X-Google-Smtp-Source: AH8x22761Dd1CXie6D66aqjWtvpZpUR76n4GrQI9WMhdldKRog8YTLRQ/FJ6IE89jQSC9xYwouhDTg==
X-Received: by 10.28.213.129 with SMTP id m123mr4135732wmg.91.1518465664051;
        Mon, 12 Feb 2018 12:01:04 -0800 (PST)
Received: from neuczc13113nr.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 4sm5577517wmz.31.2018.02.12.12.01.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2018 12:01:03 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory before running hook
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180212031526.40039-3-sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 21:01:01 +0100
Cc:     git <git@vger.kernel.org>, matthew.k.gumbel@intel.com,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2FFE6FB-4B3C-4246-9BCA-272EC874FA8B@gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com> <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-3-sunshine@sunshineco.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Feb 2018, at 04:15, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> Although "git worktree add" learned to run the 'post-checkout' hook in
> ade546be47 (worktree: invoke post-checkout hook, 2017-12-07), it
> neglects to change to the directory of the newly-created worktree
> before running the hook. Instead, the hook is run within the directory
> from which the "git worktree add" command itself was invoked, which
> effectively neuters the hook since it knows nothing about the new
> worktree directory.
>=20
> Fix this by changing to the new worktree's directory before running
> the hook, and adjust the tests to verify that the hook is indeed run
> within the correct directory.
>=20
> While at it, also add a test to verify that the hook is run within the
> correct directory even when the new worktree is created from a sibling
> worktree (as opposed to the main worktree).
>=20
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> builtin/worktree.c      | 11 ++++++++---
> t/t2025-worktree-add.sh | 25 ++++++++++++++++++++++---
> 2 files changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..b55c55a26c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -345,9 +345,14 @@ static int add_worktree(const char *path, const =
char *refname,
> 	 * Hook failure does not warrant worktree deletion, so run hook =
after
> 	 * is_junk is cleared, but do return appropriate code when hook =
fails.
> 	 */
> -	if (!ret && opts->checkout)
> -		ret =3D run_hook_le(NULL, "post-checkout", =
oid_to_hex(&null_oid),
> -				  oid_to_hex(&commit->object.oid), "1", =
NULL);
> +	if (!ret && opts->checkout) {
> +		char *p =3D absolute_pathdup(path);
> +		ret =3D run_hook_cd_le(p, NULL, "post-checkout",
> +				     oid_to_hex(&null_oid),
> +				     oid_to_hex(&commit->object.oid),
> +				     "1", NULL);
> +		free(p);
> +	}
>=20
> 	argv_array_clear(&child_env);
> 	strbuf_release(&sb);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 2b95944973..cf0aaeaf88 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -454,20 +454,29 @@ post_checkout_hook () {
> 	test_when_finished "rm -f .git/hooks/post-checkout" &&
> 	mkdir -p .git/hooks &&
> 	write_script .git/hooks/post-checkout <<-\EOF
> -	echo $* >hook.actual
> +	{
> +		echo $*
> +		git rev-parse --show-toplevel
> +	} >../hook.actual
> 	EOF
> }
>=20
> test_expect_success '"add" invokes post-checkout hook (branch)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/gumby
> +	} >hook.expect &&
> 	git worktree add gumby &&
> 	test_cmp hook.expect hook.actual
> '
>=20
> test_expect_success '"add" invokes post-checkout hook (detached)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/grumpy
> +	} >hook.expect &&
> 	git worktree add --detach grumpy &&
> 	test_cmp hook.expect hook.actual
> '
> @@ -479,4 +488,14 @@ test_expect_success '"add --no-checkout" =
suppresses post-checkout hook' '
> 	test_path_is_missing hook.actual
> '
>=20
> +test_expect_success '"add" within worktree invokes post-checkout =
hook' '
> +	post_checkout_hook &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/guppy
> +	} >hook.expect &&
> +	git -C gloopy worktree add --detach ../guppy &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> test_done
> --=20
> 2.16.1.291.g4437f3f132
>=20

Looks good but I think we are not quite there yet. It does not work
for bare repos. You can test this if you apply the following patch on
top of your changes. Or get the patch from here:
=
https://github.com/larsxschneider/git/commit/253130e65b37a2ef250e9c6369d29=
2ec725e62e7.patch

Please note that also '"add" within worktree invokes post-checkout hook'
seems to fail with my extended test case.

Thanks,
Lars


diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index cf0aaeaf88..0580b12d50 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -451,20 +451,41 @@ test_expect_success 'git worktree =
--no-guess-remote option overrides config' '
 '
=20
 post_checkout_hook () {
-	test_when_finished "rm -f .git/hooks/post-checkout" &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-checkout <<-\EOF
+	test_when_finished "rm -f $1/hooks/post-checkout" &&
+	mkdir -p $1/hooks &&
+	write_script $1/hooks/post-checkout <<-\EOF
 	{
 		echo $*
-		git rev-parse --show-toplevel
+		git rev-parse --git-dir --show-toplevel
+		pwd
 	} >../hook.actual
 	EOF
 }
=20
+test_expect_success '"add" invokes post-checkout hook (branch, bare)' '
+	rm -rf bare &&
+	git clone --bare . bare &&
+	{
+		echo $_z40 $(git --git-dir=3Dbare rev-parse HEAD) 1 &&
+		echo $(pwd)/bare/worktrees/wt-bare
+		echo $(pwd)/wt-bare
+		echo $(pwd)/wt-bare
+	} >hook.expect &&
+	post_checkout_hook bare &&
+	(
+		cd bare &&
+		git worktree add -b branch ../wt-bare master
+	) &&
+	test_cmp hook.expect hook.actual
+'
+
+
 test_expect_success '"add" invokes post-checkout hook (branch)' '
-	post_checkout_hook &&
+	post_checkout_hook .git &&
 	{
 		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/gumby
+		echo $(pwd)/gumby
 		echo $(pwd)/gumby
 	} >hook.expect &&
 	git worktree add gumby &&
@@ -472,9 +493,11 @@ test_expect_success '"add" invokes post-checkout =
hook (branch)' '
 '
=20
 test_expect_success '"add" invokes post-checkout hook (detached)' '
-	post_checkout_hook &&
+	post_checkout_hook .git &&
 	{
 		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/grumpy
+		echo $(pwd)/grumpy
 		echo $(pwd)/grumpy
 	} >hook.expect &&
 	git worktree add --detach grumpy &&
@@ -482,16 +505,18 @@ test_expect_success '"add" invokes post-checkout =
hook (detached)' '
 '
=20
 test_expect_success '"add --no-checkout" suppresses post-checkout hook' =
'
-	post_checkout_hook &&
+	post_checkout_hook .git &&
 	rm -f hook.actual &&
 	git worktree add --no-checkout gloopy &&
 	test_path_is_missing hook.actual
 '
=20
 test_expect_success '"add" within worktree invokes post-checkout hook' =
'
-	post_checkout_hook &&
+	post_checkout_hook .git &&
 	{
 		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/guppy
+		echo $(pwd)/guppy
 		echo $(pwd)/guppy
 	} >hook.expect &&
 	git -C gloopy worktree add --detach ../guppy &&


