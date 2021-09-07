Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24691C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057B960F92
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbhIGMkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:40:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:41169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344244AbhIGMka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631018358;
        bh=nvS7pUIkHYcON8SPJaw2Ww9kf8guYjLPRh791jhgl6Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LUwKEfXJiLdT1mH1Zs0GO7ovpwQdDu2MBUTWFjzEhwTvivbSrt0pSi6sk56AU4Ll7
         oCpwZG/my5N8Qqv9C/igV+zodzaU4rmZmPPsk7fRouoGBP12ogqCyFSCUIyEFdm4G4
         wvAuVgUuJH07e+EB8xfdIvHDsMgDK/HlGstXyESs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1muhCw1SoK-00g3pN; Tue, 07
 Sep 2021 14:39:18 +0200
Date:   Tue, 7 Sep 2021 14:39:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 7/7] rebase: drop the internal `rebase--interactive`
 command
In-Reply-To: <cf76b707-bd59-26f8-f257-02d773294495@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109071438580.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <4492cca369cdc0c8cd39b3dafab86d798cfbaa8f.1630497435.git.gitgitgadget@gmail.com> <cf76b707-bd59-26f8-f257-02d773294495@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zrl3Ni2YjZpKfSOqnCgOsggOlurH7sJbSJPF3ffOx0As7mkin2m
 97GMD00DqF7GNnFNp/VbjTlxswNoZ4XCd/4jrmrfQyahVUm1lbVYPHX5MhN/Y8HHz8unjN0
 wv0eYGAriME5GE/J1dbMbdtyEZzQF7OB7IQG+RhcICwV5Fk2tgPSE1cb+uGQtUmg6wwHJ2d
 kqoC14b1PqghP91NlQbuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Y5AjKRWghY=:Tmqz/rff92pwkwu9V1OLkY
 ywXd7SgSi18uR7pXw5EWw2f2BK09xM6f/kYr79ThrS3PmRofmctkxDf5aE3bJKrC6wj0UuRSD
 2cUE7t8Sy99nnYLCq8RyhxIiJ+1khB+fN2fZ0plXhttk31Z2KI2AueOrJ+D4DtETg7jMoipm9
 0rPdJaRmA+1kozLL+w2htkEPTTNZeg/IJyre+LAACu4So54KtWWt1yHMY5XMnYtlnDXzyntRL
 GrBa6oeEP/aDFYV99q6tHUeuO8cdEJWkBimw9bFI+62Tg9UH3Sa3LV1zg91PRYGLjqVtrggl9
 I98V6NqhuO/FE3nS92NrFquCNdoKsqikwo/xidpgYFpP2Ju3FR0q3Uttvp6g4+/J/TrkRPwVO
 xLPa4XYNsayeiOQHMuCyApQWEQ+ZKmzm05RDUMoOvPM9xVPXYtH2dt61BKLAROYXnx7GX8gGC
 Uf+82OVlGDKA90pYLKVQX/Lr3AGPAekziPcNKWkKqZ0laBifFSCddKprItNI5A75WWLYNu91K
 N/KzD8kTssAwM8uJk1n3SY8BnJFsVVsijB3gGLl0Iw/7bOa7mNGjhIHBozxlOqmc8W/HN81K8
 ZZR3IlsO/0f1SOWcu4Mh0kY6Q7gtYJ/slBAlcxEj5U5kGx7ZT1jMBHE/S0016R7/TZkNLp0/h
 ksSDLjG0cCvLza+3RYNjW1nLI9v2FbhdYtrIIfwS/QslfszkKxEDzYbw6in0V2HJE8LmzaBb7
 VVVVH3HrWPVh0wl9TjNNyu8i1EOgmEDA0YhcbmMDoUit/IXv3JuG/952FPAHRzHYKFiaDWjFM
 t0B2Qaqh789ZJkEnGJeYkHZ1MeSmh1xsNlRBRt0jDV0EKEfdV48VSb+rmhyKMw9Q0HXGjM1A1
 UGcb2r9aI+RvEXi7W1zNwoYjSiZYz3hvJF95k0X7IAlFiNi9EhallwzW8oSpPJamsHri83UEW
 bIlw9DOLXpUk2g5NmkvuFVrRQKzRWwPK/DXx72WOzTcps0ym3ZItTQczSUOFQe0YGydme3jm5
 6tG2KczcyBHzc0MBmUr6PxLkKDOfRrx+DIvfJ2yhg0wru2V3jAuaiboeuB0XvbNJQH4k4VaJP
 27/SurT1z6tco3cue3axLD+akRCWU+kUCgH6UszLLdMFctX3qSI1Jt0LA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Sep 2021, Phillip Wood wrote:

