Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5C3208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeHFTVY (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:21:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41313 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHFTVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:21:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so7168074pfn.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eW4J1QCpZzI184aLndVFsh/NMUTT5H8faHjHj+jRD4c=;
        b=pjt0T/Jyl+DfO2otN2JZkW+/gWixC2feYLt/BW85daomBF9BOg4cuJdNQXdrdBcQF9
         /6OZBkUKQQyZiiggpBULS3BRmms4bp6iHTomirjGcnglkFvs6B3+t/4LTXUKqu0wn1Go
         qbe23zdN8KnlP+A8ITumljVSszT6+3xMMABJxoRErrtzSqwNztO5IOzi74jiCa9MAky4
         Dkc1ZZjxjVlY1CawLhYf7Nv3ShpIaaKnbMTsVMJwBiBM81q/76Sb105g24WnYYBMiWtG
         VJAnke4xCuMlNc3MFvHcLiwOivBPXp27DWuQatZiYn06W4St9opHrqiFuBb6kNuxNe/I
         04fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eW4J1QCpZzI184aLndVFsh/NMUTT5H8faHjHj+jRD4c=;
        b=Ed5yESYd5O5Vo3cJUjZAdJbKA2B5Yi1+PYzkeIwBsN+r94B393buguQesq42khoFWO
         3SWxNsVDJH6nXy6kDPllMs0ZbEZe8nTsm0Jji5A+gbgEkTlAiUJ4xrUq0trugbYHVvya
         uqaJXM3daPGQ3AiNbnBwQQDS+GWhyRx9sttnLIOlCw9QksKDtj1Qbgb16vlpQ09Mq86V
         R3axKd/fo8tjb7iuBlAP3rA4GPH6H/USl6IGiXVKeffyV82Nn9yI/3d9wCrPWPmqMf/k
         Rq2oI0M6OWbVcrmEdpR1Sh/FRZxtqtC/rxUBSWBhhZsraUy6XMzLP7OvfseZe1Leit8B
         UpUA==
X-Gm-Message-State: AOUpUlEnVZFOuD5SHpXvIgUEGLl3u9Eig9HqFpWi3vv6o4j9Ced9Xlw+
        5KoGZ5kpeSK/tUfVR86Bh64=
X-Google-Smtp-Source: AAOMgpfr6CVbwLcKr0g940DGJiPDzHQxp9LnJCZrOKjMqCNmyKka8AkC8oBYtOlZQuhMxpEq0UgWBQ==
X-Received: by 2002:a63:c252:: with SMTP id l18-v6mr15228249pgg.76.1533575482062;
        Mon, 06 Aug 2018 10:11:22 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u9-v6sm26261300pfi.104.2018.08.06.10.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:11:21 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:11:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180806171119.GC120433@aiede.svl.corp.google.com>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
 <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
 <87zhxzsb2p.fsf@evledraar.gmail.com>
 <20180806170211.GD19053@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806170211.GD19053@sigill.intra.peff.net>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> I had the impression that DEVELOPER=1 was allowed to set flags that old
> versions might not even know about. Hence they might actually barf, even
> without -Werror.

Yes.

[...]
> We're developers ourselves, and we interact with new developers that we
> want to help.  But there are masses of people[1] building Git who are
> _not_ developers, and want the default to be as robust as possible.
> They're probably not going to show up in this thread.
>
> -Peff
>
> [1] I actually wonder how large that mass is. Clearly there are many
>     orders of magnitude more users than there are developers. But I have
>     no idea what percentage of them build from source versus using
>     somebody else's binary package.

Relatedly, we need to think about the incentives these defaults
create.  Personally, I want *more* naive users to be building from
source, because then they are better able to test recent versions,
bisect, test my patches, etc.

As I hinted in my earlier reply, I think it would be best to try some
basic things to make DEVELOPER more visible first.  If that fails,
then we can revisit how to make this more drastic change in a way that
minimizes the harm (and I am not sure yet that that is possible).

Thanks,
Jonathan
