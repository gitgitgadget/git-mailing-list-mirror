Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00511F404
	for <e@80x24.org>; Sun, 18 Feb 2018 04:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBREQ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Feb 2018 23:16:58 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55200 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBREQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Feb 2018 23:16:57 -0500
Received: by mail-wm0-f45.google.com with SMTP id z81so9486572wmb.4
        for <git@vger.kernel.org>; Sat, 17 Feb 2018 20:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9UBixxe68tF99UuI8acuRfMpk5UcVAbbcCa2GAaJCy8=;
        b=pb1X0FLczJap2bvjXHyDlOuihtt8Hs7JsdFodJGJqf6L/IIfuRMqPboDXe//9g6LtZ
         vRZPEAaqmAoU+bCtRgOZbPV/zprdfqB5Qws+yY1kSdkOHPmSQvOVbl9rUXlSmrZFto3a
         hjSTIH+Aws0DjENSwi74IvlFsbt83OQF4EMgTBC9aaTies+1Yb6JyxlTU9YDy1x385yV
         6QWtFXvdxwG1tDa2D/vH+OVAJzkEsmJQmnIf49JFJEW928zkxiHo+X3PQ9xciTOwSqrb
         1sGkLOL7ObedqUyTv3kL2WCpNDnHfggFcIBZm/kkEj9QBB9MTL7gV00b6iQmYuRdtK7/
         DwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9UBixxe68tF99UuI8acuRfMpk5UcVAbbcCa2GAaJCy8=;
        b=gqqBFqt4a6NJA3MIF4xRNRUH+pSZbRX0aLLZAzHJDhRsEpxpBcw8IPQLhU3IiTc3GC
         7C9Y/buTKPjENGsil1+DClzqRZGu48XxTMEeX2WJVK5uOod4KL8IhQGlrU9m9RHvyw/q
         vHbeWhOCw+5ht0gPpyQ89wc0JN0HCexgHWLaqwXoTgO/EEmk2SzCWaxVYU6QVsFyidz8
         4jtLFtzwdTtjtkkkEkzT1rG7vJQX0E7ymfUGd+nfd0/LFTPKn5iqjhxf9Ci/bpKxguhM
         rJUiWDNFU9HOrzU6o6kp9tCfnCAQ5o57RHV4/2mSk6f/YJtUYkm+MwU1jzJFncO10u1I
         jm5w==
X-Gm-Message-State: APf1xPAeMMNKyn8Aq/qRBibOtJnRsFKT7NcKOmevDwskPSVF2m0Pj4pc
        G0Vn8Nt1L20AkkH9uwBm0MovIQK8wLBCsxBbT7s=
X-Google-Smtp-Source: AH8x224n10FnXDa561bS1bnv44malfhjVYWwqMiy8t/lqhmfP3NSItSvgPibS1e9CURWJrpQ2BkP6xMVW0zWWf6KSyQ=
X-Received: by 10.80.139.5 with SMTP id l5mr12803269edl.265.1518927415409;
 Sat, 17 Feb 2018 20:16:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Sat, 17 Feb 2018 20:16:34 -0800 (PST)
In-Reply-To: <87y3jtqdyg.fsf@javad.com>
References: <87y3jtqdyg.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 17 Feb 2018 20:16:34 -0800
Message-ID: <CA+P7+xrgmSHv-coOdUAmBm31Sd0DzYdoez=tVO8drew9q7DExw@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 5:08 AM, Sergey Organov <sorganov@gmail.com> wrote:
> Hi,
>
> By accepting the challenges raised in recent discussion of advanced
> support for history rebasing and editing in Git, I hopefully figured out
> a clean and elegant method of rebasing merges that I think is "The Right
> Way (TM)" to perform this so far troublesome operation. ["(TM)" here has
> second meaning: a "Trivial Merge (TM)", see below.]
>
> Let me begin by outlining the method in git terms, and special thanks
> here must go to "Johannes Sixt" <j6t@kdbg.org> for his original bright
> idea to use "cherry-pick -m1" to rebase merge commits.
>
> End of preface -- here we go.
>

I hope to take a more detailed look at this, also possibly with some
attempts at re-creating the process by hand to see it in practice.

