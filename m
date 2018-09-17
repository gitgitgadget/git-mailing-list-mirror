Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3DA1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIQVdj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:33:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53136 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQVdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:33:39 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so11870751ita.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kazelbK++pXzox1tu9W9NM3QcREl0PYhxzrnAzYwPY=;
        b=mfBklUwoZCnQ+HaSIAz9aTaUoGwBNseDEWTbosgluDvwHfV+fZs6SlUWXWFGwmYn/t
         m2aDFgBFMWh0auaaCSAkgiBPJ3shgsgBc2dUv4yQ01kUoPlYi2bnL2V+5gB7l01Ls2LA
         KmgU21r4vCVB7XqN96zNuQlwRYxqP7ou9w9CWvkphtPftFFckw53AVTW1Fxw84mfzHAd
         wrHcxegxWb/amBEc6pwT1rvZ9jtoMlzERhyyAg0mOIoKz8vvmOHMFYbzUjl0VTjCz00f
         CdJI/avHsq5MZOKophnsiSPFgvsxWUfRxu8bDMMHEOfaJFtezwqEzSAQZAN77y3j0OYX
         NNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kazelbK++pXzox1tu9W9NM3QcREl0PYhxzrnAzYwPY=;
        b=S2pM8LLqJhyeWT/N55FU87ObvXBblW7LQuQML2Z4sQVg/cMgIz01SQaX7chV+rgiy9
         uw/e6SQ0gUAoF28JaSgjKH7GMq2wPFA9Suuw/L7XP5WUdvLN+bQqdg3hdrpABrdX6cp/
         5swUcBkWxzZJoKu06W5GMhfsk7CTwfO5wQtqRM4eXAsUNsC03l9o3e1JInyzGjF+tw+x
         GvLLDacHxN6mi5ZvEbTEmJKk7GQ7Qog//No3OryGYP0RbOF+niloEX2I25meccqmlJty
         7I2xd03J7yWVGCcXRxm3K+/RmnPGoJrEurLSJ3os6Ld2PNucGobBG2ULyBhLKIgr9eBV
         nRMQ==
X-Gm-Message-State: APzg51AFXCnDt0z3Q43Swkh5D/wnAqzCACRaMwN+LP/wt5eBvun6rczG
        HUOiI1HaCG+eKiYyPSUGXYs3CavyvEd/m/rzzBQ=
X-Google-Smtp-Source: ANB0Vdbuni/D+mn/lj7r3ZMYC1yNuwhGIK7o01/QIau3cqVLMHnETUF5QwqoXVElqMsxBMfBS/SlFjNSsFxxkp5hSYQ=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr13181794ita.5.1537200338455;
 Mon, 17 Sep 2018 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-2-benpeart@microsoft.com>
 <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com> <f7250999-71a3-0113-2858-e66bad283db3@gmail.com>
In-Reply-To: <f7250999-71a3-0113-2858-e66bad283db3@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 18:05:10 +0200
Message-ID: <CACsJy8DEvLJYBm0P1VtvKFD-CAo6_4Z13dBHWkuuAavghbGBag@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 4:55 PM Ben Peart <peartben@gmail.com> wrote:
> On 9/15/2018 6:02 AM, Duy Nguyen wrote:
>
> >>          default:
> >>                  if (*ext < 'A' || 'Z' < *ext)
> >>                          return error("index uses %.4s extension, which we do not understand",
> >> @@ -1889,6 +1893,11 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
> >>          return ondisk_size + entries * per_entry;
> >>   }
> >>
> >> +#ifndef NO_PTHREADS
> >> +static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
> >> +#endif
> >
> > Keep functions unconditionally built as much as possible. I don't see
> > why this read_eoie_extension() must be built only on multithread
> > platforms.
> >
>
> This is conditional to avoid generating a warning on single threaded
> platforms where the function is currently unused.  That seemed like a
> better choice than calling it and ignoring it on single threaded
> platforms just to avoid a compiler warning.

The third option is ignore the compiler. I consider that warning a
helpful suggestion, not a strict rule.

Most devs don't run single thread builds (I think) so is this function
is updated in a way that breaks single thread mode, it can only be
found out when this function is used in single thread mode. At that
point the function may have changed a lot. If it's built
unconditionally, at least single thread users will yell up much sooner
and we could fix it much earlier.

> >> @@ -2520,11 +2534,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
> >>                  return err;
> >>
> >>          /* Write extension data here */
> >> +       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> >> +       the_hash_algo->init_fn(&eoie_c);
> >
> > Don't write (or even calculate to write it) unless it's needed. Which
> > means only do this when parallel reading is enabled and the index size
> > large enough, or when a test variable is set so you can force writing
> > this extension.
>
> I made the logic always write the extension based on the earlier
> discussion [1] where it was suggested this should have been part of the
> original index format for extensions from the beginning.  This helps
> ensure it is available for current and future uses we haven't even
> discovered yet.

But it _is_ available now. If you need it, you write the extension
out. If we make this part of index version 5 (and make it not an
extension anymore) then I buy that argument. As it is, it's an
optional extension.

> [1] https://public-inbox.org/git/xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com/
>
>
> >> +
> >> +static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset)
> >
> > We normally just put function implementations before it's used to
> > avoid static forward declaration. Any special reason why it's not done
> > here?
> >
>
> This was done to promote readability of the (already large) read-cache.c
> file.  I first considered moving the EOIE read/write functions into a
> separate file entirely but they need access to information only
> available within read-cache.c so I compromised and moved them to the end
> of the file instead.

I consider grouping extension related functions closer to
read_index_extension gives better readability, or at least better than
just putting new functions at the end in no particular order. But I
guess this is personal view.
-- 
Duy
