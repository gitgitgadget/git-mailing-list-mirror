Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789CE1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeCLWlf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:41:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36733 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:41:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id 188so19152226wme.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vmBKxo1eV6td6jdIP1vsbBDtaFr8PUIQTLD1guMS/I4=;
        b=TuJaF+UcRsJTJ4+Pf90qaKAoGSf4u4X/w3IiiL8AlfF5yTqCP/hX0/hZWIiefV2ihB
         i2TIVqa9dn4gsDrHb28OiYzBSIpLsGOOkV9qP0RC73uWPvRxi8qDeXheX9/kI16MU/M8
         JhZ0xMT+RAoxrJSDkQAPN7o+a6kfe/g7PPR5eSi4a3TNDEuXqAvVVpRwLSHqNR8dLRiw
         10j7gVqgmTpxeFHHEizaoMGwTgUbMOGejwnNmvLLyuEL3DPkU6xBGCzAcpQg8TA7kpZR
         EhDsQpZxm3nyojuiwJTiWImj+nBajTe7lOoM2kpoJMEoLofrBJRmOuIjZimEcgie/v5o
         /TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vmBKxo1eV6td6jdIP1vsbBDtaFr8PUIQTLD1guMS/I4=;
        b=Lvif0OVXjAJLn6KBDTV7wpxCj5C7SCsxvWCiysFhCzyDKaIGdVt0s+Z094xPP99t9U
         pWIRDTzfE0xvdjiiuDBrOTsQLzPW4RpoKwHdWOH8wotRAGY2lbxnR3cccqOW51iynOJ/
         HeY0t1tqrqi3QuWR1/ZmLAx3kGOKwFDsr+E6fSx3ZK4UBZNzfxdEFdZ/uzWk68fgqpi1
         yksfL1bAnT4eTsW7bLEi6bi3EbD2MwBKJc1ZMfhRen9AeHKByfeMAMrUhewrs2sIjG8A
         u0yHSwW79u7xqm5asdfEwX3CP/R7vjo5FbKs+Cw3GyX004xRaY0NRA3pBv3sGi/pzqvT
         Pw9Q==
X-Gm-Message-State: AElRT7GyJ/LJpfYhbECMDmL7JIuWqfIoCzrK2EuwBwDmLtn56Fo3GfRM
        p22broGS9VU30wdiLKUtTFY=
X-Google-Smtp-Source: AG47ELvg+SPkOszwm5sf3ud+bAwgUG7tKcYHDNUrA0E5PuHErUKphJ4IgiWUWqvtj6BUHgFpwXls+w==
X-Received: by 10.28.52.83 with SMTP id b80mr7571990wma.90.1520894491386;
        Mon, 12 Mar 2018 15:41:31 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id l14sm1002224wrh.62.2018.03.12.15.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 15:41:30 -0700 (PDT)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com>
Message-ID: <2228813d-5b85-3371-b2a1-0a5633d26336@gmail.com>
Date:   Mon, 12 Mar 2018 23:41:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 11/03/2018 23:04, Igor Djordjevic wrote:
> 
> I`m yet to read (and reason about) your whole (very informative) 
> reply, but I just wanted to address this part first, as it might be a 
> clear end-game situation already, due to a mutual agreement, all the 
> rest being purely academic, interesting, but not any more (that) 
> important to discuss.

Ok, here`s the follow-up.

It`s "for discussion sake only", nothing really groundbreaking in 
here, I would think.

On 11/03/2018 16:40, Johannes Schindelin wrote:
> 
> > > > The main problem with this decision is that we still don't see how
> > > > and when to stop for user amendment using this method. OTOH, the
> > > > original has this issue carefully discussed.
> > >
> > > Why would we want to stop, unless there are merge conflicts?
> >
> > Because we can reliably know that something "unusual" happened - and by
> > that I don`t necessarily mean "wrong", but just might be worth user
> > inspection.
> 
> We have a similar conundrum in recursive merges. Remember how multiple
> merge bases are merged recursively? There can be merge conflicts, too, in
> *any* of the individual merges involved, and indeed, there are (under
> relatively rare circumstances).
> 
> Since we already faced that problem, and we already answered it by
> presenting possibly nested merge conflicts, I am in strong favor of
> keeping our new scenario consistent: present possibly-nested merge
> conflicts.

