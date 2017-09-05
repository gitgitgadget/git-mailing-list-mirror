Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863A8209AB
	for <e@80x24.org>; Tue,  5 Sep 2017 22:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbdIEWNn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 18:13:43 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:38686 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753474AbdIEWNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 18:13:43 -0400
Received: by mail-io0-f169.google.com with SMTP id q64so20381815iod.5
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X87Vp0Njbi7dc0tW90Dh3GB+e4V3mzRS2sL/+DuCwZA=;
        b=mWhJJ1wXHJRARKyrCQzbw/OVhN016+jBfzwMv8qxAeT/QHjlot3N0X+Q9i9JN7nMsc
         /Lb/Y9mm7dm3FLj39YuLzd+I3pVMJOqVtQzrrSC/IkwgX6sEa7eu4AcWLAJo2O1mbDjC
         DqSJ0RCy1KBShWbcD8bzdxqbGjxAwZF1IZt/AdP2FJ76zyX2y82VskDKWqSx8vg58pzX
         SDHYALftmY5xgJY6T3bddCBS5eot2RS31sH0nzRk+acIh+I311qXF8MARlj9F+6se3+R
         LZOcOsXjKsAEtGEspveuE0h1Pcyj6FOw+K0ndvBFUbP+FFe9U6d2Ojv4km7y6UWHgwAj
         +t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X87Vp0Njbi7dc0tW90Dh3GB+e4V3mzRS2sL/+DuCwZA=;
        b=hq/2ILn/sbaTS9EQd6ZJINJpE4qBEkgDsZVDrquhks1XC4P5GwvzutKinoIvAgeK4L
         a+EyFuR+ANM/tGGSXVPwmr909hJ4CQfyv/M8JvHMdAHX5sAIiowtC/MoBvIaDhvFJM0+
         JMCbdpDuC1ViHSCutb4LRf89ByTob7z5HRAyasiSN9dSvaUy/q2xAnyVO12qM/tFd4Un
         dlAG6dY3RDLptSvMIHxGm/mmKRKUa65yBKDxOxZVrtvibMQH4ry9CVkSVXejCd2I9HHi
         aO1bSbDVYaFDBdLtYm/zEuKI6nzH1Kzp7CwRYR/9uqgCiA14DnSjBprrKQPs7rQyQsns
         8ikg==
X-Gm-Message-State: AHPjjUitBYld07vPRNBkkoJced3QxB69pohwaLKwr1Gi5zFFeqTV9Lv4
        tj3bTFuKGRtdfEd8JxCek4P224a9kw==
X-Google-Smtp-Source: AOwi7QBaD8W8RuOPkUssNXBvpg4RG97yVNyP+tGnoD9uzKOVswcP9K1YBFiY/DLrHnRMWIkUbnbcG8h6qkt7RodCZfg=
X-Received: by 10.107.138.101 with SMTP id m98mr628367iod.248.1504649622388;
 Tue, 05 Sep 2017 15:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.151 with HTTP; Tue, 5 Sep 2017 15:13:41 -0700 (PDT)
In-Reply-To: <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net> <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
 <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2017 15:13:41 -0700
X-Google-Sender-Auth: -YkCg4xOj21BntOcciKkv2NpEsk
Message-ID: <CA+55aFw==7bqv0dH=cQruXbGjMw-WNrRMreMsYy_4NcrbiWSEA@mail.gmail.com>
Subject: Re: BUG: attempt to trim too many characters
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 3:03 PM, Jeff King <peff@peff.net> wrote:
>
> This probably fixes it:

Yup. Thanks.

           Linus
