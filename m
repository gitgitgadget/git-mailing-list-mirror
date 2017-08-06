Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54ED208B4
	for <e@80x24.org>; Sun,  6 Aug 2017 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdHFU0o (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 16:26:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36501 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHFU0n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 16:26:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id t201so54396036wmt.1
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1+MsLsrV6uolcCmSTpRKOwTv8Vu8bAtoOTo7kHcswG0=;
        b=GTnYVZQ/vj6aWAGVtUGG7IsP9drWRF4aIIKrofSll4UcFoUVBEWn2uGuqr5ffVW5yY
         QK69LxqLM/ehtXvG+hMQs5cIO13Kp1VQcGdkD6r8M37hXTrJ/Q686UyrF56D+1pN/rUZ
         F82F1mu3i0sBrWZP8Nng8P5SQgrwfhc5ja+42vpGdPrrle05kV4i20m4Vej7vCbAoebZ
         j8jfGW4yZH7CEP3CYgOmZGrbdsd83LYZ4VTpu/Yy/OkUWuy0EvG6YGJLLXwAnc9GdnEY
         igoIsgbipXlRAAHyA4bnI6Q68WrH+gJ3xGuv4VoVBDMB8chllHPQR+ah/tgbm7EM1n70
         uwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1+MsLsrV6uolcCmSTpRKOwTv8Vu8bAtoOTo7kHcswG0=;
        b=pDvDQiIXDSHN01dVJvsXAzic20PdEqMksddwUhccOUwNtBB6qGCiiSYSUKezQmBY12
         SPxjFVrw4oI7fRmE9TNzZJWoYnTZjVVbXty9jjIHcMOEpzDfeDS0cTAD+8qJPiboAwEA
         tGL6PRIt4YXgW2kVHiE2+yL4OWTvwYQ6ifqXq9oUQQcb2I592ksVq1NC7d1KAR82r2M9
         vkzHlT9hA3QvrcGSen/7Z+XRR7z1TQyIbc1NDG8zlHN7pRlocys4MNIJBtandJq268A0
         oV1epTuhGnqMl4cUgbsJUqHPkizeBdsL1eFWLsSrz3nYBWyPWFx5IFoQUfnXlXdfwmUt
         MnXA==
X-Gm-Message-State: AIVw113ZAYRmIAjM+KSjbY/KN8j6HsJu60r0hlKXzkuGP0qSzNUkZfn8
        uNdoszfqs58F+g==
X-Received: by 10.80.141.70 with SMTP id t6mr9134055edt.75.1502051201940;
        Sun, 06 Aug 2017 13:26:41 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id 61sm4863311edh.54.2017.08.06.13.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Aug 2017 13:26:41 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1deS8F-0000Rg-Ek; Sun, 06 Aug 2017 22:26:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com> <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com> <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com> <xmqqd18cweak.fsf@gitster.mtv.corp.google.com> <87shh57nzs.fsf@gmail.com> <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 06 Aug 2017 22:26:39 +0200
Message-ID: <873794zbls.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 05 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> We've talked how this UX should look before on-list. Rather than
>> re-hashing the arguments I had before I thought it was useful to present
>> it as a table. Here's how the patch looks now:
>>
>>     |----------------------------+--------------+-------+---------+-----------------+-------------|
>>     | cmd                        | creates new? | moves | copies? | ...with config? | checks out? |
>>     |----------------------------+--------------+-------+---------+-----------------+-------------|
>>     | branch <name>              | Y            | N     | N       | N               | N           |
>>     | checkout <name>            | Y            | N     | N       | N               | Y           |
>>     | checkout -b <name> <start> | Y            | N     | Y       | N               | Y           |
>>     | branch -m <name>           | Y            | Y     | N       | Y               | Y           |
>>     | NEW: branch -c <name>      | Y            | N     | Y       | Y               | Y           |
>>     |----------------------------+--------------+-------+---------+-----------------+-------------|
>
> I actually consider "branch" to *never* invoking a checkout.  Even
> when "git branch -m A B" happens to be done when your checked out
> branch is A and you end up being on B.  That is not a "checkout".

I think we just have a different mental model of what "checkout"
means. In my mind any operation that updates the HEAD to point to a new
branch is a checkout of that branch.

In the interest of explaining what I mean with the above and not proving
you wrong or whatever, consider a basic implementation of git before
pack-refs or whatever.

You could then copy a branch name like:

    $ cp .git/refs/heads/{master,master-copy}

Get your currently checked out branch with:

    $ cat .git/HEAD
    ref: refs/heads/master

And you could then implement "git checkout" like:

    $ echo "ref: refs/heads/master-copy" >.git/HEAD

This still works today. Now if I make a commit it goes on the
.git/refs/heads/master-copy branch.

Now let's say I wanted to rename the 'master' branch. This would rename
it:

    $ mv .git/refs/heads/{master,trunk}

But it wouldn't check it out, my HEAD would still point to master:

    $ git log
    fatal: your current branch 'master' does not have any commits yet
    $ git log --oneline -1 trunk
    8b18718 (trunk) moo

To check it out I need:

    $ echo "ref: refs/heads/trunk" >.git/HEAD

Which yields:

    $ git log --oneline -1 HEAD
    8b18718 (HEAD -> trunk) moo

The mv sans the "echo" is what we'd get if we did:

    diff --git a/builtin/branch.c b/builtin/branch.c
    index 8a0595e115..62ed1a8e20 100644
    --- a/builtin/branch.c
    +++ b/builtin/branch.c
    @@ -493,9 +493,6 @@ static void rename_branch(const char *oldname, const char *newname, int force)
            if (recovery)
                    warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);

    -       if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
    -               die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
    -
            strbuf_release(&logmsg);

            strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);

