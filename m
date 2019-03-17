Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F4E20248
	for <e@80x24.org>; Sun, 17 Mar 2019 19:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCQT2B (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 15:28:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42862 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCQT2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 15:28:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so11711504edb.9
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxfWHoVVeFareWxRXo88gnPKLExMPjeoDZmJiCnlC/U=;
        b=Yc2oEpnCfXobaz1KWGm9FtgYrwjKquuM52zdY7XBLggL+sV3zXej8uJQn5cP2C7Vzs
         Jk9Hwz28nAwNAkLkbCw13crkp2JOfHubQ4GbA4pkoCJJqZPFmvWkvYxYcWysG2QE/3Sg
         LKAvr5xEPnu8m/JqMF/nvCWM6xAJ4Uvi5ruI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxfWHoVVeFareWxRXo88gnPKLExMPjeoDZmJiCnlC/U=;
        b=aCW/SJx/EqWBloAJdjqMRJoRNLrfoiVFVh/8Eg/6/DH5wU15qNRTq2W3nF0UCpYAQx
         5vVKbUx58FXslFOJpOts7NUIBmY4j1Zz+QN2dnb7CKROsN8Zb9e72PNgsqLGjK6L8aTh
         iR24S39kFvT0k5+wDkv8DLWwEtAuOp7IunOGZrEfFJgcIz9MM5lziP/uyXNzqWoKIoLa
         xbJMdDwVDCXjVWZEOpIgB63BFpmJ1ET5SnpH8Wdfr2VqOjEIbkP7obS8rLuJi73igLWn
         JdFktWCswKRxv/wYYvuqb2jH+7dyrHukrFw0vjJtzi+pbnIcuHBqGwvbPV1S3j/YHmVm
         oEDw==
X-Gm-Message-State: APjAAAUL6nhOc6oUDsbXzge80YlEoMQdffALnWwgth9IhZFKAd4xBlSb
        6hDP8RunpP3cJDRO58RLzCFYLA==
X-Google-Smtp-Source: APXvYqzpu69D5DV1ds3RynxcxurAw9Hsl58WWnD9P/Tc+zTBlltWY5hQa38tB47D8FJx1B4s11g/xw==
X-Received: by 2002:a50:aa83:: with SMTP id q3mr10278938edc.63.1552850879612;
        Sun, 17 Mar 2019 12:27:59 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-117-200.cgn.fibianet.dk. [5.186.117.200])
        by smtp.gmail.com with ESMTPSA id p2sm2752518edr.48.2019.03.17.12.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:27:58 -0700 (PDT)
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
To:     Baruch Siach <baruch@tkos.co.il>, git@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
Date:   Sun, 17 Mar 2019 20:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/2019 20.26, Baruch Siach wrote:
> Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
> -by trailers") in git version 2.20, git send-email adds to cc list
> addresses from all *-by lines. As a side effect a line with
> '-Signed-off-by' is now also added to cc. This makes send-email pick
> lines from patches that remove patch files from the git repo. This is
> common in the Buildroot project that often removes (and adds) patch
> files that have 'Signed-off-by' in their patch description part.

Yocto/OpenEmbedded and other projects do the same

> Consider only *-by lines that start with [a-z] (case insensitive) to
> avoid unrelated addresses in cc.

While I agree with Joe in principle that we really should not look
inside the diff part, all lines there start with [ +-], so we wouldn't
normally pick up anything from that due to the anchoring. Except for the
misc-by regexp that added hyphens to grab Reported-and-tested-by and
similar. So this is by far the simplest fix that doesn't hurt the common
use cases the misc-by handling was added to support, so

Acked-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Rasmus
