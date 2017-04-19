Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFAB1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967831AbdDSVYH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 17:24:07 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33595 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967527AbdDSVYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 17:24:05 -0400
Received: by mail-lf0-f52.google.com with SMTP id 88so19212544lfr.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s8XAPAmlmloWt42C/0t2X+aod0c8p+qI+yhkc+4gvJo=;
        b=JTNz+M5Z3X7DIhacDZ9YHXXsyoK2t7PdPtdoM4nEzpYLLp9BF7d40FPh36TTT8GlUX
         kng3ESxYRH8ENCbqTYlQiA1cLU7WbVO1W+1TPA885xQMukO34YJhuYSx8mFkx3nYiGl7
         KS7BVUcPdMWzIeCRhWFgwy7XwYQcMiIA2H5ughewsuG6tPyGNr1SAOOPD2ZYOL0dySgt
         jaUO84HTUc+ml+u9P267c990Iw5Iynle6AHbCcp13QYN2cYSF0Bo7XFlF65FMdU1sXaB
         QEGa1rBZFOB4mTCV2KDQATM2sLzm2l1MM436B7fExEkYuTrAhQqXo7nQNjRxCUIrpS+k
         zh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s8XAPAmlmloWt42C/0t2X+aod0c8p+qI+yhkc+4gvJo=;
        b=m2jk6IJsNSF8+3q0KPOt/5UzBfysm7elOPAebwZAMCQYL2YxnfwYzXNPoCDNWu9bLD
         h4hGgazSTL4YePh8FN14hhj4jVJlWjgtzOKqTAnUCa9wzFgQDaqTRItnldVBii5YO1oI
         aHDMMGKdXuyiz0V9TPM1OdubCKVaVIuE5MxBKgoaeXdm1F8VTBjwd1tIzuHVIBjgzQQr
         5i7pgDAgG1m20IeqpFk4BkTY4hgo4lrxrnuB60fcN6VJjWT37pM2C8GF7WQEO7hZWx4G
         nmwla/Wc8EGAkyfdGuLunJfzBDeNhHODJ/3M7ulir+CUb+X0ElkxU4ibcAzqqMrC2zOP
         Ktkw==
X-Gm-Message-State: AN3rC/66wrGFfhXgYtFIj2sPM8TZiRpuFb9RDeJA7Z7nFGrkPzLx64q/
        v5i9R0k/QxehbVtNAYoklcXfq+2w8g==
X-Received: by 10.25.196.133 with SMTP id u127mr1869103lff.88.1492637043817;
 Wed, 19 Apr 2017 14:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Wed, 19 Apr 2017 14:23:43 -0700 (PDT)
In-Reply-To: <CA+P7+xpahRim9H1cHuHmzjGggYt2qbvxrDYyi+ri0QsDEUAkcw@mail.gmail.com>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
 <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net> <CA+P7+xqo6BJ8LXy8EVvq0JXPD4r-jZ6boOGT=2XY8SVnWfVMcQ@mail.gmail.com>
 <20170419210028.sky24qda7kp4pl5y@sigill.intra.peff.net> <CA+P7+xpahRim9H1cHuHmzjGggYt2qbvxrDYyi+ri0QsDEUAkcw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Apr 2017 14:23:43 -0700
Message-ID: <CA+P7+xoMMPHwkaDiZWjD5gCoKh4iWGaVQ+206i8kS9aFM5zcEg@mail.gmail.com>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 2:22 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Apr 19, 2017 at 2:00 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Apr 19, 2017 at 01:54:06PM -0700, Jacob Keller wrote:
>>
>>> This is why it's an RFC. I don't really feel that it's too much of a
>>> problem. As for the reason why I thought it might want a flag itself
>>> is because of concerns raised earlier that we might have something
>>> liek
>>>
>>> OPT_BOOL( ... "no-stage" ...)
>>> OPT_INT(... "stage" ....)
>>>
>>> or something already which might be broken and the only proper way to
>>> disable no-stage is no-no-stage?
>>>
>>> Is this actually a concern? I thought this was a comment raised by you
>>> earlier as an objection to a change unless we specifically flagged
>>> them as OPT_NEGBOOL()
>>
>> I think the breakage in that case would be caused by "--no-stage" taking
>> over "--stage" as well. And your patch doesn't change that; it happened
>> already in 2012.
>>
>> Your patch only affects the --no-no- form, which I think we would never
>> want. I don't think it needs callers to trigger it explicitly.
>>
>> -Peff
>
> Right, I was just thinking in the weird cause were we *do* have a
> "no-option" that does want the "no-no-option" to negate it. Maybe this
> isn't ever a thing and we don't need to worry at all..?
>
> Thanks,
> Jake

And in this case the same PARSE_OPT_FLAG would be used to also not do
the "no-option" negates to "option" as well, since the options point
would be something liek "this option starts with no- but negates
normally even though we don't normally allow that"
