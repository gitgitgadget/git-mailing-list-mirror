Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43651F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeIOVn4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:43:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34329 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOVn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:43:56 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so8401510iob.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z44exRlwTyu0wdhWWsmNDjGYCZcgBFVTYn6bvlOPqcw=;
        b=IWKRKySX4ALcZ9EuVvXykvbO9uPTtV7HQRyLECCiU1ZBsIi/GWkAJ6qER3qAVlz5y1
         0WZFyatArggotAAt7S/EG/ltwA3bsmUeJbVx2wbQ0h5r7WV3SMIpB81MJhVVjDx4Gq+4
         0d2wmOp3RG+OEzTqFhzjbTx9CkwgxIa6iqBM8oAdEBNvVGyFWEVeCBhAWHdlwKx5SiPW
         A3kwEleyZ36wBSJHXqfQ4RyJL2DMry8DM7knasyFWu9yJp0erULoRf71dkHzPqwL/yRu
         v1Co1pVMnIYtDfWBFBE5f7I37HiPEPXxgv5yNNPrNSDQJiZ6HuLmfhVFt/2TSZde21Yw
         3aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z44exRlwTyu0wdhWWsmNDjGYCZcgBFVTYn6bvlOPqcw=;
        b=n7kbE2yjZiW82msCe7BIt58xOsjA/p3b7mZDxCFmbY8eYFcEet6dVJwTUkxIMY5F0P
         VUQBLyRolpHG4sUBdV2RWt6SjGN3ln4r4bdJrFdJM24iKSqK2tYHaQ1naknvxn90QleA
         AbZFk/XbDz/Sdt4dYn9j+9hlH1YhnfLLwmz3i3Cj5SmcyzHwUc6wThB8P5LtIwdvjet1
         AtSvecz6ALjA0VKzqJOqdRH7Utst80yg/8LH2nEwpq3TpGFqcaV1lQr46wMSOuVX7lcR
         5QhGSpjqQ+1IfT02S62vuEMUQMMY050kwWvM5JGh/7Vor7YgEzLErn8nWx3W59F748bU
         cq7w==
X-Gm-Message-State: APzg51BLUvMDHJjII+EXK/6gAUfdF0K9A6yXpjQuD30jCtQ3UoR1rHob
        ul2wdljeQbmmP1W5GJudfWq7cmmjBglMs6dPs18=
X-Google-Smtp-Source: ANB0VdbRtpccha5g4QzSHLH/5nuHyYNW2coToyFJA0bScsk3idXFckgJGLE0g7Uvvp2cI6qE1edCcrKw2ezCwfepj/g=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr13667881ioe.282.1537028665631;
 Sat, 15 Sep 2018 09:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-3-benpeart@microsoft.com>
 <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
In-Reply-To: <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 18:23:59 +0200
Message-ID: <CACsJy8DtYrB99_7GyZaHsLTG8Ff7Mt_hENwhLE6_x6b5zzQ9Hg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 15, 2018 at 12:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> Wait there's no way to disable this parallel reading? Does not sound
> right. And  if ordinary numbers mean the number of threads then 0
> should mean no threading. Auto detection could have a new keyword,
> like 'auto'.

My bad. Disabling threading means _1_ thread. What was I thinking...
-- 
Duy
