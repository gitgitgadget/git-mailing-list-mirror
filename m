Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790041F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 22:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDLWPN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:15:13 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53326 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeDLWPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:15:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id 66so1308904wmd.3
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vCDgupaxF9FrvKMBuBDmthOs0r2lweEnmWURdVv59p0=;
        b=KffxAzA9fTXco08CKvnsvkAA2blKwhPzBqg/pC5i77kbFik6SxKy3cnAiSL74KJjs9
         TGuKAcAmU5HG6aRR36PqTLAYkr83tg35jJIlmH9nvCczEznIloMcE8XVf0KGuorLpivd
         vk+zCUxlGhPQ57RggzoOX413vcOhO4NE/AX5IRzFeSgzmoT/LCKmH6LnEeNIps1tvXV/
         MapM8Z2IQDQPHL28NFl+ETfcYeMJ3i9jlvP9qm/yG03bCXqFCKgQ6y90J/kbypiu4npH
         wbs/Cy9tScJWk3m6aFSErQctMjw23OKfxqSyu+Ty5bsT5gh5oSlaC5U7/bS8gZhADbVk
         cFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vCDgupaxF9FrvKMBuBDmthOs0r2lweEnmWURdVv59p0=;
        b=CLnPhgUwMfQ3MYuEk6brJ72E/MpfC/83kzj9qap11IqUfkugBsJmr5l83tbjGmw+Y+
         khz/PLT7J7anccPsYkH5X8SKu/HX45ZLwyN/WyxgmpiMyGI6lqOIhRvh2/KFuoKaGlat
         ioVs2vUj+xqZYTBBtASrOW5gl+9YNck2nxU+UJhCiSpTnVXrybHj5m5FtHBZ4ahU2iTv
         Ndlnr9uZK78Yg+4sKH8K6xvLOO/UhJA3AVZvi7LhBtcUaeCwuC1qca/ycY3B0iet2o29
         dv4r4E5wEJTP4dR7XNYVcM/YhEsHOG5p2hIEf15Jtg7XJRZZZg4fE/RkQYQviIv4Evd3
         4i7Q==
X-Gm-Message-State: ALQs6tCDn1f88GK6p8xan7NpIWfTuqOKeKu2F+0ABlak6ycAkRNp6tzC
        WbMH0CJUn3D7t/iV0EqWE5j55WMu99VmoQ7LOnU=
X-Google-Smtp-Source: AIpwx49L/015Qv84G1BCI9skhqCW9LjXtZTJ7DpexXxuGP7Mubgg/tQkuwod3LddgdJeqxrpBth7GGkGsxt33JQBGjQ=
X-Received: by 10.80.208.2 with SMTP id j2mr17624034edf.44.1523571310841; Thu,
 12 Apr 2018 15:15:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 12 Apr 2018 15:14:50 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com> <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
 <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Apr 2018 15:14:50 -0700
Message-ID: <CA+P7+xrGMtbtquHohnWbfq1Fy6Smj=LAXnqM=_wXOLvHMU+F2A@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 3:02 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Thu, 12 Apr 2018, Jacob Keller wrote:
>
>> On Wed, Apr 11, 2018 at 10:42 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> >
>> > Jacob Keller <jacob.keller@gmail.com> writes:
>> >> On Wed, Apr 11, 2018 at 6:13 AM, Sergey Organov <sorganov@gmail.com> wrote:
>> >>> It was rather --recreate-merges just a few weeks ago, and I've seen
>> >>> nobody actually commented either in favor or against the
>> >>> --rebase-merges.
>> >>>
>> >>> git rebase --rebase-merges
>> >>
>> >> I'm going to jump in here and say that *I* prefer --rebase-merges, as
>> >> it clearly mentions merge commits (which is the thing that changes).
>> >
>> > OK, thanks, it's fair and the first argument in favor of
>> > --rebase-merges I see.
>>
>> I'd be ok with "--keep-merges" also.
>
> My main argument against --keep-merges is that there is no good short
> option for it: -k and -m are already taken. And I really like my `git
> rebase -kir` now...
>

Right, that's unfortunate.

> A minor argument in favor of `--rebase-merges` vs `--keep-merges` is that
> we do not really keep the merge commits, we rewrite them. In the version
> as per this here patch series, we really create recursive merges from
> scratch.

