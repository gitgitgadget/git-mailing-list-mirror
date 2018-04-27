Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34031F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758915AbeD0TMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:12:48 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33994 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758203AbeD0TMr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:12:47 -0400
Received: by mail-qk0-f194.google.com with SMTP id p186so2260109qkd.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cmWp/xdsTCbdh0dX9GVEiPDVdy3Z5ZRC7sEI2MM9gUY=;
        b=e1OAqHccmqY6WKkjDtKG4w7TEVFJR0OMlmGyB1zrTMHDgGlD2aGcoeUS71N2V3UGvC
         PB14McnF/KQok/AczNKRTW5jrB0nJi4p4AuCBv1PZb/4Ky4qwgbJGwhrvF6x4br2qApO
         9pow/0DD6H7SXkPCZYBv6QeQibHZKbFstn2K8Dx+Tfn+sV1IHkZbvuumJvtUYUjSLEuU
         qhg9zRyPvINcBD/d8nhGhtyUN8HL7zs7sF/jC20THH8bAh4WjN9VCO3J1f7YzX9KzNXj
         HbBakyb4VxykzwprFN2fUTLrGG6EzWg02XQC1odtZxCYSfhQOvu94URW7js23OqzrSXp
         yzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cmWp/xdsTCbdh0dX9GVEiPDVdy3Z5ZRC7sEI2MM9gUY=;
        b=FhpmTjzS3O9A/3wXUDCat/8zAclgWM4vF1ldI/3chje7uAyta7IS3rYf/1ZsY8IDPM
         k51dw6JIF4t+v+M3TR55xTdYOM4pUbUW59PRcKIgkyLOgJ8E8o+0ZoOdZ2IaA1h41tE8
         H3fakhSqKVAoUUzTaExj+xksVNiowqhZCxPjV475YtyftfK+J+7oeEgdMdrQGMxqjVKd
         5Ivm/FKI659tutVcaWWT34fd2Q9TEiGEr1uQdS3uuhUAKJq4O1bdbr5YfOd6gQwRSgUc
         ndxwBa2Bc4cUhyBWo6GhH4Le0946Wmm8lmTylSjPIPy9CGnt7Bu4BZMw16xZsj1Bi1fE
         sZZQ==
X-Gm-Message-State: ALQs6tCVYG3QuUC66l8HbOMsHZ63SIZJkyyPa9f5jyBFkvE2TGlUI0Gp
        vSWrMe0keqKAa7N45S9RaHXvwXgClUMn1XEyiNs=
X-Google-Smtp-Source: AB8JxZpCpn+41kdGvqXYGbkPoX3++qUpddI/aVRrpBa3y8EQ/L5/JhhJ62SvsTCTKfsObbx/oqNlszUsRR58qPn85zs=
X-Received: by 10.55.79.9 with SMTP id d9mr3039404qkb.2.1524856366619; Fri, 27
 Apr 2018 12:12:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 27 Apr 2018 12:12:46 -0700 (PDT)
In-Reply-To: <bb44e716-a57b-71fb-4446-20809ddb73d1@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com> <CAPig+cTM1J35hvwYwj9BOkFxw0tGQJFZjPL_WnCa=wDxzYzj0g@mail.gmail.com>
 <bb44e716-a57b-71fb-4446-20809ddb73d1@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 15:12:46 -0400
X-Google-Sender-Auth: nh3FL3FhP8D7TQZCzpsarOIH_YA
Message-ID: <CAPig+cQyVWXfLXGJO2JBxXTB1sT3ba_AukbKtaYwq8SjWcKq8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 2:40 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 27.04.2018 um 19:33 schrieb Eric Sunshine:
>> On Fri, Apr 27, 2018 at 1:04 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>> @@ -13,7 +13,7 @@ SYNOPSIS
>>> -'git diff' [options] [--no-index] [--] <path> <path>
>>> +'git diff' [options] --no-index [--] <path> <path>
>>> @@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
>>> -'git diff' --no-index [--options] [--] [<path>...]::
>>> +'git diff' [--options] --no-index [--] <path> <path>::
>>
>> Not a problem introduced by this patch, but shouldn't this say
>> "[options]" rather than "[--options]"? Since the aim of this patch
>> series is to clean up botches and normalize documentation, perhaps it
>> could also fix this oddness(?).
>
> Well, in the SYNOPSIS it is always `[options]` for all variants but in
> the DESCRIPTION it is always `[--options]` for all variants. Fixing the
> other variants would stretch the "subject" line of the patch a little
> bit to far ;-)

I wasn't suggesting that this patch should fix that issue (it
shouldn't) but that it could/should be done by a separate new patch
since it's a distinct change. (That's why I was careful to say "aim of
this patch _series_".)
