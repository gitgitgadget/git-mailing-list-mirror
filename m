Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9500B20248
	for <e@80x24.org>; Thu,  4 Apr 2019 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDDVzU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 17:55:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42968 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDVzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 17:55:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so3638050edc.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eyE/9BobmcdeV6zSZk8TPFbJ5BBBYboyVbhVzV8EO4=;
        b=bhj774Puj5BinUfVHtqsKr3zttwsCTbacmnAL6wuAiZeQ9U8P3MyZzcLyF3FawM8wz
         bal89RhUDoTT3SX7zOmHR+EBKURyuGM6ZcIm1DkHRYw62Z1Faweb28IoiTYRTSm8ZATo
         RvxO11CUKf3vTinvsqyU5empGmRd02ariM5K7G9+z1YAeAcB6K/UxM+PGcNf1mISz99g
         99uoYSOltza2kreoU6VdKfyCBdNLlnOUzWcZqYl2euY9D7dUo1teya8kaWy36NNvZhzk
         Edy9uwdJN7qRm3f4/iDEkKLExhgMehsTeeZNE5TRlNKt7D2suabrm7AcSWjjH7zmvVEb
         CLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eyE/9BobmcdeV6zSZk8TPFbJ5BBBYboyVbhVzV8EO4=;
        b=UhYZ9fpUBmXrkE6HlsC9j/bsEfH4qcAF7vssiD2ffywcTr3/Yzs9+RuUPmmuTrZk6E
         e89w1YoKkMe66XPwx18lH27i6JEDEVpGg6DQuCUr5j99Z7Ppn8TIl7c4M/YMLVcCihgU
         DrUk9TWwAUfQU1UmE0X/J/LQwLxerFwwbeTJOXwwqBODllO++BcGxTrcu0pz8hfw8Xop
         3vkzAWFX4fKcgYOn2aJ7F3X5GLu3RQRJH5N3ArNQIz8nH2l9kz48bXkgMU+BZq4KT3jD
         R9FB6WaCZFEtqFGPZkTgbz+yXp55m3prt0XAZ4QZMup2S2JG3UpeMANfKx5GHPS/JHyp
         Anpw==
X-Gm-Message-State: APjAAAWI82cQ1Wz8Z1Wq3wg1yNvCdEWj/Th/rCQw0pxdGAChA5gOyKjC
        GW0QNovVhCdghpXHmZnZoxShK8VqmU0+MgmfFr4=
X-Google-Smtp-Source: APXvYqxHCuI8act5yYynMY8u/5rwTsoe7wjYvbqtdpnYgj+SAbS/vUf0i/3UdIFJFpO8zFa16dYuzUIQvHbmGtSjZ7c=
X-Received: by 2002:a17:906:4d85:: with SMTP id s5mr5104790eju.18.1554414918407;
 Thu, 04 Apr 2019 14:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <0830dd3a-551e-8d74-18cf-288ef05ec287@ramsayjones.plus.com>
In-Reply-To: <0830dd3a-551e-8d74-18cf-288ef05ec287@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Apr 2019 23:55:06 +0200
Message-ID: <CAP8UFD267N_zaomOD_-_1YnyKpGu7jDuEjyRW0sc3Y6Wjo2xRA@mail.gmail.com>
Subject: Re: [PATCH] promisor-remote.h: fix an 'hdr-check' warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Thu, Apr 4, 2019 at 8:59 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> If you need to re-roll your 'cc/multi-promisor' branch, could you
> please squash this into the relevant patch (commit e52d417b57
> ("promisor-remote: implement promisor_remote_get_direct()", 2019-04-01)).
>
> [I had a deja-vu moment writing this - it seems I sent a very
> similar mail about 3 weeks ago. ;-) ]

Yeah, sorry. I don't know why but I failed to notice your previous
email about this.

I have integrated the change you suggest in my patch series so it
should be in the next version.

Thanks again,
Christian.
