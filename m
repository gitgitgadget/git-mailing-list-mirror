Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA07208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 17:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdHRRQQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 13:16:16 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35033 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdHRRQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 13:16:15 -0400
Received: by mail-yw0-f178.google.com with SMTP id n83so34779368ywn.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vUpfrkWeHHCRTgw7sVyT9CWdgMkAY2NqSQ+GsAI0qlU=;
        b=FPEKoXPtInCY39ZZT04nsb0dQFTBlNPaHpXHt2ABsw7k1AJ3i4jFn9XzB3RgfkRlmy
         EYoOGhbiEQNLdi4m59lu8hi4TIoSv2HDEXCbCCvvKCjZDI9xjbAvWEjmOerrnrBk7srU
         wFSaWVGogaB6oVNMh8ZZAmBd/N5uC+1TfaXvksq+9FsGgKHyUmnUPSlgIggFB6EjTE0Z
         b9xHqYUfsZUAyoDEejms4n+mKjHE0QMHTuMHLE1bjdmQt/0hXLgdfhHyxL4/d0yVBrF/
         nI8uIrZMOxhMB2JPBM3o+1DRSmGdk9rf5YHCfYlWOH53AgANej/n3LVhmzOCAfiCvW/M
         yzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vUpfrkWeHHCRTgw7sVyT9CWdgMkAY2NqSQ+GsAI0qlU=;
        b=OTdoTqikLBosxGkaC4Jg4oiDEeQ4LTiX6CQqtBPi09rw6obWvwqSXtG2VqAX1ABVUF
         bn09iF8c+WEJQsBKoKGBakfVXhOo1N1gf0EM7CkvffslR6CL18Ml0vFt3hZ0a4oSHLMC
         3bAD2eM6Nu/4xk3WcQczQAg73gwne7atQQgJ3SQnwiw0DLvNBTq8P3roAvxxcUBZ69qt
         gtR7LIxih37+szdxGqJBhKlmlJS5g0ShvID1EB4Fy8C/ykEQewUoao38u/z0HhQyDWSd
         FfiadrddZdHIkeYVV4mvuaYQ1OBdWE+fhmXeGqOdHRJAv02APwzT7hNvxDjwlLuPAvVy
         STuw==
X-Gm-Message-State: AHYfb5gtuSF/SQKSoNTrLYLEoQztUA0IBEUBY/37p4Ts6KbvXRXxGiAI
        tbMsj0gRwm+00TDuIykOY2/RKaVBr3+0
X-Received: by 10.13.198.6 with SMTP id i6mr5770759ywd.422.1503076574780; Fri,
 18 Aug 2017 10:16:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Fri, 18 Aug 2017 10:16:14 -0700 (PDT)
In-Reply-To: <D784E926-9FC7-4508-9632-225138679CDF@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <D784E926-9FC7-4508-9632-225138679CDF@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Aug 2017 10:16:14 -0700
Message-ID: <CAGZ79kaC-rtfp-AMdpkpCycgk568eU2y-JDGwdoSK_E=oUJo-w@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In the past "submodule.<name>.update=none" was an easy way
> to selectively disable certain Submodules.
>
> How would I do this with Git 2.14?

    submodule.<name>.active = false

> My gut feeling is that all commands should respect the
> "submodule.<name>.update=none" setting.

Well my gut feeling was that the "update" part of the name
reponds to the subcommand, not the generic action.

For example when you set update=none, git-status,
recursive git-diff still reported the submodule.

>
> - Lars
