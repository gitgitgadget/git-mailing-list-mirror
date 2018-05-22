Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877731F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEVS0R (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:26:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46030 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEVS0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:26:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id r13-v6so6676861ybm.12
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MQuJtmMvC8xM04g6S6vLRpevLjtozOTVi8pDkJv4Fdc=;
        b=UJiEQrnX2cSEbKTtZShuiLepZiF5hoQ32C7bzZ9Ym6a1up26IImt4f6HclWCoFwzBW
         nRS1N+aFE7IDgVvRtzmRzPX0fsL+oFbXm6GWvYuO6ICAnm9XMjn+UQ6iHI/xdXxCTp1C
         Msi+KRmhs06Ml19Q6aNXKxG/HOkeZq36ZfHX/129tM/atDW9lrKdddxKBuU/lTGXLxE0
         Keo3+QFO6nVruaj9D+pP0QJCK6OGLt4FsqZNiLXFlkLKQPH9e8KN+SAdc/jN3Marky56
         vgWTKMNoI9wbm/4I8wpydXiWu91JCRv45LfDtRhDIX1CoK5EjvPRRuU3LxJYNCoy4nLW
         DPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MQuJtmMvC8xM04g6S6vLRpevLjtozOTVi8pDkJv4Fdc=;
        b=ubQOnaBdEEA6A275FFrRyeiJRiP2c7HDgW+zqURiA6Z/DiCjdi3sM/401sYj0Vqf7s
         wLmuEOF2mpp6pJr7lfmIgcyAMSwwLDxS0W+P3L5iiMg7so/KF9IssT7wjt0HYihM18lL
         grMZwCDAT4GygqxhOWnEnjpy5d8iGo6fYWTlwy7ZbXk4mpgeHohpkCRJV+0/wr7o1Jg1
         yYHFS5iwoSA1actEVpfnHP8K3bizKv4he00SDTm5jhtfVvUFlEJ9DE+B+12ztp3tmiZa
         Siw55ivgJz6N42RMGkSJnAZHC+5NpuCj3gPqjYSz9r8UyqJc3O0t+MDMHcYw1oZAJthm
         R7bA==
X-Gm-Message-State: ALKqPwdLczZV4iCdSbT2njbo3qUfZPyt5Jt8D4upTwotqOHem4HuCjOs
        9rTwF2wwmpGwNrEgOi+DImo9EuyIDOi8rJ49GJ3bMkssS6Q=
X-Google-Smtp-Source: AB8JxZrJhlukEdZWYXbVjLb5iyJ7yEMoI+FU0mRFmyjMqwekmil9PQbFym0VnxRfJDQEwgBLOTUViG5OKzU+1oGwwHI=
X-Received: by 2002:a25:ae45:: with SMTP id g5-v6mr5698175ybe.292.1527013575668;
 Tue, 22 May 2018 11:26:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:b189:0:0:0:0:0 with HTTP; Tue, 22 May 2018 11:26:13
 -0700 (PDT)
In-Reply-To: <20180522133110.32723-2-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com> <20180522133110.32723-2-alban.gruin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 May 2018 11:26:13 -0700
Message-ID: <CAGZ79kaTPu=z_6oJk__meuyhUt-pU_LtOJ90rPTQcC=YvhnOnw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/4] rebase: duplicate git-rebase--interactive.sh to git-rebase--preserve-merges.sh
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 6:31 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This duplicates git-rebase--interactive.sh to
> git-rebase--preserve-merges.sh. This is done to split -p from -i. No
> modifications are made to this file here, but any code that is not used by -p
> will be stripped in the next commit.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>

So how would I best review this?

I applied the patches locally[1], and ran git-ls-tree on this commit
hoping to find the same blob id for git-rebase--interactive.sh as for
git-rebase--preserve-merges.sh; however I did not.

So I diffed them and had the diff below[2], which looks like that has parts
of Johannes recent series?

Thanks,
Stefan

[1] After applying I pushed it to
https://github.com/stefanbeller/git/tree/alban_split_off_-p
and this patch is commit 9f64342ea1b64d43e4675b5f202174c9e0f77dbf

[2] $ git diff 9f64342ea1b64d43e4675b5f202174c9e0f77dbf:git-rebase--preserve-merges.sh
\
    9f64342ea1b64d43e4675b5f202174c9e0f77dbf:git-rebase--interactive.sh
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--interactive.sh
index 9947e6265fe..2f4941d0fc9 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--interactive.sh
@@ -155,13 +155,19 @@ reschedule_last_action () {
 append_todo_help () {
        gettext "
 Commands:
-p, pick = use commit
-r, reword = use commit, but edit the commit message
-e, edit = use commit, but stop for amending
-s, squash = use commit, but meld into previous commit
-f, fixup = like \"squash\", but discard this commit's log message
-x, exec = run command (the rest of the line) using shell
-d, drop = remove commit
+p, pick <commit> = use commit
+r, reword <commit> = use commit, but edit the commit message
+e, edit <commit> = use commit, but stop for amending
+s, squash <commit> = use commit, but meld into previous commit
+f, fixup <commit> = like \"squash\", but discard this commit's log message
+x, exec <commit> = run command (the rest of the line) using shell
+d, drop <commit> = remove commit
+l, label <label> = label current HEAD with a name
+t, reset <label> = reset HEAD to a label
+m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
+.       create a merge commit using the original merge commit's
+.       message (or the oneline, if no original merge commit was
+.       specified). Use -c <commit> to reword the commit message.

 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
@@ -888,6 +894,8 @@ init_revisions_and_shortrevisions () {
        else
                revisions=$onto...$orig_head
                shortrevisions=$shorthead
+               test -z "$squash_onto" ||
+               echo "$squash_onto" >"$state_dir"/squash-onto
        fi
 }

@@ -942,7 +950,7 @@ EOF
        die "Could not skip unnecessary pick commands"

        checkout_onto
-       if test -z "$rebase_root" && test ! -d "$rewritten"
+       if test ! -d "$rewritten"
        then
                require_clean_work_tree "rebase"
                exec git rebase--helper ${force_rebase:+--no-ff}
$allow_empty_message \
@@ -964,6 +972,8 @@ git_rebase__interactive () {
        init_revisions_and_shortrevisions

        git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+               ${rebase_merges:+--rebase-merges} \
+               ${rebase_cousins:+--rebase-cousins} \
                $revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
        die "$(gettext "Could not generate todo list")"
