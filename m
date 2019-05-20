Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0835B1F462
	for <e@80x24.org>; Mon, 20 May 2019 23:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfETXte (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 19:49:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42772 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfETXtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 19:49:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so26337221eda.9
        for <git@vger.kernel.org>; Mon, 20 May 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i3rQwUbAL4TEWZPkZYLJf/D1JeCUcoN+HhU/G4bOm9w=;
        b=oA3J8qzS0Z3iRtwy4SXXBODYnqhTl7OivFrYqX49cK5C0YHuhOXpTcCGL159cKFFYH
         PjltbbUnhQw/5hy7+GBW1zLiq6ukzKFCgvuRe5u39xLXsjH50tL/YH4GoE6ZEiKKP+bB
         YnMkVtVcsju317o1hHIcuTjO9tpMGnhu+nuunLL7KAhNvwqzICpTA0QnlzIPrQb3+5PD
         yIjl+ghmA0LUZKX9jUBoowtguH/lK0M6J5JH8EKqOIRkH3gEe6qzTtCf0ABDBBCkHsZC
         Nff5sS6B/WoXQIERajw7EhhG/uQEy2y6OrrdWao4e2AIb/on14M36TM0rlKI7123T+o6
         2mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=i3rQwUbAL4TEWZPkZYLJf/D1JeCUcoN+HhU/G4bOm9w=;
        b=Dks9WSP/BajAKXWcPjzJJtgZUUGsAqW2p/cPtvSmpEPKcf4k3AtILruV2X+URu0ENk
         OwU6J0XKg3WgTzg6jgcnh7BZVjo13BkcupXcVWkomzT1A2F4MgBTGEV2ZpKHyCwuTqP6
         T0RdR46AhiX+826AS08vhYqF7JHuJNCY4yL4w2ZPD/HQ1EPvYk1bwhMG8o9aKg7K4848
         Uo01JtpCGRIcGi9YTZMxl2EzwcSz9XKIxVTQ1bQEJvdx7ycq17NBsggYjDP8wPTDGKgA
         0jbPkqziV2rl/tb51dLpKNEHtlDHK7DI8FLTnrlSaCm8mbrH/lNjbUHdwZ8eWGRAacyL
         EL+Q==
X-Gm-Message-State: APjAAAXd8NoCK1H2lyeNdu2u30btL3ODSkRGOJReUiUAfRfI6pXUjf5S
        eYFe3eCDTUCCyY+wN1UjiqnIHnpcUfM=
X-Google-Smtp-Source: APXvYqwgJGOphdmIWe/RJytDXVBQqbe0RKg/T3jYckYhafvOwz7sDkb47oX/gl9OjbyJv4WRX3JmQQ==
X-Received: by 2002:a50:92c9:: with SMTP id l9mr78652078eda.75.1558396170789;
        Mon, 20 May 2019 16:49:30 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l19sm5952069edc.84.2019.05.20.16.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 16:49:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little projects
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20190520182353.22221-1-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190520182353.22221-1-matheus.bernardino@usp.br>
Date:   Tue, 21 May 2019 01:49:28 +0200
Message-ID: <87d0kcvg8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 20 2019, Matheus Tavares wrote:

> Hi, =C3=86var
>
>> Give "rebase -i" some option so when you "reword" the patch is
>> included in the message.
>>
>> I keep going to the shell because I have no idea what change I'm
>> describing.
>
> I have the same problem, so I wanted to try solving this. The patch
> bellow creates a "rebase.verboseCommit" configuration that includes
> a diff when rewording or squashing. I'd appreciate knowing your thoughts
> on it.
>
> As Christian wisely pointed out to me, though, we can also achieve this
> behavior by setting "commit.verbose" to true. The only "downside" of it
> is that users cannot choose to see the diff only when rebasing. Despite
> of that, if we decide not to go with this patch, what do you think of
> adding a "commit.verbose" entry at git-rebase's man page?

Thanks for working on this. I'd somehow missed the addition of the
commit.verbose option, so the problem I had is 100% solved by it (and
I've turned it on).

I think it's better to just document it with rebase, perhaps rather than
mention that option specifically (but that would also be fine) promise
that we support "commit" options in general.

Do we promise anywhere that interactive rebase is going to run the
"normal" git-commit command. From a quick skimming of the docs it
doesn't seem so, perhaps we should explicitly promise that, and then
test for it if we don't (e.g. by stealing the tests you added).

Aside from that, if this patch is kept I see commit.verbose is a
bool-or-int option, but yours is maybe-bool, so there's no way with
rebase.verboseCommit to turn on the higher level of verbosity. Perhaps
if this option is kept some implementation that just grabs whatever "X"
rebase.verboseCommit=3DX is set to and passes it as commit.verbase=3DX down
to git-commit is better, letting it deal with the validation?

> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebas=
e.txt
> index d98e32d812..ae50b3e05d 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -62,3 +62,8 @@ rebase.rescheduleFailedExec::
>  	Automatically reschedule `exec` commands that failed. This only makes
>  	sense in interactive mode (or when an `--exec` option was provided).
>  	This is the same as specifying the `--reschedule-failed-exec` option.
> +
> +rebase.verboseCommit::
> +	When rewording or squashing commits, during an interactive rebase, show
> +	the commits' diff to help describe the modifications they bring. False
> +	by default.
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..1596fc4cd0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -914,6 +914,7 @@ N_("you have staged changes in your working tree\n"
>  #define CLEANUP_MSG (1<<3)
>  #define VERIFY_MSG  (1<<4)
>  #define CREATE_ROOT_COMMIT (1<<5)
> +#define VERBOSE_COMMIT (1<<6)
>
>  static int run_command_silent_on_success(struct child_process *cmd)
>  {
> @@ -1007,6 +1008,8 @@ static int run_git_commit(struct repository *r,
>  		argv_array_push(&cmd.args, "-n");
>  	if ((flags & AMEND_MSG))
>  		argv_array_push(&cmd.args, "--amend");
> +	if ((flags & VERBOSE_COMMIT))
> +		argv_array_push(&cmd.args, "-v");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>  	if (defmsg)
> @@ -1782,7 +1785,7 @@ static int do_pick_commit(struct repository *r,
>  	char *author =3D NULL;
>  	struct commit_message msg =3D { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf =3D STRBUF_INIT;
> -	int res, unborn =3D 0, allow;
> +	int res, unborn =3D 0, allow, verbose_commit =3D 0;
>
>  	if (opts->no_commit) {
>  		/*
> @@ -1843,6 +1846,9 @@ static int do_pick_commit(struct repository *r,
>  		return error(_("cannot get commit message for %s"),
>  			oid_to_hex(&commit->object.oid));
>
> +	if (git_config_get_maybe_bool("rebase.verbosecommit", &verbose_commit) =
< 0)
> +		warning("Invalid value for rebase.verboseCommit. Using 'false' instead=
.");
> +
>  	if (opts->allow_ff && !is_fixup(command) &&
>  	    ((parent && oideq(&parent->object.oid, &head)) ||
>  	     (!parent && unborn))) {
> @@ -1853,6 +1859,8 @@ static int do_pick_commit(struct repository *r,
>  		if (res || command !=3D TODO_REWORD)
>  			goto leave;
>  		flags |=3D EDIT_MSG | AMEND_MSG | VERIFY_MSG;
> +		if (verbose_commit)
> +			flags |=3D VERBOSE_COMMIT;
>  		msg_file =3D NULL;
>  		goto fast_forward_edit;
>  	}
> @@ -1909,12 +1917,17 @@ static int do_pick_commit(struct repository *r,
>  			author =3D get_author(msg.message);
>  	}
>
> -	if (command =3D=3D TODO_REWORD)
> +	if (command =3D=3D TODO_REWORD) {
>  		flags |=3D EDIT_MSG | VERIFY_MSG;
> +		if (verbose_commit)
> +			flags |=3D VERBOSE_COMMIT;
> +	}
>  	else if (is_fixup(command)) {
>  		if (update_squash_messages(r, command, commit, opts))
>  			return -1;
>  		flags |=3D AMEND_MSG;
> +		if (verbose_commit)
> +			flags |=3D VERBOSE_COMMIT;
>  		if (!final_fixup)
>  			msg_file =3D rebase_path_squash_msg();
>  		else if (file_exists(rebase_path_fixup_msg())) {
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 1723e1a858..9b410d31e2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1477,4 +1477,60 @@ test_expect_success 'valid author header when auth=
or contains single quote' '
>  	test_cmp expected actual
>  '
>
> +write_script "reword-and-check-for-diff" <<\EOF &&
> +case "$1" in
> +*/git-rebase-todo)
> +	sed s/pick/reword/ "$1" > "$1.tmp"
> +	mv -f "$1.tmp" "$1"
> +	;;
> +*)
> +	grep '^diff --git' "$1" >has-diff
> +	;;
> +esac
> +exit 0
> +EOF
> +
> +test_expect_success 'rebase -i does not show diff by default when reword=
ing' '
> +	rebase_setup_and_clean no-verbose-commit-reword &&
> +	test_set_editor "$PWD/reword-and-check-for-diff" &&
> +	git rebase -i HEAD~1 &&
> +	test_line_count =3D 0 has-diff
> +'
> +
> +test_expect_success 'rebase -i respects rebase.verboseCommit when reword=
ing' '
> +	rebase_setup_and_clean verbose-commit-reword &&
> +	test_config rebase.verboseCommit true &&
> +	test_set_editor "$PWD/reword-and-check-for-diff" &&
> +	git rebase -i HEAD~1 &&
> +	test_line_count -gt 0 has-diff
> +'
> +
> +write_script "squash-and-check-for-diff" <<\EOF &&
> +case "$1" in
> +*/git-rebase-todo)
> +	sed "s/pick \([0-9a-f]*\) E/squash \1 E/" "$1" > "$1.tmp"
> +	mv -f "$1.tmp" "$1"
> +	;;
> +*)
> +	grep '^diff --git' "$1" >has-diff
> +	;;
> +esac
> +exit 0
> +EOF
> +
> +test_expect_success 'rebase -i does not show diff by default when squash=
ing' '
> +	rebase_setup_and_clean no-verbose-commit-squash &&
> +	test_set_editor "$PWD/squash-and-check-for-diff" &&
> +	git rebase -i HEAD~2 &&
> +	test_line_count =3D 0 has-diff
> +'
> +
> +test_expect_success 'rebase -i respects rebase.verboseCommit when squash=
ing' '
> +	rebase_setup_and_clean verbose-commit-squash &&
> +	test_config rebase.verboseCommit true &&
> +	test_set_editor "$PWD/squash-and-check-for-diff" &&
> +	git rebase -i HEAD~2 &&
> +	test_line_count -gt 0 has-diff
> +'
> +
>  test_done