I.e. the last step of "git branch -m" is checking out the branch by
updating the HEAD. Now let's compile git like that and rename "master"
to "trunk":

    $ git symbolic-ref HEAD
    refs/heads/master
    $ ./git-branch -m trunk
    $ git symbolic-ref HEAD
    refs/heads/master
    $ git show
    fatal: your current branch 'master' does not have any commits yet

Now let's do the equivalent of that removed
replace_each_worktree_head_symref():

    $ git checkout trunk
    Switched to branch 'trunk'

And voila:

    $ git symbolic-ref HEAD
    refs/heads/trunk

This is why I'm saying that "git branch -m" involves a checkout. Because
it is literally exactly the case that it could be replaced by a
shellscript whose last step is a "git checkout" of the new branch.

Anyway, none of that changes what we /should/ be doing on the fact that
"git branch -m" not updating the HEAD would be rather useless. I just
wanted to explain what I was talking about and why I was talking about
"checkout" in that context.

> Really from the end-user's point of view that is not a checkout.
> The user renamed the branch A and the same conceptual entity, which
> is a branch, is now called B.  If that branch was what was checked
> out (IOW, if that branch was what would be grown by one commit if
> the user did "git commit"), then now that branch's name is B.  It is
> natural if you ask "symbolic-ref HEAD" what branch is checked out
> after renaming A to B (and A happened to be what was checked out),
> the answer chould be B.
>
> It's like the city you live in changed the name of the street your
> house is on.  You do not call movers, you do not do anything, but
> your address changes.

Yeah I see what you mean, although this analogy rapidly breaks down when
you poke at it as shown above. My house (a sha1) can be on any number of
streets and new ones can be added/removed all the time without changing
where my house is at.

>> I.e. have "branch -c <name>" but just make it not checkout the new
>> thing. What you're describing above sounds to me like:
>>
>>     |-------------------------------------------+--------------+-------+---------+-----------------+-------------|
>>     | cmd                                       | creates new? | moves | copies? | ...with config? | checks out? |
>>     [... stuff above this point is the same ...]
>>     | branch -m <name>                          | Y            | Y     | N       | Y               | Y           |
>>     [... so is branch -m but included for context ...]
>>     | NEW: checkout --super-b -b <name> <start> | Y            | N     | Y       | Y               | Y           |
>>     |-------------------------------------------+--------------+-------+---------+-----------------+-------------|
>
> You are talking backwards.  I do not want "branch -c A B", even when
> A happens to be what is checked out, to check out branch B.  You and
> Sahil were who wanted to check out branch B while doing so, and I
> just tried to guess why you two wanted to have such a behaviour that
> did not make much sense to me.  And my guess was "perhaps they want
> a way to create a new branch starting from another branch, and check
> it out, and do so in a single end-user operation".

The use-case is the following. When I hack on e.g. git.git I'm on
"master" with configured upstream info:

    $ git log @{u}..

Because if I don't care about 'master' another shorter way to say:

    $ git checkout -b topic -t origin/master

Is:

    $ git branch -m topic

That's how I start hacking on "topic", now let's say I've submitted that
and want to start on topic-2 after getting feedback:

    # While still on topic
    $ git branch -c topic-2

So it's just a way to get something exactly like -m except the "move &&
checkout" logic is changed to "copy && checkout".

> I am not particulary interested in such an operation; in my guess,
> you two are.  And the "super-b" thing was a suggestion to you two:
> If you so desperately want such an operation, then don't make
> "branch --copy A B" that operation.  Such an operation better fits
> in "checkout", not "branch".

That's arguably another sensible way to do a /subset/ of what 'git
branch -c' does (or something in addition to this patch). But there's
another use-case it won't cover, i.e. the two-arg branch -m/-c
manipulating a branch that HEAD doesn't point to:

    $ git checkout master
    $ git branch -m topic avar/topic

You can now do that with -c to s/move/copy/, but couldn't do this with
checkout unless you wastefully and needlessly updated the working tree.

> If you are not interested in such an operation, then that is fine.
> Do not add the "super-b" mode to "checkout".

Yeah it's not something I'm interested in or have a use-case for,
although I think in the same way we have -t for checkout it might be
sensible to have e.g.:

    $ git checkout -b topic-2 -c topic -t origin/master

Where the new -c or --config-from would mean "...and get the config from
'topic'". Such a name would probably be less confusing than
--super-b[branch?] which to be implies some ongoing hierarchical
relationship.

> But I won't defend a "branch --copy A B" that checks out B when
> users and other people like Ramsay think that such a behaviour is
> illogical, because I do think it is, too.

I just started this from the POV of using branch -m and wanting
something like that which didn't remove the old thing when it was done
as its last step, which seemed easy to implement & explain.

As noted above I think it probably makes sense to also have something
like [--config-from|-c] for checkout, which would have a related but not
exactly the same use-case.
