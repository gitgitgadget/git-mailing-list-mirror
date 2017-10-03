Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904AE2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdJCJpF (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 05:45:05 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:51657 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdJCJpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 05:45:04 -0400
Received: by mail-io0-f172.google.com with SMTP id l15so7093267iol.8
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QtptvbV8mliXodtK2dro3CGvx71MnNgtZJjMA7pJgns=;
        b=m1DHdTRqjQr3KekGnzoy2mrviawIsZNJTXEQ6xTPWe0z5ic+di4Cd87OTIbqq+H2Ye
         e4YA/OuxMcL+cGMeLmsyqrRdkVyQOzttr7L2dmoFzFtjCwRxJpWQPRXX84s4rPDyhZ9a
         v0TRoZOM36VodddYkMzCs+5dfVxzCvJEVzMnVBt/erG0i0NRofHUFmvkiOBsgOlOCBM/
         SxqGV9Xs+h/uNPZqTnv8cGMBS4GXZpiGT4+lAfX3EdfVtCgpoKNbv7y0jmQei9hxHQBg
         Szj5ifTVEwUcEN1DzC+QreolXbWwaj1AeR47N3eHemOdrzWL8hPzqMhWPOtxZx16k408
         fS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QtptvbV8mliXodtK2dro3CGvx71MnNgtZJjMA7pJgns=;
        b=jzI7DgZodqUU3iVzIzOmlZs5UWltECpgCxc9TSU/09tb5pZsMvUjKD49rbqX/P36Ys
         1/J/9Q3ubxLPqrZxNzY0Lx7jI0o50vJTob/T5MtUiXHPuB9v7J/99sUJQU+0IH49q1WL
         YBjHUZRPRLU8BL/ufG4660Jt2sPWnoXPu0Kfsok9Mrhbi+7km4i7R1Akgm9O0je6tpM7
         CGPaEX2kcVcjR9HOIHRWaQUylaS9ATB3kXeNwhnMRsPxs5+O1oPuJQ0I3/18jp1bzzvE
         /+PW6bxSh6MlaPeUgr5Wx0v98QBwmSVSlNj8YeOAZr31LlKjCesM0rjvCY9sgOVk+wJN
         eBGA==
X-Gm-Message-State: AMCzsaUhimIpzexY/LBmwww7A0LC4RJ8FTJHSIR8zwFJLzZWDK+PUb4I
        FT52Px38zlng7XZJQ+nuZ6XOnNUIaQfGiiyo8Bk=
X-Google-Smtp-Source: AOwi7QDFgPfqf45gz/ZKSFhCbE2WVrPOOYGcy755WMvpyvuR1oU2aco0vvB8la5srlNb6lf+voJ65WgyJazgHmUaPQI=
X-Received: by 10.107.30.77 with SMTP id e74mr26618095ioe.277.1507023903195;
 Tue, 03 Oct 2017 02:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.142.216 with HTTP; Tue, 3 Oct 2017 02:45:02 -0700 (PDT)
In-Reply-To: <20170929133614.1c0cd68ad80139fafdf68b86@google.com>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
 <20170916080731.13925-10-chriscool@tuxfamily.org> <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
 <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com> <20170929133614.1c0cd68ad80139fafdf68b86@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 3 Oct 2017 11:45:02 +0200
Message-ID: <CAP8UFD05QzCn53SjbbgaToVWyd=3N+HayDvR4OZNaP7YKbEBfg@mail.gmail.com>
Subject: Re: [PATCH v6 09/40] Add initial external odb support
To:     Jonathan Tan <jonathantanmy@google.com>
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

On Fri, Sep 29, 2017 at 10:36 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Wed, 27 Sep 2017 18:46:30 +0200
> Christian Couder <christian.couder@gmail.com> wrote:

>> I don't think single-shot processes would be a huge burden, because
>> the code is simpler, and because for example for filters we already
>> have single shot and long-running processes and no one complains about
>> that. It's code that is useful as it makes it much easier for people
>> to do some things (see the clone bundle example).
>>
>> In fact in Git development we usually start to by first implementing
>> simpler single-shot solutions, before thinking, when the need arise,
>> to make it faster. So a perhaps an equally valid opinion could be to
>> first only submit the patches for the single-shot protocol and later
>> submit the rest of the series when we start getting feedback about how
>> external odbs are used.
>
> My concern is that, as far as I understand about the Microsoft use case,
> we already know that we need the faster solution, so the need has
> already arisen.

Yeah, some people need the faster solution, but my opinion is that
many other people would prefer the single shot protocol.
If all you want to do is a simple resumable clone using bundles for
example, then the long running process solution is very much overkill.

For example with filters there are people using them to do keyword
expansion (maybe to emulate the way Subversion and CVS substitutes
keywords like $Id$, $Author$ and so on). It would be really bad to
deprecate the single shot filters and tell those people they now have
to use long running processes because we don't want to maintain the
small code that make single shot filters work.

The Microsoft GVFS use case is just one use case that is very far from
what most people need. And my opinion is that many more people could
benefit from the single shot protocol. For example many people and
admins could benefit from resumable clones using bundles and, if I
remove the single shot protocol, this use case will be unnecessarily
more difficult to implement in the same way as keyword expansion would
be unnecessarily more difficult to implement if we removed the single
shot filters.

See the first article in
https://git.github.io/rev_news/2016/03/16/edition-13/ about resumable
clone if you are not convinced that resumable clones are not an old
and important problem.

>> And yeah I could change the order of the patch series to implement the
>> long-running processes first and the single-shot process last, so that
>> it could be possible to first get feedback about the long-running
>> processes, before we decide to merge or not the single-shot stuff, but
>> I don't think it would look like the most logical order.
>
> My thinking was that we would just implement the long-running process
> and not implement the single-shot process at all (besides maybe a script
> in contrib/). If we are going to do both anyway, I agree that we should
> do the single-shot process first.

Nice to hear that!

>> > And I think that my design can be extended to support a use case in
>> > which, for example, blobs corresponding to a certain type of filename
>> > (defined by a glob like in gitattributes) can be excluded during
>> > fetch/clone, much like --blob-max-bytes, and they can be fetched either
>> > through the built-in mechanism or through a custom hook.
>>
>> Sure, we could probably rebuild something equivalent to what I did on
>> top of your design.
>> My opinion though is that if we want to eventually get to the same
>> goal, it is better to first merge something that get us very close to
>> the end goal and then add some improvements on top of it.
>
> I agree

So are you ok to rebase your patch series on top of my patch series?

My opinion is that my patch series is trying to get to the end goal,
and succeeding to a very large extent, with the smallest amount of
deep technical changes as possible, and that it is the right way to
approach this problem for the following reasons:

1) The root problem is that the current object stores (packfiles and
loose object files) are not good ways to store some objects,
especially some blobs.

