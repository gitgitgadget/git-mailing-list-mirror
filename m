Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABE1208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdHLOHw (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 10:07:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34961 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdHLOHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 10:07:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id l64so5260265pge.2
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gZ9/LaU5vR37SdVDCgle3bR+NE3UlCdHqyugV8YnrIA=;
        b=IHZf5ZjssSOTOhiPIRKMnZQFi9JfPE3I60g1xeRItzhxaPhTSaqRwk+VQREBwfShp8
         FZSEkKsULAOrULso+mFIY6mghiPL3OLEgLTaaHlTbeBZf/5yFM18BYcbAF3LOBj/2nvr
         kC4IGLhi4wAyKRRuyISquS/BxJpySjfSMHDs8EljKTLWoo/3QKidWBqr7aPp6c19QQ7M
         mGLt8Ht2kVSSicF4SW0PZVm0HnnnTIxOr9p8jbh4x1RgZCzhiI87uEihapiL0tIyfnxp
         64aJYNpnThgC2Ms9IXXITsMkOlZ97kRDUZ3MFfiFpFEKl3Dc0SqIfmsh8WhKpD3hNxXJ
         codw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gZ9/LaU5vR37SdVDCgle3bR+NE3UlCdHqyugV8YnrIA=;
        b=reiTb2ZUEKoEvsnqs8VWSHlXwsBAGY2s8Lh4iLHASrUYArbYdYRRmimelhDfNNbADV
         Z4GDAtu2JrrMUrUwkq/+dT1dZFakXnfA3d+tiRhuzII2yPWY7ObjoIb59YUfvYiZ8sb5
         Hio6nVnN9BcSdkmFaaSHiDB0bhIinFB5hwpxeUi0IBOL/C3D0iBdBsHHnOY7at2w4tBc
         jr17TAK9Q9k3H//h7N9ak4NmI/1VGmfWyJD7F5v73m8XFHSiE+TrGRM5zO+oW/UeUqy7
         ccvehQGRA+s2CMZQUeygVf64PYAkVvU6xpL+gqQM8o5oz+VKAgiuC/BILD6WOLj+SzDJ
         2+JA==
X-Gm-Message-State: AHYfb5h2RCDdNnPCss9sjklFgvtixheePUFvlBqOPVu2hiexbS5Qe2CR
        sbexhCyve1Ai2hFz5QJsuqsb0HIGZA==
X-Received: by 10.84.129.6 with SMTP id 6mr21825075plb.289.1502546870559; Sat,
 12 Aug 2017 07:07:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sat, 12 Aug 2017 07:07:50 -0700 (PDT)
In-Reply-To: <1502527643-21944-3-git-send-email-martin@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause> <1502527643-21944-3-git-send-email-martin@mail.zuhause>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 Aug 2017 16:07:50 +0200
Message-ID: <CAN0heSpViT-Nz8OO7Bww3Fbm=mzA6wvm0EfgfRjsz+cVfvu3Yw@mail.gmail.com>
Subject: Re: [PATCH 3/9] Convert unpack-objects to size_t
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 August 2017 at 10:47, Martin Koegler <martin.koegler@chello.at> wrote:
> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---
>  builtin/unpack-objects.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 001dd4b..0d8b6b3 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -31,7 +31,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
>   */
>  struct obj_buffer {
>         char *buffer;
> -       unsigned long size;
> +       size_t size;
>  };
>
>  static struct decoration obj_decorate;
> @@ -41,7 +41,7 @@ static struct obj_buffer *lookup_object_buffer(struct object *base)
>         return lookup_decoration(&obj_decorate, base);
>  }
>
> -static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
> +static void add_object_buffer(struct object *object, char *buffer, size_t size)
>  {
>         struct obj_buffer *obj;
>         obj = xcalloc(1, sizeof(struct obj_buffer));
> @@ -93,7 +93,7 @@ static void use(int bytes)
>                 die(_("pack exceeds maximum allowed size"));
>  }
>
> -static void *get_data(unsigned long size)
> +static void *get_data(size_t size)
>  {
>         git_zstream stream;
>         void *buf = xmallocz(size);

"size" is handed over to a "git_zstream" and goes through zlib.c,
eventually ending up in zlib, which is outside Git's control, and which
seems to work with "uLong"s. How do these kind of changes interact with
zlib? For example, I wonder about this line further down in get_data:

if (stream.total_out == size && ret == Z_STREAM_END)

If total_out isn't converted, I guess this would never hit if "size" is
too large. And if total_out /is/ converted, I guess we'd risk truncation
in zlib_pre_call in zlib.c. Maybe that might cause Git and zlib to have
different ideas about how much data is available and/or should be
processed. Maybe we could then hit things like this in git.c:

if (s->z.total_out != s->total_out + bytes_produced)
        die("BUG: total_out mismatch");

I am not very familiar with zlib, so apologies if this is just noise...

Martin
