Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231841F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJ3BGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:06:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38824 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeJ3BGK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:06:10 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so10083713ita.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ok2UuII6D6UqVqVUBCl20aEbNdQ2bMPjdcDZA1REuAg=;
        b=lf0zJdOHBjCn7lwSsiOVKxENgC4MNisVOfmtajPFhrgXp8VtQYqXgmW0APe81Iv3RQ
         adEBgBqEm6o1EwUjfTgxOYLgev2BA49bn1hP6oQDWtaOBLtZh2Brf/ZfWKa/YagqxCpW
         DTFt3cUvGaOovv7TvRTzMwvpHq3kja18i5Zhkn8Fx+u6IrkY5q8IF9ioataEK4kddSI7
         bWaIJhhgp6+oYE8hDVJ2xWDXDoTlKqpTreVmhzKRerCOVef1v3sejmGw01RjRbMkPCSn
         xMHtJsjLlVO+TAu9zyDO6h6uoF9quWyDSweLjNGAdpNl41XVI7ON08w0V5MlTx8Hg2a0
         KiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ok2UuII6D6UqVqVUBCl20aEbNdQ2bMPjdcDZA1REuAg=;
        b=PeWI8cYBbud+0IQNXQAEZefkIy4VosAHB1wVYpd2GoyuDzo5smxExp4eM0Nx/eE9Sh
         qgR3rXbApdEndUcQ+MtsAnn4wzsQyETB6Bq6TKnllx+c1OGACZjy4oK0cJ1qyFN4eenZ
         chjkKE3WXLdy0lp7wjLi2uQ0eS4OX5UN7U95biysTs0wP1e1ATEv6+KlBbxdpf43VpEr
         m0tm51OS71xxSl+JUzvkHp/kUIT0rpF0IzMiN0yRMLb7B5h5wVImGrUEOB2rWkgwv8u2
         GanYl6N2v/IAPd9xXOEec1CJ0F9Wd/PwqVp37qMulI4DYJD17FNJDcUM3OKex4PlYc92
         IGow==
X-Gm-Message-State: AGRZ1gK0XhFgKiRm5thjFZWPmtVX5ktpSNuEubjF10rdMBUiNXYKlnxe
        K4svuGZaz+rl8ZymBSlHp7eNXseAG6FiayGO/zw=
X-Google-Smtp-Source: AJdET5fJztn8DeEKzIgYpQi/LozW5zbYJNpS7jyVbL0jJnOfA3+RsLlAG8Xd84F7ic6Rge9gUGjUK/Tia80ItAsDh2s=
X-Received: by 2002:a02:9795:: with SMTP id s21-v6mr10260309jaj.92.1540829814145;
 Mon, 29 Oct 2018 09:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181028065157.26727-9-pclouds@gmail.com>
 <xmqq36sp425p.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36sp425p.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 17:16:25 +0100
Message-ID: <CACsJy8DZ2d-qReY-LZTg50dc1Y-N_iXsUPNi3OnrVdL7ZLR9Eg@mail.gmail.com>
Subject: Re: [PATCH 08/12] remote.c: mark messages for translation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> There are other series in flight that touch the same area of code
> and in different ways, causing unnecessary conflicts, which does not
> help us either X-<.

I will of course fix all other comments, but I can hold this off if
it's causing too much trouble. I'm in no hurry to get anything merged
fast.
-- 
Duy
