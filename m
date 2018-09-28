Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558CC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeI2EaB (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:30:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2EaA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so5396153pge.0
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g+8HFqs2SbXqA6/K1D7ntnoCuXR9CDmVa2XOZ8GODFw=;
        b=FVuzd4gymUqXvlNL/48gl+SDP2oH837hCLUo8CE0GvIzIT+r5JDLNcUKE59BbI/ZV7
         JKvSvcbbqXlVLepGKzwHauKpvCfyBPpy9OtPr6Ti2dANVyUs6RRrBnd00Z/t0pz+auG4
         rJW2P7vuu6hqGg9i482C7U25QQCJslmxJXoX3+Q5cDdqCJuzONUBKTQ/RIzaHuhbvuau
         CaYb3kyR/DThSV1QVx11TOD2T/l5K42d0vJXOqZ73Kzel1oWNLPKWksmmr+AX9SwdSw9
         TUdeOwpo0EXJPYEvkyE87DcZuRZQCHOqSFXXG9vHio76SPwl6KgxkaGZvAqjix8uywpa
         I/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+8HFqs2SbXqA6/K1D7ntnoCuXR9CDmVa2XOZ8GODFw=;
        b=hD4qe4d/5jBdOAnxFvKZ7vEKTohBFfe/i/2HrrVDtw9zHag4w7GfiS4+2VOXnrrftb
         t8YJG7dUNU24wdHCwtAmir4xwbSxAnLrf0HxXOW2fmKcTFWvTc7MnUndq9XmEOC8o6vc
         SpH4Zmui/DRXHGZJr3jarKpMgoZVq6yxINvCVShS4jVXz+L0XXm/pKPCF04sC3Fg+rjo
         /7OEIwrtY6jG1hzpJ++Q03lKuCxselIaJSLXbIj3H0X9RaBsMfrCS5cKh+EcJOhNWhp3
         zGHj0XOGvutWhTlyeQr/MRdYAhDRGQSQ+kYzEHvzxr+T7dCNLnoS36CKjuGz2tYN0ozq
         rQPg==
X-Gm-Message-State: ABuFfogRWgHyi1IeuJEqqm8EwsX5IXkp+qfWyenHQL/2QvhVCzUcr7Qd
        yB3EEDzaAW97F+atPU1b2RisWg==
X-Google-Smtp-Source: ACcGV62psRCEBFAfiTCKA8M5QzCNMZlYcYUcux311YI7MEuVRZkI20wBUStV2v4vf2vrIByW8I+2Qg==
X-Received: by 2002:a65:6204:: with SMTP id d4-v6mr471124pgv.121.1538172254251;
        Fri, 28 Sep 2018 15:04:14 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:a5eb:f7e6:92aa:f2c8])
        by smtp.gmail.com with ESMTPSA id 3-v6sm10779694pfq.10.2018.09.28.15.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:04:11 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 28 Sep 2018 15:04:10 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180928220410.GA45367@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <2dbcd5419073f06def007be3746ce90fffaf6a6d.1538108385.git.me@ttaylorr.com>
 <20180928052613.GC25850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928052613.GC25850@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 01:26:13AM -0400, Jeff King wrote:
> On Thu, Sep 27, 2018 at 09:25:42PM -0700, Taylor Blau wrote:
>
> > Let the repository that has alternates configure this command to avoid
> > trusting the alternate to provide us a safe command to run in the shell.
> > To behave differently on each alternate (e.g., only list tags from
> > alternate A, only heads from B) provide the path of the alternate as the
> > first argument.
>
> Well, you also need to pass the path so it knows which repo to look at.
> Which I think is the primary reason we do it, but behaving differently
> for each alternate is another option.

Yeah. I think that the clearer argument is yours, so I'll amend my copy.
I am thinking of:

  To find the alternate, pass its absolute path as the first argument.

How does that sound?

> > +core.alternateRefsCommand::
> > +   When advertising tips of available history from an alternate, use the shell to
> > +   execute the specified command instead of linkgit:git-for-each-ref[1]. The
> > +   first argument is the absolute path of the alternate. Output must be of the
> > +   form: `%(objectname)`, where multiple tips are separated by newlines.
>
> I wonder if people may be confused about the %(objectname) syntax, since
> it's specific to for-each-ref.  Now that we've simplified the output
> format to a single value, perhaps we should define it more directly.
> E.g., like:
>
>   The output should contain one hex object id per line (i.e., the same
>   as produced by `git for-each-ref --format='%(objectname)'`).

I think that that's clearer, thanks. I applied it pretty much as you
suggested, but changed 'should' to 'must' and dropped the leading 'the'.

> Now that we've dropped the refname requirement from the output, it is
> more clear that this really does not have to be about refs at all.  In
> the most technical sense, what we really allow in the output is any
> object id X for which the alternate promises it has all objects
> reachable from X. Ref tips are a convenient and efficient way of
> providing that, but they are not the only possibility (and likewise, it
> is fine to omit duplicates or even tips that are ancestors of other
> tips).
>
> I think that's probably getting _too_ technical, though. It probably
> makes sense to just keep thinking of these as "what are the ref tips".

Yep, I agree completely.

> > +This is useful when a repository only wishes to advertise some of its
> > +alternate's references as ".have"'s. For example, to only advertise branch
>
> Maybe put ".have" into backticks for formatting?

Good idea, thanks. I took this locally as suggested.

> > +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> > +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
>
> Does that script actually work? Because of the way we invoke shell
> commands with arguments, I think we'd end up with:
>
>   git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads "$@"

I think that you're right...

