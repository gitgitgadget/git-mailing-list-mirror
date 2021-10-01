Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FA461881
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhJASws (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhJASwr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 14:52:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF785C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 11:51:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s17so37330570edd.8
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+s46wQ3WtoSLv2U9n/IckWpfQQWi+ABZpKy/S18bP34=;
        b=fYRcYRxbI135mvNNZKD5zMbTLByyFpkuPQHFKjZdCFQOla4v4C3C/lHr5C+X1yIlDK
         Aw8+m/T+Y4LP+glUW3AtuhrJ0wQ8yVyJMNfqjgPVPhJXmXhgG/wD9Bwf0zlkT1BilRVO
         b9m7VXWRWQAXq0uUgbxngfT/9nz01vP3jIRIcoGGpNcqM1vGUJK/zlturL4jgCOIC14U
         m5l7NLXOEp4IMcf8VAtIjq/m/rGGwQN1MHKOj81B/z9GJZvEvXF/glT0P5bBRw+ROMf2
         l1iqlHy+HW0HaP8D4V9aA54fOwctbhPRJGSrnGYohkomvNmWNfbSe//7FcfcaNit1K7D
         PyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+s46wQ3WtoSLv2U9n/IckWpfQQWi+ABZpKy/S18bP34=;
        b=NAzLRM7Dh5VkDmAcEYDJ06Y5Y8zzdXW3+GdssBFymTaTrq3LDeMq3rnVKiGCjyWEKf
         YooYGrJ8zpjzr0OA0VjV36YjsnrhevTbtLv2VQZ6TrEJ9L+6vFsyI1oLbLtpTp74TeZW
         v7tIDoIjQkWe2oP9VCNiY0ZVO+P/xFwTukMs4w3n0PICFfR3IpoqqpedxusGnZ3EA3FC
         VaEOK/tV+CDYk2ZmR1vDif04CsnsFUaxNuEwQpw4b3X8RYfgIKBpbxFfYbRQxYa4scL7
         Zyssq9Oau3MgfkePDH9cIDn77I595syGoyJEY7n/tssxtX0Ti/KxMIf0Mumgs1ruB9SQ
         eP9w==
X-Gm-Message-State: AOAM5321GALK2aeOBncmjRBDloaAitrA3G8YM3IKRmi5mnS/enbcRETX
        0DdVFa+zV+S3muYN+fGG7++r4JqWJm3uIqsDjMZwfu9k
X-Google-Smtp-Source: ABdhPJw6eJapx89PkIkWSSnCzVsFKLfiPCYo7OrWUoKP428zeDOmx4AXaJaOrBZil+4u9Cg4yFJ7Q/XzdXn0H9hT1T4=
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr8224559ejb.253.1633114259742;
 Fri, 01 Oct 2021 11:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com> <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com> <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com> <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com>
In-Reply-To: <87k0ixrv23.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 11:50:48 -0700
Message-ID: <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to unpack_trees_options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 1, 2021 at 1:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Sep 30 2021, Elijah Newren wrote:
>
> > On Thu, Sep 30, 2021 at 7:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Wed, Sep 29 2021, Elijah Newren wrote:
> >>
> >> > On Wed, Sep 29, 2021 at 11:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> >> > <avarab@gmail.com> wrote:
> >> >>
> >> >> On Wed, Sep 29 2021, Elijah Newren wrote:
> >> >>
> > ...
> >> > As per the next patch:
> >> >
> >> > int unpack_trees(..., struct unpack_trees_options *o)
> >> > {
> >> >     struct dir_struct dir =3D DIR_INIT;
> >> >     ...
> >> >     if (!o->preserve_ignored) {
> >> >         /* Setup 'dir', make o->dir point to it */
> >> >         ....
> >> >         o->dir =3D &dir;
> >> >     }
> >> >     ...
> >> >     if (o->dir)
> >> >         /* cleanup */
> >> >     ....
> >> > }
> >> >
> >> > The caller doesn't touch o->dir (other than initializing it to zeros=
);
> >> > unpack_trees() is wholly responsible for it.  I'd kind of like to
> >> > entirely remove dir from unpack_trees_options(), but I need a way of
> >> > passing it down through all the other functions in unpack-trees.c, a=
nd
> >> > leaving it in unpack_trees_options seems the easiest way to do so.  =
So
> >> > I just marked it as "for internal use only".
> >>
> >> I think I understand *how* it works, I'm puzzled by why you went for
> >> this whole level of indirection when you're using a struct on the stac=
k
> >> in the end anyway, just ... put that in "struct unpack_trees_options"?
> >>
> >> Anyway, I see I have only myself to blame here, as you added these lea=
k
> >> fixes in the v2 in response to some of my offhand comments.
> >>
> >> FWIW I then went on to do some deeper fixes not just on these leaks bu=
t
> >> the surrounding leaks, which will be blocked by 2/11 & 05/11 of this
> >> topic for a while. I suppose I only have myself to blame :)
> >>
> >> Below is a patch-on-top that I think makes this whole thing much simpl=
er
> >> by doing away with the pointer entirely.
> >>
> >> I suppose this is also a partial reply to
> >> https://lore.kernel.org/git/CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbS=
EarLAmraA@mail.gmail.com/;
> >> but I quite dislike this pattern of including a pointer like this wher=
e
> >> it's not needed just for the practicalities of memory management.
> >>
> >> I.e. here you use DIR_INIT. In my local patches to fix up the wider
> >> memory leaks in this area I've got DIR_INIT also using a STRBUF_INIT,
> >> and DIR_INIT will in turn be referenced by a
> >> UNPACK_TREES_OPTIONS_INIT. It's quite nice if you're having to
> >> initialize with "UNPACK_TREES_OPTIONS_INIT" have that initialization
> >> work all the way down the chain, and not need e.g. a manual
> >> strbuf_init(), dir_init() etc.
> >
> > And you can keep using UNPACK_TREES_OPTIONS_INIT, because the
> > unpack_trees_opts->dir should be initialized to NULL.
>
> But I don't want it initialized to NULL, I want DIR_INIT....

