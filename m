Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D877620C11
	for <e@80x24.org>; Mon, 27 Nov 2017 19:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbdK0Tin (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 14:38:43 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43196 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbdK0Tim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 14:38:42 -0500
Received: by mail-qk0-f171.google.com with SMTP id j202so34010585qke.10
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B/6MPcXc9p5ocTaFM7AvUEbAp2d1aCfBhEk7b2jhZdc=;
        b=TaJYtsqEHVNJaahJrEPmg6gGPXgXo/FFCdrK0yyD2aewS9BGCvPNjA4/nuJrnlSWQU
         CUaY58Ty7a2QMn9KtgssgR/jetPdTsh71d1VePQL309pr/4od7740N+rm4gHyT9Cj7ib
         Eoo0nMewLrmR4C41arM5b9Np1pOcBWTNCwkjs6mEQrJRO6vG8O/lyfUCLSExNuXlUwrK
         VnjgOesuzvL2vMVbbZ1RRkg4suLIEoEKrD/5L0tIfjFjvEy0Fy2Rov896pBj+SMAzW98
         fjKAB/od1e+1ZuBTERUQ7RF/q4glwvs7ivX9Q4aGqZnvcVjz4DC0dTKc8U0kNLFICb4o
         OWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B/6MPcXc9p5ocTaFM7AvUEbAp2d1aCfBhEk7b2jhZdc=;
        b=bfXMEcCGRh/H8JQsBDXAS9l2dbykfGV4MlnjJYJYGaYUzu17kzfazWN9drHPzrf0g9
         JTyNR04dh4tJd37XKDkUSah5sDq8yYjXYrmo26/+kRQD66LozASLAVN1gVodKsWLmiIY
         H/KlTOyw93TDUKMLwcear8D1VV6j0CRukfnEJ9GwyIT86yPmpCoXtresRs87ZSi4Q5K9
         pFGvsDJP9bXnOVaXEk+CzX/m1Gyont6+lrsbpgrq6Ceox2Zt2VIimFBdAjtCw/Xl02xW
         CTf7b74pK8P1MxGAMsWpaaaGoQFGRH2NTiwf2cXVjLxBtOqw4nUMdeGi2iAJWJV2aXrm
         Nvvw==
X-Gm-Message-State: AJaThX4NMLr0L4QugT/76/m1pCvUdb8UlWVdSS/sgY1RMBHka7T0/rSm
        zyf4vaq8Y8Ry5UniLTAuLWoyQTnVHSvYLZBLypU0gQ==
X-Google-Smtp-Source: AGs4zMYvucXMdZ0WnrkETKvJ5Xo7bNgv5QMOsqZDt1w5x7js9ZukLg/GCNf4473+OyLHWj/PJm/6uAEBxT5YYNBIoKg=
X-Received: by 10.55.203.156 with SMTP id u28mr61691965qkl.353.1511811521173;
 Mon, 27 Nov 2017 11:38:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 27 Nov 2017 11:38:40 -0800 (PST)
In-Reply-To: <xmqqtvxkm9eq.fsf@gitster.mtv.corp.google.com>
References: <20171116020039.17810-1-sbeller@google.com> <20171116020039.17810-8-sbeller@google.com>
 <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com> <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
 <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com> <CAGZ79kZajrugviv60kQA6UepYrQGpJK447BK1fBFd3N5Wnn5rQ@mail.gmail.com>
 <xmqqtvxkm9eq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Nov 2017 11:38:40 -0800
Message-ID: <CAGZ79kYbvdov_0cR1W9zOzkbHra6qk6gE0eAPGkzGWL_4WwcaA@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Nov 21, 2017 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> ...
>>>> fixed.
>>>> ...
>>>> fixed the text...
>>>> ...
>>>> I am not fully convinced all descriptions are in recent history, but I
>>>> tend to agree that most are, so probably the trade off is a wash.
>>>
>>> So what do we want with this topic?  I think the "teach 'git log' to
>>> highlight commits whose changes involve the given blob" is a more or
>>> less an orthogonal thing,
>>
>> Well, both of them solve our immediate needs, so I'd be fine with pursuing
>> just one of them, but I do not oppose taking both.
>>
>>> and I suspect that it is something users
>>> may (although I personally do not) find valuable to have a related
>>> but different feature in "git describe".
>>
>> agreed.
>
> I was reacting to your "fixed".  So will we see a rerolled series or
> not?

I was not planning on rerolling it.

FYI: I am on vacation until next Monday, so if there is anything
to be fixed here, I'd do it in a week, which may be enough time
to warrant incremental fixes?
