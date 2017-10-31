Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B70F20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbdJaVqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:46:02 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:48797 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbdJaVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:46:01 -0400
Received: by mail-qt0-f175.google.com with SMTP id f8so558801qta.5
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TbCwL/kI8sfEZRmtyX45v5ii/qHxel/Q8XH/+4lyiSc=;
        b=RrPM0DIc1f2B1nV5c0Q1ovTeQ3fez9KvAiybt8l8+DRCuFiAimf6t/BSACqnLjklxB
         lbqxt3YSkOHNYROWCUiJg5ae5S0YT7G/Ce5BR/ugmEjFflAcrHdkDUa1F4M2KpXEipu9
         43f3GzhVFBRLFkeeoBb6ThViLCGFkvtZxPaSuqsGocUCXaW+TTZRowVQftBjnB2uoq35
         3/Wy4ujhNS3ZPrQvwoql+nkTKNemALu33e3b2o+GGWZN8TFovnM6PERNpIMKGQcC5L00
         uVdM6gmmPRLBAwCDbJCJBoGU7FGhPz+AwAPzGgSSMb4OEGovCClY1VHn9ShxVZqj3x6X
         SbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TbCwL/kI8sfEZRmtyX45v5ii/qHxel/Q8XH/+4lyiSc=;
        b=qH5WdUeyGG3tZQM8t8hadls58Hvv56PM9Ya9lR0GsXanZqmt7DnJGTTB6ttoYh4RIa
         HYls6HaUsOA1yqv3qd37nFFt/kaGqk6ZWgCSib0ydBekOmMmWMTQWjBNny6dHYrqGN8R
         /JQiZfg9oxVSna0G3IP8d2spE7VhSrcGnjsgO06EhWeFABiEVjogvx2m6lEzgEK6kQdR
         Yu7nm1sgJroiKslwLobwgVAhEEMCGXqYhrPvM4rbo+a2IgSwdFtc6uh8bFM9rn9Qd31J
         7rxLmSbSEFm8YkIHjjO/6r9MoehNCrITM1qtSGtWimq77aRxCjhIG9pOxySq+wBSvqRQ
         vDCA==
X-Gm-Message-State: AMCzsaWMdgt/9guNo/DDZk7jWBcTrpSwrBlPgSN0kWmGH0k+CiA903u0
        Q3KxY8BpG5/wDCAj6GPYOu+7Nou+QhG4uDDsaGnqCg==
X-Google-Smtp-Source: ABhQp+TFdLjXyOSMOtZqoxc8rhCWIqmt/mMImmf4Z6h2dA2jjpKyQvf8vHEJ9ePss/ZYIdPiUCFxj1whO1Vkm8w0Gdo=
X-Received: by 10.237.37.71 with SMTP id w7mr5119291qtc.299.1509486361143;
 Tue, 31 Oct 2017 14:46:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 14:46:00 -0700 (PDT)
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com> <20171031181911.42687-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 14:46:00 -0700
Message-ID: <CAGZ79kZytrzDRsEU8Od3rZBPbWYqJQiQ5w0PE6hxVR-SbE2MqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] convert diff flags to be stored in a struct
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> Changes in v3:
>  * Now always pass struct diff_flags by reference and don't return the struct
>    but rather modify the passed in struct.
>  * Don't clear TEXTCONV_SET_VIA_CMDLINE when --no-textconv is passed
>  * added additional patches (set out separately before) to remove the macros
>    and change the struct members to lowercase

I have reviewed this version and the functionality introduced
looks good to me. My only nits were regarding style and typos.

Thanks,
Stefan
