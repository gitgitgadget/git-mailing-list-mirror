Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485DF1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeCJNUB (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 08:20:01 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34439 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeCJNUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 08:20:00 -0500
Received: by mail-wm0-f51.google.com with SMTP id a20so6963489wmd.1
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 05:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=060a35OMaZ99hV+no4CcxtiVOnU0v3zAeOjxLWRylh4=;
        b=JejWWq25FdBHoeqOFoCCJgxHw4bs+LKL/AUH7Udb8wHFhZo0pOcl5+sR9Kwd2Y+PbT
         M44ZSQb4ekgShzoSoU6yv63ZR5h8qvmIbkfddujH8e5G/48yBymBgRpO6t5NpgYPSZMs
         BK2CNNmoYYXd+t8lffkQ2laM+s1AfSQI1UB2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=060a35OMaZ99hV+no4CcxtiVOnU0v3zAeOjxLWRylh4=;
        b=jj8Jh3eXSB9oESDuWGr6sMVran5otYc+SpWTLxY38dFs2opRpOL1pnlCa57YbtVSOz
         42TdIB/pbsPiENBi74vyFSvW1AAdAgXuh8Mj+hoR288C4tccVvGMHIv4pamchv+V6y0H
         SadZl86GEitkH7q7OAbxTXinyUXTXtG5kvaCl/IKEcPYlFE4HrQWiJaXaEVZh6/c5uTG
         cMnyMv8KhC+iIDCD9TNkJMy4RLyCqt4Lzt3fh7p6n5M2CfmoBPhsVPyjVJtvuS+WLVtr
         z4apS2YlsC/HUV3yEa4iUuFRkjrN1fITNI06TPWD3+wZW0SSb8WpRtx/djV6wk7yIpvc
         WOoQ==
X-Gm-Message-State: AElRT7FkaQ0PfyU+XhOE7IPlxBVl+KvQjFvowyFKwvB9zw8XpY+Q0ahH
        XnADj4YpaYv7239ZPok34fr4XJrldsw=
X-Google-Smtp-Source: AG47ELvVfhbyw6ZhFrLxuP7maEeZ2v841RDzdkPL+9oY5QUIVWPacuwTPLM7NOctQ3tsGaPzdFRn2Q==
X-Received: by 10.80.212.158 with SMTP id s30mr3004881edi.268.1520687998390;
        Sat, 10 Mar 2018 05:19:58 -0800 (PST)
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com. [74.125.82.51])
        by smtp.gmail.com with ESMTPSA id x44sm2369908ede.80.2018.03.10.05.19.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 05:19:57 -0800 (PST)
Received: by mail-wm0-f51.google.com with SMTP id w128so8617166wmw.0
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 05:19:56 -0800 (PST)
X-Received: by 10.28.71.204 with SMTP id m73mr1097846wmi.111.1520687995979;
 Sat, 10 Mar 2018 05:19:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.142.20 with HTTP; Sat, 10 Mar 2018 05:19:15 -0800 (PST)
In-Reply-To: <xmqq606558k2.fsf@gitster-ct.c.googlers.com>
References: <20180309131136.219303-2-tikuta@chromium.org> <20180309132655.224308-1-tikuta@chromium.org>
 <xmqq606558k2.fsf@gitster-ct.c.googlers.com>
From:   Takuto Ikuta <tikuta@chromium.org>
Date:   Sat, 10 Mar 2018 22:19:15 +0900
X-Gmail-Original-Message-ID: <CALNjmMqBbZTFVRnc__wewWy3808n9J9xfgu8ZH-FWyWJKvqb9w@mail.gmail.com>
Message-ID: <CALNjmMqBbZTFVRnc__wewWy3808n9J9xfgu8ZH-FWyWJKvqb9w@mail.gmail.com>
Subject: Re: [PATCH v3] fetch-pack.c: use oidset to check existence of loose object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-10 3:00 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Takuto Ikuta <tikuta@chromium.org> writes:
>
>> Yes, I just wanted to say 'git fetch' invokes fetch-pack.
>> fetch-pack is skipped when running git fetch repeatedly while
>> remote has no update by quickfetch. So I disabled it to see the
>> performance of fetch-pack. In chromium repository, master branch
>> is updated several times in an hour, so git fetch invokes fetch-pack
>> in such frequency.
>
> I do understand that if you run "git fetch" against the same place
> in quick succession three times, the first one may cost a lot (not
> just that it has to do the everything_local() computation that you
> care about, it also has to actually do the network transfer), while
> the second and third ones that are done before anything new happens
> on the other end will not involve everything_local() overhead thanks
> to quickfetch.
>
> A "fetch" that is run against a remote that has nothing new, but
> still triggers everything_local() only because quickfetch is
> disabled, is an artificial case that has no relevance to the real
> world, I suspect, because the quickfetch optimization is to solve
> the "there is nothing to be done, still do_fetch_pack() spends so
> much cycles only to realize that it does not have anything to do,
> why?" issue.
>

I changed not to say "disabling quickfetch" in v5 description.
Actually, I'd like to take several stats on linux because the perf difference
is small and it can be affected by network and quickfetch.

> Isn't running the "git fetch" command with the "--dry-run" option
> many times in quick succession a lot closer to what you really want
> to measure, I wonder?  That way, your first fetch won't be touching
> the state of the local side to affect your second and subsequent
> fetches.
>

