Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F651F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEOI13 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:27:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34383 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOI11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:27:27 -0400
Received: by mail-it0-f67.google.com with SMTP id c5-v6so11553947itj.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l7gogZOE+2/cg0tO7d7cfpV5mMCzP4/kNS8F9PIEhho=;
        b=Cn3VopVAlIeV6dyyHYDF664GmMBGRGx97+7ayIOI5uMggsICdtgWB3EI4ZslMmGHuJ
         LjB9+5AtYJiFz2tX9Z8XgEo8e4WPmWJniYSlC4aBO1cLgHpnhYYDpUbo6PqvAWY6T3Yz
         flAPYYWL3ZoCWi+oEgrwrBGiKQlKqbz/MOXv9FePvn65Ub2yOT0U+Xx9RXni2vmpmZP/
         HG+I590Othp14MdnQi4p6V4b80bJBsQKGhRd1lk0y8/ETZuF2RDrjkGRRQfLZ+rXNF49
         k3cc2YqvAerbLi4+m1WYQGnVRYkd7Yz2ivCKgQ4NjH1Hhm9/dAW5kSF9CLNdJxJA7v3G
         925g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l7gogZOE+2/cg0tO7d7cfpV5mMCzP4/kNS8F9PIEhho=;
        b=Gs0gsowWgav8W2D8adD1yQD3qDZ9Oo5sfjpGBWMjRC7t83kkvhlwB9Fp3vEUNNgq/f
         1+k3FG5MSArtLv2830PGZTCuImWeEB2AtSkbPn/XlxjE4D3L9fOw0sq6TGLPIaSO+C3k
         ATZIKfEsOnh9AIaS2oJ6cUwOC0FV9QCPLnXtt9wkKgR78PxMX1bMO/iCOSR3A43BoBzk
         21ci2glvwXNiBhwtxs+ehlDdDScDtEq8y6p7sDVotux9cXhp1WjsN0w8c0FcAK8J0vDJ
         U+b9UYg3rFH6B4YpXkzkHUK3IbZ2IKnMymoUKZYztqxS6c5uke17kFfsp3VpoRqjbX22
         Mjhg==
X-Gm-Message-State: ALKqPwfSHEXBLBr9fIXWBqIANZ+mcEEMEgufNBiD4EjP/MY8wHbkUwhw
        4Q3W7gFBWrKVvXirTsom50I97TqQu8voF6S2EXQ=
X-Google-Smtp-Source: AB8JxZp5LZ/MyXBU1bu7LdEVz2ONsEfdVsc9yAXhoVqtXd5cEHQ7FLlWvz4K0GG8r3kJRbqSXYl16I6Y3AQ2v4VbvDo=
X-Received: by 2002:a24:c887:: with SMTP id w129-v6mr12020655itf.122.1526372846365;
 Tue, 15 May 2018 01:27:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.139.88 with HTTP; Tue, 15 May 2018 01:27:25 -0700 (PDT)
In-Reply-To: <87lgcl3kv9.fsf@evledraar.gmail.com>
References: <CANgJU+VFCY0LNRLMSGtD7ScpcLaPFMzUOyw6Bjgk6q=Kx9DvCg@mail.gmail.com>
 <87lgcl3kv9.fsf@evledraar.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 15 May 2018 10:27:25 +0200
Message-ID: <CANgJU+W7JcA=W4dNn5uVj_=iiGCCfE6uD4cR=v5qPyCTRr3ARw@mail.gmail.com>
Subject: Re: could `git merge --no-ff origin/master` be made more useful?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 May 2018 at 00:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
>
> On Mon, May 14 2018, demerphq wrote:
>
>> The first time I tried to use --no-ff I tried to do something like this:
>>
>>   git checkout master
>>   git commit -a -m'whatever'
>>   git commit -a -m'whatever2'
>>   git merge --no-ff origin/master
>>
>> and was disappointed when "it didn't work" and git told me there was
>> nothing to do as the branch was up to date. (Which I found a bit
>> confusing.)
>>
>> I realize now my expectations were incorrect, and that the argument to
>> merge needs to resolve to a commit that is ahead of the current
>> commit, and in the above sequence it is the other way around. So to do
>> what I want I can do:
>>
>>   git checkout master
>>   git checkout -b topic
>>   git commit -a -m'whatever'
>>   git commit -a -m'whatever2'
>>   git checkout master
>>   git merge --no-ff topic
>>
>> and iiuir this works because 'master' would be behind 'topic' in this ca=
se.
>>
>> But I have a few questions, 1) is there is an argument to feed to git
>> merge to make the first recipe work like the second? And 2) is this
>> asymmetry necessary with --no-ff?
>
> I've been bitten my this myself, but found that it's documented as the
> very first thing in git-merge:
>
>     Incorporates changes from the named commits (since the time their
>     histories diverged from the current branch) into the current
>     branch[...].
>
> Since origin/master hasn't diverged from your current branch (unlike the
> other way around), the merge with --no-ff is a noop.

Yeah, I got it, but only after rereading a lot of times.

>
>> More specifically would something horrible break if --no-ff
>> origin/trunk detected that the current branch was ahead of the named
>> branch and "swapped"  the implicit order of the two so that the first
>> recipe could behave like the second
>
> If it worked like that then the user who sets merge.ff=3Dfalse in his
> config and issues a "git pull" after making a commit on his local master
> would create a merge commit.
>
> This old E-Mail of Junio's discusses that edge case & others in detail:
> https://public-inbox.org/git/7vty1zfwmd.fsf@alter.siamese.dyndns.org/

Thanks I skimmed, but it is long so I will review later.

I see the point about the config option for no-ff.

But what about an option like --reverse? Assuming we are on a local
branch master then

  git merge --no-ff --reverse origin/master

would treat origin/master as the "current" branch, and "master" as the
merged in branch, and create the appropriate merge commit. Which as
far as I can tell is tree-wise identical to creating a topic branch
instead of hacking on the local master.

>> Anyway, even if the above makes no sense, would it be hard to make the
>> message provided by git merge in the first recipe a bit more
>> suggestive of what is going on? For instance if it had said "Cannot
>> --no-ff merge, origin/master is behind master" it would have been much
>> more clear what was going on.
>
> I can't spot any reason for why we couldn't have something like this POC
> (would be properly done through advice.c):
>
>     diff --git a/builtin/merge.c b/builtin/merge.c
>     index 9db5a2cf16..920f67d9f8 100644
>     --- a/builtin/merge.c
>     +++ b/builtin/merge.c
>     @@ -1407,6 +1407,8 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>                      * but first the most common case of merging one remo=
te.
>                      */
>                     finish_up_to_date(_("Already up to date."));
>     +               if (fast_forward =3D=3D FF_NO)
>     +                       fprintf(stderr, "did you mean this the other =
way around?\n");
>                     goto done;
>             } else if (fast_forward !=3D FF_NO && !remoteheads->next &&
>                             !common->next &&
>
> But that should probably be reworked to be smart about whether --no-ff
> or merge.ff=3Dfalse was specified, i.e. do we want to yell this at the
> user who's just set that at his config default, or the user who's
> specified --no-ff explicitly, or both? I don't know.

Yes, all those points make sense.

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