> Given 2 original branches, b1 and b2, and a merge commit M that joins
> them, suppose we've already rebased b1 to b1', and b2 to b2'. Suppose
> also that B1' and B2' happen to be the tip commits on b1' and b2',
> respectively.
>
> To produce merge commit M' that joins b1' and b2', the following
> operations will suffice:
>
> 1. Checkout b2' and cherry-pick -m2 M, to produce U2' (and new b2').
> 2. Checkout b1' and cherry-pick -m1 M, to produce U1' (and new b1').
> 3. Merge --no-ff new b2' to current new b1', to produce UM'.
> 4. Get rid of U1' and U2' by re-writing parent references of UM' from
>    U1' and U2' to  B1' and B2', respectively, to produce M'.
> 5. Mission complete.
>

Seems pretty straight forward, go to each branch and cherry-pick the
merge respective to its relative parent, and then finally re-merge
everything, and consume the intermittent commits.

> Let's now see why and how the method actually works.
>
> Firs off, let me introduce you to my new friend, the Trivial Merge, or
> (TM) for short. By definition, (TM) is a merge that introduces
> absolutely no differences to the sides of the merge. (I also like to
> sometimes call him "Angel Merge", both as the most beautiful of all
> merges, and as direct antithesis to "evil merge".)
>
> One very nice thing about (TM) is that to safely rebase it, it suffices
> to merge its (rebased) parents. It is safe in this case, as (TM) itself
> doesn't posses any content changes, and thus none could be missed by
> replacing it with another merge commit.
>
> I bet most of us have never seen (TM) in practice though, so let's see
> how (TM) can help us handle general case of some random merge. What I'm
> going to do is to create a virtual (TM) and see how it goes from there.
>
> Let's start with this history:
>
>   M
>  / \
> B1  B2
>
> And let's transform it to the following one, contextually equivalent to
> the original, by introducing 2 simple utility commits U1 and U2, and a
> new utility merge commit UM:
>
>   UM
>  /  \
> U1   U2
> |    |
> B1   B2
>
> Here content of any of the created UM, U1, and U2 is the same, and is
> exact copy of original content of M. I.e., provided [A] denotes
> "content of commit A", we have:
>
> [UM] = [U1] = [U2] = [M]
>
> Stress again how these changes to the history preserve the exact content
> of the original merge ([UM] = [M]), and how U1 an U2 represent content
> changes due to merge on either side[*], and how neither preceding nor
> subsequent commits content would be affected by the change of
> representation.
>
> Now observe that as [U1] = [UM], and [U2] = [UM], the UM happens to be
> exactly our new friend -- the "Trivial Merge (TM)" his true self,
> introducing zero changes to content.
>
> Next we rebase our new representation of the history and we get:
>
>   UM'
>  /  \
> U1'  U2'
> |    |
> B1'  B2'
>
> Here UM' is bare merge of U1' and U2', in exact accordance with the
> method of rebasing a (TM) we've already discussed above, and U1' and U2'
> are rebased versions of U1 and U2, obtained by usual rebasing methods
> for non-merge commits.
>
> (Note, however, that at this point UM' is not necessarily a (TM)
> anymore, so in real implementation it may make sense to check if UM' is
> not a (TM) and stop for possible user amendment.)
>

This might be a bit tricky for a user to understand what the process
is, especially if they don't understand how it's creating special U1'
and U2' commits. However, it *is* the cleanest method I've either seen
or thought of for presenting the conflict to the user.

> Finally, to get to our required merge commit M', we get the content of
> UM' and record two actual parents of the merge:
>
>   M'
>  / \
> B1' B2'
>
> Where [M'] = [UM'].
>
> That's it. Mission complete.
>
> I expect the method to have the following nice features:
>
> - it carefully preserves user changes by rebasing the merge commit
> itself, in a way that is semantically similar to rebasing simple
> (non-merge) commits, yet it allows changes made to branches during
> history editing to propagate over corresponding merge commit that joins
> the branches, even automatically when the changes don't conflict, as
> expected.
>

Right.

> - it has provision for detection of even slightest chances of ending up
> with surprising merge (just check if UM' is still (TM)), so that
> implementation could stop for user inspection and amendment when
> appropriate, yet it is capable of handling trivial cases smoothly and
> automatically.

Nice!

>
> - it never falls back to simple invocation of merge operation on rebased
> original branches themselves, thus avoiding the problem of lack of
> knowledge of how the merge at hand has been performed in the first
> place. It doesn't prevent implementation from letting user to manually
> perform whatever merge she wishes when suspect result is automatically
> detected though.
>

Right, since we're re-creating the intermittent commits U1' and U2'
first based on the original merge, that's how we manage to maintain
the result of the merge. I like it.

> - it extends trivially to octopus merges.
>
> - it appears shiny to the point that it will likely be able to handle
> even darkest evil merges nicely, no special treatment required.
>

Yep, and I like that it has a pretty reasonable way of presenting
conflicts for resolution. It may be a bit tricky to explain the use of
the intermittent commits U1' and U2' though.

> Footnote:
>
> [*] We may as well consider the (UM,U1,U2) trio to be semantically split
> representation of git merge commit, where U1 and U2 represent content
> changes to the sides, and UM represents pure history joint. Or, the
> other way around, we may consider git merge commit to be optimized
> representation of this trio. I think this split representation could
> help to simplify reasoning about git merges in general.

Yes, I think this concept is pretty useful. I think it could be useful
as a way of showing how the merge worked.

Thanks,
Jake

>
> -- Sergey
