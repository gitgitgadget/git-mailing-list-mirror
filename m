Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F2620281
	for <e@80x24.org>; Fri, 15 Sep 2017 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdIOM5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 08:57:00 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:48730 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdIOM47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 08:56:59 -0400
Received: by mail-io0-f178.google.com with SMTP id n69so8155548ioi.5
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xXKEpaLMdN+/2WKOcTSih44UO1X6eoW+JZ1NH/tjpKw=;
        b=IDkIfxOQCJ6HpI1qwNZ3/EkZvZHZnptQkNFNkj2qxEOLGW4QsrK75IPhwXuctJZzDj
         5msAMCwDSFBugnlaHWyLPFd6S4RXBpRHqXmYulM5ytiXSrBDWoPjs7g9OqzyrnHfrRUi
         O1UDXJlU6+n2Dxk9q3sZOBQsV/FFwRHhICJhga/OQVKSpSZKPB5dYoVxegVyfbU8YUbA
         wQ8ohtBKR3bektyxOJoHLotiAZfxzHSq6BxXVCrgNVrfykd8j9Mdaew8UUDQc9ihxNUB
         rlxiITKVjBRbbL/k/hU3iBeFHoOukZxQKDd/HXBOiL9VhQvTfsFfVI9FQ+JF/Yg778on
         fyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xXKEpaLMdN+/2WKOcTSih44UO1X6eoW+JZ1NH/tjpKw=;
        b=N2SJyUe8rHeYqwxhwcSz1i2JAJ6XoDWFGeP6b3a7gESAPHNHUm0HZi8GVLi1Ec8YMe
         AhsNyBaSIgDNZ458KxH2+kpqO42zN3jnQMRBg2qzBx2beGwxUDmcMpCE90mOKHdosdj2
         dx5ctnK0eUba76j8WkrLOdGFR1UNUfa8Cavzv11sfJcZV+mGlHpbOhqQWwHchy6XwstA
         8hERyZqWFSbkch419GdQ1YqK4avK6FmnEJAkt2V+YPX75s7hhW5SDwcgZXLgN0RkpYb7
         wF55P2IdebMbLDTf7D+szmxCKWda5N4As0lzCPDUKv/XfQaYzCT4EDmzEFQOkOvAiHKr
         +leQ==
X-Gm-Message-State: AHPjjUg/cGumeD0+8m1sxsxWVpWKVUFQ7etNAvOUP5jbBb3qb7yRjYMR
        CUxDAWN9mWhRJ0YT8qncdgm6Zb06n0hFQmUmkVs=
X-Google-Smtp-Source: AOwi7QAB0uUbtXF4roZaBDAUwnJJYPz5Bg9Qq/bdNJ5QxY5aNmyM1Y0cyOt/y6OJK7FgMj1JvQ8ON0wSYcGsvMpt0/A=
X-Received: by 10.107.137.96 with SMTP id l93mr7332511iod.138.1505480218746;
 Fri, 15 Sep 2017 05:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Fri, 15 Sep 2017 05:56:57 -0700 (PDT)
In-Reply-To: <b218004c-200c-b45a-0d0a-e273707d5aa0@gmail.com>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <4be750af-b093-6644-7f0e-82983327766a@gmail.com> <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
 <b218004c-200c-b45a-0d0a-e273707d5aa0@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2017 14:56:57 +0200
Message-ID: <CAP8UFD2ORL=5_wB7iQdLy9F47yvusieiRPbzCt1DwnhKtyT4PA@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(It looks like I did not reply to this email yet, sorry about this late reply.)

On Thu, Jul 6, 2017 at 7:36 PM, Ben Peart <peartben@gmail.com> wrote:
>
> On 7/1/2017 3:41 PM, Christian Couder wrote:
>>
>> On Fri, Jun 23, 2017 at 8:24 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>> Great to see this making progress!
>>>
>>> My thoughts and questions are mostly about the overall design tradeoffs.
>>>
>>> Is your intention to enable the ODB to completely replace the regular
>>> object
>>> store or just to supplement it?
>>
>> It is to supplement it, as I think the regular object store works very
>> well most of the time.
>
> I certainly understand the desire to restrict the scope of the patch series.
> I know full replacement is a much larger problem as it would touch much more
> of the codebase.
>
> I'd still like to see an object store that was thread safe, more robust (ie
> transactional) and hopefully faster so I am hoping we can design the ODB
> interface to eventually enable that.

I doubt that the way Git and the external odb helpers communicate in
process mode is good enough for multi-threading, so I think this would
require another communication mechanism altogether.

