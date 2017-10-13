Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144DF1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 10:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbdJMKvt (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 06:51:49 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:43348 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdJMKvs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 06:51:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id m72so27634515wmc.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2iVG2I389DAcjcolRM5JRcycwx3Z2p5Jz88pHkS7rp8=;
        b=qdLrnB+Ekz4zWO6SNVKcg8yZ6D7v/IoGSZXf7mYMg9ZSHTIPDwEGZushtEogyjMoTt
         YnZq4JPFcxtmYaOK1IufzLpl19W8cD+GiQVXRf+ef9XOYQC921O0Sd1QCbVFN4SSC7De
         XH6Sf4EuI+M75iVQk61NsZQt//fR1MptoK2KkMxrXznjCVtiLjnJQU0YJ+JJjreMJ/vr
         Vbvt800VwChgx1C2omrJV32TPjS5tVserluGBX1nBUkrNoR8VdiCuppgCf3xKDogkJ1q
         GapRqKzZMytVi88XccEttVDAKE4bbgTne+xU9nyUQBznCm52HUMAFQFTHIDH4McrDHSI
         cIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2iVG2I389DAcjcolRM5JRcycwx3Z2p5Jz88pHkS7rp8=;
        b=acMkLJZargWJQ2aq8cAJZgWHsGhT/yn18KRVNogxGnrjv4yZmi2ge0Z+TGFSqPMF8o
         GYmSa5eAmrdi0pkkwBUgHIw/HJQcyzZBc9gXeUujjDjw4ljVb3iHWqzNWKy6pIx9P5Og
         i2kWeQXlTnqxp+hCeqkiiR7ARtZtnCUKCV7O4c3T5xxMT6qqwB+B/VR+xoHRPv4WTZUK
         aqQsEV+EpT8k0erzEkKMEY8B2AcgO50l51b26awPcQujGAt/Ig3ipBjM+o5qR5p9x379
         rIVN0rNbsRtmdzx99xxja0AKenSLQolhZof0xUTCnm4WG8p4lu5cVSTyeWgOA7QqheJQ
         UzfQ==
X-Gm-Message-State: AMCzsaWN4zitSNHpc84iXLBRA+KHjBUehoIe/FqbuPZGCeBK4Qy0H/sd
        gX26vqqgNqjgtwJ5D6+3ripOHehi
X-Google-Smtp-Source: AOwi7QDi/2gp/n58/yq9Kip3QaqvqL+Zjw6+fy9h9WWpuvKj9LxGOiy4xQTjvm2t1uj8dieZuEAhRQ==
X-Received: by 10.80.162.231 with SMTP id 94mr1620225edm.280.1507891907135;
        Fri, 13 Oct 2017 03:51:47 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id h51sm635388eda.56.2017.10.13.03.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Oct 2017 03:51:46 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1e2xZB-0005KB-JG; Fri, 13 Oct 2017 12:51:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org> <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com> <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
Date:   Fri, 13 Oct 2017 12:51:45 +0200
Message-ID: <87wp3zs4la.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 05 2017, Johannes Sixt jotted:

> Am 05.10.2017 um 21:33 schrieb Stefan Beller:
>> On Thu, Oct 5, 2017 at 12:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> +git-post(1)
>>> +===========
>>> +
>>> +NAME
>>> +----
>>> +git-post - Apply a commit on top of a branch that is not checked out

It would be great to have this somehow, whatever the UI ends up being.

>> Contrasted to:
>>    git-cherry-pick - Apply the changes introduced by some existing commits
>> Some questions on top of my head:
>> * Do we want to emphasize the cherry-pick to say checked out?
>
> Maybe. Maybe "cherry picking" is sufficiently clear that it is not needed.
>
>> * Is it a good design choice to have a different command, just because the
>>    target branch is [not] checked out?
>
> I would not want to make it a sub-mode of cherry-pick, if that is what
> you mean, because "cherry picking" is about getting something, not
> giving something away.

It occurs to me that a better long-term UI design might be to make
git-{cherry-pick,pick) some sort of submodes for git-commit.

Right now git-commit picks the current index for committing, but "use a
patch as the source instead" could be a submode.

Right now it commits that change on top of your checked out commit, but
"other non-checked-out target commit" could be a mode instead,
i.e. exposing more of the power of the underlying git-commit-tree.

Just food for thought.

>> * Naming: I just searched for synonyms "opposite of cherry-picking" and
>>    came up with cherry-put, cherry-post, target-commit
>
> With command line completion, we have to type 'git cherr<TAB>-<TAB>'
> currently. If we add another command that begins with 'cherry-',
> another <TAB> is needed. Therefore, I do not want to use a name
> starting with 'cherry-'.
>
>> * What was the rationale for naming it "post" (it sounds very generic to me)?
>
> Yes, it is generic, but I did not find a better word that means "give
> away" a commit. Perhaps "tack"?

[Not entirely serious]. Well if cherry-picking is taking a thing and
eating it here, maybe git-cherry-puke takes an already digested thing
and "throws" it elsewhere ?:)

It's a silly name but it's somewhat symmetric :)

>> * Does it play well with worktrees? (i.e. if a worktree has a branch checked
>>    out, we cannot post there, or can we?)
>
> Good point. It should be forbidden, but there are no safety checks,
> currently.
>
>>> +EXAMPLES
>>> +--------
>>> +
>>> +Assume, while working on a topic, you find and fix an unrelated bug.
>>> +Now:
>>> +
>>> +------------
>>> +$ git commit                                   <1>
>>> +$ git post master                              <2>
>>> +$ git show | git apply -R && git reset HEAD^   <3>
>>> +------------
>>> +
>>> +<1> create a commit with the fix on the current branch
>>> +<2> copy the fix onto the branch where it ought to be
>>> +<3> revert current topic branch to the unfixed state;
>>> +can also be done with `git reset --keep HEAD^` if there are no
>>> +unstaged changes in files that are modified by the fix
>>> +
>>> +Oftentimes, switching branches triggers a rebuild of a code base.
>>> +With the sequence above the branch switch can be avoided.
>>> +That said, it is good practice to test the bug fix on the
>>> +destination branch eventually.
>>
>> This is a cool and motivating example.
>
> Thanks. Another use case is when you receive a patch to be applied on
> a different branch while you are in the middle of some work. If it can
> be applied on the current branch, then you can post it to the
> destination, rewind, and continue with your work.
>
>>> +BUGS
>>> +----
>>> +
>>> +The change can be applied on `dest-branch` only if there is
>>> +no textual conflict.
>>
>> This is not a bug per se, it could be signaled via a return code that
>> the posting was unsuccessful.
>
> Oh, it does so return an error. But there are some cases that one
> expects that work, but where git-apply is not capable enough.
>
> -- Hannes
