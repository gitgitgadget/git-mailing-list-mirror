Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65511F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeI0A6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:58:54 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37162 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0A6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:58:54 -0400
Received: by mail-qk1-f182.google.com with SMTP id c13-v6so1527qkm.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DjaFAP7Rn43GpHN+PPVNZ9rqiQVF6eYeq+8xNn0xdkk=;
        b=i/WQFSdeB+Hvpz0jbdHt0hGRj1I6eNj4/MWyqKcL1hhTKNeh/YzFpeJwaixcqbsQPI
         NvoKBMT4BbBlOl6VhIXELEDz4ufAxNixIwdKxhZZ9kcWeaBcdQLQg6czePMNMG7cec+4
         Zh72kz/QXPwKuJtk7PLkP8Nsf4n9KZuwsHPwuVgG+hOVYHx9ZZE3u5x8ONJsKRdL1GXX
         sOH2Qpo0iQlsKfLGgGi9IL5FhS76r62u/E74893v89B45WlTAqPqUbZd/FtM0dc2y/08
         b07HWmOSUdo0JTKiLdEpLlNRw5sLadziNGDAD11r1DVF614lA3flkUKWQjw2AbV/3UCi
         cKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DjaFAP7Rn43GpHN+PPVNZ9rqiQVF6eYeq+8xNn0xdkk=;
        b=BJKYn+mfi7jqQ3oQhq1ug8xzDWz+iM2gEwUpzIId5g3IbS+PF7lZaatDhq1E0DgE0S
         y2O8ngd6gNYcawubsNBKvdDcf5TQutj1o6pv6/fUzeH/xaK49wZ9M0r94Eo+3umAJWqk
         70Orgukt2xZPHPgyp89ZM0VMuhojLT0PphcoIuyYQNZ43IVmOOlB77O3bEG2hDbIQTs1
         mv6E0cu8kC2C/TNfEmVE+6OKxzLIkH5NnSTI79iL4j9iLTIs0/uMtzNxtJyWHswXot9O
         nYBN6QtDQbcnMWd2uUa5CqPIryhGUxqzBbSHx/+mfwcRkkNfiUqkeWP3U6tCzHsDAmlB
         nyyg==
X-Gm-Message-State: ABuFfogD+5lttnwbU3tM9x9gcyo0Hl3buM1PZUj/hJS6Od+MlgB8uUzW
        JWTHSefS1YBXTFog5NCXMQXzkgfE
X-Google-Smtp-Source: ACcGV60+hCRyPEykAS6GGemSvmovhgjBHyugC2aVTWL4zZxVdIDQnoy9YkdYKY1DDqpM3JYlAPgF9Q==
X-Received: by 2002:a37:c683:: with SMTP id s3-v6mr5262769qkl.269.1537987475407;
        Wed, 26 Sep 2018 11:44:35 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51a9:99b0:a00a:e3c? ([2001:4898:8010:0:3adf:99b0:a00a:e3c])
        by smtp.gmail.com with ESMTPSA id f184-v6sm3429169qkc.23.2018.09.26.11.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:44:34 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <xmqqtvmckum8.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c805d8c5-e605-3db8-9e57-0988c635c3df@gmail.com>
Date:   Wed, 26 Sep 2018 14:44:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvmckum8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2018 1:59 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> In an effort to ensure new code is reasonably covered by the test
>> suite, we now have contrib/coverage-diff.sh to combine the gcov output
>> from 'make coverage-test ; make coverage-report' with the output from
>> 'git diff A B' to discover _new_ lines of code that are not covered.
>>
>> This report takes the output of these results after running on four
>> branches:
>>
>>          pu: 80e728fa913dc3a1165b6dec9a7afa6052a86325
>>
>>         jch: 0c10634844314ab89666ed0a1c7d36dde7ac9689
>>
>>        next: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
>>
>>      master: fe8321ec057f9231c26c29b364721568e58040f7
>>
>> master@{1}: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
>>
>> I ran the test suite on each of these branches on an Ubuntu Linux VM,
>> and I'm missing some dependencies (like apache, svn, and perforce) so
>> not all tests are run.
> Thanks.
>
>> master@{1}..master:
>>
>> builtin/remote.c
>> 5025425dfff     (   Shulhan     2018-09-13 20:18:33 +0700
>> 864)            return error(_("No such remote: '%s'"), name);
>> commit-reach.c
>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>> 559)                    continue;
>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>> 569)                    from->objects[i].item->flags |= assign_flag;
>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>> 570)                    continue;
>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>> 576)                    result = 0;
>> b67f6b26e35     (Derrick Stolee 2018-09-21 08:05:26 -0700
>> 577)                    goto cleanup;
>> cat: compat#mingw.c.gcov: No such file or directory
>> ll-merge.c
>> d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02
>> +0200       379)                    marker_size =
>> DEFAULT_CONFLICT_MARKER_SIZE;
>> remote-curl.c
>> c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700
>> 181)            options.filter = xstrdup(value);
> As I think the data presented here is very valuable, let me ignore
> the findings of this specific run (which will be fixed by individual
> authors as/if necessary), and focus on the way the data is presented
> (which will affect the ease of consumption by authors of future
> commits).
>
> These wrapped blame output lines are harder to view.  Can we have
> this in plain/text without format=flowed at least?

Perhaps removing the middle columns of data and just "<sha> <num>) 
<line>" would be easier? We could also remove tabs to save space. For 
example:

builtin/remote.c
5025425dfff  864) return error(_("No such remote: '%s'"), name);

commit-reach.c
b67f6b26e35 559) continue;
b67f6b26e35 569) from->objects[i].item->flags |= assign_flag;
b67f6b26e35 570) continue;
b67f6b26e35 576) result = 0;
b67f6b26e35 577) goto cleanup;

ll-merge.c
d64324cb60e 379) marker_size = DEFAULT_CONFLICT_MARKER_SIZE;

remote-curl.c
c3b9bc94b9b  181) options.filter = xstrdup(value);

This does still pad the data by a bit, but should be more readable. Most 
"uncovered" code will be indented at least one level.

We do lose the author information, but keen readers could identify code 
they are interested in by filename and then look up the commit by OID later.

>
> I personally do not mind a monospaced and non-wrapping website, just
> I do not mind visiting travis-ci.org for recent results from time to
> time.  Others may differ.
>
> There is an error message from "cat" in it, by the way.
Thanks! I'll add an 'if' statement when there is no gcov file. This 
happens for the compat layers that are not compiled in and for the 
t/helper directory, it seems.
>
>> preload-index.c
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       73)                     struct progress_data *pd =
>> p->progress;
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       75) pthread_mutex_lock(&pd->mutex);
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       76)                     pd->n += last_nr - nr;
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       77) display_progress(pd->progress, pd->n);
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       78) pthread_mutex_unlock(&pd->mutex);
>> ae9af12287b     (Nguyễn Thái Ngọc Duy   2018-09-15 19:56:04
>> +0200       79)                     last_nr = nr;
> I wonder how much we can save the effort that is needed to scan the
> output if we somehow coalesce these consecutive lines that are
> attributed to the same commit.

It could be possible to group consecutive lines together, but hopefully 
reducing the total data is enough, and we can keep the actual lines visible.

Thanks,

-Stolee

