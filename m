Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711CD20970
	for <e@80x24.org>; Thu, 13 Apr 2017 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdDMKwq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 06:52:46 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33330 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdDMKwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 06:52:44 -0400
Received: by mail-lf0-f51.google.com with SMTP id h125so27639338lfe.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0IqvBv9Q1i6COFZANjq1/ngX4ZXq5yTguxD0V3iNUX8=;
        b=EzPELEHs+Si8vjuLvVLELfsHVqEnZhUFwsMqKUWzKl9k2S0/1YRrtvUNfvOi8Xu0K+
         kqHHCsMqO7b+TTnaJBvE9aZLFgmjH+vboRw8UNPo0AGo9l03oKL4yhoDcDBfufJ15sDW
         1ZTfYvCSyHwOBzYKhsgzSN1wgastKc6IRAsBTAPFcPJcGPGpRn2CgY3tCliUtVspWfeC
         GN1Sp4dTDD1xMxdkYRi/3pB8XmOui6gEm1Geua15y8ShlsgkOQBEsMrk4DaTDuW3kgn8
         Q/PMWV4iHjotHDq30RD1T67Psoa9ZW0YDThjyNbfgwHmpGjIhaq4FDvJyHKMdo9F8a9w
         I3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0IqvBv9Q1i6COFZANjq1/ngX4ZXq5yTguxD0V3iNUX8=;
        b=gllRhfO/fm003QRqfgvH1GYdHaEKNdpebwtRXxiWQ8+6ehEY/N4K2aT+LjTJxTshzh
         WsBazXIeEPMMVhcOgfd0QolbTNa9ipvOTczetxlcgkVLsoEZep9GtSjYNFmqJpD5/UEx
         c5czgkYyw+Hp0IIXKXNFLgeW+USvmAXBQ31l5/rrHbp0iOy8I7pleFZpI7e1YGD91mh4
         K4GvTDGqq+KjyFTm2Urg0UtFqdP5SiHZOuNRTeOTCOxNlhtPg7x35FVSkdsVdj26VLfb
         aSoukoDqNyrUeKQBhwQXBRGSXasbXA7xDVhx8ZF5GevSaF7FfV9op3PeoP2weNXqXyKE
         WmHA==
X-Gm-Message-State: AN3rC/5hC5U0AEM+7dilL/FOmMt1RGgmDcN91CJEyNQKRDzQLrSvFMKp
        nRd7+oSfWcI7Eo98bHAIg0v2/OVYrRpi
X-Received: by 10.46.74.9 with SMTP id x9mr770751lja.4.1492080762531; Thu, 13
 Apr 2017 03:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 03:52:21 -0700 (PDT)
In-Reply-To: <xmqqbms0q0s3.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-8-tgc@jupiterrise.com>
 <20170406091857.hl4ndn52kj2z4ujh@sigill.intra.peff.net> <xmqqbms0q0s3.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 03:52:21 -0700
Message-ID: <CA+P7+xpnbcaJ8ucxfF9pGiN6=72jbq=EvRfX1qKOkG_QjWh+DA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Apr 05, 2017 at 03:04:24PM +0200, Tom G. Christensen wrote:
>> ...
>> These kinds of interleaved conditionals make me nervous that we'll get
>> something wrong (especially without braces, it's not immediately clear
>> that both sides are a single statement).
>>
>> I wonder if it would be more readable to do something like:
>>
>>   #if LIBCURL_VERSION_NUM < 0x070c00
>>   static const char *curl_easy_strerror(CURL *curl)
>>   {
>>       return "[error code unavailable; curl version too old]";
>>   }
>>   #endif
>>
>> Then callers don't have to individually deal with the ifdef. It does
>> mean that the user sees that kind-of ugly message, but maybe that is a
>> good thing. They know they need to upgrade curl to see more details.
>
> Yup, thanks for a very good suggestion.

I also think this is a good solution..

Thanks,
Jake