I also don't have a strong opinion in regards to --keep vs --rebase..

>
> In the later patch series on which I am working, we use a variation of
> Phillip's strategy which can be construed as a generalization of the
> cherry-pick to include merges: for a cherry-pick, we perform a 3-way merge
> between the commit and HEAD, with the commit's parent commit as merge
> base. With Phillip's strategy, we perform a 3-way merge between the merge
> commit and HEAD (i.e. the rebased first parent), with the merge commit's
> first parent as merge base, followed by a 3-way merge with the rebased
> 2nd parent (with the original 2nd parent as merge base), etc
>
> However. This strategy, while it performed well in my initial tests (and
> in Buga's initial tests, too), *does* involve more than one 3-way merge,
> and therefore it risks something very, very nasty: *nested* merge
> conflicts.

Yea, it could. Finding an elegant solution around this would be ideal!
(By elegant, I mean a solution which produces merge conflicts that
users can resolve relatively easily).

>
> Now, I did see nested merge conflicts in the past, very rarely, but that
> can happen, when two developers criss-cross merge each others' `master`
> branch and are really happy to perform invasive changes that our merge
> does not deal well with, such as indentation changes.
>
> When rebasing a merge conflict, however, such nested conflicts can happen
> relatively easily. Not rare at all.

Right. This would be true regardless of what strategy we choose, I think.

>
> I found out about this by doing what I keep preaching in this thred:
> theory is often very nice *right* until the point where it hits reality,
> and then frequently turns really useless, real quickly. Theoretical
> musings can therefore be an utter waste of time, unless accompanied by
> concrete examples.

Agreed.

>
> To start, I built on the example for an "evil merge" that I gave already
> in the very beginning of this insanely chatty thread: if one branch
> changes the signature of a function, and a second branch adds a caller to
> that function, then by necessity a merge between those two branches has to
> change the caller to accommodate the signature change. Otherwise it would
> end up in a broken state.
>
> In my `sequencer-shears` branch at https://github.com/dscho/git, I added
> this as a test case, where I start out with a main.c containing a single
> function called core(). I then create one branch where this function is
> renamed to hi(), and another branch where the function caller() is added
> that calls core(). Then I merge both, amending the merge commit so that
> caller() now calls hi(). So this is the main.c after merging:
>
>         int hi(void) {
>                 printf("Hello, world!\n");
>         }
>         /* caller */
>         void caller(void) {
>                 hi();
>         }
>
> To create the kind of problems that are all too common in my daily work
> (seemingly every time some stable patch in Git for Windows gets
> upstreamed, it changes into an incompatible version, causing merge
> conflicts, and sometimes not only that... but I digress...), I then added
> an "upstream" where some maintainer decided that core() is better called
> greeting(), and also that a placeholder function for an event loop should
> be added. So in upstream, main.c looks like this:
>
>         int greeting(void) {
>                 printf("Hello, world!\n");
>         }
>         /* main event loop */
>         void event_loop(void) {
>                 /* TODO: place holder for now */
>         }
>
> Keep in mind: while this is a minimal example of disagreeing changes that
> may look unrealistic, in practice this is the exact type of problem I am
> dealing with on a daily basis, in Git for Windows as well as in GVFS Git
> (which adds a thicket of branches on top of Git for Windows) and with the
> MSYS2 runtime (where Git for Windows stacks patches on top of MSYs2, which
> in turn maintains their set of patches on top of the Cygwin runtime), and
> with BusyBox, and probably other projects I forgot spontaneously. This
> makes me convinced that this is the exact type of problem that will
> challenge whatever --rebase-merges has to deal with, or better put: what
> the user of --rebase-merges will have to deal with.
>
> (If I got a penny for every merge conflict I resolved, where test cases
> were appended to files in t/, I'd probably be rich by now. Likewise, the
> `const char *` -> `struct object_oid *` conflicts have gotten to a point
> where I can resolve them while chatting to somebody.)
>
> Now, rebasing the original patches above (renaming core() to hi(), and
> adding caller()) will obviously conflict with those upstream patches
> (renaming core() to greeting(), and adding event_loop()). That cannot be
> avoided. In the example above, I decided to override upstream's decision
> by insisting on the name hi(), and resolving the other merge conflict by
> adding *both* event_loop() and caller().
>
> The big trick, now, is to avoid forcing the user to resolve the same
> conflicts *again* when the merge commit is rebased. The better we can help
> the user here, the more powerful will this mode be.
>
> But here, Phillip's strategy (as implemented by yours truly) runs this
> problem:
>
>         int hi(void) {
>                 printf("Hello, world!\n");
>         }
>         <<<<<<< intermediate merge
>         <<<<<<< HEAD
>         /* main event loop */
>         void event_loop(void) {
>                 /* TODO: place holder for now */
>         =======
>         =======
>         }
>         >>>>>>> <HASH>... merge head #1
>         /* caller */
>         void caller(void) {
>                 hi();
>         >>>>>>> <HASH>... original merge
>         }
>
> Now, no matter who I ask, everybody so far agreed with me that this looks
> bad. Like, really bad. There are two merge conflicts, obviously, but it is
> not even clear which conflict markers belong together!
>
> It gets a little better when I take a page out of recursive merge's
> playbook, which uses different marker sizes for nested merge conflicts
> (which I of course implemented and pushed to `sequencer-shears`, currently
> still in an unpolished state):
>
>         int hi(void) {
>                 printf("Hello, world!\n");
>         }
>         <<<<<<< intermediate merge
>         <<<<<<<< HEAD
>         /* main event loop */
>         void event_loop(void) {
>                 /* TODO: place holder for now */
>         ========
>         =======
>         }
>         >>>>>>> <HASH>... merge head #1
>         /* caller */
>         void caller(void) {
>                 hi();
>         >>>>>>>> <HASH>... original merge
>         }
>
> At least now we understand which conflict markers belong together. But I
> still needed to inspect the intermediate states to understand what is
> going on:
>
> After the first 3-way merge (the one between the original merge commit and
> HEAD), we have the conflict markers around event_loop() and caller(),
> because they had been added into the same spot.
>
> The second 3-way merge would also want to add the event_loop(), but not
> caller(), so ideally it should see that event_loop() is already there and
> not add any conflict markers. But that is not the case: event_loop() was
> added *with conflict markers*.
>
> So those conflict markers in the first 3-way merge *cause* the conflicts
> in the second 3-way merge!
>
> And indeed, if we merge the other way round (original merge with 2nd
> parent, then with 1st parent), the result looks much better:
>
>         int hi(void) {
>                 printf("Hello, world!\n");
>         }
>         /* main event loop */
>         void event_loop(void) {
>                 /* TODO: place holder for now */
>         }
>         <<<<<<<< HEAD
>         ========
>         /* caller */
>         void caller(void) {
>                 hi();
>         }
>         >>>>>>>> <HASH>... intermediate merge
>
> So: the order of the 3-way merges does matter.
>
> I did implement this, too, in the `sequencer_shears` branch: if the first
> 3-way merge causes conflicts, attempt the second one, and if that one is
> clean, try merging that merge result into HEAD (forgetting about the first
> attempted 3-way merge).
>
> That is still unsatisfying, though, as it is easy to come up with a
> main2.c in the above example that requires the *opposite* merge order to
> avoid nested conflicts.

I agree, this solution won't work reliably because we can show
examples which fail the opposite way.

>
> The only way out I can see is to implement some sort of "W merge" or
> "chandelier merge" that can perform an N-way merge between one revision
> and N-1 other revisions (each of the N-1 bringing its own merge base). I
> call them "W" or "chandelier" because such a merge can be visualized by
> the original merge commit being the center of a chandelier, and each arm
> representing one of the N-1 merge heads with their own merge bases.
>

I think this approach sounds reasonable.

> Similar to the 3-way merge we have implemented in xdiff/xmerge.c, this
> "chandelier merge" would then generate the two diffs between merge base
> and both merge heads, except not only one time, but N-1 times. It would
> then iterate through all hunks ordered by file name and line range. Any
> hunk without conflicting changes would be applied as-is, and the remaining
> ones be turned into conflicts (handling those chandelier arms first where
> both diffs' hunks look identical).
>
> Have I missed any simpler alternative?

I *think* this would work well if I understand it, but it's difficult
to process without examples.

>
> Ciao,
> Johannes
