Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6AE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeLTRGj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:06:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40304 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLTRGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:06:39 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so2775381ita.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBnDywPUmEoHzYHLWo/DUiZGbpojDBJ2vAle7nAUxrA=;
        b=EEmkik9qhkMOdSXrkV+09fDmgvdJCBQ6C9Pb0s1VppbJTHckgnor1A+p1fBnespOwM
         1GusiYWsNxY+fAQT/xAyAysxxoBXOEBBe9PgGYabZjaOBKbjYFBXF7k/mYwhUX7Kd4Lx
         Yplj05rUnOaIY2216S3S40u01UU4kbUzdDpgkC0MLoMDw6H+tsEyEApnqh4RF9EOrhdo
         b5Mt0rcnyTEV+svOj0aMOB64kpt1UT5rlg3i2SBHOdbE7weXWZZPXzbgQuzt9D95ZfPd
         ERNMyR6sTerZON1AKccdlMPkSBsf2z0Y3Uk2b37icG/G8Ar1JmjS1pk2iLPxUI9GZlXh
         lM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBnDywPUmEoHzYHLWo/DUiZGbpojDBJ2vAle7nAUxrA=;
        b=BMWZt16UZfVuCg6fTEpI7rc2cuIeoABXjQ1/zUoqPTERRLmtscyreDBFqIzhxl2uk0
         6063aZmd0W7za3CkfZP6NdNu5SDB8qG0qj11pMErGu/V3RfF6j5x1+jkNopps1DvVp2/
         M+EW+/xf+IxzkIvdXep+X+MFEeeJgtsOx4zkDobH57TneQz+WP7UaU30KyyMEYSqiyTf
         mRHWHdEB8Zt7z7EURxKeASUjLQnS9t+po+5qBg7ijvrQFUl0NPHvjz9VXaEDrIeept06
         4emu8QLInZbAhhVIijOHPJOY3FzMrg2sbIfDiVbXVsdyqpicNCfKNfekdRV5OvHJn2xG
         /V1g==
X-Gm-Message-State: AA+aEWZkJrqvW55ZuN4VMbeZFSpfZvX0pEp9FH/daku2EzFV2lNJ5NJh
        SSIKWQrIjZWSryv8QzQo3vF4SIdDVD1nl6XPKHYaRA==
X-Google-Smtp-Source: AFSGD/Xm1bsBAeDpTIP3CUgmkGwT8uS4Rjf7/ZeJvDtM8F9vA1yuqQI3Wtj7aEd4Jow4U5lfyVjXFEbee2EgeXj3/lA=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr22163789jak.30.1545325598348;
 Thu, 20 Dec 2018 09:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
In-Reply-To: <20181220002610.43832-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Dec 2018 18:06:11 +0100
Message-ID: <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 1:26 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -5159,6 +5159,8 @@ int diff_opt_parse(struct diff_options *options,
>                 options->flags.funccontext = 1;
>         else if (!strcmp(arg, "--no-function-context"))
>                 options->flags.funccontext = 0;
> +       else if (!strcmp(arg, "--literally"))
> +               options->flags.read_literally = 1;

You probably want to check in diff_setup_done() that if
flags.read_literally is set but flags.no_index is not, then abandon
ship and die() because --literally is not used with --no-index. Even
when --no-index is implicit, flags.no_index should be set.

I wonder if --follow-symlinks would be a good alternative for this
(then if the final destination is unmmapable then we just read the
file whole in memory without the user asking, so it will work with
pipes). --follow-symlinks then could be made work with non-"no-index"
case too. But --literally is also ok.
-- 
Duy