> For example: it seems the ODB helpers need to be able to be called before
> the regular object store in the "put" case (so they can intercept large
> objects for example) and after in in the "get" case to enable "fault-in."
> Something like this:
>
> have/get
> ========
> git object store
> large object ODB helper
>
> put
> ===
> large object ODB helper
> git object store
>
> It would be nice if that order wasn't hard coded but that the order or level
> of the "git object store" could be specified using the same mechanism as
> used for the ODB helpers so that some day you could do something like this:
>
> have/get
> ========
> "LMDB" ODB helper
> git object store
>
> put
> ===
> "LMDB" ODB helper
> git object store
>
> (and even further out, drop the current git object store completely :)).

Yeah, I understand that it could help.

>>> I think it would be good to ensure the
>>> interface is robust and performant enough to actually replace the current
>>> object store interface (even if we don't actually do that just yet).
>>
>>
>> I agree that it should be robust and performant, but I don't think it
>> needs to be as performant in all cases as the current object store
>> right now.
>>
>>> Another way of asking this is: do the 3 verbs (have, get, put) and the 3
>>> types of "get" enable you to wrap the current loose object and pack file
>>> code as ODBs and run completely via the external ODB interface?  If not,
>>> what is missing and can it be added?
>
> One example of what I think is missing is a way to stream objects (ie
> get_stream, put_stream).  This isn't used often in git but it did exist last
> I checked.  I'm not saying this needs to be supported in the first version -
> more if we want to support total replacement.

I agree and it seems to me that others have already pointed that the
streaming API could be used.

> I also wonder if we'd need an "optimize" verb (for "git gc") or a "validate"
> verb (for "git fsck").  Again, only if/when we are looking at total
> replacement.

Yeah, I agree that something might be useful for these commands.

>> Right now the "put" verb only send plain blobs, so the most logical
>> way to run completely via the external ODB interface would be to use
>> it to send and receive plain blobs. There are tests scripts (t0420,
>> t0470 and t0480) that use an http server as the external ODB and all
>> the blobs are stored in it.
>>
>> And yeah for now it works only for blobs. There is a temporary patch
>> in the series that limits it to blobs. For the non RFC patch series, I
>> think it should either use the attribute system to tell which objects
>> should be run via the external ODB interface, or perhaps there should
>> be a way to ask each external ODB helper which kind of objects and
>> blobs it can handle. I should add that in the future work part.
>
> Sounds good.  For GVFS we handle all object types (including commits and
> trees) so would need this to be enabled so that we can switch to using it.

Ok.

>>> _Eventually_ it would be great to see the current object store(s) moved
>>> behind the new ODB interface.
>>
>> This is not one of my goals and I think it could be a problem if we
>> want to keep the "fault in" mode.
>
>> In this mode the helper writes or reads directly to or from the
>> current object store, so it needs the current object store to be
>> available.
>
> I think implementing "fault in" should be an option that the ODB handler can
> implement but should not be required by the design/interface.  As you state
> above, this could be as simple as having the ODB handler write the object to
> the git object store on "get."

This is 'get_direct' since v5 and yeah it is optional.

>> Also I think compatibility with other git implementations is important
>> and it is a good thing that they can all work on a common repository
>> format.
>
> I agree this should be an option but I don't want to say we'll _never_ move
> to a better object store.

I agree but that looks like a different problem with a lot of additional issues.

>>> When there are multiple ODB providers, what is the order they are called?
>>
>> The external_odb_config() function creates the helpers for the
>> external ODBs in the order they are found in the config file, and then
>> these helpers are called in turn in the same order.
>>
>>> If one fails a request (get, have, put) are the others called to see if
>>> they
>>> can fulfill the request?
>>
>> Yes, but there are no tests to check that it works well. I will need
>> to add some.
>>
>>> Can the order they are called for various verb be configured explicitly?
>>
>> Right now, you can configure the order by changing the config file,
>> but the order will be the same for all the verbs.
>
> Do you mean it will work like this?
>
> have/get
> ========
> git object store
> first ODB helper
> second ODB helper
> third ODB helper
>
> put
> ===
> first ODB helper
> second ODB helper
> third ODB helper
> git object store

Yes.

> If so, I'd prefer having more flexibility and be able to specify where the
> "git object store" fits in the stack along with the ODB helpers so that you
> could eventually support the "LMDB" ODB helper example above.

Maybe this could be supported later with odb.<odbname>.priority or
odb.<odbname>.<instruction>_priority config option that could be
possibly negative integer.
A negative integer would means before the git object store and a
positive one after the object store.

>>> For
>>> example, it would be nice to have a "large object ODB handler" configured
>>> to
>>> get first try at all "put" verbs.  Then if it meets it's size
>>> requirements,
>>> it will handle the verb, otherwise it fail and git will try the other
>>> ODBs.
>>
>> This can work if the "large object ODB handler" is configured first.
>>
>> Also this is linked with how you define which objects are handled by
>> which helper. For example if the attribute system is used to describe
>> which external ODB is used for which files, there could be a way to
>> tell for example that blobs larger than 1MB are handled by the "large
>> object ODB handler" while those that are smaller are handled by
>> another helper.
>
> I can see that using at attribute system could get complex to implement
> generically in git.  It seems defining the set of attributes and the rules
> for matching against them could get complex.
>
> I wonder if it is sufficient to just have a hierarchy and then let each ODB
> handler determine which objects it wants to handle based on whatever
> criteria (size, object type, etc) it wants.

Yeah, I think that could be interesting to have later.

> The downside of doing it this way is that calling the various handlers needs
> to be fast as there may be a lot of calls passed through to the next
> handler.  I think this can be accomplished by using persistent background
> processes instead of spawning a new one on each call.

Yeah, this kind of mechanism would not be so simple to design if we
want things to be fast. That's why I prefer to leave it for later.

>> Yeah, capabilities are the same, but I think the script mode has
>> value, because helper are simpler to  write and debug.
>> If for example one wants to use the external ODB system to implement
>> clone bundles, like what is done in t0430 at the end of the patch
>> series, then it's much simpler if the helper uses the script mode, and
>> there is no performance downside as the helper will be called once.
>>
>> I think people might want to implement these kinds of helpers to just
>> setup a repo quickly and properly for their specific needs.
>> For example for companies using big monorepos, there could be
>> different helpers for different kind of people working on different
>> parts of the code. For example one for front end developers and one
>> for back end developers.
>
> I think the ease of writing a script mode helper vs sub-process can be
> alleviated with a library of helper routines to help with the sub-process
> interface.  You have a start on that already and given it is also already
> used by the filter interface there should be a good body of code to
> copy/paste for future implementations.  I've written them in perl and in
> C/C++ and once you have some helper functions, it's really quite simple.

It's quite simple once you know how to use the libraries, and then the
debugging is also more complex.
In the following email I gave an example of how simple some things can
be with the script mode:

https://public-inbox.org/git/CAP8UFD3ZV4Ezucn+Tv-roY6vzDyk2j4ypRsNR1YbOqoQK_qr8A@mail.gmail.com/

>> Also my goal is to share as much of the implementation as possible
>> between the script and the sub process mode. I think this can help us
>> be confident that the overall design is good.
>
> Ahh, but a single implementation is easier to code, test and maintain than
> two implementations - even with shared code. :)

