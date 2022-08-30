Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E278ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiH3PnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3PnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:43:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BBA5996
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661874172;
        bh=X4DXt5Yd+rEybEL2J6G5qos5WRARhbx4o+b0V4Z/uYw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P2VhnGXvarWty/aEyqSEgD1COlB8JAOSWm8FwoUg0Lp1y74HFvxgZ/3kY4Lm3q1gi
         LHrTvqBtHF53yAWNMr27g2TxnqeE/4xNQiWbVUJBT1PkPxTv1u+cq4xlJrUUmQcTpK
         TRSzli4ZuuRe+8KksFl7e/XDENbBAPwCyHiic7jc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1oT3O82usS-0005oe; Tue, 30
 Aug 2022 17:42:52 +0200
Date:   Tue, 30 Aug 2022 17:42:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 07/16] bisect--helper: migrate to OPT_SUBCOMMAND()
In-Reply-To: <220829.86wnar2wus.gmgdl@evledraar.gmail.com>
Message-ID: <61rq5601-o016-3006-3p67-o56307109qq5@tzk.qr>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com> <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com> <5b7a3d58b4f84f72e1ae2196fa67c76b0a6302ad.1661604264.git.gitgitgadget@gmail.com> <220829.86wnar2wus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1441139616-1661874174=:189"
X-Provags-ID: V03:K1:90FM7N6yU0t3uDMkkk3+usZe/F7ytRbHy+WYIr6ZxvvALpQUrOY
 u5szxpvuHW1PQNc6iizw/stsN1cS7gPsd5BSvhpbzJhqyAapxrtN9QWFyAVyo73kBqIkvJU
 8X7VWlmhLDlDqf1h2asRNzhduPD6CkOZcTeoQ6QGIJDVpHAmK3z4Fc0VBGqFVbAVG8ydcj/
 ptl6Clk9D6ofYEN8Z5MDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eKUI/zrcgB8=:IeqzFkLJh9gw6wILeQU+w0
 t2zLLR763xLziF7FZ9ekurCnf0ld/gWMllhhmC6/8J3PE6eJ/hb9iGe2H3mfFQOoNJgsrJ6PB
 W+aaUjqQJ+zwMUqTwP1cGC4nqInxF68Pc0nxkVfIoTK53rNxFHZfptAmTRwhS/vKCRcNsBqMU
 YFcO3LTNnkjuV14h4Coz8kPvZU7stMmBMzXAI7mB5+vqdtFCEJF81Ob2Wh+VVOPD+2d0qM9SP
 G1KvzZjHmEDXMgR7Q8BVaeMyxeByrdc4lotvTGSXEAoBb6XE2wsMwwgwVo5oFxHG4cjWhhW6E
 LaFMN1wTDw38Zqc3VXN9/sCDxFEbqg7bFu+h8jjMAK1vbRpp0kM733MyMvpk7eiIKKvNObRq3
 UWK0yTeCl0wQLG2yxgQlaotYoyqMXOOldCsuxs2fyFTW7JX4s8wtcwpF3naxZdfEIjMuwVwXj
 XkghjZFxcB2aIRrvSOznrUn3T9V1cIRGOU2k+6LttgzZiYcfWo/GlIzCJYDuuGt8AoJmirkvN
 5u9pif0uGn2QxTjWJklJVE/pKbcGYPp54qp1j3IFk/aD8gZN6ykD0WfLYb5+dsxJMV+CzgmuK
 N/2VcmT1Dnux4ZiB25CyGsygrJRN4CklIbPiaZBo6Vu39luslLjFVD2vWQuievwOrfjYb2z0x
 b7+AWxff7MRa8Xw0Zq+BNyHd32mIvR004bySH0cfiFnea/PzhxsiB7HUDg1apWsPOvWlnyNTG
 HprGnLmVcDA3f1fTlB0xLHLk4y3wNU1QKzqAxjapEKuAnpu7EZG47cqTQGP8RGPMuEtCQi1Jb
 BLO+cIYatsFY/hsOTwQ+lj7Pgfey8SqwZ6ZCEdTY4DsOrQO9A85oX8NmEOGvND+ttjpw9431w
 0fzK4pXeXNxG/+2CbGWmuV3T7lzTDCixrBkxI8LPQrjkF9gIVxstLF4U8Pwv7ECpis3XAWok6
 CftXWGihHt9tCNzTqO/segVxgIX6cG9nCdlgSppCMLg2Bcc++zUozc3PLtxXWbOLP6VYVmp3N
 q86EMVg3sKELrd56BwCpdCsY0EfjrIM00fZ2ofcJMY/6duPpEqtbl6tSQVABon0tW2c2KvrCJ
 XcDz0DFCbiluwy7IAM1fnzQbwUK0TsbpGvioceIJGVIp+iXyhdeMssG8g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1441139616-1661874174=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 29 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> > -static const char * const git_bisect_helper_usage[] =3D {
> > -	N_("git bisect--helper --bisect-reset [<commit>]"),
> > -	"git bisect--helper --bisect-terms [--term-good | --term-old | --ter=
m-bad | --term-new]",
> > -	N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --t=
erm-{old,good}=3D<term>]"
> > -					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] =
[<paths>...]"),
> > -	"git bisect--helper --bisect-next",
> > -	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> > -	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> > -	N_("git bisect--helper --bisect-replay <filename>"),
> > -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> > -	"git bisect--helper --bisect-visualize",
> > -	N_("git bisect--helper --bisect-run <cmd>..."),
> > +static const char * const bisect_usage[] =3D {
> > +	N_("git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D=
<term>]"
> > +	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
> > +	   "    [<pathspec>...]"),
> > +	N_("git bisect (bad|new) [<rev>]"),
> > +	N_("git bisect (good|old) [<rev>...]"),
> > +	N_("git bisect terms [--term-good | --term-bad]"),
> > +	N_("git bisect skip [(<rev>|<range>)...]"),
> > +	N_("git bisect next"),
> > +	N_("git bisect reset [<commit>]"),
> > +	N_("git bisect (visualize|view)"),
> > +	N_("git bisect replay <logfile>"),
> > +	N_("git bisect log"),
> > +	N_("git bisect run <cmd>..."),
> > +	NULL
> > +};
>
> Parts of this are erroneously reverting bits of 959d670d1a4 (i18n:
> remove from i18n strings that do not hold translatable parts,
> 2022-01-31).

