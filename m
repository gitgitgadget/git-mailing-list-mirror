Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846511F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeCWRHk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:07:40 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:45166 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbeCWRHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:07:39 -0400
Received: by mail-ot0-f181.google.com with SMTP id h26-v6so6537224otj.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jbORmA6J7d03I6CGKJHXrcEELR5BKGuAsv8k33p0XNo=;
        b=EhRU9N+BnD0qMMgGOiwTpxbaaogdUbD6HC7J5Ki7Y7sIe4jMSpFQ4CesPEvtWRhH1m
         NgfID3PQFTJCQqfa3YoF4ZbX2v5VWHcimHihlvmWAUV/xQ3uxAAkzQjHH1QkAX480cLg
         Btce57zPyRu4RGUo8h8DGyDP7Mc8OfT+JWlkpkjTOMaZrOtD4ObFByXKMoRmR/9QELDK
         VE2c+2fTpo9n0mYN8TRDnTE1ukJglgDWvELiUfIa2JVBFXVkfw3vTknXFxZUXxF9AOGf
         QBqBdRoKkIV+oreOEnxe5PJ3fXrV4UAoImXikHjczpaJNHwghKOVa/owo+PS2cm50XCR
         Qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jbORmA6J7d03I6CGKJHXrcEELR5BKGuAsv8k33p0XNo=;
        b=WSQgW6YZt0eLbB4EOaLv1Ec5TufJRBhchpCdAg0KaymfbArQvEIZUMHbGzF2Xn9YfC
         7nZQgGSN3vaYt/z7DhOOZtyDmTQICHSUsEujnUf8OCspJOfPQ6khtpxHDir9P1peUsnZ
         wng/mY2t3FfcXCb08TFHNbp6RXgkq88IkGEMFP2DujDo1eVJnVan//3ZBQu10xpL18ja
         F/UQU3/0oaHpzCogZQss20EwQ81rVGlZjIAl3m/W14iYUn+qy24STdc0sg604e25MadS
         2a6dEsOHmPTktabemf97P2o40zCiifUQvkav9rXzhtUAdP6p2LirUsSxIAxoRfWYSoe8
         vT0A==
X-Gm-Message-State: AElRT7GQG4dnYhCK1jtE1F0YAN18qo6NJKLQbxmT4ShmGwhCoZId1wJv
        G75Po1xsSrfbp6PsFyitR0fo6tOQqRQdICn/LYo=
X-Google-Smtp-Source: AG47ELv8N0ACuEj/z0HIMZfApkzQmiVK7wNGzsoXx6Vrm8zmPnr0a4BOUD0jLIzNlcuhyonTPzsDfnPqRAMHUVkTFnw=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr19014865otz.65.1521824858944;
 Fri, 23 Mar 2018 10:07:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 23 Mar 2018 10:07:08 -0700 (PDT)
In-Reply-To: <CACsJy8As=iDtLm6GGxbeHB=VDUvOgefrSpBduY=Kq1O3D2x1Tg@mail.gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-11-pclouds@gmail.com>
 <20180321221842.GH18406@google.com> <CACsJy8As=iDtLm6GGxbeHB=VDUvOgefrSpBduY=Kq1O3D2x1Tg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Mar 2018 18:07:08 +0100
Message-ID: <CACsJy8BcHdvUn5VPc9+mzE1SpvsJG-P2iUW=jg2VD5YhU4kVJg@mail.gmail.com>
Subject: Re: [PATCH 10/44] object-store: move packed_git and packed_git_mru to
 object store
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 6:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 21, 2018 at 11:18 PM, Brandon Williams <bmwill@google.com> wrote:
>> You're marking packed_git
>> as "private"...well C has no notion of private vs public fields in a
>> struct so it might be difficult to keep that convention, it also took me
>> a second to realize that it was only in the scope of packfile.c where it
>> was ok to reference it directly.  Maybe it'll be ok?  If we really
>> wanted something to be private we'd need it to be an opaque type
>> instead, which may be out of the scope of this code refactor.
>
> It's true C syntax does not support private/public scoping, but it
> does not mean we must avoid that. Python has "private convention" with
> the underscore prefix, no special support from the language either.
> Yes having compiler support to enforce scoping is nice, but I think we
> can still live without it (Go devs live fine without "const"
> arguments, e.g.)
>
> So I'm going to make it clearer that these fields are not supposed to
> be accessed outside packfile.c

I'm not counting out the making these fields completely opaque of
course. And with your suggestion of not embedding raw_object_store to
repository, that's actually possible to do. But I'm still not doing it
now :) The series is getting long and extending its scope will drag it
even longer (in terms of both time and number of patches)
-- 
Duy