Why?  For what purpose?  How does that help anything?  I've seen you
say that you want it, but I haven't yet seen you state how it helps
you do anything easier.

What I really want, though, is not even to have it be a pointer, but
to avoid exposing internal implementation details inside a struct that
is meant to convey the public API.  Instead unpack-trees should do
something similar to merge-ort, where it hides all those internal-only
details (by e.g. having a void* priv that happens to point to a struct
unpack_trees_options_internal, the latter of which is only defined in
unpack_trees.c).  However, I didn't want to go through that work for
just one member.

But you've inspired me to check if there are other fields that
shouldn't be exposed.  Turns out that there is a lot of cruft in
unpack_trees_options that callers shouldn't be messing with (and which
isn't at all clear to people trying to use the API): cache_bottom,
dir, msgs, msgs_to_free, nontrivial_merge, skip_sparse_checkout,
show_all_errors (!), unpack_rejects, df_conflict_entry, merge_size,
result, and perhaps pl.  A few of those have gotten slightly
entangled.  And there may have been others that people just started
setting because it was an existing field, and now I can't
differentiate between an intentional API usage passing some kind of
interesting value and an accidental setting of something meant to be
internal.

So maybe I'll submit some patches on top that rip these direct members
out of of unpack_trees_options and push them inside some opaque
struct.

> >> I removed the dir_init() in ce93a4c6127 (dir.[ch]: replace dir_init()
> >> with DIR_INIT, 2021-07-01),
> >
> > I might be going on a tangent here, but looking at that patch, I'm
> > worried that dir_init() was buggy and that you perpetuated that bug
> > with DIR_INIT.  Note that dir_struct has a struct strbuf basebuf
> > member, which neither dir_init() or DIR_INIT initialize properly
> > (using either strbuf_init() or STRBUF_INIT).  As far as I can tell,
> > dir.c relies on either strbuf_add() calls to just happen to work with
> > this incorrectly initialized strbuf, or else use the strbuf_init()
> > call in prep_exclude() to do so, using the following snippet:
> >
> >     if (!dir->basebuf.buf)
> >         strbuf_init(&dir->basebuf, PATH_MAX);
> >
> > However, earlier in that same function we see
> >
> >     if (stk->baselen <=3D baselen &&
> >         !strncmp(dir->basebuf.buf, base, stk->baselen))
> >             break;
> >
> > So either that function can never have dir->basebuf.buf be NULL and
> > the strbuf_init() is dead code, or else it's possible for us to
> > trigger a segfault.  If it's the former, it may just be a ticking time
> > bomb that will transform into the latter with some other change,
> > because it's not at all obvious to me how dir->basebuf gets
> > initialized appropriately to avoid that strncmp call.  Perhaps there
> > is some invariant where exclude_stack is only set up by previous calls
> > to prep_exclude() and those won't set up exclude_stack until first
> > initializing basebuf.  But that really at least deserves a comment
> > about how we're abusing basebuf, and would probably be cleaner if we
> > initialized basebuf to STRBUF_INIT.
>
> ...because yes, I forgot about that when sending you the diff-on-top,
> sorry. Yes that's buggy with the diff-on-top I sent you.

