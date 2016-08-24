Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22481F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbcHXWhc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:37:32 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37750 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756158AbcHXWhb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:37:31 -0400
Received: by mail-it0-f50.google.com with SMTP id f6so60656494ith.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fSvlMcgXeHiPiGiLaCrDEw8IaewhNeKbqAhULBYFItg=;
        b=Q08sKdT4rfN5aKZ87SU27SNrzo6zhu5D2lI9PtatRlMegLupO9KLiJfSog0PUnWwRC
         iiSGQFc2qsdlcs4fuEw1gkgihfoJotvJEDk1WbWIxaAoFtha/iGV9LnZVyoJQiYAZd+k
         jHdfa5jz4NJmbpJ7H8tVg4kEuwRtDDaSyzZUBTcUbav6FDk1nRN0uUUL6OSQXRQa7qsH
         WD8gEUX13eOibbjf1iVIhQqbbiHZNlXvptyuFOWrUJ9GYVuhgVrKpNbSFj3nEwDvCP/8
         r3LW2HjRwtmBY60+QTkgGV8vssuEdU8igEh/8FyiXe7XnHwhJwMb6s/vUJAl8QNxhR73
         wpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fSvlMcgXeHiPiGiLaCrDEw8IaewhNeKbqAhULBYFItg=;
        b=TmVJddqK1xGzqhmg5kqWKOad3l3pg9VraDeH/EWKSbmFbCzNA8YWupYxb3FD0kBzZK
         n7nhMLYbB8TxQML6X5bEiLHXMFf1GXHPSD0xwE34XXb9VmHlaOAAM780oNCDsJUDoytg
         7GpLJZMTRc02cm8dppUkJhiEX47W8njYbbml49Hj/RFABSbw3H3tYEeZ3EDMa4sHnTao
         UN+/b6IE33ux2lrzvWqBCHfnG0GjHzVt3Q/n7pNhNrB5v79PpMmrbVm4+Xxz85+JOCzn
         OOzZjwxHB59HAwKYy8TlY3br959c0iBQY6Kj2tJV+VHm3iIk/kfTtFRWD5nULaiQ1sOn
         NLMQ==
X-Gm-Message-State: AEkoouvdEgLQadguIT49WWjD9tTnH1eSgf95Luc7cYHxwLWSa3bt/on/nGnQJWUQ+H0v9bSMxsSIQ/i5l5mq/U/v
X-Received: by 10.107.178.129 with SMTP id b123mr6910138iof.83.1472078250584;
 Wed, 24 Aug 2016 15:37:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 24 Aug 2016 15:37:29 -0700 (PDT)
In-Reply-To: <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
References: <20160824173017.24782-1-sbeller@google.com> <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 Aug 2016 15:37:29 -0700
Message-ID: <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
Subject: Re: [PATCHv2] push: change submodule default to check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
> This seems to be dropped from the list, probably due to no "To:"
> header in the original, which led to "no", "To-header" "on" and
> "input <" on YOUR recipient list, so I am quoting it in full without
> trimming.
>
>> On Wed, Aug 24, 2016 at 10:30:17AM -0700, Stefan Beller wrote:
>>
>>> When working with submodules, it is easy to forget to push the submodules.
>>> The setting 'check', which checks if any existing submodule is present on
>>> at least one remote of the submodule remotes, is designed to prevent this
>>> mistake.
>>>
>>> Flipping the default to check for submodules is safer than the current
>>> default of ignoring submodules while pushing.
>>
>> It is safer, and that's good. But it's also slower, because it requires
>> an extra traversal of all of the pushed commits. And now people will
>> have to pay the price even if they are not using submodules at all.
>>
>> For instance, try this from a checkout of linux.git:
>>
>>   for i in no check; do
>>       rm -rf dst.git
>>       git init --bare dst.git
>>       echo "==> Pushing with submodules=$i"
>>       time git push --recurse-submodules=$i dst.git HEAD
>>   done
>>
>> The second case takes 30-40 seconds longer. This is a full push of
>> history, so it's an extreme case[1], but it's still rather unfortunate.
>>
>> Can we tie this default to some sign that submodules are actually in
>> use? I don't think the presence of .gitmodules is perfect (because you
>> might be in a bare repo, for example, and have just fetched some other
>> history you are relaying), but it may be a good compromise.  I'm
>> envisioning something like "--recurse-submodules=auto-check" which
>> auto-detects common situations (e.g., presence of .gitmodules or
>> .git/modules checkouts) and enables "check", and then setting the
>> default to that in the long run.
>>
>> -Peff
>>
>> [1] Actually, there is another much worse case lurking there. Try:
>>
>>       git push --recurse-submodules=check --mirror dst.git
>>
>>     from the kernel. I didn't let it finish, but I'd estimate it would
>>     take on the order of 5 hours. The problem is that push feeds each
>>     updated ref tip to find_unpushed_submodules(), so we end up walking
>>     over the same history over and over.
>>
>>     I think it should feed all of the "before" and "after" ref tips it
>>     proposes to update to a _single_ revision traversal.
>
> That sounds massively ... broken.  So before even thinking about
> flipping it to default, this needs to be fixed first.
>

