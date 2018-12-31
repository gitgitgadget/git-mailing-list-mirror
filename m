Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDC21F770
	for <e@80x24.org>; Mon, 31 Dec 2018 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeLaKw0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 05:52:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54582 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaKwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 05:52:25 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so35430348ita.4
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nf0wmg7Srdbxqoc6sn5jeJVSl1A5IWL+3R/4IL/6gMA=;
        b=SDQGCDex8Auwz3yhF7+l91jJ4UgQHQLgHDyCSajkXZI7IWgUVKlPHsu32Zgv4raOT4
         VJ6Dw/uEfEW5hM63R7sYgSqDnfmmQRoVvzmGpIA6LkU4Lbjcwiu0scZgJ6bQenEqqH5B
         P7+gpEAqytvsA2HK8+d5s826wSE9PWC1v652iRyqfJWa1zwPJhbY1ZOwqvQDyfzTejJe
         M+BtD+9yzL15Qqq9vaQF9Xt4DNp/8YfElKOjqlyFf7lIJQeE+55+6GbqKI9j5486fFv1
         V0hSURQhgOGeLgfOpseYdOq3T1txRAXrCcynajA4g6eTRiG9Pk+neGmYq3+/B63Vxika
         F11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf0wmg7Srdbxqoc6sn5jeJVSl1A5IWL+3R/4IL/6gMA=;
        b=jccMWp4Jt55Rt+u2dNPkmS3d/5iWF8jhBUO539K45bjnzx6/rXQF+1J0jF5GEos8bm
         NQFAeDu1lIKrl9KaBPjeS5xz9hASO05eRAdVPey5esoC01qxCAsi0c6QbswhuuYE4PHm
         cEmtTLB/PkChJZi3UGA6ZjIh9BPXrYFe77NiAQY0QERkCE9YxaLjcnW6mQaARZysUEy9
         m9IjDhx+MExon/NA/Zp43lheLhI8AEdr/XkYqsxpQwIR5izDnzqSUIuC2NEcCywIrD3g
         zuFsMbEHOB6vkJUASl7CbmLUwcsd51Qp09X+QaXk7LOltmxofhZ4N/HWxmJ9QohevAjm
         6ohA==
X-Gm-Message-State: AA+aEWb5pdtmX7z0vaBOeYNeBuIwi45h39P4zXMI/EW+YRC1P5f8AUMI
        LPQtceAZVZ5o+LqTrqg8BLfBb7iaCPkxDgzFIX4=
X-Google-Smtp-Source: AFSGD/WqmFS7O4ruKwO30T0AuSWJMPOFKXlUNGfEbB1gA1Flq26adGmsTTBnC5Nrzy3rlN1S24g5MN8pGUthrkl6HW0=
X-Received: by 2002:a02:8943:: with SMTP id u3mr23511079jaj.92.1546253544308;
 Mon, 31 Dec 2018 02:52:24 -0800 (PST)
MIME-Version: 1.0
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
In-Reply-To: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 31 Dec 2018 17:51:58 +0700
Message-ID: <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     Marc Balmer <marc@msys.ch>
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 31, 2018 at 5:44 PM Marc Balmer <marc@msys.ch> wrote:
>
> Hi
>
> One of the last three commits in git-subtree.sh introduced a regression leading to a segfault.
>
> Here is the error message when I try to split out my i18n files:
>
> $ git subtree split --prefix=i18n
> cache for e39a2a0c6431773a5d831eb3cb7f1cd40d0da623 already exists!
>    (Lots of output omitted)
> 436/627 (1819) [1455]       <- Stays at 436/ while the numbers in () and [] increase, then segfaults:
> /usr/libexec/git-core/git-subtree: line 751: 54693 Done                    eval "$grl"
>     54694 Segmentation fault      (core dumped) | while read rev parents; do

Do you still have this core dump? Could you run it and see if it's
"git" that crashed (and where) or "sh"?

>    process_split_commit "$rev" "$parents" 0;
> done
>
> Please note that this regression can not easily be reproduced, normally a subtree split just works.
>
> Reverting the last three commits "fixes" the issue.  So I kindly ask the last three commits to be reverted.

Please provide the SHA-1 of the "good" commit you tested.
-- 
Duy
