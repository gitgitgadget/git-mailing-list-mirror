Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1FD1F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 08:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1IwJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 04:52:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41920 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1IwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 04:52:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id m24so1803577ljg.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vXhJFsd+wl4NT80yQl8/0tu8WUBgmr3hN5MKwiwkbRo=;
        b=Y3kCC4pu8PfhTzG8ZrtLnclwNh/R86Nar3908VY3BJM1hHhYM8u/unTEytLTbP/BPn
         eZ1ttPNvzKem6tDdD2pq5zkdDXHXehZWqan8dgp8/c5qRz7HpIlbHSLSovvnfudv7ULf
         D1TDW8sRFKwoSrPdnSNIQ9xPJPA9+KGvaPvn9lZpiWvBmgGOUxf7bGNMG/oeIr085R6Y
         8q/oE8U7NwXXPFblWH9PPANUw6YQJ6xTBMtOfQKmMmm9vwSVzmre1d/+Gpo8MN6B4/Sa
         MHBsLazznFonK4fYqwm8F/gaxT1hUQ5B1WbmS2E9t9HGCuZAMfWsU6qfvgjM2N9TgsHl
         nuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vXhJFsd+wl4NT80yQl8/0tu8WUBgmr3hN5MKwiwkbRo=;
        b=MhNkI3mF8SFGhO1hhuE65PxaF4D3s53eqxX9PDTzTQuTaSEX9CXoURHB4Etv3BCII8
         jmWSGNWtFP70Bj8PKLsKFLDRAvoZ3fwnZLpFvh6nNjF2fiWSEho6ydTRoCNcazRKLUJY
         PMevesiTLENqzdBVQzyGeeW/5687z76r1qOVYJ1orA4Y4YoBRVX6Lozc6C9BLOVZGt3c
         NCsLPP+HFgP7rawlptlhvmWsm2llnbn1mGwTxEEBDrOw2OBZs3hWkl7sp48o5fK78wfe
         Mwyph2aHyiXyOoZ8nNvGc6Z2RarGJh0e6ZXB9oFyOrI5qyNxrCJz7jT1anF/+CXI7oMs
         K/Ng==
X-Gm-Message-State: APjAAAXv/c9X5RNGBZOGbnPSzP6wxNyY54dmWVhisvFT6KuydVt1O9dm
        hJWO6QcZ3MNN7qgKvzoOgFY=
X-Google-Smtp-Source: APXvYqz4Dw9wzwnMLzu6DFfeWa2AoVq+4hf/fMsx/nlpvPg4vh3/ZQxyBDWLMQ3ijJEdGTSXHkmvAw==
X-Received: by 2002:a2e:91d1:: with SMTP id u17mr1378712ljg.98.1566982326111;
        Wed, 28 Aug 2019 01:52:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e11sm490969ljo.19.2019.08.28.01.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 01:52:05 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
        <20190826235226.15386-1-newren@gmail.com>
        <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
        <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
Date:   Wed, 28 Aug 2019 11:52:04 +0300
In-Reply-To: <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 27 Aug 2019 15:18:19 -0700")
Message-ID: <87blw93c5n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Eric Wong <e@80x24.org> writes:
>>
>>
>> [...]
>>
>> > AFAIK, filter-branch is not causing support headaches for any
>> > git developers today.  With so many commands in git, it's
>> > unlikely newbies will ever get around to discover it :)
>> > So I think think we should be in any rush to remove it.
>>
>> Nah, discovering it is simple. Just Google for "git change author". That
>> eventually leads to a script that uses "git filter-branch --env-filter"
>> to get the job done, and I'm afraid it is spread all over the world.
>>
>> See, e.g.:
>>
>> https://help.github.com/en/articles/changing-author-info
>
> Side note: Is the goal to "fix names and email addresses in this
> repository"?  If so, this guide fails: it doesn't update tagger names
> or email addresses.  Indeed, filter-branch doesn't provide a way to do
> that.  (Not to mention other problems like not updating references to
> commit hashes in commit messages when it busy rewriting everything.)

No. Maybe the original goal was like that, by I, personally, use
modified version of this to change my "Author" credentials from
"internal" to "public" in branches that I'm going to send upstream, so
the actual aim is to change e-mail of particular Author from a@b to c@d
in all the commits in a (feature) branch.

>
>> > But I agree that filter-branch isn't useful and certainly
>> > shouldn't be encouraged/promoted.
>>
>> Well, is there more suitable way to change author for a (large) set of
>> commits then?
>
> I would say yes, use git filter-repo (note that this thread started
> with me proposing filter-repo for inclusion in git.git -- and getting
> suggestions that we should remove stuff instead of adding more stuff).
> I'm biased, but I think it's much better at this particular job as
> well:

Well, I don't want to change the entire repo, and I don't immediately
see how to do it with git filter-repo. Is it at all possible?

> You can create a mailmap file and pass it to the --mailmap option to
> git-filter-repo.
>
> Or, if you prefer (perhaps you don't like git's mailmap format as used
> by shortlog and now log, or perhaps you really want to be able to do
> regex replacement or something), you can use the --name-callback or
> --email-callback to work on those fields more directly.
>
> Or, if you prefer (e.g. you want to handle author vs. committer vs.
> tagger differently), you can use the --commit-callback and
> --tag-callback filters.
>
> As an added bonus, filter-repo will also perform the rewrite far
> faster than filter-branch (and rewrite commit hashes in commit
> messages as alluded to above).

These things are nice to have indeed, but it always changes the entire
repo, right? If so, it's not a suitable substitute for git-filter-branch
for particular job at hand.

Actually, I'd rather expect some support for this in "git rebase", being
git history editing/reshaping tool, but it looks like it only has it in
the form that is very difficult to automate.

>
>> > Yet there's probably still users which ARE happy with it, that
>> > will never hit the edge cases and problems it poses; and will
>> > never read release notes.  And said users are probably getting
>> > git from a slow-moving distro, so it'd be a disservice to them
>> > if they lost a tool they depend on without any warning.
>>
>> Personally, I'm far from happy with it, but I have no clue how to
>> substitute it in the job above. Anybody?
>
> The start of this thread where I proposed git filter-repo for
> inclusion in git[1] had links to documentation and comparisons to
> other tools and such.  You may find those links helpful; if not, let
> me know what needs to be fixed in the documentation.

Thank you for the references, I find it a very nice tool to have!

Pity it's not an entire substitute for git filter-branch.

-- Sergey