This is something I didn`t really know (possibly-nested merge 
conflicts already being a regular part of Git user experience), 
thanks for explaining it.

In the light of this, I can only agree, let`s keep it consistent.

If anyone ever decides / finds out there`s a better approach in 
regards to user experience, this might get revised, but it`s a 
different beast altogether, yes.

> As far as I understand, one of the arguments in favor of the current
> approach was: there is no good way to tell the user where they are, and
> how to continue from there. So better just to continue and present the
> user with the entire set of conflicts, and have an obvious way out.

Yes, I see this as the main concern, too. I would have expected that 
being in a kind of a "limbo" for a while shouldn`t be too bad, but I 
guess that`s too academic (and inexperienced) thought, and from a 
practical point of view one may not really know how to approach the 
(iterative) conflicts in the first place, not knowing his exact 
position (nor what`s to come)...?

Or, might be we _can_ provide enough clues on where we currently are 
(even if still inside some intermediate state)...? But, this still 
might be a topic for the future, indeed, and unrelated to rebasing 
merges alone (as you pointed out already).

> > For example, situation like this (M is made on A3 with `-s ours`, 
> > obsoleting Bx commits):
> >
> > (1) ---X8--X9 (master)
> >        |\
> >        | A1---A2---A3
> >        |             \
> >        |              M (topic)
> >        |             /
> >        \-B1---B2---B3
> >
> > ... where we want to rebase M onto X9 is what I would call "usual 
> > stuff", but this situation (M is still made on A3 with `-s ours`, 
> > obsoleting Bx commits, but note cherry-picked B2'):
> >
> > (2) ---X8--B2'--X9 (master)
> >        |\
> >        | A1---A2---A3
> >        |             \
> >        |              M (topic)
> >        |             /
> >        \-B1---B2---B3
> >
> > ... where we still want to rebase M onto X9 is what we might consider 
> > "unusual", because we noticed that something that shouldn`t be part 
> > of the rebased merge commit (due to previous `-s ours`) actually got 
> > in there (due to later cherry-pick), and just wanting the user to 
> > check and confirm.
> 
> We already have those scenarios when performing a regular interactive
> rebase, where a patch was already applied upstream. In the normal case,
> the user is not even shown B2, thanks to the --cherry-pick option used in
> generating the todo list.
> 
> Granted, in some cases --cherry-pick does not detect that, and then we
> generate a todo list including B2, and when that patch is applied, the
> interactive rebase stops, saying that there are no changes to be
> committed.
> 
> And this behavior is exactly the same with --recreate-merges!
> 
> So I do not think that it would make sense to bother the user *again* when
> rebasing the merge commit.

This seems fair enough. Phillip also pointed out it might be more 
annoyance then help, but as no one was really sure of the possibilities 
we`re discussing here, I thought being better to play it a bit on the 
safe side, for the first time, at least.

I would still like to see more examples of where this U1' == U2' 
check actually helps, and counter ones, where it only serves to annoy. 
Might be we only discover them in the future, though, once the new 
functionality is in use.

> If there are merge conflicts, yes, we will have to. If there are none
> (even if your U1' != U2'), it would be outright annoying to stop.

I hope you`re right :)

> > > > "rebase sides of the merge commit and then three-way merge them back
> > > > using original merge commit as base"
> > >
> > > And that is also wrong, as I had proved already! Only Buga's addition
> > > made it robust against dropping/modifying commits, and that addition
> > > also makes it more complicated.
> >
> > No, this is actually right, that sentence nicely describing _how_ it 
> > works.
> 
> Does it? Because that's exactly backwards from how Phillip's approach
> works: it certainly does not use the original merge commit as base. It
> uses the non-rebased merge parent as base, one at a time.

