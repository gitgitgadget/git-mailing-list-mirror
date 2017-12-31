Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0261B1F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbdLaI7F (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:59:05 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36009 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdLaI7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:59:04 -0500
Received: by mail-qt0-f171.google.com with SMTP id a16so58257379qtj.3
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 00:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gmu98UhL/11xSHJM9nOtZJwdXNGX+J8ZMblBgJVPYnA=;
        b=gSb/pI7d9tz1fm+qPEPFFZj3lubkk/7mbzw8UPnIji4xg9ulmctWfRugyqheEBI7Dy
         95IE2AE9cdObSdszhHlwhGmBMDqKGQS7SJdPibFCydQSEEjQBdOhbqAp9sabIvSE/F4X
         29oENC1x2v7wTa8EZKmrpxLnwg2xW70Vlp7ipQuwPNbJljKJo7Mrfsn0rYZz7Yiu3M0l
         OzWZXmCb6IdXK/XHV0IYW5Js18s2siKNIrOW84saMGDxM8mdgV1/dbuN4bLoyuGo6d6S
         un9tZYQEKj4xMt0SV1/hHmR4YKhdriQw8luofhfMPLuHYIVTZ44/FlkI827cb+PXUs4W
         AYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gmu98UhL/11xSHJM9nOtZJwdXNGX+J8ZMblBgJVPYnA=;
        b=l/yNgct8RfkKmKiAsEjC6Qgs0U4MLAhejicBUNBHXxw1s05Xg3JuovNfIsu8KdAhOd
         ig2wueUcxyV5gSakZp0rxTk6NmzzzM8D+1Pf4i1t0+o2xszKMMMCppUAA/nFQ8Qnlzca
         CeG+p/gdMcjnzgGo7PxqM6gJob2tVRUS54NhhUpo+5nOo/pb4TjuAlpWSBPe0pFPk8zD
         BLkz9ng+TMnT49+GnIAC+TBHFYG3ecDjBg0sXH0H+d2A+R8ciBVz2JjOtNX2sPu2lBsY
         S9KJBvwaXNkXNOP+0rn4lWE+23ZicS8o+PK6OYLK91Q/2DfjawLZQQW1/3Kk0fLTYYfP
         59ig==
X-Gm-Message-State: AKGB3mLhHpjgpt0Yo0VpoCWL384D/pWkfMzfNZ5J5tuCfJixpJCKaAUz
        8jGAo7dQCdPiJpFXePLnpMbMtWxGePdm0Rvc7is=
X-Google-Smtp-Source: ACJfBottiTfH534EzjkZNigReBSODYnCjNJ5PnOK7TX8Rm679BAutCESGgA63Oi0dkB4nkK8+k+LPtJxpsOzt8oZ+S4=
X-Received: by 10.200.35.28 with SMTP id a28mr56884953qta.51.1514710743919;
 Sun, 31 Dec 2017 00:59:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sun, 31 Dec 2017 00:59:03 -0800 (PST)
In-Reply-To: <CAO2669gb9+VEEkS2Pa=ZNbA9FsZT2t-7MmG9Nc=-nmB3Rcicig@mail.gmail.com>
References: <CAO2669gb9+VEEkS2Pa=ZNbA9FsZT2t-7MmG9Nc=-nmB3Rcicig@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 31 Dec 2017 03:59:03 -0500
X-Google-Sender-Auth: OZqeaJjuumVlnwQyohxgF8quzP8
Message-ID: <CAPig+cQhL-r-V8tMtmn3cTB90=2sxFAk65zpzEvMM5rRHdH3Ow@mail.gmail.com>
Subject: Re: Segfault
To:     Andrew Tsykhonya <andrew.tsykhonya@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 4:04 AM, Andrew Tsykhonya
<andrew.tsykhonya@gmail.com> wrote:
> git stash pop resulted in crash:
> /usr/local/Cellar/git/2.10.2/libexec/git-core/git-stash: line 470:
> 14946 Segmentation fault: 11 git merge-recursive $b_tree -- $c_tree
> $w_tree
> although, the changes have been applied successfully.

Thanks for the problem report. Can you come up with a reproduction
recipe in order to help debug the problem?

Also, what happens if you update to a newer version of Git? You appear
to be running 2.10.2, whereas the latest version in Homebrew seems to
be 2.15.1.
