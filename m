Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCE01F424
	for <e@80x24.org>; Thu, 14 Dec 2017 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdLNJAi (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 04:00:38 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:44729 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdLNJAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 04:00:38 -0500
Received: by mail-it0-f51.google.com with SMTP id b5so9713167itc.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 01:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B4jOXhroZa6XX9OgS1zfMjYMZqBH2RSonwtAtZhh6Xo=;
        b=JlSZIDYkIfpParhvwDcybplIPdM1hgAif0MVISz6UMcO4J7MxDqvuUEqOda6rix7TT
         T/QPqzTvo5wqjatnbNL9pDSCdR3MAiZZ5jMpjNOdBgSZlw9rbnhF4TstE8PufJFpaKCp
         MBX7hwDbhfxqvGXn+UU1i0n+sJpGW7SaczZgdoM4VBvIGDQDh6mOfFqcGtOJqlxpMAcj
         mX7nUcIHqX974+ydWeG/FpMT3k0IJIvPtet4gYoEBMtJcAzsLqNFvmuo+jee7u7PopUi
         iDHCHe7q/ZGfTy2hOk9A2n2DZeHXO6r5pKtO16MAWw4zwaSvaPO6+Oh2blXawpJyAZ4B
         KsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B4jOXhroZa6XX9OgS1zfMjYMZqBH2RSonwtAtZhh6Xo=;
        b=JdSLESWgv2ShVNyyy7FvnapQXJC+QGR0DIdW3VUpkoybfdXvGe/y94dZo2QUioaSdm
         +qK6tD9h6hX5xEH4NKsRJPgj9h3BZCNzSrEnQh7CEPEYO0E271CiiJfrj3PF+5Rm792Q
         fugDw4UE5fUbKW9lOKp1294ogJmHXWXBsICerFJSvSMkVXzKCygn017YVAmVJN2W7Sd4
         qUIYiK7W2BJrdOUso5O1anhmiJVbQHyBx29w6Rf6op/pfN9g5G/l0PvI7iInBlXN5CDz
         xv8HeIzmwUxqScqKVD1ITuPn2a4kK08jqJLCiVI55ktzopHhwZHRiBdCdE2w7zNauQVJ
         dYyQ==
X-Gm-Message-State: AKGB3mIvZzLFehDJBNrrO1/4q/EXpHm7JyTVRE7/Mv/i2U7GsHa8hZlN
        oD9DPfcCF01EJm85GfqTWaLKHnZihOZODaQJVIM=
X-Google-Smtp-Source: ACJfBoueFOfk4yUJXBIuTmMwiJL7AYABk4u2qTik6CkTdjoPBJNlluewZHhQIwSGU5pzO1WXtQX42tTRTqrJzxiXO+c=
X-Received: by 10.107.81.2 with SMTP id f2mr5888903iob.282.1513242037408; Thu,
 14 Dec 2017 01:00:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 14 Dec 2017 01:00:36 -0800 (PST)
In-Reply-To: <xmqq4louwdpn.fsf@gitster.mtv.corp.google.com>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
 <20171213151344.2138-5-chriscool@tuxfamily.org> <xmqqbmj2wedd.fsf@gitster.mtv.corp.google.com>
 <xmqq4louwdpn.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Dec 2017 10:00:36 +0100
Message-ID: <CAP8UFD3sCQcp_006AhQXrKicDmuLehRLQDN+X2upRy3sQOKOcQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/run: use $default_value instead of $4
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you want to be able to use this helper to specify a default value
>> of an empty string (which the orignal that used $4 did), then the
>> previous hunk must be corrected so that it does not unconditionally
>> set default_value to $4.  Perhaps like
>>
>>       if test -n "${4+x}"
>>       then
>>               default_value=$4
>>       else
>>               unset default_value || :
>>       fi
>>
>> or something.
>
> And if you do not care about passing an empty string as the default
> value, then the earlier hunk can stay the same
>
>         default_value=$4
>
> but the eval part should become something like
>
>         test -n "$default_value" && eval ...
>
> Given that you are planning to add yet another optional argument to
> the helper, and when you pass that variable, you'd probably need to
> pass "" as the "default" that is not exported, perhaps this "give up
> ability to pass an empty string as the default" approach may be the
> only thing you could do.

Yeah, thanks for the explanations and suggestions.