Hmm, might we are all misunderstanding each other here - what I meant 
is that what Sergey wrote about his approach is exactly how _his_ 
approach works (quoted above): "rebase sides of the merge commit and 
then three-way merge them back using original merge commit as base".

> So the closest I got was the description with the *original merge commit*
> as merge base, which I disagree with. It does not make sense to me.
> 
> Consecutive three-way merges between the original merge commit and the
> merge parents (with the *original merge parents* as merge base,
> respectively), still makes the most sense to me: it is a merge between the
> amendmends to the merge commit and the changes introduced by rebasing the
> merge parents.

This is what I hopefully managed to explain as essentially being the 
same concept, using those "merge-recursive transformations", where we 
can get from using *original merge parents* as a merge base, to using 
*original merge commit* as a merge base[1] (when using U1 and U2).

> I am now getting the sense as if Sergey's approach (with your, let's say,
> "fix") is trying to apply too much, and by using the original merge commit
> as merge base then tries to undo part of that.

This is an interesting way to look at it. If you observe rebased 
temporary commits U1' and U2' alone, then I guess the answer would be 
*yes*, even.

But I think they should only be observed as an intermediate step to 
reach a final (rebased) merge commit, and the missing (and inseparable) 
link is that original merge commit used as a base for merging them.

They _did_ become from that original merge commit (tree) in the first 
place, merge commit alone transformed to more separate (but dependent 
commits), thus they are still somewhat related/dependent to it after 
their rebasing and prior the final merge (more on it in a graph later).

> > > > I honestly don't see any advantages of Phillip's method over the
> > > > original, except personal preferences. At the same time, I have no
> > > > objection of using it either, provided consistency check problem is
> > > > solved there as well.
> > >
> > > Okay, let me reiterate then, because I do not want this point to be
> > > missed:
> > >
> > > Phillip's method is essentially merging the new tips into the original
> > > merge, pretending that the new tips were not rebased but merged into
> > > upstream.
> > >
> > > So it exploits the duality of the rebase and merge operation, which both
> > > result in identical trees (potentially after resolving merge conflicts).
> > >
> > > I cannot think of any such interpretation for your proposal augmented by
> > > Buga's fix-ups. And I haven't heard any such interpretation from your
> > > side, either.
> >
> > Ok here it goes (I might be still wrong, but please bare with me).
> >
> > What Sergey originally described also uses the "duality of the rebase 
> > and merge operation", too ;) Just in a bit different way (and might 
> > be a more straightforward one?).
> 
> I will be the judge whether it looks more straight-forward to me. :-)

Hehe, fair enough ;) I was speaking mainly for myself (at the time) :)

> > Here`s a starting point, two commits A and B, merged into M:
> >
> > (3) ---A
> >         \
> >          M
> >         /
> >     ---B
> >
> >
> > According the "patch theory"[1] (which might not be too popular 
> > around here, but should serve the purpose for what I`m trying to 
> > explain),
> 
> I think that the patch theory is not usually quoted here because
> 
> 1) originally, Darcs had this snake oil way of (over-)selling its theory
>    as having "roots in quantum mechanics" [*1*] at the time Git took off,
>    and
> 
> 2) it does not really have a good concept of rebasing, even if it should
>    be theoretically possible to integrate that into the "theory of
>    patches".

