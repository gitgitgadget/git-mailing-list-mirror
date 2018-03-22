Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6395D1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 18:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCVSek (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 14:34:40 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34712 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeCVSej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 14:34:39 -0400
Received: by mail-wr0-f176.google.com with SMTP id o8so9725111wra.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7iP9hLZ9VCAyGTlEmjb9nY2Oo1+gCRSRcEWM+5s2S8=;
        b=BzGkiskCaguaZFMpA4UCUGf4oeH55a2XBtGzrfHTxbPEBBE4m0iH4GerNnDT+8dYyE
         sSXnj3tT+7mLlXJS3kyqckyVgwatK9ghZD3d+m+56d/oDSxR3TfomSuweSvq3DJCziph
         WqEz12bzaYl0nJsPDLbvWx5bGMPq1ncPfq6Qt7+2FBCmwM82qvT1fSgIQMF34Ds7qOWW
         EWbFTAbgk4lglYwBU6KGBtpKARS9fcmhrkO+tDWpY924MxwWl4w1BWNyqiT+CGGAhbAJ
         qnXBBuSSS1ZYgZWYqE7BQR/eMItBrDONXK7ufgKDPJI/idb1rHD0HHZt4HHGxoO9EHoT
         IKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7iP9hLZ9VCAyGTlEmjb9nY2Oo1+gCRSRcEWM+5s2S8=;
        b=FdhlJpFnMUiGnz7rSkSYrf44GIzS0OuEMp+1Fd94Lr5zzBJy6zSPxpvAbWJpA1UHNV
         DS0b65BQP0Qo9H+Eqox/qmZMpKRMnrVMsfPXCsq3iS5DQXNRcLLCv6SzsEKPDdM62Ils
         hHDyjuuDe6fmrHFM8kUcIxZCazprJNHyLOqXo38khglAAnGhJ9ncR/26uOIJslB6HP3M
         2zwZDt2LIGBgfeoUqbngXurJhilrHnP9BRCZJq97BUh8mRsS/PvE9rLCOIrQO/NS+/lr
         NN5QW+qgCyTHumiH5+7JVXtICEbRxyxwG+yI6l/2iL4ZeYhdu4nQwbxi0Db0Tl6Y/dDA
         fpIQ==
X-Gm-Message-State: AElRT7FYqGKNLnPvnzzlc4PItF6NZCmFH7JxSFrnOkZnYvswP5a1hi86
        2LXodu1ccBca/EgjwFK/pnZutZLf
X-Google-Smtp-Source: AG47ELsOU32Y9sQnpMLc9A5Tn+QjSbiFQo7asRo104jFlPQKqoAM5FXw2ZGbjupYg0H6s1grsCEkdQ==
X-Received: by 10.223.184.219 with SMTP id c27mr22233568wrg.30.1521743678300;
        Thu, 22 Mar 2018 11:34:38 -0700 (PDT)
Received: from sebi-laptop ([92.55.154.10])
        by smtp.googlemail.com with ESMTPSA id c19sm2304544wmd.37.2018.03.22.11.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 11:34:37 -0700 (PDT)
Message-ID: <1521743676.8404.4.camel@gmail.com>
Subject: Re: [GSoC][PATCH v6] parse-options: do not show usage upon invalid
 option value
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Date:   Thu, 22 Mar 2018 20:34:36 +0200
In-Reply-To: <CAPig+cT8OemuHYbkfX_zpQw47zjupDf65FKC-uC=GP+FLR62og@mail.gmail.com>
References: <20180320175005.18759-1-ungureanupaulsebastian@gmail.com>
         <CAPig+cT8OemuHYbkfX_zpQw47zjupDf65FKC-uC=GP+FLR62og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thank you a lot for your advice! I will keep in mind your words next
time I will send a patch. 

Best regards,
Paul Ungurenanu
