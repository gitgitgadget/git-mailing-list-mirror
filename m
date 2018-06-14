Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A1C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeFNSKA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:10:00 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33532 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbeFNSJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:09:59 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so2464402ywg.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrNMZkFJyh8wB2MmUwSO7SHI0qHdPVt5uB1KPgT8i+w=;
        b=RZu00zD4QWwfSrV5EiWji0gQFKhfj01Tpry+GruhNuiyuwDU9096iCkMuyxAtBIOgJ
         hUbhVpuUtFyBzoVA1XZB/3uhVgZ+e94nTc8YS/xfvsVcW25sO/4WQrE7xTfGBvDHNKRn
         DKNYbFmXYxy8uAJ4Op8PZSq1SaYmZFXG1nIzLxSlzGUVEUiZf1c/SwWGz/hzWSsZ6ZTd
         mYuFihrKR0GdXXCJy8mthbYtKP5YWlm/2f8LQv1VBxbhAmf+kfJMxneDmTS1sOY6+Koq
         Jpy6G8Q+UwF3yu3OE0yslHScxaDix/kgCcDkG43HXRgpcU0UPRpnIMWMXNdoh1ZKyJOv
         rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrNMZkFJyh8wB2MmUwSO7SHI0qHdPVt5uB1KPgT8i+w=;
        b=uKvlmH3HXRi1wdMXmgaZPnBEKhIQZ2P9c6a5R678kz2fh7EddPgAiSSNdwp9PpBV/L
         ECw6DK3TRxQ/V287OtQxDg2aOvjvOjRv2YWX/RfCu2+31RYhSgnkcVHJQQe9nCtvt3xS
         jyM6l9YuvtXjpDyrAC/TaqAyaf36WCuxzgebAwaxyUmZpDSol9E8PdNqX5CaqMT5BZDm
         ayLmNmlbhlKupJeyHrh4esfpIUj+H8IqJVuI8gt6c2zvXaOwDg377grwCWvkMF7Xeih3
         8Vo/fbpnKN8gwA83drhxTLV2qo+/T0N39GHJvonsDz8w82gakhqkW8Rqnc5ywU268Bng
         VC2Q==
X-Gm-Message-State: APt69E3pXp2QPAv8798kugrNliIPi6OGol27SGARoQBIPVEwO8ysxGHb
        nDx7wKo/yIu458qtNRFlG3buc1GZwPBRsIGF592bhw==
X-Google-Smtp-Source: ADUXVKIuwVf08ahYmURgg2c2O31WkH5LnvJb5xjwIss9D0UONk1pdCJ+/qhwf6rVRIS0W0iRdQpyWpdTKfdYGKrAdWc=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr2008158ywd.500.1528999798619;
 Thu, 14 Jun 2018 11:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-2-bmwill@google.com>
In-Reply-To: <20180613213925.10560-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 11:09:47 -0700
Message-ID: <CAGZ79kbThoJBriGOQnEBOr73NPKsz91x1W_ZgJLSi=hgYD5b+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] test-pkt-line: add unpack-sideband subcommand
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
>
> Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
> enable unpacking packet line data sent multiplexed using a sideband.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  t/helper/test-pkt-line.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
> index 0f19e53c7..2a55ffff1 100644
> --- a/t/helper/test-pkt-line.c
> +++ b/t/helper/test-pkt-line.c
> @@ -1,3 +1,4 @@
> +#include "cache.h"
>  #include "pkt-line.h"
>
>  static void pack_line(const char *line)
> @@ -48,6 +49,40 @@ static void unpack(void)
>         }
>  }
>
> +static void unpack_sideband(void)
> +{
> +       struct packet_reader reader;
> +       packet_reader_init(&reader, 0, NULL, 0,
> +                          PACKET_READ_GENTLE_ON_EOF |
> +                          PACKET_READ_CHOMP_NEWLINE);
> +
> +       while (packet_reader_read(&reader) != PACKET_READ_EOF) {
> +               int band;
> +               int fd;
> +
> +               switch (reader.status) {
> +               case PACKET_READ_EOF:
> +                       break;
> +               case PACKET_READ_NORMAL:
> +                       band = reader.line[0] & 0xff;
> +                       if (band == 1)
> +                               fd = 1;
> +                       else
> +                               fd = 2;
> +
> +                       write_or_die(fd, reader.line+1, reader.pktlen-1);

white space around + and - ?

> +
> +                       if (band == 3)
> +                               die("sind-band error");

s/sind/side/ ?

What values for band are possible?
e.g. band==4 would also just write to fd=1;
but I suspect we don't want that, yet.

So maybe

    band = reader.line[0] & 0xff;
    if (band < 1 || band > 2)
        die("unexpected side band %d", band)
    fd = band;

instead?