That is misreading what this patch does. I did not turn the pre-image into
the post-image.

As the commit message states, we now use the subcommand API with the
intention to replace the `git-bisect.sh` script altogether (that's written
in the first paragraph of the proposed commit message).

This means that the command modes are replaced by subcommands, and the
usage of the subcommands is copied from the script.

And that is the reason why you see a usage about `view` and `log`, as I
assume you noticed.

By the way, this here distraction makes a really fine case why it would
have been better to leave the migration to the subcommand API to a
follow-up patch series. You will recall that I favored that, and I would
have loved for you to agree.

Having said that, it is a good point that we do not want to reintroduce
the problem that was fixed by 959d670d1a4 (i18n: remove from i18n strings
that do not hold translatable parts, 2022-01-31).

> I.e. the N_() should not be there in cases like "git bisect next", only
> commands that have placeholders like "<rev>".
>
> > +static const char * const bisect_start_usage[] =3D {
> > +	N_("git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D=
<term>]"
> > +	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
> > +	   "    [<pathspec>...]"),
> > +	NULL
> > +};
>
> Rather than copy/pasting these we can define them once & re-use that
> definition with a macro. See builtin/commit-graph.c and 8757b35d443
> (commit-graph: define common usage with a macro, 2021-08-23).

I would do this if I found it elegant.

