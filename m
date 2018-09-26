Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99BC31F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeI0AmK (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:42:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43907 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeI0AmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:42:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id z14-v6so10519006wrs.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zJdYbwxIot5zhfR6pKYCa6mVyP+r9vcn+2ykT4uDI8U=;
        b=Dx2ijxpj/GIX0kxeYToUzHbfUenCQp1EvNoMsys2nUPN/mEQLH3BsqXqQDEqCES40d
         KGVnNJ7UxGeswmHRX963QT9x0JtGhRKiMjLMkjLqL1IapTd2yOTuWb4gOCzWIaHtst65
         5K4qDu+QcpjlX8BzCAD6f7eTbHfyeJujLMqQ48qIkOjWcuhm+vwjiXRG6kmBaqrmzFEG
         0fMLZa2HbAuGBRJjSLllDjfnfLdqgfj7fkPgXXPh8ICzMTcXq/XHRej70YSpCnmwL/2C
         arc4ZrzbJ/6s3d0LXrEmGrh3Lx3kJaMlZTa9pZbmfehE4Ik4tATvBu/lUhBl2mJLcXi6
         YL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zJdYbwxIot5zhfR6pKYCa6mVyP+r9vcn+2ykT4uDI8U=;
        b=Twhv/nRNUHjdTmDqVvBcesmyeC084HR5oZwpbSR4cpXdhRYngo0lWO3NgsZg8KY2JM
         g5dzSfqpQ6jPFkGh05LoNK8NOb/3rFwroLduVJ7Uu/qeKJXqOEIWL8XNX5QZ64Q+nAuA
         9BvkPTIdFgz2+7OfTzI5eVK2USVCJiv6+kHthVrsTyi2lo4WCyOvYsn/E8LamqIF6wZu
         sn7XvE61+GLhTbVDJIowBqCq/nnzOA756tMmXBI5P020vJn4ZchwoU4XJKaSDBF1lkzg
         DIQASBfwQBhqXfdseyMlfG5gXOCSktNt3VQy4wEYLUjMgNW1/TA8ea/w4R5X5/y6IpOR
         tyfg==
X-Gm-Message-State: ABuFfohNR78vIt1NUqeBeIkwwDfmhBuvwWH60bkXFAYflXzvuzWFOBQq
        cJIe+hJW79VntEK/pcmzNco=
X-Google-Smtp-Source: ACcGV625TPgUqFhKhM7t3OzwJ6usebfykkITOqdWo+n85wDN7JF5o22a0Po5Ar7FL/52tQP0KKGo9A==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr6186340wri.221.1537986474913;
        Wed, 26 Sep 2018 11:27:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z69-v6sm172672wmz.18.2018.09.26.11.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:27:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
Date:   Wed, 26 Sep 2018 11:27:53 -0700
In-Reply-To: <87d0t0jghm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 26 Sep 2018 19:49:57 +0200")
Message-ID: <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Sep 26 2018, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>>
>>> Yes, please. I think it prevents exactly this sort of confusion. :)
>>
>> CodingGuidelines or SubmittingPatches update, perhaps?
>>
>>  Documentation/CodingGuidelines | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 48aa4edfbd..b54684e807 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -358,7 +358,11 @@ For C programs:
>>     string_list for sorted string lists, a hash map (mapping struct
>>     objects) named "struct decorate", amongst other things.
>>
>> - - When you come up with an API, document it.
>> + - When you come up with an API, document it.  It used to be
>> +   encouraged to do so in Documentation/technical/, and the birds-eye
>> +   level overview may still be more suitable there, but detailed
>> +   function-by-function level of documentation is done by comments in
>> +   corresponding .h files these days.
>>
>>   - The first #include in C files, except in platform specific compat/
>>     implementations, must be either "git-compat-util.h", "cache.h" or
>
> Thanks. I had not looked at this closely and was under the false
> impression that it was going in the other direction. Good to have it
> clarified.

Heh, I knew people were in favor of one over the other but until
Peff chimed in to this thread, I didn't recall which one was
preferred, partly because I personally do not see a huge advantage
in using in-code comments as docs for programmers, and do not like
having to read them as in-code comments.

If somebody wants to wordsmith the text and send in a patch with
good log message, please do so, as I myself am not sure if what I
wrote is the consensus position.  It could be that they want to have
even birds-eye overview in the header files.

