Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E50E21847
	for <e@80x24.org>; Wed,  2 May 2018 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEBR6i (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:58:38 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:33795 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeEBR6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:58:37 -0400
Received: by mail-ot0-f180.google.com with SMTP id i5-v6so5936956otf.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+xKkSsCXAokhGtJUD97dwWFWiUqUsR3I7Z2Q3Esu00s=;
        b=E5L+OPFJQnYhgU9wSehJMhCJ2puF8M7Nhbh0aKk4fTNs6xn+EYKThnsNck2YLPF/Cq
         0u3O3XIi5ASCRYWQszEXqbwMaacfdSC5efsELgHMWaHJhKHdLbUPQOAAvXsg/1I9MNRt
         MB/lO2ZmURWcuO9fiFBsem3IrvH8i22HCsb+LaDfdR8LeMPk+AYewlKyIZmRDORaQH4P
         AR+diXpqtNDJzwyScnkWcEZOIWEDp7fJp4wA/H/a+Ma1qyPP2tqcAW1A0lxPBqMbKbZg
         cmbFo723T5FteVq08epwZR7zasS5fp6AAOOiSMyHC9ke4LIlcwYUIfV976LW4K6Eau45
         t6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+xKkSsCXAokhGtJUD97dwWFWiUqUsR3I7Z2Q3Esu00s=;
        b=fcr0BBdCpyC7grwqXMYGeTu/ZyJMbNzcDon4REJs2dGBSM669JcsSf4D12bhoACfqz
         GWJnrp31eMzyAHBhamJEcY0YrL+dBqrwZkDyrVc/DYQ++RtCsPNIxc8zsCm7KY/k5ieJ
         Oesa5fVeC9U45+bk94pEhJec1VyE3HVUioxXq2uKrz4O0MTLX6MrFZQ/cBj3G5eEJgFq
         pzMBgSoRVmCH1Jc0oSVSp+RhdXCJCu8ZCCaJYLpaYqmNLKhbLO4hdZFnvRLan24ZqO7I
         ba39IM9ZisVtdlFeO7a38eTmCnFU23QDxq6jN7nhJM/Kqpn73T3THUBMViCJnpAOPgwS
         /pnw==
X-Gm-Message-State: ALQs6tAIAA3Jmzrha3x7chel+2w/xkt5akP5TcUh7yiPkCQfA+2Rlb+h
        4uUsZmwQt3jCVRYl8xCkqJ0gqeOvU/GSkFvJpAQ=
X-Google-Smtp-Source: AB8JxZorA59RS8juQrARlvgd6i8nvzpm3lR+o7hyIrZjP9LQ1vSR19++Q2llCRPxYzIM9uXxUcqE1V/jc6DOYuUOvzk=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr15557263otb.356.1525283916974;
 Wed, 02 May 2018 10:58:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 10:58:06 -0700 (PDT)
In-Reply-To: <CAGZ79ka6p33W8msji9kFMaWGOuDzSyx=y0AFPaQSX_08AZSgag@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-2-sbeller@google.com>
 <CACsJy8CgX6BME=EhiDBfMRzBOYDBNHE6Ouxv4fZC-GW7Rsi81Q@mail.gmail.com> <CAGZ79ka6p33W8msji9kFMaWGOuDzSyx=y0AFPaQSX_08AZSgag@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 19:58:06 +0200
Message-ID: <CACsJy8CouvcppoHDEG-PvpuKh9b-r5R1j4Q6HaJ8XPb1G8FSNw@mail.gmail.com>
Subject: Re: [PATCH 01/13] repository: introduce object parser field
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 7:26 PM, Stefan Beller <sbeller@google.com> wrote:
>> Another suggestion is object_pool, if we keep 'struct object' instead
>> of 'struct parsed_object' and also want to keep current allocation
>> behavior: no individual deallocation. If you free, you free the whole
>> pool (e.g. you could run rev-list --all --objects in a separate pool,
>> once you're done, you delete the whole pool).
>
> That is what the following patches will be about, you can
> only free the whole set of parsed objects.
>
> So if you want to do a separate rev walk, you may need to
> instantiate a new repository for it (ideally you'd only need a
> separate parsed object store).

I'm not sure if it's a good idea to create a separate struct
repository just because you want to free this parsed object store.
What if updates are made in both repositories? All the cache (well,
mostly the delta base cache in sha1_file.c) will double memory usage
as well. Yeah not ideal. But I guess making rev-list related code use
a separate parsed object store is no small task (and kinda risky as
well since we migrate from global lookup_* functions to local ones and
need to choose the correct parsed object store to look up from)

For your information, there is already a good use case for this
wholesale memory free: if we can free the rev-list related memory
early in pack-objects (e.g. part of repack operation) then it could
lower memory pressure significantly when running on large repos. This
has been discussed a bit lately.
-- 
Duy
