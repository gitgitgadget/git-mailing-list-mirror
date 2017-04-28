Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7988207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423855AbdD1OpX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:45:23 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36343 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939370AbdD1OpV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:45:21 -0400
Received: by mail-io0-f196.google.com with SMTP id x86so11632059ioe.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LOLw75jTedHNS0FTNmBGekRiNdsi+lbO50cyBiEk6Ic=;
        b=re3t5y8/nI1T6RVs3qfZ40V5nT654recpObxDj04jJqGCfggc3UAMQGaGpoZk+dIFA
         waNRlNfLnbQd0FV6uU8PVGSQlHTRmS6EUr9LX8Cbg2sfHjtz28nCIdWoyLA0vk1MH4Aw
         oLw1r2mnT2m4gZczaCAWF51inVc41b8d3t8LWgUaKqGc1+xjWF6vvWVtMS9i6GnBvQjm
         oyku5QswOizm6KlYOSqyISqsUToE4c+n5c4O8YdzLH8ElYeVQJerniSxt5zY0JFDlA8s
         J6kiAZtoWkXGGR4cbbk+xbfLRT/9jjUK+SS9aH3xFwX5dP5Jw2+oJfRQCFn3qsXFtXcs
         44oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LOLw75jTedHNS0FTNmBGekRiNdsi+lbO50cyBiEk6Ic=;
        b=qTntWKpG2YY9EcK9KesZjhTJcdpn5K3iwNaFn1uJXij6DpuQ3ONzvoAXn74YJntkXY
         54DWhCSRjL/8+gSbhiZDOvLwkqGvIRLPlusJgWxKGPBYnGX5dqAnV/5QHc8WObPbqTL2
         lI2wcKEFuXtGdYkKQQo1O0ZjzmAxvoBg+8wWfhV+qVOQ0fTZ2663dRHxxNCqfaNh8ctU
         ZOUIyYB8w8Wv6mkxWoEp/FFSLVNEo/l6lutOS8m2pioFnDi1VmwHo/T2yZXEHupuWQ/4
         lmxAaoG3uNYrFXOJl0ST2MwmIoajpcsx63Z1fPU5LI4I/XgUk5h4aQ5HTtHUZIDn8+Ju
         4vBA==
X-Gm-Message-State: AN3rC/4vmmuuA5g21tFsSXnoLuVZliyYx5nXNdt/dstOpRqbIBeXt+5q
        DAk4KOsCafjlyeIgqHE3Fb8omkO0OBnTDZs=
X-Received: by 10.107.138.9 with SMTP id m9mr10855802iod.80.1493390720326;
 Fri, 28 Apr 2017 07:45:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 28 Apr 2017 07:44:59 -0700 (PDT)
In-Reply-To: <CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-3-avarab@gmail.com>
 <CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 28 Apr 2017 16:44:59 +0200