Yeah, I actually remembered some Linus` comment about "theory of 
patches" being nice... well, in theory (like for scientist), but not 
that much useful in practice - I`m paraphrasing now, here`s a proper 
reference[2].

Basically, it did provide me with a hint to take "patch theory" with 
a grain of salt, just that I did seem to find a logical explanation 
in there for what Sergey was originally describing, and what otherwise 
did "feel" as a good thing, but I wanted some more support on _why_ 
it feels so (on why it works, as you asked yourself, while it did seem 
to work, nonetheless).

> > each merge commit can be "transformed" to two non-merge commits, one on
> > top of each of the merge parents, where new commit brings its original
> > merge parent commit tree to the state of the merge commit tree:
> >
> > (4) ---A---U1
> >
> >
> >
> >     ---B---U2
> 
> You get the same result if you stick to regular graph theory, of course.
> All you need to do is to interpret the directed vertices between nodes as
> a patch & parent relationship. Simple.

Not knowing much about graph theory myself (other than what I grasped 
through Git so far), I`ll take your word here - and might be educate 
myself more about it, too :)

> > Now, we have two new commits, U1 and U2, each having the same tree as 
> > previous merge commit M, but representing changes in regards to 
> > specific parents - and this is essentially what Sergey`s original 
> > approach was using (whether he knew it, or not).
> >
> > When it comes to rebasing, it`s pretty simple, too. As this:
> >
> > (5) ---X1---o---o---o---o---o---X2 (master)
> >        |\
> >        | A1---A2---A3
> >        |             \
> >        |              M
> >        |             /
> >        \-B1---B2---B3
> >
> > ... actually equals this:
> >
> > (6) ---X1---o---o---o---o---o---X2 (master)
> >        |\
> >        | A1---A2---A3---U1
> >        |
> >        |
> >        |
> >        \-B1---B2---B3---U2
> >
> > ... where trees of M, U1 and U2 are same,
> 
> Okay, so you basically duplicated the merge commit and dropped its
> semantics as a merge commit. That is a very big difference to Phillip's
> approach already.

Yes, the purpose here was to explain why Sergey`s approach (still) 
works, not to compare it with Phillip`s (which also works).

From here on, we can use simple (and existing) rebase functionality / 
semantics to really rebase that original merge. There are no new 
concepts needed, it just works (TM) :)

