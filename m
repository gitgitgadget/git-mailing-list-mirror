Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D724B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIGXb2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 19:31:28 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38041 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGXb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 19:31:28 -0400
Received: by mail-yb1-f193.google.com with SMTP id e18-v6so5814103ybq.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlw416jEW4ZBsgGA79rEi3jOvHcs8RGM18rg5Fjjsa8=;
        b=GyM65W6hlDYP7IuQZgu8m1qq1PKn/BYtxoXfYAJlqCnRhBwLpOwpLKaEAEfi2dvDYg
         6m3l38nVWh10Gk8Bll0C9yrkOQj44Q+IlE2QSjyUjDlZoGaTWZjLBeYmxXlgArH1UOy+
         0szd8JwzLYPc6fgs8/1SgyPQfLDTN7Ws4qaaJy3QByWxRRIcodZcPnyySbQ79vt/w4mU
         GNuernrCC1ftSDBkvv70ueEBdvLZ9jEf2B11KeHMqIY3hdYDp2PKFkHMi5YSiAYy8xy1
         FGeSBDEJYwtvbcvz0QjSVTsaiQSU9RrwPd3WjhWYFcg4LsQYD4l0AxuwyZbgq79b3V3t
         xJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlw416jEW4ZBsgGA79rEi3jOvHcs8RGM18rg5Fjjsa8=;
        b=qcccrTOFfRiZfmkyR0COYYchiTSC5BSknoq54bWYJL/g7ncuH+umZbIgo9+gf9HxhW
         OcS/UUPaEJqGa1NgbU+0xlvXaxiSoHnjQEoGoyM/EGhvg/dQgzOGPl4+GU/Uds6bptXx
         CB/5eM+B8FmXZcRXvqekcWkMckQ5iFW4iv0M+6tBvvt51itxNCadsvbb0lQEd78lHUVU
         2gySBTX5u+Q0Yq5wA8C7rnGTkMlnPQtYMEiEUnXQ4+SdHEbpG3z/fHgY8mb1u0CtITtE
         LV5A2KHslhjcOlHqpXjDWQO9hRs6zQwI26uDNg4G2CfABmd+DpYigQlbDQLDN1A5ZIFV
         C5Uw==
X-Gm-Message-State: APzg51BuUn0dltZT9H4Cyt1gJxCJTnEH3Kg0hHpxKNcXfRT7onFf9EXl
        2XJJfMurRDFPFS0oVW6wDBgnJVlSX1Uuu3h8V7QqpUGs
X-Google-Smtp-Source: ANB0VdZsXuDdu0nBNoRyiwIJ/uw/f9xFa/Iq6UUyJgEHQl0p19yYIW89YUjCzQmezqiS/3gqSzVB5VZEjVjZPwjU4k4=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr4623977yba.493.1536346153196;
 Fri, 07 Sep 2018 11:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180827221257.149257-1-sbeller@google.com> <20180827221257.149257-2-sbeller@google.com>
 <20180905191849.GB120842@aiede.svl.corp.google.com>
In-Reply-To: <20180905191849.GB120842@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Sep 2018 11:49:02 -0700
Message-ID: <CAGZ79kb0VEDxe0TAMf66nWk3pYMPxrpb_zFmoU4gezzswM5XSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git directories
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 12:18 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
>
> > This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
> > works with broken submodules, 2017-04-18), which tones down the case of
> > "broken submodule" in case of a missing git directory of the submodule to
> > be only a warning.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  submodule.c                   | 16 ++++++++++++++++
> >  t/t2013-checkout-submodule.sh |  2 +-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
>
> I don't understand what workflow this is a part of.
>
> If the submodule is missing, shouldn't we make it non-missing instead
> of producing a partial checkout that doesn't build?

No. checkout and friends do not want to touch the network
(unless we are in a partial clone world; that is the user is fully
aware that commands can use the network at totally unexpected
times)

So for that, all we can do is better error messages.

Stefan
