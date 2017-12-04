Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BD420C11
	for <e@80x24.org>; Mon,  4 Dec 2017 02:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbdLDCdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 21:33:39 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38494 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbdLDCdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 21:33:38 -0500
Received: by mail-wm0-f44.google.com with SMTP id 64so11663966wme.3
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 18:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shHccSkGps+vKRfClNmV5FOKslfnuWZabo6ClNRgzJg=;
        b=GW2Uvn204nUtfi4HUveZoxsg/TwANGUMF1iBft3EMyuV4oYvkkEr2Hx4J3LoexAeTE
         hEIMRcW6b8vDpyh+zb3ClO4aFF78EiN5P0lowo7llNXMDKidDB/OocA1JE15UI0L9phv
         CcKeClOm7G3CVQmcU1bvhTk1d9QD5iwpG/hCEkakFjPHuFBdpOISH2cJS9+pcOMpX54d
         qQqGs0MJFaAKiBsbVeRSnx/1uTi2eXnRPtWTFOCDR1RLEk1dbz05KtZYZRoaKJ8kbJ+N
         Q6Vz0YL/vdkyIr1KxGF95MUeydxc0xvnDKlmHxFI8y/chbGeV9wKqad/vNuzz2w3Quiz
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shHccSkGps+vKRfClNmV5FOKslfnuWZabo6ClNRgzJg=;
        b=YehW4jxjkTO5g9XPZ5j1BvhlUrEOyQJYkPtdUYF0yZQU0kOWCCdTGqkRcjtZXmqImp
         ElTcr/K416e4/ZLnteZrSUJ2n28+dPYCRHhXo+h+FuJTz7afr6ranoYfXEYBibGb3dOH
         wo6k1J4BGbnUHNb7B3C1z9Rc5t/i0zdZzcyB2lE7YRZOkNLCop9mp8jRn7b5s1jk9WPR
         ytpStsUEio3PzZ+JRcyRml5bCR7WGF71mwILVj6wMjPsK8NLJL9l3M7TU5MLBqlDfP2Z
         sEs7OXQFsBddPgzQ3ovrhFJgOv+RanPoDx/qXxQ2ngKyfR8A4Nd5bnyJtH719hhQXk66
         Yelg==
X-Gm-Message-State: AKGB3mLKrUReMM0nEwpmjzBySkHDXRARbU3wowb55vWhx4OUj9yx5tso
        S2dLT69hHiitkLISHw6mij4=
X-Google-Smtp-Source: AGs4zMZtzNhRnwATqct1IfAEKqYvSOvzjc9+RLAiVTF/sfZYPJJbmwncq4CRN6XboWaT2qxOQR28ew==
X-Received: by 10.28.128.214 with SMTP id b205mr6664760wmd.82.1512354816595;
        Sun, 03 Dec 2017 18:33:36 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id d9sm13145020wrf.45.2017.12.03.18.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 18:33:35 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
Date:   Mon, 4 Dec 2017 03:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On 01/12/2017 18:23, Johannes Sixt wrote:
> 
> > To work with `--onto-parent` and be able to commit on top of any of
> > the topic branches, you would need a situation like this instead:
> >
> >   (1)  ...C      <- topic C
> >           |
> >      ...A |      <- topic A
> >          \|
> >        ...o I    <- integration
> >          /|
> >      ...B |      <- topic B
> >           |
> >        ...D      <- topic D
> 
> This is a very, VERY exotic workflow, I would say. How would you
> construct commit I when three or more topics have conflicts?
> merge-octopus does not support this use-case.

