Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9021F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHMSuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:50:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36735 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMSuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:50:02 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so14805089itp.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEVTLF/bsz5fZKGpBD5/wlQcesgnlIu2/he0WssZzz8=;
        b=WbFTlSPBZfBT/Aw/ApqKpaRwuSdFc24CvJJ/hei0An/k0tSJhMJWDoh2FBA7AaUMmM
         f0QCrnRuSJ/hZQFHZ3raucJbTADuftfoTPsSAGM6aovCkc9LBhOq3Y03cWZZd1emeabC
         zC+PbbYgt2FYPaYAzSggZVL5+hD+BVLXmjWRKKmqfGYB9DvlXGTiLKgnN+TmiaralLQ8
         4W8j+ZmQuvT+h32Q0vO0wW7igDPL2h+gBd6UjBLt4qmAFqC9BM7S6blNJXAfvA7fXUqS
         65kDvwu/Rx3tlkSGuutFfikukjtKVUNTtplnfXq0u2kN5EMswyk+TXxfm9nPeDANQCPT
         TZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEVTLF/bsz5fZKGpBD5/wlQcesgnlIu2/he0WssZzz8=;
        b=jObYbOW41IF5VtQ8NwqfSvVa+HsWqYZRKwGgH7ZpLkJZWn4cVlh1BvqpOdRdoi3oM3
         8xVeKn2x5LrwQBI/ZHRHab8emRr0DGpCcsexg8qrOOcXtA37vv9Y5Ij+qNeh9HwBdWw5
         EIS2ZGEDC2yBx0v5QWCbOmy+DmaFVc1Rbg9vjNJT1Hmd0L7pZMG+8PvkBMBTfPY2yUGM
         jpkqxsAmBy64Jzed55pzWcxIqP7QSIbcM9PKM4sNH3v9eukrJtebJqtR3vMdGFV9+G7Y
         x3Z7V+iuT+bC1g54SOcG1bbv32sZ9mLxUvdwsQM0L5j30uRyFWx9srJqwuNJSbFFY9ZI
         J0jA==
X-Gm-Message-State: AOUpUlFOiRelw3xs6LtEnGLsRN6b7P9ELSYtQ2RfjGkdmi95XAAu/5Ec
        2fnT9wWPdOF3yb5iK4ReVTTWRrlIz+SXXEiVf8k=
X-Google-Smtp-Source: AA+uWPz+sBOD0bdNwQxK8smEQcm6vCvnfNYS6RSKkC7RqWWKiBVYYavPxz6a5DexH9uzO4xc4OtLjctE2hDznQNulu8=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr10940867itf.121.1534176430215;
 Mon, 13 Aug 2018 09:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180731180003.5421-1-alban.gruin@gmail.com> <20180810165147.4779-1-alban.gruin@gmail.com>
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 18:06:43 +0200
Message-ID: <CACsJy8B=4kKa5ZjQ6dL2H9LToOGdu2OzmexwpWkS+Tayphv1XA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v6 00/20] rebase -i: rewrite in C
To:     alban.gruin@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 6:54 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This patch series rewrite the interactive rebase from shell to C.

I was running some tests on 'pu' and ran git-rebase--interactive
without arguments because a test failed and I was wondering if it was
me. It showed this

> ~/w/ztemp $ ./git-rebase--interactive
fatal: ambiguous argument
'(null)...97004f10c7e6d1e784eb8a62bebdf529cd3b81f5': unknown revision
or path not in the working tree.
fatal: Use '--' to separate paths from revisions, like this:
fatal: 'git <command> [<revision>...] -- [<file>...]'

The "(null)" should not be printed out because it could actually
segfault on some other platforms. Just wanted to let you know.
Apologies if it's already reported and fixed, I didn't really read
this series.
-- 
Duy
