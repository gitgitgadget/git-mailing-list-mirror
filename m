Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD52F1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755992AbcJNRrs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:47:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32978 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755505AbcJNRro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:47:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id 191so751890wmr.0
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Vqt1hJzkcE1IoRIn9ZGTjeVPLTDBTUqldlOX/MBzUiE=;
        b=qNa6z8gOqXBEVqroq9Ux+AQc8YyvUPOb4me++GC1hIBUHg5og3H338KoABqIrTk4v5
         fi/7XAY1P6WF4T+YlTgkXGkO3WfhLsVJJT6q/33kySyMELeDuy4txaSKsGyqymZ+B2J0
         SC9U4u8cdH1vAYTEijwLd26mLY+NJq1bCuLiRC0tM/6hlgL3rbu/KTZeBkx29uIOfN0w
         bRoj8FGhAqzYQyGUy9kybFURLW8CbuPRlx5G0692U5JABIaU9BvUHVlLOIwZUdCA7KJx
         acBU+Ncy62+4PECWDfRvzDeKZrWzTlz8D65jBHq6kdXbFLkH15hjXGAFLfAYd/9a1/9z
         SJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Vqt1hJzkcE1IoRIn9ZGTjeVPLTDBTUqldlOX/MBzUiE=;
        b=VBduozkSNwnXvBxUgoN0C1uvbkfe9Rh8Qzr9R8qyBokfzhqcd+HCwrqC2POHYA3cJ4
         UoZQNmWb0nW3dUP1nP60/QBlLh2jlHrT2xzTb4We/GP4NOczJGldu/xOnOAGlwdLOOq4
         4AG51s59LL5b/90/Xm41TpcrcqiGl+BKmpz5e/qgZpFVFlIoAeDLod9q3cQBenmatQCe
         pR6n8QRtBs4gMgzXiYKf4+in0+psh2t/VHmvBq3uvWxfhU/Iyg15ZGYkiGem/x3qmxSD
         dNm4Fu1L3OLmJs3fDaWJBcTTMQrKf6HDrlXuRoi4+WavCjh0pqpxwrnBBCrqKE6nJss5
         S84A==
X-Gm-Message-State: AA6/9Rm4T5PZTia30nKOiYbFwBPXH5Hm7wHULLfCKxiYdD8f8HBUrg29Kf8N+qvTZONttg==
X-Received: by 10.194.6.36 with SMTP id x4mr3048802wjx.175.1476466165236;
        Fri, 14 Oct 2016 10:29:25 -0700 (PDT)
Received: from [192.168.1.26] (agd104.neoplus.adsl.tpnet.pl. [83.25.159.104])
        by smtp.googlemail.com with ESMTPSA id 14sm830638wmg.13.2016.10.14.10.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 10:29:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] trailer: use list.h for doubly-linked list
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1476314576.git.jonathantanmy@google.com>
 <a7b9f79ea1b61b80d1177740d5d78fcca848a4f6.1476314576.git.jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2e688562-56d2-96d5-0fe7-bf140a7f7cba@gmail.com>
Date:   Fri, 14 Oct 2016 19:29:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <a7b9f79ea1b61b80d1177740d5d78fcca848a4f6.1476314576.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 13.10.2016 o 01:40, Jonathan Tan pisze:
> Replace the existing handwritten implementation of a doubly-linked list
> in trailer.c with the functions and macros from list.h. This
> significantly simplifies the code.
> ---
>  trailer.c | 258 ++++++++++++++++++++++----------------------------------------
>  1 file changed, 91 insertions(+), 167 deletions(-)

Very nice gains!

BTW. could you sign (Signed-off-by) your patches? TIA.

Best,
-- 
Jakub Narębski

