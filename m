Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53062201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935366AbdEOSdG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:33:06 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35903 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933211AbdEOSdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:33:04 -0400
Received: by mail-pg0-f50.google.com with SMTP id x64so44657177pgd.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nkv3SIWdfcArfjqbkvuYISfVMuXoHz5iTVR+SB7ksB8=;
        b=ETFar6PUDzVpJLzZ4/hW5Qhn1xfO/t2tStCB6bBRfaWLPskpT8mVyR0DKOzxgH0uRg
         XHMnyAe+RFEfWMmxdHEw9SfFnvgqfWCdltPSGkOZUzf787tkuEVMhyrzL6npLeG5A61w
         xx7ovIt8J7vE5o44uK1BTiprXJu5wZe7hHLy2BvMO/XisB+boDDd4l+a5IegMqpGPIIn
         Qm1HIPGnh1TsKkJmnT3BibjnVECMD+0TGlLSYXWPw+3roB4JnX7y47yJg6YNEQvaGC4P
         tQHZy+Nwi+J/Z6obIZYsDNQT/UEc1czum6X7nQB33JesJYcTPDTUIdrV4rUtHPppJo+N
         o16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nkv3SIWdfcArfjqbkvuYISfVMuXoHz5iTVR+SB7ksB8=;
        b=MgrXTQtLRifAm9YLmcUszSI1OD7Iww+7dMozprxoSL6xR9eKNjjM8NLB++pyy1p8Qp
         vYZnBnB+bSc5DLnqKtIwoIPWsgUnDdJNwTC7Gwb2lnfbZryn9s8qCusXyMRZgwOcgs/w
         +FAH3WkiEby8JaQ/Tl8axqfsp7uMf5ZgdPKulgh2B0uGtwhec3QUeUc44zNnpOo/znyo
         68XU4/LMtqNDFWaXDshPX91ogG7pvM9yqmSreQX8J+2cxCHSYEjx9KoA1oKxFDIuy3Y8
         92N3GaIfkiS5CUaKAoS+evlDniL5VS+LsRumr57ts6Kb2dXKc058utITfAVU598VrCt5
         fckg==
X-Gm-Message-State: AODbwcCheW2hhbxtqFwYbxwd+7Kd4KIgbQDE3V4vEjtBKKQpuXk9/63U
        pKlrkRS9w2Frb4SC5xmGmLyROTZA+ktu
X-Received: by 10.99.60.81 with SMTP id i17mr7728296pgn.183.1494873183539;
 Mon, 15 May 2017 11:33:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 11:33:03 -0700 (PDT)
In-Reply-To: <115f4d30-5c97-9ee9-e56b-3cf955a5454e@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-4-sbeller@google.com>
 <115f4d30-5c97-9ee9-e56b-3cf955a5454e@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 11:33:03 -0700
Message-ID: <CAGZ79kZSixaG2CoO-WV47=-eE96yhtoCm82KFbZ=-=8c-VPXcA@mail.gmail.com>
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:26 AM, Jonathan Tan <jonathantanmy@google.com> wrote:

> "erroneous"?

yep, words are hard.

>
> I also don't understand the meaning of this paragraph - if you mean that
> this patch teaches other callers to hardcode the sign, I don't see any such
> changes in the diff below.

The last two hunks of the patch switch two callers that call with a sign
that is hard to reason about.

> After reading the patch below, would this commit message be better:
>
> [begin]
> diff.c: teach emit_line_0 to accept sign parameter
>
> Instead of a separate "first" parameter representing the first character of
> the line to be printed, make emit_line_0 take an optional "sign" parameter
> specifically intended to hold the sign of the line. Callers that store the
> sign and line separately can use the "sign" parameter like they used the
> "first" parameter previously, and callers that store the sign and line
> together (or do not have a sign) no longer need to manipulate their
> arguments to fit the requirements of emit_line_0.
>
> (And then mention that you have checked all the callers and that none of
> them send '\n' or '\r' as the sign, as you have done in this version.)
> [end]

That describes the situation better, indeed.

>> @@ -556,7 +547,7 @@ static void emit_line_0(struct diff_options *o, const
>> char *set, const char *res
>>  static void emit_line(struct diff_options *o, const char *set, const char
>> *reset,
>>                       const char *line, int len)
>>  {
>> -       emit_line_0(o, set, reset, line[0], line+1, len-1);
>> +       emit_line_0(o, set, reset, 0, line, len);
>>  }
>
>
> Maybe this function is unnecessary now that emit_line_0 can take the line
> directly.

That would produce a lot of code churn, specifically in later patches;
but I can remove that function if anyone feels strongly about it.

>> +                       char term[2];
>> +                       term[0] = options->line_termination;
>> +                       term[1] = '\0';
>> +
>> +                       emit_line(options, NULL, NULL,
>> +                                 term, 1);
>
>
> If options->line_termination is 0, this is actually a zero-length string
> (not 1).

So passing in !!options->line_termination should be fine?

Thanks,
Stefan
