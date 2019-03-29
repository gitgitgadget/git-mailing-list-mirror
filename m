Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90701202BB
	for <e@80x24.org>; Fri, 29 Mar 2019 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfC2Rwz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:52:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40304 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2Rwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:52:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so1554492pgo.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tNAgGkdGUcAin8Q3RnlfQ5nLDmRA6zRfKfbbw68wEsc=;
        b=Mzvl4wB99PqxY6Ylvf2lg8XiY1eMre4dfkIQ7IwHfTxbkH1JugdCKSjjRAm52MCrtP
         qYWv3tPBAUJJZX4O3h1Lh3ix5V/u9NorpKwbjP85myjf6kMzsuaawIGrFAnK/xZ+wLyZ
         D4vvXDu9Q/laWesn0CC0TRjdWpruLIkdfeHd3FUvWK+6mUHgIwO882cLxwcLkFtd3VjR
         5jZ8ghaTW3T1kSM4imSUhBwfdR4GpAflypy4tWbHYGRtPSnpHDUpBKY1eY3B1KHTQ/+8
         W6Z5Xb4+blyoXJIJ3ur6SsvmlADEMUwYvAbf8UEXojlwg9Hwn0oqt84HQYhr3k0gVPry
         /J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tNAgGkdGUcAin8Q3RnlfQ5nLDmRA6zRfKfbbw68wEsc=;
        b=dzyiWwQBOhpBy5JNCNI27KyEPWH2YFNdFGMmjkUDoxRw8sDo3BP8f5BS1u9/Efgnrv
         MG6vf3wMvYawO5Qwo+KKVO/f1HE5/L3aPm/Ic+GtTXBuNe4AdwB8RNvCklBEJ6whcr+c
         mazaXbN1NBBDouNuALKNOM+ZK/pzwkZeHuHpn6XTLVwOpElPxdR47i4JqrqppkCLJVmB
         KLjGmeT9BHL2LmCwmYTEaB0mDprE3Z7AkKnuIY/ZOedL8slNQypQd2wTx2h//UrpBhg+
         crS/W+I440++EyTJY3p4dsPoDIv+xIIfo+bzIFKIEZWj7k6yw4TbBdM11HuUdcPzqTDl
         ioXQ==
X-Gm-Message-State: APjAAAV26EViOdjktbTN0DfBxv1d1JPEfeGMZnlqv6ovjecOPJhA3vAO
        +gWrSl+drrffSV7bbb3pq50=
X-Google-Smtp-Source: APXvYqzz0JyifmF8XzwG3BEFcLSWisfJCzKNyqawGRKffCZ3f2q9lnUi+/3LeV9YdaJSETRFNgs2XA==
X-Received: by 2002:a63:6a42:: with SMTP id f63mr20602820pgc.207.1553881973858;
        Fri, 29 Mar 2019 10:52:53 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id j20sm3361790pff.22.2019.03.29.10.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:52:52 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:52:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] rebase: teach rebase --keep-base
Message-ID: <20190329175250.GA18702@dev-l>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <20190328221745.GA3941@dev-l>
 <nycvar.QRO.7.76.6.1903291643060.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1903291643060.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Mar 29, 2019 at 04:47:42PM +0100, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Thu, 28 Mar 2019, Denton Liu wrote:
> 
> > A common scenario is if a user is working on a topic branch and they
> > wish to make some changes to intermediate commits or autosquash, they
> > would run something such as
> >
> > 	git rebase -i --onto master... master
> >
> > in order to preserve the merge base. This prevents unnecessary commit
> > churning.
> 
> Maybe an example would clarify what you try to do here? Something like:
> 
> 	Example: When contributing a patch series to the Git mailing list,
> 	one often starts on top of the current `master`. However, while
> 	developing the patch series, `master` is also developed further,
> 	and it is sometimes not the best idea to keep rebasing on top
> 	of `master`, but to keep the base commit as-is. In such a case,
> 	the user can call
> 
> 		git rebase -i --onto master... master
> 
> 	as a shortcut to using the merge base between `master` and the
> 	current branch as base commit.

Will do, I'll include an example in the next reroll (probably in the
docs too).

> 
> I wonder, however, whether it makes sense to introduce a shorter, sweeter
> way to do this:
> 
> 		git rebase -i master...
> 
> I.e. if we detect that the `<upstream>` argument is not a valid ref, that
> it ends with three dots, and that stripping those dots off makes it a
> valid ref, then we internally convert that to the same as `--onto
> master... master`.

There's one use-case that this syntax wouldn't cover. Currently, if
<upstream> isn't specified, rebase automatically uses 
'git merge-base --fork-point @{u} HEAD' as <upstream>. This is
even true for an invocation of 'git rebase --keep-base'.

As a result, suppose we have the following graph

	o - f - o - U' origin/master
	    \
	     U - A master

