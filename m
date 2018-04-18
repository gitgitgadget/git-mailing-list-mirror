Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F231F404
	for <e@80x24.org>; Wed, 18 Apr 2018 20:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDRU44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 16:56:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42866 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeDRU4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 16:56:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id s18-v6so8345691wrg.9
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sozuVYjPb5rT4aq17BYeo6hm8bECUV9708RRktQtXBI=;
        b=ESuTZwGVybjtax/7ne+bO61IjDqCdXwts8w6oazP8sq4BNtuvTfESpuXSsHSq3tfbR
         i9S8zlr6iLL6LQdabFQm8CzrfME33wPPPPcfn3ifOCANWVzrS/i+I/bfxTe9a8FrGMKn
         SVaJ7ReT73N/jNFS3NWGvI6p2tq+pKSbKkXDWpv+CP/L+vccGnO3Sp5RzcSzATtXXy0O
         BevKRkiSVwTbLSxKWIj0gf3lAa2BdyqGRtt6Yt3nvO4G/s7YpKAtirFugnWB0Y9DyPOb
         BGQ94qtHRKCVhB4NqC/pH57R/BuhOXRnmt/8Zibk9YlqhEhddsrxBe57o/g8wXD2dyDd
         6Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sozuVYjPb5rT4aq17BYeo6hm8bECUV9708RRktQtXBI=;
        b=Zao4Q4M+nwt+5waHjmPw0YIcuUZ7FDluBVz7CaQ8iqd29nwG49AQtmcJJMAgFpuSbd
         6AvOxm56PtTbojuR+OYkSqorsLO1J6FRzYE08mDooWtxGoqI80OPJwnnyUjQIDKkDyGd
         5fBt1oMxh/xUdtkkt9BjcBc+YwyOUlkJXHnhB+n62uS0xqsS4Zuq3W+aEmpCrBaDi2XQ
         WIeVQYpFpRSVpC7D2Z5xA/8zAiS8ABewYkY/uLWDEAlodIXULVNZweT5D6Nyqkizmwm0
         Qy84O//GTyOkgz+QzqjB72LwqFsDFqewYYR7p7b8qju6TMbNTks6nwI1al+oVac1Donu
         hyvw==
X-Gm-Message-State: ALQs6tDCZBDwJ8Jg7uIbfF4zzehOB2iw6GT6xtnkTJLjUvH9XpRU2cis
        mVdYF1DmlOnwilmyRvU5Yek=
X-Google-Smtp-Source: AIpwx4+DgT98e6vdw/2dZ1A7T2L2LlrpSEPkyhvtgYCPKRZ6Fp2KKyUeto0uqeyUAAF+G9Ci8TRlsg==
X-Received: by 10.28.108.20 with SMTP id h20mr537864wmc.5.1524085013940;
        Wed, 18 Apr 2018 13:56:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n79sm3468570wmi.20.2018.04.18.13.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 13:56:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
        <xmqqpo2xjpf6.fsf@gitster-ct.c.googlers.com>
        <287d6c83-2c7e-3138-def4-fee5d9cb9e48@gmail.com>
Date:   Thu, 19 Apr 2018 05:56:52 +0900
In-Reply-To: <287d6c83-2c7e-3138-def4-fee5d9cb9e48@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Apr 2018 08:50:10 -0400")
Message-ID: <xmqqd0ywi67f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I'm sorry that my second message was terse. My response to v1 [1] was
>
>> I looked through these patches and only found one set of whitespace
>> > 
> errors. Compiles and tests fine on my machine. > > Reviewed-by:
> Derrick Stolee <dstolee@microsoft.com> So, I pulled the code, went
> through it patch-by-patch, and saw that the transformations were made
> using the established pattern. The second review was to chime in that
> my v1 comments had been addressed. Thanks, -Stolee
> [1]
> https://public-inbox.org/git/6c319100-df47-3b8d-8661-24e4643ada09@gmail.com/

Thanks.
