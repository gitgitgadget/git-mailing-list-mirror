Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCEC1FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbcLHBMz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:12:55 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33330 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932216AbcLHBMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:12:54 -0500
Received: by mail-yw0-f170.google.com with SMTP id r204so310426727ywb.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UaY9wdUxmCSzWChf4wS+zaFrupPBWzxy1o+XHzSYRkM=;
        b=h13OCszD4BUugegOqkZ9+PvxjcAlqPPdzSmAbicXLZL5vF2uB0r9lyIuXr2dbTuoAb
         tSLprzfpueqXmk6xEWHMFawQ+bhohkp0nGcm0XEhDthnXhSMlEpwIGyx0nw4vM3O+MJt
         NbviqMBUxPGQqYjZBPP7f0BuAC1D2BydVjTpXjA2IfaKU4+NwP54qBnx+BCOOX8N68H3
         xiGeYyIoT8NGIVl/g2EhsKWcl2EQb19FF6jEYrtmZjlUGfw/Tyh0WOuHbP8obbnceFYZ
         SKMqcL5bXt6w0yfYSH9UZun31NnpaFr3ZNCsIF1i/qeMC0frGU3z9raZ2a19kW6t7MIs
         jJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UaY9wdUxmCSzWChf4wS+zaFrupPBWzxy1o+XHzSYRkM=;
        b=Nsf8a+I4Amv4Rxc4ZPcl8E/QDz77xTEvo0XhU7cGwn3gQjVJYKVMogc8fyEBVvDE/e
         uz56zQSNSTrYx/tX5AcY4UpT2mN5tkvjiRGvBMD4FkW9kQ0el40flcqT+tM7y9ViGHDS
         uLhM9OhqvBfZKVCjIYmn8ohCokrYpu3kYELci2BBOh1Xbxlx1Os8rI7Qc6bC4q9pH884
         HF9dVMkLA+V/CaOg+SOGHuOcF9Q8g8ESknAA/0+N8DVC9afwGTysE/YquuxfJ8untsrL
         QnlB9iBHkMWkVXZ3q1RS3OHWql6a769MbjMW/CwVq8b30n8MsZ158JHZVHxGgOO5Qnj0
         POVw==
X-Gm-Message-State: AKaTC01y+i9FZlUhuRBQoxX0I7xWTn6e7SqgkhowknGi/a8UHdU99Plv6ZEB0ueoXda/t03OHKs9hLjxNyMyJQ==
X-Received: by 10.13.250.3 with SMTP id k3mr64728305ywf.276.1481159104785;
 Wed, 07 Dec 2016 17:05:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Wed, 7 Dec 2016 17:04:44 -0800 (PST)
In-Reply-To: <xmqq60mvuv8v.fsf@gitster.mtv.corp.google.com>
References: <20161207023259.29355-1-jacob.e.keller@intel.com>
 <20161207023259.29355-2-jacob.e.keller@intel.com> <xmqqa8c7wfxu.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrPivwMzGhzKxu30jns+YvSQGXBKUc4JDmfbenTy27tZg@mail.gmail.com> <xmqq60mvuv8v.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Dec 2016 17:04:44 -0800
Message-ID: <CA+P7+xrWUS9BuwoOjGv+VtC5gR9vWrf7ANnks87fqvoDst9dAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] describe: add support for multiple match patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Basically, this started as a script to try each pattern in sequence,
>> but this is slow, cumbersome and easy to mess up.
>>
>> You're suggesting just add a single second pattern that we will do
>> matches and discard any tag that matches that first?
>
> I am not suggesting anything. I was just trying to see how well what
> was designed and implemented supports the use case that motivated
> the feature. Think of it as a sanity check and review of the design.
>

Makes sense.

>> I think I can implement that pretty easily, and it should have simpler
>> semantics. We can discard first, and then match what remains easily.
>
> I actually think "multiple" and "negative" are orthogonal and both
> are good things.  If we are enhancing the filtering by refname
> patterns to allow multiple patterns (i.e. your patch), that is good,
> and it would be ideal if we can also have support for negative ones.

I can add support for negative matches pretty easily. I personally
don't see the value of "logical and" filters, ie to match only tags
that match all the given filters, though that does allow some other
forms of expression.

I do like the idea of negative filters, and I'll go ahead and work on
adding that as another extension.

Thanks,
Jake
