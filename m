Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513B31F597
	for <e@80x24.org>; Sun, 29 Jul 2018 05:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeG2G4Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 02:56:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50662 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeG2G4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 02:56:16 -0400
Received: by mail-it0-f68.google.com with SMTP id g191-v6so1997777ita.0
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 22:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsG921u+pQ9BumUOD8L4sLP8OotYRXEOK4U7+FA+bbM=;
        b=X0jwlYt1tjCXODKtjaB3g0ovE0UOCqe7oQIx0sAmD7weskDTFhjzZtb8jx6OJ2cgk0
         vyJhLQXoOn+lBhhBJdXOEhgnmH1ZMaZxszqOEDYAFQbzvXRKT7SojAHFbL/VJSoAdMF2
         oZnKh2pCRt1i/I9FmnKKTjgrpTK/zKv4G66Yndt6yeVjI5EPLhgZtKRUeq4CaLY8MTi5
         Cz1VGA5NTVuA1dsGu7WhBSRwi4EgAmkLbfskd9KHdBtEwtoFB/yqlW9uBhcZMp0I7/Jz
         VwVzdH8x0h2tANiSgctRGC/f7+Hx9Is2Fp9o0Z8LX2H5uQ7gjiJRX9AFydDXveaLQhuZ
         9jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsG921u+pQ9BumUOD8L4sLP8OotYRXEOK4U7+FA+bbM=;
        b=GqM4HKpQmR6jBLQEATQILtaVdkk620C5ox3PveEhQTqCgmseoHLHMX4PCAvZqdol9Y
         0HSjxJ1udMfUHTTgJdLcIGTEh4oSBjYD/xBAKpqLj1ddlUGMdcNSw4rlhtLgUk3V1rjt
         puBpjjm9p/mT/a4+4KeABxj5psqTRZnBykqvkZDWGAVzKiRB7C5UK9ioHbzNtyJyH1R0
         bAZHE5R0Kw2zuzhGsmdXVN0gZdFnjrnaRWj5TzK/u691h4r8jCEkktFAuMdA4oicOc7L
         ORctv7QyuO93wxvPLneprm5KqFdRzTMZH+YU/7DyWvVktsPRxkiTvur+ks1yDC34HTUo
         JC9Q==
X-Gm-Message-State: AOUpUlGkFcpWpk2IiBgShx1FhmzVrNb4+CrxKQDSAAKhj/hazaMNjWL1
        KQnznA95RkY+ZamhQNCfSssG3tQ2klSWIiKR3E76xEyF
X-Google-Smtp-Source: AAOMgpeXRIAlxEUomrZwScOnwh9Wau8JBvIFzKtfzo37/G7JCoWkqPLxXZIWlMJiCT+3V01UKaK5Yi2frwXiWF3TCvY=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr12108758jam.61.1532842027746;
 Sat, 28 Jul 2018 22:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net> <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net> <20180728051105.GA32243@duynguyen.home>
 <20180728095659.GA21450@sigill.intra.peff.net>
In-Reply-To: <20180728095659.GA21450@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 29 Jul 2018 07:26:41 +0200
Message-ID: <CACsJy8DTQhinpLOhojnrpFt3_2tVo3mo1Dwv-x4aF3mZJ2Rhgg@mail.gmail.com>
Subject: Re: Git clone and case sensitivity
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 11:57 AM Jeff King <peff@peff.net> wrote:
> > +static int has_duplicate_icase_entries(struct index_state *istate)
> > +{
> > +     struct string_list list = STRING_LIST_INIT_NODUP;
> > +     int i;
> > +     int found = 0;
> > +
> > +     for (i = 0; i < istate->cache_nr; i++)
> > +             string_list_append(&list, istate->cache[i]->name);
> > +
> > +     list.cmp = strcasecmp;
> > +     string_list_sort(&list);
> > +
> > +     for (i = 1; i < list.nr; i++) {
> > +             if (strcasecmp(list.items[i-1].string,
> > +                            list.items[i].string))
> > +                     continue;
> > +             found = 1;
> > +             break;
> > +     }
> > +     string_list_clear(&list, 0);
> > +
> > +     return found;
> > +}
>
> strcasecmp() will only catch a subset of the cases. We really need to
> follow the same folding rules that the filesystem would.

True. But that's how we handle case insensitivity internally. If a
filesytem has more sophisticated folding rules then git will not work
well on that one anyway.

> For the case of clone, I actually wonder if we could detect during the
> checkout step that a file already exists. Since we know that the
> directory we started with was empty, then if it does, either:
>
>   - there's some funny case-folding going on that means two paths in the
>     repository map to the same name in the filesystem; or
>
>   - somebody else is writing to the directory at the same time as us

This is exactly what my first patch does (minus the sparse checkout
part).  But without knowing the exact folding rules, I don't think we
can locate this "somebody else" who wrote the first path. So if N
paths are treated the same by this filesystem, we could only report
N-1 of them.

If we want to report just one path when this happens though, then this
works quite well.
-- 
Duy
