Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8E41F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJGTRA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:17:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42453 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:17:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so16582835wrw.9
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t+MO2T42iT1EN+XkkOz+JcdsaRw+hn05yUNKykkVUFs=;
        b=DQ6x+O2u8nW2976bQoZkNuZ3Ij+sapyk9k6ftox4r6zTWphyW6aMtci5yIBc/MW5z9
         M2McLBNhPh6oGdv9ZJbve4GYIqkD/EhnH93GKhpnyHL5hrn8y4cHgvheiK+6VzYcLpnC
         Xndmh4xPKpB7VVVnSxV1WLZJfQ/cJiaO5gJTpObiMhLZpLe2RHWqF6uXM4MYmDsFBw02
         97kr0Ini1UtMlzOCpcDdXJvsaPuRdJdB0uep07eCDMotEHCbYDhl0CV1fdWQAK6uoz9R
         vIxAuk5o9jHRTOF4pNKFJ7opCOFOQqsf84JwYb1LN9mcGYUstjqfjaGrGag2RHnaZx+8
         KBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+MO2T42iT1EN+XkkOz+JcdsaRw+hn05yUNKykkVUFs=;
        b=dBpoTYcutH+m2VCtxi5/vFzmpCijGsFz8hnB7PmjYE5d+yW3nyyr0nsuRXvas4in7Q
         RToFBD036g0UMR0v4hBZIp82tFlRLf5+iePIpPMLbhjQW/Ss0CJx3H0eD+9ROuF0oZF9
         UMxFYSmIYOJaCxvlC+UUbLJKtoRvKoY7k2fjlZgY2bu1ZjeoVHLv5RoLS2sIzKWGo9YE
         aXjw8jqcwnQLaSS2x802R1qlYsTntEVIRaJvFyb9iNBM0WJX0UBPUR4v6XugO22DKPae
         NHi+xsGMbKnJtg3ybAHs0vr/jCBeLF3gUM7fni3WXh00OX6eMXpQnvYLZtbD/hezJZnl
         I7aQ==
X-Gm-Message-State: APjAAAUEN+cG74iU83SDK54upREkDkwb+LGHq5gjKnr7CpXxDDFuQsKc
        ZiSsieud76wSepLc113QlsHQdaB4
X-Google-Smtp-Source: APXvYqxkeMDjj/S5p6b5apPTDXiYfz92guh4cNVMX54QXp5aRrwFeYWwTxSQnILLiNRE+M5/bvFjEg==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr11169495wrq.275.1570475817954;
        Mon, 07 Oct 2019 12:16:57 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.gmail.com with ESMTPSA id r7sm2687287wrt.28.2019.10.07.12.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:16:57 -0700 (PDT)
Subject: Re: [PATCH v3 03/13] winansi: use FLEX_ARRAY to avoid compiler
 warning
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
 <pull.288.v3.git.gitgitgadget@gmail.com>
 <e632a4eef46720d43fd014644ff24d3dac61ebe9.1570201763.git.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d1f53812-ebaf-4290-f867-6d34735d314d@gmail.com>
Date:   Mon, 7 Oct 2019 21:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <e632a4eef46720d43fd014644ff24d3dac61ebe9.1570201763.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 04/10/2019 à 17:09, Johannes Schindelin via GitGitGadget a écrit :
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> MSVC would complain thusly:
> 
>     C4200: nonstandard extension used: zero-sized array in struct/union
> 
> Let's just use the `FLEX_ARRAY` constant that we introduced for exactly
> this type of scenario.

Perhaps this is a good candidate for a semantic patch?

Cheers,
Alban

