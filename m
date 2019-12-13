Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC0C80D5B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE65024784
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfLMTpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:45:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37798 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfLMTpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:45:04 -0500
Received: by mail-il1-f195.google.com with SMTP id h15so407793ile.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 11:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOycaEl2gbj5RQ4jnsuqAtgKBuY5xnp4xiEjYhPb0sE=;
        b=lNxG5YKmdBg4XnryYkgzppDtVn7u0hsrbXZYoaEk8dYWxW3hB22bp657NjxbB8SmJc
         /UHznWuA1w/GrFO3pXo39C8ek1aKthqKJ+7CD8u8kHjT+tDOqAB3CXsmfF4Z5trNfymy
         11qAeZqgk8rrUI2OeTtQTlRXd3cSqG/HcENCMxeL3/3Vvpx1IbR/l0RknK4Klm82tUs4
         k0ezAppYZTAd6rSyRyN036WV8Rgn7K2XBGjmoGfeQCG7bBByldQJmZTTe7NabD1oUUwL
         r/fbBsOQLVUVYTTW6vhYBs8k2SNgooAO5jyk1GVH9lo2cEMebZV8QBeoVk7OLdOxz4L5
         OJ4Q==
X-Gm-Message-State: APjAAAXCZbSWBr5UCpwwY0kXEvXitj371pkE4f+aiGB17rPoGeL5wikC
        i9Xr4KRy6+rL9ASscWvnAamUxIeB+O45+RP7+wU=
X-Google-Smtp-Source: APXvYqza+y5EzHVPY2enrHpG88EGInf/mV6KbtlFU+xaBtxRuCHeGO8B9rCDeBp1WanhChyXbiZBbnpH5asn9G+TMog=
X-Received: by 2002:a92:cbd2:: with SMTP id s18mr975879ilq.98.1576266303962;
 Fri, 13 Dec 2019 11:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20191213173902.71541-1-emaste@FreeBSD.org> <20191213175535.87725-1-emaste@FreeBSD.org>
 <0c9d891e-382f-03d1-bcbd-d652f1d58f4d@kdbg.org>
In-Reply-To: <0c9d891e-382f-03d1-bcbd-d652f1d58f4d@kdbg.org>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 13 Dec 2019 10:58:40 -0500
Message-ID: <CAPyFy2B_P7qJ+ocg8rzNWEZWo2uKzaZsfYRvvhwUbAXv2AB6pg@mail.gmail.com>
Subject: Re: [PATCH v2] userdiff: remove empty subexpression from elixir regex
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, lukasz@niemier.pl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Dec 2019 at 14:24, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 13.12.19 um 18:55 schrieb Ed Maste:
> > The regex failed to compile on FreeBSD.
> >
> > Fixes: a807200f67588f6e
>
> Having a references is this form is unusual for our codebase. (Not that
> I mind a lot, though.) I expect that Junio will commit the fix on top of
> the commit that introduced the bogus regex anyway (branch
> ln/userdiff-elixir), and then it will be easy find.

Ok, I picked this up from the Linux kernel where someone added a
Fixes: tag to one of my changes (which had the hash of the original
change as part of the commit message body).

> > Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> > ---
> > Add /* -- */ to make things more clear and be consistent with other
> > patterns.
>
> This text would be nice to have in the commit message.

Ah, I didn't think it was remarkable (it's consistent with all of the
existing entries) but the change is indeed broader than what the
commit message implies. I'm happy to send a v3 with an amended commit
message if that's desired.
