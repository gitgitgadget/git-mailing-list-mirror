Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA33215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeD3Pr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:47:58 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45611 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeD3Pr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:47:57 -0400
Received: by mail-ua0-f194.google.com with SMTP id j5so5674424uak.12
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EcHospfHnqrWEYVA65KU6c5jAkySkjSlLL2pH/vtFn0=;
        b=E4GJhw0sdUB6n9DeCo04rWdFu5EyF626qgtRQk7l4fEtQgM6+FH0bX131kM5BNMBBy
         NxvuWmwqYJlccLW8B9kx7KO2WjCved9nTzP+4UHwNVAPyXpDQs4zxONLzbR8jXdkTnkM
         BSmB+CjSE2lM2t2nCYnbUQndAC5sXuMSvKZv5oDbzjMNIFOLvbaQFdarz+8HXqWJpf4H
         NFepBjGr68o6BU8R4F+Rzi476sdsJ5V0B7YgRMYGtkRcKIbCtKdQ9hoX1gZ73ZDjuy2J
         ks5vFSUqswwq+u7XEXEjZKYUuH20JyXxsiESJH92aW7Z1hj+TBsjm93uTuEpDGE3KPrh
         rORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EcHospfHnqrWEYVA65KU6c5jAkySkjSlLL2pH/vtFn0=;
        b=LllI1AeT6xDNgfndZFo1I25cmcd8fj6kt0J2aPADT6x2EbIGNpJ2EvqmlXlM17kLQ5
         GEsd199POtlq7X8SaoAeijatOBXIAAgq8dCH6qNXEelcJQeS27CglSZVxq8sLB1q8dH0
         wSr9co/fnNjpYw7nSqN8ffySNxIXW8emrv31DCBts7aE0m8VCaMi6fQSFyAaeq7tbaCc
         PfxAcGj92BP+BevndhVG+p7qv1AuUVGTlbi0JRWv91AQkAh+QPPIhL/U0ItMK1QA3HaN
         pdn484zk6wLniSvlKoLSWGBgh4sHsLzuXaOzM5VYLk+ERJnxTxBIZ4XEP339/WypDj3A
         l+fQ==
X-Gm-Message-State: ALQs6tAOEDdoiZkXlu0n6UtEakt7EQSJqktxIqdz1WZYuGDgMbqAyyn6
        kSovaptSkULVQ2DfywTgWq2jqT0nkF3txZWAje8=
X-Google-Smtp-Source: AB8JxZoSLrGE/cxBmTA5BZERd4nVFXL5ofUhayQd5ExgXoF24UiPHRLCIxNC4c7ukELDCMn0MVL4MLCcbe9Cbb+9gcM=
X-Received: by 10.176.83.38 with SMTP id x35mr9586032uax.29.1525103276178;
 Mon, 30 Apr 2018 08:47:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 08:47:55 -0700 (PDT)
In-Reply-To: <86b1fc05-b22c-cb9a-b5b5-d5e819d97c1e@web.de>
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
 <20180430063519.27122-1-tboegi@web.de> <CABPp-BHa7y8ggoCoLY0z4_=3njH=UV8GscXaz_YWvfNbfmPxhA@mail.gmail.com>
 <86b1fc05-b22c-cb9a-b5b5-d5e819d97c1e@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 08:47:55 -0700
Message-ID: <CABPp-BH54kVUnHR3r=XH9b6RhnQ2NpFSqVUnNyQU6M9b1tywMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for APFS
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 8:41 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On 30.04.18 17:33, Elijah Newren wrote:
>
>> On Sun, Apr 29, 2018 at 11:35 PM,  <tboegi@web.de> wrote:
>>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>>

>>> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>>
>> I'm not sure what "NFD" and "NFC" stand for, but I suspect the test
>> prerequisite name may be specific to how HFS handled things.  If so,
>> should it be renamed from UTF8_NFD_TO_NFC to something else, such as
>> UTF8_NORMALIZATION?
>
> NFD and NFC both come from the unicode standard, and are just taken
> "as is" into the Git world:
> https://en.wikipedia.org/wiki/Unicode_equivalence
>
> If you are otherwise happy with the patch, would it be possible
> to run it on your system ?
> (I don't have a High Sierra box, but I am confident that the test work
>  for you).

Sure, feel free to add a

Tested-by: Elijah Newren <newren@gmail.com>

if you like.  (Works with both 'test -r', as in your patch, and 'test
-f', as suggested by Junio.)
