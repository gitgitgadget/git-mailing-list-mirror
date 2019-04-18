Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFA520248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfDRSAj (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:00:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42427 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390388AbfDRSAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id v22so2650414lje.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oD84o5+7rBQoOPZFnh82DDzpQhdawm2wKaQWHgnBeWo=;
        b=rU171XnuaoDVSJAA6+wHEcvMT6JNPB/NPCVc1Xd/zM8z3CiC6APLaKMuldZZ8VpeOm
         aJ37yUVMMXf3XBURYkVPm9oaJV5cReIh9KhQkGCmfof/8K5f7/foCypU4GsZMtJo34Cz
         mdcnzqy4uRkEgaTcHh4pgFOHlYK6nWHGSEKYntnsKgHBTHouReZCBxVjfx6r0MnnZ1tw
         KJ1QR5BeTCyQl6Y0bhSJcSlKWQpFzxEOldf1X0qporpktxL462MNpT9Q4eMEbN/nqB37
         Erz04AwLBeNEna+g4h6ccvRyrxFISRvOkCqf6rACQQ19umKxjJD9Tkr5bhLebSGsOQFq
         bk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oD84o5+7rBQoOPZFnh82DDzpQhdawm2wKaQWHgnBeWo=;
        b=Yn99Dsj8eotDkHvh7qoAehlImjnho9x69QVjdXKKnGy5DsIfP2//JXE9eIx4+ghMrr
         DBVmJjZMUJhOunXo5U6Bt7uSqlDm7v58b27pD2PTF7ds7pFTBZNRbO9634KYb3yXGfdg
         YyPZvlQylUyZ01AX0hzCoSGVD1lVIcYI5t/NRf8bofl41HJ9fnd8M3thZUseNoSMdLP5
         SrNCmALzny0lQlOAVKmgMxBxu8LTafp5COqlrYDwgPPZkmhiiru89uFZvGRBbxBNkcdH
         Xvx0TmxS16hYPePfCDtLcZIpJmbzokr8GT7/uFWpCUBYs+i53ZVD1pBT0rMfPI9fYPJN
         penA==
X-Gm-Message-State: APjAAAUdVuZVuSmJNaEejADSkWcOCqHSBUMCWjp+W4qY9o6HcTOyJcJo
        HcYBUhnDpSK5ZeCYeBXUYPU7YjfyB4G1n37K8Q7Y14rB
X-Google-Smtp-Source: APXvYqyX9cno3WggJC8HRbWKjXbB/S3UGWfgJtcYeea2hh0p4ZAYE9PObb/kh0Kg+QZd9VPKF4skMRkHyVFl8rEqOj4=
X-Received: by 2002:a2e:8618:: with SMTP id a24mr4350422lji.192.1555610435493;
 Thu, 18 Apr 2019 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
 <878sw8bbby.fsf@evledraar.gmail.com> <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com>
 <86o953z0b9.fsf@gmail.com>
In-Reply-To: <86o953z0b9.fsf@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 18 Apr 2019 11:00:23 -0700
Message-ID: <CABURp0r_0pTY9JAsphm-TUBVCarK8h8SmO-v8zf7OPzf+7=SJw@mail.gmail.com>
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wouldn't we need to extend this to cherry-pick, too?  Suppose I do this:

    $ git log -2 --oneline --decorate foo
    abcd123456  (foo)   Revert 123456aaaa
    123456aaaa  Some useful commit for the future, but not now

    $ git checkout bar
    $ git cherry-pick foo^ foo

    $ git log -2 --oneline --decorate
    badc0ffee  (bar)   Revert 123456aaaa
    babeface0  Some useful commit for the future, but not now

Now when I rebase bar, the revert appears to be untwinned.

Similar problems arise for other history modifying tools like
filter-branch, fast-export, reposurgeon, bfg, etc.

I guess we can use 'git patch-id' to see if the companion commit is
still in our history, but this seems tenuous.  Can we make it work
anyway?


On Thu, Apr 18, 2019 at 10:33 AM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >> On Wed, Apr 17 2019, Giuseppe Crin=C3=B2 wrote:
> >>
> >>> The feature I'm asking is to add an extra-step during rebasing,
> >>> checking whether there's a reference to a commit that's not going to
> >>> be included in history and asks the user whether the heuristics is
> >>> correct and if she wants to update those references.
> >>>
> >>> Scenario: it can happen for a commit message to contain the ID of an
> >>> ancestor commit. A typical example is a commit with the message
> >>> "revert 01a9fe8". If 01a9fe8 and the commit that reverts it are
> >>> involved in a rebase the message "revert 01a9fe8" is no longer valid
> >>> -- the old 01a9fe8 has now a different hash. This will most likely be
> >>> ignored by the person who's rebasing but will let the other people
> >>> reading history confused.
> >>
> >> This would be useful. Done properly we'd need some machinery/command t=
o
> >> extract the commit id parts from the free-text of the commit
> >> message. That would be useful for other parts of git, e.g. as discusse=
d
> >> here:
> >> https://public-inbox.org/git/xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.=
com/
> >
> > That's a helpful input.
> >
> > But in general we do not have an infrastructure to systematically
> > keep track of "this commit was rewritten to produce that other
> > commit", so even if a mention of an old/superseded commit can be
> > identified reliably, there is no reliable source to rewrite it to
> > the name of the corresponding commit in the new world.
> >
> > For that mapping, we'd need something like the "git change/evolve"
> > Stefan Xenos was working on, which hasn't materialized.
>
> Well, what about limiting changes and rewriting only to the commits
> being rewritten by [interactive] rebase?  I mean that we would rewrite
> "revert 01a9fe8" only if:
>
> a.) the commit with this message is undergoing rewrite
> b.) the commit 01a9fe8 is undergoing rewrite in the same command
>
> We could use the infrastructure from git-filter-branch for this.
>
> It is serious limitation, but that might be good enough for Giuseppe
> Crin=C3=B2 use case.  Though for example there is a question what to do i=
f
> referred-to commit (01a9fe8 in the example) is simply dropped, or is
> gets split in two?  Ask user?
>
>
> Another possibility would be to provide a command line option to rebase
> which would automatically generate replacements (in git-replace meaning)
> from old pre-rebase name to new post-rebase name (assuming no splitting,
> no dropping commits).  This would make references just work... well, as
> long as refs/replace/* are in place (they are not copied by default).
>
> On the other hand some of our performance-improving features, like the
> commit-graph, do not work if there are replacements.
>
>
> Best,
> --
> Jakub Nar=C4=99bski
