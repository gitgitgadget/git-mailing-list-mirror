Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B230A1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 21:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdLSVuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 16:50:35 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44293 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdLSVue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 16:50:34 -0500
Received: by mail-io0-f194.google.com with SMTP id w127so15151821iow.11
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sb50HumzOrr/zhFHjYu+0Quaqx9P6v2sjJ4SHoAxKgE=;
        b=XpUu3uQxB+GWhAk7x8CKONHD4XuhP3oW2jJr66UhPOx7IWM9Aua58Q4ZkI1Q4KfSjv
         6+uHz2dG2OlgngAHhnI0BvynyCExGG1U+3GGrllcZFxLaRBCoKuOFsHRzwGHNkHyjZbA
         zsnchyihA0HE8xmtOIZTGLkmUah0tMsmOms5ITukV15G4zdpVDoOn/gpeH7Zz0Q4Goew
         RjpLxO2t3IJwaotJejG/vT8hFxiklXmb4mUXBXfqfrIMWUgItnzOBIF4iv20eZWAPUcl
         A3OfecyXfvFWHVsljNuWfO9Nrw02L8+E6NaP8qZhV3TYFMNnn9xnIekym0oEKXBwPI5e
         h7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sb50HumzOrr/zhFHjYu+0Quaqx9P6v2sjJ4SHoAxKgE=;
        b=bH4PJz4IAWAaZK8Fe0zRl/rToLePirEmgr632KN4hEVZCFp1cFEUVxSJQOhE35FF/y
         W7146SKRcfrEuK98dne2A5K+Sx5pWY+18+aULp/16xH8Cw/LubC2n2FQWLeWycbmL8EQ
         2CdBsTugcq/tdnN47BKxb3/J9WVlSg70Pk8CzXXaeXKDfrO2DtZ7Ug3dC/UZMy3aSLbr
         C4P5Omjh1J+HQklIQBII4SwI7gNdljFh10FzOFAEqmwq6bk/WuvrvqzhlWELYgdllMHr
         vBqd0pBPIdq2tUjdyChCidCaJR7QM7IM+Hx97FuCxnSdHNTXEQQZxVN/VaV30l5ZFQV7
         S8mQ==
X-Gm-Message-State: AKGB3mIEK6G2Lvwa18og4cHwOWqwO8e3jCQQew6ZtMj/uxO6s1CikX4R
        a7mqgoLgwUyGwqDXt1vLyLY=
X-Google-Smtp-Source: ACJfBosSkvADT/pV9IQc9W2HYdMI3jLimTaSf4NT9AoOJOXJ9zzz+yqhpNq3WkfmsXoezFgBONXUKw==
X-Received: by 10.107.132.24 with SMTP id g24mr5824936iod.151.1513720233806;
        Tue, 19 Dec 2017 13:50:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f13sm8173939ioh.70.2017.12.19.13.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 13:50:33 -0800 (PST)
Date:   Tue, 19 Dec 2017 13:50:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wei Shuyu <wsy@dogben.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: support CURLPROXY_HTTPS
Message-ID: <20171219215031.GE240141@aiede.mtv.corp.google.com>
References: <20171219172401.5263-1-wsy@dogben.com>
 <20171219205807.GC240141@aiede.mtv.corp.google.com>
 <xmqq7etiv1n5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7etiv1n5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Wei Shuyu wrote:

>>> diff --git a/http.c b/http.c
>>> index 215bebef1..32d33261c 100644
>>> --- a/http.c
>>> +++ b/http.c
>>> @@ -865,6 +865,11 @@ static CURL *get_curl_handle(void)
>>>  		else if (starts_with(curl_http_proxy, "socks"))
>>>  			curl_easy_setopt(result,
>>>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
>>> +#endif
>>> +#if LIBCURL_VERSION_NUM >= 0x073400
>>
>> Can this use #ifdef CURLPROXY_HTTPS instead?  That way, if someone's
>> copy of curl has backported support then they get the benefit of this
>> change as well.
>
> It sounds like a worthwhile thing to do (assuming that these are
> always implemented as preprocessor macros).

Oh, good point!  It's an enumerator, not a preprocessor macro.  But
there is a preprocessor macro CURL_VERSION_HTTPS_PROXY.

Anyway, using LIBCURL_VERSION_NUM is consistent with the surrounding
code.

Thanks,
Jonathan
