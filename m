Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C7120248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDDJUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:20:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfDDJUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:20:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so2827349wrq.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UAyhydIHP/a85o1zr9TIiv4wkQo3zaKqVcv+StklDzM=;
        b=IXDugqDfL/N2QTUPn0IcoMmA1Dasxazs56k7sJH09qYuXrY6Cevanr2//TfdAT5FZw
         ylkZQ8GIeQ39aOEDQUsQS8c27olHNBoIPhwWc6lb5L768a6XCMeghQVUjNdqgIStFU1V
         eyanThKEyGwvnyJATKlmSSkVxSjv3DO4cmNtccsyRpXa9bR1ZOkWHoFwscmVR5PoKyH2
         5ELYqSaQxGUtBo6w96Nv8HTlExA8a24kxxvUcooO/hZ1zVcYeE566HNH5tZDDuC1ylD/
         xY/6sES5pk5FV0EKFua+xELJfSnGk7BwGIw7/EJkPPPMahwo8SYg1IJlWpGU6ojlJ3yA
         02sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UAyhydIHP/a85o1zr9TIiv4wkQo3zaKqVcv+StklDzM=;
        b=aJElhngqg7KOSruvBPGlZh8TXaJBjMt+EKlprHHHYRHjMU1BjOM9eofu/LvtyREm0P
         utRhmBbU5Fjofj1QhOUHALde7WQCAjmHXtWKcrmrq4lqVXy4i9fsG2QK8bZpFMm1StCm
         J3L+VQR2zjk3A+ftPHT0xrjjOPQTgDiGtRaReHQXNssnpmT2fb9Jm+Tvrxhpuas36OX6
         x+EZ0XoX8iv2qM53borZrwlPMfuWvrJiV530QNC2VdCXclYaNU6eqt8FlIE766vW4vYJ
         91a9OuvwZBv+ry4PmxyyhyR9jUHV5ctstTwUbXa6/cgDlFW9AKFET8Qdrw28vUEtKQ6L
         gGvA==
X-Gm-Message-State: APjAAAXIUMiL0n29mAQXMq1UE6kRfPwDKnXs1NnD7lQ+LxhVx9ugq1Yk
        c4g30QO7FvD3QID5roKDnMI=
X-Google-Smtp-Source: APXvYqxMD1qUzzOWaLm5JVtWa+BGPeEuBUVWfPB0uFlvnVQUX5ggxhz0RiBEp6xwZbqghAHCoLJbqw==
X-Received: by 2002:adf:b612:: with SMTP id f18mr3329776wre.236.1554369635077;
        Thu, 04 Apr 2019 02:20:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z1sm15818326wrs.52.2019.04.04.02.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:20:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
        <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
        <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
        <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com> <874l7ekynt.fsf@tarshish>
Date:   Thu, 04 Apr 2019 18:20:33 +0900
In-Reply-To: <874l7ekynt.fsf@tarshish> (Baruch Siach's message of "Thu, 04 Apr
        2019 10:38:46 +0300")
Message-ID: <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Baruch Siach <baruch@tkos.co.il> writes:

>> Independently, I think it makes sense to do something like
>>
>> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
>>
>> to tighten the match to exclude a non-trailer; that would have been
>> sufficient for the original case that triggered this thread.
>
> Is there anything I need to do more to get this fix applied for the next
> git release?

Get "this" fix applied?  I think we should tighten the regexp to
exclude a non-trailer, which would have been sufficient for the
original case without anything else in "this" fix.  So in short, I
do not think "this" fix won't be applied without further tweaking
;-)
