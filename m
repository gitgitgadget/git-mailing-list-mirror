Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627371F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDQVy6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:54:58 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35860 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeDQVy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:54:56 -0400
Received: by mail-qk0-f180.google.com with SMTP id a202so8892758qkg.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y1OxT0f7OrMeo+Bj8dSY83wGKcCjC4rNWkh11/wln0k=;
        b=Y7EW00RIjg20l4HAb74TcGAjGFnVJ6Q0RC6rN3d04ckICkY4OFlsMMKywUdTIg7SH/
         m5Eov+RiuFlAETCg/2IBWssf0Z5SoWlHmi0gJo90eRbgP3w565oOli8a8N3FGx9hxfrQ
         XxA9YhPDQoYPMcLCOuc54cXiG2T4xuERJteGh5Lj5YnM/phD0hQpby5xe5mAHpkCZOOE
         qY6U3E4BThBWT1ZF4ewHRAe7GN2gTb4Eh0D0a7XI3+CNbcOBqq++CD3/4gMem7/WOvEb
         0MIvdmo37QG11fqWvdy0cEkFrlR4FdIQVvLrbfkE7vc3KZvTgGAUQqEGr5cydLyllR85
         R2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y1OxT0f7OrMeo+Bj8dSY83wGKcCjC4rNWkh11/wln0k=;
        b=Fxzq8m75unGd62EfQb9WLtCWlqJKlAoIu2VcbHkj6+dcOZ8AImL6zCah26Y3sUAVGb
         iDhzMutYNWHg8HbZrqiMJwCR7fDf0TRwNiiFg/3Chg3/OObySkxqz4BnJNR7sPkKQdaX
         uZldy0vbpUhyvC/os94oQuhLHEA+PvECeAVekgewTwZ1Ke52NM5uGe05UHrWwp1vC1Tu
         0dCckrTzzITRRGpx13afYd3SvpE/sSUi1lstT95s/rKVy/ckte/HIV+gFGe1YMmwUHLy
         bW7oXnkny12moSlsNvaYjM8ganx60Wc5zeqScMmJMCcNr82Z1wqWsqajCA/KvQ86CQpv
         aMvA==
X-Gm-Message-State: ALQs6tDMQlpwpM5ftmZtvVCSlh/R84omjvC5d8z5HOLZZtRm68dtec94
        vHIhHlZ6Ey7ne6loO66RGKtvcatzraJytntollU=
X-Google-Smtp-Source: AIpwx48kIn8xnmN/W7D9LSoHdQdMYgv8VYgFv9qLgpWu0xyX3+ExKLVMBln3uFekvUMDNd4D9Y46fGx/fdImbucrHcE=
X-Received: by 10.55.91.132 with SMTP id p126mr3795536qkb.179.1524002096029;
 Tue, 17 Apr 2018 14:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 17 Apr 2018 14:54:55 -0700 (PDT)
In-Reply-To: <20180417213049.118995-2-sbeller@google.com>
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
 <20180417213049.118995-1-sbeller@google.com> <20180417213049.118995-2-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Apr 2018 17:54:55 -0400
X-Google-Sender-Auth: a_gjLwgwyzpr00Zy1sPAqrh9Xxg
Message-ID: <CAPig+cR6Mx7sUSk6J0DULPVAunhZ4kUZLhWg_9ydgttKPSrD1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 5:30 PM, Stefan Beller <sbeller@google.com> wrote:
> Choose a different color for dates and imitate a 'temperature cool down'
> depending upon age.
>
> Originally I had planned to have the temperature cooldown dependent on
> the age of the project or file for example, as that might scale better,
> but that can be added on top of this commit, e.g. instead of giving a
> date, you could imagine giving a percentage that would be the linearly
> interpolated between now and the beginning of the file.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> # Conflicts:
> #       builtin/blame.c

Meh.
