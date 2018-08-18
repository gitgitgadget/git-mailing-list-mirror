Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121B51F954
	for <e@80x24.org>; Sat, 18 Aug 2018 06:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeHRKGe (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 06:06:34 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:40531 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHRKGe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 06:06:34 -0400
Received: by mail-pl0-f44.google.com with SMTP id s17-v6so4688842plp.7
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uoN30ClIibBNbbzD+AqUm26q4LjJMCEZ+189r0mybnI=;
        b=In2uL3P0gDr86fafJ0VnYYJgX51TYBuFgFnnQbuxRShHZP0OX8DvyHhLNgBDEFNPTX
         l/b7jpPEwUoARTD7yUTPVESPJFi6JLEaFqKmdvfxQf8qvrPJhfjjvGtxNlgQL7lr3TqC
         k9a3lt5tCLKXlJe1rE2vEv0dIx/c08ef9BR/JNy2xdjYvIWEPFRky59f+6SxniL0a00X
         mbw3NAlT/HxFG/FlfTm99PQtgNl+AQt7GeMHwLXy8+8On71m/DrXS7E+LuY3Q7QAeOTp
         +ca+KX7g0MM5FZDR8KRK7Jf2CHM0Rxj1J7wXLaZt2aWG9nN6UDHiHy7C7Mk9tPTzDoJY
         CXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uoN30ClIibBNbbzD+AqUm26q4LjJMCEZ+189r0mybnI=;
        b=GaBMUrq2BSHfXxfgwRlKDucAvLQquMuEc+hyuHx4ZEqisS/q3UZGdmU6E3f1tH/PhT
         vUIIJdMmrq/xBzbkoT6n47OahdjZK0h/e+L7FIdA93acozmkwgBE9vQoMYqgNf6l8Wx3
         9RVc86mjLC8yrptLJF1Sf+G/ODa1KfKOGXWPBNJGmBHe3Z1jA8fcruqpdBtXgXsjnyGT
         K0uECo15j6c/SvtpOlS4SMOkqnuTQxApLDGC5GSUrhAP03R5+W35fH/AviCDrVolx9e8
         iUI0YOvSqaZykBryDuj73MfcejnjfwAq7jHwOkHVn34//MmchRN8fkb3ZJOUM7X5iNm4
         VK9g==
X-Gm-Message-State: AOUpUlGsjlMJjP/FZxah0esqeEYXJdvWilLqcLywdb1a+vauVh/ktQOt
        Zk96pgLvpdAR1TgHAr5HCls=
X-Google-Smtp-Source: AA+uWPxDgIKQRxwRMNyGVRyAY2Pp9VmJxmlmmIuSNeTuzgmOUiycFo2QoBqQIGyWAEiUPygiEvpCfQ==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr36520896pll.47.1534575596005;
        Fri, 17 Aug 2018 23:59:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q65-v6sm5654776pfj.127.2018.08.17.23.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 23:59:55 -0700 (PDT)
Date:   Fri, 17 Aug 2018 23:59:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
Message-ID: <20180818065953.GE241538@aiede.svl.corp.google.com>
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> Usually, I refrain from merging larger topics in 'next' down to
> 'master' when we get close to -rc0, but I am wondering if it is
> better to merge all of them to 'master', even the ones on the larger
> and possibly undercooked side, expecting that we collectively spend
> effort on hunting and fixing bugs in them during the pre-release
> freeze period.  If we were to go that route, I'd want everybody's
> buy-in and I'll promise to ignore any shiny new toys that appear on
> list that are not regression fixes to topics merged to 'master'
> since the end of the previous cycle to make sure people are not
> distracted.

Based on what I see in 'next' (midx, range-diff, etc), I quite like
this idea.  In private I may still have ideas for new features and
hack away at them but I would avoid sending new feature topics and
would focus on helping polish what's already been sent out.  Let's
make 2.19 easy for people to adopt.

For whatever that's worth.  I'm only one person; others may have their
own wishes.

Thanks,
Jonathan
