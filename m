Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DECE1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 16:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBZQKU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 11:10:20 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:42698 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBZQKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 11:10:19 -0500
Received: by mail-vk0-f51.google.com with SMTP id y127so10147626vky.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4yoYwLllkP8qJm8xrBxPrLiaD9uJ/MEE++xIhATCyQY=;
        b=u8q0JFJhLbAQmS5+0LM2bbQFrsJ6RCOrNnug+HcQ3FSJ9cwK+T4KaTQmaaI4Xcsv2A
         HPaKQUEAjFBpJgUY+Og5oLheYH1VQx3zBuVjNx3YwfBbgiX/T2cXTtVw5/w/GYK4c55U
         S7POM0b+KFio03yBamyKYrT8CRt7s6j3uA5f5LbaqqSS+mjs7bMJWEh3eMMVqtGsmjFa
         0z9fFIOtNsbrpjPAfnxJzC7b2wWBCSKts+cpYw9h49KOzSvolYzrxpVijK5ufgjbuFam
         PDCNQ2Wh4oWQrd7x/AfKafRjJGWZFN52KRXJ52HaXorKvW2+7nDbV0jLEOlhnt03xzIk
         eehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4yoYwLllkP8qJm8xrBxPrLiaD9uJ/MEE++xIhATCyQY=;
        b=Y+OZu6SiKaBQOZpcvi7/zogEBjPxK8bhlVKcmQa7iTyfZ5/ehIg4iNC2QzOGagtBFw
         OzFdxrrshMXYU2YEXj0YbLX+zj9UYuqIilECJGluZ4mTP3fqhTVnVmKxqhSLiG/SHZSE
         mLyEHPY8eXcYi2qO1X4PPUVy4m1AvxYBN2DJZ85sKNJOQEBLcZtcuKRCOM+RYqZAuhXT
         ew538d/yecnooOB2+FyO8yTyBT1PHIeDU5FuTqkUUJ2vEHwAOFDudwTTD1GVn02Wrtdn
         tJFAO8nFkCesltNZ7a7doc9i2gOG5OBXpWFdKelc8jc+YWOma8Oa5LwaGUm3mocVCua4
         czeA==
X-Gm-Message-State: APf1xPCZ5hYDLrqlMcJh/SfpKd35Bb8nqEP5sw9u4VtU6ieUZXRTfYkm
        VRuha1iTgo65iZm1B64UNhFOMTHxf96vXH4MQTM=
X-Google-Smtp-Source: AG47ELvtwZE6UDrGELnEGdx5DTa+jDAKX4YqteRa19j1aHuM6En/XCgDkXawv5PGLK0UGY3nSImIlxrL46NT8EgCpM8=
X-Received: by 10.31.51.73 with SMTP id z70mr7947204vkz.2.1519661419012; Mon,
 26 Feb 2018 08:10:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 26 Feb 2018 08:10:18 -0800 (PST)
In-Reply-To: <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 26 Feb 2018 17:10:18 +0100
Message-ID: <CAM0VKjk2dphJsMfuG2F4-G0xW=YfmVsDsPpxm_XoXTCgQHA7=g@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, git@jeffhostetler.com,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 7:53 PM, Derrick Stolee <stolee@gmail.com> wrote:

> +static int if_packed_commit_add_to_list(const struct object_id *oid,
> +                                       struct packed_git *pack,
> +                                       uint32_t pos,
> +                                       void *data)
> +{
> +       struct packed_oid_list *list = (struct packed_oid_list*)data;
> +       enum object_type type;
> +       unsigned long size;
> +       void *inner_data;
> +       off_t offset = nth_packed_object_offset(pack, pos);
> +       inner_data = unpack_entry(pack, offset, &type, &size);
> +
> +       if (inner_data)
> +               free(inner_data);

The condition is unnecessary, free() can handle a NULL argument just fine.

(Suggested by Coccinelle and 'contrib/coccinelle/free.cocci.patch'.)