Message-ID: <CACBZZX5dxaJDN18J5fAhjKcaP8cZSTtRw5-eScr2oq8OYyhKuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] clone: add a --no-tags option to clone without tags
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 7:54 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Add a --no-tags option to clone without fetching any tags.
>>
>> Without this change there's no easy way to clone a repository without
>> also fetching its tags.
>>
>> When supplying --single-branch the primary remote branch will be
>> cloned, but in addition tags will be followed & retrieved. Now
>> --no-tags can be added --single-branch to clone a repository without
>> tags, and which only tracks a single upstream branch.
>>
>> This option works without --single-branch as well, and will do a
>> normal clone but not fetch any tags.
>>
>> Many git commands pay some fixed overhead as a function of the number
>> of references. E.g. creating ~40k tags in linux.git will cause a
>> command like `git log -1 >/dev/null` to run in over a second instead
>> of in a matter of milliseconds, in addition numerous other things will
>> slow down, e.g. "git log <TAB>" with the bash completion will slowly
>> show ~40k references instead of 1.
>>
>> The user might want to avoid all of that overhead to simply use a
>> repository like that to browse the "master" branch, or something like
>> a CI tool might want to keep that one branch up-to-date without caring
>> about any other references.
>>
>> Without this change the only way of accomplishing this was either by
>> manually tweaking the config in a fresh repository:
>>
>>     git init git &&
>>     cat >git/.git/config <<EOF &&
>>     [remote "origin"]
>>         url =3D git@github.com:git/git.git
>>         tagOpt =3D --no-tags
>>         fetch =3D +refs/heads/master:refs/remotes/origin/master
>>     [branch "master"]
>>         remote =3D origin
>>         merge =3D refs/heads/master
>>     EOF
>>     cd git &&
>>     git pull
>>
>> Which requires hardcoding the "master" name, which may not be the main
>> --single-branch would have retrieved, or alternatively by setting
>> tagOpt=3D--no-tags right after cloning & deleting any existing tags:
>>
>>     git clone --single-branch git@github.com:git/git.git &&
>>     cd git &&
>>     git config remote.origin.tagOpt --no-tags &&
>>     git tag -l | xargs git tag -d
>>
>> Which of course was also subtly buggy if --branch was pointed at a
>> tag, leaving the user in a detached head:
>>
>>     git clone --single-branch --branch v2.12.0 git@github.com:git/git.gi=
t &&
>>     cd git &&
>>     git config remote.origin.tagOpt --no-tags &&
>>     git tag -l | xargs git tag -d
>>
>> Now all this complexity becomes the much simpler:
>>
>>     git clone --single-branch --no-tags git@github.com:git/git.git
>>
>> Or in the case of cloning a single tag "branch":
>>
>>     git clone --single-branch --branch v2.12.0 --no-tags git@github.com:=
git/git.git
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> I like the option, though I dislike the implementation, specifically as y=
ou
> brought up e.g. "[PATCH] various: disallow --no-no-OPT for --no-opt optio=
ns".
>
> Can we have an option "--tags" instead, which is on by default
> and then you can negate it to --no-tags, without having to worry
> about the no-no case.
>
> The problem with tags is that they are in a shared name-space
> and not part of the remote refspec. If they were, the documentation
> would be way easier, too going this way.

I don't mind doing it this way, but this really should be part of an
unrelated topic to eliminate --no-OPT in favor of just --OPT which is
supplied by default, if we want to go that route.

Right now it makes more sense to have a --no-tags, because this along
with e.g. --no-hardlinks and numerous other options[1] is for an
obscure use-case most users won't care about, and then we have &
document --no-BEHAVIOR.

Perhaps we shouldn't have that at all, go through all these --no-OPT
and replace them with --OPT in both the docs & code & get rid of the
--no-no-OPT & some confusion that way.

1. git grep -- '\[--no-' Documentation/git-*txt

>> +--no-tags::
>> +       Don't clone any tags, and set
>> +       `remote.<remote>.tagOpt=3D--no-tags` in the config, ensuring
>> +       that future `git pull` and `git fetch` operations won't follow
>> +       any tags. Subsequent explicit tag fetches will still work,
>> +       (see linkgit:git-fetch[1]).
>> ++
>> +Can be used in conjunction with `--single-branch` to clone and
>> +maintain a branch with no references other than a single cloned
>> +branch. This is useful e.g. to maintain minimal clones of the default
>> +branch of some repository for search indexing.
>
> In the future we may want to have '--depth' also imply --no-tags,
> just as it implies --single-branch.

Are there some cases where we'd like to also somehow import & rewrite
tags covering the given --depth?

>> @@ -652,7 +655,7 @@ static void update_remote_refs(const struct ref *ref=
s,
>>
>>         if (refs) {
>>                 write_remote_refs(mapped_refs);
>> -               if (option_single_branch)
>> +               if (option_single_branch && !option_no_tags)
>
> I am debating if this needs to be an || instead of &&, as you would not
> want to write the tags with "--no-single-branch --no-tags" ?

This hunk is confusing out of context, but I believe it's doing the
right thing now. This write_followtags() codepath is only taken (and
is only meaningful) with --single-branch, there's an earlier change
just before that:

    -       if (!option_mirror && !option_single_branch)
    +       if (!option_mirror && !option_single_branch && !option_no_tags)
                    get_fetch_map(refs, tag_refspec, &tail, 0);

Which ensures that with --no-single-branch --no-tags that tags aren't
written, and there's tests for that.
