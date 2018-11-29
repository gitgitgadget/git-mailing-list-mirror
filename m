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
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AB7211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 16:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeK3DJS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 22:09:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeK3DJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 22:09:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so2458688wrb.2
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+JyQcnWVlyFt2J99n1v1kmM30i+tLPzko4WtRMd9M28=;
        b=uKis4fzlGNsBWcOK/n5aj4HURnbU6jgTNj6GGAk6ChZC/M4iOxvo3pb5QITKjojlee
         v6xQtoP97vpsNczLLDDdmDdx7CrZ4q1Q+LSPa9HbEPwmv+FhUcAxlW24HB9xpRtvfpJc
         yTI27mrkgXr5a6OcEvwlYkGTHJCqIF++rsTsiCrJUay7KVcItIylloDSJ18e95VnUa3L
         AzhxfyDadq+PdIUhZ95pBAuHTehTIR+uQVGNqR77QIRjOiNqdzAzakqPY4nj1Uh6nwv3
         Hx1UP1CPqEAVC55RWZbwbWPHvpOoX3ZwNYT6g3zdXlt7i0lwGEDmDcRRiYH2PeRdhZz7
         JGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+JyQcnWVlyFt2J99n1v1kmM30i+tLPzko4WtRMd9M28=;
        b=INXMd0hnLffbz94rp/OhoM3Gu6/fTvJpqFAT2f5V1i0FGM95AMkgW4GNTGyuA6pEPO
         rYq3/J1nZ/C3eLWUOQZWjztkEQmHUSbMjtnv+mQjIKbF6KAzapEVs0H5Nbf2ut5OMdzN
         XdM5osxYHNTCdP2z9FHCOJqOsyRvKH3sVGoH3aqmAFLrOIvER5L2fBwmIEn2Avv8rfqs
         mPPnbLee/jNZNIBEBiDywUYb3HKwRvt0Sxy5DRncvD3gopkF8zJ0s+b5k4zMJFYc3boH
         SEK6rbyuLzOi9nAuQexe0eBDxSzG3kZjmaUDmGw1EGWyirzj00eBMjBQAcAQ19aX7FAu
         kU+Q==
X-Gm-Message-State: AA+aEWYng5wZPhJIYx3MavXshkNMw/c9RqkxcTK1yId6K7EDB532Td7p
        G7JjvytlxeyKbG+ttt1X1mY=
X-Google-Smtp-Source: AFSGD/U4Q5SnJYX/ClPzPO/5qGkmMNG4t/2pmAbwOUl5vQp7zM88+yZNFXKYDgV8DRAfCjD/cGdV2w==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr1872451wrw.310.1543507404930;
        Thu, 29 Nov 2018 08:03:24 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 5sm3487900wmw.8.2018.11.29.08.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:03:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com> <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet> <871s74yms3.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet>
Date:   Thu, 29 Nov 2018 17:03:22 +0100
Message-ID: <87tvjzyiph.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Thu, 29 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Thu, Nov 29 2018, Johannes Schindelin wrote:
>>
>> > On Thu, 29 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>> >
>> >> On Thu, Nov 29 2018, Johannes Schindelin wrote:
>> >>
>> >> > On Wed, 28 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>> >> >
>> >> >> Change the semantics of the "--range-diff" option so that the regular
>> >> >> diff options can be provided separately for the range-diff and the
>> >> >> patch. This allows for supplying e.g. --range-diff-U0 and -U1 to
>> >> >> "format-patch" to provide different context for the range-diff and the
>> >> >> patch. This wasn't possible before.
>> >> >
>> >> > I really, really dislike the `--range-diff-<random-thing>`. We have
>> >> > precedent for passing optional arguments that are passed to some other
>> >> > command, so a much more logical and consistent convention would be to use
>> >> > `--range-diff[=<diff-option>..]`, allowing all of the diff options that
>> >> > you might want to pass to the outer diff in one go rather than having a
>> >> > lengthy string of `--range-diff-this` and `--range-diff-that` options.
>> >>
>> >> Where do we pass those sorts of arguments?
>> >>
>> >> Reasons I did it this way:
>> >>
>> >>  a) Passing it as one option will require the user to double-quote those
>> >>     options that take quoted arguments (e.g. --word-diff-regex), which I
>> >>     thought sucked more than the prefix. On the implementation side we
>> >>     couldn't leave the parsing of the command-line to the shell anymore.
>> >>
>> >>  b) I think people will want to tweak this very rarely, much more rarely
>> >>     than e.g. -U10 in format-patch itself, so having something long-ish
>> >>     doesn't sound bad.
>> >
>> > Hmm. I still don't like it. It sets a precedent, and we simply do not do
>> > it that way in other circumstances (most obvious would be the -X merge
>> > options). The more divergent user interfaces for the same sort of thing
>> > are, the more brain cycles you force users to spend on navigating said
>> > interfaces.
>>
>> Yeah it sucks, I just think it sucks less than the alternative :)
>> I.e. I'm not picky about --range-diff-* prefix the name, but I think
>> doing our own shell parsing would be nasty.
>
> What prevents you from using `sq_dequote_to_argv()`?

