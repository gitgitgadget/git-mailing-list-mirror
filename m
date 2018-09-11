Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7811F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKVNo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:13:44 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34874 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKVNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:13:43 -0400
Received: by mail-qt0-f169.google.com with SMTP id j7-v6so28855592qtp.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/0zHiRYnLCOZ2y/+dc5vJPh3qjMPogqYQg/r/Kf+c60=;
        b=ef/0eOUwPcxSVFB8R6vXPGXO3Lif9WbnVeiwGjWiSkSfpIgZjsWkWH5kejt83EGPHD
         QQmNcjfNn4IXBpC03AmBNJw5lCNF9YauQSuoDK0JetbbV3tYjKi4pUri1pQBDhAtksug
         nRoyk8UN4NMYMqchUSp0pByufRUiB26jgboB+/WwzoqVuiq/TpHPbtEAxjLlyOkpIWM4
         LpZuqnfhlkBurmJH/CFCH+WDxSmYL0DkyXK1rkgPBmz/BrfUj9pUgkRGHTOUD6KTXyfQ
         FhyxSeJDbFiUuZPJb7mTDAi7jcKd0h7fEosw+YxivOr5HsvNMxMSh+cjfZOQguPQLQq5
         5ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/0zHiRYnLCOZ2y/+dc5vJPh3qjMPogqYQg/r/Kf+c60=;
        b=ZmCCunyPkArtRJ7K8bLV/RVBlBomGsEmxYjOYETjewQyOj2pL0rk2g5m/2TESK/Nmp
         9er9BBc3RyiLvBeOM8FI5xJTMFq++o7oEqrVjE6zvmdwdOWuTPfe/Z47DYfT9F4qRQ9J
         rVIhCtaA5PWT20ZRgnTjE8GztGLtI7Eutvz4JWTqlQhS+uz6VA26c3xLqC1yfBLoM7Cm
         MQF+ocKhImyFrpHMwncrt3EK2RaZAhPCPwF2EobQ0NZ/B39aEcMoQ5DdX9Z2ew5Lr2jJ
         vKRV8Y6BYaUkUQV8l9T3kquQ0YeTncrsrW0rNhh8Wt2i18m/n/CknNO0YXl/setyTXoU
         Ye5w==
X-Gm-Message-State: APzg51Ads3yC/k8hkrswWpUjK2Aik3EweGg5BCVBNQalV1MMmwbpOoIa
        kPhLih2p0pk93RQQ+zeW0l7j3PMS
X-Google-Smtp-Source: ANB0VdZ6BPdGoUP810Fh6Eh9u9TXwWS632rtByj6jVBT91lXqbTQYNV1SwrvSSRWcuzIlDQy57C0qQ==
X-Received: by 2002:aed:2841:: with SMTP id r59-v6mr3549543qtd.6.1536682422343;
        Tue, 11 Sep 2018 09:13:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:80cf:4a5a:6920:a965? ([2001:4898:8010:0:6a05:4a5a:6920:a965])
        by smtp.gmail.com with ESMTPSA id c2-v6sm10838102qkc.20.2018.09.11.09.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:13:41 -0700 (PDT)
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
From:   Derrick Stolee <stolee@gmail.com>
To:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
Message-ID: <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
Date:   Tue, 11 Sep 2018 12:13:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 12:04 PM, Derrick Stolee wrote:
> On 9/11/2018 11:38 AM, Derrick Stolee wrote:
>> On 9/11/2018 11:25 AM, ryenus wrote:
>>> I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
>>> only got a Segmentation fault: 11
>>>
>>>      $ git version; git range-diff origin/master  HEAD@{2} HEAD
>>>      git version 2.19.0
>>>      Segmentation fault: 11
>>>
>>> Both origin/master and my local branch each got two new commits of 
>>> their own,
>>> please correct me if this is not the expected way to use git 
>>> range-diff.
>>>
>>> FYI, I've created a sample repo here:
>>> https://github.com/ryenus/range-diff-segfault/
>>
>> Hi Ryenus,
>>
>> Thanks for the report!
>>
>> I ran something similar using Git for Windows 2.19.0-rc2. I had to 
>> run `git commit --amend --no-edit` on the tip commit to make my local 
>> master disagree with origin/master. I then ran the following:
>>
>> $ git range-diff origin/master HEAD~1 HEAD
>> -:  ------- > 1:  5009c62 aaa
>>
>> With this, the command succeeded for me. There is another way to get 
>> a similar result, could you try it?
>>
>> $ git range-diff origin/master~1..origin/master HEAD~1..HEAD
>> 1:  f14d571 = 1:  5009c62 aaa
>>
>> Otherwise, we can now get started trying to repro this on a Mac. Thanks!
>
> The patch below includes a test that fails on Mac OSX with a segfault.
>
> GitGitGadget PR: https://github.com/gitgitgadget/git/pull/36
> Failed Build: 
> https://git-for-windows.visualstudio.com/git/_build/results?buildId=18616&view=logs
>
> -->8--
>
> From 3ee470d09d54b9ad7ab950f17051d625db0c8654 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Tue, 11 Sep 2018 11:42:03 -0400
> Subject: [PATCH] range-diff: attempt to create test that fails on OSX
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3206-range-diff.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 2237c7f4af..02744b07a8 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'amend and check' '
> +       git commit --amend -m "new message" &&
> +       git range-diff changed-message HEAD@{2} HEAD
> +'
> +
>  test_done
> -- 
> 2.19.0.rc2.windows.1


Sorry, nevermind. The test failed for a different reason:

2018-09-11T16:02:20.2680990Z ++ git range-diff changed-message 
'HEAD@{2}' HEAD
2018-09-11T16:02:20.2779250Z fatal: Log for 'HEAD' only has 2 entries.
2018-09-11T16:02:20.2802520Z error: could not parse log for 
'changed-message..HEAD@{2}'
2018-09-11T16:02:20.2817470Z error: last command exited with $?=255
2018-09-11T16:02:20.2832300Z not ok 12 - amend and check

Ryenus, it would help if you could create and push the following 
branches based on your local repro:

     git branch base HEAD@{2}

     git branch topic HEAD

     git push origin base topic

Also, does the following command fail, after creating the branches?

     git range-diff origin/master base topic


Thanks,

-Stolee

