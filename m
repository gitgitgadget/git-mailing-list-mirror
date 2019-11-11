Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3900C1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 17:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKRZy (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 12:25:54 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34560 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKRZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 12:25:54 -0500
Received: by mail-vk1-f194.google.com with SMTP id t184so3765129vka.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 09:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8Yb4vsUuxAgnWibtTHuuq1JBC+p31XFfG89NSW+Gt0=;
        b=W1rzF9GMZm9BI6Z3h3i0+bNwaZQf48o6GCwxjJMEByrjWc6wDeLz9mD5NI7Nc7OhdG
         m3fF1aiCaX0pNf0M6NJchN81CVyyFCYKpLm0ebzXtbOasDPxVgC3mwJAgB2yoALf9K7r
         nzypm91MAGfNvGixiJLcPORvFkCrrZfVpnoD8G+NOKWCMofVwfMDEnt3mBwmkx08Mitm
         cApsxhgqkTB3bo+IFg+3I5npLfNGkVN2QigRScUrgP3t7KFzqpxHkSr+uVBiWS1xpsL5
         TwWXHIEWtHQeDYyfC0aG3SzQmmBF46ZSVFpS96XJVFhM7vRW//hO/4Yduuq9sa6jZ6+U
         Fjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8Yb4vsUuxAgnWibtTHuuq1JBC+p31XFfG89NSW+Gt0=;
        b=K3hJQAB/DhX836BDMzshPaemnxt4s2Zqmh+v5fjM+biNtHR5l2LxOejP4LmkUpVwZv
         tHEnInXw2pkeUOVDXLVC4qUD1Oq9uj5lNrO1km6UHGQKn3D2rD9UcJG7cjEvmlb1xJ1E
         62tXj60ooig2CfmNlIkN3dyro7pUCwBHxer4TMXNQ7f9uen4/vO7dD1BhzayXucOXd4O
         MsfbVC5oCg4V83Rwr6dqy6hFq/a08gGd9MziAoHK6SA3fo86RNQ1ENBBGw1Y8LRsTBCf
         zMBprcS7phlbplVyjjfSGlw4HCVgwMcUnQvYuStlNHZuD6sz5/+EQeSZz/8gpFZW33AB
         s7kQ==
X-Gm-Message-State: APjAAAU3CqHgXu9i0QC4OM6Hi6ePhHi4p+ODIZMbQE8qwYAf+ndgmlzP
        bR09Wde2D+b2h/kIQeQF9fQMdD+NHeWc1alYJCvjdQ==
X-Google-Smtp-Source: APXvYqxwAoh5pthivGFEvqD0vWJ2VOMScwB1FRSitr5RtRTOKCq+JZzhL04ti1vbdeh50/5js4hdJjLBuW+V9yaR7uQ=
X-Received: by 2002:a1f:2b0f:: with SMTP id r15mr18531466vkr.91.1573493152444;
 Mon, 11 Nov 2019 09:25:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com> <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   Utsav Shah <ukshah2@illinois.edu>
Date:   Mon, 11 Nov 2019 09:25:41 -0800
Message-ID: <CABhpXbdyfxF3xVrjHUDzN7inu6O+CVVxG1wc9shhy33XiDoNPA@mail.gmail.com>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
To:     Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 8:55 AM Kevin Willford
<Kevin.Willford@microsoft.com> wrote:
>
> > From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> > Of Junio C Hamano
> > Sent: Sunday, November 10, 2019 7:01 PM
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > >> At the very least, this patch mitigates an over-eager check for split
> > >> index users while maintaining good invariants for the standard case.
> > >
> > > OK, it sounds more like this "it does not make any sense to compare
> > > the position in the fsmonitor bitmap (which covers the entire thing)
> > > with the position in just a split part of the index (which covers only
> > > the delta over the base index)"?  If that is the case, it means that
> > > the "check" is even worse than being "over-eager"---it simply is not
> > > correct.
> >
> > Having said all that, I wonder if we are doing the right thing with or without
> > 3444ec2e ("fsmonitor: don't fill bitmap with entries to be removed", 2019-10-
> > 11) in the split-index mode in the first place.
> >
> > The fact that your "loosen the check and allow 'pos' that identifies a tracked
> > path used by the fsmonitor bitmap to be larger than the size of the istate-
> > >cache[]" patch under discussion is needed is that 'pos' may sometimes be
> > larger than isate->cache[] no?  Then what happens in this hunk, for example?
> >
> > diff --git a/fsmonitor.c b/fsmonitor.c
> > index 231e83a94d..1f4aa1b150 100644
> > --- a/fsmonitor.c
> > +++ b/fsmonitor.c
> > @@ -14,8 +14,13 @@ struct trace_key trace_fsmonitor =
> > TRACE_KEY_INIT(FSMONITOR);  static void fsmonitor_ewah_callback(size_t
> > pos, void *is)  {
> >       struct index_state *istate = (struct index_state *)is;
> > -     struct cache_entry *ce = istate->cache[pos];
> > +     struct cache_entry *ce;
> >
> > +     if (pos >= istate->cache_nr)
> > +             BUG("fsmonitor_dirty has more entries than the index
> > (%"PRIuMAX" >= %u)",
> > +                 (uintmax_t)pos, istate->cache_nr);
> > +
> > +     ce = istate->cache[pos];
> >       ce->ce_flags &= ~CE_FSMONITOR_VALID;
> >
> > The istate->cache[] is a dynamic array whose size is managed via the usual
> > ALLOC_GROW() using istate->cache_nr and istate->cache_alloc, whether the
> > split-index feature is in use.  When your patch makes a difference, then,
> > doesn't the access to istate->cache[] pick up a random garbage and then flip
> > the bit?
> >
> > Puzzled...  In any case, "check is worse than over-eager, it simply is wrong" I
> > wrote in the message I am responding to is totally incorrect, it seems.  It
> > smells like lifting the check would just hide the underlying problem under the
> > rug?
>
> I agree.  The only 2 places that excluding the split-index make sense are in
> read_fsmonitor_extension and write_fsmonitor_extension because the
> index_state that is being passing into those methods could be the delta index
> in which case the number of entries for the fsmonitor bitmap would almost
> always be more and cause the BUG to be hit which it should not be.
>
> The reason it is not needed and should not be in the other 2 places is they
> are ran from tweak_fsmonitor which is ran at post_read_index_from which
> is after the base and delta indexes have been loaded into the indes_state and
> the index_state will have all the entries and if the fsmonitor bitmap is bigger
> than the number of entries then the BUG should be hit.

Thanks. What exactly is the delta index? Is it the "split" index, vs
the shared indices? I was surprised to see cache_nr being zero. My
understanding was that cache and cache_nr would always be the
materialized version of the entire index, which is clearly incorrect.

>
> Kevin
