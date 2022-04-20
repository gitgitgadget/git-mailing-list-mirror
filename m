Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6FC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377993AbiDTLN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiDTLN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 07:13:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B38B3E5C4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 04:10:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l7so2826349ejn.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BMlminj38rLWFTaFUCtkz+0H+AsWRsqGQDUGi86IMA=;
        b=BAtSQZ8CMQLmoT/tb1SqHGdpdV1UvGjFyPw4a4HHHqa4D8H/nsvibvi5tYLEf1Dk9N
         mIJ1QAsQYoE3D6FSiIEWCkUwAKJI3fgucYerRf9fllVBfKnJPrGBnBV4OLCOp38RlETe
         Ki4h82z9c+5aqhPbsdXK/yepgfo7CvlqZP1Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BMlminj38rLWFTaFUCtkz+0H+AsWRsqGQDUGi86IMA=;
        b=qiC1RdEiDYfKH2/zFyGnbg4xkHyM6O9X6A9x4wSeyRVM8d8MH+bhbiiSIhfjE6B3wp
         XRPPzUhD8fqxe8r9rQKgZKQm7/6cz0tNFNLEqLdrFngVyGDXjKhGpA+f769lFw6U+hpq
         T95HK849z25lWOYUd/fTlzk5FpckfQ5rnOA2yQRkJTNiOQtrYdniNun698V+0lGBRWt8
         aQhXpKAAnTu+oduQkg9iOWvFnJw2AdLfizZ28wVVnLlzzDt4qNroFrV9zqXw1HxrhJrX
         CJtQirF9osvw6QJUhMZBQ4wxq4rp6T+DtQQMeoM9qyEanIw0g9PdKf3gcaw9MQllbp1q
         C7Sg==
X-Gm-Message-State: AOAM532o05h5/A9nMvNE+NN35Sdldo4/kGMDgcLD7iYKHJrZPBpimqH/
        Q4clBb+1xmtGQDKu8iol5meQMI8n/ISH24vvVJHoug==
X-Google-Smtp-Source: ABdhPJzs4x5MFmWf9XYu7VEGS82cIAGyutD0Kv9oUwFDgylXPl58Qtam9FKD4KNaBu8YHyB5NOyPO4KhsOIAZRYQf4w=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr18333714ejw.487.1650453038431; Wed, 20
 Apr 2022 04:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
 <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com>
In-Reply-To: <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 20 Apr 2022 13:10:26 +0200
Message-ID: <CAPMMpoj_aZTgiviv0OBYb-SwhgL9oecbBYkS9LQjcTf0cPmABg@mail.gmail.com>
Subject: Re: Unexpected conflict with ort merge strategy?
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for resurrecting such an old thread, and thanks again for your
detailed response last year.

