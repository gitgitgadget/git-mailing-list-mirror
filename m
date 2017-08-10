Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED2C208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbdHJT50 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:57:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38504 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdHJT5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:57:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id h75so1521928pfh.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FQjgIfmKlZYmf+K+kgsL7Mvjn7MCu1aCdFQGUUek1qc=;
        b=LUqeUlSne7MhffEAtN3texnhNlWIfXO7X7cGjfCfoQZX5uPFjXukKvozLGKo+IxB5r
         ZHzB3qPMlYlTfxL/R+cq8P4VJCOT8s7EJmuQKgYkTKbInlPvSGdOtAR1t48waQXNb2sf
         q8QtMgwmPtN8Nbnzsdw0gNIzPwWil+HOGqZviI6aa26IVY13eeb8xTy+OmANhour+sIw
         QDCSasBar4K4kEXgdHVqM/Ff/nb7+HLli/ddjZj8o9oT365e6CwYbkYUQFHKDASjANYu
         3acdoSnBIXIqQhUqtnBjEMj4MCPxMiuDEICKEg9VuAi8zjIdUXt9uUo6jMQ+ORk0NAkD
         /p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FQjgIfmKlZYmf+K+kgsL7Mvjn7MCu1aCdFQGUUek1qc=;
        b=Z1i56AhfkRStcrldLnWBSyw2oB9OzXFNqnNMGBpTnj7fv7ixlkUGP5yyMCnU5q3OHW
         XL/fEPQunMxBxoY1QY0WdG0IgVy3xQ1lYEhZnHDDNLMuTjawWVxzdYWbS0/Si6NwsTUy
         NvFod5m3vM77FN+R3fVlBBncsYiy6RmLzUoBay8mcCHbAAu83Ou87mBQSUw+VJbJ/akM
         PQ+nIEfEoRJbwLoR8tbHcZiYN4fl10at1RJaCt1hEbhGhwcx6CR0w93BA4PH9usx81+L
         IMvU8Z37h60wnTY8t9aUXQuZtE0UbgvqDll5O3bTUcOGwu9cQV1JJzNP0uDrbh30y02Q
         O06Q==
X-Gm-Message-State: AHYfb5jBbJq7Sh/vQfIhZomGeCqSFXb8qnb8gEwnSBPcQr78ngHd08j5
        r4FdHvXCA6LDIg==
X-Received: by 10.84.236.11 with SMTP id q11mr14560279plk.401.1502395045392;
        Thu, 10 Aug 2017 12:57:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:29:1004:2c52:f00a:8c85:ce9b? ([2001:4898:80e8::54f])
        by smtp.gmail.com with ESMTPSA id f64sm12530196pfb.83.2017.08.10.12.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 12:57:24 -0700 (PDT)
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
To:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
References: <20170810184723.12424-1-kewillf@microsoft.com>
 <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
 <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net>
From:   Kevin Willford <kcwillford@gmail.com>
Message-ID: <e71f1aab-d93a-2774-4378-8431bd33e146@gmail.com>
Date:   Thu, 10 Aug 2017 15:57:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810190349.jxlp6i7c6q5hpari@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/2017 3:03 PM, Jeff King wrote:
> On Thu, Aug 10, 2017 at 11:58:34AM -0700, Stefan Beller wrote:
>
>> On Thu, Aug 10, 2017 at 11:47 AM, Kevin Willford <kcwillford@gmail.com> wrote:
>>> String formatting can be a performance issue when there are
>>> hundreds of thousands of trees.
>> When changing this for the sake of performance, could you give
>> an example (which kind of repository you need for this to become
>> a bottleneck? I presume the large Windows repo? Or can I
>> reproduce it with a small repo such as linux.git or even git.git?)
>> and some numbers how this improves the performance?
> I was about to say the same thing. Normally I don't mind a small
> optimization without numbers if the result is obviously an improvement.
>
> But in this case the result is a lot less readable, and it's not
> entirely clear to me that it would always be an improvement (we now
> always run 3 strbuf calls instead of one, and have to check the length
> for each one).
>
> What I'm wondering specifically is if vsnprintf() on Kevin's platform
> (which I'll assume is Windows) is slow, and we would do better to
> replace it with a faster compat/ routine.
>
> -Peff

The strbuf_add call is essentially only having to do a memcpy whereas
the strbuf_addf will have to parse the string, determine the types,
convert the data, and then get it in the buffer.  That could be made
faster with a better compat/ routine but I fear still far from
the length check and memcpy.

void strbuf_add(struct strbuf *sb, const void *data, size_t len)
{
	strbuf_grow(sb, len);
	memcpy(sb->buf + sb->len, data, len);
	strbuf_setlen(sb, sb->len + len);
}

Here are some of the performance numbers from the windows repo.
I will work on writing a perf test for this change so that we
have a better idea on smaller repo what the impact of this change
is on them.

              | w/o     | with fix |
-----------------------------------
git checkout | 36.08 s | 33.34 s  |
-----------------------------------
git checkout | 32.54 s | 28.26 s  |
-----------------------------------
git checkout | 44.10 s | 38.13 s  |
-----------------------------------
git merge    | 32.90 s | 30.56 s  |
-----------------------------------
git rebase   | 46.14 s | 42.18 s  |



