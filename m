Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4F21F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDEWkF (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:40:05 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36332 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeDEWkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:40:04 -0400
Received: by mail-qt0-f174.google.com with SMTP id w23so20596756qtn.3
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y7/XOqa5VR1SiXUJirjsYUFzo6xElnEi4Z641GWE19U=;
        b=tVKeRtzMO15P/B8r8LDjcd8MsxDQBmiBbGtlR80+7uC93twGCoT4t85KXKMPLtest+
         1ynNn02o6TXQXFKT48Xnlj250RSUXsiXloU/G7ZotXM5JsONBfd6NPvY/N35BCJXLYnf
         YJqMdGlOPWMmN/EdWQ8zrru8Uc2Ju+DZEqFLCLwjGj5RWc83hfo9XFtJaOfQh3oXI/v3
         koUTp2plmEjznxHKT42L3ARumGzsXEpxiVfg14dnZprCC8mYFaQh+mPMBEDXxPU2g5Yk
         d9GIWMAr5vE4HO0872+Vq7iOb4EtbK9277BsP/V1lfzTRwV6+T41ITmpqT4aeOpIfGQY
         Ol6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y7/XOqa5VR1SiXUJirjsYUFzo6xElnEi4Z641GWE19U=;
        b=Y3Biw+MUzNFHCe4d/k2hx5yZQkmy4wM5iGhcqVBAHy4QyKfEdlS8AfXOcgDWNxmiHl
         0Gn6xTJgQPvs4ww0w4giJtBguR7/3ViQCsB7L57g78he3Xnt+EUaffXpBp1LlJSw1B14
         1m0TbS8VVE+mLXQ1ghpY2FUIVhtAQaQnYeCNcUtWqCyIGQNgJaie5wGS/yX3NVVxBUPJ
         aIJy5/CExS0eJJqzHl20bFNM58D0E409S1N2I3h0M9C8elx2hsT0bHOZKghXzkpbrItg
         EmgEUai51Ch33HfQr8PnW4egaRAJWyD33j0eYNdRISZvt91yVVnutc/n/Z1xhRvy4ZJG
         T8gg==
X-Gm-Message-State: ALQs6tC8kCY0TOBqO0DOQETSlAMqjU/+JZKF0k/C39fC3jIw/poWhBxL
        yL21zouiiH5gdZMPJ+xoS5od2yHDjoZpROgM7YA=
X-Google-Smtp-Source: AIpwx49jJx1m2c62C4HBItcKSMz6p8GzRmkqgi39wxlGGLtYhTdPmouwCj3Y46gXiXUxOzZb+dRFuJoD/L6w20YhjcI=
X-Received: by 10.200.42.37 with SMTP id k34mr35618549qtk.101.1522968003523;
 Thu, 05 Apr 2018 15:40:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 15:40:03 -0700 (PDT)
In-Reply-To: <20180405025912.GB49902@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com> <cover.1522896713.git.me@ttaylorr.com>
 <20180405025912.GB49902@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 18:40:03 -0400
X-Google-Sender-Auth: SrMzaMN_MfObkY3g3t9R6Z4UUWY
Message-ID: <CAPig+cQwj8tqJToKU0_emHHC+mdtpPS666XJ7sqentMAFoLivw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 10:59 PM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> This commit (and those following it in this series) aim to eventually
> replace `--get-color` with a consistent alternative. By introducing
> `--default`, we allow the `--get-color` action to be promoted to a
> `--type=color` type specifier, retaining the "fallback" behavior via the
> `--default` flag introduced in this commit.
> [...]
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -235,6 +235,10 @@ Valid `<type>`'s include:
> +--default value::

This should be typeset as: --default <value>

> +  When using `--get`, and the requested slot is not found, behave as if value
> +  were the value assigned to the that slot.

And you might use "behaves as if <value>" in the body as well (though
I think Git documentation isn't terribly consistent about typesetting
as "<value>" in the body, so I don't insist upon it).