I agree. That sounds bad.

However having the --auto-check feels like papering over the
actual problem which to me sounds like a design problem.
However this may be a viable short term solution.

About the design issue:
We need to answer the question: Which submodule commits
are referenced by a given set of superproject commits.

This question is advancing a very similar question that we'd
have to ask in git-gc. In gc we would end up without having to
worry about a specific set, but rather the all reachable commits
of the superproject are in the given set.

So we could solve two issues at the same time if we had a quick
way to answer this question quickly.

And for that I considered introducing a ref in the submodule
(e.g.) refs/superproject/gc_protector, which records both the
superprojects commit as well as the submodule commit
in case the superproject changed the submodule pointer.

I have some rough patches for this, but I did not consider sending
that to the list as the patches are still rough and not quite
fully thought out on the design level.

--
Actually screw this. After an office discussion with Jonathan (cc'd):

1)  We need to have an "alternate refs namespace", which contains
    secondary data (as this can be derived from the primary data with
    lots of compute). So maybe we need a file similar to the packed refs
    file, "superproject-refs" that behaves as if it is storing refs,
but that file
    is safe to delete as we know all its contents can be recreated.

2) In this new alternate refs space, we can have
    refs/superproject/<sha1> in the submodule with the sha1 of the
    superproject that points to a commit which is a dirty merge of all
    submodule commits, that have no other parents.

e.g.
In the superproject we might have a history of:

  A <- B <- C

with A being origin/master and C our local master.

In the submodule we have:

  D <- E <- F
    \
      G

F is the master branch in the submodule, G is a dangling commit.

Now we could have the following git links:

    A -> D
    B -> G
    C -> F

Then the refs/superproject/<C>
would be a merge of F and G.

When pushing in the superproject (A..C) we would need to make sure
the submodule is updated as well, i.e. we'd look at
refs/superproject/<C> to know we need to advance the remote
submodule history to contain at least G and F.

Then we can do a standard rev walk starting at G and F downwards until we
hit a commit that is contained in remote/refs/*.

> Why wasn't it discovered that "push.recursesubmodules = check" is
> UNUSABLE since it was introduced is simply beyond me.

Maybe it is not compatible with your workflow as you push only once a day?
In a centralized server model you rarely exceed a few commits on push time,
but
    $ git rev-list a829490...c08db5a |wc -l
    23
    $ git rev-list f5df0f2...f3c0fa5 |wc -l
    61
    $ git rev-list 8f73021...de36215 |wc -l
    95

and some new branches, so you pushed around 200 commits.
I think this misbehaves strongly for typical maintainer work flows.

> I am mad (which is unusual for me, isn't it? -- I've seen somebody
> else saying "I am mad", but I do not think I ever said it here).

Please direct your anger at the design of submodules.
The assumption of the submodule being sort of 'independant' doesn't allow
for efficient data structures I would think. So maybe we need to teach the
submodules about the existence and state of the superproject?

/me ducks
