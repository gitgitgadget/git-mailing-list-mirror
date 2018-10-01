Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2B51F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeJAWJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 18:09:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33599 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJAWJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 18:09:12 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so9801523ioj.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R79GuV55dG+RGJCUrX2H4epJjKp0ncTpv6wG1TRV1is=;
        b=CQYNVNpNeVjCUTArvvFPlr+zDG8A++yPBeDhor/x/ck29l8vskRBl7tciZk0VbezSf
         f0+S+DdWe7Xo2UCdZO/HdQTvJMwc9gzO/5vsXxTUo0gd8KWnpvXN2ObMmOFnLzrKSD3k
         AI3/gHhGTTZUPzlOl3iI1oPXy+jcEQ0Hx47epBtuapd0VQ9yQ/siiKTIS5CHqIxIXhMV
         Wimn+T7BEyAJkmO/KcjqjdExdfZgjFhje1rfALY2s7FqQm+LKTv7NUDaq/jeRT0Zw77P
         CnPS1QCw2EOglKx+Yuy5EHqAQSrSikTV7252Wz+cFPyImiJgoJKPPEUF49qM4PaaBqR0
         q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R79GuV55dG+RGJCUrX2H4epJjKp0ncTpv6wG1TRV1is=;
        b=E8dhEayODtUBO/zoRkRUhXKBfumobz8F5MVA6fQac0DNHCHM8QbBm5LMAvXf1Xr9iw
         aa13s0UHNqT+X3J7W53RGjvakm0S4ezkWwMHZVzEVLuXf/b7W2ejbFh6xGEEomZ84fmp
         ifbkO8a6Nzm28iNVY9cdoWUzkGEvr7ijY0ii4QKM8GS4n1oNq0jh8+UajWLHfiEj3c52
         7nWUj0heRtbnIpi4D7z0uRj0mo3+SENGX0cgeCGh8HzcG06pLdTLfv0THJBEDkhQEruV
         FNzJlOaV+dSUJlzvDimxQEWqjsKDvMFhKygt657/hWSNCtDeTGgHRE6e4H/NL4m2NJAI
         hXog==
X-Gm-Message-State: ABuFfohFUUIJFwn6Ah/B8cGEwTlT3PPMUAX/6uK81eAdAGSw+uTC36dy
        s1aRUCYpRHFnsckA+j4Yj85N1WipGxNG4MFHauLkdw==
X-Google-Smtp-Source: ACcGV61uS4xUUr4d+NIVSPOOgcFZe9L+5fnmI7CO7M2HSSrpEla5pemBmIe2Dx8mH+lH4n8zomLNGw6jpBAn6o5RDXk=
X-Received: by 2002:a6b:6f0f:: with SMTP id k15-v6mr5913388ioc.236.1538407851800;
 Mon, 01 Oct 2018 08:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com> <20181001134556.33232-4-peartben@gmail.com>
In-Reply-To: <20181001134556.33232-4-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Oct 2018 17:30:25 +0200
Message-ID: <CACsJy8CX0TwVydzmqsjHK+W7tcaDgRCgeU3Gmc-bA1Ecf=Yz6A@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] eoie: add End of Index Entry (EOIE) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
> @@ -2479,6 +2491,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>         if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
>                 return -1;
>
> +       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;

Note, lseek() could in theory return -1 on error. Looking at the error
code list in the man page it's pretty unlikely though, unless

> +static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
> +{
> +       /*
> +        * The end of index entries (EOIE) extension is guaranteed to be last
> +        * so that it can be found by scanning backwards from the EOF.
> +        *
> +        * "EOIE"
> +        * <4-byte length>
> +        * <4-byte offset>
> +        * <20-byte hash>
> +        */
> +       const char *index, *eoie;
> +       uint32_t extsize;
> +       size_t offset, src_offset;
> +       unsigned char hash[GIT_MAX_RAWSZ];
> +       git_hash_ctx c;
> +
> +       /* ensure we have an index big enough to contain an EOIE extension */
> +       if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)

Using sizeof() for on-disk structures could be dangerous because you
don't know how much padding there could be (I'm not sure if it's
actually specified in the C language spec). I've checked, on at least
x86 and amd64, sizeof(struct cache_header) is 12 bytes, but I don't
know if there are any crazy architectures out there that set higher
padding.
-- 
Duy