That bug didn't come from the diff-on-top you sent me, it came from
the commit already merged to master -- ce93a4c6127  (dir.[ch]: replace
dir_init() with DIR_INIT, 2021-07-01), merged as part of
ab/struct-init on Jul 16.

> I've got that fixed in the version I have. I.e. first I add a
> UNPACK_TREES_OPTIONS_INIT macro, then deal with that lazy initialization
> case (at which point DIR_INIT starts initializing that strbuf), then
> change the "dir_struct" from a pointer to embedding it, and finally fix
> a memory leak with that new API.
>
> WIP patches here:
> https://github.com/avar/git/compare/avar/post-sanitize-leak-test-mode-add=
-and-use-revisions-release...avar/post-sanitize-leak-test-mode-unpack-trees=
-and-dir

Yes, that fixes DIR_INIT nicely.  Looks good!

> >> but would probably need to bring it back, of
> >
> > If you need to bring it back, it's unrelated to my changes here, and
> > would only be because of the lack of basebuf initialization above.
>
> Yes, in this case. I mean that generally speaking I think it's a good
> pattern to use to have structs be initialized by macros like this,
> because it means you can embed them N levels deep (as we sometimes do)
> without having to call functions to initialize them.
>
> So yes, in this case as long as DIR_INIT is { 0 } it doesn't matter, but
> it does as soon as it has a member that needs initialization, and
> generally speaking for any FOO_INIT that needs a BAR_INIT ...

Callers SHOULD NOT call a function to initialize
unpacked_trees_opts->dir in my patches.  It's a ****BUG**** if they do
so.  So if you're complaining that my changes force callers to also
invoke some additional function, then I think you're just not
understanding my patch.

So, I still see no reason given for wanting opts->dir to be a struct.
But maybe we can fix this by just removing 'dir' (and several other
members) from opts, so that callers can't initialize it in any way to
anything.

