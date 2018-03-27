Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F63A1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 19:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeC0TXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 15:23:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40584 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeC0TXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 15:23:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id x4so858313wmh.5
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tNGyaGJiHD2KWLzXTSuRyqKfow2hbTTpU4q/VXZQAj8=;
        b=VpdOBwXOX5Eu/sfv5Ju6Xy3o5gS1JZb//w016/hJM0JjSey05+ZpNAEiayI1XuSreY
         1jbWF7FfBotAIHNSJ42dI5X6orI1f8oMVmJVqLsYFIEPBD6YlCi/AnFT91Zwf0frz+7f
         SsOp0IHlZHWTDN0jb0dGP6RutQyt99aIYbqPSTkmXXpipMV7mPfWd8i7gmPlV4yI9W2I
         TCC1VAr/aD4GbhGDH7otHBJHUsSacQtDyphpLBubuNRKZor5pa+fl3dTu1b1cL+PLE3E
         PCsn0dfLvt1q6U3unjaya2mapmpxfhmILF+oXjdutfOKOMeWo8q6X8+AGpYD6JTds8BD
         5PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tNGyaGJiHD2KWLzXTSuRyqKfow2hbTTpU4q/VXZQAj8=;
        b=nGJwcqUtpdpXa3LnnDmtt9tF4Fq/YnvJPtJOMvhxGqj0U8dGQMmt8jjQNEQgUanjAK
         W3gDKtokWeiAm7T55GZDq5h0qLYg0xzRMRxsJ214S4EsOp2CaVdjlaQ5NiCeNZVzgGmd
         4Oo/1wM3b07FyCOFcs0mMWGt0Y0yyjHBF2TLkzUeCwGUuBVxrrBzhwZotsWI49B10/5u
         uk3bLbM0yaR4FYDQkuXZupI84cwYWQJb9vWQM+y1XtmrIKyQQ9ie0ilA796BmfHdqr67
         h68/w2HdINL0R1ai1Rl44mvRlyv3Xj61epQtIpyyCxw+BMCW8Fakd7AKLSzMzA8fXTiT
         k5rQ==
X-Gm-Message-State: AElRT7EMh5BIKd7e7NvgAQq1TJDY7QT8FZP+nvZb7BBt6MaipjpDkzww
        yWgNl6rRah0EVSKiQGQcC1SChHcJ
X-Google-Smtp-Source: AIpwx49qPns9WPhU3aJa2Gp+YsgQNqgA2HgtzpFiWioTgrTvdEl/KzIONoQODhfroqOUOxpM4VOYAA==
X-Received: by 10.28.51.6 with SMTP id z6mr372605wmz.63.1522178631230;
        Tue, 27 Mar 2018 12:23:51 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id a11sm2394559wra.50.2018.03.27.12.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 12:23:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Aaron Greenberg <p@aaronjgreenberg.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] branch: implement shortcut to delete last branch
References: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com> <1522176390-646-2-git-send-email-p@aaronjgreenberg.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <1522176390-646-2-git-send-email-p@aaronjgreenberg.com>
Date:   Tue, 27 Mar 2018 21:23:48 +0200
Message-ID: <87tvt1wce3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 27 2018, Aaron Greenberg wrote:

> This patch gives git-branch the ability to delete the previous
> checked-out branch using the "-" shortcut. This shortcut already exists
> for git-checkout, git-merge, and git-revert. A common workflow is
>
> 1. Do some work on a local topic-branch and push it to a remote.
> 2. 'remote/topic-branch' gets merged in to 'remote/master'.
> 3. Switch back to local master and fetch 'remote/master'.
> 4. Delete previously checked-out local topic-branch.
>
> $ git checkout -b topic-a
> $ # Do some work...
> $ git commit -am "Implement feature A"
> $ git push origin topic-a
>
> $ git checkout master
> $ git branch -d topic-a
> $ # With this patch, a user could simply type
> $ git branch -d -
>
> "-" is a useful shortcut for cleaning up a just-merged branch
> (or a just switched-from branch.)
>
> Signed-off-by: Aaron Greenberg <p@aaronjgreenberg.com>

