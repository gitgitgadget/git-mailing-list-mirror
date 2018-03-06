Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608071F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeCFUT1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:19:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53718 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeCFUT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:19:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id e194so615132wmd.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbwmHhdKeAj5CHFdIby/wumWn7Y6/kwJZl0hhjcMoww=;
        b=E33tAGcMrB17BKLCnDZqAoIjzSCToOEXfevyW6mfqJvYHMlgbyn4U4iEP57Ti4LhGa
         E4PlMEqI4tlHKIvIV8JXhQcp7D37136PVAbvxR0AC4j/LmrT6KyoUYoj++Bi1omMChwU
         qW4Imr0Tb20bhlb/UjZdFNRrodWM5xoWfWap654p24qRbh1HEDsbqmr8SsYJjl5xrLzs
         lHHkI0iZrWJt3Dfvfo1+hkxHQOlTcDTzL9aZD8lif6VOiYsxAWjr/BPAnFiqJTA7/Hc4
         4vafTKKjmYTpB+mBrrJmG53rRjgk9pzSkqqzTfkw5EjGbc2r+AD71IMDoKZGxvfNq9Sc
         tP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbwmHhdKeAj5CHFdIby/wumWn7Y6/kwJZl0hhjcMoww=;
        b=H01rPPMHoLMoqTAvWTVblIvAmG/zpxQwezm+lojb27USQIzGiSQv2F0f76p/Wsh6JV
         nTPK653KskLF4HD29hSiLdRd3C6xsCF7XLEpQ+786JE9DZCa0Kve3OJrc0h/BgwGCYA/
         WtJ4QvlC+GV/8db/tOOjJtv0S2+ZjVxOIxDqq2t4xgoaFUpgg4Huaa5f5DBii6KP93sT
         M+fmOB7GVnE5MOlXW5DueLSGC29ZB0xjAXnAUXfD+OWu79GQX6Wlise8x+NwFCkjdw2E
         FyXQml2P/lzxGyD3WWTUsAeDQ2o4i7xMAxpwONswo6sIf5vBlmAVKB1jLVqO5NSjSReD
         Tmxw==
X-Gm-Message-State: AElRT7Hbr2nPIsTGM7C3NMAfJ7fh5ekG/1UqU5vm2p7Kwg25sNTW05Ya
        Ifuuahq/SQwKQXESmyUz7/o=
X-Google-Smtp-Source: AG47ELsAsRIm3naDM1hMWN72jr8QxrvSH1XsDFUc1Zm3ovby103HIo2X/4Pd+5hUm9HvIj/kGQ5uqw==
X-Received: by 10.28.160.26 with SMTP id j26mr11601220wme.76.1520367565791;
        Tue, 06 Mar 2018 12:19:25 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id o11sm14119182wrg.91.2018.03.06.12.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 12:19:24 -0800 (PST)
Subject: Re: [PATCH v2 0/3] add -p: select individual hunk lines
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <64005dad-ec23-892c-4270-b01cae74f663@gmail.com>
Date:   Tue, 6 Mar 2018 21:19:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306101750.18794-1-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 06/03/2018 11:17, Phillip Wood wrote:
> 
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> I've added some documentation to git-add.txt for the new selection
> mode and cleaned up some style issues, otherwise these are unchanged
> since v1.  These patches build on top of the recount fixes in [1]. The
> commit message for the first patch describes the motivation:
> 
> "When I end up editing hunks it is almost always because I want to
> stage a subset of the lines in the hunk. Doing this by editing the
> hunk is inconvenient and error prone (especially so if the patch is
> going to be reversed before being applied). Instead offer an option
> for add -p to stage individual lines. When the user presses 'l' the
> hunk is redrawn with labels by the insertions and deletions and they
> are prompted to enter a list of the lines they wish to stage. Ranges
> of lines may be specified using 'a-b' where either 'a' or 'b' may be
> omitted to mean all lines from 'a' to the end of the hunk or all lines
> from 1 upto and including 'b'."
> 
> [1] https://public-inbox.org/git/xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com/T/#m01d0f1af90f32b698e583b56f8e53b986bcec7c6

Nice, thank you :)

A small nitpick - I see you use phrasing like "select lines", where 
the other commands usually talk about "staging", instead, so "stage 
lines" might be more aligned with the existing text.

I`ll quickly go through the patches regarding this (not being of much 
help for the code itself at the moment, sorry!).

Regards, Buga
