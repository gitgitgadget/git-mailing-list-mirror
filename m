Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1CB21841
	for <e@80x24.org>; Mon, 30 Apr 2018 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeD3LeX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 07:34:23 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46208 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeD3LeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 07:34:21 -0400
Received: by mail-ot0-f195.google.com with SMTP id t1-v6so9065337ott.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Ds988DI/H59NnW+5qsa3E24mQPuXlw1hOd+rXZp3ME=;
        b=XJENEsW2sJA9Vu+VDqtqe/wdhZLSD8MpjIBr4GX0AANshxFIPgGlQ7mfdVHjczyFTD
         BuRTUUmET5t72H1SkhfzUuC0QhcWTan4meLtgu0G0nE19Sz7aUrCdNEVNKzJ3SQkffFu
         4771NqkFxCjJvPZS/STzHHE37UFaFe1/8gQSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Ds988DI/H59NnW+5qsa3E24mQPuXlw1hOd+rXZp3ME=;
        b=N356wuLC7LEl7mt+wM0c//gkszvBoRvpFkGS5S7aoj0RgzpubWDgRHY6fvXxPLf9qq
         9mgDgLVzWMeunqUuChO51nSSasdm0GNSepZl6shIXNJTDrQDmA4HasJzyFkX6qvxcgwN
         g0tDzzohiwPKRu/b19RQBk6DydQ6u31gLoJxagf6uVRo3ljb6tbNEmft7kV5KDJsfpgW
         5Ax2GqnjHNSJsksQeFH0j+Gsua4TBepHg51lQ85id+6qLtUlalUpvw0eBxGIbHzEuNpo
         GTC7ODeTKxOcWf8AeYbrFp+GH2MienSSOoxEeQe27Asf7fc44PiqDy+yPB6JKEuqvLOV
         DruQ==
X-Gm-Message-State: ALQs6tCldIM/fhZ2wj0ZwhQSZVXfSGRGgfUIHI+2+p4jS4uhdP4huoZj
        dFcV7CsUBxVGU4WhnZcklC9/kt/JXETrRgAM02v4tw==
X-Google-Smtp-Source: AB8JxZrdOASbfOoRfNaqq1wOvV2cw7cN8b8wG3Ue/wjkBsN6vFmG41zlv4SB0BAfLOST7HgcCEKhLqsRq7HIhatycJc=
X-Received: by 2002:a9d:28e7:: with SMTP id s94-v6mr8540499ota.346.1525088061103;
 Mon, 30 Apr 2018 04:34:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.190.8 with HTTP; Mon, 30 Apr 2018 04:34:20 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804301330230.79@tvgsbejvaqbjf.bet>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
 <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
 <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com>
 <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
 <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAF2GuqtooOo0P3nGXNEEu=j2XSuNZ2KRwEOAz82mMC3t3v7bXQ@mail.gmail.com> <nycvar.QRO.7.76.6.1804301330230.79@tvgsbejvaqbjf.bet>
From:   Tiago Botelho <tiago@gitlab.com>
Date:   Mon, 30 Apr 2018 12:34:20 +0100
Message-ID: <CAF2GuqvTvPPfGPXCwhBkTHJvRQcV1w9VebHkn+Kqw6dZ2b0xKQ@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 12:31 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Tiago,
>
>> > On Thu, 12 Apr 2018, Tiago Botelho wrote:
>> >
>> >> On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
>> >> <christian.couder@gmail.com> wrote:
>> >> > On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
>> >> > <haraldnordgren@gmail.com> wrote:
>> >> >> I think it looks similar. But if I'm reading that thread correctly
>> >> >> then there was never a patch created, right?
>> >> >
>> >> > (It is customary on this mailing list to reply after the sentences =
we
>> >> > reply to. We don't "top post".)
>> >> >
>> >> > On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/)=
 we
>> >> > have been suggesting "Implement git bisect --first-parent" and ther=
e
>> >> > are the following related links:
>> >> >
>> >> > https://public-inbox.org/git/20150304053333.GA9584@peff.net/
>> >> > https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
>> >> >
>> >> > Tiago in Cc also tried at a recent London hackathon to implement it
>> >> > and came up with the following:
>> >> >
>> >> > https://github.com/tiagonbotelho/git/pull/1/files
>> >> >
>> >> > I tried to help him by reworking his commit in the following branch=
:
>> >> >
>> >> > https://github.com/chriscool/git/commits/myfirstparent
>> >>
>> >> Thank you for the cc Christian, I=E2=80=99ve been quite busy and was =
not able
>> >> to work on the PR for quite some time.
>> >>
>> >> I intended to pick it back up again next week. If it is ok with
>> >> Harald I would love to finish the PR that I started, since it is
>> >> quite close to being finished (I think it was just specs missing if I
>> >> am not mistaken).
>
> It is now well after "next week". Are there any news? Or could you unbloc=
k
> Harald by stating that you won't come back to it any time soon (in
> particular since the PR is not quite as finished from my reading as you
> made it sound...)?
>
> Ciao,
> Johannes

I've been working on the feature for the past week
https://github.com/tiagonbotelho/git/commit/709e2e248ebfb1deab12fd7d3da4611=
002dfaf86#diff-118df990fd68a0929bca5441fea06fc7

I have some comments sent by Christian I plan on fixing this week

Thank you,

--=20
Tiago Botelho