So just a tip on this E-Mail chain/patch submission. When you submit a
v2 make the subject "[PATCH v2] ...", see
Documentation/SubmittingPatches, also instead of sending two mails with
the same subject better to put any comments not in the commit message...

> ---

...right here, below the triple dash, and CC the people commenting on
the initial thread. With that, some comments on the change below:

>  builtin/branch.c  | 3 +++
>  t/t3200-branch.sh | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6d0cea9..9e37078 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -221,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		char *target = NULL;
>  		int flags = 0;
>
> +		if (!strcmp(argv[i], "-"))
> +			argv[i] = "@{-1}";
> +

If we just do this, then when I do the following:

    1. be on the 'foo' branch
    2. checkout 'bar', commit
    3. checkout 'foo'
    4. git branch -d -

I get this message:

    error: The branch 'bar' is not fully merged.
    If you are sure you want to delete it, run 'git branch -D bar'

While that works, I think it's better UI for us to suggest what's
actually the important alternation to the user's command, i.e. replace
-d with -D, otherwise they'll think "oh '-' doesn't work, let's try to
name the branch", only to get the same error. I.e. this on top:

diff --git a/builtin/branch.c b/builtin/branch.c
index cdf2de4f1d..081a4384ce 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -157,17 +157,18 @@ static int branch_merged(int kind, const char *name,

 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int resolved_dash)
 {
 	struct commit *rev = lookup_commit_reference(oid);
 	if (!rev) {
-		error(_("Couldn't look up commit object for '%s'"), refname);
+		error(_("Couldn't look up commit object for '%s'"), resolved_dash ? "-" : refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
 		error(_("The branch '%s' is not fully merged.\n"
 		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'."), branchname, branchname);
+		      "run 'git branch -D %s'."), branchname,
+		      resolved_dash ? "-" : branchname);
 		return -1;
 	}
 	return 0;
@@ -220,9 +221,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;
+		int resolved_dash = 0;

-		if (!strcmp(argv[i], "-"))
+		if (!strcmp(argv[i], "-")) {
 			argv[i] = "@{-1}";
+			resolved_dash = 1;
+		}

 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -255,7 +259,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,

 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
+					force, resolved_dash)) {
 			ret = 1;
 			goto next;
 		}

There are other error messages there, but as far as I can tell it's best
if those just talk about the "bar" branch, but have a look.

A test for that with i18ngrep left as an exercise...

>  		strbuf_branchname(&bname, argv[i], allowed_interpret);
>  		free(name);
>  		name = mkpathdup(fmt, bname.buf);
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 6c0b7ea..78c25aa 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -776,6 +776,14 @@ test_expect_success 'deleting currently checked out branch fails' '
>  	test_must_fail git branch -d my7
>  '
>
> +test_expect_success 'test deleting last branch' '
> +	git checkout -b my7.1 &&
> +	git checkout  - &&
> +	test_path_is_file .git/refs/heads/my7.1 &&
> +	git branch -d - &&
> +	test_path_is_missing .git/refs/heads/my7.1
> +'
> +
>  test_expect_success 'test --track without .fetch entries' '
>  	git branch --track my8 &&
>  	test "$(git config branch.my8.remote)" &&

I don't know how much this applies to the existing commands you
mentioned (looks like not), but for "branch" specifically this looks
very incomplete, in particular:

 * There's other modes where it takes commit-ish, e.g. "git branch foo
   bar" to create a new branch foo starting at bar, but with your patch
   "git branch foo -" won't work, even though there's no reason not to
   think it does.

 * There's no docs here to explain this difference, or TODO tests for
   maybe making that work later. Your patch would be a lot easier to
   review if you went through t/t3200-branch.sh, found the commit-ish
   occurances you don't support, and added failing tests for those, and
   explain in the commit message something to the effect of "I'm only
   making *this* work, here's the cases that *don't* work".
