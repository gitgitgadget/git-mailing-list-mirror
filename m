Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B451F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbfG2UAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:00:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45398 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390673AbfG2UAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:00:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so63151993wre.12
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtfm-co-hu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zEyiicXMUVkcGTNSj/Dwuz+gh2/KziH9sTqKIZ1QZAY=;
        b=uaIojva1ZfOcwpvYD+rwomUC10dP4OA3l0VeHcBMV5JQEbFt66ZqhHGphXEEHPVGJx
         F4RXZY6PPLKdF6rL+zZFy8lMZvPnnHVTdoSn1g5MP1gfO8NEi43G+66AyJx669l0lZyC
         w8IQhHTP2Q60Td5T2WRvWa18Nu1UjmwpRJdoITEQa6NXABPWyuCWYNZ5hA8YNVLJv1Uq
         sMSD1iVLCA95S21Pxi2yXY+ORIp8EK6DGKvIcb8MPe5fZtzMQLl7FwJtZ5gl5bzuhWDW
         4Q/l8kk5wvpsyn0a2wFkXn1hn2mXa9K2caZ5ploJbvtM9Km0OeWcX3HiFdk/HP7DWUeE
         hqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zEyiicXMUVkcGTNSj/Dwuz+gh2/KziH9sTqKIZ1QZAY=;
        b=pn6zi6VAHu6ITvIADI9V/ROz38jvhMxczw6usaktyCzlx+DO2lHShDEUXN2E+ZV/HN
         HZKVl5vZhOFZKCDmIsJ3a0Zp3Tt1J87N85QMZ3h/aOOwywszonXyR3wC20/VZUkHpi2b
         9kWawFeT/7N9qcr8Cit5f4lFyU0dMvUhBcCLtlaJrH4j38OBr8p0XfijiPHMA3F0MZe8
         k0if8OPBB8FhJQpIEiLHOWQaoVVLenDvB4Rie54M376CzNbvbj0mLeldoJaj9hc8kKVA
         r49b/ScYIQ9qgwkBXxQ72NKwwPiQ4JTGW0rvSlWwhC4gnB3fFYGwDuICNechRclaiqVp
         3zzg==
X-Gm-Message-State: APjAAAWMMHA8fnv+OAYZ2RLwxIzQvpl0V7Bz8vKW1TWZr0BMduFwaClN
        2i7Lq1R2/gjWY1rhd9N/WZgXfLCp
X-Google-Smtp-Source: APXvYqxYMy9/LN5vHzQ39WVqbidO+lwyD/OxXrvHKYNtVMxap6EuX4O5f6AFPkhVpjWFiTsqGSBTeA==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr38138079wrn.171.1564430441611;
        Mon, 29 Jul 2019 13:00:41 -0700 (PDT)
Received: from [192.168.160.67] (catv-176-63-72-133.catv.broadband.hu. [176.63.72.133])
        by smtp.gmail.com with ESMTPSA id r11sm95427809wre.14.2019.07.29.13.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:00:41 -0700 (PDT)
Subject: Re: git name-rev segfault
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <799a4ba4-a2ae-7ce3-a6e4-acd329d062da@rtfm.co.hu>
 <20190729195001.GE14943@sigill.intra.peff.net>
From:   Tamas Papp <tamas.papp@rtfm.co.hu>
Message-ID: <560b857a-808e-9ac6-ec3e-6778bb4c03e7@rtfm.co.hu>
Date:   Mon, 29 Jul 2019 22:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729195001.GE14943@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for letting me know and for the corrections too.


Cheers,

tamas


On 7/29/19 9:50 PM, Jeff King wrote:
> On Mon, Jul 29, 2019 at 04:19:47PM +0200, Tamas Papp wrote:
>
>> Generate 100k file into a repository:
>>
>> #!/bin/bash
>>
>> rm -rf .git test.file
>> git init
>> git config user.email a@b
>> git config user.name c
>>
>> time for i in {1..100000}
>> do
>>    [ $((i % 2)) -eq 1 ] && echo $i>test.file || echo 0 >test.file
>>    git add test.file
>>
>>    git commit -m "$i committed"
>>
>> done
> I lost patience kicking off two hundred thousand processes. Try this:
>
>    for i in {1..100000}
>    do
>      echo "commit HEAD"
>      echo "committer c <a@b> $i +0000"
>      echo "data <<EOF"
>      echo "$i committed"
>      echo "EOF"
>      echo
>    done | git fast-import
>
> which runs much faster. This doesn't change any files in each commit,
> but I don't think it's necessary for what you're showing (name-rev
> wouldn't ever look at the trees).
>
>> Run git on it:
>>
>> $ git name-rev a20f6989b75fa63ec6259a988e38714e1f5328a0
> Anybody who runs your script will get a different sha1 because of the
> change in timestamps. I guess this is HEAD, though. I also needed to
> have an actual tag to find. So:
>
>    git tag old-tag HEAD~99999
>    git name-rev HEAD
>
> segfaults for me.
>
>> Could you coment on it?
> This is a known issue. The algorithm used by name-rev is recursive, and
> you can run out of stack space in some deep cases. There's more
> discussion this thread:
>
>    https://public-inbox.org/git/6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu/
>
> including some patches that document the problem with an expected
> failure in our test suite. Nobody has actually rewritten the C code yet,
> though.
>
> -Peff