I mean not just nasty in terms of implementation, yeah we could do it,
but also a nasty UX for things like --word-diff-regex. I.e. instead of:

    --range-diff-word-diff-regex='[0-9"]'

You need:

    --range-diff-opts="--word-diff-regex='[0-9\"]'"

Now admittedly that in itself isn't very painful *in this case*, but in
terms of precedent I really dislike that option, i.e. git having some
mode where I need to work to escape input to pass to another command.

Not saying that this --range-diff-* thing is what we should go for, but
surely we can find some way to do deal with this that doesn't involve
the user needing to escape stuff like this.

It also has other downstream effects in the UI, e.g. it's presumably
easy to teach the bash completion that a --foo=XYZ option is also called
--some-prefix--foo=XYZ and to enable completion for that, less so for
making it smart enough to complete "--some-prefix-opts="--foo=<TAB>".

>> >> > I only had time to skim the patch, and I have to wonder why you pass
>> >> > around full-blown `rev_info` structs for range diff (and with that really
>> >> > awful name `rd_rev`) rather than just the `diff_options` that you
>> >> > *actually* care about?
>> >>
>> >> Because setup_revisions() which does all the command-line parsing needs
>> >> a rev_info, so even if we only need the diffopt in the end we need to
>> >> initiate the whole thing.
>> >>
>> >> Suggestions for a better varibale name most welcome.
>> >
>> > `range_diff_revs`
>> >
>> > And you do not need to pass around the whole thing. You can easily pass
>> > `&range_diff_revs.diffopt`.
>> >
>> > Don't pass around what you do not need to pass around.
>>
>> Ah, you mean internally in log.c, yes that makes sense. I thought you
>> meant just pass diffopt to setup_revisions() (which needs the containing
>> struct). Willdo.
>
> Thanks,
> Dscho
>
>>
>> > Ciao,
>> > Dscho
>> >
>> >>
>> >> > Ciao,
>> >> > Dscho
>> >> >
>> >> >>
>> >> >> Ever since the "--range-diff" option was added in
>> >> >> 31e2617a5f ("format-patch: add --range-diff option to embed diff in
>> >> >> cover letter", 2018-07-22) the "rev->diffopt" we pass down to the diff
>> >> >> machinery has been the one we get from "format-patch"'s own
>> >> >> setup_revisions().
>> >> >>
>> >> >> This sort of thing is unique among the log-like commands in
>> >> >> builtin/log.c, no command than format-patch will embed the output of
>> >> >> another log-like command. Since the "rev->diffopt" is reused we need
>> >> >> to munge it before we pass it to show_range_diff(). See
>> >> >> 43dafc4172 ("format-patch: don't include --stat with --range-diff
>> >> >> output", 2018-11-22) for a related regression fix which is being
>> >> >> mostly reverted here.
>> >> >>
>> >> >> Implementation notes: 1) We're not bothering with the full teardown
>> >> >> around die() and will leak memory, but it's too much boilerplate to do
>> >> >> all the frees with/without the die() and not worth it. 2) We call
>> >> >> repo_init_revisions() for "rd_rev" even though we could get away with
>> >> >> a shallow copy like the code we're replacing (and which
>> >> >> show_range_diff() itself does). This is to make this code more easily
>> >> >> understood.
>> >> >>
>> >> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> >> >> ---
>> >> >>  Documentation/git-format-patch.txt | 10 ++++++-
>> >> >>  builtin/log.c                      | 42 +++++++++++++++++++++++-------
>> >> >>  t/t3206-range-diff.sh              | 41 +++++++++++++++++++++++++++++
>> >> >>  3 files changed, 82 insertions(+), 11 deletions(-)
>> >> >>
>> >> >> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
>> >> >> index aba4c5febe..6c048f415f 100644
>> >> >> --- a/Documentation/git-format-patch.txt
>> >> >> +++ b/Documentation/git-format-patch.txt
>> >> >> @@ -24,7 +24,8 @@ SYNOPSIS
>> >> >>  		   [--to=<email>] [--cc=<email>]
>> >> >>  		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
>> >> >>  		   [--interdiff=<previous>]
>> >> >> -		   [--range-diff=<previous> [--creation-factor=<percent>]]
>> >> >> +		   [--range-diff=<previous> [--creation-factor=<percent>]
>> >> >> +		      [--range-diff<common diff option>]]
>> >> >>  		   [--progress]
>> >> >>  		   [<common diff options>]
>> >> >>  		   [ <since> | <revision range> ]
>> >> >> @@ -257,6 +258,13 @@ feeding the result to `git send-email`.
>> >> >>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
>> >> >>  	for details.
>> >> >>
>> >> >> +--range-diff<common diff option>::
>> >> >> +	Other options prefixed with `--range-diff` are stripped of
>> >> >> +	that prefix and passed as-is to the diff machinery used to
>> >> >> +	generate the range-diff, e.g. `--range-diff-U0` and
>> >> >> +	`--range-diff--no-color`. This allows for adjusting the format
>> >> >> +	of the range-diff independently from the patch itself.
>> >> >> +
>> >> >>  --notes[=<ref>]::
>> >> >>  	Append the notes (see linkgit:git-notes[1]) for the commit
>> >> >>  	after the three-dash line.
>> >> >> diff --git a/builtin/log.c b/builtin/log.c
>> >> >> index 02d88fa233..7658e56ecc 100644
>> >> >> --- a/builtin/log.c
>> >> >> +++ b/builtin/log.c
>> >> >> @@ -1023,7 +1023,8 @@ static void show_diffstat(struct rev_info *rev,
>> >> >>  	fprintf(rev->diffopt.file, "\n");
>> >> >>  }
>> >> >>
>> >> >> -static void make_cover_letter(struct rev_info *rev, int use_stdout,
>> >> >> +static void make_cover_letter(struct rev_info *rev, struct rev_info *rd_rev,
>> >> >> +			      int use_stdout,
>> >> >>  			      struct commit *origin,
>> >> >>  			      int nr, struct commit **list,
>> >> >>  			      const char *branch_name,
>> >> >> @@ -1095,13 +1096,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>> >> >>  	}
>> >> >>
>> >> >>  	if (rev->rdiff1) {
>> >> >> -		struct diff_options opts;
>> >> >> -		memcpy(&opts, &rev->diffopt, sizeof(opts));
>> >> >> -		opts.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
>> >> >> -
>> >> >>  		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
>> >> >>  		show_range_diff(rev->rdiff1, rev->rdiff2,
>> >> >> -				rev->creation_factor, 1, &opts);
>> >> >> +				rev->creation_factor, 1, &rd_rev->diffopt);
>> >> >>  	}
>> >> >>  }
>> >> >>
>> >> >> @@ -1485,6 +1482,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>> >> >>  	struct commit *commit;
>> >> >>  	struct commit **list = NULL;
>> >> >>  	struct rev_info rev;
>> >> >> +	struct rev_info rd_rev;
>> >> >>  	struct setup_revision_opt s_r_opt;
>> >> >>  	int nr = 0, total, i;
>> >> >>  	int use_stdout = 0;
>> >> >> @@ -1603,6 +1601,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>> >> >>  	init_log_defaults();
>> >> >>  	git_config(git_format_config, NULL);
>> >> >>  	repo_init_revisions(the_repository, &rev, prefix);
>> >> >> +	repo_init_revisions(the_repository, &rd_rev, prefix);
>> >> >>  	rev.commit_format = CMIT_FMT_EMAIL;
>> >> >>  	rev.expand_tabs_in_log_default = 0;
>> >> >>  	rev.verbose_header = 1;
>> >> >> @@ -1689,8 +1688,32 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>> >> >>  	rev.preserve_subject = keep_subject;
>> >> >>
>> >> >>  	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
>> >> >> -	if (argc > 1)
>> >> >> -		die(_("unrecognized argument: %s"), argv[1]);
>> >> >> +	if (argc > 1) {
>> >> >> +		struct argv_array args = ARGV_ARRAY_INIT;
>> >> >> +		const char *prefix = "--range-diff";
>> >> >> +		int have_prefix = 0;
>> >> >> +
>> >> >> +		for (i = 0; i < argc; i++) {
>> >> >> +			struct strbuf sb = STRBUF_INIT;
>> >> >> +			char *str;
>> >> >> +
>> >> >> +			strbuf_addstr(&sb, argv[i]);
>> >> >> +			if (starts_with(argv[i], prefix)) {
>> >> >> +				have_prefix = 1;
>> >> >> +				strbuf_remove(&sb, 0, strlen(prefix));
>> >> >> +			}
>> >> >> +			str = strbuf_detach(&sb, NULL);
>> >> >> +			strbuf_release(&sb);
>> >> >> +
>> >> >> +			argv_array_push(&args, str);
>> >> >> +		}
>> >> >> +
>> >> >> +		if (!have_prefix)
>> >> >> +			die(_("unrecognized argument: %s"), argv[1]);
>> >> >> +		argc = setup_revisions(args.argc, args.argv, &rd_rev, NULL);
>> >> >> +		if (argc > 1)
>> >> >> +			die(_("unrecognized argument: %s"), argv[1]);
>> >> >> +	}
>> >> >>
>> >> >>  	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
>> >> >>  		die(_("--name-only does not make sense"));
>> >> >> @@ -1702,7 +1725,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>> >> >>  	if (!use_patch_format &&
>> >> >>  		(!rev.diffopt.output_format ||
>> >> >>  		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
>> >> >> -		/* Needs to be mirrored in show_range_diff() invocation */
>> >> >>  		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
>> >> >>  	if (!rev.diffopt.stat_width)
>> >> >>  		rev.diffopt.stat_width = MAIL_DEFAULT_WRAP;
>> >> >> @@ -1877,7 +1899,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>> >> >>  	if (cover_letter) {
>> >> >>  		if (thread)
>> >> >>  			gen_message_id(&rev, "cover");
>> >> >> -		make_cover_letter(&rev, use_stdout,
>> >> >> +		make_cover_letter(&rev, &rd_rev, use_stdout,
>> >> >>  				  origin, nr, list, branch_name, quiet);
>> >> >>  		print_bases(&bases, rev.diffopt.file);
>> >> >>  		print_signature(rev.diffopt.file);
>> >> >> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> >> >> index bc5facc1cd..6916103888 100755
>> >> >> --- a/t/t3206-range-diff.sh
>> >> >> +++ b/t/t3206-range-diff.sh
>> >> >> @@ -308,6 +308,35 @@ test_expect_success 'format-patch with <common diff option>' '
>> >> >>  		--range-diff=topic~..topic changed~..changed >actual.raw &&
>> >> >>  	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
>> >> >>  	sed -e "s|:$||" >expect <<-\EOF &&
>> >> >> +	1:  a63e992 ! 1:  d966c5c s/12/B/
>> >> >> +	    @@ -8,7 +8,7 @@
>> >> >> +	     @@
>> >> >> +	      9
>> >> >> +	      10
>> >> >> +	    - B
>> >> >> +	    + BB
>> >> >> +	     -12
>> >> >> +	     +B
>> >> >> +	      13
>> >> >> +	-- :
>> >> >> +	EOF
>> >> >> +	test_cmp expect actual.range-diff &&
>> >> >> +	sed -ne "/^--- /,/^--/p" <actual.raw >actual.diff &&
>> >> >> +	sed -e "s|:$||" >expect <<-\EOF &&
>> >> >> +	--- a/file
>> >> >> +	+++ b/file
>> >> >> +	@@ -12 +12 @@ BB
>> >> >> +	-12
>> >> >> +	+B
>> >> >> +	-- :
>> >> >> +	EOF
>> >> >> +	test_cmp expect actual.diff &&
>> >> >> +
>> >> >> +	# -U0 & --range-diff-U0
>> >> >> +	git format-patch --cover-letter --stdout -U0 --range-diff-U0 \
>> >> >> +		--range-diff=topic~..topic changed~..changed >actual.raw &&
>> >> >> +	sed -ne "/^1:/,/^--/p" <actual.raw >actual.range-diff &&
>> >> >> +	sed -e "s|:$||" >expect <<-\EOF &&
>> >> >>  	1:  a63e992 ! 1:  d966c5c s/12/B/
>> >> >>  	    @@ -11 +11 @@
>> >> >>  	    - B
>> >> >> @@ -327,4 +356,16 @@ test_expect_success 'format-patch with <common diff option>' '
>> >> >>  	test_cmp expect actual.diff
>> >> >>  '
>> >> >>
>> >> >> +test_expect_success 'format-patch option parsing with --range-diff-*' '
>> >> >> +	test_must_fail git format-patch --stdout --unknown \
>> >> >> +		master..unmodified 2>stderr &&
>> >> >> +	test_i18ngrep "unrecognized argument: --unknown" stderr &&
>> >> >> +	test_must_fail git format-patch --stdout --range-diff-unknown \
>> >> >> +		master..unmodified 2>stderr &&
>> >> >> +	test_i18ngrep "unrecognized argument: --range-diff-unknown" stderr &&
>> >> >> +	test_must_fail git format-patch --stdout --unknown --range-diff-unknown \
>> >> >> +		master..unmodified 2>stderr &&
>> >> >> +	test_i18ngrep "unrecognized argument: --unknown" stderr
>> >> >> +'
>> >> >> +
>> >> >>  test_done
>> >> >> --
>> >> >> 2.20.0.rc1.387.gf8505762e3
>> >> >>
>> >> >>
>> >>
>>
