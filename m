Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976821F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936186AbeFRTPs (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:15:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37155 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935860AbeFRTPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:15:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so17998997wro.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uJh198+CvZOQ15n/anRZCHYxosIgk0XuizS0YMB3m4g=;
        b=OlQkuma+eDcUv9ERS3ZyArvg7KIGwIoI7wuFo2/KBqeiiaZVYgWR7RZbElel3sI7kP
         pBlM+62DYKPhRqdPCqPRqFzAoQ8HecXFc62m8vS0v+hUgBEiaPnjEf1dnp7q+QKAQp+/
         b4pNmqfy3dipDpK4qhs485DFHH7fOtgHR+DQyJZ67ev8Vd9SZABSO2Pltg2Lg3VKsdtR
         HmjY2MXI/YXEuMfuEV6U9IUZOpbSMSiYPrVuRsv16XxblEN5pAXtz04d9vg/TUwcr7k0
         Oa720Os3ArXEcYwjr2kMt/5ll0PJo4nkJwx9+LYhXODErTEFssKDU4YD/mqlWmhBj++5
         H4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uJh198+CvZOQ15n/anRZCHYxosIgk0XuizS0YMB3m4g=;
        b=sPh3CxRVdnF4WsYvJoRzv6h9stXrPrsNC1m0R5QVAHf0MV/3INIchX6h4pmnG7khtX
         pqadPQwcSiQZf+OYTx/SdBuhpFFiPDKHVS7DuweKvvyKKOuplYCPJTghoFDic7tnmu1i
         lz1D+bZ9mbB/7qJ0K95fSLFLN1Y1iP8m+LKA84fj1xqWzUEKlFsgpjOStBfhvKPbT9GA
         HC5UzrHXlZ9RrX5poWwHE8acVPOrs8WsnIPvKD6LdtrxqLrN2Qx5+52tP+KJa9DERGLl
         FWpvSkk1sxsSRUHH8N0KjFsTmoh/gZ78CbaZITPcE4mDRl/5AP5tVrP9K2qork3h6BkN
         teNA==
X-Gm-Message-State: APt69E25s0iXOHT+Uo/6Klpv9l+u/REmpdihrn9zOPiZeJYqHoKrZCL1
        iHiAJXvHQmN1mL0iLFYmQCaxjwA6LE461mNSU1lPJA==
X-Google-Smtp-Source: ADUXVKIoLKKR8lBE2AJ2prbitJJGM2sMpx8/Rq4pDRHGJ3xd5iljEgFUJhguK/W2S3jsBZ7itImx9lPNOurm52Tjzcg=
X-Received: by 2002:adf:858f:: with SMTP id 15-v6mr12225433wrt.31.1529349344683;
 Mon, 18 Jun 2018 12:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:e90d:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:15:43
 -0700 (PDT)
In-Reply-To: <CAGZ79kbVsV390C0p3dAs3Ddp=K7mLnzfBhFC2jS4oon3Uy_nvw@mail.gmail.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com> <2bc7df55a6451afbd35638b31a1551c648129b22.1528234587.git.jonathantanmy@google.com>
 <CAGZ79kbVsV390C0p3dAs3Ddp=K7mLnzfBhFC2jS4oon3Uy_nvw@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 18 Jun 2018 12:15:43 -0700
Message-ID: <CAGf8dgLXi95ZUin+EWQ5Q9MfNT5Qxs82=F5w_ohDw9-cK7OfFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t5702: test fetch with multiple refspecs at a time
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 11:30 AM, Stefan Beller <sbeller@google.com> wrote:
>> +test_expect_success 'fetch supports various ways of have lines' '
>> +       rm -rf server client trace &&
>
> Can we move these deletions to test_when_finished of the previous(?) test
> as well as have them here in a test_when_finished line?

I think that deleting them when necessary makes it more explicit, and
this also supports tests where a repository is set up and then used
over multiple tests (e.g. having separate "setup X" and "use X"
tests).

> This test is precise and easy to understand; the patch is
> Reviewed-by: Stefan Beller <sbeller@google.com>
> (considering the test_when_finished comment as
> an optional nit)

Thanks. Do you have any comments about the performance issue that
Brandon brought up?
