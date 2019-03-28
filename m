Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C5D20248
	for <e@80x24.org>; Thu, 28 Mar 2019 23:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfC1XNf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 19:13:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45135 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfC1XNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 19:13:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so428550edd.12
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yLtA9lHgXWSdcRsVmCI1HaitggWkr3VcWdwxo9xnNsM=;
        b=Alu8kMIPFsTG7FWnEJJvnf4rIB5secqIVCwMcRSBezMhcYr+F0AtC1sgEGHz+KrzAw
         KBUvhJ66N84xBe3LK00OuMlCr3+QpiQgzgZ1tE2F4yDYxWWSOzqOT5eYV8fw4XQMLmdS
         dMuT+jDKrypaKALI7XqdzKTrkDkSLEMCFcGD/foA0Sfvrmp+Z9Eg51l9nw8uZ8nlMxBl
         dpukMe5HCbbIPFVgeot3NHNbEtM+ECmd86UpVuvUcqQJUpj4cP5/H//Bq7eYZ58UCrSJ
         IWmZiJaltLJSqcUbZ8b0PU00aUbtZV9RApQ2VhxiUfviH07MmhT5uQHJIPVQIkXvBLnq
         OR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yLtA9lHgXWSdcRsVmCI1HaitggWkr3VcWdwxo9xnNsM=;
        b=jaPqjeaLk6Ovlx98Cyx/VInYNLwQRYFjoG4ezgyBvwXwC+zH4FmhB8awUU/Wbsc1SZ
         mshYvSis/HTzgmYFJizO7hLPa2oUq30nCDUPfy3l57kl8hlJhL1xOYMXt/2OmwEF8jzQ
         ZF3usawm91hGQIxCnoBCdCv7ysH7u+1Azgd1Yk3S1YeWbVImFU9E1kAe0TKWSRym6Hh/
         cECGyl/hzlFQl/SU98vMFroSZEn0s771mJfW4Kx+uQY6NtjguSj36cpS72Refnhk8NJ3
         Y0ws8qgFWN9GzxteEI1ZUoLuLrHBV+LqTUxvlP0Bxefa01rQ0vNC0M8xQGlMWqbB4uoO
         F0bA==
X-Gm-Message-State: APjAAAVnfdzN2V4KPeiv0ZUIwA5Lxz+Qrg8zPp8icQE1T1f3H4kMeIRQ
        AZsQVa42BKXkjmla0LlRXCs=
X-Google-Smtp-Source: APXvYqzAgIymXtfHBsbIWgLF9ww7of0fF4BpGeyZ02qpuPKkzl/zYfzH1pZPQkCBx4vc14ccaK88lQ==
X-Received: by 2002:a50:b1bc:: with SMTP id m57mr28728670edd.116.1553814812817;
        Thu, 28 Mar 2019 16:13:32 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m4sm57662ejl.49.2019.03.28.16.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 16:13:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] rebase: teach rebase --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com> <20190328221745.GA3941@dev-l>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190328221745.GA3941@dev-l>
Date:   Fri, 29 Mar 2019 00:13:30 +0100
Message-ID: <87tvfma8yt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 28 2019, Denton Liu wrote:

> A common scenario is if a user is working on a topic branch and they
> wish to make some changes to intermediate commits or autosquash, they
> would run something such as
>
> 	git rebase -i --onto master... master
>
> in order to preserve the merge base. This prevents unnecessary commit
> churning.
>
> Alternatively, a user wishing to test individual commits in a topic
> branch without changing anything may run
>
> 	git rebase -x ./test.sh master... master
>
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
>
> This allows us to rewrite the above as
>
> 	git rebase -i --keep-base master
>
> and
>
> 	git rebase -x ./test.sh --keep-base master
>
> respectively.
>
> Add tests to ensure --keep-base works correctly in the normal case and
> fails when there are multiple merge bases, both in regular and
> interactive mode. Also, test to make sure conflicting options cause
> rebase to fail. While we're adding test cases, add a missing
> set_fake_editor call to 'rebase -i --onto master...side'.
>
> While we're documenting the --keep-base option, change an instance of
> "merge-base" to "merge base", which is the consistent spelling.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> =C3=86var, I have a feeling that we're still miscommunicating and we don't
> fully understand each other. I'm putting up v2 to hopefully clear things
> up a little but I welcome more feedback.
>
> This patch now depends "[PATCH 1/8] tests (rebase): spell out the
> `--keep-empty` option" which is the first patch of Johannes's "Do not
> use abbreviated options in tests" patchset[1]. (Thanks for catching
> that, Johannes!)

