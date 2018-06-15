Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12931F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755859AbeFOGa4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:30:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46705 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755592AbeFOGaz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:30:55 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so403435ybp.13
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 23:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yqGMfOSf3DiEx36azRs2tHfxs6T+TBdV+BAcieuYNI=;
        b=AF12zPaf1N9JMdUHr9o9Jwr6ILm08pYX5QWOhg44/pCodw05mWdJ0Q3epWC0RwJ1cW
         mtBNKbCS9vlgGM4dwkSnn8GDul2jBdUEXcvekTsMeMXKRqqOl7pDJ7MYE7iFroqE95l9
         Srg27tZHZtNDmxKLGW7Wm93wUVfUwLSV1zYPHcHMDnaQ/tT7hXU0dIjuBrs3Z85GFIFu
         LeD68IgFxVg5jW/P3thfPnroljqkD7WLvh+CmnpvlityHbHFO5819L8/Rp7TbRgb0iC5
         N06QUpS81vM+zhBLmygPuzHpBjmAsuRUwkkI7ek1s39wqq9KEoPyKKmjdEdGAMbNnoUi
         g4JA==
X-Gm-Message-State: APt69E31YsBP/+iGJxFxU1KMaBzNVNNhG+39WI77HpE6UvKyzNfUvYji
        epNT6BkX8FDRrZCD3TqLjUpaOA3DcfvxTs21qkg=
X-Google-Smtp-Source: ADUXVKL4bbn1SA2uM9+V5U73wtkHBaUg0sYnbYuQu1xESF1Jw3CPMx/6VOw9M0y8/q0/ZLEODDT7jJ+dMajjUNvpNQI=
X-Received: by 2002:a25:8751:: with SMTP id e17-v6mr173978ybn.194.1529044255219;
 Thu, 14 Jun 2018 23:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com> <20180615042023.GA31294@sigill.intra.peff.net>
In-Reply-To: <20180615042023.GA31294@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jun 2018 02:30:43 -0400
Message-ID: <CAPig+cTSirqhayBDJFZhn2HL4EMr36GHuCOYAMaCeptqFtoR=w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 12:20 AM Jeff King <peff@peff.net> wrote:
> We have OLD_ICONV, too, which should probably do nothing if NO_ICONV is
> set. I think that works OK. We end up setting -DOLD_ICONV on the command
> line, but that's only consider inside "#ifndef NO_ICONV" within the
> code.

Right, that was my conclusion, as well. Since it works as is, I'm not
sure suppressing -DOLD_ICONV in Makefile is worth the extra patch
noise. I can re-roll with that change too, if someone thinks it's
worthwhile, though.
