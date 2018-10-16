Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A7E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 19:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJQDvz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 23:51:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36377 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeJQDvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 23:51:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so27005117wrw.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7PeOkfJ0URGXywVT21phU1/TnsHEiyOGk182Dg1BuY=;
        b=Yt8tBBSosrI0C8F5FFPfvKEX1ehavWuL10ZSFiO84D7gnZ/1HUwzSqVTrLwQKlEr8+
         rPP8STLThKFVBzrgIO8LSvRmNw1vwvh2ll5sK2zruus5EpMoeHr8VweBcBnc9DtY5pri
         CfPuPlfbLONEuzycVhtiOVEC0in3/j4UDuDM7K/cX9nwkB9/qZSi+7cLkAsMpGNHP20w
         LrV17BR0OjjzJq5upNgEMSSKgfOk9jfXVG2Cz8Q567XsQgPS9DR/OfxjWoCxIr+/v1NC
         BfCHfqMNHdgBUd5O9vlwOObSwwJMTceWBgQUdWa5+Z3Fhm9gyzzGFoHAYA3A0DMHv1Ca
         EwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7PeOkfJ0URGXywVT21phU1/TnsHEiyOGk182Dg1BuY=;
        b=PrquBmRvmndhwRmcVRnYj2Psm7d132SJcl/hkbhBykq3seuUjF4MUBmZ5F2CxKk0O2
         0K3RviMxYh5fDX2SzC5GOKjbul8+2iFA1g0IqOvhFQoqtHWnAmsNATDuJxVMAObCCsJm
         TwA1qKIA+P1rQRUWdh9hEWhEh6xTilgRDqPdzTN9WdPGKf5SgcBlVycN+lrUArShGRM2
         TRROT8CaOXHLyLFrqAKVgOBAO17yjiod3G9aLh+Yt/DRdqO2ZNOZCPUrJ+cdy6kk8piZ
         qmPEGtxvLoBrQ58VIzd0pZ7ltN7G0E2EIvpexjHpZzBSu7GnPxoag7iHpASmxint+dnw
         Ry6A==
X-Gm-Message-State: ABuFfoj1MULaX3MFf4sr4sgnMGETe4fGZUmeIx0vYp1qAYnO8YfiS+5B
        GZ8w7B2NZuh5a1oWm/WWy2aqQJwP
X-Google-Smtp-Source: ACcGV61cGL9XTqu5O4hhf8SHfEalJlf9Qp4MJ0do6I5JZDwLZrPy4sBEAVQRGJVDfxGgyG6WiJO7SQ==
X-Received: by 2002:adf:fb89:: with SMTP id a9-v6mr18601435wrr.219.1539719991287;
        Tue, 16 Oct 2018 12:59:51 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id k1-v6sm13940906wrl.39.2018.10.16.12.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 12:59:50 -0700 (PDT)
Date:   Tue, 16 Oct 2018 20:59:49 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v10 00/21] Convert "git stash" to C builtin
Message-ID: <20181016195949.GE4883@hank.intra.tgummerer.com>
References: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/>
 <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
 <20181015221040.GD4883@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1810161205530.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810161205530.4546@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Mon, 15 Oct 2018, Thomas Gummerer wrote:
> 
> >  2:  63f2e0e6f9 !  2:  2d45985676 strbuf.c: add `strbuf_join_argv()`
> >     @@ -14,19 +14,17 @@
> >       	strbuf_setlen(sb, sb->len + sb2->len);
> >       }
> >       
> >     -+const char *strbuf_join_argv(struct strbuf *buf,
> >     -+			     int argc, const char **argv, char delim)
> >     ++void strbuf_join_argv(struct strbuf *buf,
> >     ++		      int argc, const char **argv, char delim)
> 
> While the patch series does not use the return value, I have to ask
> whether it would really be useful to change it to return `void`. I could
> imagine that there may already be quite a few code paths that would love
> to use strbuf_join_argv(), *and* would benefit from the `const char *`
> return value.

Fair enough.  I did suggest changing the return type to void here, as
I found the API a bit odd compared to the rest of the strbuf API,
however after looking at this again I agree with you, and returning a
const char * here does seem more helpful.  Sorry about the confusion
Paul-Sebastian!

> In other words: just because the *current* patches do not make use of that
> quite convenient return value does not mean that we should remove that
> convenience.
>
> >  7:  a2abd1b4bd !  8:  974dbaa492 stash: convert apply to builtin
> >     @@ -370,18 +370,20 @@
> >      +
> >      +			if (diff_tree_binary(&out, &info->w_commit)) {
> >      +				strbuf_release(&out);
> >     -+				return -1;
> >     ++				return error(_("Could not generate diff %s^!."),
> >     ++					     oid_to_hex(&info->w_commit));
> 
> Please start the argument of an `error()` call with a lower-case letter.

I think this comes from your fixup! commit ;) But I do agree, these should be
lower-case.

