Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6961F461
	for <e@80x24.org>; Tue, 20 Aug 2019 23:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHTXqW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 19:46:22 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41321 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTXqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 19:46:22 -0400
Received: by mail-vs1-f68.google.com with SMTP id m62so95521vsc.8
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EAlPn/RLTOMqTLtpvOl78zy4OfeZD8JRXPnIvpbHdwI=;
        b=sXETBqXQy5eHmbiNVDovtLS2iSG4NedRNOMRlXuK4fJ/q7abR6ivy9siFqBa138euR
         pvi191t57L9NBjmfIx4K4Xgpw3pn6/KN2afNqnRADedKxLBVYJOeAaT0Ry8r5DI2UAgu
         z7j1DQtodq+aByLC2ljQtDv10WDctJkT45PnWbv3creZgl2ka7jy7ZG02hnCYwW/6Y7L
         b7KtY39a7vrHlC1P7osd4nfkX0bHqXVGoVkyyNyR0lwZPqFGQI9vK+5iQmK0oUFYeqHZ
         urKnYv5zSmBuXSdYlCiv5ZuXk14nOJyLl/FpAbu+/pnOOTMSDeKpjtVk3jZczg38QIgO
         1NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EAlPn/RLTOMqTLtpvOl78zy4OfeZD8JRXPnIvpbHdwI=;
        b=kE7Jb0iNyi8KLoI3WPM4Yaw4si/e2hbiP5imKdr3EXJeV+51KrWvNP+Z0dHRv+j0Hi
         r2ltNc6DWEwgEp5BJpxH2UBjjcP+U4Yl3190P8AqHGEHpVz24jf6EIFWeIoDOny/PWDd
         wf+UF7sURshh6tl43/iu+B9pCuvNQCYCcaxWvs8RXitHo9LNdRmbEuu+tJz36n5VpZc0
         iCChFRBDYU3zlfiCJ+/55YpzG0DX5IMMG53XufKKJs7PlWfZEH3jcO9LoYlXIQGY6NI2
         JC5ZmJUZXzRKAg3OjOIqVKTbk0jJANQZ7kOLN+romPa/0DL1e0FkAMS/VQBniqEyg7Ed
         MZKQ==
X-Gm-Message-State: APjAAAVdRTbiBvqyPqiJp7E2+f1lGUQuQcXSqe+AQFwIVhRHOGaWe+Km
        8wau2viSDOM4EW5WZIvwruRFlgUOcHTA2ENCdA==
X-Google-Smtp-Source: APXvYqxygHshAN5UtYg9Myngwp/qkmNkxf0fpEaPxeHADotjJuNDyBGkmbYiCqsqFfghq/pIL+8dO/lI6/JkDQ1ryWo=
X-Received: by 2002:a67:eb8c:: with SMTP id e12mr17964212vso.20.1566344781157;
 Tue, 20 Aug 2019 16:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
 <3442071566267276@iva5-049509bcc5d6.qloud-c.yandex.net>
In-Reply-To: <3442071566267276@iva5-049509bcc5d6.qloud-c.yandex.net>
From:   Aaron Miller <aaronkmiller@gmail.com>
Date:   Tue, 20 Aug 2019 16:45:44 -0700
Message-ID: <CALSvhyZUphJ4+Vb5MD-KS9OV7DOK6ahwvfBdg0JiNWbT7GxzWA@mail.gmail.com>
Subject: Re: git-p4: Clone p4 path with bidirectional integrations
To:     Andrey <ahippo@yandex.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrey,

Thanks so much for this detailed response, I really appreciate it.

> First of all, git-p4 should normally take only one direction from bidirec=
tional integrations on its own.
> Do you see "p4 branch <branchABC> defines a mapping from <path1> to <path=
2>, but there exists another mapping from <path2> to <path1> already!"?
> If you do, it means that git-p4 will ignore <branchABC> mapping.

I was afraid that was the case!

> Also, just FYI, as far as I know, git-p4 doesn't create "merge" commits,
> so bidirectional integrations won't look different from ordinary commits =
in git commit graph.