On Thu, Nov 11, 2021 at 6:57 PM Elijah Newren <newren@gmail.com> wrote:
>
> Sorry for the late response...
>
> On Tue, Oct 19, 2021 at 3:44 PM Tao Klerks <tao@klerks.biz> wrote:
> >
> > Hi folks,
> >
> > I just came across a situation where the ort merge strategy chooses a
> > "worse" rename mapping than the recursive strategy - worse in the
> > sense of having a lower similarity score, worse in the sense of having
> > been a change in another commit (but I guess this is just a limitation
> > of git merge? It doesn't look for renames "iteratively" through
> > history when merging?), and finally worse in the sense of causing a
> > merge conflict that, given the previous two points, is unnecessary and
> > does not occur with recursive.
> >
> >
> > I've prepared a reproduction script, attached. It's probably a little
> > convoluted because I didn't know exactly what to look out for. This is
> > an extreme simplification of a real-life incident:
> >
> > One file (folder1/firstfile.txt) is deleted independently in two
> > branches, and another somewhat-similar file (folder2/secondfile.txt)
> > is renamed (to folder2/secondfile_renamed.txt) and slightly modified
> > in one of them (in another commit).
> >
> > When the branch with the rename gets merged in to the branch that just
> > had the delete, "ort" sees the rename as having been of
> > "folder1/firstfile.txt" to "folder2/secondfile_renamed.txt", despite
> > this being of a lower similarity than the real rename that happened,
> > and a conflict ensues.
>
> Very interesting case; thanks for passing it along.  I thought Junio
> had brought up this case while reviewing patches several months back
> and we discussed it, but I can't find it right now.  The short answer
> is that yes there's a difference in behavior, but no bug.  I'll
> summarize and provide a 'TAKEAWAY' in the final paragraph, but there's
> lots of nuance here that probably deserves explaining for the curious.
>
> WARNING: lengthy details follow; skip to final paragraph of the whole
> email if you want to skim
>
>
> So, I'm assuming you're curious about why there's no bug despite a
> difference in behavior.  So, let me explain (a) the crux of your
> testcase -- what's happening and why, (b) similar-ish cases with
> behavioral changes that were explicitly discussed and documented in
> the past year (for BOTH merge-ort and merge-recursive), (c) some
> similar cases not discussed and documented, and for which the
> recursive backend gives a "worse" answer according to what you
> suggested "worse" meant, and (d) some warning/advice for folks dealing
> with multiple files/directories whose contents are quite similar.
>
> === (a) what's happening and why ===
>
> In your testcase, you can drop all files other than
>   * folder1/firstfile.txt
>   * folder2/secondfile.txt
>   * folder2/secondfile_renamed.txt
> and any commits not touching those files can be dropped.  In simpler
> terms, your testcase is:
>   * Merge base: Has both folder1/firstfile.txt and folder2/secondfile.txt
>   * feature branch: delete folder1/firstfile.txt
>   * master branch: delete both folder1/firstfile.txt and
> folder2/secondfile.txt, introduce folder2/secondfile_renamed.txt which
> is very similar to both deleted files, but more so to the latter
> If you're thinking my description of the master branch is funny (as
> per your wording, you renamed folder2/secondfile.txt to
> folder2/secondfile_renamed.txt), remember that git doesn't track
> renames.

I actually disagree with this as a simplification of my testcase. In
my testcase, the deletion of "folder2/secondfile.txt" and introduction
of "folder2/secondfile_renamed.txt", the "high-percentage rename" as I
call it, is *separate* from the deletion of "folder1/firstfile.txt".

I can understand how any given algorithm might choose to gloss over
that fact, but it has very clear significance in my testcase.
Obviously I'm not talking about the "_renamed" suffix, but rather the
fact that in the *individual* commit, rename detection will 100%
correctly/reliably detect this as a rename.

When I provided the test case, I assumed this was something like
"Recursive uses the information of each commit individually, whereas
ort elides some stuff (and potentially introduces lots of other stuff)
in the name of performance, hence there seems to be a correctness
issue here". I assumed that the "recursive" strategy was logically
equivalent to iteratively merging all the changes, along some chosen
path from the merge base (eg the shortest?), and ort was... something
else. Hence my assumption that in this case, where iteratively merging
master into will get you the *right* result, regardless of whether you
choose "recursive" or "ort" to do it, there was a correctness
regression in ort.

If I understand some of what you describe below correctly, this is an
incorrect understanding of "recursive" - it does not, then, do the
equivalent of iteratively merging all the commits along some selected
path from the merge base.

Insofar as a majority of my users (and, I suspect, a majority of git
users overall) typically deal with large merges in a context where
some upstream branch has had lots of changes, very iteratively, and
*there is meaning* in those iterations, it scares me a bit to think
that users are at risk of getting painful or wrong merge outcomes
because that upstream branch's history is actually being ignored, or
not used to its max potential. I would welcome some more-primitive and
slow algorithm that could use the *knowledge* that
"folder2/secondfile_renamed.txt" was in fact a rename of
"folder2/secondfile.txt", as encoded in one of the individual commits
in the path from the merge base to the tip being merged in. I would
want to be able to offer this "slower, but more correct" algorithm to
my users when a merge turned out to be more conflictive than they
might have expected, as here.

