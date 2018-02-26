Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6ED1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeBZLiT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:38:19 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44849 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeBZLiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:38:18 -0500
Received: by mail-ot0-f194.google.com with SMTP id 79so13049143oth.11
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n9+JeC6H47R0iEfmFC6Ge+TUWisVZdcojMxW/VKd7sQ=;
        b=KFsFE6I2DmBgOCt5UEz9WHu42XqvtuP/BqDAfwIFxYrJI3ESB2U6+pw44FBMxNEya8
         ujZXJamrGCuS8drryNnAInnCHqpa6HFiFODm58BUGHc8DSW9MH9NBos+NGpdQ8MDXMXe
         aV0zlrr4jp9Han+nWIkDOHkTrI4a5AHynV1wbrqIpjcXa6l9EfDCzgSoikY+MJXG56BQ
         uDMZ8zQ0VvHaNk959eHW69Cxjk+tqmuq2S7uQXDMkHxG6cKVzXwXk8pwQgJ5Z7sf0p1i
         dy/CoGiMSz1ieWLeU1+i4iF4wBVw2X5zOFjupKcD85XZP28U3Vb5ARbev0+bPcID4LWr
         ZvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n9+JeC6H47R0iEfmFC6Ge+TUWisVZdcojMxW/VKd7sQ=;
        b=SCw7G8E+rn+HLOCAMprVKyLLMHEqmxuIkrQc1yDdP7184rb30XI6g6SKyPwGcJmPiu
         GnMv2eRX3ZptGGHe0tfDoacA91Dk5eFCair2zmrplqI0D1+aqYJnyJc3F1w8qCJ1F5XF
         xZT3dO1EjF71VIxMQ4B/zfpm9XNI9mecG390aOm32VOaDVvXvREUb1ziuNVazPGNvVSr
         +qtBce+obexnnNhVHWW9L3f8/PdKLKQg8udr2O0sxQ6nap/GKn1T7+e8GrYzvk4oXK/g
         RoXlrYRNTIA5+Awf5YASAmdmXBHHp6ugmuuI4pwwmFya70gzB7LgqlydCuCOR8xGJGrf
         rVmw==
X-Gm-Message-State: APf1xPDkyDDSRdlmuTgRBbzWL01z8K4DWZ1fs7382tZhpreUnMImWBeu
        hoZV6BNEIJ76Jr+E/zwaQVNLrg3FfSZHKVtQxv0=
X-Google-Smtp-Source: AG47ELt6gN53TZBpvdmCEhgIzXt15PgypoTOjEX5BR6lhI/AF1vhJuKnR8IKeoM4uMpwZ4uhLquRxaotejMM6sAMIDE=
X-Received: by 10.157.54.204 with SMTP id s12mr7763074otd.304.1519645098390;
 Mon, 26 Feb 2018 03:38:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 03:37:48 -0800 (PST)
In-Reply-To: <20180225211212.477570-35-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net> <20180225211212.477570-35-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 18:37:48 +0700
Message-ID: <CACsJy8BcFVVjvfrqot5mTv4+zKx_GnRQ_vsiyXvKkYvWVnS0LA@mail.gmail.com>
Subject: Re: [PATCH v2 34/36] Convert lookup_replace_object to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 4:12 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index 7493bc7f11..c41fbe2f01 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1227,22 +1227,18 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
>         static struct object_info blank_oi = OBJECT_INFO_INIT;
>         struct pack_entry e;
>         int rtype;
> -       const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
> -                                   lookup_replace_object(oid->hash) :
> -                                   oid->hash;
> +       const struct object_id *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
> +                                      lookup_replace_object(oid) :
> +                                      oid;

Micro nit. Perhaps we should replace "? :" with a real "if" construct
-- 
Duy
