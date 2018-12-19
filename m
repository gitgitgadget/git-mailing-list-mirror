Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBD61F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeLSVxE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:53:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46394 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeLSVxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:53:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so18699210ljh.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d94sngjmVln7SimPQLQ1oweOpklEvyv6YNarlMGIQeY=;
        b=dl0EwwhLORTwTY6eCbyMl68Eej0nABVolyAZt37IO0lYzbCj06YJB1usHWME4biive
         zXspom7OIgUzlH0i7Jitkalpyj8d1gYty/GBMv4u46uGs6VPeCufeqrRTykRSSOjw06W
         qBRjh4aC6vkbrKhgu2aTA/jyWPitPtV2zcbdQLkJaGO2JolMaI7pkjcH9xp8Oy+D8S6l
         EJa8q4xqY+HAARi3dfR1JiAhTg6c9vF9H7uppBK3wtSNDtLCsu4prGTuFV5TgvAr5jSH
         xd8ehFcTkZQiXQJVANG/ZKs8NQkjB4XZsw/d192YErFiXSeHqYzd/azDWgqaDjtBxOzH
         /FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d94sngjmVln7SimPQLQ1oweOpklEvyv6YNarlMGIQeY=;
        b=CKoAMxWhLBSNL5gWVqTd2uiy8rxeBj/iJ/Fq4lCn5QXZTpyeuUeQkloDmF4/TT0KJz
         khXuI39IOJNlbmqyk+KDrdkbrx3RaKqWKco6lBZ4ezWUHgLHqgHWY3dfG+IFCWgzIYB3
         ZOSn+a1wIbfDHQLsGIQDw5AXOjnpkOdRmhe0baTxHg/c9Bo9lBwZJr8Qk7PBb55ifVfi
         59Hc1QzMbZRkEoQGgNkdaPITOuv/RV0L/8g3q1Q5DF1Wkr6qPBBnDSb3nbUXNxUHaSZG
         y0KhDcmA6dpHBhSlmrbPm5kA6Yv6Ut377Zy3v/nN2/hLV4zXOtVcV9HACLBLqz8QmfGB
         5WiA==
X-Gm-Message-State: AA+aEWZrVbZmQ7gAPsHSR7rYbnkZJWYR9pzjHcLirgVVx5FZb59Sa5kL
        bYGnT8aAKWxKIWXRor1/KoLrUxrofIkvDUmv4Ck=
X-Google-Smtp-Source: AFSGD/Uii4b6szcSqpxhPzqH9/PBMxuu38vfMagBScw3zXs5yl0Q8ExwxvjZOtKYIWl+vxv2AU0IyJJagHaQc9pUQKo=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr536621ljg.23.1545256382228;
 Wed, 19 Dec 2018 13:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20181217165957.GA60293@google.com> <CAN0heSoekZ_vjR6DRjSAfw74hn_NU3-5TFf6-Hn9z2D_zE-mNg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812181258550.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812181258550.43@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Dec 2018 22:52:50 +0100
Message-ID: <CAN0heSoUu-d1vut+5S_Sb8kASiFTG0mGfPqMzbXKxAQFr1JfKg@mail.gmail.com>
Subject: Re: [PATCH] stripspace: allow -s/-c outside git repository
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Dec 2018 at 13:00, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > Makes me wonder if `setup_git_directory_gently()` should BUG if it
> > receives NULL. That would require some reshuffling in setup.c, since
> > `setup_git_directory()` calls out to it with NULL... Just thinking out
> > loud. In any case, and more importantly, this is the last user providin=
g
> > NULL except for the one in `setup_git_directory()`.
>
> We could rename `setup_git_directory_gently()` to
> `setup_git_directory_gently_2()`, make that `static` and then call it fro=
m
> `setup_git_directory_gently()` and `setup_git_directory()`.

Thanks for the hint. I'm currently recuperating from having been lost in
a nearby corner of setup.c, so I=C2=B4ll leave this tightening as a
low-hanging fruit for "someone else."

Martin
