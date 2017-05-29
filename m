Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC1B1FD09
	for <e@80x24.org>; Mon, 29 May 2017 02:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdE2CcG (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 22:32:06 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36860 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2CcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 22:32:05 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so41087334pfg.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tn+bLErrXocabsSH04iTdZMFRe3UWKjmBa08sMp3geY=;
        b=J1rMXSmxUPZXEx6RJ0lO1ZZHe6ayIXn5frrnkkV66qfBlSAEmTHc+ixTycDUK5MMxb
         A+ZKDDrJ1mMSbYtVKJYKbNRT8MWyxSeq+xKey/2nlTiuCFP795EjYrPwnzXChhXs7J0g
         MLrvAZTv6KU0bblM+PVJfMYr3VtXG8qK7KE6fwoh6IdnAMuJ0j6LOhblOnj+hm1ARwPx
         tC8WTL14wCGXQtPz4zN9TTqiH6S3oPGO9rtNq9RS2li8TROrFWuMMgR33yTAw8reQcZf
         QYNiH0dQtsy7xvmzwi0SKQ1I1Brx8JeuZ4eP2Y+gE6wEEP7b2X3eZx+G2DZ4oO41JxKz
         V+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tn+bLErrXocabsSH04iTdZMFRe3UWKjmBa08sMp3geY=;
        b=N2latNuImjpx3asN7Alk5JYXUECOLJORlVuwhe0WpFvUQGSDlnkou3gwaXvBSIzL8p
         ddRsV7R8jtkVSXY5+aJomVwJf4Vh0+wB8k3Saz8h7TUGxKozxb7rlVjdUaVKSLxsX7u9
         YhQHbDNIXrQ1RM+mDeDhOisuAdwyc9wB+kJ79/4qZJF9QfYO+xgcyS7iwH1YqR2ZD+8r
         4xexRxNEF7kHz8cXTd7CgvgSb7IAIja03qijswCAxPy9M9Wbu1Yc39Gd3rUIf11JuXNu
         7BgpqRpDkanmIY6Ca31G4AYChEP17p1RG3Htk54fihlc6l1+XFeMmQ38dBsL6coA7ypx
         Kf1w==
X-Gm-Message-State: AODbwcDMbjGIzHb172xNgXIFKOOQAaYX7yxNE6gN5DZwUPsVVWj1eLcW
        HZ6KWk1M/0ORMTSz7CQ=
X-Received: by 10.84.179.65 with SMTP id a59mr27102786plc.82.1496025124798;
        Sun, 28 May 2017 19:32:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id w10sm12662616pge.48.2017.05.28.19.32.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 19:32:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tyler Brazier <tyler@tylerbrazier.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pull: ff --rebase --autostash works in dirty repo
References: <0102015c5166284d-d8dd6534-a8d5-452d-af14-d827934ef593-000000@eu-west-1.amazonses.com>
Date:   Mon, 29 May 2017 11:32:03 +0900
In-Reply-To: <0102015c5166284d-d8dd6534-a8d5-452d-af14-d827934ef593-000000@eu-west-1.amazonses.com>
        (Tyler Brazier's message of "Sun, 28 May 2017 23:31:08 +0000")
Message-ID: <xmqqmv9w8kbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tyler Brazier <tyler@tylerbrazier.com> writes:

> pull --rebase --autostash was failing on a fast-forward in a dirty repo
> since we shortcut to run_merge(), which does not know how to autostash.
> The shortcut is a performance optimization, and since rebase was
> rewritten in C, it seemed okay to just bypass the shortcut if we
> autostash.
> ---

Please clarify "was failing".  I suspect that

    When we can fast-forward to the updated upstream, "git pull
    --rebase --autostash" in a dirty repository did not auto-stash
    and failed.  This was due to a short-cut to avoid running rebase
    when we can fast-forward, but the autostash option was ignored
    in that codepath.

or something like that was what you meant.

"rebase" was not rewritten in C.  Not the part that matters in
making "pull --rebase" work anyway.  Unlike the one in the earlier
discussion, you are not removing the short-cut unconditionally; I do
not think you need to justify the "bypassing" based on performance.
If we need to take run_rebase() codepath when "--autostash" is in
effect, we need to do so even if the result were somewhat slower for
correctness (and it would not hurt to mention that actual measurement
showed that it is dubious it is slower in the first place).

Missing sign-off.

>  builtin/pull.c  |  5 +++--
>  t/t5520-pull.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index dd1a4a94e41e..609e594d3f28 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -772,6 +772,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	struct oid_array merge_heads = OID_ARRAY_INIT;
>  	struct object_id orig_head, curr_head;
>  	struct object_id rebase_fork_point;
> +	int autostash;
>  
>  	if (!getenv("GIT_REFLOG_ACTION"))
>  		set_reflog_message(argc, argv);
> @@ -800,8 +801,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (!opt_rebase && opt_autostash != -1)
>  		die(_("--[no-]autostash option is only valid with --rebase."));
>  
> +	autostash = config_autostash;
>  	if (opt_rebase) {
> -		int autostash = config_autostash;
>  		if (opt_autostash != -1)
>  			autostash = opt_autostash;
>  
> @@ -868,7 +869,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		head = lookup_commit_reference(orig_head.hash);
>  		commit_list_insert(head, &list);
>  		merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
> -		if (is_descendant_of(merge_head, list)) {
> +		if (!autostash && is_descendant_of(merge_head, list)) {
>  			/* we can fast-forward this without invoking rebase */
>  			opt_ff = "--ff-only";
>  			return run_merge();

The scope of the "autostash" feels a bit unfortunate, but that is a
direct consequence of having two "if (opt_rebase)" separated in the
control flow, so it's not your fault.

When autostsash is in effect, you _know_ you do not have to compute
is-descendant-of and you do not have to prepare merge_head or list
here.  I do not like deeply indented code, but perhaps like this one
on top of your patch?

 builtin/pull.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 609e594d3f..42f0560252 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -863,16 +863,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("Cannot rebase onto multiple branches."));
 
 	if (opt_rebase) {
-		struct commit_list *list = NULL;
-		struct commit *merge_head, *head;
-
-		head = lookup_commit_reference(orig_head.hash);
-		commit_list_insert(head, &list);
-		merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
-		if (!autostash && is_descendant_of(merge_head, list)) {
-			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
-			return run_merge();
+		if (!autostash) {
+			struct commit_list *list = NULL;
+			struct commit *merge_head, *head;
+
+			head = lookup_commit_reference(orig_head.hash);
+			commit_list_insert(head, &list);
+			merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
+			if (is_descendant_of(merge_head, list)) {
+				/* we can fast-forward this without invoking rebase */
+				opt_ff = "--ff-only";
+				return run_merge();
+			}
 		}
 		return run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
 	} else {



> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 17f4d0fe4e72..4c85be0417cf 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -272,6 +272,24 @@ test_expect_success '--rebase fast forward' '
>  	test_cmp reflog.expected reflog.fuzzy
>  '
>  
> +test_expect_success '--rebase --autostash fast forward' '
> +	test_when_finished "
> +		git reset --hard;
> +		git checkout to-rebase;
> +		git branch -D to-rebase-ff;
> +		git branch -D behind" &&

Do you need these semicolons?  I thought we designed our test
helpers and eval's in such a way that we can write these without
them (iow, I thought these newlines should suffice).

> +	git branch behind &&
> +	git checkout -b to-rebase-ff &&
> +	echo another modification >>file &&
> +	git add file &&
> +	git commit -m mod &&
> +
> +	git checkout behind &&
> +	echo dirty >file &&
> +	git pull --rebase --autostash . to-rebase-ff &&
> +	test "$(git rev-parse HEAD)" = "$(git rev-parse to-rebase-ff)"
> +'
> +
>  test_expect_success '--rebase with conflicts shows advice' '
>  	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
>  	git checkout -b seq &&
>
> --
> https://github.com/git/git/pull/365


Thanks.
