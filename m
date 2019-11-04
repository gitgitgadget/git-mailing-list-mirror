Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7F31F454
	for <e@80x24.org>; Mon,  4 Nov 2019 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKDQEg (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 11:04:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43990 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 11:04:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so7324474ljh.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2N7KudSWFkJTcd3U9sWmn92HZHFP7E+mPz3RLrKCRA=;
        b=X0hKgVZkWV7TA39i4jbH2ndUj1ojhEYjn/S7U93Aj7wtnf1Rl+9zVAilK/tM5Yh2ea
         dtWPlycRT95zV5yu5CntSAihj3MFmG7Nm8wGQMNR66wgL2W7XH7oghIk9sqNa905PnIu
         x+GpSCCjURzVtUktr9w7NBJZ8QWchwC6vdoBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2N7KudSWFkJTcd3U9sWmn92HZHFP7E+mPz3RLrKCRA=;
        b=S3aQgOkpXqqIp/o9Pr5EHPjSc0KBkDznd8Lb4DjMJFfUuJGR4kOe7k450cuYq3YPtm
         /dF64VNkGaOxZpzxuzy18WBkDYU1DWOIoi8l6rSiUo3MG9mOyVOVKeZC2SE6EgjCl1K2
         sIpfcY+pqDiE9n3S1uQMdIfN9bpLDG+Xb27o6yJvpf33Ll32tkoMHcZzQj1yRapETb6F
         1eEVL+dO8ZVKXe6JKUUhw7uhcNppcrVJIrHDxOI/fDuFOdklN/eEu4yihteN4UFTLPuJ
         yhYj+XgVWG6ykP3DufOxXhCggNe2xBkM5T2EeGXlD/G2fx9xVK7WK0PU4r6tptSLjAAh
         JpTA==
X-Gm-Message-State: APjAAAWfedCGVX9CA/jtxCMmwyLQRklqkmmGHaNzf6UZFEs5B7uZqu6A
        kuj6+cARs6qpS0NcfmYbxrNcltpfH7TNh05EbYzZpvpGyf6+UA==
X-Google-Smtp-Source: APXvYqz9Qjx2SCcOlrIfry3fhgz2O6h5Z5407aNXQ8uX11ZsHHRBWhBHn6jWGdRcGRvcIrMx/KLUtR/gYeDAMnji2Ig=
X-Received: by 2002:a2e:575c:: with SMTP id r28mr19004596ljd.245.1572883468079;
 Mon, 04 Nov 2019 08:04:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <0190f6f2f978a674a29a1e2013d00bc289851c76.1572418123.git.gitgitgadget@gmail.com>
 <20191103074453.56ubga6eitjhp6rf@yadavpratyush.com>
In-Reply-To: <20191103074453.56ubga6eitjhp6rf@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Mon, 4 Nov 2019 10:04:16 -0600
Message-ID: <CAPSOpYsBLe+M+6xP0zdT4fY=K4poFCH_yr3-W7e_dCnG9OhhhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: revert untracked files by deleting them
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 3, 2019 at 1:48 AM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> Hi Jonathan,
>
> Thanks for the quality re-roll. It was a pleasant read :)
>
> I would have suggested just handing off the paths to `git clean`, but it
> unfortunately does not do what we want it to do.
>
> Say we have a directory 'foo' which has one file called 'bar.txt'. That
> file is untracked. Now, I expected `git clean -fd foo/bar.txt` to delete
> 'bar.txt' _and_ 'foo/', but it only deletes bar.txt, and leaves 'foo/'
> intact. What's worse is that since 'foo' is an empty directory, it
> doesn't appear in git-status anymore, and so there is no way the user
> can tell the directory exists unless they go there and do a `ls`.
>
> Maybe something to fix upstream?

Possibly, but I think the implications of such a change in the core
tool are far greater than UI features in Git Gui.

> On 30/10/19 06:48AM, Jonathan Gilbert via GitGitGadget wrote:
> > From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> >
> > Updates the revert_helper procedure to also detect untracked files. If
>
> Typo: s/Updates/Update/ ?

It wasn't a typo, I wrote it as an abbreviated form of basically "This
change updates the revert_helper procedure to ...". But, if that
choice of linguistic construct goes against convention I can change
it. :-)

> > +     # The index is now locked. Some of the paths below include calls that
> > +     # unlock the index (e.g. checked_index). If we reach the end and the
>
> Typo: s/checked_index/checkout_index/

Fixed. :-)

> > +     if {$need_unlock_index} { unlock_index }
>
> Are you sure you want to unlock the index _before_ the cleanup of
> untracked files is done? While it makes sense to unlock the index since
> our "clean" operation would only touch the working tree, and not the
> index, it would also mean people can do things like "Revert hunk" (from
> the context menu). Right now, this operation can not be done on
> untracked files (so this won't be a problem for now), but I do plan on
> adding this in the future, and it wouldn't be obvious from that patch's
> POV that this could be an issue. If someone does a "Revert hunk" on a
> while that is queued for deletion, there might be problems.
>
> Also, would doing an `unlock_index` early allow people to run multiple
> "clean" jobs at the same time? Will that create race conditions that we
> aren't ready to handle?
>
> It also makes sense to evaluate what the downsides of keeping the index
> locked are. So, does keeping the index locked prevent meaningful usage
> of git-gui, making your batched deletion pointless? Is there some reason
> for unlocking it early that I'm missing?
>
> If we do decide keeping the index locked is a good idea, it would be
> troublesome to implement. `checkout_index` is asynchronous. So, when it
> returns, the index won't necessarily be unlocked. It would get unlocked
> some time _after_ the return. I'm not sure how to work around this.

Yeah, when I wrote this I was looking at the fact that the locking of
the index, on the surface, only seems to interact with Git working
copy operations, and as you mention the fact that both tails of the
function (`checkout_index` and `delete_files`) operate asynchronously
means that figuring out _when_ to unlock the index is a bit tricky.
But, based on what you've written I understand that locking the index
also disables UI interaction while it's locked, and that may be
desirable, so we probably do want to keep it locked until both
operations are complete.

What we need here is something I have seen referred to as a "chord" --
conceptually, a function with multiple entrypoints that get called
from different threads, and then the body of the function runs only
when all "notes" on the "chord" have been activated. So in this case,
an object that has one entry-point for "the checkout is complete" and
one entry-point for "the deletion is complete". The body of the
function is `unlock_index`, and then the two asynchronous functions
both call into their "note" on the "chord" instead of directly calling
`unlock_index`. This would mean that the `_close_updateindex` call
that `checkout_index` ultimately drills down to would have to, in some
circumstances, _not_ unlock the index itself. I'll take a hack at this
and see what transpires. :-)