> Possibly for-each-ref would ignore the extra path argument (thinking
> it's a ref pattern that just doesn't match), but it's definitely not
> what you intended. You'd have to write:
>
>   f() { git --git-dir=$1 ...etc; } f
>
> in the usual way. That's a minor pain, but it's what makes the more
> direct:
>
>   /my/script
>
> work.

...but this was what I was trying to get across with saying "...to the
path of a script which runs...", such that we would get the implicit
scoping that you make explicit in your example with "f() { ... }; f".

Does that seem OK as-is after the additional context? I think that after
reading your response, it seems to be confusing, so perhaps it should be
changed...

> The other alternative is to pass $GIT_DIR in the environment on behalf
> of the program. Then writing:
>
>   git for-each-ref --format='%(objectname)' refs/heads
>
> would Just Work. But it's a bit subtle, since it is not immediately
> obvious that the command is meant to run in a different repository.

I think that we discussed this approach a bit off-list, and I had the
idea that it was too fragile to work in practice, and that it would be
too surprising for callers to suddenly be in a different world.

I say this not because it wouldn't make this particular scenario more
convenient, which it uncountably would, but because it would make other
scenarios _more_ complicated.

For example, if a caller uses an alternate reference backed, perhaps,
MySQL (or anything that _isn't_ Git), they're not going to want to have
these GIT_ environment variable set.

So, I think that the greatest common denominator between the two is to
pass the alternate's absolute path as the first argument.

> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > new file mode 100755
> > index 0000000000..503dde35a4
> > --- /dev/null
> > +++ b/t/t5410-receive-pack.sh
> > @@ -0,0 +1,49 @@
> > +#!/bin/sh
> > +
> > +test_description='git receive-pack test'
>
> The name of this test file and the description are pretty vague. Can we
> say something like "test handling of receive-pack with alternate-refs
> config"?

I left it intentionally vague, since I'd like for it to contain more
tests about 'git receive-pack'-specific things in the future.

I'm happy to change the name, though I wonder if we should change the
filename accordingly, and if so, to what.

> > +test_expect_success 'setup' '
> > +   test_commit one &&
> > +   git update-ref refs/heads/a HEAD &&
> > +   test_commit two &&
> > +   git update-ref refs/heads/b HEAD &&
> > +   test_commit three &&
> > +   git update-ref refs/heads/c HEAD &&
> > +   git clone --bare . fork &&
> > +   git clone fork pusher &&
> > +   (
> > +           cd fork &&
> > +           git update-ref --stdin <<-\EOF &&
> > +           delete refs/heads/a
> > +           delete refs/heads/b
> > +           delete refs/heads/c
> > +           delete refs/heads/master
> > +           delete refs/tags/one
> > +           delete refs/tags/two
> > +           delete refs/tags/three
> > +           EOF
> > +           echo "../../.git/objects" >objects/info/alternates
> > +   )
> > +'
>
> This setup is kind of convoluted. You're deleting those refs in the
> fork, I think, because we don't want them to suppress the duplicate
> .have lines from the alternate. Might it be easier to just create the
> .have lines we're interested in after the fact?
> I think we can also use "clone -s" to make the setup of the alternate a
> little simpler.
>
> I don't see the "pusher" repo being used for anything here. Leftover
> cruft from when you were using "git push" to test?
>
> So all together, perhaps something like:
>
>   # we have a fork which points back to us as an alternate
>   test_commit base &&
>   git clone -s . fork &&
>
>   # the alternate has two refs with new tips, in two separate hierarchies
>   git checkout -b public/branch master &&
>   test_commit public &&
>   git checkout -b private/branch master &&
>   test_commit private
>
> And then...
>
> > +test_expect_success 'with core.alternateRefsCommand' '
> > +   write_script fork/alternate-refs <<-\EOF &&
> > +           git --git-dir="$1" for-each-ref \
> > +                   --format="%(objectname)" \
> > +                   refs/heads/a \
> > +                   refs/heads/c
> > +   EOF
>
> ...this can just look for refs/heads/public/, and...
>
> > +   test_config -C fork core.alternateRefsCommand alternate-refs &&
> > +   git rev-parse a c >expect &&
>
> ...we verify that we saw public/branch but not private/branch.
>
> It's not that much shorter, but I had trouble understanding from the
> setup why we needed to delete all those refs (and why we cared about
> those tags in the first place).

I agree with all of this. It's certainly roughly the same length, but I
think that it makes it much easier to grok, and it addresses a comment
that Junio made in an earlier response to this thread. So, two wins for
the price of one :-).

I had to make a couple of other changes that you didn't recommend:

  - Since we used to create fork with 'git clone --bare', the path of
    `core.alternateRefsCommand` grew an extra `../`, since we have to
    also traverse _out_ of the .git directory in a non-bare repository.

    Instead of this, I opted for both, with 'git clone -s --bare .
    fork', which means we don't have to check out a working copy, and we
    can avoid changing the line mentioned above.

  - Another thing that I had to decide on was what to give as a prefix
    for the test exercising 'core.alternateRefsPrefixes', which I
    decided to use 'refs/heads/private' for, which makes sure that we're
    seeing something different than 'core.alternateRefsCommand'.

The diff is kind of long (so I'm avoiding sending it here), but I think
that it's mostly self-explanatory from what you recommended to me and
what I said above.

> > diff --git a/transport.c b/transport.c
> > index 2825debac5..e271b66603 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
> >  static void fill_alternate_refs_command(struct child_process *cmd,
> >                                     const char *repo_path)
>
> The code change itself looks good to me.

Thanks for your review, as always.

I'll wait until Monday to re-roll, just to make sure that there isn't
any new feedback between now and then.

Thanks,
Taylor