2) This root problem cannot be dealt with by Git itself without any
help from external programs, because Git cannot realistically
implement many different object stores (like http servers, artifact
stores, etc). So Git must be improved so that it becomes capable of
communicating with external object stores.

3) As the Git protocol uses packfiles to send objects and is not very
flexible, it might be better if external stores can also be used to
transfer objects that are not stored any more in the current object
stores. (As packfiles are not good for storing some objects, they are
probably also not a good format for sending them. Also, as the Git
protocol is not resumable, we might easily be able to implement
resumable clones if we let external stores handle some transfer.)

4) Making it easy and flexible to exchange objects (and maybe meta
information) with the external stores is very important.

5) Protocol changes are more difficult than many other code changes,
so we should care a lot about the protocol between Git and external
stores.

> - I mentioned that because I personally prefer to review smaller
> patch sets at a time,

I am ok with sending small patch sets, and I will send smaller patch
sets about this from now on.

> and my patch set already includes a lot of the
> same infrastructure needed by yours - for example, the places in the
> code to dynamically fetch objects, exclusion of objects when fetching or
> cloning, configuring the cloned repo when cloning, fsck, and gc.

I agree that your patch set already includes some infrastructure that
could be used by my work, and your patch sets are perhaps implementing
some of this infrastructure better than in my work (I haven't taken a
deep look). But I really think that the right approach is to focus
first on designing a flexible protocol between Git and external
stores. Then the infrastructure work should be related to improving or
enabling the flexible protocol and the communication between Git and
external stores.

Doing infrastructure work first and improving things on top of this
new infrastructure without relying first on a design of the protocol
between Git and external stores is not the best approach as I think we
might over engineer some infrastructure work or base some user
interfaces on the infrastructure work and not on the end goal.

For example if we improve the current protocol, which is not
necessarily a bad thing in itself, we might forget that for resumable
clone it is much better if we just let external stores and helpers
handle the transfer.

I am not saying that doing infrastructure work is bad or will not in
the end let us reach our goals, but I see it as something that is
potentially distracting, or misleading, from focusing first on the
protocol between Git and external stores.

>> >  - I get compile errors when I "git am" these onto master. I think
>> >    '#include "config.h"' is needed in some places.
>>
>> It's strange because I get no compile errors even after a "make clean"
>> from my branch.
>> Could you show the actual errors?
>
> I don't have the error messages with me now, but it was something about
> a function being implicitly declared. You will probably get these errors
> if you sync past commit e67a57f ("config: create config.h", 2017-06-15).

I am past this commit and I get no errors.
I rebased on top of: ea220ee40c "The eleventh batch for 2.15"

>> > Any reason why you prefer to update the loose object functions than to
>> > update the generic one (sha1_object_info_extended)? My concern with just
>> > updating the loose object functions was that a caller might have
>> > obtained the path by iterating through the loose object dirs, and in
>> > that case we shouldn't query the external ODB for anything.
>>
>> You are thinking about fsck or gc?
>> Otherwise I don't think it would be clean to iterate through loose object dirs.
>
> Yes, fsck and gc (well, prune, I think) do that. I agree that Git
> typically doesn't do that (except for exceptional cases like fsck and
> gc), but I was thinking about supporting existing code that does that
> iteration, not introducing new code that does that.

I haven't taken a look at how fsck and prune work and this is still
code that Peff wrote (though a long time ago), so I tend to trust it.
But I will take a look, and if it is indeed better for them, I am ok
to update sha1_object_info_extended() instead of loose object
functions.

Thanks.