> (Ditto elided below)
>
> > +	argc =3D parse_options(argc, argv, prefix, options,
> > +			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
>
> Nit: Stray " " (double space) here in the argument list.

Good find! Will fix. And obviously not only the `reset` case.

>
> >  		printf(_("Your current terms are %s for the old state\n"
> >  			 "and %s for the new state.\n"),
> >  		       terms.term_good, terms.term_bad);
> >  		return 0;
>
> Using '%s'-quoting here for the interpolated terms would help
> translators & normalize this with other bessages. It was (partially)
> like this in the pre-image, but since we're changing the whole string
> anyway...

It is a bad practice to draw out code contributions by asking contributors
to add unrelated changes. This here mail thread presents a fine example
why. Let's avoid doing that from now on.

> > +	if (argc > 0)
> > +		usage_msg_opt(_("requires 0 argument"),
> > +			      bisect_next_usage, options);
>
> Earlier a message says "requires either no argument[...]", but here we
> say "requires 0 argument", which sounds like it expects a literal "0" in
> the argument list.

As you undoubtedly noticed, this message was moved from the
`cmd_bisect__helper()` function, with its `--bisect-next` part deleted
(because it is incorrect now that we no longer have command modes).

> But what we actually mean is "requires no arguments", let's change the
> string to that.

No, let's not. For the same reason as noted above.

> > -	}
> > +
>
> Here's a "whitespace change while at it..."...

This removes a curly bracket and adds an empty line. You are referring to
the empty line?

It is a bit hard to understand what you mean, not only because of the lack
of clarity but also because too much context was clipped to easily find
the part of the patch that you were referring to. Please be more
considerate in the future.

I have to assume that you are referring to a tiny part of one hunk that
describes how `bisect_start()` became `cmd_bisect_start()`. If that is
indeed what you were referring to, then you are talking about a hunk that
seemingly replaces a `for (i =3D 0; i < argc; i++)` loop that parses the
command-line with a loop that validates that only revision parameters are
specified before the double dash, if any. In other words, the "introduced"
white-space is part of a completely new loop.

>
> >  finish:
> > +	strvec_clear(&orig_argv);
> > +
>
> Ditto here, why make this clear/release visually separate from the
> cleanup below?:
>
> >  	string_list_clear(&revs, 0);
> >  	string_list_clear(&states, 0);
> >  	strbuf_release(&start_head);
>
> ^^^ i.e. this.

Because the latter statements clean up data structures that were used for
the core functionality of `bisect start`, while the `orig_argv` purely
were a copy for the sake of the bisect log. Therefore, they are logically
separate, and the empty line helps readers such as myself.

