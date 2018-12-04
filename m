Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10BD211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 13:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLDNgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 08:36:02 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33733 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLDNgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 08:36:02 -0500
Received: by mail-wr1-f54.google.com with SMTP id c14so15999436wrr.0
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 05:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K0UIUZd4jbZ8HddNyTgnJGGsAZ/q9C5vG+mWqnfo4/4=;
        b=SWm8BS0jQfg8eIyOZzCPx9LII3jGBiX/4uD0oUvhKqnEsZr+k8Jn1b2vQ6/JNyG4bX
         H3tjOGcbykgtLt5xdBZ6HTgaBzew0oOnxYqHYFxJjRlemJvDlQRlldCJXKz2vN51J83r
         MuJI3a0GjXv2q3Zxb0jVcxkHh1LO8IKW9bbwR9prvAu5PGV9Anbyrz2kEK5akTmScfCr
         rg8VttZKVHnfLnFTx5mY9ol7aRVUxCpMxoFNTrr1i8RcOR/46gUOzDt+IrZxVQ7rFmgF
         hsqSpP9RWLRQIKK7tjaqZkgFdL/sHTislxbFEm9ZSrvevN9DloMToa+KuNmDWcfYQ8tR
         IU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K0UIUZd4jbZ8HddNyTgnJGGsAZ/q9C5vG+mWqnfo4/4=;
        b=e6Tqr4coGOenjV922DA0jYB8pMqQBVAMSzAGnf47jyLx7ldOjIhLy8gQgcjYyFy4zS
         D0v3xlKbzKSN06odHyW/515asruBdbsvBoGy3jNKdBlX7eliRFCeM5rONI9Z7Y/iYmE8
         4mUSWvuQdNWEWme045atRF9FlyLLkGuN9PUyQrWkw2mRKi2P/X3Kiz4n621JvEV9TYtx
         ICuIqVAlMpUv5paG/7KZ9fENvCbHTxbgHM6nlcrny/mK3ud0TRzvPTT23ZrFqnRsaDbZ
         h+myibXnAM6lSh8BBsgaZW6qb5Q4RdIo0vAhCz0VoCC9SdPKa5RNZ6JqJklA+r8q1rXD
         5EsA==
X-Gm-Message-State: AA+aEWZ6AeFC7zxTcS2UV+u2yTEKGVsvb1Cu1/C92M0w2bjxHe25MO+S
        M5eiY9DAtGwfnkJLQVa7yNVnlTe3
X-Google-Smtp-Source: AFSGD/U6RYPvLjuoxPds0xD6GREPfFpZ5/9fW1teVdbqNT9C+x8pmDrpG0YuWdlKI+g3c8VMAF07NQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr17954414wrq.16.1543930558348;
        Tue, 04 Dec 2018 05:35:58 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id o17sm6013331wmg.35.2018.12.04.05.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 05:35:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
References: <87zhtsx73l.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87zhtsx73l.fsf@evledraar.gmail.com>
Date:   Tue, 04 Dec 2018 14:35:56 +0100
Message-ID: <87sgzdv2gz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 29 2018, Ævar Arnfjörð Bjarmason wrote:

> A co-worker asked me today how space could be saved when you have
> multiple checkouts of the same repository (at different revs) on the
> same machine. I said since these won't block-level de-duplicate well[1]
> one way to do this is with alternates.
>
> However, once you have an existing clone I didn't know how to get the
> gains without a full re-clone, but I hadn't looked deeply into it. As it
> turns out I'm wrong about that, which I found when writing the following
> test-case which shows that it works:
>
>     (
>         cd /tmp &&
>         rm -rf /tmp/git-{master,pu,pu-alt}.git &&
>
>         # Normal clones
>         git clone --bare --no-tags --single-branch --branch master https://github.com/git/git.git /tmp/git-master.git &&
>         git clone --bare --no-tags --single-branch --branch pu https://github.com/git/git.git /tmp/git-pu.git &&
>
>         # An 'alternate' clone using 'master' objects from another repo
>         git --bare init /tmp/git-pu-alt.git &&
>         for git in git-pu.git git-pu-alt.git
>         do
>             echo /tmp/git-master.git/objects >/tmp/$git/objects/info/alternates
>         done &&
>         git -C git-pu-alt.git fetch --no-tags https://github.com/git/git.git pu:pu
>
>         # Respective sizes, 'alternate' clone much smaller
>         du -shc /tmp/git-*.git &&
>
>         # GC them all. Compacts the git-pu.git to git-pu-alt.git's size
>         for repo in git-*.git
>         do
>             git -C $repo gc
>         done &&
>         du -shc /tmp/git-*.git
>
>         # Add another big history (GFW) to git-{pu,master}.git (in that order!)
>         for repo in $(ls -d /tmp/git-*.git | sort -r)
>         do
>             git -C $repo fetch --no-tags https://github.com/git-for-windows/git master:master-gfw
>         done &&
>         du -shc /tmp/git-*.git &&
>
>         # Another GC. The objects now in git-master.git will be de-duped by all
>         for repo in git-*.git
>         do
>             git -C $repo gc
>         done &&
>         du -shc /tmp/git-*.git
>     )
>
> This shows a scenario where we clone git.git at "master" and "pu" in
> different places. After clone the relevant sizes are:
>
>     108M    /tmp/git-master.git
>     3.2M    /tmp/git-pu-alt.git
>     109M    /tmp/git-pu.git
>     219M    total
>
> I.e. git-pu-alt.git is much smaller since it points via alternates to
> git-master.git, and the history of "pu" shares most of the objects with
> "master". But then how do you get those gains for git-pu.git? Turns out
> you just "git gc"
>
>     111M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.1M    /tmp/git-pu.git
>     115M    total
>
> This is the thing I was wrong about, in retrospect probably because I'd
> been putting PATH_TO_REPO in objects/info/alternates, but we actually
> need PATH_TO_REPO/objects, and "git gc" won't warn about this (or "git
> fsck"). Probably a good idea to patch that at some point, i.e. whine
> about paths in alternates that don't have objects, or at the very least
> those that don't exist. #leftoverbits
>
> Then when we fetch git-for-windows:master to all the repos they all grow
> by the amount git-for-windows has diverged:
>
>     144M    /tmp/git-master.git
>     36M     /tmp/git-pu-alt.git
>     36M     /tmp/git-pu.git
>     214M    total
>
> Note that the "sort -r" is critical here. If we fetched git-master.git
> first (at this point the alternate for git-pu*.git) we wouldn't get the
> duplication in the first place, but instead:
>
>     144M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.1M    /tmp/git-pu.git
>     148M    total
>
> This shows the importance of keeping such an 'alternate' repo
> up-to-date, i.e. we don't get the duplication in the first place, but
> regardless (this from a run with sort -r) a "git gc" will coalesce them:
>
>     131M    /tmp/git-master.git
>     2.1M    /tmp/git-pu-alt.git
>     2.2M    /tmp/git-pu.git
>     135M    total
>
> If you find this interesting make sure to read my
> https://public-inbox.org/git/87k1s3bomt.fsf@evledraar.gmail.com/ and
> https://public-inbox.org/git/87in7nbi5b.fsf@evledraar.gmail.com/ for the
> caveats, i.e. if this is something intended for users then no ref in the
> alternate can ever be rewound, that'll potentially result in repository
> corruption.
>
> 1. https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/

Maybe this is useful to someone. Here's a cronjob I wrote since I wrote
this thread that runs in daily cron on some of our systems.

It expects repositories in /var/lib/git_tree-for-alternates like
/var/lib/git_tree-for-alternates/git/git.git to exist, then scours /home
and /etc/puppet/environments (which we had a lot of) for "config" files
with the string in git/git (this saves us some work) and then tries to
find a git repository relative to that "config" file with "rev-parse
--absolute-git-dir".

If there is one, we check if the repository has a SHA-1 that the history
of our /var/lib/git_tree-for-alternates/git/git.git started with (if >1
we pick the oldest), if so this is a repository that can benefit from
using /var/lib/git_tree-for-alternates/git/git.git/objects as an
alternate, and we add the appropriate alternate info, unset
gc.bigPackThreshold so GC will actually do its work, and run "git gc"
sudo'd as the the user who owns the thing.

