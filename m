Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD801F453
	for <e@80x24.org>; Fri,  9 Nov 2018 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeKJHko (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 02:40:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37837 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJHko (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 02:40:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id y10-v6so2923958edr.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NWMI3ncQ4AuJvc0LQxvhsS4oI6o11tI0aXXjhUxxNs=;
        b=Gcp7BXM6s2MsAaYsPdv6Doprdg/phiC4j2xmCijdXjVxPaaBDBN6pa1TB+lzPo0LVx
         CU6NdA7BEe7EbyDRXGXC+L5NROO1tI0GRLhvNJH9IYgOODhml+ORE7INY1iM+40589k1
         7/wOqJicWBL0PRl2QyK/v62BarZDFiNgDnzGKd4zp9VtamkpffihJxbUhaQ9dvQEHQ9z
         37QFCHvp709Sk1wh4YbMvsJSOiQJimQVDyGXUrxNg9dMzv1Xer0zL9Pa1t2VoaHg1+/X
         Bi3qzfQHLrrUkh7augoxREp+0TV4ipP/6iIXieTLR/N0SfhKjspmrP0MKEGPUAJ0bdCu
         bJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NWMI3ncQ4AuJvc0LQxvhsS4oI6o11tI0aXXjhUxxNs=;
        b=J1wVlgCsQVXDyReNfMYTLLe4kPIQUabC7IuIuvNj+XVw0i0eXVm9L3uuHz7NbsgwxE
         Pr4uBBgp0m+WvuDfpeFJ9kGvAOl+sT9BShdRMdzLDIHVPVVftQKYobnm6XfzwewOSvih
         8RkfkJxLXd0WIyL2BTBvmDrA02Y+V1KC1kCZC0zt8V/Q6+f1QQekkVTeKO7IJzK7Aqoi
         Uuk3xIBaK9ZeUfVxLadU3EWzUJ9MZy+ZaVeKn2thDjLfm+LzGatZq4zjiJxIE9b23ynN
         gouJM89gTMu7wBiF1kOBPtCdwF15g3YwQIVPRux4RPWwM+cGA1aSPASdsrJi+t4GTB5J
         I0Qg==
X-Gm-Message-State: AGRZ1gI3Z0V8gQTjtBBw/8JFkbcq+N7U7lo0HDozxLOBVH0C/UUGLDA2
        6JIzNJFJbtaPZ8VUeDWdVMNgT0n057DyobQOAH4E/A==
X-Google-Smtp-Source: AJdET5eMSN/V4JA9uZQwecep6mICFFXCH5+76Hwbjscx/pp45oguxxG1MQyuSjEt8OwFiBBqnZ13kHaETm8cCwDNuJg=
X-Received: by 2002:a50:a307:: with SMTP id 7-v6mr3720815edn.231.1541800692938;
 Fri, 09 Nov 2018 13:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20181030220817.61691-2-sbeller@google.com> <20181108205255.193402-1-sbeller@google.com>
 <xmqqzhui4ymh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhui4ymh.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Nov 2018 13:58:01 -0800
Message-ID: <CAGZ79kbdewnxe=uC4GScvjJTgsru75O2FzSckjWoin2g1yXyPw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: add pending semantic patches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 9:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> > Add a description and place on how to use coccinelle for large refactor=
ings
> > that happen only once.
> >
> > Based-on-work-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >
> > I consider including this patch in a resend instead.
> > It outlays the basics of such a new workflow, which we can refine later=
.
>
> Thanks for tying loose ends.
>
> > diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
> > index 9c2f8879c2..fa09d1abcc 100644
> > --- a/contrib/coccinelle/README
> > +++ b/contrib/coccinelle/README
> > @@ -1,2 +1,62 @@
> >  This directory provides examples of Coccinelle (http://coccinelle.lip6=
.fr/)
> >  semantic patches that might be useful to developers.
> > +
> > +There are two types of semantic patches:
> > +
> > + * Using the semantic transformation to check for bad patterns in the =
code;
> > +   This is what the original target 'make coccicheck' is designed to d=
o and
> > +   it is expected that any resulting patch indicates a regression.
> > +   The patches resulting from 'make coccicheck' are small and infreque=
nt,
> > +   so once they are found, they can be sent to the mailing list as per=
 usual.
> > +
> > +   Example for introducing new patterns:
> > +   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
> > +   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
> > +
> > +   Example of fixes using this approach:
> > +   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
> > +               a strbuf, 2018-03-25)
> > +   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
> > +
> > +   These types of semantic patches are usually part of testing, c.f.
> > +   0860a7641b (travis-ci: fail if Coccinelle static analysis found som=
ething
> > +               to transform, 2018-07-23)
>
> Yup, and I think what we have in 'pu' (including your the_repository
> stuff) falls into this category.

My impression was that the_repository is strongly second category
as the_repository.cocci doesn't fix bad smells of code, but proposes
a refactoring that we agreed on doing.

> I've been paying attention to "make coccicheck" produced patches for
> the past few weeks, and so far, I found it _much_ _much_ more
> pleasant, compared to having to worry about merge conflicts with the
> topics in flight that changes day to day (not just because we add
> new topics or update existing topics, but also the order of the
> merge changes as topics mature at different rates and jumps over
> each other in master..pu history), that "make coccicheck" after
> topics are merged to integration branches fixes these issues up as
> needed.

So from your end we would not need the "pending" category as long
as the follow ups come in a timely manner?

>
> > +   3) Apply the semantic patch only partially, where needed for the pa=
tch series
> > +      that motivates the large scale refactoring and then build that s=
eries
> > +      on top of it.
>
> It is not quite clear what "needed for the patch series" really
> means in the context of this paragraph.  What are the changes that
> are not needed, that is still produced if we ran "make coccicheck"?