Yeah I'm still confused. Gotta go now, but just some early poking I did.

First, there's now docs saying "starting point" v.s. "fork point", but
the tests are still the same, i.e. the ones I can just replace with
either of `git merge-base [--fork-point] @{u} master`.

It would really help if the tests actually stressed the parts where this
is different, including argument-less versions. I.e. just "git rebase
--keep-base".

Speaking of that, even though you say this is different than
"--fork-point" you may or may not have noticed that if "argc < 1" you
*still* go through the whole fork_point codepath, which will set
"options.restrict_revision" for you. This is part of what I mentioned
upthread. I.e. with this on top of this patch all your tests still pass:

    diff --git a/builtin/rebase.c b/builtin/rebase.c
    index 3347dd8975..e38a5044eb 100644
    --- a/builtin/rebase.c
    +++ b/builtin/rebase.c
    @@ -1515,7 +1515,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
     								    NULL);
     			if (!options.upstream_name)
     				error_on_missing_default_upstream();
    -			if (fork_point < 0)
    +			if (fork_point < 0 && !keep_base)
     				fork_point =3D 1;
     		} else {
     			options.upstream_name =3D argv[0];
    @@ -1524,9 +1524,11 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
     			if (!strcmp(options.upstream_name, "-"))
     				options.upstream_name =3D "@{-1}";
     		}
    -		options.upstream =3D peel_committish(options.upstream_name);
    -		if (!options.upstream)
    -			die(_("invalid upstream '%s'"), options.upstream_name);
    +		if (!keep_base) {
    +			options.upstream =3D peel_committish(options.upstream_name);
    +			if (!options.upstream)
    +				/* I suppose we need to keep this die(...) somewhere still... */
    +				die(_("invalid upstream '%s'"), options.upstream_name);
    +		}
     		options.upstream_arg =3D options.upstream_name;
     	} else {
     		if (!options.onto_name) {
    @@ -1564,6 +1566,8 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
     		}
     		options.onto =3D lookup_commit_or_die(&merge_base,
     						    options.onto_name);
    +		if (keep_base)
    +			options.upstream =3D options.onto;
     	} else {
     		options.onto =3D peel_committish(options.onto_name);
     		if (!options.onto)

But now because (and bear with me, I don't really get all this) we are
not implicitly setting options.restrict_revision later in the
"fork_point > 0" case *and* our "options.upstream" SHA-1 is the base you
find with --keep-base instead of the @{u} SHA-1 the
can_fast_forward(...) "if" kicks in, so now:

    $ git status
    On branch master
    Your branch and 'origin/master' have diverged,
    and have 3 and 37 different commits each, respectively.

    # Here your version would always re-rebase it
    $ ~/g/git/git --exec-path=3D$PWD rebase --keep-base
    Current branch master is up to date.

But "-i" still works as intended:

    $ ~/g/git/git --exec-path=3D$PWD rebase --keep-base -i
    hint: Waiting for your editor to close the file... Waiting for Emacs...
    Successfully rebased and updated refs/heads/master.
    $ git status
    On branch master
    Your branch and 'origin/master' have diverged,
    and have 3 and 37 different commits each, respectively.

I don't know about the *other* use-cases you have in mind, but I can't
see a reason for why *that* simple case shouldn't work like that. Why
would we redundantly rebase every time in this case, just becase some
mode of --onto does it? I think if anything we should teach it the same
lazyness, or maybe that breaks stuff (what stuff?).

Peff discussed some of these variables & their interaction in
https://public-inbox.org/git/20190224101029.GA13438@sigill.intra.peff.net/

I just re-read that, but this whole thing has paged out of my brain in
the meantime, and on my quick reading before sending this E-Mail I'm
still not sure what all the subtleties involved are.

But one thing's for sure, I think exhaustive testing of all the edge
cases involved will make this a lot clearer. I.e.:

 * Here upstream has diverged, we rebase (and in the "noop case?)
 * Here upstream has diverged, *and* rewound (and in the "noop case?)
 * etc. etc.

> Changes since v1:
>
> * Squashed old set into one patch
> * Fixed indentation style and dangling else
> * Added more documentation after discussion with =C3=86var
>
> [1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66=
a.1553537656.git.gitgitgadget@gmail.com/
>
>  Documentation/git-rebase.txt     | 25 ++++++++++++--
>  builtin/rebase.c                 | 32 ++++++++++++++----
>  t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6363d674b7..27be1f48ff 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
>  SYNOPSIS
>  --------
>  [verse]
> -'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <ne=
wbase>]
> -	[<upstream> [<branch>]]
> +'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
> +	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
>  'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <ne=
wbase>]
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --sh=
ow-current-patch
> @@ -217,6 +217,19 @@ As a special case, you may use "A\...B" as a shortcu=
t for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
>
> +--keep-base::
> +	Set the starting point at which to create the new commits to the
> +	merge base of <upstream> <branch>. Running
> +	'git rebase --keep-base <upstream> <branch>' is equivalent to
> +	running 'git rebase --onto <upstream>... <upstream>'.
> ++
> +Although both this option and --fork-point find the merge base between
> +<upstream> and <branch>, this option uses the merge base as the _starting
> +point_ on which new commits will be created, whereas --fork-point uses
> +the merge base to determine the _set of commits_ which will be rebased.
> ++
> +See also INCOMPATIBLE OPTIONS below.
> +
>  <upstream>::
>  	Upstream branch to compare against.  May be any valid commit,
>  	not just an existing branch name. Defaults to the configured
> @@ -364,6 +377,10 @@ ends up being empty, the <upstream> will be used as =
a fallback.
>  +
>  If either <upstream> or --root is given on the command line, then the
>  default is `--no-fork-point`, otherwise the default is `--fork-point`.
> ++
> +If your branch was based on <upstream> but <upstream> was rewound and
> +your branch contains commits which were dropped, this option can be used
> +with `--keep-base` in order to drop those commits from your branch.
>
>  --ignore-whitespace::
>  --whitespace=3D<option>::
> @@ -539,6 +556,8 @@ In addition, the following pairs of options are incom=
patible:
>   * --preserve-merges and --rebase-merges
>   * --rebase-merges and --strategy
>   * --rebase-merges and --strategy-option
> + * --keep-base and --onto
> + * --keep-base and --root
>
>  BEHAVIORAL DIFFERENCES
>  -----------------------
> @@ -863,7 +882,7 @@ NOTE: While an "easy case recovery" sometimes appears=
 to be successful
>        --interactive` will be **resurrected**!
>
>  The idea is to manually tell 'git rebase' "where the old 'subsystem'
> -ended and your 'topic' began", that is, what the old merge-base
> +ended and your 'topic' began", that is, what the old merge base
>  between them was.  You will have to find a way to name the last commit
>  of the old 'subsystem', for example:
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..7c14a00460 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -27,8 +27,8 @@
>  #include "branch.h"
>
>  static char const * const builtin_rebase_usage[] =3D {
> -	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> -		"[<upstream>] [<branch>]"),
> +	N_("git rebase [-i] [options] [--exec <cmd>] "
> +		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
>  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
>  		"--root [<branch>]"),
>  	N_("git rebase --continue | --abort | --skip | --edit-todo"),
> @@ -1018,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>  	};
>  	const char *branch_name;
>  	int ret, flags, total_argc, in_progress =3D 0;
> +	int keep_base =3D 0;
>  	int ok_to_skip_pre_rebase =3D 0;
>  	struct strbuf msg =3D STRBUF_INIT;
>  	struct strbuf revisions =3D STRBUF_INIT;
> @@ -1051,6 +1052,8 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>  		OPT_STRING(0, "onto", &options.onto_name,
>  			   N_("revision"),
>  			   N_("rebase onto given branch instead of upstream")),
> +		OPT_BOOL(0, "keep-base", &keep_base,
> +			 N_("use the merge-base of upstream and branch as the current base")),
>  		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
>  			 N_("allow pre-rebase hook to run")),
>  		OPT_NEGBIT('q', "quiet", &options.flags,
> @@ -1217,6 +1220,13 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>
> +	if (keep_base) {
> +		if (options.onto_name)
> +			die(_("cannot combine '--keep-base' with '--onto'"));
> +		if (options.root)
> +			die(_("cannot combine '--keep-base' with '--root'"));
> +	}
> +
>  	if (action !=3D NO_ACTION && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> @@ -1541,12 +1551,22 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  	}
>
>  	/* Make sure the branch to rebase onto is valid. */
> -	if (!options.onto_name)
> +	if (keep_base) {
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, options.upstream_name);
> +		strbuf_addstr(&buf, "...");
> +		options.onto_name =3D xstrdup(buf.buf);
> +	} else if (!options.onto_name)
>  		options.onto_name =3D options.upstream_name;
>  	if (strstr(options.onto_name, "...")) {
> -		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> -			die(_("'%s': need exactly one merge base"),
> -			    options.onto_name);
> +		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
> +			if (keep_base)
> +				die(_("'%s': need exactly one merge base with branch"),
> +				    options.upstream_name);
> +			else
> +				die(_("'%s': need exactly one merge base"),
> +				    options.onto_name);
> +		}
>  		options.onto =3D lookup_commit_or_die(&merge_base,
>  						    options.onto_name);
>  	} else {
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-three=
dots.sh
> index ddf2f64853..9c2548423b 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' '
>  	git checkout side &&
>  	git reset --hard K &&
>
> +	set_fake_editor &&
>  	test_must_fail git rebase -i --onto master...side J
>  '
>
> +test_expect_success 'rebase --keep-base --onto incompatible' '
> +	test_must_fail git rebase --keep-base --onto master...
> +'
> +
> +test_expect_success 'rebase --keep-base --root incompatible' '
> +	test_must_fail git rebase --keep-base --root
> +'
> +
> +test_expect_success 'rebase --keep-base master from topic' '
> +	git reset --hard &&
> +	git checkout topic &&
> +	git reset --hard G &&
> +
> +	git rebase --keep-base master &&
> +	git rev-parse C >base.expect &&
> +	git merge-base master HEAD >base.actual &&
> +	test_cmp base.expect base.actual &&
> +
> +	git rev-parse HEAD~2 >actual &&
> +	git rev-parse C^0 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase --keep-base master from side' '
> +	git reset --hard &&
> +	git checkout side &&
> +	git reset --hard K &&
> +
> +	test_must_fail git rebase --keep-base master
> +'
> +
> +test_expect_success 'rebase -i --keep-base master from topic' '
> +	git reset --hard &&
> +	git checkout topic &&
> +	git reset --hard G &&
> +
> +	set_fake_editor &&
> +	EXPECT_COUNT=3D2 git rebase -i --keep-base master &&
> +	git rev-parse C >base.expect &&
> +	git merge-base master HEAD >base.actual &&
> +	test_cmp base.expect base.actual &&
> +
> +	git rev-parse HEAD~2 >actual &&
> +	git rev-parse C^0 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'rebase -i --keep-base master from side' '
> +	git reset --hard &&
> +	git checkout side &&
> +	git reset --hard K &&
> +
> +	set_fake_editor &&
> +	test_must_fail git rebase -i --keep-base master
> +'
> +
>  test_done
