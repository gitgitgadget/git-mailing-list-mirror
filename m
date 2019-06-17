Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF5E1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 20:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfFQUIE (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 16:08:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33264 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFQUIE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 16:08:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so17999052edq.0
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJ6LKSmf7thz2dIFp2+yQO8bJcfZzz/Yaq4GwwgujBw=;
        b=HAqt1C2B6W1VpxKWKNqnyHkACWny8CHd0M+VXy0MpQQ3vqYZ1o7TofL5z4aAsh06di
         M8M1KBld+o8aSCwJf1BZL2i5obdVe/5lVLos36sIFwdlfqunRqwvrL+YZlubJtngny4o
         dEEf+T7f1y2LnRIroSdISPq+6RoaSHbAbXr8uZV8n8KrW82lpThu4GTKn9g0h3ZVE1oJ
         kv2gW78jOgXyGkypXOt7rm/EU/YtGwRgFTtWufcEOo4sB3+bTdxNydbl/E3lpHQfkE2t
         f0cYChoYUev/pVx1qHVBYxJ1dtZ7vE11oQLaqX0k+d4Q0SgPoKx98cGo3Pafh1v2tdch
         3sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJ6LKSmf7thz2dIFp2+yQO8bJcfZzz/Yaq4GwwgujBw=;
        b=sj+ClLiuF1bDXt+hlhl7r6mWv7GZFBWmcURLjHu9/rOP5sEf8HLc+IvqK4H6ET/iiu
         v9xt97RRB6+TEeo8eWH2xbt7PAnjHeScf+Ys0v8N2RNC1y1qVP+t9cqlbxFdrMIFFKUw
         mJe3ed7R1AJXvX3rG3dNWXrOuYQQ3n/QWKw0WRSpyCWU8k2kQ9C6XaS1UwQFP0RQ99+x
         J48BQkblBeE4a0Wf4AcGayZG+ZC6AYFQSNdv/TVjcoO2YwkdJj9igmCRtVHKLlmyIqj3
         F1LUxu26lj0NyDTHpeDIoKMUE8BkPJCQItyKJEwRMacjFRoq9qJdAdo8N8VeZHlmK/Jl
         E7xg==
X-Gm-Message-State: APjAAAVZS53aHw+fs2tJ6AfPSTt5Zx4KlW4oY6fPthx5+avlGwaavAbs
        ViU/L/SokF3ZSpJ9sncdK9rEB3Hsnfk6ftLrywI=
X-Google-Smtp-Source: APXvYqwNeIh35CvwwLK9wBaYRjJNpb2KrHzGbqmEKSS9E/sESZhlwl6AGdmO2wj/hz0EBoxBO5caXu2+DVr5K3t7EJs=
X-Received: by 2002:a50:bdc2:: with SMTP id z2mr120855153edh.245.1560802082209;
 Mon, 17 Jun 2019 13:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net> <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
 <CAK7LNATRQWz9CvosEDzNHCZHaxpzozAjGyo5VSKpQhui9zhSFQ@mail.gmail.com>
 <CAP8UFD3_kKvBs=rMvBp-K-UPD5mCqVsHRZ1VqGYY7uR8G+H8SQ@mail.gmail.com> <xmqqtvcoruda.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvcoruda.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Jun 2019 22:07:50 +0200
Message-ID: <CAP8UFD3EaR=PRsN9sEEAOOdqQxPeZ1wiiWrVeBKQv8AW1zY1ig@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 17, 2019 at 7:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Mon, Jun 17, 2019 at 6:33 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >>
> >> On Sat, Jun 15, 2019 at 5:41 PM Christian Couder
> >> <christian.couder@gmail.com> wrote:
> >> >
> >> > > I do wonder if the trailer code is correct to always respect it, though.
> >> > > For example, in "git log" output we'd expect to see commit messages from
> >> > > people with all sorts of config. I suppose the point is that their
> >> > > comment characters wouldn't make it into the commit object at all, so
> >> > > the right answer there is probably not to look for comment characters at
> >> > > all.
> >> >
> >> > Would you suggest an option, maybe called `--ignore-comments` to ignore them?
> >>
> >> Since 'git interpret-trailers' already ignores lines starting with '#',
> >> is this option true by default?
> >
> > Sorry, I should have suggested something called --unstrip-comments or
> > --ignore-comment-char that would make 'git interpret-trailers' stop
> > stripping lines that start with the comment character.
>
> So, to summarize:
>
>  - As the traditional behaviour is to strip comment, using the
>    hardcoded definition of the comment char, i.e. '#', we do not
>    switch the default.  Instead, a new command line option makes
>    it pretend there is no comment char and nothing get stripped.

Yeah, that's the idea of --unstrip-comments (or
--ignore-comment-char). I am ok with preparing and sending a patch to
add that, though it is not urgent and it would be nice if we could
agree with the name first.

>  - But the core.commentchar that does not override hardcoded
>    definition is a bug, so we'd fix that along the lines of what
>    Peff's patch outlined.

Yeah, not sure if Peff wants to resend his patch with a proper commit
message. I would be ok with doing it if he prefers.

Thanks,
Christian.