> Hi dscho
>
> Thanks for working on this, it opens up the possibility of future cleanu=
ps now
> we're not constrained by supporting cmd_rebase__interactive()

Yes!!!

> On 01/09/2021 12:57, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > [...]
> > @@ -437,24 +362,6 @@ static int run_sequencer_rebase(struct rebase_opt=
ions
> > *opts,
> >
> >     break;
> > }
> > -	case ACTION_SHORTEN_OIDS:
> > -	case ACTION_EXPAND_OIDS:
> > -		ret =3D transform_todo_file(flags);
> > -		break;
> > -	case ACTION_CHECK_TODO_LIST:
> > -		ret =3D check_todo_list_from_file(the_repository);
> > -		break;
> > -	case ACTION_REARRANGE_SQUASH:
> > -		ret =3D rearrange_squash_in_todo_file();
> > -		break;
> > -	case ACTION_ADD_EXEC: {
> > -		struct string_list commands =3D STRING_LIST_INIT_DUP;
> > -
> > -		split_exec_commands(opts->cmd, &commands);
> > -		ret =3D add_exec_commands(&commands);
> > -		string_list_clear(&commands, 0);
> > -		break;
> > -	}
>
> As Alban mentioned, I think it would be worth removing the enum members =
as
> well as the case clauses here.

Makes sense.

Thank you for your review,
Dscho

