Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AABB1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJQU6b (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:58:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43414 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQU6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:58:30 -0400
Received: by mail-ua1-f66.google.com with SMTP id c89so4706623uac.10
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=B6rQ3CM/rQhQ3VqVgjhXLqGYwoSRhHooadW3EEyxowA=;
        b=WHT7509jpD8UtagBFtsi8QbP61w1UljZhiVNClidhLc8Uc/QO3x5MzCu339cC00i+s
         5pRcJQL9mM6VLKUBuZygAEDwrwgZ7T8WALRQfkJeeTJJlMQJNetV2HW3ffm7x6Z9WnUa
         5y9TEEQtjUiEoL1plklrKN1ABFVuuNxMQwwxLv2wL0lNT+aOlgv/0fdbp06HARb3izPt
         5QETUdTc+dN6awmSX2u1q8Ax9E50sV4rug2NExLalGY1HS9GruhGECh6tSqhmGPp21hk
         f8dBB8LDlKsQmr1Jvydb/0I85zWC4EFA6S8hcAla4MTtd+ClsUXQIuYnp5ff/WxCq7wn
         sYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B6rQ3CM/rQhQ3VqVgjhXLqGYwoSRhHooadW3EEyxowA=;
        b=n+W38BYklOs4slwP2EVGghqcl7C2IARd9hhPuthSkcJpVd706u8m29y2qq+ZggQhXt
         hLIc1SAoW8dQ+v7V2ybbT4YS/Y9YtzO2x7lpRVXgdag0Ucy/WD+/Kb4/usxkMccrtPZ6
         gxKYmyQQaRlAYHbNcAsgEIDto0fHX0nwLse6hT3q+PbvP9O5Mv2LPr9DN+gXK0nFUOfA
         8605+o1OWSyBOl/N2rnl4FKcwspb/pOuWvGHEu5LrpKEpCyXskx4nb+4sIDpiNVLlG9H
         x/wIRo8HvxHBWP6uMUtl6oV+flVJnLEVVQi7TzOUF9DR4QMh/ziv4D9cp6SRaeX9dIoN
         7cgA==
X-Gm-Message-State: ABuFfogiun2QuT87wDXqA0/Y0vs9n3TTp118NcyzMv5XShn4GcKgX2Yq
        I6ltvDRWEE6+t2KJZ3eptc1QkeiV
X-Google-Smtp-Source: ACcGV61O+ruxK18c0mFvLqdbLNd/riIFGPloeQQAsZZRkrxJsIxvR5lhJsM0id0iZTIJXJRlDjkzOQ==
X-Received: by 2002:ab0:24a:: with SMTP id 68-v6mr11377349uas.25.1539781373444;
        Wed, 17 Oct 2018 06:02:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8586:348a:8c9:d17b? ([2001:4898:8010:0:6ebc:348a:8c9:d17b])
        by smtp.gmail.com with ESMTPSA id y205sm2372546vsc.6.2018.10.17.06.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:02:52 -0700 (PDT)
Subject: Re: [PATCH] test-tool: show tool list on error
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20181017092506.GA15503@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b8791c01-05be-20aa-f4e9-40eaa547f1c8@gmail.com>
Date:   Wed, 17 Oct 2018 09:02:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017092506.GA15503@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 5:25 AM, Jeff King wrote:
> Before we switched to one big test-tool binary, if you
> forgot the name of a tool, you could use tab-completion in
> the shell to get a hint. But these days, all you get is:
>
>    $ t/helper/test-tool approxidate
>    fatal: There is no test named 'approxidate'
>
> and you're stuck reading the source code to find it. Let's
> print a list of the available tools in this case.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not really user-facing, but this bugged me enough earlier to write the
> patch. ;)
>
> Some of the individual tools have nice help, too (try
> "t/helper/test-tool date", which shows the approxidate command I was
> looking for), but some of them could probably stand to improve their
> friendliness (try "t/helper/test-tool config"). I think it's fine for
> people to improve them over time if and when they get annoyed.
This will improve contributors' lives! Thanks.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
