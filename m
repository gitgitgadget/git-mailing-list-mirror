Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A211FA14
	for <e@80x24.org>; Thu, 13 Apr 2017 00:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755405AbdDMAnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 20:43:00 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35824 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdDMAm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 20:42:58 -0400
Received: by mail-pg0-f51.google.com with SMTP id 72so13911229pge.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N5bHCURUJHKjTkEp2HEGQWItEJM7SUvB71NielJe8fo=;
        b=hh4EoTOX4wss+43b4wbfkQ3khya8l7YXrIDIZ4d18W8zL6xY+WEcxI6wvQYuLjSGqC
         8LuVMv0LPqwMg+OAp9sfTfPF8SGOL/P2jLKoJHZBxM6oBZhIPJLZY0r03zkbmxrSMjKu
         0niObc1+Bv3njh54sB1BaGgGwi4gSQvwDXmLSQ/WQhUrnzp6R0Y3yVeryTbaGv/q/JnZ
         vzLJ63kLA2ME8A6gvK1rBGAla3pkfedZnXwAnyQIhGBovzGUwZysVQxUc6OW5iyaCXkr
         CmSPKG0vn3GveBy1Qf/YOamDXSAj+IWB0u+1E1dPqqEGk9c0LZvBCkwQSqI3v53/8lTc
         qxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N5bHCURUJHKjTkEp2HEGQWItEJM7SUvB71NielJe8fo=;
        b=XYQsonmRiLVpA5bRhKNPBbigaCR/+XJi5WXXaz1mT7GpzWVI6CxjU3Bwbf5o754UoL
         Ru2UyNk+to1cagrawDK2I2S/9PXuJ5fWjPA4IBi5m6bYK3VYfYdn5o1C1pkzlm8ZrL4e
         Ub/gFwz0nwp+4tSTgU24reN27MJxnumPPPEyWO/z7wJj53Fq7pZBPHOnmtk/d0nbSIrn
         PnLIYC/4Z5jH/4GtRhS+F8SgGj0+PvskEJV1KKIJp9tmFKUiKh0kU+PORDF3HNC3A1mp
         sqIP4dVcSJZv6AWxCctEmorwG9FN8B3nwSLuYYjx0E1Mka99mWzNCreXiY/13EfEAcl5
         OnNg==
X-Gm-Message-State: AN3rC/7zGkkDZqin+kbsjn29FL4sRyFP9kyeK4/zvfPDm/U+n7GeoGYN
        KDhr8F8xAEV7R+F5QbhMXmkoMGmh0U1R
X-Received: by 10.99.56.66 with SMTP id h2mr504686pgn.40.1492044177712; Wed,
 12 Apr 2017 17:42:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Wed, 12 Apr 2017 17:42:57 -0700 (PDT)
In-Reply-To: <1491442767-54068-2-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com> <1491442767-54068-2-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Apr 2017 17:42:57 -0700
Message-ID: <CAGZ79kaH0ihJ-zFX5zdK-av0Aqxi1ebCEqj5smb2Zu9pKRG8oA@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] dir_iterator: add tests for dir_iterator API
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 6:39 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:

> +int cmd_main(int argc, const char **argv) {

Style (minor nit, in case resend is needed):

We only put the { brace on the same line for statements
(if, for, while, switch), not for function declarations.

I tried to find a good rationale for it, this is the most sufficient I
could find
https://www.kernel.org/doc/Documentation/process/coding-style.rst
(section 3):

    Heretic people all over the world have claimed that this inconsistency
    is ...  well ...  inconsistent, but all right-thinking people know that
    (a) K&R are **right** and (b) K&R are right.  Besides, functions are
    special anyway (you can't nest them in C).
