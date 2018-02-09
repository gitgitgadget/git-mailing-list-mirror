Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FD21F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeBIWEV (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:04:21 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40174 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIWEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:04:20 -0500
Received: by mail-wm0-f51.google.com with SMTP id v123so22346wmd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=suPySec4AviQhY9sVnsFEEe86OfD4pUjcyORZcyLbBA=;
        b=tgChnfTUzQDr8vTWLVeyCd0Q1B5tk9ahwJaRjnrb1rxP8Vp3KqKqbL1DL9WQ/F6S7f
         3DSoLsDW64sfC06HwJgvLtwABCz4u5+bKrHTVI/OCWYDNx6CztPSDhFXdUWcicXMXt3z
         0AA7PQuL8lgTqr4JVf6JIzFFsZMOzgY8NDGksGaIWQpPlxyAfSVDIg4lpsWLPDdL6qFj
         8xowormkgQpKF1z7XydKcLegBXLG3cmPDEIbhtmrEHLFvk1cpPlk/xHscrvwi6Ko0bFT
         I8je4GWLvTblVHlOahOLJrsHACyImtOcwsvE0xLqoosOwDxe4jj+J6ItB5yhQRXuJzfG
         UfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=suPySec4AviQhY9sVnsFEEe86OfD4pUjcyORZcyLbBA=;
        b=EPUKlcbJT0KcXIiWBoxPn1SQfuzvr/1vulf//6sTcD0RqG6dk8KYwpj4v/UhkaphYj
         cyg9Z+yi0KvkBE/5hAffN8aVSdxc+Q+fhpKSWbWxlBsd3lQwYwElm60o1S68+roKmfez
         TfxM6glTH6zTQdBbJKnB6cYjndrHJsTfGxa7d0BIRxRzzPgF3ym09KdXyoHqG4OYVDlR
         7/Lv+2CftCNcvcq5dDnOzlRMqfJSpVGrHkcoxyfhAMNAgQ7zg8ph9tx9ofw+VkbJ7GSp
         1NLg/DguMt3iR3eOO3e1scwtsJPYo6Ob/uhLtXrE7uZJpTdHvtanGNYWEcgdwVuadRad
         u19A==
X-Gm-Message-State: APf1xPA9Q4sQYjOLhkeMMLXNc3fNkWNWj9lhN+heMlC+85fcuM7a6dg7
        RrT503TzEy2t50lteatMeg0=
X-Google-Smtp-Source: AH8x224MW9YXavZqbYfKBb8/u5biVSJTR/KEEXM/KA2/cAXxM4M0XZdyeYNQ7W5TwG9r+UHD9mS/0g==
X-Received: by 10.80.136.129 with SMTP id d1mr5665368edd.42.1518213858847;
        Fri, 09 Feb 2018 14:04:18 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id j59sm95914edd.31.2018.02.09.14.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:04:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io> <87inb8mn0w.fsf@evledraar.gmail.com> <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io> <20180208153040.GA5180@kitenet.net> <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io> <87bmgzmbsk.fsf@evledraar.gmail.com> <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
Date:   Fri, 09 Feb 2018 23:04:17 +0100
Message-ID: <87po5dbz1a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 08 2018, Leo Gaspard jotted:

> On 02/08/2018 10:06 PM, Ævar Arnfjörð Bjarmason wrote:>> Hmm, OK, so I
> guess I'll try to update the patch when I get some time to
>>> delve into git's internals, as my use case (forbidding some fetches)
>>> couldn't afaik be covered by a wrapper hook.
>>
>> Per my reading of
>> https://public-inbox.org/git/20111224234212.GA21533@gnu.kitenet.net/
>> what Joey implemented is not what you described in your initial mail.
>>
>> His is a *post*-fetch hook, we've already done the fetch and are just
>> telling you as a courtesy what refs changed. You could also implement
>> this as some cronjob that polls git for-each-ref but it's easier as a
>> hook, fine.
>
> I was thinking along the lines of
>     https://marc.info/?l=git&m=132486687023893&w=2
> with high-level description at
>     https://marc.info/?l=git&m=132480559712592&w=2
>
> With the high-level description given here, I'm pretty sure I can hack a
> hook together to make things work as I want them to.
>
>> What you're describing is something like a pre-fetch hook analogous to
>> the pre-receive hooks, where you're fed refs updated on the remote on
>> stdin, and can say you don't want some of those to be updated.
>>
>> This may just be a lack of imagination on my part, but I don't see how
>> that's sensible at all.
>>
>> The refs we fetch are our *copy* of the remote refs, why would you not
>> want to track the upstream remote. You're going to refuse some branches
>> and what? Be further behind until some point in the future where the tip
>> is GPG-signed and you accept it, at which poich you'll need to do more
>> work than if you were up-to-date with the almost-GPG-signed version?
>
> That's about it. I want all fetching to be blocked in case of the tip
> not being signed. As there is a pre-push hook ensuring committers don't
> forget to sign before pushing, the only case the tip could not be signed
> is in case of an attack, which means it's better to just force-push
> master because any git repo that fetched it is doomed anyway. Definitely
> would not want to allow an untrusted revision get into anything that
> could even remotely be taken as “endorsed” by the user.
>
> (BTW, in order to avoid the case of someone forgetting to sign the
> commit and not having installed the pre-push hook, there can be holes in
> the commit-signing chain, the drawback being that the committer pushing
> a signed commit takes responsibility for all unsigned commits directly
> preceding his -- allowing them to recover in case of a mistaken push)
>
>> I think you're confusing two things here. One is the reasonable concern
>> of wanting to not have your local copy of remote refs have undesirable
>> content, but a pre-fetch hook is not the way to accomplish that.
>
> Well, a pre-fetch hook is a possible way of accomplishing that, and I
> don't know of any better one?
>
>> The other is e.g. to ensure that you never locally check out some "bad"
>> ref, we don't have hook support for that, but could add it,
>> e.g. git-checkout and git reset --hard could be taught about some
>> pre-checkout hook.
>
> Issue is, once we have to fix checkout and reset, all other commands
> that potentially touch the worktree also have to be fixed (eg. I don't
> know whether worktree add triggers pre-checkout?)
>
> Also, this requires the hook to store a database of all the paths that
> have been checked, because there is no logic in how one may choose to
> checkout the repo. While having a tweak-fetch hook would make the
> implementation straightforward, because at the time of invoking the hook
> the “refname at remote” commit is already trusted, and the “object name”
> is the commit whose validity we want to check, so we just have to check
> the path between those two. (I don't know if you checked my current
> scripts, but basically as the set of allowed PGP keys can change at any
> commit, it's only possible to check a commit path, not a single commit
> out-of-nowhere)

Right, it's certainly the case that refusing the refs is a more
effective gatekeeper, we're not going to have hooks for all the
low-level stuff that might inspect sha1s or check them out.

My assumption was that hooking into just a couple of things would be
good enough, but yes, there's other trade-offs.

> The only issue that could arise with a tweak-fetch hook is in case of a
> force-fetch (and even maybe it's not even an actual issue, I haven't
> given it real thought yet), but this can reasonably be banned, as once a
> commit is signed it enters the “real” master branch, that should never
> be moved backward, as it can't be the sign of an attack.
>
>> You could also have some intermediate step between these two, where
>> e.g. your refspec for "origin" is
>> "+refs/heads/*:refs/remotes/origin-untrusted/*" instead of the default
>> "+refs/heads/*:refs/remotes/origin/*", you fetch all refs to that
>> location, then you move them (with some alias/hook) to
>> "refs/remotes/origin/*" once they're seen to be "OK".
>
> That is indeed another possibility, but then the idea is to make things
> as transparent as possible for the end-user, not to completely change
> their git workflow. As such, considering only signed commits to be part
> of the upstream seems to make sense to me?

I mean this would be something that would be part of a post-fetch hook,
so it would be as transparent as what you're doing to the user, with the
difference that it doesn't need to involve changes to what you slurp
down from the server.

I.e. we'd just fetch into refs/remotes/origin-untrusted/, then we run
your post-fetch hook and you go over the new refs, and copy what you
like (usually everything) to refs/remotes/origin/*.

You get the same thing, the logic just becomes inspecting something
locally and copying it over.

There are other caveats, notably that the local ref store now needs to
store 2x the amount of branches, unless we're smarter about it and only
store stuff in refs/remotes/origin-untrusted/ that's different from
refs/remotes/origin/, as a sort of ref staging area.

Anyway, I don't have strong opinions on this, just thought it was worth
discussing the whys.

One thing that's not discussed yet, and I know just enough about for it
to tingle my spidey sense, but not enough to say for sure (CC'd Jeff &
Brandon who know more) is that this feature once shipped might cause
higher load on git hosting providers.

This is because people will inevitably use it in popular projects for
some custom filtering, and because you're continually re-fetching and
inspecting stuff what used to be a really cheap no-op "pull" most of the
time is a more expensive negotiation every time before the client
rejects the refs again, and worse for hosting providers because you have
bespoke ref fetching strategies you have less odds of being able to
cache both the negotiation and the pack you serve.

I.e. you want this for some security feature where 99.99% of the time
you accept all refs, but most people will probably use this to implement
dynamic Turing-complete refspecs.

Maybe that's worrying about nothing, but worth thinking about.
