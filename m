Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE421FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbcH2RlQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:41:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbcH2RlO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:41:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so10484524wma.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Z27oDLQEGgI3LUkKG6p3fEhpUYbUtKR677TYonPCPnQ=;
        b=KjUPDD/v3N2uVz2f96fNBSNw2fUQeKuE2IPRguv5NFth0uM4wcJkGIeERbaTiljpeR
         Ih4MvV4WcayanRRAX3UYDEGc1n4q5x4xuLLfjIHti7658qz8o/KQbwhDWAGrtswYB+Ex
         N9B/xiLMl1busR4j8gPclBs20nmTB3xA/rN7MD9FvVLl2uigzPo6rHYgOgDBR9xAowmW
         QjJsTdlSdVmxLwGY0uoAF5rxbQWy8Ek8PWy4tCAgYM3xuXry8hpgpX9xBHaWgEBmOlLT
         xq516Ib3E6HwVsvS1n7O1YGPQknLUxmZDPa6v9Z1qXLq9WGEz313cowcueG/DhfCavOl
         1Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Z27oDLQEGgI3LUkKG6p3fEhpUYbUtKR677TYonPCPnQ=;
        b=OcvjVU2/NTJh0Vbf7dDRqFjskNczCinHalbpnb8B+fU8CDSn7TMs9pm9BOm+vtEjeb
         IFraUMDYGWwVRb3Porw0bEf3wv2QTMUJ9+dSqaTq5ANbqG+lDFwLqks9oAQXs/b4B+9+
         9nWskhWkptoudIByDTpUM9xoR9J6iSxqvHlo2c2YnpgCK/cN6PQ4p9GYXb4iAVW7HliN
         hdbDRmjWTRhzOSx/doqpVo85PGVxQK+opJ6S6Vku2KdW0+Cp3zeOpNNOMNEcSQpjvqbs
         6zFpDoDQzyLg4g9VGm5c5NW0S+e6kxU4SNH3gb8vK1OKyhUcVNpGaNGjIUlbNEAk+EeS
         8lUQ==
X-Gm-Message-State: AE9vXwMkuG9mYabvUYRxXT8HIWbD32SoHEJarpzIm6VxdibKdWhKkbs9dW6Y8JP1SlR+dA==
X-Received: by 10.194.40.166 with SMTP id y6mr16200960wjk.171.1472492472700;
        Mon, 29 Aug 2016 10:41:12 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id yz6sm35433751wjb.35.2016.08.29.10.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 10:41:11 -0700 (PDT)
Subject: Re: [PATCH 01/22] sequencer: use static initializers for replay_opts
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de>
 <1472462360.4265.21.camel@kaarsemaker.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8c36fb5f-42a2-e4a7-1b7d-c8e60de593e4@gmail.com>
Date:   Mon, 29 Aug 2016 19:41:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472462360.4265.21.camel@kaarsemaker.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 11:19, Dennis Kaarsemaker pisze:
> On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:
> 
>> +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
> 
> This looked off to me, as it replaces memset(..., 0, ...) so is not
> 100% equivalent. But the changed functions both set opts.action and
> call parse_args which sets opts.subcommand.

This information would be nice to have in the commit message.

-- 
Jakub Narębski

