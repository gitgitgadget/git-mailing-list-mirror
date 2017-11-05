Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A4520450
	for <e@80x24.org>; Sun,  5 Nov 2017 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdKEJlX (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 04:41:23 -0500
Received: from mail.aegee.org ([144.76.142.78]:60114 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdKEJlU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 04:41:20 -0500
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org vA59hBY4002555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1509874992; i=dkim+MSA-tls@aegee.org; r=y;
        bh=3A4v3t0J1tPWBCGXbNOPM1KEPNKUvbNd9p35A3tWU4k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZD0Z3w3xxC6EAxCyJvLwvrkvQmEQbvfRppOpitrRVWtEcFPpTpySd23K/oIkVeioN
         ZT1+7EaOoNKhExyRHZXTE+xaXgKAsmg9cMA/CqGiNryX/sSXnz5WqQEqmZ30jkqG18
         E6AQf28qFX5P19HPjTbG91bqKOnm+Y1fheFcsxZBLhcbjCWR0S58e/K6870ZZQvuZp
         eRvjwpUBRunemuHXbfAmuwmsc0+jjN4x3DDv1h8hRuuj0AliMG+lSahNvwozu7s+uK
         R3XsN6vwisOG9d8Gu2JXrj+/ZpYk1JuAyjPNnx4JOxbnSgFHZF5bEnJ9qLSNHf3A7K
         r8pHdJ77c8AoxVIg4Yj74X2hswzdXN++IRLPJ807wyU6lOqROXjbGkw/QU6A+PT/Aw
         iX0im+x2VZIsxZfOjlZcRxkz5n0iEqZW7zq2yQcdQFtZlZsHnlRdRaNN0i2dywxoXD
         rozUynOzvyRk8Co83b05pgRI9bSCEMk7p/nkZbtbUEU5azKnv/lud1xDUfYNUE6vYQ
         7txoiOthgw6FMiKRu7wlltwEWgeYoNvh38UGNKzXPQWBaolzw17dOQpDCB9s/0i5+f
         SyEXtk6XYJHy8uyFnYk/qHzIhziEJ8squY2jvYOcjsCYfNh0l0vwd75UuyuYW923bN
         cZPEtASjE5G7RwIzG/GvVWoA=
Authentication-Results: mail.aegee.org/vA59hBY4002555; dkim=none
Received: from [192.168.178.46] (x5f74eb27.dyn.telefonica.de [95.116.235.39])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id vA59hBY4002555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Nov 2017 09:43:12 GMT
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
 <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net>
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Message-ID: <4e2bc579-429f-9927-4502-5929e5235740@aegee.org>
Date:   Sun, 5 Nov 2017 10:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

thanks for your answer.

I understand that the PCRE's stack can get exhausted for some files, but 
in such cases, git grep shall proceed with the other files, and print at 
the end/stderr for which files the pattern was not applied.  Such 
behaviour would be more usefull than the current one.

Regards
   Dilian

On 11/05/2017 03:16 AM, Jeff King wrote:
> On Sun, Nov 05, 2017 at 01:06:21AM +0100, Дилян Палаузов wrote:
> 
>> with git 2.14.3 linked with libpcre.so.1.2.9 when I do:
>>    git clone https://github.com/django/django
>>    cd django
>>    git grep -P "if.*([^\s])+\s+and\s+\1"
>> django/contrib/admin/static/admin/js/vendor/select2/select2.full.min.js
>> the output is:
>>    fatal: pcre_exec failed with error code -8
> 
> Code -8 is PCRE_ERROR_MATCHLIMIT. And "man pcreapi" has this to say:
> 
>    The match_limit field provides a means of preventing PCRE from
>    using up a vast amount of resources when running patterns that
>    are not going to match, but which have a very large number of
>    possibilities in their search trees. The classic example is a
>    pattern that uses nested unlimited repeats.
> 
>    Internally, pcre_exec() uses a function called match(), which
>    it calls repeatedly (sometimes recursively). The limit set by
>    match_limit is imposed on the number of times this function is
>    called during a match, which has the effect of limiting the
>    amount of backtracking that can take place. For patterns that
>    are not anchored, the count restarts from zero for each posi‐
>    tion in the subject string.
> 
>    When pcre_exec() is called with a pattern that was successfully
>    studied with a JIT option, the way that the matching is exe‐
>    cuted is entirely different. However, there is still the pos‐
>    sibility of runaway matching that goes on for a very long time,
>    and so the match_limit value is also used in this case (but in
>    a different way) to limit how long the matching can continue.
> 
>    The default value for the limit can be set when PCRE is built;
>    the default default is 10 million, which handles all but the
>    most extreme cases. You can override the default by suppling
>    pcre_exec() with a pcre_extra block in which match_limit is
>    set, and PCRE_EXTRA_MATCH_LIMIT is set in the flags field. If
>    the limit is exceeded, pcre_exec() returns PCRE_ERROR_MATCH‐
>    LIMIT.
> 
> So your pattern is just really expensive and is running afoul of pcre's
> backtracking limits (and it's not helped by the fact that the file is
> basically one giant line).
> 
> There's no way to ask Git to specify a larger match_limit to pcre, but
> you might be able to construct your pattern in a way that involves less
> backtracking. It looks like you're trying to find things like "if foo
> and foo"?
> 
> Should the captured term actually be "([^\s]+)" (with the "+" on the
> _inside_ of the capture? Or maybe I'm just misunderstanding your goal.
> 
> -Peff
> 
