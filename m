Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9DC1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 07:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeHIJ7Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 05:59:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIJ7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 05:59:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so2424818pff.7
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oA/1tBQ6vh336WptPdyqTb6V366Vf3y5OnSIoTu6nAY=;
        b=RX28z9OHXqHf6HsgF0S2ZeKeiTxCkarxWqHLohQBJSALIBy+T+m+yYUCp4ecS0olOX
         NvbbMkAFaYlvjMiHESA/HLpg8SPXJfrdY6B82gp8Y/t/8zhVAHKKlRrrf6ZE6MWO36PO
         W+293h0SW4s52xkHkWuJc7P6tX846So0pPzM/HxhGFp1BUE7gpexTOfE5LoB0WU1uFup
         X9U/o7OTYihcBlXX2kPoQFa7JaUkOKgu7tOnKbAv0UN6+uIWQr2i3/LrLorYOQgDZnpA
         9bCLVRaH32K3mN+zwOOlPJYz9SVl+H2PEoPWHVzaRteI1d0bFlFdwzhpgmoyK48+FhaG
         XXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oA/1tBQ6vh336WptPdyqTb6V366Vf3y5OnSIoTu6nAY=;
        b=Ugvk/45JfbMki5bJ5eAxHm2U2l2ZG0WqlCv4bW6g/I/aW5awsj1Zp2v/gezSyBxGqk
         kQcXdSH8bTPDHYqAwMBqE4ivUqAhUXUXZ+BS+bS3Rtsuj9wU5omFpkSGP/rclBo9rmmp
         Sb5Jj3kVdgVuYlNTPUNuqgvk9N5ykUWlBFrsozpZnMxXHZbLY6chETFbAYYJ0D0K0Ehw
         NcQFk6elgf7rJRqix+6OvXkayWV392zUfz5aHxWpWcYKI0HmHBmDrvR2XgONe6JZqaxd
         q/J9+2lNASHUI0ZqW8EEbC6GkMGjiXkaszv4ukvn2tGp9e2kZ7xA+wga7gVR0DOMouM6
         JsNA==
X-Gm-Message-State: AOUpUlGTfQfSVs6RzzMwzEBqAd6cliVGwAKIeK22lXfzfrQU94Xk4KzQ
        1CR9PPgoTyVjh7eiVs56dVn30QeHlDIXmX1UtqPq3g==
X-Google-Smtp-Source: AA+uWPxvJHQq5vsEmrB+Tle2BMBSRnLKG1mgWGY+69ejt6b011tnu3wDEmM21e00OBLU9euwny0FQkQM3lJuQb0fiS4=
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr1182259pfi.196.1533800151567;
 Thu, 09 Aug 2018 00:35:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3541:0:0:0:0 with HTTP; Thu, 9 Aug 2018 00:35:51
 -0700 (PDT)
In-Reply-To: <20180808221752.195419-3-sbeller@google.com>
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-3-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 9 Aug 2018 09:35:51 +0200
Message-ID: <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] string-list.h: add string_list_pop function.
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hvoigt@hvoigt.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> A string list can be used as a stack, but should we? A later patch shows
> how useful this will be.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.c | 8 ++++++++
>  string-list.h | 6 ++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/string-list.c b/string-list.c
> index 9f651bb4294..ea80afc8a0c 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -80,6 +80,14 @@ void string_list_remove(struct string_list *list, const char *string,
>         }
>  }
>
> +struct string_list_item *string_list_pop(struct string_list *list)
> +{
> +       if (list->nr == 0)
> +               return 0;

return NULL, not 0.

> +
> +       return &list->items[--list->nr];
> +}
> +

> +/**
> + * Returns the last item inserted and removes it from the list.
> + * If the list is empty, return NULL.
> + */
> +struct string_list_item *string_list_pop(struct string_list *list);
> +

The memory ownership is now with the caller. That is, the caller needs
to check/know `list->strdup_strings` and know `free_util` to be able to
properly free all memory.

OTOH, the pointer returned by this function is only guaranteed to be
valid until you start inserting into the list (well, you can do one
insertion per pop without worrying, but that's quite detailed
implementation knowledge).

Maybe these caveats should be documented, or is a hint that this
`_pop()` is not so nice to have after all, but let's see what happens in
the later patches...

Martin
