Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4DDC1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 13:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeHXRYc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 13:24:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38233 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeHXRYb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 13:24:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so10177242qtk.5
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z2F32psoPIe9Ek01BsZbp98lTyt2+V8hVOp2SIEU3nU=;
        b=nyzko8NdBQiJoJUVq5XYw8If3z3YyT6Cp4NgXRChn5lSJf5czGFJo0WorCLj84vCtc
         r1Vw/QpoCyVRl1os4WjOh04UcwiHcGzRkqYBEWdfApDJ4odmQ1razQcLK9uyvxGchJV8
         XVN9oTMul9Pc2AiNcA1se+UroyMSPqmxCGXMTDQElvryiVg8BV9kJyYj34oOy1mVjrrZ
         uf+E1rS41moWzmSznSZM6swjmFavcZ48BAVyVehIuiNx6s1BaLMRhen77PJ2dUzNo+Lu
         PeBo/PkBTfx9mislcT+eHeUR8nPKK57R8CtQsENFS/HmuIsBX8GrBFIwqjU9cWTkc7AP
         Jxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z2F32psoPIe9Ek01BsZbp98lTyt2+V8hVOp2SIEU3nU=;
        b=XU3wtSgESv/ahlCOaTCyNYRDscJ/6v4FnjAJPp8ofCqt/cuQvyh8tv6MH1E3dd9BtU
         maZ+x5JpSLc6npO3Ke/QPCeVMjHzEks0s2TuLOCB3AJhChsJuYNAHEm6+zBwnVjgLl3X
         8tOfR9Skfd06h3rUMJq3eHQ7qzUjyHNecWnsF56hT7HWM/TjZsVuIA17+CwPtGFtMeQg
         7d42GkBDbJQVyypooa+0mWwEN6P3CZcm0rJcihDEsAKzsuFE5VcU4O43JoPq/9CKDnPb
         gnbIcgP/+8+o+OZ7tkmGWzpsZoC0p0wg6fPw63epHyVFL/sOvvKkf+JjAMlE5PkXQnh0
         TznA==
X-Gm-Message-State: APzg51BSwDSKZtjq3Rd4sZTO7mC2VU+n66EjV8LV/bKHKjl8xJ/NA/OC
        WzfSWZxvbgdvh0rELiWIpsk=
X-Google-Smtp-Source: ANB0Vdbh/7HO+Ly1suAde/9DkKTRWnHzN+xIsZYOT+HqIRn9qlXZLiQB6Bx051qViyY1mVKO8TgHyw==
X-Received: by 2002:aed:3d05:: with SMTP id g5-v6mr1778241qtf.247.1535118585612;
        Fri, 24 Aug 2018 06:49:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7cdf:e697:e8f8:d87a? ([2001:4898:8010:0:6615:e697:e8f8:d87a])
        by smtp.gmail.com with ESMTPSA id z13-v6sm5416999qtz.4.2018.08.24.06.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:49:44 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] tests: fix and add lint for non-portable grep
 --file
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180823152502.3886-2-avarab@gmail.com>
 <20180823203604.5564-6-avarab@gmail.com>
 <xmqq6000izil.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1dc8c6a-1f42-b92f-8544-9593b6bd298f@gmail.com>
Date:   Fri, 24 Aug 2018 09:49:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq6000izil.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2018 4:44 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> The --file option to grep isn't in POSIX[1], but -f is[1]. Let's check
>> for that in the future, and fix the portability regression in
>> f237c8b6fe ("commit-graph: implement git-commit-graph write",
>> 2018-04-02) that broke e.g. AIX.
>>
>> 1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
> Thanks.

Yes, thanks! I'll keep this in mind for the future.

>>   t/check-non-portable-shell.pl | 1 +
>>   t/t5318-commit-graph.sh       | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
>> index 75f38298d7..b45bdac688 100755
>> --- a/t/check-non-portable-shell.pl
>> +++ b/t/check-non-portable-shell.pl
>> @@ -43,6 +43,7 @@ sub err {
>>   	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
>>   	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
>>   	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
>> +	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
>>   	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
>>   	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
>>   		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 3c1ffad491..0c500f7ca2 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -134,7 +134,7 @@ test_expect_success 'Add one more commit' '
>>   	git branch commits/8 &&
>>   	ls $objdir/pack | grep idx >existing-idx &&
>>   	git repack &&
>> -	ls $objdir/pack| grep idx | grep -v --file=existing-idx >new-idx
>> +	ls $objdir/pack| grep idx | grep -v -f existing-idx >new-idx
>>   '
>>   
>>   # Current graph structure:
