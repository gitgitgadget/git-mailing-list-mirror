Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828991F461
	for <e@80x24.org>; Thu, 22 Aug 2019 12:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfHVM2X (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 08:28:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:44161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731393AbfHVM2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 08:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566476851;
        bh=INUDD9Ldk2f3lNlKvRV1IdB8YAdJMptFddT4LaTKcgs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bIdl4HGbMbxurLVNTlux6Rn1/S9RHJRFKGA3KIZj8EXAb0qS05tKB+oGLC4jfvo5I
         cI+t+ztnNVKc+SuoZht/qfGJbUVqZxGpstBn/XwQcJeM1QTIBhI6q9loNLqsunJpVQ
         Rnc5ctUtDrVZUgof2B5nzqtumyyL5fkICBm8ehw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaIw0-1hh2Pj22UC-00Jr5Y; Thu, 22
 Aug 2019 14:27:31 +0200
Date:   Thu, 22 Aug 2019 14:27:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Wijen <ben@wijen.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/1] rebase.c: make sure the active branch isn't moved
 when autostashing
In-Reply-To: <20190821182941.12674-2-ben@wijen.net>
Message-ID: <nycvar.QRO.7.76.6.1908221418540.46@tvgsbejvaqbjf.bet>
References: <20190820201237.10205-1-ben@wijen.net> <20190821182941.12674-1-ben@wijen.net> <20190821182941.12674-2-ben@wijen.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SCclLg6j9eb8ARDNMlfT7jHqVyJXORAbnCv3rMcCRR7ywN+rk+v
 lyC2HOKxWYLa5elfmqkFUtRuf9YDrAR47fBUliDcI5DVq372c84utCk6LfhN3OHvtQjY276
 dbmQgUhwc+ZKrtTOPFGn1nUJnF4AcYSwuSw01uFrvCBaAsZtOecmCJmiVCPxrGdCOOWCeNf
 WzefwCSqZQXnud1efGXfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3aIUM7t/D80=:jiiqWaWJ0GIA8b4Ip2ouid
 QItnKvl9GRIiYdhavoe0cJp0mlHrBcvpsfw2gC5RQdCH40tvHEMcsei0hHwmp/kr0JP6wl4U/
 BZz26Aciy6ChaOiVAOFeC4V+5SzUwj8lSAAKih9sUYJ7DEOuWRrqR94ZegnNvbrQwd5nQIQzq
 SboY0gtNAt3nnG6p7usa3Fb2zpC2QWIKy4TzGmgFPND0OnyXcRoixCH33yIZ4lu5/PcaAZnM5
 2A+tW5YdmdXR46kYxUCz5i1zw4Bg7FzkJaDY4fxqP3NZj/P3bbdk7sLbkg9Ouanqqk7zhvixe
 4TzPMy3wWOnJSoq7ldrSnA+jndIqg8OqgGLSKuJt/gi+8fDO4CMGu9Nw5gbHJXDDf5EliYEUo
 KWHdCl6P/3lZyMDMESwME/Zj/aMys3yreJr7w4H/XZ5c7ZyhfUrA7YTTwqOPDcK+ZHnTped75
 1X4rJ3WsYa+Ejm+6JxC7r0E5VoXOaepOG7s8u0Oal46vIn3P0Z5DjrzgDpZNTglmhdglLzfDX
 MO5fFB066F/yzyrtntoa5xauhBY9WaDHwatQnX7tfLVP9HCCKNDgEvu7eizcYbGgIItp+6gTr
 1LMmoc7CYw02wP669Q6ByhsnojrMR1S8ejY2SshY0K8gM5PVzDHkbTUshn1ALybaTk0obaoWb
 gQ2flKHudUK0XznqEkWTMdbkcWkVW5waiRzWblgG0WnPwKIbobuC8lg9QZvK20U6wcRq/fZHW
 2j+sG3BrUjHgO/8f/oXUO+6A9KMiZGx9Yj53lqyUXyPQoJU2Oq4tsR36cCIjlXU7zk5/ein67
 UBfq2Z6W2LShQZuXoRfHghzwxSLotZ35EawB26zpdmfj5BBFpqA1d876g2dR19Uzfrprz93NI
 dzreWl9CKyW0Y+gLpTErvYC7/s/TIbZjQrAX2nrVlHDN/WOKMaoPsRruK9Z81IbYtJvJ4T2jA
 8cc94HHolnSS1I21RlHLx4xkCp6XRf+3nq08XI6tq3sCQVnQNn+KR3u/pzmoeKPVmGgPuL+G9
 LnrJlyk5XSyMF1ISsr7pazczeo2Y4aceDNlT/iBnwCcyxdcBfLhOV5OaB21IWiHscb0+ELfjB
 u0ekk37JZvV+wvtVJClbk6AIvpMrktyJbbjNOBZwIPQ4SB5i8ABLQ+BIeZ13AMio6tSWfnzFl
 yRnBI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Wed, 21 Aug 2019, Ben Wijen wrote:

> Consider the following scenario:
>     git checkout not-the-master
>     work work work
>     git rebase --autostash upstream master
>
> Here 'rebase --autostash <upstream> <branch>' incorrectly moves the
> active branch (not-the-master) to master (before the rebase).
>
> The expected behavior: (58794775:/git-rebase.sh:526)
>     AUTOSTASH=3D$(git stash create autostash)
>     git reset --hard
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH
>
> The actual behavior: (6defce2b:/builtin/rebase.c:1062)
>     AUTOSTASH=3D$(git stash create autostash)
>     git reset --hard master
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH

Interesting. So the only difference is that the original rebase called
`git reset --hard` on the current HEAD, while the new behavior tries to
reset to the branch to which the user wants to switch, right away.

I can see that this would lead to possible problems e.g. if a file had
been added between master and the current branch.

> This commit reinstates the 'legacy script' behavior as introduced with
> 58794775: rebase: implement --[no-]autostash and rebase.autostash
>
> As with this commit the reset must never change the active branch,
> the 'HEAD is now at ...' message has now been removed.

Actually, I am not so sure that I like this change.

Previously, users had a chance to figure out to which revision the
worktree was reset, before switching the branch (because switching the
branch we _do_, via `git checkout master`).

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..a928f44941 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1968,9 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  				state_dir_path("autostash", &options);
>  			struct child_process stash =3D CHILD_PROCESS_INIT;
>  			struct object_id oid;
> -			struct commit *head =3D
> -				lookup_commit_reference(the_repository,
> -							&options.orig_head);

This should probably be changed to look up `HEAD` instead, then, so that
we can keep the message.

I.e. you probably want to use `get_oid("HEAD", &head_oid)` instead.

>  			argv_array_pushl(&stash.args,
>  					 "stash", "create", "autostash", NULL);
> @@ -1991,17 +1988,14 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  				    options.state_dir);
>  			write_file(autostash, "%s", oid_to_hex(&oid));
>  			printf(_("Created autostash: %s\n"), buf.buf);
> -			if (reset_head(&head->object.oid, "reset --hard",
> +
> +			/*
> +			 * We might not be on orig_head yet:
> +			 * Make sure to reset w/o switching branches...
> +			 */
> +			if (reset_head(NULL, "reset --hard",
>  				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
>  				die(_("could not reset --hard"));
> -			printf(_("HEAD is now at %s"),
> -			       find_unique_abbrev(&head->object.oid,
> -						  DEFAULT_ABBREV));
> -			strbuf_reset(&buf);
> -			pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
> -			if (buf.len > 0)
> -				printf(" %s", buf.buf);
> -			putchar('\n');
>
>  			if (discard_index(the_repository->index) < 0 ||
>  				repo_read_index(the_repository) < 0)
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index b8f4d03467..d1352096f2 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -37,7 +37,6 @@ test_expect_success setup '
>  create_expected_success_am () {
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	First, rewinding head to replay your work on top of it...
>  	Applying: second commit
>  	Applying: third commit
> @@ -48,7 +47,6 @@ create_expected_success_am () {
>  create_expected_success_interactive () {
>  	q_to_cr >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	Applied autostash.
>  	Successfully rebased and updated refs/heads/rebased-feature-branch.
>  	EOF
> @@ -57,7 +55,6 @@ create_expected_success_interactive () {
>  create_expected_failure_am () {
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	First, rewinding head to replay your work on top of it...
>  	Applying: second commit
>  	Applying: third commit
> @@ -70,7 +67,6 @@ create_expected_failure_am () {
>  create_expected_failure_interactive () {
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	Applying autostash resulted in conflicts.
>  	Your changes are safe in the stash.
>  	You can run "git stash pop" or "git stash drop" at any time.
> @@ -306,4 +302,16 @@ test_expect_success 'branch is left alone when poss=
ible' '
>  	test unchanged-branch =3D "$(git rev-parse --abbrev-ref HEAD)"
>  '
>
> +test_expect_success 'never change active branch' '
> +	git checkout -b upstream unrelated-onto-branch &&
> +	test_when_finished "
> +		git reset --hard &&
> +		git checkout - &&
> +		git branch -D upstream" &&

I feel like we want to have a more meaningful branch name than
"upstream", and then we can get away with leaving it in place, i.e. just

	test_when_finished "git reset --hard && git checkout -" &&

> +	echo changed >file0 &&
> +	git add file0 &&

Since `file0` is already tracked, I think that this `git add` invocation
only distracts from the essence of this test case.

> +	git rebase --autostash upstream feature-branch &&
> +	test_cmp_rev upstream unrelated-onto-branch

Otherwise: well done! And thank you so much for fixing this.

Ciao,
Dscho

> +'
> +
>  test_done
> --
> 2.22.0
>
>
