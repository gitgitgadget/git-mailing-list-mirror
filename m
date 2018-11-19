Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D123A1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeKTHnW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:43:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53045 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbeKTHnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:43:21 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so276390iti.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxwmgQ++KNmDLuWEohuEi34R6Hw6sEkCOyB6x6UDym0=;
        b=stzFuem1e6vkc53oq4LwQ27x3uYwgnJ9vHYnwNPwMxo0VLPWW/4EGaO343GsqY3DMU
         lPAq3KLhu31qwKrJ4LK7ZS3/yH/vZjFtjMfmAiXxQWoo/BNe0MhwXLIeyMXq3Z/t9w2S
         BK2YHeFRtFYUrhMai+YxQu3USSoP62yfjSseTwQXmKb03w4X0NbURsPZoLJxY44p+Gu4
         L9iUQiXTBXNSL/3xJACHSr5FNUkMgKJFVuJ5FwCYOllDRDHmMNo34wN3RYoV0hVPw4VZ
         RBqV0DGOrsxTRM14rdjgdVwqKK86jX5dvbKpfZy0Cu9Zv4f9T0O3RlPNnuoCU4ht6X+z
         LwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxwmgQ++KNmDLuWEohuEi34R6Hw6sEkCOyB6x6UDym0=;
        b=ZM5fQn9EBvSX44SyHariP0TRYj5uHIWm2k9r2XBYhKj3MQPiNloAcph17zuBt1FKtv
         /RadBh/zOrtfnkbb5dKyVea82OKGfbs1READu4MWiUaAL/5kbPRHKWH3hht6s+KlN4RS
         X1JtLkizVfX9V53Ih/qLEay7sPQGsUwG3OYqTafrALon9tD1IUFfzKzNvIpIKuKWqLCr
         mJLw1OM9C9DkQYQ55J4kPN217A/QsE+nElzqq/9ZTpEaeDQaXhzjuV0qP6o77WQpgCfp
         +Xai+QyEFDYTUX5th8+so0sbPD++l+kU3hZOpOMU65Tli7eMqnDHQKkuc1Rkpd9pcnSE
         t4+Q==
X-Gm-Message-State: AA+aEWZAiPrYJVcE4YktB5T1O5x3zezPeUUlVsYEW2t8KgmfhUtwhxgD
        rUuczCE4KlguHPfh4szASSS+7WxmXJD2zX3xEMo=
X-Google-Smtp-Source: AFSGD/XyYwVWyzGPLa/u7cDYgHpHKp8VHbHzT3tHsYvf3Ut3PwXx1+bKgnKHTvzA6yYEPZ13H7/fSpQP4e/NBQxqwvo=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr9790504ith.123.1542662270753;
 Mon, 19 Nov 2018 13:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de> <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
 <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com> <20181119210323.GA31963@duynguyen.home>
In-Reply-To: <20181119210323.GA31963@duynguyen.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 22:17:24 +0100
Message-ID: <CACsJy8Ac_o6M5DZDz6hwn-JGJLGdzK4wtvhAY4bwaSwPoix6Cg@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 10:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
> Thanks Carlo for the file and "stat" output. The problem is APFS has
> 64-bit inode (according to the Internet) while we store inodes as
> 32-bit, so it's truncated.
> ...
> We will have to deal with the same
> truncated inode elsewhere to make sure we index refresh performance
> does not degrade on APFS.

... and we don't have a problem there. Either Linus predicted dealing
with 64-bit inodes, or he had a habit of casting st_ino to unsigned
int, I cannot tell. This code

    ce->st_ino != (unsigned int)st->st_ino

is from e83c516331 (Initial revision of "git", the information manager
from hell - 2005-04-07) and it's still used today for comparing sd_ino
with st->st_ino in read-cache.c. I guess I should have copied and
pasted more often.
-- 
Duy
