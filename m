Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA24B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeDYOkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:40:09 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:46980 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754696AbeDYOkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:40:05 -0400
Received: by mail-ot0-f175.google.com with SMTP id t1-v6so6248486ott.13
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fhq+Lz904XZe7Nbg76OHu4uikRMl867k6PKob2dHYaI=;
        b=b74CDxKK+OhCqYL5YveXHwYSYXrLYyo5MhY4qY+f6AQcZsluH7pLqzEDOnACuOMw9R
         oBTNTDhz+jGHsMAEB1Dw2ZTFnbsP5wwK5BfcVcIpg0TSsbH8SXZ/l2OKstTSrUld1AFN
         wAo3pbt2NBa5mXeA6edQLiEzlWb2W2nipX8tBdRYiy7wIIFfZQ3Do0yGEt6rjNIB4e+G
         xMazGy7esiTNgCgSvBMc5gWhQiAN7eh3hH2oLVsI9Igi/p1tz276aqkImfdKKUJ8viYo
         IqD+qsSI1zQZYivLlskUmDUwC1CSSZ6terB80tWct93Dzbvv5CEFZF6Elws6RU4joyKi
         Df7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fhq+Lz904XZe7Nbg76OHu4uikRMl867k6PKob2dHYaI=;
        b=WzKTLzGZcvjJZJ7nbUuUDz3RseM4dPXe3m2mxckalIbtTEvvYPMwnGBOhcFAjlSHgO
         PWn42B1TvT9aLZLPCP3NqJ0y77XP1W0lb/NNDH53UkRxdlHxgx2vAZ8qhjuXDbYpxe8H
         ZUFQgEx1tK67pLQB7ZqElqN3Mi4KHwVEySMppq4p6pjgq5ZY4YtueFU44HKKknx0+ErC
         CGEh2pEQpFwHttvOnVOxlP/u/K8vqfadXmX5fcSD68MwwxncnwlhfwevfdgS2Cp6vkJ9
         dSEBvC5/M1KeV76TqnS0/OQksLWSXwZ500j6EOuhovnsYNi6jP+19pXoxgbRaKN5t/1l
         GYAw==
X-Gm-Message-State: ALQs6tD6FxOs+d4r8j86BNueOjK3d6Q24jhwgKxHD6esZeAy8W4ncVUQ
        vQC0mFCxwR97XaEwTAyOzTkqv1vAcbtOWZ/ZX20=
X-Google-Smtp-Source: AIpwx49mUamE64FKerScNlcuWMpmQk2PpcgsFg6HFUrrhfbU2StovrjoEP6dNHk96TGXNZGD8gXDiKLxDQgetGz3tQY=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr20947690otb.152.1524667204991;
 Wed, 25 Apr 2018 07:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Wed, 25 Apr 2018 07:39:34 -0700 (PDT)
In-Reply-To: <CAM0VKjmZeVF6GV9ZRXLdwZJJyFi8oLnGvKe7tQYi_QRLoAk4Og@mail.gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com> <CAM0VKjmZeVF6GV9ZRXLdwZJJyFi8oLnGvKe7tQYi_QRLoAk4Og@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 25 Apr 2018 16:39:34 +0200
Message-ID: <CACsJy8Chk5C8BgHsZfhYugBAAwzAUJXQLhq0EYmT2m9us6E6xA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 3:06 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> -__git_list_all_commands ()
>
>> -__git_list_porcelain_commands ()
>
> Users can have their own completion scriptlets for their own git
> commands, and these should be able to rely on helper functions in
> git-completion.bash to do things like refs completion and what not.
> Therefore, we tend not to remove or alter those helper functions in a
> backwards incompatible way, because we don't want to break those
> completion scriptlets.

What kind of "API" guarantee do we provide here? I don't mind adding
the wrappers, but for me it's hard for new contributors (like me) to
see which one should be stable and which one is internal.
--=20
Duy
