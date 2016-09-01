Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D392035F
	for <e@80x24.org>; Thu,  1 Sep 2016 08:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbcIAI25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:28:57 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38879 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcIAI2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:28:55 -0400
Received: by mail-wm0-f49.google.com with SMTP id 1so81123670wmz.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fm06HxsdfIDqsb7TuCc1lALAKl3AwDdPHuT1PgWsR4E=;
        b=D4A7pFgX4dG087waxfkLYmJizMb+1wvjZ19vR309yZAUbnhRk+IT6bF7PpvXm3DReM
         UR/sG2c58RpzwPRH3IRMN5ZOTWlPXaQrDwntpzP1qOwFIBPozXVfOINjR58K9/CqMD1C
         A/4UXCyHg3wY3qNbJakdr5yG6KKRwbgmEiy0LMjSoB/IfOITsQd5nIHJrDCiSuQFI9Bs
         ZGMSBwdhsMzq86LBI6psloTZMRoqiv0HuiC87+jm20Z/uW9sk5IzWKAqfox60ARaUdQm
         m02FqLYCWgCnN1qJLcXBJ6kGnrtuzJrPmWOQSAcBm77NjRaK47EpJlpKZnLKzuHOCzy4
         4G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fm06HxsdfIDqsb7TuCc1lALAKl3AwDdPHuT1PgWsR4E=;
        b=gtgDhiSQ7UU6x3NWkAuFYCHGXcg6bOxKTKdWQGHJ0En2D1ymH/s9ZfWd3o+C7qRN7i
         q4UiLVBPuLaQDTxs+j/SY6IAFMval5AvvJfvmbhOanijYMo5qt98dUwbhf+/b3fzV2K5
         +OBFpttXgWuvghWH9mxiNnKA3gjKKHIIRVVW/2eX01LHPxrfKaog6yHShHx88Ft7vVqp
         Q21E8IIMFqoTvbWmRbUv7hs39/P7BHxeXrYm3RpJJJlUme5n0BxPuO3E9sxIFcZVIWHR
         anmDPoTWk8V7R99iXILQTrJYnDIbhqHUL1bVfMAKnkHZ+N4DzzkuONI0SvtT02+AeSaC
         2SRA==
X-Gm-Message-State: AE9vXwOLthyeydQIXLmgA0gKHHvRJbb0yfsvy8YJZoq+7U4gHW64vDz2ASvwtt0A9VlvNHkWzmfKSlju2VDITQ==
X-Received: by 10.28.61.11 with SMTP id k11mr13095231wma.34.1472718533795;
 Thu, 01 Sep 2016 01:28:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Thu, 1 Sep 2016 01:28:53 -0700 (PDT)
In-Reply-To: <xmqq1t14zit7.fsf@gitster.mtv.corp.google.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com> <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
 <xmqq1t14zit7.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Sep 2016 10:28:53 +0200
Message-ID: <CAP8UFD3wA32eXYq3F4=KS-9SkV48Yh45TKgFnn3AmGVfpjwWjA@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 12:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Aug 29, 2016 at 9:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> Highlevel view of the patches in the series
>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> This is "part 3" of the full patch series. I am resending only the
>>>> last 14 patches of the full series as "part 3", because I don't want
>>>> to resend the first 27 patches of v10 nearly as is.
>>>
>>> Just to make sure, you are sending the first 11 of these 14 exactly
>>> as-is, right?  I didn't spot anything different other than 12 and 13
>>> that replaced the "alternate index" step from the previous round.
>>
>> Yeah, the first 11 of the 14 patches have no change compared to v12.
>> I didn't want to create a "part 4" as that could be confusing, and
>> sending the first 11 patches gives them another chance to be reviewed
>> again.
>
> Hmph.
>
> But most likely, you made sure that those who _could_ review the
> first 11 are miniscule minority by omitting the earlier steps before
> these 14 patches -- unless they are familiar with them, the first 11
> patches are not much use to them.  And those who are familiar have
> already seen the first 11, too.  That was why I wondered who the
> target audience was when seeing only the last 14, among which 11 of
> them were identical to the previous.

Following Stefan's review, it looks like I will need to resend at
least 02/14, 10/14 and 14/14.
What do you prefer me to resend:
1) all the last 40 or so patches
2) the last 14 patches
3) only the few patches that changed
?