> It opens the door to ambiguities, as we will see later.
> 
> > and we can use the regular rebase semantics and rebase it to this:
> >
> > (7) ---X1---o---o---o---o---o---X2 (master)
> >                                 |\
> >                                 | A1'--A2'--A3'--U1'
> >                                 |
> >                                 |
> >                                 |
> >                                 \-B1'--B2'--B3'--U2'
> >
> > ... which is essentially this again:
> >
> > (8) ---X1---o---o---o---o---o---X2 (master)
> >                                 |\
> >                                 | A1'--A2'--A3'
> >                                 |            \
> >                                 |             M'
> >                                 |            /
> >                                 \-B1'--B2'--B3'
> >
> > ... where it is still true that trees of U1', U2' and M' are still 
> > the same. So we managed to rebase a merge commit without ever doing a 
> > merge :) (note that, practically, we _can_ finally even merge U1' and 
> > U2' to produce M', it shouldn`t really matter as all the trees are 
> > the same, so merge will be a no-op)
> 
> U1' and U2' do not have the same tree, though *especially* when the user
> did not edit the todo list to insert/modify/drop/reorder commits.

I lost you here - how come they don`t? The only difference between U1 
and U1' will be what`s between X1 and X2, and the same is true for U2 
and U2'. And as we know U1 = U2, it means U1' = U2' still holds.

I`m following further...

> This violation of expectations is of course caused by "duplicating the
> merge commit" into U1 and U2.

It`s just a change of semantics, a natural transformation (I wouldn`t 
know a more "proper, scientific" term, sorry), all still being 
correct. But I guess we can call it "duplicating" as well.

> But let's continue.
> 
> > But, as we saw (what you`ve explained), this doesn`t really work in 
> > case one of the sides of the merge gets "disbalanced" (so to say), 
> > like dropping a commit (which could also happen non-interactively, 
> > where a commit has been cherry-picked to a different branch, but
> > previously obsoleted by `-s ours` merge).
> 
> Precisely. A *very* important counter-argument to this approach so far.
> 
> > As observed, dropped commit could still wrongly get into final merge 
> > commit tree (or cherry-picked commit wrongly not get there), due to 
> > the nature of those rebased U1 and U2 temporary commits to hold all 
> > the differences in regards to their specific merge commit parent.
> 
> The reason for this, of course, is that either U1's or U2's diff will show
> those differences, *and we still try to rebase them even if the user
> already dropped them*.
> 
> But let's continue.
> 
> > A natural improvement to original idea which Sergey eventually came 
> > up with after my findings (which you now ended up calling a hack, even, 
> > but I would respectfully disagree), is to use original merge commit M 
> > as a merge base for final merge of U1' and U2' - and here is why it 
> > works, too, and why I wouldn`t consider it a hack, but a proper (and 
> > a solid) solution.
> >
> > Merge commit M is what we are rebasing, so we should have a way to 
> > somehow learn from it, alongside U1 and U2 temporary commits - and 
> > that is what using original merge commit M as a base does for us. It 
> > helps us spot any "disbalances" that happened in comparison to original 
> > merge parent trees, which is exactly what we`re interested in.
> 
> ... except that it gets the direction wrong. Rather than trying to *avoid*
> rebasing possibly dropped changes, it tries to kind of "undo" them by
> using a merge base that does not really make sense (unless you think of it
> as a "revert").

I disagree, but I`ll explain more later. The point is that we are 
really rebasing original merge commit, where rebased merge commit 
might have missed some stuff (due to possibly dropped changes) - so 
once we successfully rebased the original merge commit, we are to 
acknowledge additional changes we didn`t catch so far (as we would 
catch additions), and act accordingly.

Using original merge commit for the purpose feels natural to me - 
it`s where we are starting from, using both parent branches evolution 
to get where we`re heading to, being a rebased merge commit.

> It would make sense if M could interpreted as a branch point. But it
> cannot, as we specifically did *not* continue to develop the merge parents
> from that merge commit.

But we did (for the sake of rebasing), transforming the very merge 
commit into those commits developed on top of its merge parents :)

> Instead, what we did was to branch off of the original branch point X1.
> 
> Reframing the rebase of a sub-branch (X1..A3) as merge with upstream,
> however, we can interpret M and A3' as revisions we want to merge, with A3
> as the merge base.
> 
> (You can think of it in terms of the "theory of patches" thusly: if X1..A3
> is represented by patch K, X1..X2 by patch L, and X2..A3' by K', then what
> we want to merge into M is K^(-1).L.K', which is precisely what A3..A3'
> translates to.)
> 
> You can also think of it as diverging changes going from A3: one direction
> was to merge (resulting in the commit M), the other direction was to
> rebase onto X2 (resulting in A3'), and a 3-way merge M <- A3 -> A3' will
> reconcile those changes (and you will want to repeat with B3/B3', too).
> 
> Let's put that into the context of your example: instead of introducing U1
> and U2, we introduce V1 and V2 right away, as temporary *merge* commits,
> where the tree of V1 is identical to the one of A3', and the tree of V2
> to that of B3'.
> 
>  ---X1---o---o---o---o---o---X2 (master)
>     |                        |\
>     |                        | A1'--A2'--A3'--V1
>     |\                       |               /
>     | -A1---A2---A3----------+---------------
>     |              \         |
>     |               M        \-B1'--B2'--B3'--V2
>     |              /                         /
>      \-B1---B2---B3--------------------------
> 
> Note: the *really* important difference is that these temporary commits
> are based on the *rebased* history rather than the *unrebased* history.

This might be an important advantage of Phillip`s "simplification", 
indeed.

> Third note: my favorite mental model is still the duality of rebasing and
> merging, in which case V1 and V2 would not have A3' and B3' as first
> parents, but X2.
> 
> Phillip's strategy is to merge M with V1 and V2.
> 
> This translates to "merge the amendments of the merge commit M with the
> changes introduced by rebasing its merge parents".

All this I agree with. And all this can be used to support what 
Sergey described, too (being a bit different, though) :) Let`s see...

 ---X1---o---o---o---o---o---X2 (master)
    |                        |\
    |                        | A1'--A2'--A3'--U1'
    |\                       |               /
    | -A1---A2---A3---U1-----+---------------
    |              \ /       |
    |               M        \-B1'--B2'--B3'--U2'
    |              / \                       /
     \-B1---B2---B3---U2---------------------


To get the original merge commit M, you can just merge U1 and U2 
again back to single commit - original commit M is a natural merge-base. 
It`s the same with rebased commits U1' and U2' - to get rebased merge 
commit, you merge them. Again, original commit M is a natural 
merge-base.