> >      +			}
> >      +
> >      +			ret = apply_cached(&out);
> >      +			strbuf_release(&out);
> >      +			if (ret)
> >     -+				return -1;
> >     ++				return error(_("Conflicts in index."
> >     ++					       "Try without --index."));
> 
> Same here.
> 
> >      +
> >      +			discard_cache();
> >      +			read_cache();
> >      +			if (write_cache_as_tree(&index_tree, 0, NULL))
> >     -+				return -1;
> >     ++				return error(_("Could not save index tree"));
> 
> And here.
> 
> > 15:  bd827be103 ! 15:  989db67e9a stash: convert create to builtin
> >     @@ -119,7 +119,6 @@
> >      +static int check_changes(struct pathspec ps, int include_untracked)
> >      +{
> >      +	int result;
> >     -+	int ret = 0;
> 
> I was curious about this change, and could not find it in the
> git-stash-v10 tag of https://github.com/ungps/git...

This line has been removed in v10, but did exist in v9, so
the git-stash-v10 should indeed not have this line.  I suggested
removing it in [*1*], because it breaks compilation with DEVELOPER=1
at this step.

> > 18:  1c501ad666 ! 18:  c90e30173a stash: convert save to builtin
> >     @@ -72,8 +72,10 @@
> >      +			     git_stash_helper_save_usage,
> >      +			     PARSE_OPT_KEEP_DASHDASH);
> >      +
> >     -+	if (argc)
> >     -+		stash_msg = (char*) strbuf_join_argv(&buf, argc, argv, ' ');
> >     ++	if (argc) {
> >     ++		strbuf_join_argv(&buf, argc, argv, ' ');
> >     ++		stash_msg = buf.buf;
> >     ++	}
> 
> Aha! So there *was* a user of that return value. I really would prefer a
> non-void return value here.

Right, I'd argue we're mis-using the API here though.  do_push_stash
who we later pass stash_msg to takes ownership and later free's the
memory before returning.  This doesn't cause issues in the test suite
at the moment, because do_create_stash() doesn't always free stash_msg
before assigning a new value to the pointer, but would cause issues
when do_create_stash exits early.

Rather than the solution I proposed in I think it would be nicer to
use 'stash_msg = strbuf_detach(...)' above.

I'm still happy with the function returning buf->buf as const char *,
but I'm not sure we should use that return value here.

> > 19:  c4401b21db ! 19:  4360ea875d stash: convert `stash--helper.c` into `stash.c`
> >     @@ -264,9 +320,9 @@
> >      -	argc = parse_options(argc, argv, prefix, options,
> >      -			     git_stash_helper_create_usage,
> >      -			     0);
> >     -+	/* Startinf with argv[1], since argv[0] is "create" */
> >     -+	stash_msg = (char*) strbuf_join_argv(&stash_msg_buf, argc - 1,
> >     -+					     ++argv, ' ');
> >     ++	/* Starting with argv[1], since argv[0] is "create" */
> >     ++	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
> >     ++	stash_msg = stash_msg_buf.buf;
> 
> Again, I would strongly prefer the convenience of assigning the return
> value directly, rather than having two lines.

This is a similar case as above, where I think using strbuf_detach
would be best, again instead of the 'xstrdup()' I mentioned in [*2*].

> >     @@ -375,10 +425,8 @@
> >      +			 * they need to be immediately followed by a string
> >      +			 * (i.e.`-m"foobar"` or `--message="foobar"`).
> >      +			 */
> >     -+			if ((strlen(argv[i]) > 2 &&
> >     -+			     !strncmp(argv[i], "-m", 2)) ||
> >     -+			    (strlen(argv[i]) > 10 &&
> >     -+			     !strncmp(argv[i], "--message=", 10)))
> >     ++			if (starts_with(argv[i], "-m") ||
> >     ++			    starts_with(argv[i], "--message="))
> 
> Very nice.
> 
> > 20:  92dc11fd16 ! 20:  a384b05008 stash: optimize `get_untracked_files()` and `check_changes()`
> >     @@ -52,7 +52,6 @@
> >      +static int check_changes_tracked_files(struct pathspec ps)
> >       {
> >       	int result;
> >     --	int ret = 0;
> 
> I also wonder about this change, in light of...

The double - in the beginning of the range diff indicates that the
removal of this line was removed from this particular patch (the
removal is now done in patch 15 instead).  I think this is one of
those cases where the range-diff is a bit hard to interpret,
especially without the --dual-color mode :)

> >       	struct rev_info rev;
> >       	struct object_id dummy;
> >      -	struct strbuf out = STRBUF_INIT;
> >     @@ -99,8 +98,8 @@
> >      -	if (!check_changes(ps, include_untracked)) {
> >      +	if (!check_changes(ps, include_untracked, &untracked_files)) {
> >       		ret = 1;
> 
> this here line. How does that work, if `ret` is removed? And why didn't
> the `make DEVELOPER=1` complain about that unused `ret` variable before?

This is a different function, the above is in the
'check_changes_tracked_files()' function, while we are in the
'do_create_stash()' function, which has a local 'ret' variable.

> 
> >     - 		*stash_msg = NULL;
> >       		goto done;
> >     + 	}
> >      @@
> >       		goto done;
> 
> The rest of the changes looks pretty sensible to me (indentation/wrapping
> changes, mostly, with a couple of commit message/typo fixes thrown in).
> 
> Maybe you have a commit hash, or even better, a tag in a public Git
> repository somewhere, so that Paul can pick it up more easily (and compare
> the changes with his latest local branch)?

The range-diff here between Paul's v9 and v10 series.  I just applied
both series, and sent out the range-diff in case someone else prefered
not applying both series, or fetching both from Paul's repo, but
reading the range-diff (and I got you to comment on it, which I
already found helpful :)).  There are no changes of my own included in
this.

> Thank you!
> Dscho

[*1*]: https://public-inbox.org/git/20181002201940.GH2253@hank.intra.tgummerer.com/
[*2*]: https://public-inbox.org/git/20181015220338.GB4883@hank.intra.tgummerer.com/
