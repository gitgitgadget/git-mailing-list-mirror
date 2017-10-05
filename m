Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD58B1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdJEVWG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:22:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:50616 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdJEVWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:22:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id f15so28057307qtf.7
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mLccnxyhPAMWT0/hrv9gNiYVajIC8jQMJqKXkLx1Z1c=;
        b=bLkwE7e0+O5hdV0J2jLIETEscjxQvPi/fsi6DacneNNQGZZ8+pDkyo9mWaW2Nru7Ck
         qOoVjerjAOWThPFsK7IwEWjY5JyXa2kFlEU7laZdcZXcc0MYQU1cVGjufY/MwKas/t03
         UhqsPZmD7/xtvDsVBNXOWgv2bBWl9NwK3XmvxZtmLLoO+tWXZjYPKXTtGfSfNQ4fvP+Y
         Hl38TU9FLpP07ECQLpy5h4cqpm/skLZlU4faKILoVgPLTei8aCIvJqi4/TClVQkr7xZd
         6G95dGTnbg9bSUtknlvaqdCbRqBpYJ7Ue5ePpuRw5U8utzgVGWIR1HReMi6AOWstxnCE
         Ygvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mLccnxyhPAMWT0/hrv9gNiYVajIC8jQMJqKXkLx1Z1c=;
        b=colfp2F2U360lu3s6+evj3ed34e739NTmaKBpdyLSjdyNl2FxI2N/SUZuLsw3Lat1s
         BWI7eTYYU5n0wuC4P3KdbsbC1HMDgT6kWWzXsh3u4gW/2JUjen5sh5J7SnmSFB42eCq5
         ZlZLI7yxlql+H/vEy1Bg4NSB7X53K6gktM3J8IIwYM6jiblyHbmr+D2/MoxooQhaj8z1
         5K2G+LQ5nOIO/vErIpGwkCE+55yigo+uZFJWghAGdfxt4pHqnKKMTqpeIevG/yss6Ayq
         tet8h3l/WwNWR4plCp/9ZSm9LYB5vIGziF8rQ4IbnaFuDZQKy6OKq7EuxSAfi+uaVdZv
         aOHw==
X-Gm-Message-State: AMCzsaVl8dKJd7xOcEoaK8A6qfkerZw6tkfolz61Nwmg+zhjeOlbqqoi
        X73T33s3oaSZf+24a5tt9MQ=
X-Google-Smtp-Source: AOwi7QBgcdl17HLWilIrhWVzLxu31rPKLjfH8YXr+s/0gSD0NHiPzsaZMwR9erbN7Mf+ubsrOhc9sA==
X-Received: by 10.237.39.219 with SMTP id m27mr64570qtg.34.1507238524263;
        Thu, 05 Oct 2017 14:22:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:48e9:83dd:e402:bbfc? ([2001:4898:8010:1::67a])
        by smtp.gmail.com with ESMTPSA id k2sm12192517qth.39.2017.10.05.14.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2017 14:22:03 -0700 (PDT)
Subject: Re: [PATCH 0/6] Teach Status options around showing ignored files
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        bmwill@google.com, sbeller@google.com,
        Jameson Miller <jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171005211643.GC88769@aiede.mtv.corp.google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <21c31e97-a550-1573-52c1-4c21584341bc@gmail.com>
Date:   Thu, 5 Oct 2017 17:22:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171005211643.GC88769@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/05/2017 05:16 PM, Jonathan Nieder wrote:
> Hi,
>
> jameson.miller81@gmail.com wrote:
>
>> This patch series is the second part of [1], which was split into 2
>> parts. The first part, added an optimization in the directory listing
>> logic to not scan the contents of ignored directories and was merged
>> to master with commit 5aaa7fd3. This patch series includes the second
>> part to expose additional arguments to the --ignored option on the
>> status command.
> Thanks.
>
>> This patch series teaches the status command more options to control
>> which ignored files are reported independently of the which untracked
> [...]
>> Our application (Visual Studio) has a specific set of requirements
>> about how it wants untracked / ignored files reported by git status.
> [...]
>> The reason for controlling these behaviors separately is that there
>> can be a significant performance impact to scanning the contents of
> [....]
>> As a more concrete example, on Windows, Visual Studio creates a bin/
>> and obj/ directory inside of the project where it writes all .obj and
> [...]
>
> I see this information is also in patch 1/6.  That's a very good
> thing, since that makes performance numbers involved more concrete
> about which patch brings them about and it becomes part of permanent
> history that way --- thanks.
>
> But it took me a while to notice, and before then, I was trying to
> read through the cover letter to get an overview of which patches I am
> supposed to look at.  For next time, could the cover letter say
> something like "See patches 1 and 2 for more details about the
> motivation" instead of repeating the commit message content?  That
> would save reviewers some time.
Will do - thank you for the feedback!
>
> Thanks,
> Jonathan

