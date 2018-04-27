Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410F51F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757856AbeD0Sph (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:45:37 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34476 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757523AbeD0Spg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:45:36 -0400
Received: by mail-pg0-f50.google.com with SMTP id p10-v6so2197373pgn.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGmtY9SStaIN3de88kcjmdM0w8/cQJFuWcUtLjgeWDc=;
        b=fUNIzpOo9J/xyjq0XzQfgvu5qwbmfcxaFYew/m4LhTSGz0iZqAJ9KxOHs4z5dV6iML
         XS04Q5uicwNNVw7Jhznw8/TO/kSdo4xtxObwtkj7ncekhdw7qd1lsHs2WkUk28QK9KIx
         pjjTFmDd29v1ti1QQx8SHY82TCb9jsv9HHgZWvcxkePN6ZSHGAhQdfZ1Mj5fPHNiaJQV
         NU/TDyGjOgyPNcqz+rkB5iu6gwUIDAZgnRhf6GVMhQUE9uIoUQwkCtFArQxc+mMLuasp
         HqN8oy4guqooIVqG8LfBy9n7ZltxY9qubgxXh7xt4v0LTuYJEnWuq3TcbYQTEUdZ3ss+
         MfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGmtY9SStaIN3de88kcjmdM0w8/cQJFuWcUtLjgeWDc=;
        b=WDL96WzpW/dtuy0tBxc6xXFFDOQnLd+MII338LZxpp4/cmaD3+7NXWG6Se5G2ey9R2
         BJb8rMVfG78S7kqwSKxVxjYUw77+DGJ5BbZE8/uwhbP0wTv0hsJuMMHK5PVYqCDECVi8
         QHCx7K3eJQao4MUO5PgQ8nIUisFmY5ZATQTyeI7lwquGV1dUGZnJJVsp+7zKOojZg+t7
         1w6DRAPMown1k14XKDjs2LzL+ETBHhmP1ra2sbJ3ErIz5Yfh7OqesQwU5eyx1PutbCCD
         lpI32FdUc6RUkaNberhkznAYbLXsuxjYpf6OsmPhkc2+F4B1uSBAQ2yRyNFIohXArsL0
         vZ8g==
X-Gm-Message-State: ALQs6tAS3fl0h5Z3mrzVH7n7egEthcY2PcmrmeJAJz4HUg5zS0o2fpEn
        7eEw1gBjIDNr771PhGQDzLH2ag1SFM+tuQiNihk=
X-Google-Smtp-Source: AB8JxZq6DcyHWYnUQnOUsr5x4ZjqZ1j6/LdJF0f2qJMF8AhIsddQmTUxugWM21VAbPw/u1O81TsVASwo6ngiPSSHrnQ=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr3243331plb.298.1524854736042;
 Fri, 27 Apr 2018 11:45:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 27 Apr 2018 11:45:35 -0700 (PDT)
In-Reply-To: <a3253c99-63a4-22bc-53a0-4d94c01a564c@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com> <CAN0heSpdc51+7-uWcLVXU72qLZgZApdME8ywBJaQQy4DiWHAfg@mail.gmail.com>
 <a3253c99-63a4-22bc-53a0-4d94c01a564c@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Apr 2018 20:45:35 +0200
Message-ID: <CAN0heSquZ9WGQE=SCZ0DkgsbKPc80r5TmYhNXOGKFJ6MaJ_sOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 April 2018 at 20:28, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 27.04.2018 um 19:18 schrieb Martin =C3=85gren:
>> On 27 April 2018 at 19:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>> The two '<path>' parameters are not optional but the option
>>> '--no-index' is. Also move the `--options` part to the same
>>> place where the other variants show them.
>>
>> Should this commit message be updated after the changes you did to
>> address Junio's comment? This text suggests you want to place --no-index
>> in [] (and you did in v1) but you do not do that below.
>>
>>> All three items are already correct in the synopsis.
>>
>> Same here, now you actually do change things there.
>>
>>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>>> Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>
>>
>> Strictly speaking, my Reviewed-by was on another patch. I do find this
>
> Sorry, I've added that trailer after reading "The diff LGTM.", then
> applied Junio's changes and forgot to remove the trailer.
>
>> one better though thanks to Junio's suggestion (except the mismatch with
>> the commit message).
>
> I'll fix that with this:
>
>         doc: align 'diff --no-index' in text with synopsis

s/with/and/ since they both change? It's not that the first changes to
match the second, but they actually both change to match each other (and
to be correct, obviously).

>         Make the two '<path>' parameters in DESCRIPTION mandatory and
>         move the `--options` part to the same place where the other
>         variants show them. And finally make `--no-index` in SYNOPSIS
>         as mandatory as in DESCRIPTION.

Great! Junio had some good reasoning about how --no-index is
sometimes optional, but not always. Not sure if it's worth spelling that
out. (Although one could argue that it already did trip us up once. :-))

Eric's point about "--options" vs "options" seemed right to me. If you
address that, note that this message says "--options".
