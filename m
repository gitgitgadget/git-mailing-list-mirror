Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D0D1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 14:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbdAaOHB (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 09:07:01 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33938 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbdAaOGk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 09:06:40 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so34032393lfi.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9mxbJVG1B7C6ZHAFXFLVPqRWoN898trcdD1G3Myofi0=;
        b=TUmVFM3VS0WHq94IJZxPhw6fFT6rvFz2HTLj9hvniNzAOEtlv5eJQE4RWXPWuh0mXO
         n+goMdBL9qpQ91aerAcQOYBpFrGSnDwcVZKxhPJ0iR/5jzwGgjOdWR8zbTt6Sg/C8aoX
         PzgHB4aJF0cgO8uDHT5PqnqXOHPJOhdmIsYVsl3viFiR7y8AOYwci3w/VQK3oan5fhL4
         aBjYFKK7tRDTUGIl4VpqgeSFShj8NVJOBMGmUHvAXY5zWLNYFlQdu//lhLVZsGdchI4s
         oVV3AQKGs6aAknvClSAVNY7ikChy39nO7yujrtsgZ6BM985ijMB1nawaHN7OMLvVyCST
         FkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9mxbJVG1B7C6ZHAFXFLVPqRWoN898trcdD1G3Myofi0=;
        b=WqYDeTSQN0RSlavknHmgApyDcoR7LLaH5LGvA/cdadXUsswpVwE8/b2L8gVf1DPChU
         VEP7QPRMGE6YaaoMlsXPSKgXmesnxqX9OsEqS5vF8tApA+zYmorl/kmGHggoiR7bxJiS
         FBzMf/FIvasFymGodT1QrzaT7mamgiuqxNxvNz82yGevBm1OpNq88GKZSn0rZe/gtsY7
         QOF8juxKSg7bDEf74D49w8Hhp6+e4eIAJzrtz1EKhaql8s5ED+NiPTET2Z01InbqLxZO
         0edSUsxwAAfr0Zxn2mVo7kIQIZtL8RU7DPjKQ3Yz1ydMob9uBNwrJzwArZZ8+B+rybfJ
         OiCQ==
X-Gm-Message-State: AIkVDXKHmSoSeJQttjgvMq9hEpI4xxMGjpBr0gL36npUAcK8v0vAouyqNongnNMOtN5nnyAUt0QVeaYbUvTsOg==
X-Received: by 10.25.203.3 with SMTP id b3mr9453537lfg.130.1485871583511; Tue,
 31 Jan 2017 06:06:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Tue, 31 Jan 2017 06:06:22 -0800 (PST)
In-Reply-To: <xmqqsho6amm7.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
 <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com> <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
 <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com> <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
 <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com> <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
 <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com> <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
 <xmqqsho6amm7.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 31 Jan 2017 15:06:22 +0100
Message-ID: <CAP8UFD3iWg5g-h209VDyg1U03Jmma8nTONyCYB-kN7GwspkL8Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Well, when we cannot freshen a loose file (with
>> freshen_loose_object()), we don't warn or die, we just write the loose
>> file. But here we cannot write the shared index file.
>
> I think that is an excellent point.  Let me make sure I got you
> right.  For loose object files, we may attempt to freshen and when
> it fails we stay silent and do not talk about the failure.  Instead,
> we write the same file again.  That will have two potential outcomes:
>
>  1. write fails and we fail the whole thing.  It is very clear to
>     the user that there is something wrong going on.
>
>  2. write succeeds, and because we just wrote it, we know that the
>     file is fresh and is protected from gc.
>
> So the "freshen and if fails just write" is sufficient.  It is
> absolutely the right thing to do for loose object files.
>
> When we are forking off a new split index file based on an old
> shared index file, we may attempt to "touch" the old shared one, but
> we cannot write the old shared one again, because other split index
> may be based on that, and we do not have enough information to
> recreate the old one [*1*].  The fallback safety is not available.

Yeah I agree. But note that I was talking about the case where the
shared index file does not exist anymore.
I was just saying that when the shared index file has been removed
behind us, it is equivalent as when
loose files have been removed behind us, except that we cannot write
the removed file to disk.

>> And this doesn't lead to a catastrophic failure right away.
>
> Exactly.
>
>> There
>> could be a catastrophic failure if the shared index file is needed
>> again later, but we are not sure that it's going to be needed later.
>> In fact it may have just been removed because it won't be needed
>> later.
>
> You are listing only the irrelevant cases.  The shared one may be
> used immediately, and the user can keep using it for a while without
> "touching".

Now you are talking about a case where the shared index file can be
used immediately and the user can keep using it.
This is a different case than the case I was talking about (which is
the case when the shared index file does not exist anymore).

> Perhaps the shared one was chowned to "root" while the
> user is looking the other way, and its timestamp is now frozen to
> the time of chown.  It is a ticking time-bomb that will go off when
> your expiry logic kicks in.

In the case I was talking about, the shared index file doesn't exist
anymore. So there is no time ticking bomb, because what could happen,
if we cannot freshen the shared index file, is that the shared index
file could be removed, which wouldn't make things worse as anyway it
does not exist anymore.

So the case when the shared index file doesn't exist is different than
other cases.

Now if you want to talk about the case when the shared index file has
not been removed, but just chowned to "root", then I wonder how is it
different from the case when the file system is read only.
Perhaps the admin just chowned everything to make sure that the repo
could not be changed anymore by the usual processes and users.

>> So I am not sure it's a good idea to anticipate a catastrophic failure
>> that may not happen. Perhaps we could just warn, but I am not sure it
>> will help the user. If the catastrophic failure doesn't happen because
>> the shared index file is not needed, I can't see how the warning could
>> help. And if there is a catastrophic failure, the following will be
>> displayed:
>>
>> fatal: .git/sharedindex.cbfe41352a4623d4d3e9757861fed53f3094e0ac:
>> index file open failed: No such file or directory
>
> That "fatal" is given _ONLY_ after time passes and our failure to
> "touch" the file that is still-in-use left it subject to "gc".  Of
> course, when "fatal" is given, it is too late to warn about ticking
> time bomb.
>
> At the time we notice a ticking time bomb is the only sensible time
> to warn.  Or better yet take a corrective action.

In a previous email you wrote that if the file system is read only, it
is a bad thing if we warn.
So I wonder why it would be a good thing to warn or try to do
something if the admin chowned everything to prevent usual processes
and users to change anything.

> As I expect (and you seem to agree) that a failure to "touch" would
> be a very rare event (like, sysadmin chowning it to "root" by
> mistake),

Yeah, I agree that a failure to "touch" would be a rare event. But the
thing is we often don't know if admins or users do things by mistake
or not.
If they rm -rf everything forcefully, for example, they might not like
it, if we start to rewrite stuff to try to "correct" things.

> I do not mind if the "corrective action" were "immediately
> unsplit the index, so that at least the current and the latest index
> contents will be written out safely to a new single unsplit index
> file".

If the admins or users chowned a shared index file precisely because
they want to save it from ever being garbage collected, I am not sure
that they would be happy if we decide to "correct" things.
For example they might not like it if we change the current mode to
unsplit index.

So in my opinion, the safest thing, if we really want to do something,
is to just warn, perhaps once, and I am ok to do that.
If we really wanted to do our best, perhaps we could warn once only in
the case when the shared index file still exists (because otherwise
there nothing to lose anymore).

> That won't help _other_ split index files that are based on
> the same "untouchable" shared index, but I do not think that is a
> problem we need to solve---if they are still in use, the code that
> use them will notice it, and otherwise they are not in use and can
> be aged away safely.

I am not sure that I understand you correctly on this. The current
code does not age away the split index files. It only ages away shared
index files.
I think aging away the split index file is a different issue, because
when we are not in split index mode, the index files are not aged
anyway.
