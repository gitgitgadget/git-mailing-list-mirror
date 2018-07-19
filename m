Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7329E1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 05:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeGSGj2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:39:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45117 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeGSGj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:39:28 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so6110900ioh.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnTGG14icSJ9/fAt+WsGMlPgE8B1G742KC1l6GxOA4Q=;
        b=e/apw5oyRrwJ28t+hX/VVShNP7txkNCgXdd2q/eRNq6aKlZAxek+pGeEb0WU9tjZnt
         d0T0e8VVEhzpoSNI2JnuttT4NE5o9zGCrP+hqCMebmMB7bkqCGiNIrq3hiLPD9jLxvuC
         KhIp7p1kG+a9W0YEQUkAdbvCuJj/4YBZBoc0VmHVFbVkpM6loLvWAonAwvaDW0A0Nvkf
         8JOjXfT6BLTZN6XjIPP9Canw6tCsP2XjNSaZiFGiR7khI3IDzUf2/TjqPZ1gZhkljki7
         C3YHqN0aR7Zso3yLlqnVlyX8og8RaTo1lT1U0s4OEdrF87+a+FhTBfaS27MsXiWXQ8N0
         BNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnTGG14icSJ9/fAt+WsGMlPgE8B1G742KC1l6GxOA4Q=;
        b=YIAkpLjK5IVrHjcliZISHm4IHYycQOcd97m9iaegoeauGJ7r2HM96AWIGcCm0v9YvM
         EfTUSEavjwB2lIlFINg33OoLbGiGsME696iBIX/BummeN/x871N7xiX6zIlCMtE+ziOP
         IuR2xXOqIkb+d8XSU8IhzGNEidEduDA0i4/VjXVGUbNJVm4f3ITH7y0C+wK2xmhN3y6i
         MZFv8MsZaf4HG70UluC5R5ONbsJ4hWb0nPqyZTV/Bl0dANfp751DiXz0lQe+DrmL0t5V
         PdhmiVd9RfwvJYGaxJEMaDA6BD5QHHRlAY8oA8wDv+KEk9+7aVMrqKK6bDS9Db3PLVb3
         DMoA==
X-Gm-Message-State: AOUpUlGJse8fjaM1+bcXlxGI2nBFY5US9Wmb7ox+b2+s+k28dp14zqSE
        EegyvXwP6UpAA8M44mlM1VuQwRMPxk0cDOhyPSE=
X-Google-Smtp-Source: AA+uWPw+mkk1/+6tG3LSJq4zmsj47KCQ0WV5pxsE7MiBvfmfq+E5MO42dl6jDt94ywZTvuxWmtB3e2CuXKhpKTGO68M=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr7343139iod.118.1531979884033;
 Wed, 18 Jul 2018 22:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180719054424.GB23884@sigill.intra.peff.net>
In-Reply-To: <20180719054424.GB23884@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 07:57:37 +0200
Message-ID: <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 7:44 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 18, 2018 at 03:51:08PM -0700, Elijah Newren wrote:
>
> > I had a user report some poor behavior of 'git gc --aggressive' on a
> > certain repo (which I sadly cannot share).  Turns out that on this
> > repo, this operation takes about 60% longer and produces a pack
> > roughly twice the expected size.
> >
> > Naturally, bisecting takes a while but it points to this commit:
>
> Thanks for finding and bisecting.
>
> > To put some numbers behind this, I got on a very beefy box (40 cores,
> > 160GB RAM) and ran some comparisons:
> >
> > Version  Pack (MB)  MaxRSS(kB)  Time (s)
> > -------  ---------  ----------  --------
> >  2.17.0     5498     43513628    2494.85
> >  2.18.0    10531     40449596    4168.94
> >  fix-v1     5509     42509784    2480.74
> >  fiv-v2     5509     41644104    2468.25
> >
> > where fix-v1 and fix-v2 are different patches on top of git-2.18.0
> > that I'll follow up to this email with.  The patches are just meant as
> > discussion starters.  I'll add signoffs and proper commit messages if
> > folks actually want those fixes, but I suspect they're just starting
> > points for discussion.
>
> Hmm. So what's the mechanism causing the issue here? Looking at the
> patch from 0aca34e826 (pack-objects: shrink delta_size field in struct
> object_entry, 2018-04-14), it should _mostly_ be about how we store data
> in memory, and should not impact the deltas we find.
>
> But reading the patch and looking at your v2, it seems clear that this
> hunk is the culprit:
>
> @@ -2006,10 +2008,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>         delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
>         if (!delta_buf)
>                 return 0;
> +       if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
> +               free(delta_buf);
> +               return 0;
> +       }
>
> So we're punting on large deltas, and presumably your test case has some
> files that are large but delta well (and we miss those opportunities,
> which wastes further time in the delta search and creates a lousy pack).
>
> I'm not sure why we need this hunk, though. Eventually we'd hit
> SET_DELTA_SIZE(), and I thought the point is that it should handle large
> sizes with some kind of fallback (the commit message even mentions an
> "overflow bit"). Looking at oe_set_delta_size(), though, I don't think
> the fallback would really work here; we'd hid the BUG().

The fallback is for existing on-disk deltas where we can actually get
the size from. For new deltas we have to store the size somewhere in
memory and we can't because this field's size is reduced.

I thought 2M was generous but I was obviously wrong. I'd like to see
the biggest delta size in this pack and whether it's still reasonable
to increase OE_DELTA_SIZE_BITS. But if it's very close to 4GB limit
then we could just store 64-bit delta size in a separate array.
-- 
Duy
