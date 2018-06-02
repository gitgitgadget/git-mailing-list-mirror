Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE661F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbeFBEli (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:41:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37088 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeFBElh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:41:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id l22-v6so16473113oib.4
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3UdaVeBR5RiNAmswgopb6BjbP/6uEt7FpfVwOMRMcUY=;
        b=SdkBJt5XfzxNHaDGPRaPBfKYvetRHizOqxM7WmAx3VLNvLjPxZAOoezu+MGIvMr4Wt
         05Stjv7wyw+1rshHNDrlezB/e5VDnhvXjjYcllUUBZkpcpKhQyaqLE7Y89RpOMsEF0ld
         3n/kKXjtda25X413rs+KNf9+USh9dIEKmEuO//2OEgwZ5ySUN+XwLuzL2108VLrJbnHe
         BsDU/h0o170R6qkUbhKs+MTuKKdmkyATrfXS9BJadWl5XljnoQ7OlRwzMWRKGxvE0oTU
         5hMtpoP2Rj3X/SuVotunyUEqGTrYk/f4uoDCHz0W7wTbNtEyPuz1vUj33K0qRvPswKyf
         cAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3UdaVeBR5RiNAmswgopb6BjbP/6uEt7FpfVwOMRMcUY=;
        b=Svcy5TL6uy/vUg2ijXYSEwWvNYECVCWFLoDbmxMnjKzdX7TQUyvjXaxZewdbtsy27Z
         bnlzQHkdw3ld9MwMfer68R1V9OwzwYvU4JOr/vYyi1KK+nGbDapLjzssSF19F5bmU0oY
         b9VzVfsOuO0/VxSpEIC6LDJdV0AbjcZl5h3PihhH5ngGABQIevPl0Ng+vuWh37ZU1cfs
         1/pVQnvFQ4LJzyDCMHfMosSd9sSVx8mpOBEtDrBlBIj8tDZh3vpbcIyBT7Cjuzcf9ToG
         L5j33KghE3dHIRargOquWL9ZiR93P+IlRJJ526yDe3/4XyaDkJItSStHVUCv7++DFZcm
         JY/g==
X-Gm-Message-State: APt69E1fNWE8GtCZfLRiwOFWvmDHBRZnWBsKTkA3h1GBNiSMN8S/tS2B
        aK+w5go+zBFkLSFAT5j+5mWC1SaX70N1F6c+C6Q=
X-Google-Smtp-Source: ADUXVKIfiowlhJIphQIHsldlugL3gElJLJdiuRjENLHWaRXMCbm8q4xOLXvwkfr6WBvcZvWMH7LObVeuLClQ0TxyGGA=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr7670045oib.32.1527914496994;
 Fri, 01 Jun 2018 21:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 21:41:06 -0700 (PDT)
In-Reply-To: <20180326143136.47116-2-git@jeffhostetler.com>
References: <20180326143136.47116-1-git@jeffhostetler.com> <20180326143136.47116-2-git@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 06:41:06 +0200
Message-ID: <CACsJy8DcGp29iJDZKUz0JM-bvbE_G3KnqWyLk_efjd7T3URTYw@mail.gmail.com>
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON format
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, wink@saville.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 4:31 PM,  <git@jeffhostetler.com> wrote:
> +static inline void assert_in_array(const struct json_writer *jw)
> +{
> +       if (!jw->open_stack.len)
> +               die("json-writer: array: missing jw_array_begin()");

When you reroll, please consider marking all these string for
translation with _(), unless these are for machine consumption.

> +       if (jw->open_stack.buf[jw->open_stack.len - 1] != '[')
> +               die("json-writer: array: not in array");
-- 
Duy
