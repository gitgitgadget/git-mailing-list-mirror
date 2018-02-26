Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77CE1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 14:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeBZOnf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 09:43:35 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:33941 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753333AbeBZOne (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 09:43:34 -0500
Received: by mail-io0-f172.google.com with SMTP id e7so17464883ioj.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 06:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKASzkh4sPniCUBchIa0/EnvnRzCZxQi/NKp2X+rXrc=;
        b=ddg+lTHuYBXhUk1EO92rdKxQLoU3E/OGDFGnxp7OLLVGCK1H69Ll74Y/kWONnzt/JO
         C0oDGollZmX2FmDy/dz632YbUnYg3+sy+xEMHKwg/OE3OQpt5fkYnQ355rqXXQpecPrj
         DTnmndZ0qca9ZlJLDB7Cc2HkdG84WwrSyCsobn9JyiRK6zQpefwjTsIhVna4lAJRenby
         gLIULdPy0jM6CdThwdqJfIGhKyCUEUkT/Ewi/dt4jkWmk4912pfq16r+NJcHs2/c5yQf
         87JSvi7VTODCXjoMnogyUhRa0420WHH1RXVDQM+zitfjsNIjSMjoUrwg5y6VZx2jig5E
         d4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKASzkh4sPniCUBchIa0/EnvnRzCZxQi/NKp2X+rXrc=;
        b=AXMF/4db1wSoWojNkVtMYK+DvvFLsjLfG8DrFnE5x8eM+8WmuV4+Vg++aDtCJk2z/M
         P6m/a1SATW7jXu+IziY/e/ozNp1GtfNbRbSqvi/PVgo2rR5nd62g6DLcRNgS6Iv22FqQ
         0vPFVfqqEistYm8xFJVfpddsT4PscL6Zvbb1iEf0m7r37MECBP3eBMb8Vu3+8QgaaF8d
         FsKBf4xps0JcdrbjeTf0myMvdolgakyHEg9WuCndibQ9fEx+2q/7fXuDxAyFUXExI6ua
         +fTUDDRumn+mnqTAzJvNVKh3H4AnOickkEfFb1IMV0zVouitHWvGO4NoE+eqJ6K9tDi/
         efEQ==
X-Gm-Message-State: APf1xPCHz2bmfSK8iAji5LqP/ojdXyRctHeJh71Vs8MS4GzzJwidL5bg
        /mW33V7IWzJ0L963mK3CrOkPd55bq+g7GR5YVUs=
X-Google-Smtp-Source: AH8x227J3DzwNVQUCfnD8GqW5YtHuVBcdHExZSZ/cuMdxff4JmuBl4uCsSUp+7G+Dsdm3Bcbnwg0xuQcraXGovqbyBw=
X-Received: by 10.107.144.197 with SMTP id s188mr11796512iod.53.1519656214152;
 Mon, 26 Feb 2018 06:43:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.20 with HTTP; Mon, 26 Feb 2018 06:43:33 -0800 (PST)
In-Reply-To: <0a85ea3b-3f64-f67d-b4d5-a761cbc4c6db@gmail.com>
References: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
 <20180226095311.GA14831@sigill.intra.peff.net> <CAP8UFD01wkpNuXSHxQTETi3+tWBM0E=iYXQeT2r7tGs=2Yq2EA@mail.gmail.com>
 <0a85ea3b-3f64-f67d-b4d5-a761cbc4c6db@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Feb 2018 15:43:33 +0100
Message-ID: <CAP8UFD0CesVk8FjX-=unwSO6u0pi1-Usm1yVW5hs5FHi=8Timg@mail.gmail.com>
Subject: Re: Use of uninitialised value of size 8 in sha1_name.c
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 3:06 PM, Derrick Stolee <stolee@gmail.com> wrote:
>
> Christian: do you want to submit the patch, or should I put one together?

I'd rather have you put one together.

Thanks,
Christian.
