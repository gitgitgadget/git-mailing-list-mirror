Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09451211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 16:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeLEQUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 11:20:36 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:42495 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 11:20:36 -0500
Received: by mail-yb1-f174.google.com with SMTP id s8so6470730ybe.9
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fc5PE9LqX3uxZzl/xxiZcXKoOQkgCaElWqgaTraZa6Y=;
        b=dhJrZkqxw6FbB8U6vQ1fFURMqhrkIGfLNj7Nm7JwuWsHjSNfN11gWtTW6kccVCnhUz
         JPQr6rFfFjU7zgOhqMMcA7nUX+zEGCzxX7rcEBF87v74pS9mJyWaKB7w09dDe1yD3354
         8OrZQ+PY0oQjismZLU5sbSWYDIvFsnB0O4qoN3gh1gFSY9ubVw49DUuq578eh7iweT2o
         kBHPelwCLzMwhzCqd+eAQ6hW0ncrIJ652+KaazgZiiQQwNk53samt4uOD1q3ivqK2JbT
         nuauIH13vIZlvx5iKfkeXMB1r8/1XWrEFFb6UjZMpSuUd6MicmUd3znPE0DH74V6x6kJ
         h9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fc5PE9LqX3uxZzl/xxiZcXKoOQkgCaElWqgaTraZa6Y=;
        b=lIR5eDIsxE0vnZJLmatRYhmhKS/a+y6m9YBf1a3QLxyppwcocp81dsrs/vsj1lkTWR
         aj5ox38K6zEBGgmQzIbdy7JnA10Fd2Dci9eJ4Qn+QcpNeRZM+NGWRqoNjQvMRj9u5BKv
         QCdAixUBngd5/bUN4RkyjoMBro23rdSWr5MuWJ6s4V8+zyI4uYmd1sWqcgIRPdw2mKjJ
         LDd16k+EZ3oc/6cXLfmmrzwBihXOP2oBwNyhazAYvi95shlrSa5josrfr7edKG0UofM/
         OHH4B8G4tlk2qK71H1hJHsDeVhOsvN+QYnowfUI1HDxtYbKRklhyF1XTKFnc7yadXL9Z
         6GPg==
X-Gm-Message-State: AA+aEWYVqgPmsdTvi1XEV21so511rLbc96IS0zW8crUZEbPJ+vXIXuDT
        UPcR/XhxgYsdF9rraOnfuG0=
X-Google-Smtp-Source: AFSGD/XNvW4+oUDaHk7LoWsYPYfXI0jpApEO3WBi+AEu9rapRYQRuK6czz0zZVZMpWp5TtV6gyBwpw==
X-Received: by 2002:a25:7208:: with SMTP id n8-v6mr24479180ybc.144.1544026834549;
        Wed, 05 Dec 2018 08:20:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:d57b])
        by smtp.gmail.com with ESMTPSA id r20sm13258620ywa.13.2018.12.05.08.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:20:33 -0800 (PST)
Date:   Wed, 5 Dec 2018 08:20:31 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        kernel-team@fb.com
Subject: Re: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181205161103.GO2509588@devbig004.ftw2.facebook.com>
References: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
 <20181115144044.GA16450@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115144044.GA16450@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Jeff.

On Thu, Nov 15, 2018 at 09:40:44AM -0500, Jeff King wrote:
> Sorry for the slow reply. This was on my to-look-at pile, but for
> some reason I accidentally put in my done pile.

No worries and sorry about my late reply too.  Things were a bit
hectic.

> > * A new built-in command note-cherry-picks, which walks the specified
> >   commits and if they're marked with the cherry-pick trailer, adds the
> >   backlink to the origin commit using Cherry-picked-to tag in a
> >   cherry-picks note.
> 
> That makes sense. I think this could also be an option to cherry-pick,
> to instruct it to create the note when the cherry-pick is made.
> 
> But you may still want a command to backfill older cherry-picks, or
> those done by other people who do not care themselves about maintaining
> the notes tree.

So, I wanted to do both with the same command.  git-cherry-pick knows
which commits are new, so it can just pass those commits to
note-cherry-picks.  When backfilling the whole tree or newly pulled
commits, the appropriate command can invoke note-cherry-picks with the
new commits which should be super cheap.

