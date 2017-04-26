Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E18207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 08:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955969AbdDZI4y (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 04:56:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36641 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036119AbdDZI4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 04:56:49 -0400
Received: by mail-it0-f68.google.com with SMTP id x188so23902757itb.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k5S5pvTZEtCkylCQMbZbV5fBxNmqwsHajLDpTFgFOgw=;
        b=l64cvfwgPA4Yia0HMBda1TDXqpDIWaYDNYVaPiKII6XRspnBXkmN/wnS5hWUtY3fhU
         IrOfQTcdgw6Mzm2mCKgg+mZResKapFdWKsiPBHwXQeJ/WF5C4Omdi/S6RpN664yWOOpE
         Zm5lMSpZgObd3v+BDGK+xI0CZWqlKGGg1Y2kBVUxSn8s5nr6E8jhSyu0rPhNpNLvOHgr
         sBnZ9X7YqzVL4O7mZOy/RekHr7CxpwtmSXV4O6tYaXrhdAdk+6VVgujiwzSkxVDbD+CW
         4/QGNQZUdfVnVQN3MdfVlP07JF2UGCFteelDc7v34ah9v0VurTDQTWeZFZkDjFNGXy1s
         A/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k5S5pvTZEtCkylCQMbZbV5fBxNmqwsHajLDpTFgFOgw=;
        b=RPitcmdyGITCS9FVrOR+pwlnI07UuvpujzSm9ro4obuA+6L/YrBCOO7JPMTrct/yBU
         E2LMdob9VZvMSBWVAfXOAcaoMl5iPImmJWsvhGEZzHqfpBRu8rx71/fyUR8THMAml/j6
         xHEb1fgRYvVsR8MPSNdD37aOciU1a3wHhtt2OAva3P3ugNhN8RKBmutZBxJpOU/uIyM1
         GJcGNPzLxcV2QZ3w91uL5Q3l01qGTOOcwvGEOpqubPfc95rfOORHSDZ7c4UC1L0D4MON
         9uEAuMHZObZvF/eIg/9WZ4/hk7byf0NY2lP9wJFUSPZ4DLHocuxTYLqD8fHS4qV8LLgR
         9xBQ==
X-Gm-Message-State: AN3rC/5YNZdgQJ1GR+BW9Is5LukMehrpXT+3Fwb7vKbaNG5AQz+Fd3Ay
        T5yQdn2g4ukWQ+tsepVTSUg6Xm8cdQ==
X-Received: by 10.36.131.65 with SMTP id d62mr9764902ite.66.1493197008691;
 Wed, 26 Apr 2017 01:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 26 Apr 2017 01:56:28 -0700 (PDT)
In-Reply-To: <20170425224521.GM28740@aiede.svl.corp.google.com>
References: <xmqq60i1dvnk.fsf@gitster.mtv.corp.google.com> <20170419143831.6868-1-avarab@gmail.com>
 <20170425224521.GM28740@aiede.svl.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 26 Apr 2017 10:56:28 +0200
Message-ID: <CACBZZX7u_1hifAHxNJU+WCkdk2+s63PV5F5dSx=M5azPE4Ra0A@mail.gmail.com>
Subject: Re: [PATCH v2] clone: add a --no-tags option to clone without tags
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 12:45 AM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi,
>
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> Add a --no-tags option to "git clone" to clone without tags. Currently
>> there's no easy way to clone a repository and end up with just a
>> "master" branch via --single-branch, or track all branches and no
>> tags. Now --no-tags can be added to "git clone" with or without
>> --single-branch to clone a repository without tags.
>
> Now I've read the discussion from v1, so you can see my thoughts
> evolving in real time. :)
>
> The above feels a bit misleading when it says "there's no easy way to
> clone a repository and end up with just a 'master' branch".
> --single-branch does exactly that.

I'll reword this, what I meant is "just a master branch [and no other
references]". Not "just the master branch [and no other branches]".

> Some annotated tags *pointing to
> its history* come along for the ride, but what harm are they doing?

I'll explain this in a bit more detail in the commit message & docs,
both you & Junio (in <xmqq1ssparom.fsf@gitster.mtv.corp.google.com>)
seem to be making the assumption that only getting & maintaining the
tags for the branch you're cloning is cheap.

This assumes a repo that while large, doesn't get a lot of releases on
its main branch. E.g. linux.git has ~650k commits, and ~500 v* tags,
that's a tag every 1300 commits or so.

Now if you run this on linux.git:

    $ git rev-list origin/master | parallel -j6 --progress 'test
"$(echo {} | cut -b1)" =3D 0 && git tag -a -m"msg" test-tag-{}'

You'll get a tag a bit more than every 16 commits, and now a lot of
everyday commands become slow, because a lot of them need to look at
every ref before they start:

    $ (time (git log -1 >/dev/null)) 2>&1|grep ^real
    real    0m1.304s

Whereas on a linux.git without all those tags:

    $ (time (git log -1 >/dev/null)) 2>&1|grep ^real
    real    0m0.027s

