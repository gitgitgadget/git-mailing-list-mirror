Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753AB2055E
	for <e@80x24.org>; Fri,  3 Nov 2017 02:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965024AbdKCCla (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 22:41:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:53805 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964918AbdKCCl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 22:41:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id t188so1143393pfd.10
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxduuSmcG5FBrZz/YHHFInEYHVWmS+f4skSrbJ5SNkw=;
        b=SZqs7pDcU6Afp85syScJ4JYuOxiasDlBaGrsq2SmYs8inyQSk6X8YPu3XNgvLPLV4L
         +Vumj1VtMQ1AHGoIgshlw7dtViJhpGLknz7PjJyPUEC7Nznc4QY9sj6uLHEtECnj9eg3
         8xn8L88Msx17w+NtqgmYj9f9TzXzXOZLfrECrP/AsaWHiyT2z0qhWCtkRon62HuYxx8A
         AvCgruHBy9r9qYrkMeWNqhdspy+m7Yk7MjSXNiGlqZIO7MMQylizqmQA1lZ+UsUk+jGv
         jeWpIkSSBc1ctod5RrbECim+qVFdhXZVqZBSeGryoe3yYKkorgFDZMlF8yul2POtWwSb
         BSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxduuSmcG5FBrZz/YHHFInEYHVWmS+f4skSrbJ5SNkw=;
        b=b1KOaoXr+vYzz7aPVSVtwCCVwjDhscfny9PjyPT++N3czcCDAtN5PjkLMZ2N3y6yov
         IvUWjWvjdpENHGgSJAq3EG4NinvvesxNyP1TaYhUXl7fI1dkPxRL0kmAw9uZzY+XL8AG
         WoUgQln1wsBDkIGqc4mi23aX0bkKrvfJX0wcxL2EQYfnK29IkTLc47AxkOZHxjs7/kRw
         KLuBYR0ok9rXQjpP1PMsMhlkntiq+MdB/W13zKmwYVNm9oWpxUnJHmKlH+gzzTIr0nk5
         VFoAWGsANw3KhqRbd1p1d83taoJTOM91YQIJovST+uw7kvf2VY29QsRgIkKc9L3D90a4
         lKGg==
X-Gm-Message-State: AMCzsaVtyXmaESUdyiMW+6Bbyh/IspgWyGgZ7cS3ywM8yTzPI6b08DO7
        bWg8TuqWyHojVwsQOC8McfE=
X-Google-Smtp-Source: ABhQp+RtdeA1R3EZSCRsc1Ay8W3qSrRv/29q+ku7AUTs7zMIe2uU1pw9JvgDJLVYpbfuP6IP45R+Zg==
X-Received: by 10.98.204.150 with SMTP id j22mr6039895pfk.3.1509676888876;
        Thu, 02 Nov 2017 19:41:28 -0700 (PDT)
Received: from [192.168.43.71] ([117.249.180.49])
        by smtp.gmail.com with ESMTPSA id u76sm9034137pfk.181.2017.11.02.19.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 19:41:27 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
 <CAPig+cRJDiHXoz-81EMtsbFfqaZz76eo1msUQW+eBP=wUsm6JA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <59d4a08d-7165-9e56-5ddc-4f97d4a9d4d4@gmail.com>
Date:   Fri, 3 Nov 2017 08:11:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRJDiHXoz-81EMtsbFfqaZz76eo1msUQW+eBP=wUsm6JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 02 November 2017 07:51 PM, Eric Sunshine wrote:
> 
> Nicely explained; easily understood.
>

Good to hear that.


> 
> Translators can correct me, but this smells like "sentence lego"[1],
> which we'd like to avoid. Translators lack full context when presented
> with bits and pieces of a sentence like this, thus the translation may
> be of poor quality; it may even be entirely incorrect since they don't
> necessarily know how you will be composing the various pieces.
> 
> You _might_ be able to able to resolve this by dropping "and" from:
> 
>      "foo is moo, and bar is boo"
> 
> to turn the error messages into independent clauses:
> 
>      "foo is moo; bar is boo"
> > but I'm no translator, and even that may fail the lego sniff test.
> 
Though I can't be very sure that the one you suggested will pass the 
"lego sniff test", its better than the "and" I used. Further, my 
instinct says it wouldn't qualify as sentence lego (it's just a ";").


> A sure-fire way to avoid lego construction would be simply to emit
> each messages on its own line:
> 
>      fatal: branch 'tset' doesn't exist
>      fatal: branch 'master' already exists
> 
> (though, you might consider that too ugly).
>

Though it might not look that ugly, I don't know how you could make 
'git' die() twice (or am I missing something)! Of course we could use 
'error()' to report the errors and then 'die()' with a message like 
"Branch rename failed" but I find that to be a little too verbose and 
further using the connector ";" instead of "and" does seem to reduce the 
possibilities for the above program fragment to pass the "lego sniff test".

---
Kaartic
