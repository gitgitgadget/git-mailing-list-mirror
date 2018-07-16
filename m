Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BA41F597
	for <e@80x24.org>; Mon, 16 Jul 2018 14:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeGPPQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 11:16:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33358 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeGPPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 11:16:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so12735883qtp.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wRO28HBO9J5UFjtfOjchhyOLLaGcQhE8Akuh7+VhUWY=;
        b=oPolThXxjSwxmFADDfo7EZc0d9dj9g9jfKGX/1skBDqosFyceVDXu5Tn8nSBIZ/LwM
         QXi7Y8RHhhzTDcwZoEHwmhUBYtSfStue/tYf7XMtsu9RnP4b91+IuR7UApqvFkKpRmOE
         MyfSby0JEOHX+FIbO0FHeDmXf4qTHfKfFkZNMatAT2WRpwJctPgV9jvV1R0OZ5cZYc+F
         cspGzHV+ANsvhION68hIB18RQIxWhFgs8fQSVbdCTfyfTKBjFrsIwcuzZPzOINQJvmy4
         e58qG/By0mNAD/5PQoh311Cw3faUOSmNqacntpbETlhuiipr3OyFtVV7WrIYhU+P5Oh9
         Lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wRO28HBO9J5UFjtfOjchhyOLLaGcQhE8Akuh7+VhUWY=;
        b=UjAZ7lVnxaWrP8WNQVHur3ChTJhbDuhMMLEYyEIESFLoe4SEMNWUEOYP5E2mz8fTLA
         pa5/k9qllcwpexoRX8CWRNFlV79aBSHKyofrviyhwAbod6ulbOSKLUGtMW9sR/oG17vD
         qup43Z40fc/iKvrFUyxDbncLxrqag7gheFlsD9QKHDsPPhXImyh7RA5bpGKje+W+dR2W
         wdIa4XReMTcLJs9cMMh4IY1pUH395j/b9tzEntA7miOigZpK0X0+VJMEdXSadkPAFgmA
         DfSjPX5Obof7K3rKMhoJhBVOmrqY9s+3nlYvVzlEQaQ8gXNgqM1phu6lo3zr5d2mdyq/
         7Miw==
X-Gm-Message-State: AOUpUlGQoYs2Xw+wHHLVWKVYE5Kcv2SW+jvbiNHgjEkev7ETCvA4gr4O
        FcMeUEIR+5DMvrxtv/L4ITs=
X-Google-Smtp-Source: AAOMgpcwkhkLNan3xHQXLEYlvmH7nKeX4cO0ISky3XM5jlpsfCmTS8SwCjHSh+swma3ji5L7v/c4eQ==
X-Received: by 2002:ac8:7107:: with SMTP id z7-v6mr14673742qto.326.1531752553246;
        Mon, 16 Jul 2018 07:49:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:60fd:63a1:877b:9618? ([2001:4898:8010:0:4a33:63a1:877b:9618])
        by smtp.gmail.com with ESMTPSA id x26-v6sm1385727qth.15.2018.07.16.07.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:49:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] object_id part 14
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <668c27f2-fb61-32c5-7664-160d9a9f7e18@gmail.com>
Date:   Mon, 16 Jul 2018 10:49:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2018 9:27 PM, brian m. carlson wrote:
> This is the fourteenth series of patches to switch to using struct
> object_id and the_hash_algo.  This series converts several core pieces
> to use struct object_id, including the oid* and hex functions.
>
> All of these patches have been tested with both SHA-1 and a 256-bit
> hash.
>
> Most of these patches are fixes for things that will clearly cause
> segfaults or other very obvious breakage on a Git with a 256-bit hash.
>
> Changes from v1:
> * Drop patch that's been replaced by one from Ben Peart.
> * Update patch handling hash* and oid* functions.

I re-read this series and it looks good to me. Thanks!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

