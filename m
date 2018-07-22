Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FCC1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeGVOyL (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 10:54:11 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55295 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeGVOyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 10:54:11 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so20532700itb.4
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Svia0sYSeU6oeJsLfnvj4PgC4Yw3a0GVLo0BAmnyDPU=;
        b=JKoklTcraT2DlUiWP0BDN79K4AnXgz12G6NhXXCAaObFmBTlHQzK6KS9aJFyOFY8h0
         ZNAl/VaOG4Rfd7u76TyrBznVtMWMJ1pvsDT3XxeLwymN7HhQWi0xUbqnbYlfHGCvickc
         cCWbY5jJi52VBiUDRuWjbhNdn4lmCCKXavi8NfTlySykFF4t+xLFLLsN7wCA9SchAypY
         KoUsap0+r88GICU5W5AB4iwpUD2JHorqRsnUY5cIKGbEafoFcjUvcFa7LqkQLB3OBwFs
         Xi9ukpbHzPG4nRtV7tPOC266G8j/EGcwBgBtOUaihOpd1GQpCdEA2eS18m0eXuf2kput
         oc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Svia0sYSeU6oeJsLfnvj4PgC4Yw3a0GVLo0BAmnyDPU=;
        b=OnsvlBxFje872mtMlgl77I4E6ejyeoh1UUG7It/yvQIqJz+oc9q1fybQiYzl+kXDpn
         7McNR4k5nS1IFwzL8DTYZP+tcuEQ1L5nQ9jqkCezgYOiG/SnnxRBf0hcS19MVBJqpD+S
         uMkawKqYdgG9zX3MU2Djof7V5r0n1Zhpi8OKJKYeFqkURaMtcT/d20i74n1a5Rf5gMCW
         YT20LHa5B30Rafc9L8MFBP2L1r0Ym4NXSVbAyVLY0y4ojvd4OuH/jpy4da0jRsijf1/B
         ual0uCqh37HiQtV7mEe0SlKNdwgXdCeV30g9LG1YLyXVsP/7MYgpZq+UEOx6GVD84xqL
         NyGQ==
X-Gm-Message-State: AOUpUlE8qeqXEkc5CzQHSqqKPrvn24cDrSOgVFaCU8Jia6aXOT0mmKeg
        mvEXJYO66GG+miRM54DNBdpTcBuGaw+ANM9iWoU=
X-Google-Smtp-Source: AAOMgpfpsJTrydHBVNsocrXYAXjZWunSpeZ5e9VKC8z0v5LsQwTeGBDl1oRZPbsYKwsE9lrg3jq4hr0Btu1c86kgJsc=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr7144451itl.96.1532267844187;
 Sun, 22 Jul 2018 06:57:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 06:57:23
 -0700 (PDT)
In-Reply-To: <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org> <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Jul 2018 15:57:23 +0200
Message-ID: <CAP8UFD0K+F5D2q5UY-aX9tmtkqvgMiKf=bq+wE+yZuxzyQst_g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 10:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 7:51 AM Christian Couder
> <christian.couder@gmail.com> wrote:

>> +pack.island::
>> +       A regular expression configuring a set of delta islands. See
>> +       "DELTA ISLANDS" in linkgit:git-pack-objects[1] for details.
>> +
>
> That section is not added until 3/5 though.

Yeah, so I guess it is better to move this hunk to 3/5 and keep
pack.island undocumented until the delta islands code is actually used
by pack-objects.

>> diff --git a/delta-islands.c b/delta-islands.c
>> new file mode 100644
>> index 0000000000..645fe966c5
>> --- /dev/null
>> +++ b/delta-islands.c
>> @@ -0,0 +1,490 @@
>> +#include "builtin.h"
>
> A bit weird that builtin.h would be needed...

Yeah, I will get rid of that include in the next iteration.

>> +       if (progress)
>> +               progress_state = start_progress("Propagating island marks", nr);
>
> _() (same comment for other strings too)

Ok, the strings will be marked for translation in the next iteration.

>> diff --git a/pack-objects.h b/pack-objects.h
>> index edf74dabdd..8eecd67991 100644
>> --- a/pack-objects.h
>> +++ b/pack-objects.h
>> @@ -100,6 +100,10 @@ struct object_entry {
>>         unsigned type_:TYPE_BITS;
>>         unsigned no_try_delta:1;
>>         unsigned in_pack_type:TYPE_BITS; /* could be delta */
>> +
>> +       unsigned int tree_depth; /* should be repositioned for packing? */
>> +       unsigned char layer;
>> +
>
> This looks very much like an optional feature. To avoid increasing
> pack-objects memory usage for common case, please move this to struct
> packing_data.

Ok, I will take a look at that.

Thanks for the review,
Christian.
