Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1D220248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCHJiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:38:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHJiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:38:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id w6so20601709wrs.4
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1+w9dck0KNtViU3mltx7CwuK8crGzLioGr9mCT68w8=;
        b=DDqPWtpMjq8e2e2fkvlJlN6Rymm0vZZFu8DspmJcKBZs4Zbxn7LAr5P/Ii4Afr9wd8
         4slOexH0PEB+hldib2Y1cY8z2Ha7edeecv7esWS7CuMOkgrg7SbTMcSSufy2snkczfc0
         wyYYCiDWj/Lhm4KM0QHcu6xQeFu5K2XrnnDgkI92gMAPPuULvkEiqUt5c3ivrytcyod/
         GawlkBYwZpsmvOZk+jFHPcpRfY2353yks0obQhw23A5FZaagFYDpPjsgunjjvCVV0xmI
         cAZfevxcdJZYEscGUM4nH+x0mIu5BiRHy1N2+TrVYgsPEWeiis9AU7nxs03u5aglXYIL
         34IQ==
X-Gm-Message-State: APjAAAXC587bGjCXDc+PB31pDc8IJdzWHdskq4vvc4ySIDyUXYfq9WCX
        zIH+nZ2NY8uByn1Bzh5rPw9nCrRVnOSpaoE3GU8=
X-Google-Smtp-Source: APXvYqzLgbBIvAgp3bN16k/9Gx5j7uf5QbTy095/HVsselNKKHpLZpRHLe7lp0IqM1maB+gHdQWyOGS0xf6chDiDN2o=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr10431151wrg.88.1552037890703;
 Fri, 08 Mar 2019 01:38:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
 <CACsJy8D_ahM_7mLaAijJsZ0e8BF6PBfr3pPisOnYmRH7U8kmqA@mail.gmail.com>
In-Reply-To: <CACsJy8D_ahM_7mLaAijJsZ0e8BF6PBfr3pPisOnYmRH7U8kmqA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Mar 2019 04:37:59 -0500
Message-ID: <CAPig+cRCUZApx36ZdmWAY2UbvgF6phjVNb5XU7YN=5LryU5trw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] worktree: fix worktree add race.
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Marketa Calabkova <mcalabkova@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 4:20 AM Duy Nguyen <pclouds@gmail.com> wrote:
> Junio, it seems 2/2 is stuck in an endless discussion. But 1/2 is good
> regardless, maybe pick it up now and let 2/2 come later whenever it's
> ready?

Yep, 1/2 seems a good idea and has not been controversial. It may not
solve all the race conditions, but it is a good step forward.
