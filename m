Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126851F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756481AbeDKUcF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:32:05 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35990 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeDKStd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:49:33 -0400
Received: by mail-yw0-f171.google.com with SMTP id y64so902982ywa.3
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5KHs6fi4WgfloSW1OnTDnjr+tYcK2lAgCYLUNNqIO5k=;
        b=F4olO0/t8bL+SYXfICNEF28JnMGMcuGLikxnFTFrrGfgfP/izzBxxjKBokti0KXoWK
         hstP4sXUjVx0aT/Xi1+XWWWSXNdwShMAbm8l6fFrKLKWd2W6Ix3ebcAlcTESoSyNMuz6
         lscO0i66dcteYCE4eGPX9y6kaZesx7HQ+S1XPoeRJSImXpLFi40epiL/K4h15dCI0EhJ
         r+jIBY+UhXymILwdIZ3QRy3zcn+juB3bP6VF67ePeVCB6J1fjAk5seuuekbzj6od8NdC
         o/UFqGmW9C2cX3MjnJ5kFJLVit0NP0KQbFPw1abkU4xtWv0A1hvy2Q/Cdrd6VPq/hBTX
         vaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5KHs6fi4WgfloSW1OnTDnjr+tYcK2lAgCYLUNNqIO5k=;
        b=AsuSsM7bs7c+Sdo1+8BURhiFV0PeOShVwuYPp48Vt4f3V5kd2XWDrlCmhyehflhfaD
         MjrCzZqdcvgrQSqxBhBx1mjYBTcH5hiS2iSpBUUUPoDN69UXrC7gyWgxHcPYTdO6MpiT
         SWw7NAZyGsHUoN/gmok5GaMHEYF24WvtrWIoH//RlUUgIGybktRIo05XQ394gn5VavZO
         cZmwQ/rIIa4qXnBRSjhmfX2VQc+eKpc2Di+XcRWk4ZxGUilD9S8lzzKIg65aeeDgYC8g
         /YtegXCaD5R/Ax315TKvNZfx4fdaklXQaPQs1bgo/R2rAkXW+SiQq1sPv8y14lKk4fjX
         0sYw==
X-Gm-Message-State: ALQs6tDUCjgXkvqRSRgwL7lBdNzxY1okT66Su9TDtyZHUJ7LOo0t08Nn
        PeHdg0ZB7rPkMg5MTtD5pTebgttqenSaPgLhvPbqpGhf
X-Google-Smtp-Source: AIpwx4+oKJsHCGsRnrxBAHHqCfzkK4NKldyRZpj3xkbmxzjb72uWhwFNk7r0Fsape+q8qCQZqZou0+VBN1u1N7RUTnY=
X-Received: by 10.129.86.5 with SMTP id k5mr2628853ywb.345.1523472572153; Wed,
 11 Apr 2018 11:49:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 11 Apr 2018 11:49:31
 -0700 (PDT)
In-Reply-To: <9ba7d27f-ce65-7f2c-601a-1bea3274104e@gmail.com>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-5-dstolee@microsoft.com> <xmqqa7uazc9e.fsf@gitster-ct.c.googlers.com>
 <9ba7d27f-ce65-7f2c-601a-1bea3274104e@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Apr 2018 11:49:31 -0700
Message-ID: <CAGZ79kaqyEvfS2aND-pBkgjN0=GCmU8MiXvoeNJ8RAjpbqyn_w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] commit-graph: compute generation numbers
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/10/2018 10:51 PM, Junio C Hamano wrote:
>>
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> +               if ((*list)->generation != GENERATION_NUMBER_INFINITY) {
>>> +                       if ((*list)->generation > GENERATION_NUMBER_MAX)
>>> +                               die("generation number %u is too large to
>>> store in commit-graph",
>>> +                                   (*list)->generation);
>>> +                       packedDate[0] |= htonl((*list)->generation << 2);
>>> +               }
>>
>>
>> How serious do we want this feature to be?  On one extreme, we could
>> be irresponsible and say it will be a problem for our descendants in
>> the future if their repositories have more than billion pearls on a
>> single strand, and the above certainly is a reasonable way to punt.
>> Those who actually encounter the problem will notice by Git dying
>> somewhere rather deep in the callchain.
>>
>> Or we could say Git actually does support a history that is
>> arbitrarily long, even though such a deep portion of history will
>> not benefit from having generation numbers in commit-graph.
>>
>> I've been assuming that our stance is the latter and that is why I
>> made noises about overflowing 30-bit generation field in my review
>> of the previous step.
>>
>> In case we want to do the "we know this is very large, but we do not
>> know the exact value", we may actually want a mode where we can
>> pretend that GENERATION_NUMBER_MAX is set to quite low (say 256) and
>> make sure that the code to handle overflow behaves sensibly.
>
>
> I agree. I wonder how we can effectively expose this value into a test. It's
> probably not sufficient to manually test using compiler flags ("-D
> GENERATION_NUMBER_MAX=8").

Would using an environment variable for this testing purpose be a good idea?

If we allow a user to pass in an arbitrary maximum, then we'd have to care about
generation numbers that are stored in the commit graph file larger than that
user specific maximum, though.

Looking through the output of "git grep getenv" we only have two instances
with _DEBUG, both in transport.
