Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FA31F404
	for <e@80x24.org>; Mon, 19 Mar 2018 03:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755054AbeCSDHp (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 23:07:45 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43015 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755032AbeCSDHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 23:07:42 -0400
Received: by mail-qk0-f169.google.com with SMTP id g184so16867048qkd.10
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ViAGQ7wYeKnNIiq882ZyPdjAjYFzy6mKguyQEmlrO9c=;
        b=WqF9hg3dcHqIuc1biCNzLb3BmSHdnZFNCX7NuKiLYDtXItZiHMP0dVTeRU2816dpT9
         g2/VwLJfjIujsBeUWhtcerLGQDiWbOMUrDBhUnZxpomBUV8VQQy8SbxnWf8cHHsSslDf
         +kdevnjW4e0nvLu4UqxoBMZTlZLQ2PSE3sxagP7R68MIw3La2D8yCYaUkZwLeQO+yqnY
         vTEbZlgGYzK6yLmFlb9cSD/YCfVjdgtcRC26/U3N32jK5GNLq5lDixLXRNy5+LOco9FV
         T4olE7rdjU1tjKM6eJ2CoXpL+NULxo8o78AZ3Sp6dtG4nnHCJhv8AJZ32K906NuLm80E
         qiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ViAGQ7wYeKnNIiq882ZyPdjAjYFzy6mKguyQEmlrO9c=;
        b=YF7JsdXPSv8mNgc5d7BuHr66vpcn9uphfRorQvh/Mb+4BN7e//8aIU6GaubfKYV7DF
         zXDjU5PagKj0nn3vaULV49/BEUg4rK2E9H91PCmp8SoSCjivqZWJZyua+gLrIpgqbPjC
         eSl48jPK8N2ztruUOGjtbS3Fhvm9xjV/c1iigcQVHd+OTL0/Z1kMqWrfSfaPeL4BeSdM
         hc2MgAFvViYhVNxXlR+K+mE8VtfZhNHgokULN57s7qRGqZZdqhJ2gUqoolTHxoxzQ4DT
         ZrL07Cqv/jWTtmFimDYBU8ly+L8pO+MOXehbmaVz43gv/cNjoJZy1kJY6WIDG3vZBDuS
         0NlQ==
X-Gm-Message-State: AElRT7Hanp9o1oKPvA6BxO4Gc5HTBWaqrxQg9aH6QZXL4zznM+XjREdu
        Gl2p4FaSGrQ9RqMFv07qMnpS3878vXtfCxa062U=
X-Google-Smtp-Source: AG47ELvG5WrxpOAtKcV2OjK1yMnmiDBZGjRzpRxj1rXYFn1uTkonfyaMycJDovdrK6QmYL+iHnjgLjrTioBHgL9+gTU=
X-Received: by 10.55.74.2 with SMTP id x2mr15045826qka.314.1521428861689; Sun,
 18 Mar 2018 20:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 20:07:41 -0700 (PDT)
In-Reply-To: <20180319025046.58052-2-dnj@google.com>
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-2-dnj@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 23:07:41 -0400
X-Google-Sender-Auth: C9rglIQ42XEw1Kfqb7GjANtlaJk
Message-ID: <CAPig+cRPX9fHdco-g0GOUCwMr5Sh=hdBTAtUHyYSpKPherRd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Makefile: generate Perl header from template file
To:     Dan Jacques <dnj@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 10:50 PM, Dan Jacques <dnj@google.com> wrote:
> Currently, the generated Perl script headers are emitted by commands in
> the Makefile. This mechanism restricts options to introduce alternative
> header content, needed by Perl runtime prefix support, and obscures the
> origin of the Perl script header.
>
> Change the Makefile to generate a header by processing a template file and
> move the header content into the "perl/" subdirectory. The processed
> generated will now be stored in the "GIT-PERL-HEADER" file. This allows

"processed generated"?

> the content of the Perl header to be controlled by changing the path of
> the template in the Makefile.
>
> Signed-off-by: Dan Jacques <dnj@google.com>
