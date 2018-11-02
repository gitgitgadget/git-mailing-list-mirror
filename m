Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68AD1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeKCERs (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:17:48 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40961 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCERr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:47 -0400
Received: by mail-yb1-f193.google.com with SMTP id t13-v6so1208380ybb.8
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QBYMqAu/zFBzLWg3Oi+DcIe258pI2DLb5uNJxzDEoog=;
        b=jn8Dxf3xLfFpbod5algBia7m/Z8hzocAUQD8xHvA0w/W4v+AZNv1cvZtxmxsubN+Uy
         fTYKQR3kPAbcnIR+Itmg7uAKNQpUflsWP3pWnpw1ZveCYm+UzbmY7CNGsGsjV7Cf4Rh9
         PoigqR+sr+uNoBEkre83ZDpDkxJRZa8LypS+eCvBeZYcgdtpkifWHX9+fr5dtUgzMSDs
         tWYb3KgcUcsxrN8UUq9bE++dbfYKHVtp+cshqeUI3Ai1m4XzCTLXJhzTiRdrtpvRW99b
         9uh14KOKImR103++S0FB+l6lElhcUxKn8lsCN+gjxNvolmDntPWZuQITchNjU9CY3YwU
         uUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QBYMqAu/zFBzLWg3Oi+DcIe258pI2DLb5uNJxzDEoog=;
        b=hmwOgMMkcgMsBLfhHBeoWrdpvuB7nBdkGs/BItQqRxgdvQYQgBEUv0hoX/ZbR4Ig0D
         fRky+jfOWKLaFrKp4zlshiokZjf+4DhoBHN4ij6zKsuwFksTog2pQxG9twNHdoL3bc1I
         zzDUxKxI4OccUTaqoulixXDI3FA1nwaCwMMyKraLGGq7JmhFyAqfxEMKeyr8RnviZzjz
         MWijOsH9H2bEmnDOXepnfpI0cjk1PT+cXx6Bjo4armXDSo9j+3RdEuX5Br1MxwFPlxQA
         P2BETuhhL09t8j0Y3wmfcMt70by1Yx5JrWB8ZxjvmV3nv2vvfk+9Rgqvn1fXK9SYLpKD
         4+jQ==
X-Gm-Message-State: AGRZ1gKRkLBzNi+YMo2BsMVbzizC56zPWOA+hHwtn4/lmEX+Rlg7idJJ
        z7zI2obYOeBnRqdkybLyOws=
X-Google-Smtp-Source: AJdET5cbLsP3C72j/U4ZFuTuhChna1TWV73I+6sX4UmnE1spnNGfpOBDv5+Sct1UY8UYPRKYeBa0zA==
X-Received: by 2002:a25:dd85:: with SMTP id u127-v6mr12408033ybg.151.1541185767117;
        Fri, 02 Nov 2018 12:09:27 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r5-v6sm13679344ywr.80.2018.11.02.12.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 12:09:26 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] Improve path collision conflict resolutions
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20181019193111.12051-1-newren@gmail.com>
 <20181102185317.31015-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <232094ce-6872-4039-06a6-af40c709cac0@gmail.com>
Date:   Fri, 2 Nov 2018 15:09:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181102185317.31015-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2018 2:53 PM, Elijah Newren wrote:
> Major question:
>    * You'll note that I edited the last two patches to mark them as RFC.
>      To be honest, I'm not sure what to do with these.  They improve code
>      coverage of new code, but the same gaps existed in the old code;
>      they only show up in the coverage-diff because I essentially moved
>      code around to a new improved function.  Since the new code doesn't
>      really add new abilities but rather just shifts the handling of
>      these conflicts to a common function, they shouldn't need any more
>      testcases than previously and modifying the existing patches thus
>      feels slightly misleading.  That line of thought leads me to believe
>      that perhaps putting them in a separate combined patch of their own
>      with a decent commit message is the right way to go.  On the other
>      hand, squashing them to the commits they're marked as fixups for
>      shows which logical part of the code the tests are related to, which
>      seems like a good thing.  So what's the right way to handle these?

I appreciate the effort you made to improve test coverage! It's 
unfortunate that this portion wasn't covered earlier, because we could 
have broken it and not noticed until a release.

I think making them separate commits is fine, and the comment on the 
test case is helpful. The fact that you only had to change the commit 
timestamps in order to get the coverage makes me reexamine the code and 
realize that maybe the "right" thing to do is to reduce our code clones. 
(This is also how I was looking at the wrong block of the patch when 
talking about it not being covered.) I'll look at the patch and see if I 
can contribute a concrete code suggestion there.

Aside: I hope that I am not being annoying by poking around with the 
test coverage reports. It does give me a way to target my review 
efforts, especially into changes that touch areas outside my expertise 
(like this one).

Thanks,

-Stolee

