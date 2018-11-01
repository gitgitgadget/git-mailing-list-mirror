Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7518C1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeKAVfH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:35:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39292 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeKAVfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:35:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id e4so12112252qkh.6
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AMy/ApTqkFtnBc4P5ZLDtLeaKVHBDrx6EqP6VsqzJII=;
        b=FTftSjIQ2pcrRPKpqf5EyxirsHKi0dtOuAbtI879uP4kg0LfFx8jUbk8wpn6ROu+P1
         w+EdW7oFWK0dUJW+fa7j0Iv4yzucGTULbk03iF6ezzqLr+z9dgJHRJ7OO5sxricz6rW2
         GK+S6+tzL3PqEBvjv63rLJEY8XqCGeGO3ExEzB9ll/rK4qdVFTwdHEYAMHf66PojPvOC
         O+5dmYA5fQ5VNJPMHtaFoum/29rFH6xkcZzKuWFBYl27kmczC1ygL1/rgA4z2kQ6YdfK
         s6wC/iB+C0iTw/jQFZSUH6Nz7ONK7192GvMIQAaX5N60MbFLbmFY3YI+22s58526p0Id
         oAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AMy/ApTqkFtnBc4P5ZLDtLeaKVHBDrx6EqP6VsqzJII=;
        b=G+dq5lzq+DX4WxNFJHA9oNLOpVB6MbOAjv5HnHpDUUdMbaalNoWbeSyGxtbXu8u3iX
         mrff+MgwFcsfU8/UVOKIDOkmXRmL9v/D1cuqEPlUR5t/2wh3tK34VIxe+1HAdF52eX5F
         UsfKvuH4fBuP5qehJ8AdFm3+ocDlhpi8NVQRP+6flrOPKI+Tp0jbcG7P8FQysNYQm3Dd
         BsxzIDhGDfg5GySP4VZnsUfDxFZ+Wgo0UExWmM+Al/pFXQn1zojsh4aTnxvJp7QKKYxj
         QiAbhx9dFjUEk+ZNgIiv9SfCg04QCL29+xO0N14BDgGEpMijiCton+rgYdRmG+R40jR0
         aByg==
X-Gm-Message-State: AGRZ1gK+p1blYWU5MIVbzmoMC2Ruc5HepaFNKXH2J6bEjAVRMU3DhlNl
        DvxMdbRpc2vvfzOxwFn+ziQ=
X-Google-Smtp-Source: AJdET5cSE/cEaU2x7E6YkBP29yk6dqLtgeanjm9XlJuY+EsldcLLp/fxzDLAvWDlutCxsreiUd0/7A==
X-Received: by 2002:ae9:c21a:: with SMTP id j26-v6mr6080697qkg.52.1541075539201;
        Thu, 01 Nov 2018 05:32:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id k38sm9201624qkh.72.2018.11.01.05.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:32:18 -0700 (PDT)
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com>
 <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com>
Date:   Thu, 1 Nov 2018 08:32:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2018 2:52 AM, Elijah Newren wrote:
> On Wed, Oct 31, 2018 at 5:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 10/31/2018 2:04 AM, Elijah Newren wrote:
>>>
>>> On the original repo where the topic was brought up, with commit-graph
>>> NOT turned on and using origin/master, I see:
>>>
>>> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
>>> To /home/newren/repo-mirror
>>>   * [new branch]       test5 -> test5
>>>
>>> real 1m20.081s
>>> user 1m19.688s
>>> sys 0m0.292s
>>>
>>> Merging this series in, I now get:
>>>
>>> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
>>> To /home/newren/repo-mirror
>>>   * [new branch]       test5 -> test5
>>>
>>> real 0m2.857s
>>> user 0m2.580s
>>> sys 0m0.328s
>>>
>>> which provides a very nice speedup.
>>>
>>> Oddly enough, if I _also_ do the following:
>>> $ git config core.commitgraph true
>>> $ git config gc.writecommitgraph true
>>> $ git gc
>>>
>>> then my timing actually slows down just slightly:
>>> $ time git push --follow-tags --dry-run /home/newren/repo-mirror
>>> To /home/newren/repo-mirror
>>>   * [new branch]          test5 -> test5
>>>
>>> real 0m3.027s
>>> user 0m2.696s
>>> sys 0m0.400s
>> So you say that the commit-graph is off in the 2.8s case, but not here
>> in the 3.1s case? I would expect _at minimum_ that the cost of parsing
>> commits would have a speedup in the commit-graph case.  There may be
>> something else going on here, since you are timing a `push` event that
>> is doing more than the current walk.
>>
>>> (run-to-run variation seems pretty consistent, < .1s variation, so
>>> this difference is just enough to notice.)  I wouldn't be that
>>> surprised if that means there's some really old tags with very small
>>> generation numbers, meaning it's not gaining anything in this special
>>> case from the commit-graph, but it does pay the cost of loading the
>>> commit-graph.
>> While you have this test environment, do you mind applying the diff
>> below and re-running the tests? It will output a count for how many
>> commits are walked by the algorithm. This should help us determine if
>> this is another case where generation numbers are worse than commit-date,
>> or if there is something else going on. Thanks!
> I can do that, but wouldn't you want a similar patch for the old
> get_merge_bases_many() in order to compare?  Does an absolute number
> help by itself?
> It's going to have to be tomorrow, though; not enough time tonight.

No rush. I'd just like to understand how removing the commit-graph file
can make the new algorithm faster. Putting a similar count in the old
algorithm would involve giving a count for every call to
in_merge_bases_many(), which would be very noisy.

Thanks!
-Stolee
