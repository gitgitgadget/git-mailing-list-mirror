Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28FFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 03:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD57460FC0
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 03:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbhJADN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJADN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 23:13:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E267C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 20:12:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba1so29517074edb.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xowvDQ7yvcVtJ2nXgismN34lTJQh3dTACuTOREknfas=;
        b=Z/MFo+4ihI8jJgkyCuBG9X7gVOYX6ucIsDDQTyAOn50pH44UiwgVSH1jiIVrwTO998
         LHAVpErD16GDTFm9Mb5xWe7Cb7AkCESzCmr19rQQywWnCy0o3NQK4j75dq3dOgMT2p+2
         ivq3RE10hbZ250M3lEOwg2MZOYdwgHoMhFA9lXKkwCLAqqkuk0Fdbx2bZEAsx5CBD7Ht
         4hT6F5bMrxvKSqpFM+C+WNt+k3Eq0pWn4fXz5XZGibuW3AhJkN88acN6d+R5aV2XtqQu
         zPnfcBycyw3VwsdCNLD+MQIW3g154KZzrE77pc+IJcLBsGUpHDvpenOh2DVdMmYZ4m77
         GMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xowvDQ7yvcVtJ2nXgismN34lTJQh3dTACuTOREknfas=;
        b=Bgja9PsxI7OPp3uPIGN66jgPUCMa5ZtBXEW1jfCkqRSuuVQzhJwhXHrYP2dAqOMAGq
         6rX9RhOm8PhHdHASi/dYLAmUYTf8ArLYuexlAWgMkG5ZDPSkB8rHC85mSb5pj4gTsNvP
         j3JWuWKgI92d8dPpUBarSpkJy6ccMkpcuYTec8NfxzXpIri6xV2nx7vlS4Kz2zYlOEh4
         ZQLdnkMP27QfWs34i9pLpPpwKK4DiF6TtqAovI6J3ANFJNQWXir+w2Bp44qPMmTmuA+z
         PzikbupXFxrSiFyTmwQemj2OVmm75DxZtaJS3kpyxIzV8BMLaX+4CyF2xJg//xRG8euq
         edLQ==
X-Gm-Message-State: AOAM5306zyWPCT7EGBRwlQQlPuJqH3qNMbAzYMUlANZwPAC6+OuXruU7
        6D7Rk4XQYgUhG3PKaGARpQOHjTOUNyo6Mvj28BBgO2M82To=
X-Google-Smtp-Source: ABdhPJxC/XeuOwVBzrnDTNI2ly7snWBDT+u1pcvHN90S9ACeIL+TkavtWdX4ZBNs1fnTjxXrp8ji3f4VqfpaXAvzHoU=
X-Received: by 2002:a50:be82:: with SMTP id b2mr11432878edk.56.1633057931555;
 Thu, 30 Sep 2021 20:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <xmqqsfxof2hr.fsf@gitster.g>
 <YVVoXJo3DlPQd1A3@coredump.intra.peff.net> <87tui2tckn.fsf@evledraar.gmail.com>
In-Reply-To: <87tui2tckn.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 20:11:59 -0700
Message-ID: <CABPp-BGsjq3ts4A6wKLYcopD9rknM+LXXi8qR_SLEpmU+x7KNQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 6:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Sep 30 2021, Jeff King wrote:
>
> > On Tue, Sep 28, 2021 at 09:08:00PM -0700, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >>
> >> >   Side note: The pretend_object_file() approach is actually even bet=
ter,
> >> >   because we know the object is fake. So it does not confuse
> >> >   write_object_file()'s "do we already have this object" freshening
> >> >   check.
> >> >
> >> >   I suspect it could even be made faster than the tmp_objdir approac=
h.
> >> >   From our perspective, these objects really are tempfiles. So we co=
uld
> >> >   write them as such, not worrying about things like fsyncing them,
> >> >   naming them into place, etc. We could just write them out, then mm=
ap
> >> >   the results, and put the pointers into cached_objects (currently i=
t
> >> >   insists on malloc-ing a copy of the input buffer, but that seems l=
ike
> >> >   an easy extension to add).
> >> >
> >> >   In fact, I think you could get away with just _one_ tempfile per
> >> >   merge. Open up one tempfile. Write out all of the objects you want=
 to
> >> >   "store" into it in sequence, and record the lseek() offsets before=
 and