(of course, I may have misread chunks of what you are saying here - my
conclusion here is strongly focused on your, in my opinion
correctness-damaging, simplification of my test case)

>
> So, when git goes to merge, renames between the merge base say there
> have been two files deleted and one new one added.  Since
> folder2/secondfile.txt was unmodified in the feature branch, any
> renames affecting it won't result in three-way content merges anyway,
> and thus was removed from rename detection.  That only leaves
> folder1/firstfile.txt and folder2/secondfile_renamed.txt left to even
> compare, and since it only compares those two, it matches them up as a
> rename.  That explains what is happening here, and why.
>
> Note that this particular change came from my "Optimization batch 9"
> in merge ort, and was the optimization that I think was more important
> than all the others combined.
>
> But some, seeing this case in isolation, might be thinking
> "regression", so let's dive into more nuance...
>
>
> === (b) similar-ish cases discussed and documented explicitly in the
> past year ===
>
> We decided in "Optimization batch 7" to actually relax the "best
> match" criteria.  Note that we changed the documentation in commit
> 07c9a7fcb5 ("gitdiffcore doc: mention new preliminary step for rename
> detection", 2021-02-14) to include the following:
>
> '''
> So, for example, if a deleted
> docs/ext.txt and an added docs/config/ext.txt are similar enough, they
> will be marked as a rename and prevent an added docs/ext.md that may
> be even more similar to the deleted docs/ext.txt from being considered
> as the rename destination in the later step.
> '''
>
> This was related to some discussions we had around performance,
> including the following statement I made at the time:
>
> '''
> We will give up "optimal" matches, but as long as what we provide are
> "reasonable" matches I think that should suffice.  I personally
> believe "reasonable" at O(N) cost trumps "optimal" at O(N^2).
> '''
>
> (It may also be worth noting that the optimization affecting your
> testcase, from "batch 9", was one that often provides reasonable
> renames at O(0) cost; O(0) is even more of an improvement over O(N^2)
> than O(N) is.)
>
> Somewhat interesting here is that this "Optimization batch 7" isn't
> just new to merge-ort; it also affects merge-recursive.  So if we
> changed your testcase as follows:
>   * feature branch: make a small tweak to both folder1/firstfile.txt
> and folder2/secondfile.txt
>   * master branch: delete both folder1/firstfile.txt and
> folder2/secondfile.txt, and introduce newfolder/firstfile.txt that is
> more similar to folder2/secondfile.txt
> then both merge-ort and merge-recursive today will match up the
> folder1/firstfile.txt -> newfolder/firstfile.txt.  (Whereas a year
> ago, it would have matched up folder2/secondfile.txt ->
> newfolder/firstfile.txt).
>
>
> But the nuance goes a bit further...
>
> === (c) some similar cases not discussed and documented, and for which
> the recursive backend gives a "worse" answer by your explanation of
> "worse" as being that it gives conflicts ===
>
> If you modified your testcase slightly:
>   * feature branch: modify folder1/firstfile.txt slightly
> and as a reminder, the other branches were:
>   * Merge base: Has both folder1/firstfile.txt and folder2/secondfile.txt
>   * master branch: delete both folder1/firstfile.txt and
> folder2/secondfile.txt, introduce folder2/secondfile_renamed.txt which
> is very similar to both deleted files, but more so to the latter
>
> Then merge-recursive will fail with conflicts while merge-ort will
> succeed without any.
>
> Is that better?  Worse?  For which backend?  Before you make your
> call, let's consider the following slightly different case:
>   * Merge base: Has files A & B (very similar, but not exact)
>   * feature branch: Modify B, in an area where it differs from A
>   * master branch: Copy A to C (while modifying it slightly in the
> area it differs from B) in one commit, then delete B in another
> commit.
>
> From the point of view of "best matches", we would have "A was left
> alone, B is modified slightly on one side and deleted on the other,
> and C is a new file" so the result should be "the original A, the new
> C from master, and a modify/delete conflict on B".  However,
> merge-recursive and merge-ort will instead claim there was a B->C
> rename and since they have conflicting content changes in the same
> area, fill C with conflict markers from these "unrelated" files that
> the user then has to separate.

My knowledge of copy-detection is very limited - I don't know what
purpose it serves, when it is used, etc. I've always assumed that from
a "file destiny" perspective, creating a copy, without removing/moving
the original, should have no impact on where later changes to the
original are considered to go - they stay with the original, even if
it drastically changes. I would only ever expect rename detection to
kick in if one thing was added, and another removed, in the *same*
commit.

If I were to apply an "iterative-ort" algorithm (that is, first merge
in the "Copy A to C" commit, then merge in the "delete B" commit,
using ort both times), I would get the "best match" outcome you
describe, right?

>
> So, should merge-ort and merge-recursive do copy detection in order to
> get the "best" matches?  Practically speaking, doing so means not only
> dropping the recent optimizations that sped up rename detection by a
> few orders of magnitude, we're actually talking about taking the slow
> version of merge-recursive from before this year and slowing it down a
> few extra orders of magnitude in order to get copy detection -- making
> it overall several orders of magnitude slower than today's merge-ort.

I'm not sure I understand what copy-detection has to do with it - is
your point here that by identifying a copy and carrying that knowledge
forward, you can avoid a later deletion of the original being
*mistaken* for a rename? That sounds... very reasonable, but given
your description of impact on performance, maybe sub-optimal.

I assume adding this copy-detection would still, in practice, perform
better than my imaginary "iterative-ort" algorithm?

>
> But maybe you still think this is a correctness issue, and performance
> is irrelevant.  So let's go a little further in the nuance, so I can
> demonstrate that "best matches" actually can give you demonstrably and
> laughably wrong results:
>
> === (d) some warning/advice for folks dealing with multiple files
> whose contents are quite similar (or even multiple directories of
> files whose contents are quite similar) ===
>
> During the testing of merge-ort, I dug through many repositories and
> remerged all existing merges to see which might give different results
> with merge-ort vs. Git v2.30's merge-recursive.  I did find some,
> though they came from the basename-guided matching change (discussed
> in my section (b) above) rather than the unmodified-one-on-side change
> (the case you pointed out in your email).  However, every single one
> of the examples I found came from an interesting type of situation: it
> appears that a number of big projects sometimes make a complete copy
> of some directory (a library, a driver, whatever), and keep them both.
> Many times this might be to keep one stable, while making
> modifications to the other copy to add new features or abilities.
> It's also possible that there was an earlier rename involved before we
> got the current two names as well.  So, with that in mind here's a
> question: what do you do when cherry-picking new features added to an
> older version of the code?  If we use your "highest percentage match"
> as you mentioned earlier, we'll likely end up applying the
> cherry-picked changes to the _stable_ files rather than the new
> version, because the copy meant to be stable is more similar to the
> older version.  That's likely the wrong target.  But it gets worse...
>
> Some new feature is probably going to touch several files in the
> relevant directory, not just one.  That raises the question of where
> do the files each match individually?  I saw multiple examples where
> the "best" match for individual files left half the files matching the
> current stable version of the library/driver/whatever, and the other
> half of the files matched against the new version of the
> library/driver/whatever.  That means that porting those patches using
> merge/cherry-pick/rebase/etc. is going to apply half the patches to
> one copy and the other half of the patches to the other copy.

If I understand you correctly, this is a problem that both "recursive"
and "ort" share, but my imaginary "iterative-ort" does not. Is that
right?

> That
> just cannot possibly be right.  merge-ort didn't fix this, it
> basically just meant it'd sometimes choose a slightly different mix of
> application targets, but still split them across the two copies.
> Well, technically merge-ort is marginally better here because the
> directory-rename-guided-optimizations in merge-ort means that it's
> slightly more likely to apply all the changes to one directory than
> merge-recursive is.  But only slightly.  So these are situations where
> both algorithms are likely to provide results that users will almost
> certainly classify as wrong (and maybe even as "extremely wrong").
>
> If your repository is one where each file is pretty unique, then
> rename detection seems to be a lot more reasonable and straightforward
> to just run automatically.  But if you have multiple near copies of
> the same file, and especially if you have multiple near copies of the
> same directory, then relying on git's automatic rename detection
> without double checking is a bad idea.  Git does a good job during a
> merge of printing out which files it has detected as renames and
> displaying which files have three-way content merges performed on
> them, so I'd recommend looking at those a lot closer if you've got
> multiple near copies of the same file or directories.
>
> > Is ort supposed to choose the "best" rename choice, for a given set of
> > trees, and failing to do so here? Or is this a case of recursive
> > *accidentally* doing a better thing?
>
> As noted above, neither the ort nor recursive strategies promise to
> choose the "best" rename (by which I presume you mean closest match);
> they both have situations where they'll pick a different one when
> there are multiple choices.  Further, as shown above, finding the
> optimal rename choice is an ill-posed problem space when dealing with
> multiple near-copies of the same files or directories.  I would not
> label either recursive's or ort's behavior as "correct" or "better"
> for your testcase (nor as "incorrect" or "worse").  As to your last
> question, while there have been cases in the past of the recursive
> strategy accidentally getting good results in some cases (e.g. due to
> serendipitous cancellation of different bugs for certain inputs),
> there's no such accident in anything I've discussed here that I've
> found; it's all a clear expected result of the algorithms in question.
> I hope that this all answers your particular questions, but I think
> there's a deeper point here that is important for people to generally
> realize for this situation or others like it:
>
>
> TAKEAWAY: Whenever you are dealing with multiple files or directories
> that are near matches, the person doing merges/rebases/whatever really
> does need to be responsible to pay close attention to any such
> files/directories (and this is not new to merge-ort; it has always
> been an issue with merge-recursive as well).

This conclusion I find deeply scary and problematic. If I have 1000
users of a repo, and there are 3 sections of the folder structure that
have been split off / duplicated, and many of these users might change
the original ones or the copies, you're saying *all* of these users
merging "upstream" changes down into their feature branches need to be
*aware* of the "there are multiple similar directories" problem, and
need to *actively* recheck that git is not doing anything "wrong" by
eliding commit history when merging, even in the absence of warning or
conflicts from the tool???

Sorry if I'm misunderstanding and mischaracterizing... but this
seems... bad. It seems very much in violation of the general principle
that Junio outlined that "[users needing] to look for mistakes in
_all_ merges made by the tool, [...] is
not something we would want."

Understanding that the default choice of merge strategy needs to make
compromises, and apparently recursive *already* made these particular
compromises, is there in fact an "iterative along the shortest merge
path", or "iterative-ort" strategy or that I could try / play with, in
terms of performance testing? In practice, I think the *process* of
faking/prototyping this would actually be a kind of "reverse-rebase":
* Assuming I have a series of commits on "master" that, taken together
without copy-detection, can be "misinterpreted", and that I want to
merge master into a feature branch:
* Checkout a new branch from master, creating temporary branch
"merge-outcome-candidate"
* Rebase onto feature (resolving any conflicts along the way,
potentially over several/many steps, and *without* --rebase-merges),
resulting in an iterately-merged / resolved tree
* Check out feature
* Merge in master with --no-commit
* "git add  ." to fake-resolve any conflicts
* "git restore merge-outcome-candidate -- *" to reuse the
iteratively-merged tree as the merge outcome
* "git commit", pretending this was a regular merge

Does anything logically equivalent to this exist?

Do you agree that it would in principle address the correctness issues
discussed here, no matter how poorly it might perform?

Thanks,
Tao