This is why I disagreed above with statement that merging U1' and U2' 
with base M doesn`t make sense. I think this shows it does.

> The really cute part about this is that (in contrast to using U1' and
> U2'), we do not merge the amendments of the merge commit multiple times,
> but exactly once. And therefore, we do not need to "undo" them by using
> the original merge commit as merge base, either (which would introduce
> many more opportunities for merge conflicts to creep in, oftentimes
> unnecessary conflicts to begin with).

This might be true, which is why I might find Phillip`s approach to 
be a further optimization of what Sergey came up with. But I would 
still like to do some tests concerning manually amended conflicts, 
will report once I do.

Though, we do not merge the amendments of the merge commit multiple 
times here either, but we do rebase them multiple times, true (being 
held in each rebased Ux' commit again).

> > In ideal case (as per "patch theory"[1]), final merge of rebased U1' 
> > and U2' with original merge commit M as a base would be rather simple, 
> > too (not to say pointless again), as both U1' and U2' would have same 
> > changes in comparison to M, namely all the changes from commit we are 
> > rebasing from (X1 above) to commit we are rebasing to (X2 above).
> >
> > But in a more complex case like this:
> >
> > (9) ---X1---B2'---o---o---o---o---X2 (master)
> >                                   |\
> >                                   | A12--A2'---B3'
> >                                   |             \
> >                                   |              M'
> >                                   |             /
> >                                   \-B1'--B3'---B4
> >
> > ..., being what we are ultimately interested in, it helps us notice 
> > all kind of changes on our rebased merge parent branches, and act 
> > accordingly (as shown by my previously posted test script).
> 
> To use the "theory of patches" to explain why Phillip's approach is so
> much more appealing: in Sergey's approach, we will rebase U1 (which is
> "sort of" B1.B2.B3 in the "theory of patches"). If the cherry-pick of B2'
> caused merge conflicts that had to be resolved, then these merge conflicts
> will have to be resolved *again* when rebasing U1 (because B2 is *part of*
> U1). And of course they will have to be resolved *again* when merging U1'
> with U2'.