Ah, I didn't realize that, thank you. Perhaps I should just sync each
branch separately then, ignoring branch mappings entirely and be done
with it.

I was hoping to generate a commit graph that properly represents
integrations as merge commits because our Perforce branches are quite
large. Storing diffs of integrations rather than discrete commits
would result in a much smaller Git repository for us. There are
*quite* a lot of integration commits.

I wonder how hard it would be to modify git-p4 to use merge commits? I
will take a look at the source. I'm somewhat surprised that's not the
case to begin with though? Maybe someone else can chime in on why
merge commits aren't used.

> Uh-oh, 5M commits!
> But given that it fails at 25% instead of 1%,
> you've got some luck. :)

Hehe :) Fortunately I don't have to migrate *all* of those commits,
but still a fair number.

> This might not be just because of bidirectional integrations per se.

I should have mentioned - there were no P4 branch mappings defined for
the depot paths in the test case I shared (maybe that's obvious).

> This error may happen if, say, there's a P4 branch mapping from staging t=
o master,
> but master was actually created before staging.
> git-p4 tries to find a "parent branch" for master, but it doesn't exist y=
et,
> so git-p4 fails in an ugly way.

Yeah this is exactly correct, I've tested precisely this scenario.
Actually that's what two of the real branches I am trying to migrate
look like.

> One way to filter out troublesome P4 branch mappings is to set git-p4.bra=
nchUser to a particular user.
> But most likely, this won't help you because different people created dif=
ferent branch mappings over time.

I was thinking I could set git-p4.branchUser to a user that hasn't
created any branches at all and then define branch mappings I care
about in git-p4.branchList.

But pretty much all of our branches either have bidirectional
integrations or a situation like you described above where branchA was
created before branchB, and branchB integrates into branchA.

> Unfortunately, there's _no_ git-p4.branchRegexp config option,
> but it's fairly straightforward to implement -- patches welcome! ;)
> (getBranchMapping() needs to apply a regex to branch names before doing a=
nything serious with them)

That would be a neat option! It's not really filtering the branch
mappings which is my issue though. The number of branches is small
enough that I can manage the mappings manually.

> Note, that you can't have master:staging together with staging:master,
> otherwise you'll likely run into the same problem as before.

Yeah this is really the crux of my issue.

> This might be simple or quite tedious depending on the history and branch=
ing strategies of your repositories.
> It may be as easy as just dropping some p4 branch mappings.

I'm thinking if I'm not getting merge commits anyway I may as well
just forget about the branch mappings entirely.

> However, one of the repositories I had to deal with had almost random bra=
nching strategy (with most integrations done without predefined branch mapp=
ings), so I had to spend quite some time to trace the history and figure ou=
t which branches make the most sense in git.

Fortunately our branching strategy was *mostly* well-defined and we do
have Perforce mappings defined between our branches. However most
integrations didn't actually use the branch mappings, just manually
specified depot paths. But they did fall under the branch mapping
scopes.

> so for repositories with simple/short history,

Unfortunately our repo history is anything but short or simple :(

> I recreated those merge commits manually (well, in a bash script) using `=
git replace --graft <commit> <parent1> <parent2>` followed by `git filter-b=
ranch --tag-name-filter cat -- --all` to make grafts permanent.
>
> (`git filter-branch` is only needed once in the very end after all `git r=
eplace` manipulations are done)
> It's perhaps better to teach git-p4 to produce merge commits, but a bash =
script was a low-tech low-risk option for me.
>
> Also, beware that git-p4 doesn't handle branch-into-non-empty directory p=
roperly.
> If I remember correctly, something like
> `p4 copy //depot/branchA/... //depot/branchB/... ; p4 submit; p4 copy //d=
epot/branchC/... //depot/branchB/...; p4 submit`
> will result in branchB having _both_ branchA and branchC contents in git.
> `git filter-branch` or `git rebase` are your friends to workaround this.
> (or better fix git-p4, of course)

These are great tips, thanks! Maybe what I will do is sync each branch
separately with no branch mappings, then use this technique to create
merge commits for the initial branch creation commits only and not
worry about any other integrations.

-Aaron