>
> Best Wishes
>
> Phillip
>
> >    default:
> >     BUG("invalid command '%d'", command);
> > }
> > @@ -476,98 +383,6 @@ static int parse_opt_keep_empty(const struct opti=
on
> > *opt, const char *arg,
> >    return 0;
> > }
> >   -static const char * const builtin_rebase_interactive_usage[] =3D {
> > -	N_("git rebase--interactive [<options>]"),
> > -	NULL
> > -};
> > -
> > -int cmd_rebase__interactive(int argc, const char **argv, const char
> > *prefix)
> > -{
> > -	struct rebase_options opts =3D REBASE_OPTIONS_INIT;
> > -	struct object_id squash_onto =3D *null_oid();
> > -	enum action command =3D ACTION_NONE;
> > -	struct option options[] =3D {
> > -		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
> > -			   REBASE_FORCE),
> > -		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
> > -			N_("keep commits which start empty"),
> > -			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
> > -			parse_opt_keep_empty),
> > -		OPT_BOOL_F(0, "allow-empty-message",
> > &opts.allow_empty_message,
> > -			   N_("allow commits with empty messages"),
> > -			   PARSE_OPT_HIDDEN),
> > -		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase
> > merge commits")),
> > -		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
> > -			 N_("keep original branch points of cousins")),
> > -		OPT_BOOL(0, "autosquash", &opts.autosquash,
> > -			 N_("move commits that begin with squash!/fixup!")),
> > -		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
> > -		OPT_BIT('v', "verbose", &opts.flags,
> > -			N_("display a diffstat of what changed upstream"),
> > -			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
> > -		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
> > -			    ACTION_CONTINUE),
> > -		OPT_CMDMODE(0, "skip", &command, N_("skip commit"),
> > ACTION_SKIP),
> > -		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo
> > list"),
> > -			    ACTION_EDIT_TODO),
> > -		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the
> > current patch"),
> > -			    ACTION_SHOW_CURRENT_PATCH),
> > -		OPT_CMDMODE(0, "shorten-ids", &command,
> > -			N_("shorten commit ids in the todo list"),
> > ACTION_SHORTEN_OIDS),
> > -		OPT_CMDMODE(0, "expand-ids", &command,
> > -			N_("expand commit ids in the todo list"),
> > ACTION_EXPAND_OIDS),
> > -		OPT_CMDMODE(0, "check-todo-list", &command,
> > -			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
> > -		OPT_CMDMODE(0, "rearrange-squash", &command,
> > -			N_("rearrange fixup/squash lines"),
> > ACTION_REARRANGE_SQUASH),
> > -		OPT_CMDMODE(0, "add-exec-commands", &command,
> > -			N_("insert exec commands in todo list"),
> > ACTION_ADD_EXEC),
> > -		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"),
> > N_("onto"),
> > -		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
> > -		{ OPTION_CALLBACK, 0, "restrict-revision",
> > &opts.restrict_revision,
> > -		  N_("restrict-revision"), N_("restrict revision"),
> > -		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
> > -		{ OPTION_CALLBACK, 0, "squash-onto", &squash_onto,
> > N_("squash-onto"),
> > -		  N_("squash onto"), PARSE_OPT_NONEG, parse_opt_object_id, 0
> > },
> > -		{ OPTION_CALLBACK, 0, "upstream", &opts.upstream,
> > N_("upstream"),
> > -		  N_("the upstream commit"), PARSE_OPT_NONEG,
> > parse_opt_commit,
> > -		  0 },
> > -		OPT_STRING(0, "head-name", &opts.head_name, N_("head-name"),
> > N_("head name")),
> > -		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt,
> > N_("key-id"),
> > -			N_("GPG-sign commits"),
> > -			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > -		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
> > -			   N_("rebase strategy")),
> > -		OPT_STRING(0, "strategy-opts", &opts.strategy_opts,
> > N_("strategy-opts"),
> > -			   N_("strategy options")),
> > -		OPT_STRING(0, "switch-to", &opts.switch_to, N_("switch-to"),
> > -			   N_("the branch or commit to checkout")),
> > -		OPT_STRING(0, "onto-name", &opts.onto_name, N_("onto-name"),
> > N_("onto name")),
> > -		OPT_STRING(0, "cmd", &opts.cmd, N_("cmd"), N_("the command to
> > run")),
> > -		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_autoupdate),
> > -		OPT_BOOL(0, "reschedule-failed-exec",
> > &opts.reschedule_failed_exec,
> > -			 N_("automatically re-schedule any `exec` that
> > fails")),
> > -		OPT_END()
> > -	};
> > -
> > -	opts.rebase_cousins =3D -1;
> > -
> > -	if (argc =3D=3D 1)
> > -		usage_with_options(builtin_rebase_interactive_usage, options);
> > -
> > -	argc =3D parse_options(argc, argv, prefix, options,
> > -			builtin_rebase_interactive_usage,
> > PARSE_OPT_KEEP_ARGV0);
> > -
> > -	if (!is_null_oid(&squash_onto))
> > -		opts.squash_onto =3D &squash_onto;
> > -
> > -	if (opts.rebase_cousins >=3D 0 && !opts.rebase_merges)
> > -		warning(_("--[no-]rebase-cousins has no effect without "
> > -			  "--rebase-merges"));
> > -
> > -	return !!run_sequencer_rebase(&opts, command);
> > -}
> > -
> >   static int is_merge(struct rebase_options *opts)
> >   {
> >   	return opts->type =3D=3D REBASE_MERGE;
> > diff --git a/git.c b/git.c
> > index 18bed9a9964..268cdd82cfc 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -577,7 +577,6 @@ static struct cmd_struct commands[] =3D {
> >    { "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
> >    { "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
> >    { "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
> > -	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP |
> > NEED_WORK_TREE },
> >    { "receive-pack", cmd_receive_pack },
> >    { "reflog", cmd_reflog, RUN_SETUP },
> >    { "remote", cmd_remote, RUN_SETUP },
> >
>
>
>
