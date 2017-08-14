Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA18620899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbdHNWHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:07:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36520 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdHNWHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:07:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id d40so15865584wma.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zkqNgm3BFyDU2NabIEe6OSst20JGPvgI8uG6bH4I47A=;
        b=CN70tcrmzEUSMpeOSATQ3xy2n6DhY2F0hPLR46tZNybRtQ53IM/9wY2c4EpaPshEAx
         O7RoeFIEc4JoDcbtQyjH+slHKSfPoslAsPmGQYLFX0YOFGAQT/n/5gDJj6MLR3AlIq+k
         qCedjt+uK3dEtbEBNgRJopgnETCsLEGEUfdY2nTptZ6IqBQUHLg0bnXUPcitAunBns4/
         kPFSd3WzRx+nA/TRGJ9K6/mYG8ttSdecrDGIVVTRKv/iCbu4BzoKqk3V7PCjIU9sFcEq
         zlCD2x7dNPxtRb8s/avuI6ZGgsKOmeMawSO2pAZm+G6VrCUzI3SrxjN5ubxZj0cFmTpO
         MWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkqNgm3BFyDU2NabIEe6OSst20JGPvgI8uG6bH4I47A=;
        b=RxLpmRRDrlDjPwZmvezpsPRRV/Vn86sV/X/U/GHOBGYkuRhLJMqMgpPHl9+M/c1aLk
         3zee5hUuoFozCirC0SCInL0YTS/exVwaa3l6PfdeXQIRVwW0g/fZ5GSPuWKoUl7bMC1o
         p35L08pavOYr82yPNMoAlPsuYFulDizCAvErJp+dbI3/mu0NdAmYfmtGmkwoiZ12Jwts
         hhqWRcY2VKcWrUBJ6wC9MVwdzw1rGO1q94GT7UBnGcCiULnPBhegXTnwG0argoFLNIqd
         0Sfza62T3THr7qgu4kqWBaW1nJl1vMEEe1iOXGeuaP7tsh2ImkAzsNrQANvS+GZTvLBe
         JXAg==
X-Gm-Message-State: AHYfb5j4HvekT2KgPMBO3bEmC3PTllzlD78zHfxJloVd+li/ot182Kfs
        IeYTrE3GNJJOh9xL
X-Received: by 10.28.11.131 with SMTP id 125mr219859wml.82.1502748449419;
        Mon, 14 Aug 2017 15:07:29 -0700 (PDT)
Received: from ?IPv6:2001:a61:10aa:9a01:58c4:fe9a:8665:891? ([2001:a61:10aa:9a01:58c4:fe9a:8665:891])
        by smtp.googlemail.com with ESMTPSA id v6sm589384wmd.42.2017.08.14.15.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2017 15:07:28 -0700 (PDT)
Subject: Re: [PATCH] doc: clarify "config --bool" behaviour with empty values
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20170813094816.7754-1-asheiduk@gmail.com>
 <xmqq60dqvxw1.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com>
Date:   Tue, 15 Aug 2017 00:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq60dqvxw1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.2017 um 19:53 schrieb Junio C Hamano:
> Andreas Heiduk <asheiduk@gmail.com> writes:
> 
>> `git config --bool xxx.yyy` returns `true` for `[xxx]yyy` but
>> `false` for `[xxx]yyy=` or `[xxx]yyy=""`.  This is tested in
>> t1300-repo-config.sh since 09bc098c2.
>>
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> ---
>>  Documentation/config.txt | 3 ++-
>>  Documentation/git.txt    | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index d5c9c4cab..d3261006b 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -221,7 +221,8 @@ boolean::
>>  		is taken as true.
>>  
>>         false;; Boolean false can be spelled as `no`, `off`,
>> -		`false`, or `0`.
>> +		`false`, `0`, no value (but still with `=`) or the
>> +		empty string.
> 
[...]
 
> However, I think this "no value (but still with '=')" is making it
> more confusing than necessary for two reasons.
[...]
 
> I notice that in this Values section (where the boolean:: is the
> first entry) there is no mention on how to spell a string value.

I assumed this is due to the pretext of the definition list:

	Values of many variables are treated as a simple string, but there
	are variables that take values of specific types and there are rules
	as to how to spell them.

After that I would NOT expect string values to be "specific". Also: If string 
values are explained here in the "Values" section, the line-breaking and escape 
sequences syntax should be here too.

So my (minimal) suggestion is:

       false;; Boolean false literals are `no`, `off`,
                `false`, `0` and the empty string.

I'll adapt `true` in the same style and resend a patch.
