Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3E520986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbcI0Td4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:33:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34731 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbcI0Tdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:33:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id l132so2637767wmf.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aVarnoEISe2loWmejp6XGszhfMnuNHtReEkRmEJyvSY=;
        b=tWF4fDpApUU+/rzoewkDlmR5Uod+Qi0IdRj1eQSsmr/e3nvWmM9NupjhAM4aK+ovlN
         KMG4HOzDTs5PQmUBcbE7XC7m/+ZPEj4iURXoYX7cSc0H6vToxgmZq3R9VlfiqeksNWcE
         jIODADJUuLI7/G14e5heWusjgPelrGUofWzZmLSnio/mgdBsj/LNIu59kxh5J+Sxa+je
         iMEFTFyh0fO+YZvWZi1VDiAdlHFbefmMcc72ErYPRvkc8VdHaJS5oewpT3jtvD+sfuHv
         KVXvZe1ZLc0iaT7nDloxMwKsBHL6mVetk7kyfHdCJa3rMy+PSDfpZlPCxnBPx3DQ7NYB
         4wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aVarnoEISe2loWmejp6XGszhfMnuNHtReEkRmEJyvSY=;
        b=FNOwXdG+5rnveflQtylEjm07SyTf4SbwAOMCH4NH/F3G4Fqw08kgUICaUmEIgES5sA
         kLjfUFPos28xJEtsy5bnPP5+T3ncyyD/6acPbZNGpRufRRYSDopLSRfACspZCFmJ3T6Y
         1luaPKzD0fGfJmvfea8e93k5IWQFhNibS6CaYJYt6DLbtKIxAIOf2UZdU8XdXA00uDII
         Ru0AGw6hRH8rlTY5DsCSga5rTjhG9bD59Yu/KiCo7pyBBC+YIiFfRk0rC7n5a2yJCjKC
         AHAvZHQoJRescpJLNvpiJHv1pMryIXf2h4OAfnzOor/UlanPsUArRepltLLqBAhfQwnc
         bnFA==
X-Gm-Message-State: AA6/9RkPts1pPPZM5j+fLsp+G9X6aHVTPs7XyuR4cX1eYgt2WW2D2ud6TG58KD6hzXTsiA==
X-Received: by 10.28.47.87 with SMTP id v84mr4368314wmv.50.1475004819971;
        Tue, 27 Sep 2016 12:33:39 -0700 (PDT)
Received: from [192.168.1.26] (dbw202.neoplus.adsl.tpnet.pl. [83.23.48.202])
        by smtp.googlemail.com with ESMTPSA id e187sm4687665wma.21.2016.09.27.12.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 12:33:38 -0700 (PDT)
Subject: Re: [PATCH v8 06/11] pkt-line: add packet_write_gently()
To:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-7-larsxschneider@gmail.com>
 <55c5a86e-4055-f36d-bbf1-e8bae919088a@gmail.com>
 <4CF26590-7B88-4DB6-B6D4-A6CFE0FD6ABF@gmail.com>
 <20160927083939.par2ea5nqjrtkkjs@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5e6a95a5-e744-1e9d-05c6-3700c595af36@gmail.com>
Date:   Tue, 27 Sep 2016 21:33:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160927083939.par2ea5nqjrtkkjs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.09.2016 o 10:39, Jeff King pisze:
> On Mon, Sep 26, 2016 at 09:21:10PM +0200, Lars Schneider wrote:
> 
>> On 25 Sep 2016, at 13:26, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>>> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> ...
>>>>
>>>> +static int packet_write_gently(const int fd_out, const char *buf, size_t size)
>>>
>>> I'm not sure what naming convention the rest of Git uses, but isn't
>>> it more like '*data' rather than '*buf' here?
>>
>> pkt-line seems to use 'buf' or 'buffer' for everything else.
> 
> I do not think we have definite rules, but I would generally expect to
> see "data" as an opaque thing (e.g., passing "void *data" to callbacks).
> "buf" or "buffer" makes sense here, but I don't think it really matters
> that much either way.

True.

>>>> +	static char packet_write_buffer[LARGE_PACKET_MAX];
>>>
>>> I think there should be warning (as a comment before function
>>> declaration, or before function definition), that packet_write_gently()
>>> is not thread-safe (nor reentrant, but the latter does not matter here,
>>> I think).
>>>
>>> Thread-safe vs reentrant: http://stackoverflow.com/a/33445858/46058
>>>
>>> This is not something terribly important; I guess git code has tons
>>> of functions not marked as thread-unsafe...
>>
>> I agree that the function is not thread-safe. However, I can't find 
>> an example in the Git source that marks a function as not thread-safe.
>> Unless is it explicitly stated in the coding guidelines I would prefer
>> not to start way to mark functions.

There is *one* example: "fill_textconv is not remotely thread-safe;"
comment in grep.c, but not in diff.{c,h} where it is declared/defined.

Also, it is static function; we should know if it is thread-safe
or not.

I am thinking about supporting streaming in the future, and perhaps
also running different filter drivers (for different files) in parallel.
I guess that using "static __thread char packet_write_buffer[...]"
is out of question (still not reentrant)?

> 
> I'd agree. A large number of functions in git are not reentrant, and I
> would not want to give the impression that those missing a warning are
> safe to use.

The fact tha git code is undercommented and underdocumented does not
mean that we should not add comments and documentation.

> 
>>>> +	if (size > sizeof(packet_write_buffer) - 4) {
>>>
>>> First, wouldn't the following be more readable:
>>>
>>>  +	if (size + 4 > LARGE_PACKET_MAX) {
>>
>> Peff suggested that here:
>> http://public-inbox.org/git/20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net/
> 
> There is a good reason to do size checks as a subtraction from a known
> quantity: you can be sure that you are not introducing an overflow
> (e.g., Jakub's suggestion does the wrong thing when "size" is within 4
> bytes of its maximum value). That's unlikely in this case, but then so
> is the size exceeding LARGE_PACKET_MAX in the first place (arguably this
> should be a die("BUG"), because it is the caller's responsibility to
> split their packets.

Right.  I should train myself to watch for overflows.

-- 
Jakub Narębski

