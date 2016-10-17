Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6231F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757700AbcJQWuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:50:44 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:32787 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbcJQWum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:50:42 -0400
Received: by mail-qt0-f181.google.com with SMTP id s49so136167482qta.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7t+3Wd7cev8EOpBRkfqluOOq44BNm+UrW92+qaL3IfQ=;
        b=MvFv7D3bsjZbm2iUwUeiFhLfCIFFI6AkQkr7PRDYXWlAKJi5LM+NTYQxCzd+7k0xir
         Rhsl7Y1Qi8BjT0XbKpsUgO/crmL8p6eTzlJw/JoYQj79RYiJlYOKoLmaRDsOHNL/T3DV
         0jWhM7rYE/nq51tAxXjAtYk8ChFOu3z8mLPy259TnNTEyZxQKS+9rLzCvtlGTGHuF6bX
         axvr6G867IrSUtq2DFw5HxtBH4xAIYU0Dquj5mmDuK9jm8pXkAB2c9RHsX7h8lcPT9dC
         q0/Q4eajQLcKxk/m3mzyF6RVFm6cnfg6rk72nitnE5XFZkI+RSAdH5HrofoXKAf0b+bM
         HTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7t+3Wd7cev8EOpBRkfqluOOq44BNm+UrW92+qaL3IfQ=;
        b=G7BocQcJ/8HcaEaRQ3tQgK5GMg6tBEUB5Vno5evL+eLI954BUyytgAmCDK2bnye4OO
         NcggP3ZxSzj+djoMH1s/wJxaRCwNaGEccmGptSkGFR3lb0Hx/+q4fzmyP8NlCuXhliU5
         QuA+eaedJ0nRBHqp12qXzM1AYspyE2N6y0VxkEqrFGsl+wcgaMLacWNB4C/IzvaAjkZi
         jfRNLmav/D86DrkjCzggsJZc+uifx70A4NW0ZDgR/Dd4LVYeGbOsVH3XYTiUq2I2LLLq
         mteQCD+WIkv7iML4ZNSP2+eXciJxqEcbFuvl0xb+3fXVB9Dss22dXFAnFJmNqAV367t+
         1pow==
X-Gm-Message-State: AA6/9RmAsCZjWDyXc3oV2IVJ5WPxikWxXokUpssJDPcwXoGdZ5emakNooPN4gA0jjv/elfBW6/TEaki/+30PNFp/
X-Received: by 10.200.34.6 with SMTP id o6mr28613285qto.88.1476744641655; Mon,
 17 Oct 2016 15:50:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 15:50:41 -0700 (PDT)
In-Reply-To: <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
References: <20161017221623.7299-1-sbeller@google.com> <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 15:50:41 -0700
Message-ID: <CAGZ79kaE=KAWcDTEvAqGO=-zzjh3VeSwHH82SnhK6DO9THOyPA@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 3:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static void strip_url_ending(char *url, size_t *_len)
>> +{
>> +     int check_url_stripping = 1;
>> +     size_t len = _len ? *_len : strlen(url);
>> +
>> +     while (check_url_stripping) {
>> +             check_url_stripping = 0;
>> +             if (is_dir_sep(url[len-2]) && url[len-1] == '.') {
>
> This is "strip /. at the end" it seems.
>
> Does anything in the loop control guarantees 2 <= len at this point?

Oh, thanks for pointing that out. I thought about that and missed to add it.
I'll reroll with the length check once we hear back from Windows folks,
that this is a viable strategy for them, too.

Thanks,
Stefan

>
>> +                     url[len-2] = '\0';
>> +                     len -= 2;
>> +                     check_url_stripping = 1;
>> +             }
>> +
>> +             if (is_dir_sep(url[len-1])) {
>
> This is "strip / at the end" it seems.
>
> Does anything in the loop control guarantees 1 <= len at this point?
>
>> +                     url[len-1] = '\0';
>> +                     len--;
>> +                     check_url_stripping = 1;
>> +             }
>> +     }