One one server the .git directories in /home went from ~2TB to ~100GB
using this script. On another from ~250G to ~5G. The leftover space
spent is the commit-grah (not de-duped like objects are), and whatever
accumulated divergence (topic branches mainly) exist in those repos
different than what the alternate store has in the HEAD branch.

#!/bin/bash

set -euo pipefail

ALTERNATES_STORE=/var/lib/git_tree-for-alternates

if ! test -d $ALTERNATES_STORE
then
    echo 'We have no alternates repositories here to point to!' >&2
    exit 0
fi


find_owning_user() {
    path=$1
    case $path in
        /home/*|/etc/puppet/environments/*)
            who=$(echo $path | perl -pe 's[^
                (?:
                    /home
                    |
                    /etc/puppet/environments
                )
                /
                ([^/]+)
                /
                .*
            ][$1]gx')
            if getent passwd $who >/dev/null
            then
                echo $who
            else
                echo "Know how to get user from path '$path', but '$who' is not a valid user!" >&2
            fi
            ;;
        *)
            echo "Don't know how to get user from path '$path' yet!" >&2
            ;;
    esac
}

find $ALTERNATES_STORE -type d -name '*.git' -printf "%P\n" |
while read alternate
do
    alternate_no_git=$(echo $alternate | sed 's/\.git//')
    ALTERNATES_STORE_OBJECTS=$ALTERNATES_STORE/$alternate/objects

    # If these repositories we're finding don't share a root commit
    # with the repo we have this is not going to work and we have the
    # wrong match. Note that we can have more than one root commit
    # and try to find the oldest one. Pretty sure bet that that's
    # the "real" root.
    root_commit=$(git -C $ALTERNATES_STORE/$alternate log --max-parents=0 --date-order --reverse --pretty=format:%H | head -n 1)
    echo "> Finding repositories on the system that share the $root_commit commit with $alternate" >&2

    find \
        /home \
        $(if test -d /etc/puppet/environments; then echo /etc/puppet/environments; fi) \
        -type f -name 'config' -exec grep -Hl $alternate_no_git {} \; 2>/dev/null |
    while read config
    do
        dirname=$(dirname $config)
        echo ">> Checking if $dirname is in a $alternate git repository..." >&2
        if git_dir=$(git -C $dirname rev-parse --absolute-git-dir) &&
                git -C $git_dir cat-file -e $root_commit
        then
            echo ">>> ...Yes it was, at $git_dir" >&2
            echo ">>>> Is it already migrated?..." >&2
            if test -e $git_dir/objects/info/alternates &&
                    grep -x -F -q $ALTERNATES_STORE_OBJECTS $git_dir/objects/info/alternates
            then
                echo ">>>> ...yes, nothing to do here" >&2
                continue
            else
                echo ">>>> ...no, doing migration" >&2

                who=$(find_owning_user $git_dir)
                if test -z "$who"
                then
                    echo ">>>>> unable to find who owns $git_dir" >&2
                    continue
                else
                    echo ">>>>> found that $who owns $git_dir" >&2
                fi

                if test "$DRY_RUN" = "1"
                then
                    echo ">>>>>> Would have ran commands migrating $git_dir"
                else
                    if ! sudo -u $who stat $git_dir >/dev/null 2>&1
                    then
                        echo ">>>>>> The '$who' user can't access his own '$git_dir'. Could be e.g. ex-employee. Using 'root'"
                        who=root
                    fi

                    echo ">>>>>> Migrating $git_dir is now $(sudo -u $who du -sh $git_dir | cut -f1)"
                    sudo -u $who git -C $git_dir config gc.bigPackThreshold 0
                    echo $ALTERNATES_STORE_OBJECTS | sudo tee -a $git_dir/objects/info/alternates >/dev/null
                    sudo -u $who git -C $git_dir gc
                    echo ">>>>>> Migrated $git_dir is now $(sudo -u $who du -sh $git_dir | cut -f1)"
                fi
            fi
        else
            echo ">>> No it isn't. Skipping it" >&2
            continue
        fi
    done
done