But I`m not interested in constructing commit I in the first place, 
only help working with it once it`s already there (which shouldn`t be 
too uncommon in case of unrelated, non-conflicting topics) - but I 
already agreed my example could have been a bit too esoteric, 
distracting attention from the important part :)

I`ll continue on this further below, where you commented on those 
more common scenarios.

Here, let`s try to look at the whole situation from a "patch queue" 
perspective instead, starting from something like this:

(5) ---O---I  <- integration <- HEAD

... and then making progress like this - first, commit A1 onto O, 
starting "topicA" branch at the same time, even, maybe using syntax 
like `git commit --onto-parent O -b topicA`:

(6) ---O---J  <- integration <- HEAD               [ J = I + A1 ]
        \ /
         A1   <- topicA

..., then commit B1 onto O to start "topicB" branch:

(7)      B1   <- topicB
        / \
    ---O---K  <- integration <- HEAD               [ K = J + B1 ]
        \ /
         A1   <- topicA

..., then add one more commit (patch) onto B1:

(8)      B1---B2   <- topicB
        /      \
    ---O--------L  <- integration <- HEAD          [ L = K + B2 ]
        \      /
         A1---/    <- topicA

..., and one more, B3:

(9)      B1---B2---B3   <- topicB
        /           \
    ---O-------------M  <- integration <- HEAD     [ M = L + B3 ]
        \           /
         A1--------/    <- topicA

We can also start a new topic branch (queue), commit C1:

(10)     B1---B2---B3   <- topicB
        /           \
    ---O-------------N  <- integration <- HEAD     [ N = M + C1 ]
       |\           /|
       | A1--------/ /  <- topicA
       \            /
        C1---------/    <- topicC

And lets make one more "topicA" related commit A2:

(11)     B1---B2---B3   <- topicB
        /           \
    ---O-------------P  <- integration <- HEAD     [ P = N + A2 ]
       |\           /|
       | A1---A2---/ /  <- topicA
       \            /
        C1---------/    <- topicC


Notice how HEAD never leaves "integration" branch, and underlying 
commit is recreated each time? It`s like a live branch we`re working 
on, but we`re not actually committing to.

No branch switching (and no working tree file changes caused by it), 
and we`re working on multiple topics/branches simultaneously, being 
able to instantly test their mutual interaction as we go, but also 
creating their separate (and "clean") histories at the same time.

I guess this would make most sense with simple topics we _could_ 
practically work on at the same time without making our life too 
complicated - what stands for "git add --patch", too, when working on 
multiple commits at the same time.

Once satisfied, of course each topic branch would need to be tested 
separately, and each commit, even - all the same as with "git add 
--patch" commits.

And "git add --patch" can still be used here, too, to distribute 
partial changes, currently existing together inside the working tree, 
to different topic branches, at the time of making the commit itself.

Does this approach make more sense in regards to "git commit 
--onto-parent" functionality I`m having in mind? Or I`m dreaming too 
much here...? :)

> > Once there, starting from your initial position:
> >
> > >     ...A    ...C            <- topics A, C
> > >         \       \ E
> > >       ---o---o---o---o I    <- integration <- HEAD
> > >             /       /
> > >         ...B    ...D        <- topics B, D
> >
> > ... and doing something like `git commit --onto B --merge` would
> > yield:
> > 
> >     (3) ...A    ...C            <- topics A, C
> >           \       \ E
> >         ---o---o---o---o I'   <- integration
> >               /       /|
> >           ...B    ...D |      <- topic D
> >               \        |
> >                f-------'      <- topic B
> >
> > ... where (I' = I + f) is still true.
> 
> I am not used to this picture. I would not think that it is totally
> unacceptable, but it still has a hmm-factor.

Main idea is not to pile up uninteresting merge commits inside 
(throwaway) integration branch, needlessly complicating history, but 
pretend as we just made the integration merge, where fixup commit f 
was already existing in its topic branch prior the merge.

> > If that`s preferred in some
> > cases, it could even look like this instead:
> >
> >   (4) ...A    ...C             <- topics A, C
> >           \       \ E  I
> >         ---o---o---o---o---F   <- integration
> >               /       /   /
> >           ...B    ...D   /     <- topic D
> >               \         /
> >                f-------'       <- topic B
> >
> > ... where F(4) = I'(3), so similar situation, just that we don`t
> > discard I but post F on top of it.
> 
> This is very acceptable.

And I can see logic behind this case, too (alongside that other one, 
where they can both be supported, for different scenarios).

> Nevertheless, IMO, it is not the task of git-commit to re-compute a
> merge commit. It would be OK that it commits changes on top of a
> branch that is not checked out. Perhaps it would even be OK to remove
> the change from the current workspace (index and worktree), because
> it will return in the form of a merge later, but producing that merge
> is certainly not the task of git-commit.

Just to make sure we`re on the same page - you mean conceptually, or 
practically? Or both...? :)

Because practically, we don`t do any merge operations/computations 
(as can be seen inside the script), so we really don`t produce any 
merges :)

Having a merge commit being updated as an outcome is just a 
consequence of altering our history to pretend fixup commit already 
existed elsewhere, being brought into our current state from there - 
and that "current state" is updated accordingly to reflect the change 
we made in the history that led to it.

Let`s look at a different example, no merges involved:

(12) ---A---B---C---D  <- HEAD

Here, we can do `git commit --onto-parent C` to make the history look 
like this:

(13) ---A---B---C---E---D'  <- HEAD

..., where we practically inserted commit E between our HEAD and 
commit C, causing D to be updated to D' accordingly (rebased, 
practically).

Idea is the same with merges involved, updating HEAD commit to 
reflect altered history.

In situation (12), we could also do `git commit --onto-parent C 
--amend`, ending up with history like this instead:

(14) ---A---B---F---D'  <- HEAD

..., where F is amended C, E being added to it, instead of being a 
separate commit.

So there are quite some possibilities here.

But as said, I can understand a wish to have a commit elsewhere 
without "merging" it in, too (changes removed from current workspace), 
or "merging" it inside a separate commit (not updating existing 
HEAD one).

And saying that, making the merge commit at the same time could then 
be observed as no more than a shortcut, too, like being able to 
create a new branch on checkout using "-b" option.

So even conceptually, it would make sense to wish for something like 
this:

(15) git commit --onto B --merge

..., producing that graph (4) shown in the quote above, I would 
think? 

But even in that case, do note no merge is really happening, we just 
alter history of our current state, where we already are.

Splitting changes out of HEAD to a commit directly preceding it, on a 
different branch, and still keeping those changes in HEAD, naturally 
causes our current HEAD state to have multiple parents, what is 
perceived as a merge commit, even without a merge operation leading 
to it.

Thus, `git commit` seems it should be up to the task, whichever 
approach user opts for :)

Regards, Buga
