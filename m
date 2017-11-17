Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694BF201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbdKQH6z (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 02:58:55 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35282 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933951AbdKQH6y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 02:58:54 -0500
Received: by mail-io0-f179.google.com with SMTP id i38so7937176iod.2
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 23:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0GnyYL+x1D3PEapx4EXisEcE/nPnfpIkc+hxh6T9Syk=;
        b=XHpUrF2txtMC59MbeAqP/BY4KgNdfaAmpHJIB9IhPMEEGSJIhTaON0pEy0L8wzzpaS
         3p8bIGVxYJtoS3c9KxWHDSTs1n9Onp6Un4kdlRHWCeAPYVeQaNLSvsBHT/5LuOIusfbi
         iwphee20591PM9XtWmSy86atB/y+jTJscekbqsglyME+3ybjAeIgtY+Hk6w3WPoiNjMr
         nnnwQSsis9iAdxJ0PYOI99NzXjEDsNMgAVQLyVYODl3DGD/BlzNlmp1aQNAWXM+v+Czq
         dIan/bBUNkK18HnCefNjx6D0EOB4V0kzssiDTIAdbNvRHINlUs1jWxm9oqvufXlIN3Kt
         4k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0GnyYL+x1D3PEapx4EXisEcE/nPnfpIkc+hxh6T9Syk=;
        b=gkTUbCebsRSZDu/o06ep7zB6XvyOYeG6B24FOdhaubOz56g3S07U8cxl65YKOYhaNv
         4toE5j1M5LNnGHqkwS39c7HTsfort4w/fBmjfsVptCZZV06XaZYetTtmryM99+PONA0e
         lexeoVJDu4qqaRbKW+nA2Am32zjLq7oMgUwaviTtUJOcLN6thC4EgYXANzGKmbBWpnLH
         J5tzrvUdfRaYURLg+7alhRBXrmhuRKXLu4GDTvGp7cAu3rzqIboGKtPRr3XyKphXqz/s
         FbC/w+OIYpBsGNOj8PcRuVaZiujC2Tk1uck3O9bD3y2AyaUs3jrhHtgYzRMIWhqg168J
         x5pw==
X-Gm-Message-State: AJaThX5rxIgN+Ro9FDpoGDfbPWOSHVuxhQlpiP1UmX0X33SfINc3nz1o
        g0A2ZN9QepaTCs/XsQ7RbV+r1XAMlWJtLuSA0x0=
X-Google-Smtp-Source: AGs4zMawgi6i67ofnmnHTLD7ye3Ar0sUdyWG9E4H1SGE+ek32yDiqXNuIUlkKFmf3GEcMw/DsIq3hOlxAc+Bv2ajYxA=
X-Received: by 10.107.81.2 with SMTP id f2mr1672264iob.282.1510905533382; Thu,
 16 Nov 2017 23:58:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 16 Nov 2017 23:58:52 -0800 (PST)
In-Reply-To: <xmqqy3obslyb.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
 <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
 <xmqqy3obslyb.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 17 Nov 2017 08:58:52 +0100
Message-ID: <CAP8UFD2gqwtmGVkkqh3JKYf8X9innfJVV2-+FWTVyjXftKiYxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] perf/run: add '--config' option to the 'run' script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 7:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> It is error prone and tiring to use many long environment
>> variables to give parameters to the 'run' script.
>
> This topic has been sitting in the list archive without getting much
> reaction from list participants.  Is anybody happy with these
> patches?

(Sorry for not responding earlier to this.)

Hopefully AEvar CC'ed will take a look at this soon.
