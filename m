Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15BFE1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1950720AbdDYP5V (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 11:57:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33606 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951006AbdDYP5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 11:57:19 -0400
Received: by mail-pf0-f177.google.com with SMTP id a188so28921516pfa.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y3qrUFmaVKHQw4QT1zGHk2vVM4Ws3z3Bn9It+m6Eafw=;
        b=mLQZ2HK2AgVUsy2U+KBaOV7WRDHmdpcpab6OwxHF6TG8/202DYVauqo4LkIbBirG+a
         V7J/ui1oRGd++jOklY8NTI6uyDRELFf5nzBeg+VXLHEaSyYo4bi5NLkrZ4M1BOdB1VR/
         2VOcNteNPxJggevqtwZ6efVoTPrKQaHsNO7t0hGFQQI6OJWyZIcmXYP3LMRA2r3vDOBM
         762L1RBMd7Zk3AIAZ8ri0WOGDhoSbosLG1S1MtVzR/OtyJuC6HzbDsRQwT7nMFoJWyDh
         4JSn3dGM0nhC2PIEvDPNQkPzrjSmjAJoDABIvvZYynoSP7jDx0xcBVaFAK5iPtGTh3JL
         ASmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y3qrUFmaVKHQw4QT1zGHk2vVM4Ws3z3Bn9It+m6Eafw=;
        b=idEX90nQEifIuoaJZtUUJL71HF3Bq5cH6tuyEjPwRQQrHF6ZT5ZAkXeWIx1XzD0kc8
         JXT9PlhC1/oXinRvQgnso4aGBYkqcWTbWLjCpx/xLoxTLVNpwdnSSlxmR8W0ozqHoOLf
         P5fHPXWRSyQEff9KbGOYEwTN9g5iQDYa/tbAm3BJ2yiJobWIbvjnbbNU7I0GaRalOaqO
         OVKjM/ISVwoQmA4JR6RAZPMh9JhbvMRi7fSw54y52R9n6Pw6z68LjgRsM0zrrTRHtFdd
         pxicWk6xc+iu2o2GemGBUh/4WixftXL9LjZcw/YIIuFJAlkfwvhQ+B6/TtKEW6pNdiFy
         jZgA==
X-Gm-Message-State: AN3rC/6a7bj2K/gNR4DmsxYmiZOwTgNbTKe9v+mmlLBdiSlGUEEoZG1e
        j1j/q0qLF/JK0w1reobWXjUvfn5Ggtcy
X-Received: by 10.98.90.6 with SMTP id o6mr10698198pfb.101.1493135838771; Tue,
 25 Apr 2017 08:57:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 25 Apr 2017 08:57:18 -0700 (PDT)
In-Reply-To: <xmqqfugxxmkn.fsf@gitster.mtv.corp.google.com>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
 <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com> <xmqqfugxxmkn.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Apr 2017 08:57:18 -0700
Message-ID: <CAGZ79kbr_LJ+mviXWxdyDWgSjAdc8VAXtfE_NG9qVOOCBM=JVQ@mail.gmail.com>
Subject: Re: Submodule/contents conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> A similar bug report
>> https://public-inbox.org/git/CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com/
>>
>> "checkout --recurse-submodules" (as mentioned in that report)
>> made it into Git by now, but this bug goes unfixed, still.
>
> I do not mind reverting that merge out of 'master'.  Please holler
> if you feel these "go recursive" topics are premature.

The bugs reported here are not for the recursive checkout,
I was merely noting it as a side effect of time having passed. :)

I did not imply the recursive topics being premature.

Thanks,
Stefan