> >> course you need some "release()" method for the
> >> UNPACK_TREES_OPTIONS_INIT, which in turn needs to call the dir_release=
()
> >> (well, "dir_clear()" in that case), and it needs to call
> >> "strbuf_release()". It's just nicer if that boilerplate is all on
> >> destruction, but not also on struct/object setup.
> >
> > The caller should *not* be initializing or tearing down
> > unpack_trees_options->dir beyond setting that field to NULL; it should
> > then leave it alone.
>
> s/NULL/DIR_INIT/ in my version, but yes.
>
> >> We do need that setup in some cases (although a lot could just be
> >> replaced by lazy initialization), but if we don't....
> >>
> >> diff --git a/unpack-trees.c b/unpack-trees.c
> >> index a7e1712d236..de5cc6cd025 100644
> >> --- a/unpack-trees.c
> >> +++ b/unpack-trees.c
> >> @@ -1694,15 +1694,12 @@ int unpack_trees(unsigned len, struct tree_des=
c *t, struct unpack_trees_options
> >>         static struct cache_entry *dfc;
> >>         struct pattern_list pl;
> >>         int free_pattern_list =3D 0;
> >> -       struct dir_struct dir =3D DIR_INIT;
> >>
> >>         if (o->reset =3D=3D UNPACK_RESET_INVALID)
> >>                 BUG("o->reset had a value of 1; should be UNPACK_TREES=
_*_UNTRACKED");
> >>
> >>         if (len > MAX_UNPACK_TREES)
> >>                 die("unpack_trees takes at most %d trees", MAX_UNPACK_=
TREES);
> >> -       if (o->dir)
> >> -               BUG("o->dir is for internal use only");
> >
> > I think this was an important check that you've tossed without
> > replacement.  Historically, callers set up and tweaked o->dir with
> > various values.  With my patch, we are no longer allowing that..which
> > introduces a transition problem -- people might have written or are
> > now writing patches that make new calls of unpack_trees() previous to
> > this change of mine, but submit them after this change of mine gets
> > merged.  Without this check I added, they'd probably just do a
> > mechanical `o->dir->` change to `o->dir.` and assume it's good...and
> > then possibly have ugly bugs to hunt down.
> >
> > So, I think it's helpful to have a check that provides an early
> > warning that tweaking o->dir is not only no longer required, but also
> > no longer allowed.
>
> The compiler will catch any such use of the pointer version on a
> mis-merge, or do you just mean that the person running into that might
> get the resolution wrong? I.e. before we could check o->dir being NULL
> for "do we have an exclude", but &o->dir will always be true?

The compiler catches and reports, and then the human sees the error
and just transliterates "o->dir->" to "o->dir.".  And then it
compiles, and the person assumes they fixed it correctly, but the
transliteration was WRONG and has subtle bugs because they had been
setting up o->dir with special values and something needs to warn them
that they shouldn't be touching o->dir anymore.  You removed the
safety check that would have let them know that their straightforward
transliteration was wrong.  I added that safety check intentionally,
and don't like seeing it ripped out without a replacement.

> >>         trace_performance_enter();
> >>         trace2_region_enter("unpack_trees", "unpack_trees", the_reposi=
tory);
> >> @@ -1718,9 +1715,8 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
> >>                 BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible wit=
h preserved ignored files");
> >>
> >>         if (!o->preserve_ignored) {
> >> -               o->dir =3D &dir;
> >> -               o->dir->flags |=3D DIR_SHOW_IGNORED;
> >> -               setup_standard_excludes(o->dir);
> >> +               o->dir.flags |=3D DIR_SHOW_IGNORED;
> >> +               setup_standard_excludes(&o->dir);
> >>         }
> >>
> >>         if (!core_apply_sparse_checkout || !o->update)
> >> @@ -1884,10 +1880,7 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
> >>  done:
> >>         if (free_pattern_list)
> >>                 clear_pattern_list(&pl);
> >> -       if (o->dir) {
> >> -               dir_clear(o->dir);
> >> -               o->dir =3D NULL;
> >> -       }
> >> +       dir_clear(&o->dir);
> >
> > Unconditionally calling dir_clear()...
>
> As before I'm not sure about bugs in the ad-hoc patch on top, but I
> don't think this is a bug in my version linked above.
>
> I.e. it's zero'd out, and the dir_clear() either ends up calling
> free(NULL) or tries to loop over 0..N where N will be 0, no?
>
> >>         trace2_region_leave("unpack_trees", "unpack_trees", the_reposi=
tory);
> >>         trace_performance_leave("unpack_trees");
> >>         return ret;
> >> @@ -2153,8 +2146,7 @@ static int verify_clean_subdirectory(const struc=
t cache_entry *ce,
> >>         pathbuf =3D xstrfmt("%.*s/", namelen, ce->name);
> >>
> >>         memset(&d, 0, sizeof(d));
> >> -       if (o->dir)
> >> -               d.exclude_per_dir =3D o->dir->exclude_per_dir;
> >> +       d.exclude_per_dir =3D o->dir.exclude_per_dir;
> >>         i =3D read_directory(&d, o->src_index, pathbuf, namelen+1, NUL=
L);
> >>         if (i)
> >>                 return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce=
->name);
> >> @@ -2201,8 +2193,7 @@ static int check_ok_to_remove(const char *name, =
int len, int dtype,
> >>         if (ignore_case && icase_exists(o, name, len, st))
> >>                 return 0;
> >>
> >> -       if (o->dir &&
> >> -           is_excluded(o->dir, o->src_index, name, &dtype))
> >> +       if (is_excluded(&o->dir, o->src_index, name, &dtype))
> >
> > Unconditionally calling is_excluded()...
>
> Which will just return "it's not", won't it? Just lik dir_clear() deals
> with an "empty" dir_struct. There's existing callers of both with that
> pattern in e.g. builtin/{add,clean}.c.

That's a question that someone writing this patch should investigate
and document.  I read through is_excluded() and the functions it
calls, and I _think_ it's possibly correct in the current code.  But
it's not trivial to verify.  And I'd look a bit closer at it to be
sure it's correct before making this change.

Yeah, I'm being pretty picky here, but this is dir.c we are dealing with.

> Maybe I've missed an edge case, but I think the only reason that "o->dir
> &&" was there was because it was dynamically malloc'd before, but in my
> version where we'll always have it initialized...

I think after checking the code to verify this, that it deserves being
mentioned in the commit message (at least given that this is dir.c
we're talking about).

> >>                 /*
> >>                  * ce->name is explicitly excluded, so it is Ok to
> >>                  * overwrite it.
> >> diff --git a/unpack-trees.h b/unpack-trees.h
> >> index 71ffb7eeb0c..a8afbb20170 100644
> >> --- a/unpack-trees.h
> >> +++ b/unpack-trees.h
> >> @@ -5,6 +5,7 @@
> >>  #include "strvec.h"
> >>  #include "string-list.h"
> >>  #include "tree-walk.h"
> >> +#include "dir.h"
> >>
> >>  #define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
> >>
> >> @@ -95,7 +96,7 @@ struct unpack_trees_options {
> >>         struct index_state result;
> >>
> >>         struct pattern_list *pl; /* for internal use */
> >> -       struct dir_struct *dir; /* for internal use only */
> >> +       struct dir_struct dir; /* for internal use only */
> >>         struct checkout_metadata meta;
> >>  };
> >>
> >
> > Not only did you drop the important safety check that o->dir not be
> > setup by the caller (which needs to be reinstated in some form), your
> > solution also involves unconditionally calling dir_clear() and
> > is_excluded().  It is not clear to me that those calls are safe...and
> > that they will continue to be safe in the future.
>
> It is a common pattern we rely on, e.g. strbuf_release() and various
> other custom free-like functions generally act as NOOP if they've got
> nothing to do, just like free()...

Yeah, "common pattern" is a useful way to want things to behave, and
people assuming that in other parts of git's codebase is probably
fine, but I don't trust dir.c to already behave according to common
patterns.  My mistrust of it is deep enough that I think someone
should verify the relevant parts of dir.c do behave that way before
making changes like this, and then explicitly call it out in the
commit message when the change is made.  dir.c had some weird dragons
in it.  And after being repeatedly sucked back into dir.c problems for
years because of weird side effects, and seeing how many piles of
nearly-cancelling bugs it had, I don't trust it anymore.

> > Even if it is safe
> > and will continue to be, I don't think this should be squashed into my
> > patches.  I think it should be a separate patch with its own commit
> > message that explicitly calls out this assumption.  Especially since
> > this is dir.c, which is an area where attempting to fix one very
> > simple little bug results in years of refactoring and fixing all kinds
> > of historical messes, sometimes waiting a year and a half for
> > responses to RFCs/review requests, and where we have to sometimes just
> > give up on attempting to understand the purpose of various bits of
> > code and instead rely on the regression tests and hope they are good
> > enough.  I still think that dir.c deserves a little warning at the
> > top, like the one I suggested in [1].
> >
> > [1] https://lore.kernel.org/git/CABPp-BFiwzzUgiTj_zu+vF5x20L0=3D1cf25cH=
wk7KZQj2YkVzXw@mail.gmail.com/
>
> *nod* I can always submit something like this afterwards.

:-)

> Just on this series: Perhaps this discussion is a sign that this memory
> leak fixing should be its own cleanup series where we could hash out any
> approaches to doing that? I.e. as noted before I realize I'm to blame
> for suggesting it in the first place, but those parts of these changes
> don't seem like they're needed by other parts of the series (I tried
> compiling with the two relevant patches ejected out).
>
> Having a humongous set of memory leak fixes locally at this point, I
> think it's generally not very worth the effort to fix a leak in b()
> where a() calls b() and b() calls c(), and all of [abc]() are
> leaking. I.e. often narrowly fixing leaks in b() will lead to different
> solutions than if you're trying to resolve all of [abc](), as their
> interaction comes into play.

The patch we are commenting on isn't a leakfix, and is very much
integral to the series for reasons other than actual leakfix (which
occurred two patches before this one).  It's simplifying the API to
not require a bunch of boilerplate setup of opts->dir and instead
requiring callers to just set a simple boolean INSTEAD (and only if
they want non-default behavior, rather than requiring setting
opts->dir by all those who did want default behavior).  That way, when
I need to make sure several additional callers who should have gotten
the default behavior actually get it, they don't have to call a bunch
of functions to setup and cleanup opts->dir.

> Aside about safety: One thing I'll sometimes do when I'm unsure about
> those sorts of fixes is to have my new INIT set a new "sentinel" field
> to "12345" or whatever, then just BUG() out in an entry point in the API
> that you can't avoid calling if it's not set like that, e.g. dir_clear()
> or whatever the setup/work function is.
>
> We don't have 100% test coverage, but we usually have at least *some*,
> and doing that is good about catching e.g. a memset() at a distance, as
> happens in this code with the merge code embedding the relevant struct
> and memsetting it, which might be missed in some migration of just a
> grep for "struct dir_struct" or whatever...
