Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1DB20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbdAMSay (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:30:54 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:37343 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAMSax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:30:53 -0500
Received: by mail-it0-f42.google.com with SMTP id r185so43686040ita.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mtV2DdUUpsFvhkB5Dg3VDV6wkkGRa1fY8Y1jTRYvOEM=;
        b=kyCXxgZTlc83+m7WRlrHnRThwBr5hevDQXeWo3mSTVyNa4V0S/skwAdFR2mx2kIEW7
         uSvBYAsM1iiAMkNt7fy47L+IGT1HmhG5IpojRtySO9kaYPzI6ehs5j9Bk8+IPFt8eiNE
         84DPzveYVXqur0+C0qaRHKb6Q/4g9ujM24idEtMvUrE9vOxr7GXJZO+L4W/JuyBQp2S3
         tWYNsEn/sZVISE82t2qqNLWnNiLggXnsM2Y1jvgwjNdZu6nHJXedEhEOmRxIJ2kqAxZo
         En+olYrTNXqgePUPo2oJq/N6Pzv10heDu/+/o20JxjVlhLeszqWH/TeW0UAOxoMBfa8G
         c/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mtV2DdUUpsFvhkB5Dg3VDV6wkkGRa1fY8Y1jTRYvOEM=;
        b=D9YY6g2nVu4rEfe5sVx8rk2nf3W97OuPHE8XGMFfzwhdTZf7JybM7TK5T4yZWd6cQn
         FLaV6isRE+On1Rh2RLrnjLRRUW6lPw8Rq2gnuYA3cYyBTrJB7TRAKQtGHP2EATVZs2mK
         qzky6xFfs45sJW65RsvsKwONQ1E1Kw55BiuYBPjFKyXD2r6fwm9fV8zfKipbNOcbTq4Y
         4209Ri6GP+mE9aQ3YlbU8YCqkWmrLcnbXyLsE2VUSc4aiVqjOImeEguTDTUMaOFSZ2rZ
         JjysL603mN6+OY/icsKn6kzvflIdlAI57OOlzpplYur1CWrh9VwLqpTL4ml7HoAB96id
         eumQ==
X-Gm-Message-State: AIkVDXJBsmUsaYID8bIRhftdpFm1R+qEh9uFF4LH10gHISXGNGRrFsE7tFNK9rzY4YMuT8CXzU8y3AvzwrXJRq9F
X-Received: by 10.36.88.143 with SMTP id f137mr3734045itb.116.1484332252740;
 Fri, 13 Jan 2017 10:30:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 13 Jan 2017 10:30:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jan 2017 10:30:52 -0800
Message-ID: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
Subject: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working tree
 operations: support superprefix]
To:     "Brian J. Davis" <bitminer@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This question is about networking; the patch you originally replied to
was strictly about local operations in the filesystem, which is quite
a difference, so let's discuss it separately.

On Fri, Jan 13, 2017 at 9:56 AM, Brian J. Davis <bitminer@gmail.com> wrote:
>
> In response to a post at:
>
> https://groups.google.com/forum/#!topic/git-users/BVLcKHhSUKo
>
> I was asked to post here to explain a potential problem with current modules
> implementation.  Apologies if I am posting in the wrong place... so good bad
> or otherwise here goes:
>
> +-------------------------------
> With:
>
> git push origin branchname
>
> or
>
> git push server2 branchname
>
> I can push or pull from multiple servers so no problem as git supports this.
>
> Now the problem with use of submodules
>
> submodules are listed:
>
> submodule.directory_to_
> checkout/proj1_dir.url=https://git.someserver1/git/proj1_dir
> <https://git.someserver1/git/proj1_dir>

Technically it is submodule.<name>.url instead of
submodule.<path>.url. The name is usually the path initially, and once
you move the submodule, only the path changes, the name is supposed to
be constant and stay the same.

>
>
> but if say I want to pull from some server 2 and do a
>
> git submodule update --init --recursive

That is why the "git submodule init" exists at all.

    git submodule init
    $EDIT .git/config # change submodule.<name>.url to server2
    git submodule update # that uses the adapted url and
    # creates the submodule repository.

    # From now on the submodule is on its own.
    cd <submodule> && git config --list
    # prints an "origin" remote and a lot more

For a better explanation, I started a documentation series, see
https://github.com/gitster/git/commit/e2b51b9df618ceeff7c4ec044e20f5ce9a87241e

(It is not finished, but that is supposed to explain this exact pain
point in the
STATES section, feel free to point out missing things or what is hard
to understand)

>
> what I would get is from someserver1 not someserver2 as there is no "origin"
> support for submodules.  Is this correct?  If so can origin support be added
> to submodules?

Can you explain more in detail what you mean by origin support?

> +-------------------------------
>
> So above was post from google group.  Maybe above is enough to explain the
> problem that can result, but if not here is a discussion as to why this can
> be confusing resulting to pushing or pulling from the incorrect server.
>
> Lets say projects starts at origin on https://server0.org. Project is then
> brought in house to server https://indhouse.corp by developer A.
>
> Developer A then changes the submodule projects to point to indhouse and
> changes submodules in super project to point to indhouse so everything is
> great.
>
> Then Developer B clones from indhouse makes changes to submodule1 and
> submodule1 and pushes them to indhouse.  Dev A tells Dev B hey thoes changes
> are great why don't you push to public server0 so every one can get thoes
> changes.  Dev B then git push origin branch_name on submodule1 and push
> origin on submodule 2 and superproject.  And everything is great ... right?
>
> Yes by now those who know git know what dev B  forgot or more to the point
> what git does not support in a "clean" way.  For those who don't enter the
> life of dev C
>
> So dev C clones from server0 and performs a git submodule update --init
> --recursive.  Now Dev C is on the www and can't see indhouse.corp and ...
> kerpow... Dev B and Dev C just experienced one of the many SW mines on the
> battlefield.
>
> I ask that git devs first see if I am correct with this assessment as I
> could be wrong... maybe there is a way of doing this... and if not add a
> feature to git to handle submodules and multiple origins cleanly.... and yes
> beating dev B with rubber chicken might be a solution though I am looking
> for a slightly better option.

Yes this is a big point that we want to solve eventually.

When devA brought it inhouse, what they meant to do was this:
"This superproject is actually from server0, but we want to work on it, which
may have submodules diverge from server0 eventually. So if a submodule changed
you need to get it from the inhouse server, otherwise fall back to the server0".

That way developerB can just make changes to some submodules and when
devC clones
they get the "correct" submodule.

A weak attempt to do this is to use *relative* submodule urls. When
using relative urls, and then mirroring the supeproject inhouse, then
Git will look for the submodules as well inhouse, but there
is no such "or if not found look at the original superprojects
origin", which means, you have to mirror all submodules.

And then about upstreaming changes. If you have a single repo (no
submodules), you have to teach people to run "git remote add remote
server0.org && git push upstream ...", but that you can do for each
submodule. (This is tedious:/ but maybe ok; some submodules are free
to sent things upstream whereas others are supersecret that you do not
want to push upstream ever.)

So yeah maybe we want to have more power in the superprojects push operation

    (in the superproject) $ git push --recurse-submodules \
       --only-these-submodules=subA,subB \
       --submodule-to=upstream-as-configered-in-super-project

This is a lot of words but for explaining that is ok?

Thanks,
Stefan
