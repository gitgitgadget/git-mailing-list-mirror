Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6519A1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeCWS7X (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:59:23 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:45238 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCWS7W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:59:22 -0400
Received: by mail-ot0-f179.google.com with SMTP id h26-v6so6891292otj.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dBALgJNU8KYHOLr45HynpYS4TZALWZ9pfj7m3yeXBzk=;
        b=FNgQBq88t4g1eT/5U83/Dma0UP9HaGlp41a1sO8WAOeMuNwuadG3higYOusKJGzYZo
         PUaQc7FUTV22WVBjN0AL3Ngx+ZBgRdLQLw02wdfUU/0jRYwNHkyEr/Cg9zfgohwxslsz
         u3TGxA1AR1bLRegSBtpKYpMpkBoAa7LtwXPNlMV0jWKUy+lin3dBoBeHvz/2NDW0aW26
         CnS1ObPRTMsRE1ina9hDjDk3okLu7bOo++y8iNVufqNZ6HAwzIKcBTdqO5ZyxpUnrzQ/
         ldETh0lVW4GOJUYFeoSaSD6SUz8U+CZhPyctgjqked5obJBCgOaTfA6+6+4d2sib5wdI
         xqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dBALgJNU8KYHOLr45HynpYS4TZALWZ9pfj7m3yeXBzk=;
        b=fCJWoRaNf9tGiQSr5rucOadz3OIzHqfo+qucWZAxpgkXFQWstKTx1uoUtgxjMv8JI+
         rFY6BCyfwuQwW8UttrfknyYLYFv7jt9tokMSWMHsoV65vB0E7GYdcqYi3xcmWl7HjFDu
         K8k50ygvNTZKVZftIrt8rTxAezjf6MUY6uYEXHRNqqo6/pxHk32hD07J/EyNOQRjouSA
         c0GyjNdJns8fXfQyVSRZGQKU6JxhXKXpNdggh0/vET028LZVGDfKlZxoWn5pIMOoezh3
         HrL+nJUydBBhnWDspjzyf9CN7jKCXPgQw0FPSNLs+Fmts/c76+XVfVc6e+idXI6cQOSX
         0QXQ==
X-Gm-Message-State: AElRT7HrJsATvOqehzQS09KPCuFroqXFzSqTHoW61VqhZ+j9oKhrZ/Rx
        AAZ5IwxJ1k4hY5t1uPKLWaQgV2GvY11dvpE2VI8=
X-Google-Smtp-Source: AG47ELtjB99V+jDwz3oh6G47F6u4DNf7i5YtF4+4zg3faNV0FxX+Sk34s1wQMUDQ6EZ6/bLPQw9D/VYtWWnru1xGUJ8=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr20387724otq.75.1521831561648;
 Fri, 23 Mar 2018 11:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 23 Mar 2018 11:58:51 -0700 (PDT)
In-Reply-To: <20180323183550.GB243756@google.com>
References: <20180303113637.26518-1-pclouds@gmail.com> <20180323172121.17725-1-pclouds@gmail.com>
 <20180323183550.GB243756@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Mar 2018 19:58:51 +0100
Message-ID: <CACsJy8C2MXqsRaoXsk+Kbbc21VG0dXtCEK45Yj6-S2RdOk9pSA@mail.gmail.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 7:35 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 03/23, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> I think I have addressed all comments I've received so far. What I
>> decided not to do, I have responded individually. One comment I did
>> not respond nor do is the approximate thing, which could be done
>> later.
>>
>> Interdiff is big due to the "objects." to "objects->" conversion
>> (blame Brandon for his suggestion, don't blame me :D)
>
> Haha, I'm guessing you prefer having a pointer too then? :P

That goes without saying or I would be arguing against that instead of
spending time fixing a bunch of compile errors ;-)
--=20
Duy