Sure.

>>>> There are 3 different kinds of "get" instructions depending on how the
>>>> helper passes objects to Git:
>>>>
>>>>     - "fault_in": the helper will write the requested objects directly
>>>>       into the regular Git object database, and then Git will retry
>>>>       reading it from there.
>>>>
>>>
>>> I think the "fault_in" behavior can be implemented efficiently without
>>> the
>>> overhead of a 3rd special "get" instruction if we enable some of the
>>> other
>>> capabilities discussed.
>>
>> The "fault_in" behavior will be just a special kind of "get"
>> capability. Git needs to know that the helper has this capability, but
>> there should be no overhead. So I am not sure if I understand you
>> properly.
>
> Hopefully my sample diagrams above better illustrated what I was thinking
> and why I don't think git needs to be aware of "fault_in" behaviors.

I am not sure I understand as if a helper has some 'get_*' capability
Git needs to know anyway about that.

>>> I don't believe there is.  Instead, I think we should allow the various
>>> "partial clone" patch series already in progress solve the problem of how
>>> you do a partial clone of a repo.
>>
>> I think this is not really related to partial clone, but maybe I
>> should take a closer look at these patch series.
>
> My thought was that since a standard clone copies all objects into the local
> object store, there is no need for a way to retrieve "missing" objects as,
> by definition, none are missing.
>
> The various partial clone patch series are discussing how to clone a repo
> and _not_ copy down all objects which creates the need for a way to retrieve
> "missing" objects.  They are also dealing with how to enable git to know the
> object is intentionally missing (ie "have" can succeed but "get" will have
> to go retrieve the missing object before it can return it).
>
> This enables having missing objects without some local placeholder (ref) so
> that repos with large numbers of objects can still do a fast clone as they
> don't have to download millions of refs for the "missing" objects.

There could be just one ref pointing to a blob that contains a custom
service URL and the helper can just use the custom service URL to get
all the info it wants.
The one ref per missing object is obviously when you have a very small
number of missing objects.
