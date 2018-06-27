Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AD21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965542AbeF0SYN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:24:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33986 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964840AbeF0SYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:24:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id d23-v6so2528117qtp.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K8VRJxU0TCD6FuxDRDpDXUx8FmPwed6p3/fi/I4Edf0=;
        b=YoebqsaKHm0OCl0EmsheFeIWx71i7AA5p/a4KWp8NR1yGdS+AGiJGMlGFPeDk/xslZ
         VV2fHyMXzjCnWPRdayJVKKLIiioFl2VM98F7d21L7ErL7H2YJuYSjZpQOb8RBmatS2jY
         D+Lakv/4iidvmMfpHDSLiUSPDnbYrtyeknywh4cKkb9aLlqjKhT2CF93OXKJA4TglRni
         jIwD/94+I8e+y/7NupS01QqbrpalJ3TV41jkZXZtdAjljTMvTxpBFJor94sakAwrrqaH
         v9nzP7yuCs+9XOqJPPa5Cu3rQ19DB/HTGnY0q+W3QON1MeUYwfv5zwelJ0saomgWUxPu
         O5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K8VRJxU0TCD6FuxDRDpDXUx8FmPwed6p3/fi/I4Edf0=;
        b=Q+3WOVew1Ne8BQvQgWqWeJm0qAOYRjnIyxCu0CwEDO9AkTnM546/2ObexdJFAp7O2s
         tI9mHvUF7NmjYz88y+gt7/LZGXQJ5Jrl6/IcqcjLDGcvA7B8LpSelZHnmk96WH5L7F8d
         gBwvkL28NbGTh1qiFI9fhmfRGMrGTY6dW5RyjhjeZu/yzUdbn8vH1+Eyd+IesOQTeSet
         +GB6/exa7blVtcSYSMF9LAXiAu90ADAR29TPDpEu/Sb43wCT/Dp0o3A7piWyorE08CI0
         uLf9uk/NOcKtJZnfrgwusl8vAODkMtKu3XJl2pwqeb1MCuPYZsXMZPTIhiJbOAfZXYb1
         Mo+w==
X-Gm-Message-State: APt69E3BFRGvcsWQlS8vQl3gyeV76iwJ2I4pe5tOO89WvQk0yz+Juxe+
        B0XVq6HayKjrpw+V+v8Rtz4=
X-Google-Smtp-Source: AAOMgpfz1fgSv85Zc+bio01lbcgFoNLWId5buYBqUQ5ArACcOCO4sq76l6Xsmu82voRljH9sjMIpsg==
X-Received: by 2002:aed:2a82:: with SMTP id t2-v6mr6528034qtd.203.1530123851544;
        Wed, 27 Jun 2018 11:24:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:85f4:e33:9587:4612? ([2001:4898:8010:0:6f2a:e33:9587:4612])
        by smtp.gmail.com with ESMTPSA id m128-v6sm3019187qkd.33.2018.06.27.11.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 11:24:10 -0700 (PDT)
Subject: Re: [PATCH v7 21/22] gc: automatically write commit-graph files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
 <20180627132447.142473-22-dstolee@microsoft.com>
 <xmqqr2ksf6ed.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ac29eb4-6df7-02a2-e34b-e8622dc0a012@gmail.com>
Date:   Wed, 27 Jun 2018 14:24:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2ksf6ed.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2018 2:09 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> @@ -40,6 +41,7 @@ static int aggressive_depth = 50;
>>   static int aggressive_window = 250;
>>   static int gc_auto_threshold = 6700;
>>   static int gc_auto_pack_limit = 50;
>> +static int gc_write_commit_graph = 0;
> Please avoid unnecessary (and undesirable) explicit initialization
> to 0.  Instead, let BSS to handle it by leaving " = 0" out.
>
>> +test_expect_success 'check that gc computes commit-graph' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git commit --allow-empty -m "blank" &&
>> +	git commit-graph write --reachable &&
>> +	cp $objdir/info/commit-graph commit-graph-before-gc &&
>> +	git reset --hard HEAD~1 &&
>> +	git config gc.writeCommitGraph true &&
>> +	git gc &&
>> +	cp $objdir/info/commit-graph commit-graph-after-gc &&
>> +	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
> The set of commits in the commit graph will chanbe by discarding the
> (old) tip commit, so the fact that the contents of the file changed
> across gc proves that "commit-graph write" was triggered during gc.
>
> Come to think of it, do we promise to end-users (in docs etc.) that
> commit-graph covers *ONLY* commits reachable from refs and HEAD?  I
> am wondering what should happen if "git gc" here does not prune the
> reflog for HEAD---wouldn't we want to reuse the properties of the
> commit we are discarding when it comes back (e.g. you push, then
> reset back, and the next pull makes it reappear in your repository)?

Today I learned that 'gc' keeps some of the reflog around. That makes 
sense, but I wouldn't optimize the commit-graph file for this scenario.

> I guess what I am really questioning is if it is sensible to define
> "--reachable" as "starting at all refs", unlike the usual connectivity
> rules "gc" uses, especially when this is run from inside "gc".

It is sensible to me, especially because we only lose performance if we 
visit those other commits that are still in the object database. By 
writing the commit-graph on 'gc' and not during 'fetch', we are already 
assuming the commit-graph will usually be behind the set of commits that 
the user cares about, by design.

An alternate view on the decision will need help answering from others 
who know more than me: In fetch negotiation, does the client report 
commits in the reflog as 'have's or do they get re-downloaded on a 
resulting 'git pull'?

>
>> +	git commit-graph write --reachable &&
>> +	test_cmp commit-graph-after-gc $objdir/info/commit-graph
> This says that running "commit-graph write" twice without changing
> the topology MUST yield byte-for-byte identical commit-graph file.
>
> Is that a reasonable requirement on the future implementation?  I am
> wondering if there will arise a situation where you need to store
> records in "some" fixed order but two records compare "the same" and
> tie-breaking them to give stable sort is expensive, or something
> like that, which would benefit if you leave an escape hatch to allow
> two logically identical graphs expressed bitwise differently.

Since the file format allows flexibility in the order of the chunks, it 
is possible to have bitwise-different files that represent the same set 
of data. However, I would not want git to provide inconsistent output 
given the same set of commits covered by the file.

Thanks,
-Stolee
