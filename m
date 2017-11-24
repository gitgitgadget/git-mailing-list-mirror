Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB6E20954
	for <e@80x24.org>; Fri, 24 Nov 2017 06:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdKXGhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 01:37:18 -0500
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34744 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdKXGhR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 01:37:17 -0500
Received: by mail-yb0-f176.google.com with SMTP id k40so7939715ybj.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 22:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=51Hj/SToEBp7jK+mxPSAbf9Q6A9Y1YxYYTn9CG7W5xY=;
        b=hImJAdYpNrsSS71D6G8WNwsByezPCARrCoZgqcuVPrFpaxb8xaxNsD2Yg2cvUtZDUb
         ZZxb9hT90aBLNLWIh5cMfHwNBi7H4eaNqVX7lGtzV0q+F662m14SBAiHszINQIV+XBsI
         1wctvngbJdLAAeZxdI+xyw7vmslfJghae1EmfhswHhOINFaLg1xS6IswR+qLPAeQFkX4
         45rJptlKV3TsYjIWWiOF4DzZR1sWvA+E9rIh8DC8cRs71gNougNLl/CEhRDCYhhEpTUb
         Pp/DpXnoQDjtajRl1/veaL5MO5w/dxWbIM+cbFK0PW3aPG0xNMHAcYhCvfc1Y8yen5U6
         DXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=51Hj/SToEBp7jK+mxPSAbf9Q6A9Y1YxYYTn9CG7W5xY=;
        b=BFEPILparq8VC87zD3lFj0wbVt7qHo8q8rNvXX9u17iYkiygmHoQRg1Gd8s7dEJIs/
         dtars0KafxqbV01UqKV4DTe6VZCE25q+cutQlrPf9lOCTE1aRY0vcjCQfQyE/jYXy1pL
         kucWxjPxH9hwH7ybKmJTXUW+SBmlFC2j971rzZzMzqEATCAGfoum/DlVNhYfW8ebVHKr
         w4nQAU6y7dM8jwn53CtGsPX0ma72w6bdC8ULyF7q6WqHa0udoQS+6c10XPrnxn7gYSAV
         qZ7AYdAe1vx4046JYZGGmWLkNMocJjT4igje+DbzTnro1T3JgisyVp98fKHN+gVptOGm
         VGdA==
X-Gm-Message-State: AJaThX6306fKrwwbramh5GQh+mZzOCRAw02it7xKehhRvP0+8+6IqM8y
        OOiptDD39mbYjikRl6dCWRnjc6PDmOGGXcJDncc=
X-Google-Smtp-Source: AGs4zMbOW1IUSKsn+OKFnfqs8mDi9aoSgKt7BQ64ePGtfdMSgMP7/a3rSx8FVUX8kyKnWItTOKb8UpgLetgahw8C9YU=
X-Received: by 10.37.177.16 with SMTP id g16mr16663108ybj.191.1511505436970;
 Thu, 23 Nov 2017 22:37:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Thu, 23 Nov 2017 22:37:16 -0800 (PST)
In-Reply-To: <20171123202548.GA30957@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de> <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de> <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
 <20171115171258.GA12963@tor.lan> <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
 <20171116161506.GA20809@tor.lan> <CAJ_+vJ74mocjicpQ2BGUT+TrqrWqidp0bUJUGSz-B40-bC-c6w@mail.gmail.com>
 <20171123202548.GA30957@tor.lan>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Fri, 24 Nov 2017 12:07:16 +0530
Message-ID: <CAJ_+vJ7-M2fek8nFQgqYPs9pcAnYgenuvG50GC3ZRuPCc=R2EQ@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great work !!!
Thanks

On Fri, Nov 24, 2017 at 1:55 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On Thu, Nov 23, 2017 at 10:01:40PM +0530, Ashish Negi wrote:
>> Thanks for confirming.
>> Is it possible to track this via a bug number ?
>> It will help me to try out the fix when its available.
>>
>
> No worry, the fix is nearly complete and will come out in a couple of day=
s.
