Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04E71F424
	for <e@80x24.org>; Sun, 22 Apr 2018 18:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeDVShk (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 14:37:40 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:39969 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbeDVShj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 14:37:39 -0400
Received: by mail-wr0-f176.google.com with SMTP id v60-v6so35282977wrc.7
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RzUDYwj1kvhN/5I5XQ1ogxha8hbxdn6JMmGvaLZjPA8=;
        b=PJBZ44xDDMavti9v+cT0rp8boZ+c6QRVDdLK4jF3visC6bijMynNO8/80lz3nSXgU6
         sMH9Tr7wDkfjPvmYSIGQsF+55m37CGdJ3KoKMLw0qS+YnakbfIzu43M8IqUYF+9D0acw
         fQkKpI2/kb9e5l3Ty1YYs1PEx2+kMLquar4j8ls0WjowVG0gy7XW60IPcj8KI7PM6Z0e
         f1IPcdbFLZQ4NXKIf89uh6UFXYFMdJDUfRfp+dxMnlVxqWtNt7u7Hct4DMPcsudynjOJ
         53M0dQP19R/KD9TeKI0MoXNGt4iPIYC/oaZ6RSFrEIhwKAIbYOLPQIV0GX3bcz9tPkcY
         gCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RzUDYwj1kvhN/5I5XQ1ogxha8hbxdn6JMmGvaLZjPA8=;
        b=JeKF4gjd3OBFlVgGFxkyPUMuXu4oWN0GsFhJUaoQ7OC+F7JmIvnH052qcTIESxKRou
         udimeBFWAkpVwXcVYU49PgJFJCKWJFbiS+US7fpwTTHN12JKBHTgbLigaRGMEvBPuCQ1
         ZEL89ZUYIFcrIQ2v+ukZeZ8dtMSjAwleJDp+uaNeYyAkjA/lVkPMmxqBRb5zU9YZHs0c
         CHpMkpWILVLUwqxCJFTWjVGK1FH/kdFm8LO7ikrQeVRbikLrXwug/bJIV/06LhRD6J+m
         KtdxPttUPWcENXKTiRfCfAhokBjFRc6MIRDJ6/DMHqv0l+k3LknkMRs8k3ACo+onz3BJ
         iYCg==
X-Gm-Message-State: ALQs6tC73cRkap23u/cGLSAok7Yz+aZmb/+IOQpy2doeGgNcNilQNw4E
        tLQryIFzd8a4uT7Z/UaYJDr4g/in
X-Google-Smtp-Source: AIpwx4+ht1JfWEf/U830Ca17Zriq2DRjHL7d8ecQfE7cc3t8ED+asjhwbr5BvoKCFKCPhodERsh7Uw==
X-Received: by 10.80.129.227 with SMTP id 90mr20675297ede.252.1524422258096;
        Sun, 22 Apr 2018 11:37:38 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e14sm6488933edk.29.2018.04.22.11.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 11:37:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: RFC: How should we handle un-deleted remote branches?
References: <87in8mdqhr.fsf@evledraar.gmail.com> <3fcd1b50-2aeb-0ea4-fea7-b5705e76c027@gmail.com> <87d0yrebhw.fsf@evledraar.gmail.com> <f2fc89c6-14a9-b700-b7c9-a646148e9206@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <f2fc89c6-14a9-b700-b7c9-a646148e9206@gmail.com>
Date:   Sun, 22 Apr 2018 20:37:36 +0200
Message-ID: <87bmebdr4f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 22 2018, Andreas Heiduk wrote:

> Am 22.04.2018 um 13:17 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Sun, Apr 22 2018, Andreas Heiduk wrote:
>>
>>> Am 20.04.2018 um 14:14 schrieb Ævar Arnfjörð Bjarmason:
>>>> But this is a possible work-around:
>>>>
>>>>     git init /tmp/empty.git
>>>>     git remote add avar file:///tmp/empty.git
>>>>     git remote prune avar
>>>>     git remote remove avar
>>>
>>> This won't do it also?
>>>
>>> 	git remote prune origin
>>
>> Yes, in this particular case, but that's just emergent behavior in how
>> we handle refspec prunign, and the fact that it "works" is arguably a
>> bug in "prune". i.e. this:
>
> Its not emergent because "origin" is the other remote responsible for
> that ref and cleaning stuff "belonging" to the remote is the job
> description (I'm arguing from a user's perspective, not as a git-developer).

Right, I should have said something closer to "inconsistent", at least
from the user's perspective. I.e. "remove" doesn't delete your branches
because another ref "owns" them, but "prune" will happily clobber
another remote's refs without warning.

Maybe we're happy to keep that, pruning is a bit of an oddity already,
see the "Git has a default disposition of keeping[...]" docs and the
rest of the "PRUNING" section I added to git-fetch in 2.17.0, but this
is osmething worth keeping in mind.

>>
>>     (
>>         rm -rf /tmp/git &&
>>         git clone --bare --mirror git@github.com:git/git.git /tmp/git &&
>>         cd /tmp/git &&
>>         git remote add avar git@github.com:avar/git.git &&
>>         git remote add peff git@github.com:peff/git.git &&
>>         git fetch --all &&
>>         git remote remove avar &&
>>         git remote prune origin
>>     )
>>
>> Will delete all the avar/* and peff/* branches, even though I still have
>> a "peff" remote.
>
> Exactly my point: When you are in a the bad situation of "shared
> responsibility", then there is no easy and always correct way out,
> because there are uncountable possible situations.
>
> To give another, slightly modified example expanding the problem space:
>
> (
>     rm -rf /tmp/git &&
>     git clone --bare --mirror https://github.com/git/git.git /tmp/git &&
>     cd /tmp/git &&
>     git remote add github https://github.com/avar/git.git &&
>     git fetch github &&
>     git fetch origin &&
>     # note new fetches for "github/master" using with "(forced update)"
> )
>
> For ... reasons the first repo publishes some references like
>
> 	github/maint
> 	github/master
> 	github/pu
>
> So when this repo is mirrored AND another, suitably named remote is
> added then there will be also namespace conflicts. You can call
>
>     git fetch github
>     git fetch origin
>
> in a loop and most likely each fetch will update the same refs, always
> toggling between two states.
>
> So: not only "remote remove" and "remote prune" are at stake but every
> command handling remote references.

Right, there's certainly a lot of insanity you can create with
overlapping refs, but to bring this thread around a bit, the edge cases
I'm interested in addressing are those where "git remote <whatever>"
silently doesn't do its job, or does it too eagerly, resulting in a
hard-to-repair repo state.

> How should "git remote remove github" work in both situations? Remove
> the refs/remotes/github/master & co? remove them only if the last fetch
> was for "github" but not when the last update was for "origin"? Should
> "git fetch" use the same logic?

Until we move to some other ref store implementation that namespaces
things properly, the best we can do is simply to assume that
refs/remotes/<name>/ is owned by the <name> remote for the purposes of
remove/prune etc.

That'll of course leave open this edge case you're pointing out where
you're mirroring another remote into refs/* and it creates a
remote/<name>/ branch, but I think it's sufficient for the purposes of
sane UI to just document that fetching into refs/* creates such caveats.

> So it seems better to me to avoid that bad situation altogether. Don't
> allow overlapping/conflicting refspecs when adding a new remote. Using
> *your* last examples both
>
>>         git remote add avar git@github.com:avar/git.git &&
>>         git remote add peff git@github.com:peff/git.git &&
>
> should have failed and hence the "prune" problems won't exist. Same for
> my example.

I think this is a non-started. There's plenty of legitimate reasons to
have overlapping refspecs, e.g. the GitLab case where they're creating a
"geo" remote which is a mirror of other refs they push to.

Even if that wasn't the case, it would be very fragile to solve these
cases by disallowing adding such remotes, since users can edit the
config file, we'd need to detect it on the fly.

>>> Possible 5):
>>>
>>> 	Don't fix "git remote remove" but "git remote add" to complain that its
>>> ref-namespace is already occupied by some other remote. Add "--force"
>>> for the experts.
>>
>> Indeed, that's another bug here, i.e. in the above example:
>>
>>     git remote remove peff && # won't delete peff/ branches
>>     git remote add peff git@github.com:peff/git.git
>>
>> Will happily add the "peff" remote again, even though as you point out
>> it could be an entirely different remote.
>
> Ummm. That was not my point. My is: "git clone --mirror" uses a refspec
>
> 	fetch = +refs/*:refs/*
>
> and hence "occupies" the complete "refs/*" namespace. So adding another
> remote (for the first time or for the second time is as irrelevant as
> the url) will use
>
> 	fetch = +refs/heads/*:refs/remotes/peff/*
>
> and now the "refs/remotes/peff/*" part is in conflict with "refs/*" from
> above. The conflict exists not only for "prune" or "remove" but also for
> "fetch", "rename" (didn't check) .
>
> This kind of conflict should not be allowed right from the start - when
> the first "git remote add peff..." is executed. Then prune, remove AND
> fetch would be OK.

As noted above we need to deal with this overlap, and it has to be
allowed, but we can still do better than we do now with "remove" /
"prune" et al, i.e. simply inform & ask the user what he'd like to do.