And you can imagine what this does to some other commands, e.g. bash comple=
tion:

    $ git log <TAB>
    Display all 512 possibilities? (y or n)

v.s.:

    $ git log <TAB>
    Display all 42129 possibilities? (y or n)

Furthermore, if upstream has a high tag churn, i.e. creates lots of
tags but prunes them regularly even if you set tagOpts=3D--prune you'll
still end up with an every slower local repository as you slowly
accumulate every tag upstream has created every, you'd need to fetch
with:

    $ git fetch origin --prune 'refs/tags/*:refs/tags/*'

Simply never fetching the tags in the first place & making sure they
aren't fetched avoids all of this, and is perfect e.g. for the use
case of something that runs an automated "pull" on the repo to index
its code (I initially wrote this for a https://github.com/etsy/hound/
setup), or if you'd just like to run the likes of "git log" on the
master branch without starting that up taking a second longer.

> In other words, I think the commit message needs a bit more detail about
> the use case, to say why omitting those tags is useful.  The use case
> is probably sane but it is not explained.  A side effect (and my main
> motivation) is that this would make it crystal clear to people looking
> at the patch in history that it is talking about tags that are part of
> "master"'s history, not tags pointing elsewhere.

I'll add that.

>> Before this the only way of doing this was either by manually tweaking
>> the config in a fresh repository:
>
> Usually commit messages refer to the state of things without some
> patch using the present tense --- e.g. "Without this patch, this
> --no-tags option can be emulated by (1) manually tweaking the config
> in a fresh repository, or (2) by setting tagOpt=3D--no-tags after
> cloning and deleting any existing tags".
>
> [...]
>> Which of course was also subtly buggy if --branch was pointed at a
>> tag, leaving the user in a detached head:
>>
>>     git clone --single-branch --branch v2.12.0 git@github.com:git/git.gi=
t &&
>>     cd git &&
>>     git config remote.origin.tagOpt --no-tags &&
>>     git tag -l | xargs git tag -d
>
> At this point I lose the trail of thought.  I don't think it's
> important to understanding the patch.

I'm going to leave that in because anyone who needs this feature for a
similar use-case (which I'll explain in more detail), would need to do
exactly that to get a bug-compatible version of the same behavior if
they need to run on an older git version for whatever reason.

>> Now all this complexity becomes the much simpler:
>>
>>     git clone --single-branch --no-tags git@github.com:git/git.git
>>
>> Or in the case of cloning a single tag "branch":
>>
>>     git clone --single-branch --branch v2.12.0 --no-tags git@github.com:=
git/git.git
>
> Nice.
>
> [...]
>>  Documentation/git-clone.txt | 14 ++++++++-
>>  builtin/clone.c             | 13 ++++++--
>>  t/t5612-clone-refspec.sh    | 73 ++++++++++++++++++++++++++++++++++++++=
+++++--
>>  3 files changed, 95 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index 30052cce49..57b3f478ed 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -13,7 +13,7 @@ SYNOPSIS
>>         [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
>>         [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <reposit=
ory>]
>>         [--dissociate] [--separate-git-dir <git dir>]
>> -       [--depth <depth>] [--[no-]single-branch]
>> +       [--depth <depth>] [--[no-]single-branch] [--no-tags]
>
> Can I pass --tags to negate a previous --no-tags?

Yeah both --tags and --no-no-tags work as with every other OPT_BOOL
option. See "[RFC PATCH] parse-options: disallow double-negations of
options starting with no-".

> [...]
>> +--no-tags::
>> +     Don't clone any tags, and set
>> +     `remote.<remote>.tagOpt=3D--no-tags` in the config, ensuring
>> +     that future `git pull` and `git fetch` operations won't follow
>> +     any tags. Subsequent explicit tag fetches will still work,
>> +     (see linkgit:git-fetch[1]).
>> ++
>> +Can be used in conjunction with `--single-branch` to clone & maintain
>
> nit: s/&/and/

Will fix.

> [...]
>> +test_expect_success 'clone with --no-tags' '
>> +     (
>> +             cd dir_all_no_tags && git fetch &&
>> +             git for-each-ref refs/tags >../actual
>
> nit: this would be easier to read with the 'cd' and 'git fetch' on
> separate lines.
>
> [...]
>> +test_expect_success '--single-branch while HEAD pointing at master and =
--no-tags' '
>> +     (
>> +             cd dir_master_no_tags && git fetch &&
>
> Likewise.

This was following the existing style in the file, but sure, I'll
prepend a patch to this series to fix all of that before building this
patch on top.

>> +             git for-each-ref refs/remotes/origin |
>> +             sed -e "/HEAD$/d" \
>> +                 -e "s|/remotes/origin/|/heads/|" >../actual
>
> Can $/ be expanded by the shell?

I think not, and if there's some issue with it it's obscure enough to
not have caused issues since 31b808a032 ("clone --single: limit the
fetch refspec to fetched branch", 2012-09-20) which introduced this
pattern earlier in the test file, I'm just copy/pasting similar setup
from elsewhere in the file.