> It _feels_ like this is something that should be do-able by plugging a
> few commands together, rather than writing a new C program. I.e.,
> something like:
> 
>   git rev-list --format='%(trailers)' HEAD |
>   perl -lne '
> 	/^commit ([0-9]+)/ and $commit = $1;
> 	/^\(cherry picked from commit ([0-9]+)/
> 		and print "$commit $1";
>   ' |
>   while read from to; do
> 	# One process per note isn't very efficient. Ideally there would
> 	# be an "append --stdin" mode. Double points if it understands
> 	# how to avoid adding existing lines.
> 	git notes append -m "Cherry-picked-to: $to" $from
>   done
> 
> which is roughly what your program is doing.  Not that I'm entirely
> opposed to doing something in C (we've been moving away from shell
> scripts anyway). But mostly I am wondering if we can leverage existing

But the above wouldn't clean up stale commits, which could happen with
e.g. abandoned releases, and would be prone to creating duplicates.
We sure can add all those to shell / perl scripts but it's difficult
for me to see the upsides of doing it that way.

> tools, and fill in their gaps in a way that lets people easily do
> similar things.

I'll respond to this together below.

> And on that note...
> 
> > * When formatting a cherry-picks note for display, nested cherry-picks
> >   are followed from each Cherry-picked-to tag and printed out with
> >   matching indentations.
> 
> That makes sense to me, but does this have to be strictly related to
> cherry-picks? I.e., in the more generic form, could we have a way of
> marking a note as "transitive" for display, and the notes-display code
> would automatically recognize and walk hashes?
> 
> That would serve your purpose, but would also allow similar things to
> easily be done in the future.

Below.

> > Combined with name-rev --stdin, it can produce outputs like the following.
> > [...]
> 
> Yeah, that looks pretty good.
> 
> > Locally, the notes can be kept up-to-date with a trivial post-commit
> > hook which invokes note-cherry-picks on the new commit; however, I'm
> > having a bit of trouble figuring out a way to keep it up-to-date when
> > multiple trees are involved.  AFAICS, there are two options.
> > 
> > 1. Ensuring that the notes are always generated on local commits and
> >    whenever new commits are received through fetch/pulls.
> > 
> > 2. Ensuring that the notes are always generated on local commits and
> >    transported with push/pulls.
> > 
> > 3. A hybrid approach - also generate notes on the receiving end and
> >    ensure that fetch/pulls receives the notes together (ie. similar to
> >    --tags option to git-fetch).
> > 
> > #1 seems simpler and more robust to me.  Unfortunately, I can't see a
> > way to implement any of the three options with the existing hooks.
> > For #1, there's no post-fetch hook.  For #2 and #3, there doesn't seem
> > to be a fool-proof way to make sure that the notes are transported
> > together.  Any suggestions would be greatly appreciated.
> 
> Yeah, I think (1) is the simplest: it becomes a purely local thing that
> you've generated these annotations. Unfortunately, no, I don't think
> there's anything like a post-fetch hook. This might be a good reason to
> have one. One can always do "git fetch && update-notes" of course, but
> having fetch feed the script the set of updated ref tips would be very
> helpful (so you know you can traverse from $old..$new looking for
> cherry-picks).

This sounds great to me.

> I only looked briefly over your implementation, but didn't see anything
> obviously wrong. I do think it would be nice to make it more generic, as
> much as possible. I think the most generic form is really:
> 
>   traverse-and-show-trailers | invert-trailers | add-notes
> 
> In theory I should be able to do the same inversion step on any trailer
> which mentions another commit.

Hmm... yeah, I can definitely separate out the first part into a
separate function, move dedup of notes to add-notes, and then glue
them together.

I'm a bit hesitant to expose the first part as a separate command
without knowing what other use cases would actually look like.  I'll
make it so that it's easy to do so when a new use case arises.

> If it is going to stay in C and be cherry-pick-specific, one obvious
> improvement would be to use the notes API directly, rather than spawning
> subprocesses. That should be much more efficient if you have a lot of
> notes to write.

I'll try to make the components more generic and then glue them
together in C and make it use the APIs directly.

Thanks.

-- 
tejun