An example for "needed" would be
3f21279f50..bd8737176b
whereas "not needed" is what is in
"treewide: apply cocci patch".

The treewide conversion of e.g. unuse_commit_buffer to
repo_unuse_commit_buffer is nice, but "needed" only in
its followup patch that converts logmsg_reencode as that
calls into the unuse_commit_buffer.

> Are they wrong changes (e.g. a carelessly written read_cache() to
> read_index(&the_index) conversion may munge the implementation of
> read_cache(...) { return read_index(&the_index, ...); } and make
> inifinite recursion)?  Or are they "correct but not immediately
> necessary" (e.g. because calling read_cache() does not hurt until
> that function gets removed, so rewriting the callers to call
> read_index() with &the_index may be correct but not immediately
> necessary)?

the latter. I assume correctness (of the semantic patch) to be a given,
but this is all about timing, i.e. how can I send the series without breaki=
ng
others in flight.

>
> > +      By applying the semantic patch only partially where needed, the =
series
> > +      is less likely to conflict with other series in flight.
>
> That is correct.
>
> > +      To make it possible to apply the semantic patch partially, there=
 needs
> > +      to be mechanism for backwards compatibility to keep those places=
 working
> > +      where the semantic patch is not applied. This can be done via a
> > +      wrapper function that has the exact name and signature as the fu=
nction
> > +      to be changed.
>
> OK, so this argues for leaving read_cache()-like things to help
> other in-flight topics, while a change to encourage the use of
> read_index() takes place.  That also makes sense, and this directly
> relates to "less likely to conflict" benefit you mentioned above.

ok.

>
> But it is still unclear to me then what are "necessary".
>
> ... goes and thinks ...
>
> OK, so a series that allows a codepath to work on an arbitrary
> in-core istate, for example, may need to update a function to take
> istate and use it to call read_index(istate...), and the old code in
> such a call chain must have used read_cache(), always operating on
> &the_index.  For the purpose of that series, it does not matter if
> other codepaths that are not involved in the callchain the series
> wants to update are still only working on &the_index, so a change to
> turn read_cache() into read_index(&the_index) is *not* necessary
> (but still would be correct) and should be left out of the series.
> But any change the series makes to the callchain in question that
> turns read_cache() into read_index() with something call-specific
> (not &the_index) is a necesary one.  Is that a reasonable example
> of what these paragraphs wanted to convey with the distinction
> between "needed for the patch series" and other changes?

Exactly.

Maybe another way to phrase it is to explain the two series
independently of each other:

 1) Create the semantic patch series containing
 1a) - a *.pending.cocci semantic patch
 1b) - forward/backward compatibility providers
         (wrapper/defines)
 1c) then send the semantic patch series to the list

 2a) Write the other series as if (1) doesn't exist
    This means there will be some upgrades of
    the call chain from read_cache() to read_index()
 2b) Coincidentally these upgrades are the same
   as (1) would have produced. That's the whole
   trick.
 2c) send of this series independently of (1)

This can be done for read_cache / read_index as
they both exist already, but when read_index is
new to the code base, we'd need (2) to rely on (1b).

And that is why this patch sounded complicated.