where U used to be in origin/master (when we forked off) but upstream
was rewound to drop it. If we run 'git rebase --keep-base', we'll get
the following graph:

	o - f - o - U' origin/master
	    \
	     A master

i.e. we'll drop the commit dropped by upstream.

I'm not entirely sure how useful this is, though, so if we decide to
drop support for this use-case, then your proposed syntax will be fine.

Thanks,

Denton

> 
> What do you think?
> 
> Ciao,
> Dscho
> 
> > Alternatively, a user wishing to test individual commits in a topic
> > branch without changing anything may run
> >
> > 	git rebase -x ./test.sh master... master
> >
> > Since rebasing onto the merge base of the branch and the upstream is
> > such a common case, introduce the --keep-base option as a shortcut.
> >
> > This allows us to rewrite the above as
> >
> > 	git rebase -i --keep-base master
> >
> > and
> >
> > 	git rebase -x ./test.sh --keep-base master
> >
> > respectively.
> >
> > Add tests to ensure --keep-base works correctly in the normal case and
> > fails when there are multiple merge bases, both in regular and
> > interactive mode. Also, test to make sure conflicting options cause
> > rebase to fail. While we're adding test cases, add a missing
> > set_fake_editor call to 'rebase -i --onto master...side'.
> >
> > While we're documenting the --keep-base option, change an instance of
> > "merge-base" to "merge base", which is the consistent spelling.
> >
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >
> > Ævar, I have a feeling that we're still miscommunicating and we don't
> > fully understand each other. I'm putting up v2 to hopefully clear things
> > up a little but I welcome more feedback.
> >
> > This patch now depends "[PATCH 1/8] tests (rebase): spell out the
> > `--keep-empty` option" which is the first patch of Johannes's "Do not
> > use abbreviated options in tests" patchset[1]. (Thanks for catching
> > that, Johannes!)
> >
> > Changes since v1:
> >
> > * Squashed old set into one patch
> > * Fixed indentation style and dangling else
> > * Added more documentation after discussion with Ævar
> >
> > [1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/
> >
> >  Documentation/git-rebase.txt     | 25 ++++++++++++--
> >  builtin/rebase.c                 | 32 ++++++++++++++----
> >  t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
> >  3 files changed, 105 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 6363d674b7..27be1f48ff 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
> > -	[<upstream> [<branch>]]
> > +'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
> > +	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
> >  'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
> >  	--root [<branch>]
> >  'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
> > @@ -217,6 +217,19 @@ As a special case, you may use "A\...B" as a shortcut for the
> >  merge base of A and B if there is exactly one merge base. You can
> >  leave out at most one of A and B, in which case it defaults to HEAD.
> >
> > +--keep-base::
> > +	Set the starting point at which to create the new commits to the
> > +	merge base of <upstream> <branch>. Running
> > +	'git rebase --keep-base <upstream> <branch>' is equivalent to
> > +	running 'git rebase --onto <upstream>... <upstream>'.
> > ++
> > +Although both this option and --fork-point find the merge base between
> > +<upstream> and <branch>, this option uses the merge base as the _starting
> > +point_ on which new commits will be created, whereas --fork-point uses
> > +the merge base to determine the _set of commits_ which will be rebased.
> > ++
> > +See also INCOMPATIBLE OPTIONS below.
> > +
> >  <upstream>::
> >  	Upstream branch to compare against.  May be any valid commit,
> >  	not just an existing branch name. Defaults to the configured
> > @@ -364,6 +377,10 @@ ends up being empty, the <upstream> will be used as a fallback.
> >  +
> >  If either <upstream> or --root is given on the command line, then the
> >  default is `--no-fork-point`, otherwise the default is `--fork-point`.
> > ++
> > +If your branch was based on <upstream> but <upstream> was rewound and
> > +your branch contains commits which were dropped, this option can be used
> > +with `--keep-base` in order to drop those commits from your branch.
> >
> >  --ignore-whitespace::
> >  --whitespace=<option>::
> > @@ -539,6 +556,8 @@ In addition, the following pairs of options are incompatible:
> >   * --preserve-merges and --rebase-merges
> >   * --rebase-merges and --strategy
> >   * --rebase-merges and --strategy-option
> > + * --keep-base and --onto
> > + * --keep-base and --root
> >
> >  BEHAVIORAL DIFFERENCES
> >  -----------------------
> > @@ -863,7 +882,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
> >        --interactive` will be **resurrected**!
> >
> >  The idea is to manually tell 'git rebase' "where the old 'subsystem'
> > -ended and your 'topic' began", that is, what the old merge-base
> > +ended and your 'topic' began", that is, what the old merge base
> >  between them was.  You will have to find a way to name the last commit
> >  of the old 'subsystem', for example:
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 77deebc65c..7c14a00460 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -27,8 +27,8 @@
> >  #include "branch.h"
> >
> >  static char const * const builtin_rebase_usage[] = {
> > -	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> > -		"[<upstream>] [<branch>]"),
> > +	N_("git rebase [-i] [options] [--exec <cmd>] "
> > +		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
> >  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> >  		"--root [<branch>]"),
> >  	N_("git rebase --continue | --abort | --skip | --edit-todo"),
> > @@ -1018,6 +1018,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	};
> >  	const char *branch_name;
> >  	int ret, flags, total_argc, in_progress = 0;
> > +	int keep_base = 0;
> >  	int ok_to_skip_pre_rebase = 0;
> >  	struct strbuf msg = STRBUF_INIT;
> >  	struct strbuf revisions = STRBUF_INIT;
> > @@ -1051,6 +1052,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  		OPT_STRING(0, "onto", &options.onto_name,
> >  			   N_("revision"),
> >  			   N_("rebase onto given branch instead of upstream")),
> > +		OPT_BOOL(0, "keep-base", &keep_base,
> > +			 N_("use the merge-base of upstream and branch as the current base")),
> >  		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
> >  			 N_("allow pre-rebase hook to run")),
> >  		OPT_NEGBIT('q', "quiet", &options.flags,
> > @@ -1217,6 +1220,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  		usage_with_options(builtin_rebase_usage,
> >  				   builtin_rebase_options);
> >
> > +	if (keep_base) {
> > +		if (options.onto_name)
> > +			die(_("cannot combine '--keep-base' with '--onto'"));
> > +		if (options.root)
> > +			die(_("cannot combine '--keep-base' with '--root'"));
> > +	}
> > +
> >  	if (action != NO_ACTION && !in_progress)
> >  		die(_("No rebase in progress?"));
> >  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> > @@ -1541,12 +1551,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	}
> >
> >  	/* Make sure the branch to rebase onto is valid. */
> > -	if (!options.onto_name)
> > +	if (keep_base) {
> > +		strbuf_reset(&buf);
> > +		strbuf_addstr(&buf, options.upstream_name);
> > +		strbuf_addstr(&buf, "...");
> > +		options.onto_name = xstrdup(buf.buf);
> > +	} else if (!options.onto_name)
> >  		options.onto_name = options.upstream_name;
> >  	if (strstr(options.onto_name, "...")) {
> > -		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> > -			die(_("'%s': need exactly one merge base"),
> > -			    options.onto_name);
> > +		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
> > +			if (keep_base)
> > +				die(_("'%s': need exactly one merge base with branch"),
> > +				    options.upstream_name);
> > +			else
> > +				die(_("'%s': need exactly one merge base"),
> > +				    options.onto_name);
> > +		}
> >  		options.onto = lookup_commit_or_die(&merge_base,
> >  						    options.onto_name);
> >  	} else {
> > diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> > index ddf2f64853..9c2548423b 100755
> > --- a/t/t3416-rebase-onto-threedots.sh
> > +++ b/t/t3416-rebase-onto-threedots.sh
> > @@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' '
> >  	git checkout side &&
> >  	git reset --hard K &&
> >
> > +	set_fake_editor &&
> >  	test_must_fail git rebase -i --onto master...side J
> >  '
> >
> > +test_expect_success 'rebase --keep-base --onto incompatible' '
> > +	test_must_fail git rebase --keep-base --onto master...
> > +'
> > +
> > +test_expect_success 'rebase --keep-base --root incompatible' '
> > +	test_must_fail git rebase --keep-base --root
> > +'
> > +
> > +test_expect_success 'rebase --keep-base master from topic' '
> > +	git reset --hard &&
> > +	git checkout topic &&
> > +	git reset --hard G &&
> > +
> > +	git rebase --keep-base master &&
> > +	git rev-parse C >base.expect &&
> > +	git merge-base master HEAD >base.actual &&
> > +	test_cmp base.expect base.actual &&
> > +
> > +	git rev-parse HEAD~2 >actual &&
> > +	git rev-parse C^0 >expect &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase --keep-base master from side' '
> > +	git reset --hard &&
> > +	git checkout side &&
> > +	git reset --hard K &&
> > +
> > +	test_must_fail git rebase --keep-base master
> > +'
> > +
> > +test_expect_success 'rebase -i --keep-base master from topic' '
> > +	git reset --hard &&
> > +	git checkout topic &&
> > +	git reset --hard G &&
> > +
> > +	set_fake_editor &&
> > +	EXPECT_COUNT=2 git rebase -i --keep-base master &&
> > +	git rev-parse C >base.expect &&
> > +	git merge-base master HEAD >base.actual &&
> > +	test_cmp base.expect base.actual &&
> > +
> > +	git rev-parse HEAD~2 >actual &&
> > +	git rev-parse C^0 >expect &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'rebase -i --keep-base master from side' '
> > +	git reset --hard &&
> > +	git checkout side &&
> > +	git reset --hard K &&
> > +
> > +	set_fake_editor &&
> > +	test_must_fail git rebase -i --keep-base master
> > +'
> > +
> >  test_done
> > --
> > 2.21.0.695.gaf8658f249
> >
> >

