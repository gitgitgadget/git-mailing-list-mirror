Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2555220C11
	for <e@80x24.org>; Tue,  5 Dec 2017 10:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbdLEKhc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 05:37:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdLEKhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 05:37:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id n138so351408wmg.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 02:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WzZw2UawfsAE9l6Hd5MH8lOzuzUpQ2lyMZCRtMgdKeM=;
        b=Oo+MA4fM5l9edqrAJQmysVddQbk44KEi95mcAZizui8wV8RDB4aXqeQWLp/p5njUeA
         wUew7Jng5aXFULchgoVCI9OruOrKffP7D5q9Sl3UVaHWVCtJGP24znMoUWv1/zz2CgXo
         wobZdLs8g0TxzpnhXhhSc+zbOKfwxfGBN8exK7LcVeOiSjhyO1UK2CqkaUSpwFelkN2S
         ECU2Vvl7vM4UdPe1X0w0PeoEeB+LOvcXjHSU09sVYbrb9/fAyIRhJhhqpUEwReCT9oP/
         RBG8lcU/8Dx62z9muk6BfySu7VYYRrw1bZhClVMCeBxxQypWDd8mpVVaI8FnYZdBB6ZP
         b7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WzZw2UawfsAE9l6Hd5MH8lOzuzUpQ2lyMZCRtMgdKeM=;
        b=niAXtItKvXpv9O2fDNN6AzdJEc4tY65jw0gQtk0eCXJS/IS+Q38sqmZ0x7gMrc4ZiK
         VW6dnjI8kUjAqlobwUYOfqXAksoeSOj0UOq2BI+wnHosqTN9s+HUq72tk/jnQfUpC4HW
         CR/iFI/3bz7sH+nkWKjptHeyDUZwE5AJAGOVf9v3rg/vf30Er8OZevJAqAddiInWRAyM
         DsxddqcN6N/mXmWD2IiR5ZtKXHss8khJMN6a5uKvnwYBDhlAJxEavbT6uS3tGfDMcOaO
         feJhYGcLE8UHw/fhGx4Y2Ou/5uyqnlKPR9hZT5AYB0LkjG9HGv1Li+XyzW3KkmGHgdpZ
         mGCQ==
X-Gm-Message-State: AKGB3mKfedlOiGYL0Txc9z9mGQFPcHvXrml1S2pmUAqEuqwFyEy8pMBC
        NmhMTvVNcrB3cUsREu6+5hs=
X-Google-Smtp-Source: AGs4zMYDUkZVPPDJbYWzDjUno1sVXi2+G02/mKswVK8hvYcMBDzsxDm9LpEA+pPV9qVs0ASJxI9h1g==
X-Received: by 10.28.239.4 with SMTP id n4mr362577wmh.31.1512470250291;
        Tue, 05 Dec 2017 02:37:30 -0800 (PST)
Received: from [10.146.248.68] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c2sm18986931wrg.57.2017.12.05.02.37.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Dec 2017 02:37:29 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] progress: drop delay-threshold code
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171204220700.GB18828@sigill.intra.peff.net>
Date:   Tue, 5 Dec 2017 11:37:30 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, lars.schneider@autodesk.com,
        git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BBE0F8C1-2B9E-42B6-AE47-90C8A62A4F84@gmail.com>
References: <20171204220228.GA29422@sigill.intra.peff.net> <20171204220700.GB18828@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2017, at 23:07, Jeff King <peff@peff.net> wrote:
> 
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Since 180a9f2268 (provide a facility for "delayed" progress
> reporting, 2007-04-20), the progress code has allowed
> callers to skip showing progress if they have reached a
> percentage-threshold of the total work before the delay
> period passes.
> 
> But since 8aade107dd (progress: simplify "delayed" progress
> API, 2017-08-19), that parameter is not available to outside
> callers (we always passed zero after that commit, though
> that was corrected in the previous commit to "100%").
> 
> Let's drop the threshold code, which never triggers in
> any meaningful way.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I tweaked your patch slightly to clean up the now-simplified
> conditional.

Your first patch ("progress: set default delay threshold to 100%, not 0%")
as well as the modifications to this one look good to me. Feel free
to add my "Signed-off-by: Lars Schneider <larsxschneider@gmail.com>".

Thanks,
Lars


PS: How do you generate the commit references "hash (first line, date)"?
Git log pretty print?
