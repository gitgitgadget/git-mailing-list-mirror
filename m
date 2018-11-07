Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AC91F453
	for <e@80x24.org>; Wed,  7 Nov 2018 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeKGKQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:16:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42904 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeKGKQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 05:16:39 -0500
Received: by mail-io1-f66.google.com with SMTP id h19-v6so10705060iog.9
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 16:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5cNUxfO6mu1p+qDN+5AdBXeBdLxU4XrnOB/vjt0NvQ=;
        b=iWqs56arbp6LmDWz0f7F22q59rHY9N/hYpUOyNxriYtEJbRhbWKBncsNL/Olu99+NH
         DFfz9OYxy2HEBeR2cU52+Zy+o0JrRsg7G5MTew99jlx6GpSYMdODs3zxqGy0lnLJO1K2
         S7xX6ok9Ay65ePEaY5zIO+R4KwharvsNV+c0zHkZtGhiEH6FSe8gYQ2geOs1hiDrYQBI
         /EwuWvD8Bi2CqYlgzb6NhdW1bQlNxQ9U2QItFG1TlPLtWJG5cv8yKPgPatJUEThiYUmL
         o5Y54tx6ylElYolADECw5XhQ8B5hV+1WQn0u8vO59ah1twC1SBP4YebbFFlH2FuZIHBT
         jMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5cNUxfO6mu1p+qDN+5AdBXeBdLxU4XrnOB/vjt0NvQ=;
        b=nYmwNXdc1IKotAhV4UAK4vScz7sC/KMq0sd/XM3NiqK++//k3r6/CJFwzguhKa7Gg9
         CBQY0BpfFy/J6d34RlCPyDAdva1PswpPFfwN081vyu1HsbrkEM6qMsgSNg7UNIrAoFYr
         OYCY2EGdxAaefQioBND37R746gYSmOIPbgS3h/Vvebz1Z12iPnmGy/Xy6VTLsbeuWr0h
         LxGFD1EjgRW8m32uE88V0kDDyb+w2A/HcCw+fU345pDWltBpfddiRwDOjLwOqozkb7HX
         eM8zYqlSWK6KxFwCuy/RdYz2SZ8lP2KTAjIBB3mbKKv5UcXOomUrTIWA484zTkG65qhz
         f7LQ==
X-Gm-Message-State: AGRZ1gJEEujEvE6WlP193b4V5ld9/4VkM6xTWyqMrQh/W8iLYMDm6//e
        vPnJm6SQyRWd6DvNHdDxktl7jyxRDhclXi+aRKktKSwn
X-Google-Smtp-Source: AJdET5fYAGnHln3EN2ysGK8jHOZ5NQmet8cPKQUAtCFSpWFDEyUqDxgA+furX7wgFZm7VzgXgFGHXpBWVEOTNQdsQ4E=
X-Received: by 2002:a6b:b3c2:: with SMTP id c185-v6mr5835389iof.169.1541551720866;
 Tue, 06 Nov 2018 16:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20181102052239.GA19162@sigill.intra.peff.net> <20181102052309.GB19234@sigill.intra.peff.net>
In-Reply-To: <20181102052309.GB19234@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 6 Nov 2018 16:48:28 -0800
Message-ID: <CAPUEspi12TtKxKGr=tutfLPNPWhaZmGCh7q4D1LRJ9LFTWwKNA@mail.gmail.com>
Subject: Re: [PATCH 2/3] approxidate: handle pending number for "specials"
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 10:24 PM Jeff King <peff@peff.net> wrote:
>
>  static void date_yesterday(struct tm *tm, struct tm *now, int *num)
>  {
> +       *num = 0;

the only caller (date_time) for this sends num = NULL, so this
triggers a segfault.

the only reference I could find to that apparently unused parameter comes from:
93cfa7c7a8 ("approxidate_careful() reports errorneous date string", 2010-01-26)
and seems to indicate it is optional and therefore a check for NULL
might make sense for all other cases

Carlo
