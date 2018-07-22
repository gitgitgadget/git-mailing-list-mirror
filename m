Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AE41F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeGVF7w (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 01:59:52 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36893 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeGVF7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 01:59:51 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so5754260ywg.4
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6cqnSbEeLI2IVARzV+vkUp+RCrTuPECY6ZmQEQghTg=;
        b=OIZ+SdMt0jdaE/AC4dqSB8rn+UsI7asFVJ/jPNKpY7Vu+/IFnxQAs5XXmrb7lRQqgm
         qt7GIj2d556tSa+I5m13zwElDJZnD8uV4Fk+1uCocNN5L9lcs8fRBovgeoV8gqse2UF7
         /SbpHqENxlo1fBK21w4BzwX/m12dqS9JJ4m99+xqp317ypYQr7HAquTogDXXk56ddBN5
         uwT70y/mPFPNeejXnu/OfoEL95pp3Uu5h3wMS8IgMblB0o+/BsZvm+44RzGwO5wdcj8+
         XoUizn/ZpDvcZzhqQJVTg0m2pDCGZLDR5ZcSNeF7olhk89rqBAi5n1kzfgKnOyIh/vbA
         6cLA==
X-Gm-Message-State: AOUpUlE4lz3V5jbEzsUw3cZa0OSXvAdlNjuDrg52i85fQPMjdYI0IGwM
        blU8bHmYv/JjHSKycBk7ed+ykPw/Fr4dDHXaJ+1cYQ==
X-Google-Smtp-Source: AAOMgpfGrZe28fkt0ThTTu6EBAS1hM4XxiAjDinVCweERUNwBhfKHQLSkL3i7h7KBMjIb9TcZpYzsMQDOP6ydzxA6/I=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr4065076ywk.74.1532235871949;
 Sat, 21 Jul 2018 22:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Jul 2018 01:04:20 -0400
Message-ID: <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 6:05 PM Thomas Rast via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> These are essentially lifted from https://github.com/trast/tbdiff, with
> light touch-ups to account for the command now being names `git

s/names/named/

> range-diff`.
>
> Apart from renaming `tbdiff` to `range-diff`, only one test case needed
> to be adjusted: 11 - 'changed message'.
>
> The underlying reason it had to be adjusted is that diff generation is
> sometimes ambiguous. In this case, a comment line and an empty line are
> added, but it is ambiguous whether they were added after the existing
> empty line, or whether an empty line and the comment line are added
> *before* the existing empty line. And apparently xdiff picks a different
> option here than Python's difflib.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
