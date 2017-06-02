Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B208520D0C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdFBXfH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:35:07 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33296 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBXfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:35:06 -0400
Received: by mail-pf0-f175.google.com with SMTP id 83so433836pfr.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ob2e3R3CMK5PnfV3OT2gmAazaZ3vRPq2Ghvdp2cHsFM=;
        b=AweL6m4Jue1bvZwPUQZZWv5zD/NA5JjYo+rTe7Y5SWXqjMEzzuoAbpNr1EYc9bbyDB
         c26/EIbiKj5dQK1qhCMJEvfvQpk2bv34/FcnMplJwatw2KML+OcHJVQqIPANax/XKcOH
         zzc6ARR1LTDzTTi0SyWx1F2+cSidw0yPaauQzGC80s7syAsKtjIgDjuhfTwhkF/4T/C5
         v4sp1eEqESIkIk1csiKpsEl8MdmGQgy9YhZUf2hhL7nCHm67oCv5FohU4wAh8iC9d7eL
         sSIAyOO8EbGfFVS5tRmKtuYOK7SOseRyfssDK6MzK8e7wcksjzYlR34JlDi2vuErV5RT
         wVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ob2e3R3CMK5PnfV3OT2gmAazaZ3vRPq2Ghvdp2cHsFM=;
        b=KhCuy9SnQxbp6s82r4sg4cxTQIbQbP7UKeXMJhprCtf+Rdyld+Bf6y5wbPamJBEc41
         wN88eEBtDXuJfKctnrD5C4vdB+OrvsvwDClpuD4WIzS63BzFHgjh1MEGOBH3omWzc9lY
         isTRZ7uv8A83Zq6WXoVyZ37ZmR0NpyJBOQ6PTs9y3KoTCOHc9aTV3JpaGnOWli60W2kh
         gb6CS/0QHT3Jgw29SIqONDKBlGOnPXXMo0/QCRiPnVFwVjj+QOCJ0ACCUkQsCrCPyJnZ
         WRwry18Dwqyb3GIa66VhPCLv6KYhblQ/if9PBXNIzZM69p7Vn7ptc4XGFJUvLijB+5wu
         pnLg==
X-Gm-Message-State: AODbwcA4GmMKMDZRMNE+m/7n2PJfd+mLTM2Xzfyhyj4LafPF6zF3Vx3j
        09bkwwBFnLx5gatV3NOikg==
X-Received: by 10.99.42.68 with SMTP id q65mr9708449pgq.78.1496446505703;
        Fri, 02 Jun 2017 16:35:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id t198sm43406578pgc.33.2017.06.02.16.35.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 16:35:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
References: <20170530173109.54904-1-bmwill@google.com>
        <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
        <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com>
        <xmqqtw3yyhzc.fsf@gitster.mtv.corp.google.com>
        <20170602182215.GA57260@google.com>
Date:   Sat, 03 Jun 2017 08:35:03 +0900
In-Reply-To: <20170602182215.GA57260@google.com> (Brandon Williams's message
        of "Fri, 2 Jun 2017 11:22:15 -0700")
Message-ID: <xmqqpoemx8t4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/02, Junio C Hamano wrote:
>> 
>> I lied.  This also conflicts somewhat with Peff's diff-blob topic.
>> I think I resolved them correctly (there needs evil merges applied
>> to two files when merging this topic), and hopefully can push out
>> the result by the end of the day.
>> 
>> Thanks.
>
> If it ends up being too much of a headache for you to deal with, let me
> know and I can rebase on top of those series.  That way you don't have to
> deal with the conflict resolutions.  Just let me know what you'd like me
> to do.

Sorry, I forgot to push the result out, even though I double checked
the conflict resolution I did last night.  Now it is in the public
repository.  I have one squash queued at the right place to update
SHA1s to OIDs in the comment Brian pointed out.

If you ever need to rebase this on top of future 'master' that
already has js/blame-lib topic, fetching from me and checking
the evil merge I did may turn out to be helpful:

 $ git fetch git://github.com/gitster/git refs/merge-fix/bw/object-id
 $ git show FETCH_HEAD

but I can take patches based on the same old 'master'; as long as
the evil merge above is correct, that would probably be preferrable,
as it makes it easier to compare the two iterations of your series.

Repeating some backstory of "merge-fix" might be beneficial, if a
reader is interested.  Otherwise the remainder of this message can
safely be skipped.

After a topic (i.e. js/blame-lib) moves a lot of code around (i.e. a
bulk of what used to be in builtin/blame.c is now in blame.c and
some in diff.c), merging a topic that touches places in the code
that was moved in-place (i.e. bw/object-id, which updates the code
in builtin/blame.c) will leave a conflict that looks like:

    <<<<<<< HEAD
    ... very little that is left after moving
    ... bunch of code out of this file
    ||||||| common
    ... a lot of
    ... stuff before
    ... your change from SHA1 to OID
    ... is here
    =======
    ... a lot of
    ... stuff after
    ... your change from SHA1 to OID
    ... is here
    >>>>>>> theirs

As far as builtin/blame.c is concerned, the resolution for this
set of conflicts is just to take the HEAD version, ignoring all of
your SHA1-to-OID changes.  Once it is resolved, "rerere" can help
us remember this resolution to builtin/blame.c

But the ignored changes need to go somewhere else.

What the user who is doing a merge does at this point is to compare
what is between ||||||| and ======= (i.e. common ancestor's version)
with what is between ======= and >>>>>>> (i.e. their version) to
figure out what the branch being merged did.  And the user needs to
know where the common code went in the version in HEAD.

 $ git log [--no-merges] -p MERGE_HEAD.. -- builtin/blame.c

is helpful to locate the commit that lost the common lines from the
file.  And "git show" on it will tell us that they mostly went to
blame.c while some migrating to diff.c; we found out what you did by
comparing "common" and "theirs" in the previous step and we apply
these changes to these "new" places.

And that is the diff you see in refs/merge-fix/bw/object-id.  The
script I use to re-build 'pu' every day (probably I use it three
times a day on average) knows about that ref.  The script starts
from the tip of 'master', and for each topic, (1) run "git merge"
into HEAD, (2) take resolution recorded by "rerere" and (3) if
merge/fix/$topic exists, cherry-pick it on top to squash into the
merge made in (2).

Once I have taught my rerere database and refs/merge-fix/ about this
merge, it is not too big a deal to redo the merge to adjust to an
updated 'master' or a new interation of your series because of the
above mechanism.  And that is why I say it is OK for an updated series
to be based on the same old 'master'.

Thanks.


