Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6A71F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBVA0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:26:22 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33577 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeBVA0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:26:20 -0500
Received: by mail-yw0-f181.google.com with SMTP id l200so1141631ywb.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OED1ytasOd3i/p/snBrzpHxnOCP9zCwaEJdMwfQS6Wc=;
        b=Owe8PHI+GTWwX/UYItM6aphLNdskEJUhBr5xjjhVLmv6X4mVTZ5YVKT/Nz0/l30raM
         rychAAKHEVcCDJZFWOt60rc33z/RAH3inNvQdMLQ08eouXWfB9irU5BFIu46ub3MxPrY
         c9XCzh+Iz42bocwcbE8bIdba3TMGdcPrQr1SXJy22dR4uwCGDJN7Qt+ldOBkmuguglV1
         gM/DGWr4IHxLxZn7slv0NDN6yWEe3zSzoX8OPYOKyuEzlXdBir6V6eLCVJTN0fIfYUr/
         jSTccdvlKJEeYRhGVEYMuROdrpYq0BNYEjPxVZkGNd2lNQYAyxMjtLf4as+Lc0xs3NZa
         mpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OED1ytasOd3i/p/snBrzpHxnOCP9zCwaEJdMwfQS6Wc=;
        b=f0w6HyNl/z53JPsGAglwZVjc036fGAXFCLnWoIn8pBjqOL3PaeZGFAjfM0GBwi6EgY
         ykZGz/okCYiVKp73nwXKyL2ZSorVz1VBQlO2YrFap4rSY5x25szG09P9wPOGwKJ139hK
         xiAT+al7clutbL43DNXhKcuT7yF/XAv+7yMUXLFmf14A9AHaVcsDy/EXCzxPz2koNstS
         w3l3Unme5aSte17Lh1XGNtgEFpCWW5xZajwbY7gMpgCLrWN9dRV4DXsKsHQ7CC4xuWlx
         5t28u+CnMhVQWHajEc42s2qMsrFe5EokMVXuzhFywMrr41YuCEwoVwoNE0eH78qaXC/P
         Jchg==
X-Gm-Message-State: APf1xPA+/EyC6r5kJ0f2x/VLZoYha1Cr19kWDp68I60ZXTfUPFJcuPXv
        HIEoEJui9rL7O7HmxvNSG9BhFmAOzPgJYLHIBW2MiQ==
X-Google-Smtp-Source: AH8x224U/PmcPsOzW4LM5E4000yGQS8lMrxhmZua8/3HumRLJPrG4kdOLd6IY6nMBkudHWgrsNhkPNRjE76kTLOifEM=
X-Received: by 10.129.182.2 with SMTP id u2mr3556118ywh.345.1519259180022;
 Wed, 21 Feb 2018 16:26:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 16:26:19
 -0800 (PST)
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 16:26:19 -0800
Message-ID: <CAGZ79kbZzVDyNxL6fBAfdL4hjjtq=eDjVu3A_zohZJk-bKW9uw@mail.gmail.com>
Subject: Re: [PATCHv3 00/27] Moving global state into the repository object
 (part 1)
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 5:54 PM, Stefan Beller <sbeller@google.com> wrote:
> v3:
> * reverted back to use the repository for most of the functions
>   (including unduplicating 'ignore_env')
> * rebased on master again (I lost that state when doing v2, as
>   I did both rebase as well as conversion to object store in one go)
> * one additional patch, that moves the alternates related things to
>   object-store.h, such that inclusion of cache.h (in object-store.h)
>   is not required any more.

This is also available at
https://github.com/stefanbeller/git/tree/object-store-part1-v3
