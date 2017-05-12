Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1B21FF34
	for <e@80x24.org>; Fri, 12 May 2017 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbdELOx0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 10:53:26 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33732 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbdELOxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 10:53:24 -0400
Received: by mail-vk0-f51.google.com with SMTP id x71so19181845vkd.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bi+qGPee6vQ2fsLHJNRy44uowCiRAHxpqHg9elgU+PI=;
        b=lBk1nk+cXSDL0aYmui7mHinEWWuoOLa/GNreeIQAtyA/y7twdf23XwczDtdwNhlhFl
         0gxp5GnnV3peILvLeCeENcpF2Z+ZC1rpf5uFCR0SBY52la1KniXXM7sRydplGMv/GvpM
         6kwOq6nDB1TjRU4bLYAEVsMERDjBpayHVKqyW17StzPrGlNdu270UITECJMk05Vya8jO
         7qtPT0Dk5crXVnXzrgwz1hBZOmocedy2WVjO+xkty4HxrtSqvVv+VZDPniwI7BGUpFFg
         XXrvvqKVTl7TlwuU6+fLsZ7TeSxjhGAKZlWO3uXwvSDZDci2xnT0TphFpu18rhkSiK8o
         lBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bi+qGPee6vQ2fsLHJNRy44uowCiRAHxpqHg9elgU+PI=;
        b=HgZCT+pAoQd8QzqUfp/SDCImt7pri0CdEKb3gZKB/6pRCgeJmzaAhqCGvrqSjuzWBE
         8jMz+ahAvbZuJsWi0MvZ/11oGPx5jxakKEKrl3gWtA8VKq9Nd8Qn3YYWd8CAyN08Xu9O
         KYK2TJGKZX/6/oY9vfJ+e0bxr5toZ+vkEX4m8JAiGxmXDrbsuB5ve+/iidPdFJrxvnAW
         SgdvD3wjHnTyOuGVd56cSo223zXRs3HfmF7Yxi0FAMTVF2RdC/SWLyLjDNtQ/nrlmEhI
         UbbVVfypsIlJeDwyIzI5zB4Xypx8VduiR2UwuP5RU7AiAEuZunPYK8+/h4oLVSjWz2G6
         3o1w==
X-Gm-Message-State: AODbwcAPI1iQjvYuJpsVfo/SXTPJgfRiI8ryb8VGjwlM0sQ0LrKfv2ai
        1VDr7pRm/EGK/mxc4gQRBNk8PtQOO+A21vc=
X-Received: by 10.31.238.143 with SMTP id m137mr1953283vkh.109.1494600803740;
 Fri, 12 May 2017 07:53:23 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Fri, 12 May 2017 07:53:23 -0700 (PDT)
In-Reply-To: <20170511233640.ylf4to3hotngh6xe@sigill.intra.peff.net>
References: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
 <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net> <CAHd499AvDRH-KZ7piOE=QsVXSpMt0u5jVXUC=7UPnRVLYo-U5Q@mail.gmail.com>
 <20170511233640.ylf4to3hotngh6xe@sigill.intra.peff.net>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 12 May 2017 09:53:23 -0500
X-Google-Sender-Auth: 0p3Yncr0f5_iLSv23f1zlJorHf0
Message-ID: <CAHd499A=wwxFxZ2mq=PZcOBNRSiK1Xm_sE79AypBXQaYU_UcJQ@mail.gmail.com>
Subject: Re: Best "triangle" workflow setup?
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 6:36 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2017 at 04:23:03PM -0500, Robert Dailey wrote:
>
>> On Thu, May 11, 2017 at 3:17 PM, Jeff King <peff@peff.net> wrote:
>> > I think you want:
>> >
>> >   [push]
>> >   default = current
>> >   [remote]
>> >   pushDefault = myfork
>> >
>> > to make "git push" do what you want. And then generally have branches
>> > mark their counterparts on "origin" (which you can do either at creation
>> > time, or probably by using "git push -u origin my-topic" when you push
>> > them).
>>
>> So without the `pushDefault` setting, `current` will default to a
>> remote named `origin` if there is no tracking branch set, correct? So
>> `pushDefault` is effectively overriding this built-in default? In
>> addition, it seems like since this overrides `branch.name.remote`,
>> that this effectively makes the remote tracking branch *only* for
>> `pull`. Is this a correct understanding?
>
> Right. The general idea of a triangular workflow is that where you pull
> from is not the same as where you push to. We have branch.*.pushremote
> if you really wanted to do it on a per-branch basis, but in my
> experience you almost always want to use "myfork", because you can't
> push to "origin" in the first place. :)
>
>> > This is similar to what I do for my git.git workflow, though I usually
>> > have origin/master as the branch's upstream. I.e., I'd create them with:
>> >
>> >   git checkout -b my-topic origin
>>
>> I'm looking through the `git checkout` and `git branch` documentation,
>> but I don't see any mention of it being valid to use a remote name as
>> the <start-point> parameter (you're using `origin` in the above
>> example). Am I misunderstanding? Did you mean origin/my-topic?
>
> Using "origin" there will resolve to "origin/HEAD", i.e., origin/master.
> So basically I am saying that all of my topic branches are based on
> master, and if I were to rebase them (for example), I'd want to rebase
> the whole thing.
>
> If I were to "git pull", they'd also pull from master, which may or may
> not be what you want (though with pull.rebase, perhaps). I don't
> generally use "git pull" at all for my git.git workflow.

