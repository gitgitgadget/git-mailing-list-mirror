Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093AA1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeI1Em2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:42:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36686 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1Em2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:42:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so6478479edq.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dvol4129Jh+CIDYGtvJNyXtvPgavvwxiucZV2lTkLM8=;
        b=gfZX6P8g84BAp5ZZmqQvyBFVG29STnyoE3rPX/sDRpNttPjdud+PRC/n7AtyhkAv9y
         Oqfe4qr3hnNdTE5juJBZhEtKMydLyrXdrEx3EDV37oS0XPMsZo4TZFKBlk5rBm0NNNyu
         axMnhq1ioojfjVTYYZZLpXjQ5i9Dc4FdDypbrRKWMZ+5OOCW7YAaUCEyHRv/hFFkgGmx
         GjHPlcDBcaWj6CKv2wukig9zmYc7c2ITZSTKQkvpTtWK/A9WkcGtmV2v60eb+i7f7Gxg
         SpJXMY54LYojyARJDxCNKlxT63WtB1wGeIaGjdzS72rPkbRCk+8WgnPXcJowmGtWPd/z
         +7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dvol4129Jh+CIDYGtvJNyXtvPgavvwxiucZV2lTkLM8=;
        b=t3sr/wortWoPkAxI1o1LihLTsD9FyW90ykOV23RBSnCpQEmxMsX0Zz9CEr6oW7uP2F
         /6qcXcOGlKLPnAZykGzWly32DPM2eacwQkaKXRGXGfrNeRzSAV/A2tqqzW5igIi70Sti
         erVtijVSIenrk8tGcdte7HS9S91UIUsVXbduYqLo2DAV5TsCFc8N2Dj2wVrUAN4NWTfz
         WzMnRylHDUjoOaICzGiF6DeQHpKE27KdVhtAXNkeQVd25v54CX5sQxAMyDWQx3I5aen6
         gwM+b+H/AxGejYWCiLd28k2Z4CznpW3ePzELRqtCSzIE0Pe7NRz6Kz/J+e/QL/+p6/fp
         M5Iw==
X-Gm-Message-State: ABuFfog4CUjwca60UjsyjN4GXoZvtCB/gYWBgShffn+IdaaQoa3P520K
        ZGjgWnM4vGJgc7AXnhK5LWo=
X-Google-Smtp-Source: ACcGV62B0zchouDZzL1sOFobb4YMPPpOSUNTRUGWjpDMjLOLGT3WwBgbCFqv8s177Zp7gGJY/UBBuQ==
X-Received: by 2002:a17:906:c156:: with SMTP id bp22-v6mr3759519ejb.82.1538086917990;
        Thu, 27 Sep 2018 15:21:57 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id g39-v6sm1866154edg.63.2018.09.27.15.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:21:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com> <20180927212727.128214-1-sbeller@google.com> <xmqqftxufwgp.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqftxufwgp.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Sep 2018 00:21:56 +0200
Message-ID: <87mus2insr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
>
>> There are different opinions on how to document an API properly.
>> Discussion turns out nobody disagrees with documenting new APIs on the
>> function level in the header file and high level concepts in
>
> Looks conditionally good ;-) Thanks for keeping the ball rolling.
>
> I didn't get an impression that "next to implementation" vs "in
> header to force people write clearly" was totally settled.  I'd wait
> until Ævar says something on this ;-)

I think this patch is good and should go in. Having it be consistent is
a good thing, and we're drifting more in the *.h direction than *.txt.

The "next to implementation" suggestion was in the context of what the
perl project does, to get good use out of that we'd a) need to move all
the *.h docs and *.txt to *.c b) have something to slurp up those docs
so they're formatted. I'm not about to submit any patches for that.

>> Documentation/technical, so let's state that in the guidelines.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  This is how I would approach the documentation patch.
>>
>>  Thanks,
>>  Stefan
>>
>>  Documentation/CodingGuidelines | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 48aa4edfbd..15bfb8bbb8 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -358,7 +358,10 @@ For C programs:
>>     string_list for sorted string lists, a hash map (mapping struct
>>     objects) named "struct decorate", amongst other things.
>>
>> - - When you come up with an API, document it.
>> + - When you come up with an API, document the functions in the header
>> +   and highlevel concepts in Documentation/technical/. Note that this
>> +   directory still contains function level documentation as historically
>> +   everything was documented there.
>>
>>   - The first #include in C files, except in platform specific compat/
>>     implementations, must be either "git-compat-util.h", "cache.h" or
