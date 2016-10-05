Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACACF1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 22:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941964AbcJEWbd (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 18:31:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbcJEWbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 18:31:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so727680wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WkePKChtlqC42SLGlb/of3hNk+Z8boinavMnvYOIDmM=;
        b=Opo6IS6bvvtsUTQpTdzNusiT8T/L70VABGoct9vQlFjB/wyU54fNkRDUz48Mpjoi0i
         Q9U1nka6gXivlHaTgLgK4esD/TA0q4mdkER9jkyEE8ZAG9mHUH/fj41lygxSMdCNKR3F
         MGOQqxHuLIkYa33Ki9AcHKU0Pp9lqkHUCUADRc3nZcuJF1f4q3sxdyY8eKOzfpjvcWap
         SK0ONAuz69g0s0QzCk2CzYPbJ6nqLPQ+mrWxC3M+UZMfnAuBlY5Osd4nkluookW/w0kX
         4GlJZUbNaQcyPAJvysyDAqGZT4gknQkGpESdzTBaKm4g8fiW1ACVc6jw4nZAJjyNlH4o
         Oi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WkePKChtlqC42SLGlb/of3hNk+Z8boinavMnvYOIDmM=;
        b=h54GdKgAGdWMOn7wf7AuZ/TmZtkEmq/g/QEmuG0hz92sGN4QtIM4ZBgJzehQt4SeIX
         aCOfVOP7vekhBfac3dYzNLXZObZcmhwb9qQwJAqJVqoyd19p47dYYIK6I0aMQpeqIoza
         fC0PG3lAQgTjrDq+ZoDaaavnUwTRDdEiCBLAlXN2wuK7iKybB7WEvpEO6m0yBNxfpTDJ
         FjJr2mceHmgpJACOhP5vRTL5LX5VXN/htPEL/Si0ONNyt/CNO7vCEY1EyaPM8xiLKclD
         vQvdhXMHr+dThHSxtqnZrGwQJEFqMXEGEa8dkjsWi2RU+aOtO8h0ieX4UKuMWe3TSFH9
         cIlg==
X-Gm-Message-State: AA6/9RnEHcm8gqQXWq61Faoi48/MgLLGEMnFixm6CbS2PdydZEnhaxsDXnXxGAjd9RKL3g==
X-Received: by 10.194.223.8 with SMTP id qq8mr9573693wjc.7.1475706690377;
        Wed, 05 Oct 2016 15:31:30 -0700 (PDT)
Received: from [192.168.1.26] (epq191.neoplus.adsl.tpnet.pl. [83.20.58.191])
        by smtp.googlemail.com with ESMTPSA id r2sm31827505wmf.14.2016.10.05.15.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 15:31:29 -0700 (PDT)
Subject: Re: [PATCH v9 00/14] Git filter protocol
To:     larsxschneider@gmail.com, git@vger.kernel.org
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Cc:     ramsay@ramsayjones.plus.com, gitster@pobox.com, j6t@kdbg.org,
        tboegi@web.de, peff@peff.net, mlbright@gmail.com
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4de1976c-3b76-1131-e728-057b143c9988@gmail.com>
Date:   Thu, 6 Oct 2016 00:31:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.10.2016 o 14:59, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The goal of this series is to avoid launching a new clean/smudge filter
> process for each file that is filtered.
> 
> A short summary about v1 to v5 can be found here:
> https://git.github.io/rev_news/2016/08/17/edition-18/
> 
> This series is also published on web:
> https://github.com/larsxschneider/git/pull/13
> 
> Patches 1 and 2 are cleanups and not strictly necessary for the series.
> Patches 3 to 12 are required preparation. Patch 13 is the main patch.
> Patch 14 adds an example how to use the Git filter protocol in contrib.
> 
> Thanks a lot to
>   Ramsay, Jakub, Junio, Johannes, Torsten, and Peff
> for very helpful reviews,
> Lars

I'll try to review it before the end of the week.

-- 
Jakub Narębski

