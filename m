Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6F01F461
	for <e@80x24.org>; Sun, 19 May 2019 23:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfESXPx (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 19:15:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39609 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfESXPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 19:15:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so12511308wrl.6
        for <git@vger.kernel.org>; Sun, 19 May 2019 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=glTLOwsbi5650T0RAn0FFgwiZFwn8K2nZ3di6GtsSwQ=;
        b=eWwlBfJADfrtzsNuTnIeRCnYnTS2J6bfpHplc2ILw2D3ZCM+V37oriwDZ5aCVmUdPL
         D3OmKmmW6P90tRB+NojzaF3kP3qv9Vb64LdpMXz21ycUJBcV6BS+Gt5DgMXtaM1heUR0
         ajTaN8Hr7rK3Ug7kFX5NQGlMFNdde7+/bLvt0gpIPp92n8Mglo6RSjwSQ0MgLfSvc4+R
         ts0HZ3J1T19V6ja3O++mv2MwQ8qg+GJrLYW8pVGU4JW3TQiUKwxi8YuH95dkgH8fSbvT
         triCyAQwaA5EUHMffk2UnLSZ8f7aGdsP0yqPEUfnkZJ63yJq3sYGJR5d8Z6h7APh4bGi
         pQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=glTLOwsbi5650T0RAn0FFgwiZFwn8K2nZ3di6GtsSwQ=;
        b=a15fJ76Hq6BOgTMIgAZZsUCcw3PakOSBQfbFckROwCBuvyX39mrx0mJprHEF/pDgH5
         qpNTYiVHYC6glGpg8j2XrIiG3TIYu73GPtcxDypleMflz8+u03Gf4ebhf3Ny023k4vUj
         G+M3Tg0YIpORAR9GG9orrx6l0MzSgGRYI8y9N50YM1ZDzN1dMZqr2pw91uZhbc67huIi
         oUiqWMMxNxi8yGxJVKFrEdlaflParCFI7zKG9KM0Zd9xNcHabNIGDSn9fxgn5xIIBlzc
         gUr068uKEZP89RR/KQHl8ZKGw1rMdg5qfoSMjRWeUu2sc/PGXcFR1waulNTVDHLceNAO
         4P2A==
X-Gm-Message-State: APjAAAWNgfnllkjL9R2JGaZhBVBR+6Dp2EN8EpoLO/hqI9RJfr9svHyb
        wRBEtNLklQ0wWTDE54kpRVKgi3IaqP8=
X-Google-Smtp-Source: APXvYqwHXGD4GA06RuekizD8qIK0js9ncoXnkLdUzSK9txdCVsHLyvZZdC1FBPJUfVmPNgQEdhak2g==
X-Received: by 2002:adf:df87:: with SMTP id z7mr17471400wrl.8.1558307750167;
        Sun, 19 May 2019 16:15:50 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egp40.neoplus.adsl.tpnet.pl. [83.21.79.40])
        by smtp.gmail.com with ESMTPSA id c207sm7957055wme.47.2019.05.19.16.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 16:15:49 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     esr@thyrsus.com, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com>
        <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
        <20190515233230.GA124956@thyrsus.com>
        <87woiqvic4.fsf@evledraar.gmail.com>
Date:   Mon, 20 May 2019 01:15:47 +0200
In-Reply-To: <87woiqvic4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 16 May 2019 11:50:35 +0200")
Message-ID: <86woimox24.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> On Thu, May 16 2019, Eric S. Raymond wrote:
>> Derrick Stolee <stolee@gmail.com>:
>>> On 5/15/2019 3:16 PM, Eric S. Raymond wrote:
>>>> The deeper problem is that I want something from Git that I cannot
>>>> have with 1-second granularity. That is: a unique timestamp on each
>>>> commit in a repository.
>>>
>>> This is impossible in a distributed version control system like Git
>>> (where the commits are immutable). No matter your precision, there is
>>> a chance that two machines commit at the exact same moment on two diffe=
rent
>>> machines and then those commits are merged into the same branch.
>>
>> It's easy to work around that problem. Each git daemon has to single-thr=
ead
>> its handling of incoming commits at some level, because you need a lock =
on the
>> file system to guarantee consistent updates to it.

As far as I understand it this would slow down receiving new commits
tremendously.  Currently great care is taken to not have to parse the
commit object during fetch or push if it is not necessary (thanks to
things such as reachability bitmaps, see e.g. [1]).

With this restriction you would need to parse each commit to get at
commit timestamp and committer, check if the committer+timestamp is
unique, and bump it if it is not.

Also, bumping timestamp means that the commit changed, means that its
contents-based ID changed, means that all commits that follow it needs
to have its contents changed...  And now you need to rewrite many
commits.  And you also break the assumptions that the same commits have
the same contents (including date) and the same ID in different
repositories (some of which may include additional branches, some of
which may have been part of network of related repositories, etc.).

[1]: https://github.blog/2015-09-22-counting-objects/
     http://githubengineering.com/counting-objects/

> You don't need a daemon now to write commits to a repository. You can
> just add stuff to the object store, and then later flip the SHA-1 on a
> reference, we lock those indivdiual references, but this sort of thing
> would require a global write lock. This would introduce huge concurrency
> caveats that are non-issues now.
>
> Dumb clients matter. Now you can e.g. have two libgit2 processes writing
> to ref A and B respectively in the same repo, and they never have to
> know about each other or care about IPC.
>
> Also, even if you have daemons accepting pushes they can now be on
> different computers sharing things over e.g. an NFS filesystem. Now you
> need some FS-based serialization protcol for commits and their
> timestamps.

Also, performance matters.  Especially for large repositories, and for
large number of repositories.

>> So if a commit comes in that would be the same as the date of the
>> previous commit on the current branch, you bump the incoming commit time=
stamp.

You do realize that dates may not be monotonic (because of imperfections
in clock synchronization), thus the fact that the date is different from
parent does not mean that is different from ancestor.

>> That's the simple case. The complicated case is checking for date
>> collisions on *other* branches. But there are ways to make that fast,
>> too. There's a very obvious one involving a presort that is is O(log2
>> n) in the number of commits.

I don't think performance hit you would get would be acceptable.

[...]
>>>> Why do I want this? There are number of reasons, all related to a
>>>> mathematical concept called "total ordering".  At present, commits in
>>>> a Git repository only have partial ordering.
>>>
>>> This is true of any directed acyclic graph. If you want a total ordering
>>> that is completely unambiguous, then you should think about maintaining
>>> a linear commit history by requiring rebasing instead of merging.
>>
>> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DA=
G.
>> The presence of timestamps makes a total ordering possible.
>>
>> (I was a theoretical mathematician in a former life. This is all very
>> familiar ground to me.)

Maybe in theory, when all clock are synchronized.  But not in practice.
Shit happens.  Just recently Mike Hommey wrote about the case he has to
deal with:

MH> I'm hitting another corner case in some other "weird" history, where
MH> I have 500k commits all with the same date.

[2]: https://public-inbox.org/git/20190518005412.n45pj5p2rrtm2bfj@glandium.=
org/t/#u

--
Jakub Nar=C4=99bski