Thanks, just curious, where in the git documentation is the "origin"
to "origin/HEAD" resolution documented? I checked the git-revisions
page but it doesn't seem to mention it there. Thanks for explaining
though.

Also is there a similar mechanism for "track same-named branch on
specified remote"? Something like "origin/."? I follow git-flow
development process, so topic branches on hotfix or release branches
will track origin/master (since origin/HEAD still points to master or
develop). But I want to track "origin/release/1.2.3" without typing
the full thing. Basically would be nice if there was a lazy shorthand
for it similar to the "origin/HEAD" example you gave.


>> > And then rebasing always happens on top of master (because "origin"
>> > doesn't even have my topic branch at all). If I want to compare with
>> > what I've pushed to my fork, I'd use "@{push}".
>>
>> Can you explain more about how your rebase chooses master instead of
>> your same-named remote tracking branch? Maybe provide some examples of
>> your rebase command and respective configuration (unless what you've
>> already provided is sufficient). As for @{push}, I haven't used this
>> before, so I'll dig in the docs and learn about it.
>
> The default for "git rebase" (if you don't specify a base) is the
> configured upstream, which in my case is origin/master. Most of my
> rebasing is "rebase -i" to rewrite bits, so it automatically picks all
> the commits on my topic branch.
>
> Maybe it would help to set up a trivial example:
>
>   # just a helper to make dummy commits
>   commit() { echo "$1" >"$1" && git add "$1" && git commit -m "$1"; }
>
>   # some parent repo
>   git init parent
>   (cd parent && commit one)
>
>   # and imagine you have a public fork, too
>   git clone --bare parent myfork.git
>
>   # and then you have your local clone; in real life this is obviously
>   # the only one that would actually be on your machine, but this is a
>   # toy example
>   git clone parent local
>   cd local
>
>   # set up our triangular config
>   git remote add myfork ../myfork.git
>   git config remote.pushdefault myfork
>   git config push.default current
>
>   # now let's try a topic branch
>   git checkout -b topic origin
>   commit two
>   commit three
>
>   # config will show our topic based on origin/master:
>   #  [branch "topic"]
>   #     remote = origin
>   #     merge = refs/heads/master
>   less .git/config
>
>   # this should default to all the commits in our topic (i.e., two, three)
>   git rebase -i
>
>   # let's imagine upstream makes more commits on master. We can "pull
>   # --rebase" to put our work on top
>   (cd ../parent && commit four)
>   git pull --rebase
>
>   # pushes go to the matching branch on myfork
>   git push
>
>   # if you want to see what you haven't pushed yet, you can use @{push}
>   commit five
>   git log @{push}..
>
>   # likewise, if you wanted to rebase only commits that you've been
>   # working on since your last push:
>   git rebase -i @{push}
>
>   # Now imagine "origin" picks up your branch...
>   (cd ../parent && git fetch ../myfork.git topic:topic)
>
>   # Depending on your project's workflow, you may want to consider that
>   # the new base for further development (and never rebase or rewrite
>   # any commits that origin has). You do that by re-pointing your
>   # @{upstream} config.
>   git fetch
>   git branch --set-upstream-to=origin/topic topic
>
>   # now a "rebase -i" would show only the commits origin doesn't have
>   # (five and six in this case)
>   commit six
>   git rebase -i
>
>
> Hopefully that shows off some of the ways you can use the upstream and
> push config in practice.  Some people may not be as excited about the
> "rebase" default as I am. I spend quite a lot of time at the end of a
> series sifting through the commits via "rebase -i" and polishing them
> up. I also test with "git rebase -x 'make test'".

Yes this is extremely helpful. I also like to default to rebase for
everything. I have this in my global config:


[pull]
    rebase = true
[branch]
    autosetuprebase = always

(Although I think autosetuprebase isn't needed anymore since
pull.rebase is introduced, but I keep both just in case)

So to summarize:

* Pushing to fork only ever requires `git push`
* Pushing to origin requires at least `git push origin` (for same-named branch)
* Pulling from origin always uses remote tracking branch (set to
mainline to merge latest into topic branch (single developer) or set
to same-named branch for multiple developers)

Another improvement that it seems like I'll have is that I do not need
to specify the branch name for my first-time pushes of a branch like I
had to do when `push.default` was set to `simple`. Back then I had to
do:

$ git push -u origin HEAD

Now all I gotta do is:

$ git push

I like this much better!! Thanks a ton!