Looks no? Even when I use --dry-run, second run did not invoke fetch-pack.

>>> In any case, do_fetch_pack() tries to see if all of the tip commits
>>> we are going to fetch exist locally, so when you are trying a fetch
>>> that grabs huge number of refs (by the way, it means that the first
>>> sentence of the proposed log message is not quite true---it is "When
>>> fetching a large number of refs", as it does not matter how many
>>> refs _we_ have, no?), everything_local() ends up making repeated
>>> calls to has_object_file_with_flags() to all of the refs.
>>
>> I fixed description by changing 'refs' to 'remote refs'. In my understanding,
>> git tries to check existence of remote refs even if we won't fetch such refs.
>
> During fetch, everything_local() tries to mark common part by
> walking the refs the other side advertised upon the first contact,
> so it is correct that the number of checks is not reduced in a fetch
> that does not fetch many refs, but the number of remote-tracking refs
> you have has no effect, so I doubt such a rephrasing would make the
> description more understandable.  "When fetching from a repository
> with large number of refs" is probably what you want to say, no?
>

For refs existing in local repository, everything_local looks to be able to find
corresponding object from packed or loose objects. And if it exists,
I think, cost of lstat(2) is relatively smaller than other operations.
But for remote refs, everything_local fails to find it from packed
object (this check is fast)
and it tries to find loose object by using lstat(2), and this fails and slow.
My patch is to skip this lstat(2) to non-existing ref objects for repositories
having large number of remote refs.

2018-03-10 4:41 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Yes. But I think the default limit for the number of loose objects, 7000,
>>> gives us small overhead when we do enumeration of all objects.
>>
>> Hmph, I didn't see the code that does the estimation of loose object
>> count before starting to enumerate, though.
>
> Another thing the code could do to avoid negative consequences on
> projects that look quite different from yours (e.g. the other side
> does not have insane number of refs, but there are locally quite a
> few loose objects) is to count how many entries are on *refs list
> before we decide to enumerate all loose objects.  When the refs list
> is relatively shorter than the estimated number of loose objects
> (you can actually do the estimation based on sampling, or just rely
> on your assumed 7k), it may be a win _not_ to trigger the new code
> you are adding to this codepath with this patch.  I would imagine
> that the simplest implementaion may just count
>
>         for (ref = *refs, count = 0; ref && count++ < LIMIT; ref = ref->next)
>                 ;
>         use_oidset_optim = (LIMIT <= count);
>
> assuming your "up to 7k loose objects" and then experimenting to
> determine the LIMIT which is a rough number of refs that makes the
> oidset optimization worthwhile.
>
> We need a bit better/descriptive name for the LIMIT, if we go that
> route, though.
>

Sorry, 7000 was wrong. I wanted to say the default number of gc.auto, 6700.
I changed to count refs in for_each_loose_object(), and use it to
determine whether
we use oidset or not.

2018-03-10 4:54 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Takuto Ikuta <tikuta@chromium.org> writes:
>
>> In repository having large number of remote refs, because to check
>
> Isn't this "When fetching from a repository with large number of
> refs,"?  The number of refs (whether it is local or remote-tracking)
> the local side has has nothing to do with the issue you are
> addressing, no?
>

Yes it has nothing to do with the issue. At least, my patch won't change
performance of git fetch for the repository having large number of local refs.

>> existence of each refs in local repository, 'git fetch' ends up doing a
>> lot of lstat(2) calls to see if it exists in loose form, which makes it
>> slow.
>
> Other than that, the above description reads much better and makes
> the result easier to understand.
>
>> This patch enumerates loose objects in hashmap beforehand and uses it to
>> check existence instead of using lstat(2) to improve performance of
>> fetch-pack for repositories having large number of remote refs compared
>> to the number of loose objects.
>
> We'd rather write this paragraph as if giving an order to the
> codebase "to be like so", e.g.
>
>         Instead of making as many lstat(2) calls as the refs the
>         remote side advertised to see if these objects exist in the
>         loose form, first enumerate all the existing loose objects
>         in hashmap beforehand and use it to check existence of
>         them...
>

Thanks, I changed description like it.

>> I took time stat of `git fetch` disabling quickfetch, so that fetch-pack
>
> I still do not know if a benchmark with quickfetch disabled gives
> relevant numbers, for reasons I gave earlier.  The relative numbers
> between Linux and MacBook look quite convincing, as they illustrate
> differences of lstat(2) performance on these platforms.
>
>>       for (ref = *refs; ref; ref = ref->next) {
>>               struct object *o;
>> +             unsigned int flags = OBJECT_INFO_QUICK;
>>
>> -             if (!has_object_file_with_flags(&ref->old_oid,
>> -                                             OBJECT_INFO_QUICK))
>> -                     continue;
>> +             if (!oidset_contains(&loose_oid_set, &ref->old_oid)) {
>> +                     /* I know this does not exist in the loose form,
>> +                      * so check if it exists in a non-loose form.
>> +                      */
>
>         /*
>          * Our multi-line comment looks like this,
>          * with opening slash-asterisk and closing
>          * asterisk-slash on their own lines.
>          */
>

I fixed.


Thanks, Takuto
