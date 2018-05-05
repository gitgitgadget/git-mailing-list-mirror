Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AB9200B9
	for <e@80x24.org>; Sat,  5 May 2018 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeEETIj (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 15:08:39 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40557 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeEETIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 15:08:38 -0400
Received: by mail-qk0-f180.google.com with SMTP id h138so18358219qke.7
        for <git@vger.kernel.org>; Sat, 05 May 2018 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQiCB5gvdsMj1Mt+QZAiIqzLttbwltasuUf2CZgcEo4=;
        b=Z0GTMQK9OExfG6LVClqBZFoDun6QGttHds7o+Z1iwTDJGVYe2vV/zF7ZbXui/699cy
         x6Q9OdwJ/BZVsd77j2WVaxgpOwqU5FLaIFpvC5qXw+XDi74SMx4Q/IkGHDF3osbB8IlI
         eiJq0k+qHeInBamrzUIjce6/AgeYBLXGz9x3NWF8AI6q8sDT8FiC8j6H3lymzgiDrCG2
         423ozzecdLTwkPS2wsDLWxeTr1EVpAiGCPDRnq43gNcWGuMqrfzKNFfyJh1N6viZNK2f
         O1H108fb6EoofR1leb9e/yx7oFiJunUAXA2fFipFEZIu6iYdHBFresx2s5IySTyVUnRc
         0xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQiCB5gvdsMj1Mt+QZAiIqzLttbwltasuUf2CZgcEo4=;
        b=DydMpV7A99H/JnBnyxhrdMssSTqtIgG/QGxU+L3zlewUKlQL78eejdw2X/Yr+gx1lb
         1goszppBufv2RDpnjyC4w/Fm6jju5BvAQW0raQzdlTYUaWGlFOX/9uoKhnsR+jh6GhjO
         Jz3xckDxUIvV/K/JvGbVwrXhMqJGVo86/rARqo24Dc6pXOT5gsC6v5Zl7Ava6zPqWZxz
         K3wKGYJ/cDJ1+vsBD1dkvACHYbKJZvtE+kccnYAKJh27PWKYkS1SVMLH7WZTxMYtKl9q
         1PunqPwlvBZJs2mGQ98Ny/iO0JiUz+T9Yt5DlFEC2HrPxM+MPQ110Ve4NgnOt3qYErOf
         ft7g==
X-Gm-Message-State: ALQs6tAdT5YEqb5X8z7X64tcmjVkq4araONfmupL/prakoFTzFuTlZpP
        hKnStKNle6XQ7bDJ2ODI3DSi0XN0swiVWKrepYc=
X-Google-Smtp-Source: AB8JxZo6+lFQCOuZakL6tAZBRKuzdlLmVciCgROUKiDTEiNRkIkOQKROuM3z07M4u3jxhGYypWMA/+MLVhD6t01ZUl0=
X-Received: by 10.55.78.215 with SMTP id c206mr22339160qkb.207.1525547317411;
 Sat, 05 May 2018 12:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <cced9e2c-7d02-47fd-109a-1185eed13e63@gmail.com> <20180504182646.7738-1-martin.agren@gmail.com>
In-Reply-To: <20180504182646.7738-1-martin.agren@gmail.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Sat, 05 May 2018 19:08:01 +0000
Message-ID: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
Subject: Re: git update-ref fails to create reference. (bug)
To:     martin.agren@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twopensource.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Martin for the quick fix.

On Fri, May 04, 2018 at 08:26:46PM +0200, Martin =EF=BF=BDgren wrote:
> Anyway, that's not where I'm stuck... Regardless of how I try to write
> tests (in t1400), they just pass beautifully even before this patch. I
> might be able to look into that more on the weekend. If anyone has
> ideas, I am all ears. Or if someone feels like picking this up and
> running with it, feel free.

In t1400 `m=3Drefs/heads/master` is used in the majority of tests. And
this issue doesn't manifest itself if refs are being written under refs/

It also seems particular about having the "old sha" set to 40 zeros or
the empty string.

So I guess we should add some extra tests to cover the variations of
these two cases.

e.g.
     test_expect_success "create PSEUDOREF" '
         git update-ref PSEUDOREF $A
0000000000000000000000000000000000000000 &&
         test $A =3D $(cat .git/PSEUDOREF)
     '

fails/succeeds appropriately in my limited testing.

I am busy this weekend, but can try to write some if no one writes it
until after the weekend.

Cumprimentos,
Rafael Ascens=C3=A3o