> > +             if {$deletion_failed} {
> > +                     lappend deletion_errors $deletion_error
> > +
> > +                     # Optimistically capture the path that failed, in case
> > +                     # there's only one.
> > +                     set deletion_error_path $path
>
> I don't see why you would do this for _only_ one path. Either do it for
> every path. And since you're recording errors for each path, it makes
> sense to record the corresponding path too. Or, just count how many
> paths failed, and report that. I don't see why we'd want to be between
> those two.
[..]
> > +             } elseif {$deletion_error_cnt == $path_cnt} {
> > +                     error_popup [mc \
> > +                             "None of the selected files could be deleted." \
> > +                             ]
> > +             } elseif {$deletion_error_cnt > 1} {
> > +                     error_popup [mc \
> > +                             "%d of the selected files could not be deleted." \
> > +                             $deletion_error_cnt]
> > +             }
>
> The same comment as above applies here: either show error messages for
> all paths, or for none. I don't see why you want to make a single error
> path a special case.

Consistency -- the prompt that asks whether you want to do a revert
(checkout) or deletion (clean) in the first place has the same split,
where if only one file matches, it identifies the file, but if
multiple files match, it shows the number. For consistency with that,
I used the same logic in the error handling path.

> > -                     [concat $after [list ui_ready]]
> > +                     $path_index \
> > +                     $deletion_errors \
> > +                     $deletion_error_path \
> > +                     $batch_size \
> > +                     ]]
>
> Using `after idle` means in theory we put an undefined maximum time
> limit on the deletion process. Though I suspect in real life it would be
> a pretty short time.
>
> Nonetheless, should you instead do this asynchronously, instead of
> waiting for the event loop to enter an idle state? This means using
> `after 0` directly, instead of doing `after idle [list after 0...`. I
> haven't tested it, but AFAIK this should also keep the UI active while
> not depending on the state of the event loop.
>
> What benefits does your way have over just passing the entire list
> (without batching) to an async script to do processing in the
> background?

I'm not familiar with async scripts, I'm pretty new to Tcl. Is that
basically a mechanism like threads? I wrote the batching simply
because doing the call synchronously meant that if thousands of files
were selected, the UI would freeze hard for several seconds and that
seemed like a bad experience. If there's a better way to delete
thousands of files while keeping the UI responsive and providing
feedback, that'd make more sense, but I don't know how to do it :-)

> > +# This function is from the TCL documentation:
> > +#
> > +#   https://wiki.tcl-lang.org/page/file+exists
>
> Why include the link? My guess is "to give proper credit". Do I guess
> correctly?

Actually it's more to say, "If you're reading through this code and
the specific nuances of this procedure aren't obvious, here's the
procedure's origin. I believe it to be a reliable source, so if that's
good enough for you too, then you don't need to concern yourself with
the implementation details, you can just trust that somebody else put
time into the definition of this above and beyond the scope of the
change where I'm using it." :-)

> > +# [file exists] returns false if the path does exist but is a symlink to a path
> > +# that doesn't exist. This proc returns true if the path exists, regardless of
> > +# whether it is a symlink and whether it is broken.
> > +proc lexists name {
>
> Nitpick: wrap the "name" in braces like:
>
>   proc lexists {name} {
>
> Also, maybe re-name it to 'path_exists'? 'lexists' is not very intuitive
> unless being used _specifically_ in the context of links. Its _use_ is
> in context of paths, even though it is used to work around links.

I can make those changes. I had initially copy/pasted it with no
changes at all, so that, in the context of the preceding explanation,
a future reader could easily verify that, "Yes, this really is exactly
the same procedure definition." :-)

> > +# Remove as many empty directories as we can starting at the specified path.
>
> Nitpick: maybe change it to something like this?
>
>   Remove as many empty directories as we can starting at the specified
>   path, going up in the directory tree.
>
> It was not obvious to me from reading the comment that you were going up
> the directory tree. I thought you were going across the breadth of the
> directory, and was puzzled why you'd do that.
>
> But maybe that's just me. So, I don't mind if you keep it the way it is
> either.

That's legitimate :-) I knew exactly what the function did _before_ I
wrote the comment, after all.

Let me know about those few things, and I'll send in another iteration:

* Is it preferable to use imperative rather than third person singular
in commit messages? ("[I] make the change" vs. "[It] makes the
change")
* Should I simplify the error messages, rather than having parity with
the prompts w.r.t. one vs. multiple items?
* Async scripts for longer background operations, rather than batching
on the UI thread? Can they post ongoing status updates too?
* Should I modify `lexists` to fit the file's conventions, or keep it
an exact copy/paste from the external source?

Thanks very much,

Jonathan Gilbert