>
> > @@ -1004,8 +1135,10 @@ static int process_replay_line(struct strbuf *l=
ine)
> >  	if (!strcmp(p, "start")) {
> >  		struct strvec argv =3D STRVEC_INIT;
> >  		int res;
> > +
>
> Ditto whitespace change here...
>
> > +		strvec_push(&argv, p);
> >  		sq_dequote_to_strvec(rev, &argv);
> > [...]
> >  		struct strvec argv =3D STRVEC_INIT;
> >  		int res;
> > +
>
> ...and here.., I think these are good, but they add up, perhaps worth
> splitting up various whitespace-prettification in this series for
> readability into its own commit.
>
> > [...]
> > @@ -1272,105 +1445,26 @@ static int bisect_run(int argc, const char **=
argv)
> >
> >  int cmd_bisect__helper(int argc, const char **argv, const char *prefi=
x)
> >  {
> > -	enum {
> > -		BISECT_RESET =3D 1,
> > -		BISECT_TERMS,
> > -		BISECT_START,
> > -		BISECT_NEXT,
> > -		BISECT_STATE,
> > -		BISECT_LOG,
> > -		BISECT_REPLAY,
> > -		BISECT_SKIP,
> > -		BISECT_VISUALIZE,
> > -		BISECT_RUN,
> > -	} cmdmode =3D 0;
> > +	parse_opt_subcommand_fn *fn =3D NULL;
> >  	int res =3D 0;
> >  	struct option options[] =3D {
> > -		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
> > -			 N_("reset the bisection state"), BISECT_RESET),
> > -		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
> > -			 N_("print out the bisect terms"), BISECT_TERMS),
> > -		OPT_CMDMODE(0, "bisect-start", &cmdmode,
> > -			 N_("start the bisect session"), BISECT_START),
> > -		OPT_CMDMODE(0, "bisect-next", &cmdmode,
> > -			 N_("find the next bisection commit"), BISECT_NEXT),
> > -		OPT_CMDMODE(0, "bisect-state", &cmdmode,
> > -			 N_("mark the state of ref (or refs)"), BISECT_STATE),
> > -		OPT_CMDMODE(0, "bisect-log", &cmdmode,
> > -			 N_("list the bisection steps so far"), BISECT_LOG),
> > -		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
> > -			 N_("replay the bisection process from the given file"), BISECT_RE=
PLAY),
> > -		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
> > -			 N_("skip some commits for checkout"), BISECT_SKIP),
> > -		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> > -			 N_("visualize the bisection"), BISECT_VISUALIZE),
> > -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
> > -			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
> > +		OPT_SUBCOMMAND("reset", &fn, cmd_bisect_reset),
> > +		OPT_SUBCOMMAND("terms", &fn, cmd_bisect_terms),
> > +		OPT_SUBCOMMAND("start", &fn, cmd_bisect_start),
> > +		OPT_SUBCOMMAND("next", &fn, cmd_bisect_next),
> > +		OPT_SUBCOMMAND("state", &fn, cmd_bisect_state),
> > +		OPT_SUBCOMMAND("log", &fn, cmd_bisect_log),
> > +		OPT_SUBCOMMAND("replay", &fn, cmd_bisect_replay),
> > +		OPT_SUBCOMMAND("skip", &fn, cmd_bisect_skip),
> > +		OPT_SUBCOMMAND("visualize", &fn, cmd_bisect_visualize),
> > +		OPT_SUBCOMMAND("run", &fn, cmd_bisect_run),
> >  		OPT_END()
> >  	};
> >
> >  	argc =3D parse_options(argc, argv, prefix, options,
> > -			     git_bisect_helper_usage,
> > -			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
> > -
> > -	if (!cmdmode)
> > -		usage_with_options(git_bisect_helper_usage, options);
> > +			     bisect_usage, 0);
> >
> > -	switch (cmdmode) {
> > -	case BISECT_RESET:
> > -		if (argc > 1)
> > -			return error(_("--bisect-reset requires either no argument or a co=
mmit"));
> > -		res =3D bisect_reset(argc ? argv[0] : NULL);
> > -		break;
> > -	case BISECT_TERMS:
> > -		if (argc > 1)
> > -			return error(_("--bisect-terms requires 0 or 1 argument"));
> > -		res =3D bisect_terms(argc =3D=3D 1 ? argv[0] : NULL);
> > -		break;
> > -	case BISECT_START:
> > -		set_terms("bad", "good");
> > -		res =3D bisect_start(argc, argv);
> > -		break;
> > -	case BISECT_NEXT:
> > -		if (argc)
> > -			return error(_("--bisect-next requires 0 arguments"));
> > -		get_terms();
> > -		res =3D bisect_next(prefix);
> > -		break;
> > -	case BISECT_STATE:
> > -		set_terms("bad", "good");
> > -		get_terms();
> > -		res =3D bisect_state(argc, argv);
> > -		break;
> > -	case BISECT_LOG:
> > -		if (argc)
> > -			return error(_("--bisect-log requires 0 arguments"));
> > -		res =3D bisect_log();
> > -		break;
> > -	case BISECT_REPLAY:
> > -		if (argc !=3D 1)
> > -			return error(_("no logfile given"));
> > -		set_terms("bad", "good");
> > -		res =3D bisect_replay(argv[0]);
> > -		break;
> > -	case BISECT_SKIP:
> > -		set_terms("bad", "good");
> > -		get_terms();
> > -		res =3D bisect_skip(argc, argv);
> > -		break;
> > -	case BISECT_VISUALIZE:
> > -		get_terms();
> > -		res =3D bisect_visualize(argc, argv);
> > -		break;
> > -	case BISECT_RUN:
> > -		if (!argc)
> > -			return error(_("bisect run failed: no command provided."));
> > -		get_terms();
> > -		res =3D bisect_run(argc, argv);
> > -		break;
> > -	default:
> > -		BUG("unknown subcommand %d", cmdmode);
> > -	}
> > +	res =3D fn(argc, argv, prefix);
> >  	free_terms();
>
> The real meat of this is here, and looks much better on top of SZEDER's
> series in "next" ...

Beauty is no quality in things themselves: It exists merely in the mind
which contemplates them; and each mind perceives a different beauty.

Plus, this hunk cannot be taken out of context: It requires all the
lengthy hunks that come before it, and that are relatively hard to parse
as you found out.

> >
> >  	return is_bisect_success(res) ? 0 : -res;
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 405cf76f2a3..e19847eba0d 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -58,26 +58,26 @@ case "$#" in
> >  	help)
> >  		git bisect -h ;;
> >  	start)
> > -		git bisect--helper --bisect-start "$@" ;;
> > +		git bisect--helper start "$@" ;;
> >  	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> > -		git bisect--helper --bisect-state "$cmd" "$@" ;;
> > +		git bisect--helper state "$cmd" "$@" ;;
> >  	skip)
> > -		git bisect--helper --bisect-skip "$@" || exit;;
> > +		git bisect--helper skip "$@" || exit;;
> >  	next)
> >  		# Not sure we want "next" at the UI level anymore.
> > -		git bisect--helper --bisect-next "$@" || exit ;;
> > +		git bisect--helper next "$@" || exit ;;
> >  	visualize|view)
> > -		git bisect--helper --bisect-visualize "$@" || exit;;
> > +		git bisect--helper visualize "$@" || exit;;
> >  	reset)
> > -		git bisect--helper --bisect-reset "$@" ;;
> > +		git bisect--helper reset "$@" ;;
> >  	replay)
> > -		git bisect--helper --bisect-replay "$@" || exit;;
> > +		git bisect--helper replay "$@" || exit;;
> >  	log)
> > -		git bisect--helper --bisect-log || exit ;;
> > +		git bisect--helper log || exit ;;
> >  	run)
> > -		git bisect--helper --bisect-run "$@" || exit;;
> > +		git bisect--helper run "$@" || exit;;
> >  	terms)
> > -		git bisect--helper --bisect-terms "$@" || exit;;
> > +		git bisect--helper terms "$@" || exit;;
> >  	*)
> >  		usage ;;
> >  	esac
>
> ...I did wonder if OPT_SUBCOMMAND() supported subcommands "--like-this"
> as opposed to "this", if so the renaming of all of these could be split
> up into its own change.
>
> Maybe not worth it, but it's a very large commit, which does at least:
>
>  * Migration to that new API
>  * Stray whitespace changes while at it
>  * Migrating the sub-command functions themselves to parse_options()
>    (good!), but not strictly required for OPT_SUBCOMMAND() (an
>    orthagonal change).
>  * Renaming the "verbs" for the internal helper from
>    e.g. "--bisect-skip" to "skip", which is what we want eventually, but
>    does inflate the almost 500-line change.

