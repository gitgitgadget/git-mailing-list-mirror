Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34E21F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeC0FIo (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:08:44 -0400
Received: from mail.javad.com ([54.86.164.124]:34041 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeC0FIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:08:43 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id EAFC73EA25;
        Tue, 27 Mar 2018 05:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522127322;
        bh=pVcSuZFfur7IjfqW6Nnq2zZPF7T7O6Gk3fsOmUvwt7M=; l=5551;
        h=Received:From:To:Subject;
        b=BNtg6QuFEqOrY+UmBhZku1UvwQaONSke9hWShDtEjN/nCahZt4vtVYxuSxR8eAZ8J
         j76Muh9ziHiRpWtYfFpX/eT1M3vzagI2l5mQFIRMw3o5OGcMFuS1ae5g20Om/0BT0V
         zB/hYVv0tFRZybXrCQH54hv02hUhZPBDZZZRGFq0=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f0gqd-00008B-Tz; Tue, 27 Mar 2018 08:08:39 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
        <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
        <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
        <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8plh2qd.fsf@javad.com>
        <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com>
        <nycvar.QRO.7.76.6.1803261351070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:08:39 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803261351070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 26 Mar 2018 14:03:42 +0200
        (DST)")
Message-ID: <87muyugl60.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Buga,
>
> On Tue, 13 Mar 2018, Igor Djordjevic wrote:
>
>> On 12/03/2018 13:56, Sergey Organov wrote:
>> > 
>> > > > I agree with both of you that `pick <merge-commit>` is inflexible
>> > > > (not to say just plain wrong), but I never thought about it like
>> > > > that.
>> > > >
>> > > > If we are to extract further mentioned explicit old:new merge
>> > > > parameter mapping to a separate discussion point, what we`re
>> > > > eventually left with is just replacing this:
>> > > >
>> > > > 	merge -R -C <original--merge-commit> <merge-head>
>> > > >
>> > > > ... with this:
>> > > >
>> > > > 	pick <original--merge-commit> <merge-head>
>> > >
>> > > I see where you are coming from.
>> > >
>> > > I also see where users will be coming from. Reading a todo list in
>> > > the editor is as much documentation as it is a "program to execute".
>> > > And I am afraid that reading a command without even mentioning the
>> > > term "merge" once is pretty misleading in this setting.
>> > >
>> > > And even from the theoretical point of view: cherry-picking
>> > > non-merge commits is *so much different* from "rebasing merge
>> > > commits" as discussed here, so much so that using the same command
>> > > would be even more misleading.
>> > 
>> > This last statement is plain wrong when applied to the method in the
>> > [RFC] you are replying to.
>
> That is only because the RFC seems to go out of its way to break down a
> single merge commit into as many commits as there are merge commit
> parents.

Complex entity is being split for ease of reasoning. People tend to use
this often.

> This is a pretty convoluted way to think about it: if you have three
> parent commits, for example, that way of thinking would introduce three
> intermediate commits, one with the changes of parent 2 & 3 combined, one
> with the changes of parent 1 & 3 combined, and one with the changes of
> parent 1 & 2 combined.

No.

> To rebase those commits, you essentially have to rebase *every parent's
> changes twice*.

No.

> It gets worse with merge commits that have 4 parents. In that case, you
> have to rebase every parent's changes *three times*.

Sorry, the [RFC] has nothing of the above. Once again, it's still just
as simple is: rebase every side of the merge then merge the results
using the original merge commit as a merge base.

And if you can't or don't want to grok the explanation in the RFC, just
forget the explanation, no problem.

> And so on.
>
>> > Using the method in [RFC], "cherry-pick non-merge" is nothing more or
>> > less than reduced version of generic "cherry-pick merge", exactly as
>> > it should be.
>
> I really get the impression that you reject Phillip's proposal on the
> ground of not being yours. In other words, the purpose of this here
> argument is to praise one proposal because of its heritage, rather than
> trying to come up with the best solution.

No. As the discussion evolved, I inclined to conclusion that modified
Phillip's algorithm is actually better suited for the implementation
[1].

> On that basis, I will go with the proposal that is clearly the simplest
> and does the job and gets away with avoiding unnecessary work.

These algorithms are actually the same one, as has already been shown
elsewhere in the discussion. Asymmetric incremental nature of the
Phillip's one is apparently better suited for naturally asymmetrical way
Git already handles merging. FYI, here is the latest proposal that came
out of discussion [1]:

git-rebase-first-parent --onto A' M
tree_U1'=$(git write-tree)
git merge-recursive B -- $tree_U1' B'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
[ $conflicted_last_merge = "yes" ] ||
  trees-match $tree_U1' $tree || 
  stop-for-user-amendment

where 'git-rebase-first-parent' denotes whatever machinery is currently
being used to rebase simple non-merge commit.

>
>> > Or, in other words, "cherry-pick merge" is generalization of
>> > "cherry-pick non-merge" to multiple parents.
>> 
>> I think Sergey does have a point here, his approach showing it.
>
> His approach is showing that he wants to shoehorn the "rebase a merge
> commit" idea into a form where you can cherry-pick *something*.
>
> It does not have to make sense. And to me, it really does not.

Except that Phillip's one does exactly this as well, only in incremental
manner, as shown in [1].

>
>> Phillip`s simplification might be further from it, though, but we`re 
>> talking implementation again - important mental model should just be 
>> "rebasing a commit" (merge or non-merge), how we`re doing it is 
>> irrelevant for the user, the point (goal) is the same.
>
> Except that Phillip's simplification is not a simplification. It comes
> from a different point of view: trying to reconcile the diverging
> changes.

They are essentially the same as one easily converts to another and back
[1]. They will only bring different user experience in case of
conflicts.

> Phillip's is a true generalization of the "rebase vs merge" story: it is
> no longer about merging, or about rebasing, but about reconciling
> divergent commit histories, with whatever tool is appropriate.

Whatever. They are essentially the same thing. The only difference is
incremental vs parallel [1].

References:

[1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com/

-- Sergey
