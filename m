Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627BE1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHQPSg (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 11:18:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQPSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 11:18:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so4341779wrj.12;
        Sat, 17 Aug 2019 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ul2l5JrqAd1mDsIFKulTSXYEdv8S9wBV/0xY3AmlAzI=;
        b=PTQlbfiJrEF2+AW661DWdF2SDZZ/0T8mtFFkdnvUjG8Y9EQV8aFFyN674s96eFyqck
         QY3WP1GSmhhl9A9MdPXfog3LYhxgNmGyxA2i3wCsbnwIplWF2eVlnSM3K5mDhSWTHlkP
         Cj+jQ0p6Aiz4qRRFBT5oNPoWlVMmi51VZNAPtpagYs6IGf+guz+433MFPtghq/lB78ZW
         3VKvw3Am42dyZA9JX5PBtkdpBmgHmgDD3HSP1rBm9qQnA2j1nZwj176OPmMeITDTRDr5
         h4oKbqhKI8kKx7sHM5lY43NRHXqNysADW060XoliR6ZaquDGEd9m9jjaYIRSk7S8LEeh
         7M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ul2l5JrqAd1mDsIFKulTSXYEdv8S9wBV/0xY3AmlAzI=;
        b=DtFu3FU4oj+fLqgvztaCi9oeyGNzMrciBI40+tDbgIMNPbPuNZWzNOF66fx530iYpR
         GNClpXAqTm434Cg8e4TAbxl4QPMqcw3ULB6zqzzdqIwv9/ES8lpWJ985BgnpFkS5pPi1
         JgGMyrEHut4Un3bVv1PEtaDHNMMF8caRNREXXozhWBV9r5nKketizyQAklntSfuIRkaN
         GWvXhd0GhwpgmrGdBas4igtbVYy8D7omlQPVuDCyBS5qQjIhpQFZ3yypbpeD2V/9J2vi
         yrAB4L6hz16+NMOX9+LeHTwF0VDPtYo27SAhZEj19v1ZnXN0yY8HX5BHtjFWvEg3kPP4
         WbHw==
X-Gm-Message-State: APjAAAXDsVGLTUYRmO9oBx6gnn0GYTuv8kCHGtxorTrgl85KuJ0Mdkgr
        MK7kdEGISCmFY48xTKw2Wqs=
X-Google-Smtp-Source: APXvYqxtM/pIN6DiBAcap1mZ9r0mDJOO+aKxE3rqqLOZfbOi1BvJAmMU3kkyV5APulBLz4Byx6KMyA==
X-Received: by 2002:adf:f042:: with SMTP id t2mr16775248wro.139.1566055113047;
        Sat, 17 Aug 2019 08:18:33 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-6-50.w86-222.abo.wanadoo.fr. [86.222.149.50])
        by smtp.gmail.com with ESMTPSA id e10sm10863065wrn.33.2019.08.17.08.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 08:18:32 -0700 (PDT)
Subject: Re: [PATCH v2] userdiff: Add a builtin pattern for dts files
To:     Stephen Boyd <sboyd@kernel.org>, git@vger.kernel.org
Cc:     Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190816225658.8946-1-sboyd@kernel.org>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <40ec31c4-6f13-a513-6514-93b6c8e84a7f@gmail.com>
Date:   Sat, 17 Aug 2019 17:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190816225658.8946-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

Le 17/08/2019 à 00:56, Stephen Boyd a écrit :
> The Linux kernel receives many patches to the devicetree files each
> release. The hunk header for those patches typically show nothing,
> making it difficult to figure out what node is being modified without
> applying the patch or opening the file and seeking to the context. Let's
> add a builtin 'dts' pattern to git so that users can get better diff
> output on dts files when they use the diff=dts driver.
> 
> The regex has been constructed based on the spec at devicetree.org[1]
> 
> [1] https://github.com/devicetree-org/devicetree-specification/releases/latest
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Sending this again after getting feedback and it getting stuck in
> review[1]. I'm not sure what happened with the meta question from Junio
> to add a way for various projects to introduce their own patterns,

Nothing happened, AFAIK.

> but
> I'd still prefer to have this in git proper because the kernel uses git
> extensively and we rely on git formatted patches in our workflow. I
> recently reviewed a dts change and remembered this never got accepted.
> 
> Changes from v1:
>  * Updated regex to handle anything after node names instead of
>    requiring a '{'
>  * Updated test for boolean relation operators
>  * Sent out a patch to devicetree spec to document % operator
> 
> [1] Feedback was in 16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com
> 
>  -%<-
This looks good to me.

Cheers,
Alban