These suggestions could very easily be construed to be intentionally
drawing out a patch contribution that pretty much all other participants
in the mail thread have expressed a desire to be done with.

I do understand that you care a lot about these details and about
white-space and the parse_options API.

Please do understand that I care about the correctness of the code, and
wish I could see more suggestions between all those suggestions that would
be conducive to further that goal.

This is a complex patch, to be sure, and it is pretty much solely due to
having had to include the move from the command-mode paradigm to the
subcommand paradigm in the patch series, which I would very much have
preferred to do in a separate patch series.

Could that move have been done more incrementally? Maybe. I tried to split
it up as much as I could _without_ losing focus of the actual goal of this
patch series: the conversion from a script that implemented the `bisect`
operation to a pure built-in that is supposed to perform the same
operation without introducing regressions. If it were a follow-up patch
series whose sole intention is to migrate `git bisect` to the subcommand
API, I would have been eager to spent more time on making it more
incremental. However, the goal of this patch series was, and is, to finish
the conversion of `git bisect` from a script to a built-in.

That goal was unfortuntely made a lot harder than I wanted to by the
feedback I received, and I really wish that it would have been easier to
convert `git-bisect.sh` to `builtin/bisect.c`. I would see the feedback in
more favorable light if I could see how that feedback furthered that goal,
but I have a hard time finding enough evidence that I could consider to
merit 5 iterations and 7 months of work.

I want to be clear: any feedback you provide that helps me improve the
quality and correctness of my patches is appreciated. Your feedback where
you pointed out that my v5 would regress on 959d670d1a4 (i18n: remove from
i18n strings that do not hold translatable parts, 2022-01-31) is such a
feedback. I want to see more of that kind of feedback from you, and will
not hold it against you if you reduce tangential feedback in order to do
that.

Thank you,
Johannes

--8323328-1441139616-1661874174=:189--