I think I disagree here - U1 doesn`t purely hold B1.B2.B3, but their 
_application onto A3 tree_ - with all conflicts resolutions that might 
have happened. Thus rebasing U1 on top of A3' should be as safe as it 
gets.

Am I missing something?

> In short: Phillip's approach is a short-cut that avoids unnecessary merge
> conflicts because it avoids rebasing changes that would need to be undone
> right away anyway.

I don`t agree it avoids conflicts (as resolutions of those are already 
part of U1, I`ll need to test), but I do agree on Phillip`s approach 
seeming to be a shortcut, though.

> > All this said (and hoping anyone is still reading this), to shed some 
> > light on what I meant by "favoring Sergey`s approach in general, but 
> > _implemented_ through what Phillip described".
> >
> > I think we should use temporary commits U1 and U2, being a sound 
> > approach backed up by the "patch theory"[1], as it helps us notice 
> > any "disbalances" of the rebased merge commit parents trees (so we 
> > can stop for user inspection), finally merging them with original 
> > merge commit as a base, in order to spot additional changes on trees 
> > of the merge commit parents we are rebasing.
> 
> In Phillip's approach, we do not need to rebase the amendments of the
> merge commit M twice (or even more times, for octopus merges). Therefore,
> there is no opportunity for these imbalances.

First sentence is true, conclusion not (necessarily) - it`s not 
rebasing amendments that introduces "disbalances", but changes in 
rebased merge parents` trees other than what found inside X1.X2.

> > But, the merging steps themselves, backed up by a need to stop for 
> > conflict resolution as soon as one happens, should be performed 
> > _iteratively_, like Phillip showed us... I would think :)
> 
> From a user interface perspective, this is a bad idea: you would now have
> to communicate to the user *where* in the process they are.
> 
> And for that you would have to explain that process to them. Including
> "theory of patches" and all.
> 
> Taking me as a prime example, you now know how tedious and impractical
> that would be.

I don`t (or didn`t, at least) find this as terrible as you`re 
describing it - yes, we`d need a way to explain people that they`re 
in an intermediate state, on the way to rebase a merge commit, but 
that`s all they would really need to know.

Might be it would be enough to say "currently rebasing merge parent 
X" (or "commit X"), then later "currently rebasing merge parent Y", 
or something along the lines of what rebase already does, just to 
provide a hint so one can act accordingly (resolve conflicts), and 
--continue.

But, as you previously mentioned this already being a known issue 
(possibly nested merge conflicts), which I wasn`t really aware of, I 
would refrain from further discussing it now and just agree to do 
what we do in the other case, too, as you suggested.

> > And, for example, that would do wonders when we introduce completely 
> > new branch during an interactive rebase, too, for example:
> >
> > (10) ---X1---B2'---o---o---o---o---X2 (master)
> >         |\                        /|\
> >         | A1---A2---A3---U1       || A12--A2'---B3'---U1'
> >         |             \           ||             \
> >         |              M          ||              M'
> >         |             /           ||             /|
> >         \-B1---B2---B3---U2       |\---B3'---B4-/-|---U2'
> >                                   |               |
> >                                   \-----B1'-------/
> >
> >
> > In this situation, we would merge all temporary Ux commits using 
> > original merge M as a merge base, and then merge _that_ resulting 
> > tree with B1' (being a newly introduced merge commit parent), using 
> > whatever merge base is most appropriate between the two (in this 
> > case, X2).
> 
> The semantics of octopus merges are very different from regular recursive
> merges. I am not sure that we want to go there in this discussion...
> 
> If, on the other hand, you do not try to turn M from a regular 2-parent
> merge commit into an octopus merge during an interactive rebase, but
> instead split the B branch into two branches *before* merging the result
> into the rebased merge commit, we are in the same square as
> reordering/dropping/inserting/modifying patches: to neither of the
> presented strategies would it matter what kind of branch topology the
> merge parents have.
> 
> For the record: I am still not convinced that Phillip's and Sergey's
> approach are equivalent, even in terms of the "theory of patches". [...]

And you shouldn`t be, nor it was my wish to conclude so, but only to 
(try to) explain _why_ Sergey`s approach works _as well_, without anything 
magical about it (nor wrong), thus no need to be afraid of it, either.

> [...] But if
> they are, then Phillip's version is a shorter version that avoids applying
> changes just to revert them right away. And in a setting where each patch
> can cause merge conflicts (as the interactive rebase is), the less changes
> you have to apply, the better.

I would still like to see some comparisons (for myself), but this is 
fair enough for now, and understandable.

Thank you for a very interesting (and educative!) read :)

Regards, Buga

[1] https://public-inbox.org/git/6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com/
[2] https://public-inbox.org/git/Pine.LNX.4.64.0604030727250.3781@g5.osdl.org/