> >> >   after for each object. Then mmap the whole result, and stuff the
> >> >   appropriate pointers (based on arithmetic with the offsets) into t=
he
> >> >   cached_objects list.
> >>
> >> Cute.  The remerge diff code path creates a full tree that records
> >> the mechanical merge result.  By hooking into the lowest layer of
> >> write_object() interface, we'd serialize all objects in such a tree
> >> in the order they are computed (bottom up from the leaf level, I'd
> >> presume) into a single flat file ;-)
> >
> > I do still like this approach, but just two possible gotchas I was
> > thinking of:
> >
> >  - This side-steps all of our usual code for getting object data into
> >    memory. In general, I'd expect this content to not be too enormous,
> >    but it _could_ be if there are many / large blobs in the result. So
> >    we may end up with large maps. Probably not a big deal on modern
> >    64-bit systems. Maybe an issue on 32-bit systems, just because of
> >    virtual address space.
> >
> >    Likewise, we do support systems with NO_MMAP. They'd work here, but
> >    it would probably mean putting all that object data into the heap. I
> >    could live with that, given how rare such systems are these days, an=
d
> >    that it only matters if you're using --remerge-diff with big blobs.
> >
> >  - I wonder to what degree --remerge-diff benefits from omitting writes
> >    for objects we already have. I.e., if you are writing out a whole
> >    tree representing the conflicted state, then you don't want to write
> >    all of the trees that aren't interesting. Hopefully the code is
> >    already figuring out which paths the merge even touched, and ignorin=
g
> >    the rest. It probably benefits performance-wise from
> >    write_object_file() deciding to skip some object writes, as well
> >    (e.g., for resolutions which the final tree already took, as they'd
> >    be in the merge commit). The whole pretend-we-have-this-object thing
> >    may want to likewise make sure we don't write out objects that we
> >    already have in the real odb.
>
> I haven't benchmarked since my core.checkCollisions RFC patch[1]
> resulted in the somewhat related loose object cache patch from you, and
> not with something like the midx, but just a note that on some setups
> just writing things out is faster than exhaustively checking if we
> absolutely need to write things out.
>
> I also wonder how much if anything writing out the one file v.s. lots of
> loose objects is worthwhile on systems where we could write out those
> loose objects on a ramdisk, which is commonly available on e.g. Linux
> distros these days out of the box. If you care about performance but not
> about your transitory data using a ramdisk is generally much better than
> any other potential I/O optimization.
>
> Finally, and I don't mean to throw a monkey wrench into this whole
> discussion, so take this as a random musing: I wonder how much faster
> this thing could be on its second run if instead of avoiding writing to
> the store & cleaning up, it just wrote to the store, and then wrote

It'd be _much_ slower.  My first implementation in fact did that; it
just wrote objects to the store, left them there, and didn't bother to
do any auto-gcs.  It slowed down quite a bit as it ran.  Adding
auto-gc's during the run were really slow too. But stepping back,
gc'ing objects that I already knew were garbage seemed like a waste;
why not just prune them pre-emptively?  To do so, though, I'd have to
track all the individual objects I added to make sure I didn't prune
something else.  Following that idea and a few different attempts
eventually led me to the discovery of tmp_objdir.

In case it's not clear to you why just writing all the objects to the
normal store and leaving them there slows things down so much...

Let's say 1 in 10 merges had originally needed some kind of conflict
resolution (either in the outer merge or in the inner merge for the
virtual merge bases), meaning that 9 out of 10 merges traversed by
--remerge-diff don't write any objects.  Now for each merge for which
--remerge-diff does need to create conflicted blobs and new trees,
let's say it writes on average 3 blobs and 7 trees.  (I don't know the
real average numbers, it could well be ~5 total, but ~10 seems a
realistic first order approximation and it makes the math easy.)
Then, if we keep all objects we write, then `git log --remerge-diff`
on a history with 100,000 merge commits, will have added 100,000 loose
objects by the time it finishes.  That means that all diff and merge
operations slow down considerably as it runs due to all the extra
loose objects.

> another object keyed on the git version and any revision paramaters
> etc., and then pretty much just had to do a "git cat-file -p <that-obj>"
> to present the result to the user :)

So caching the full `git log ...` output, based on a hash of the
command line flags, and then merely re-showing it later?  And having
that output be invalidated as soon as any head advances?  Or are you
thinking of caching the output per-commit based on a hash of the other
command line flags...potentially slowing non-log operations down with
the huge number of loose objects?

> I suppose that would be throwing a lot more work at an eventual "git gc"
> than we ever do now, so maybe it's a bit crazy, but I think it might be
> an interesting direction in general to (ab)use either the primary or
> some secondary store in the .git dir as a semi-permanent cache of
> resolved queries from the likes of "git log".

If you do per-commit caching, and the user scrolls through enough
output (not hard to do, just searching the output for some string
often is enough), that "eventual" git-gc will be the very next git
operation.  If you cache the entire output, it'll be invalidated
pretty quickly.  So I don't see how this works.  Or am I
misunderstanding something you're suggesting here?
