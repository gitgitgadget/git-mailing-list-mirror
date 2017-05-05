Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B0A207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdEETbl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:31:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33605 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdEETbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:31:40 -0400
Received: by mail-it0-f66.google.com with SMTP id v135so1952741itv.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1p8Jt7n3GZpuHR9I7Jfx3PD4J2qRL90aiNoRWehPDn0=;
        b=sSm4B87r3s9Ycxek5KDTp8B3jkyXjwgUs5REyT4oY8ozeSRI7iKhGyNX1fQ/1wOCLP
         ucax8Csu2GUeVQyskftExeONLjfynTtGBRSb3QAN8s2MrnurjGKz4YZrLUVwLIXU3pYb
         Y87UN1wmriNfKs5QdoCpddez5MRcJ9aW4wT/ET8QqC5DdvC9VnJALcX6Bwu+h5wWqZUL
         RGlon1m0Z5ag0VNSBRh2aqVBfe9/UPfZ1NA8wHfbxI/y+Gd+jkaZhXVlTz3WugGc7T28
         qFw9Fvu9eJTg8A9NXAnzAr2+qbsFKB3vVhABr3QSKxOdcphO1qeLgpfM3mbD4QBAFet9
         O3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1p8Jt7n3GZpuHR9I7Jfx3PD4J2qRL90aiNoRWehPDn0=;
        b=J0R06lnppXYpJCU/RLHATOvc9Zljt0IzNOkaiXhXktsauATcr6VCj3HJIYhXhVjhJ9
         /UEhG0IuDKxe9BKeQyX5OewdSKQ8V/Ek4pcRrCvnTBXFR9CgwjTHzBkyw/aTczY9PUs5
         dZA5+XCqow1QJWbrjJsg7+lLzzRFDcaUUqbN78/SD/TwmJ/gK7VAwWfwOlbVqmLDxRAD
         TKqncpB8o2MrRp2NGKMdB6UI+TGSlWs96z3mJB2tmW6DnM7wbEo0cjIvPx/AAD3quF6W
         6USjBILUmdQJ3zksRRpsu4jPOKJXiYR9Bh+cFFxrX1USAeYckLSec4k2HzSpAgb9sJMm
         DGeg==
X-Gm-Message-State: AN3rC/4HVWZ0W4Nts8/OGlIDNnlfWJzzI6gCrubiI1yil7rpWoY0Vdbd
        rXj1mjjpksXdrtMsIkkU9nHkWtD4fg==
X-Received: by 10.36.89.207 with SMTP id p198mr10132744itb.71.1494012699540;
 Fri, 05 May 2017 12:31:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 12:31:18 -0700 (PDT)
In-Reply-To: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 5 May 2017 21:31:18 +0200
Message-ID: <CACBZZX6oTEToPPFF0LpAXBCru9_B+VcaBL=KQUjkUhNdyanF1g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 8:43 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> This series introduces git-add-interactive--helper (or should it be
> called git-add--interactive--helper?) as a builtin capable of doing
> what the Perl script's status_cmd() would do.

The existing script is git-add--interactive.perl, so
git-add--interactive--helper.c would be consistent with that, since
there's no git-add-interactive command.
