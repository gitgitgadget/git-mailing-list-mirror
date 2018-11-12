Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44591F97E
	for <e@80x24.org>; Mon, 12 Nov 2018 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeKMBad (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:30:33 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33913 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeKMBad (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:30:33 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so2057828vkd.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj9K0VkoPeFLjIe0xfKDL+198D4fsAJ15tZiYYeEv/0=;
        b=GSq7XX/0KFVBnmywrbeyyXnLqFB6fdDyfBK6XbkxhsyIISqZ0AO0b9ab7vw95ACKc/
         oNLoZ7KPhcbdSeOCZSKWkA6FpiVq3TIiiiiGP1RyzHL6NWygfM5z1IgcJb5QRRz88hwE
         9hz/cj8tlDY0s8b+tVEvqVrzF0JmC0oD6hWpOHNbEageIXFexRT3xDdNnOBfAU0XuLS5
         kQJk/5oDXLM3uRy3MLMwuMenwXuPgD/matUG1AkzyC28gCnlj1EVUIFa/LwlxCcw25wS
         hFQb1+4E7OnIpIJNPbMLVtq1nUN/uB+CBD/gl3qlGwZd12kdPupRS4t3ix5KdCh1FYm5
         tjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj9K0VkoPeFLjIe0xfKDL+198D4fsAJ15tZiYYeEv/0=;
        b=bRXOA3+KKA2wo79uBeZ5QVL+QzSuJCynUPp4WlLU22Yp+I6SiIRQdUNZ6TmFsQh8KG
         36VsOhcl1cQJELzTQRuoXog+Wmu4BkeXwTnidZ1DGV0d7+D5PC1RtbZtRQ1VZrcYFBEp
         Ze39ziyWYsJLlg0fUhgErVV0o8qrn2diORVH+4sQYjufVFrrx66lkJPNTKY7yqjSO1nt
         /Rp2++t4FZWEZaUnvOmfCXIBYnB+bIqd9IudQnWQ3Dgt3AOth8201GQDvEqlEh+iU+3R
         Fz22Gf25qBVmUXYJh+baXnVKb2rL30mz08So33z87NzlKSR/Ob1VZInOF021RgJF9SiH
         Qumw==
X-Gm-Message-State: AGRZ1gLeeblVJpIkoMogUOvEGWsl+hoJMFvAo7EWzi3X48QnJM6OQRWz
        UdTgNEW5ycYWFDfflo/km9hyMrghCsYVNUX4C6Y=
X-Google-Smtp-Source: AJdET5e2uMKSmoTJ0DsOsKYMgsavcllOENW8GBHCK/VV6zxtr/n0OS0LkVEXXkZrX2HGP1m3TukVIKuC4BbwIpMPg8A=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr593466vkd.15.1542037007188;
 Mon, 12 Nov 2018 07:36:47 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-7-newren@gmail.com>
 <20181111065338.GF30850@sigill.intra.peff.net> <CABPp-BGF8C5vhyVbAwpmXeii452fBgtvL4dPRLWdOPxLiCYR0A@mail.gmail.com>
 <20181112124547.GG3956@sigill.intra.peff.net>
In-Reply-To: <20181112124547.GG3956@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Nov 2018 07:36:36 -0800
Message-ID: <CABPp-BHLEtXe-2OTHNxHe=vypvbd-kFQ3G1FaVGnQ-Gc4+z1uA@mail.gmail.com>
Subject: Re: [PATCH 06/10] fast-export: when using paths, avoid corrupt stream
 with non-existent mark
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 4:45 AM Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2018 at 12:01:43AM -0800, Elijah Newren wrote:
>
> > > It does seem funny that the behavior for the earlier case (bounded
> > > commits) and this case (skipping some commits) are different. Would you
> > > ever want to keep walking backwards to find an ancestor in the earlier
> > > case? Or vice versa, would you ever want to simply delete a tag in a
> > > case like this one?
> > >
> > > I'm not sure sure, but I suspect you may have thought about it a lot
> > > harder than I have. :)
> >
> > I'm not sure why you thought the behavior for the two cases was
> > different?  For both patches, my testcases used path limiting; it was
> > you who suggested employing a negative revision to bound the commits.
>
> Sorry, I think I just got confused. I was thinking about the
> documentation fixup you started with, which did regard bounded commits.
> But that's not relevant here.
>
> > Anyway, for both patches assuming you haven't bounded the commits, you
> > can attempt to keep walking backwards to find an earlier ancestor, but
> > the fundamental fact is you aren't guaranteed that you can find one
> > (i.e. some tag or branch points to a commit that didn't modify any of
> > the specified paths, and nor did any of its ancestors back to any root
> > commits).  I hit that case lots of times.  If the user explicitly
> > requested a tag or branch for export (and requested tag rewriting),
> > and limited to certain paths that had never existed in the repository
> > as of the time of the tag or branch, then you hit the cases these
> > patches worry about.  Patch 4 was about (annotated and signed) tags,
> > this patch is about unannotated tags and branches and other refs.
>
> OK, that makes more sense.
>
> So I guess my question is: in patch 4, why do we not walk back to find
> an appropriate ancestor pointed to by the signed tag object, as we do
> here for the unannotated case?
>
> And I think the answer is: we already do that. It's just that the
> unannotated case never learned the same trick. So basically it's:
>
>   1. rewriting annotated tags to ancestors is already known on "master"
>
>   2. patch 4 further teaches it to drop a tag when that fails
>
>   3. patch 6 teaches both (1) and (2) to the unannotated code path,
>      which knew neither
>
> Is that right?

Ah, now I see where the slight disconnect was.  And yes, you are correct.

> > > This hunk makes sense.
> >
> > Cool, this was the entirety of the code...so does this mean that the
> > code makes more sense than my commit message summary did?  ...and
> > perhaps that my attempts to answer your questions in this email
> > weren't necessary anymore?
>
> No, it only made sense that the hunk implemented what you claimed in the
> commit message. ;)
>
> I think your responses did help me understand that what the commit
> message is claiming is a good thing.
