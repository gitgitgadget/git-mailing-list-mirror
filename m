Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20EA208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeG2XRo (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 19:17:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeG2XRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 19:17:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so10676969wro.3
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k7PAsQ3hDzfcR1lSm2zVYveCf+hNTL3fDGM98XFG0sw=;
        b=PN9eY4okRZLmEGMvOEkFCWi9TZ57b0VErKr0EVomwzijBMaALMy66uUWN0z7R2YUej
         hG/5s0rpq456ILhivWZ7vVP+WW9kUBnhSsKkfJ//mfmXIw6//Pu52Mm4xg3BMlpab/n9
         rRyE7wemLQ3RPfqd7PkZemzk5kCfTQ7a8B9heVdc3HeO95yNrLvPa1OtbeCjkwpUm93Z
         sI+3/EOuBmLMH7X+pCSBYbR8N0C8iN9gsOeB9fMA4vhQwPihMhufmm06HtVAD1Qe9S3o
         T+se1xX0mP3gVbbjUPKnWexykulrZnPyWJ/A4MHyte84jArYNMo38CrxU2D5FuufduMN
         s4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7PAsQ3hDzfcR1lSm2zVYveCf+hNTL3fDGM98XFG0sw=;
        b=S81nKEeZ7o79WW81dsV1KaH4rlq9r7Vb3aCwtSt2sHeDNxjgwboDhNLDfPs6TZZW2F
         //nLOfh+vOZ2uiSxff0+12b/OXHKDC/n/7+z+/TMG2ajlyj2Zrwe9qzVxemxSyrfEJ/O
         N351x480obL+Ifzo2natNi3t5hGySIehFl8mGLg8Rfak4yXItxuKAELw3H2w/HjoqCw4
         fozB7pLS6UGV1NUORHTu9tAv5ZwrSuDKQYtE6C6QGC7xsYNqvkfzuj1cWn38fKl8XwhD
         /g0pk/NwD1p9eOdBKYHsukz/+u75JjpcAgdMFaiUOvHlcJgjWiqRCu3BkNO7uFTnJMxv
         y5kA==
X-Gm-Message-State: AOUpUlFoA9PmzqxDsFqiuXOrKd1+Md4XDISUKEiZvIRd+Zj8UMoZ1SOo
        o9Cy1DzvqqmpHTYHe9haGWM=
X-Google-Smtp-Source: AAOMgpeY5gc76yDuA6FtJG7AipUcPbqyP4+5YQcS7VTmoZG0ZrcPZsgvdIy3Wx6nL/pAT3Pj+Jp5lA==
X-Received: by 2002:adf:f001:: with SMTP id j1-v6mr14161320wro.260.1532900745174;
        Sun, 29 Jul 2018 14:45:45 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id d14-v6sm14295062wrr.12.2018.07.29.14.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:45:44 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:45:43 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
Message-ID: <20180729214543.GD9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
 <20180729190359.GD2734@hank.intra.tgummerer.com>
 <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/29, Eric Sunshine wrote:
> On Sun, Jul 29, 2018 at 3:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > Just like tbdiff, we now show the diff between matching patches. This is
> > > a "diff of two diffs", so it can be a bit daunting to read for the
> > > beginner.
> > > [...]
> > > Note also: while tbdiff accepts the `--no-patches` option to suppress
> > > these diffs between patches, we prefer the `-s` option that is
> > > automatically supported via our use of diff_opt_parse().
> >
> > One slightly unfortunate thing here is that we don't show these
> > options in 'git range-diff -h', which would be nice to have.  I don't
> > know if that's possible in git right now, if it's not easily possible,
> > I definitely wouldn't want to delay this series for that, and we could
> > just add it to the list of possible future enhancements that other
> > people mentioned.
> 
> This issue is not specific to git-range-diff; it's shared by other
> commands which inherit diff options via diff_opt_parse(). For
> instance, "git log -h" doesn't show diff-related options either, yet
> it accepts them.

Fair enough, that makes sense.  Thanks for the pointer!

There's one more thing that I noticed here:

    git range-diff --no-patches
    fatal: single arg format requires a symmetric range

Which is a slightly confusing error message.  In contrast git log does
the following on an unrecognized argument:

    git log --no-patches
    fatal: unrecognized argument: --no-patches

which is a little better I think.  I do however also thing the "fatal:
single arg format requires a symmetric range" is useful when someone
genuinely tries to use the single argument version of the command.  So
I don't know what a good solution for this would be.

> > > diff --git a/range-diff.c b/range-diff.c
> > > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> > >                       printf("%d: %s ! %d: %s\n",
> > >                              b_util->matching + 1, short_oid(a_util),
> > >                              j + 1, short_oid(b_util));
> > > +                     if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> >
> > Looking at this line, it looks like it would be easy to support
> > '--no-patches' as well, which may be slightly easier to understand that
> > '-s' to someone new to the command.  But again that can be added later
> > if someone actually cares about it.
> 
> What wasn't mentioned (but was implied) by the commit message is that
> "-s" is short for "--no-patch", which also comes for free via
> diff_opt_parse(). True, "--no-patch" isn't spelled exactly the same as
> "--no-patches", but git-range-diff isn't exactly a perfect tbdiff
> clone, so hopefully not a git problem. Moreover, "--no-patch" is
> internally consistent within the Git builtin commands.

Makes sense, thanks!  "--no-patch" does make sense to me.  There's
still a lot of command line flags in git to learn for me, even after
all this time using it ;)  Might be nice to spell it out in the commit
message for someone like me, especially as "--no-patches" is already
mentioned.  Though I guess most regulars here would know about
"--no-patch", so maybe it's not worth it.  Anyway that is definitely
not worth another round here.
