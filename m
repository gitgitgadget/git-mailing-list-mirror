Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0071F404
	for <e@80x24.org>; Thu, 19 Apr 2018 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDSTyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 15:54:40 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:42597 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeDSTyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 15:54:40 -0400
Received: by mail-qk0-f182.google.com with SMTP id j10so6600554qke.9
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AT1jqBQnN3bs4CVDlNBcu/ZahIRJfGAXLzRoKiH/aIY=;
        b=sv8pJiqznmFZKnW/doDG/G7W9xpHoCLhyc4yXEB5DiYthKDGvmSANv2N5UEJ4USU1E
         jdeFkmJVVUU4vMkTnuTcQ8lQkaRwUJXaV0RFpS7JhHC+wrsae4soQgsWCx1GRF0Iec1s
         l/uZ3W3tW4lZcPZ+UiD2Cou+dIZrq6AOijza/Qtxc/QbUYbX1GhyxBSkG6wLbszINRSG
         TeWjxKyS1tG58Magj1OxKPkONpI1HtRov5iDkR32Rd4RF0aO1PrYUWvI9HQ2YiLaox11
         y9ZFHTC3S3JYpwgLdpu/9FZhDqoFN+IybRcaXPYYNiSakZahF+UyNQoYncx3e3ZY1HCs
         s3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AT1jqBQnN3bs4CVDlNBcu/ZahIRJfGAXLzRoKiH/aIY=;
        b=oxOjzO3zrBJCINkF46oplvdc0ZaStBqH+2iYapy5m5rcSXZahFwM1Sg2pohufk0AWW
         H4EKF2Q4lPa1iLodF8jr1giEKwqkSUH16DpUI4YMRN+hngL+kgjdIPATH8riQSsAhVdu
         K6eFD+jApgRo5s9ynH0Jg3NROzMv1I9D3fom+3lg6Rj9zTN9SRMcYCzY5JaGuGTaZiod
         Mdcol6OquAGTuCuv+hxlfyPaLSFrbdZGCYzCF+mqDAacd//v6ob9iDGrnW5dk9njHhJN
         iZ4liJ4O+v2DxEZLnBG2thY1aIyQcYYm79V+rhbbM51tNvPUR/8X+NbXMvGYjyQpBSv1
         jMUw==
X-Gm-Message-State: ALQs6tCKifpepno0YjmnBAMfyfzSkevupuOu7ZudJCkh9/BOJrFdY4FO
        i4SbXDC4o1LakT5e5ChZ8/FouXY/
X-Google-Smtp-Source: AB8JxZryzRU3q2GrV4XO5c0d+pALIxOQwsoZzvT82tUNycVJbZfO0wsJJwyhKfNi3vrr4M/qrL91nw==
X-Received: by 10.55.31.132 with SMTP id n4mr7163982qkh.375.1524167679275;
        Thu, 19 Apr 2018 12:54:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 18sm3370103qkg.70.2018.04.19.12.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Apr 2018 12:54:37 -0700 (PDT)
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
 <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
 <CAGZ79kat76NhYW1wbV+4=CaYdZ6ESMtBeUJuyi6yvRF2vJjFRQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6f6e57cb-c48c-7e5d-d8da-0d0b0b336971@gmail.com>
Date:   Thu, 19 Apr 2018 15:54:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kat76NhYW1wbV+4=CaYdZ6ESMtBeUJuyi6yvRF2vJjFRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/19/2018 2:41 PM, Stefan Beller wrote:
> On Thu, Apr 19, 2018 at 11:35 AM, Elijah Newren <newren@gmail.com> wrote:
>> On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
>>> This series is a reboot of the directory rename detection series that was
>>> merged to master and then reverted due to the final patch having a buggy
>>> can-skip-update check, as noted at
>>>    https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>>> This series based on top of master.
>> ...and merges cleanly to next but apparently has some minor conflicts
>> with both ds/lazy-load-trees and ps/test-chmtime-get from pu.
>>
>> What's the preferred way to resolve this?  Rebase and resubmit my
>> series on pu, or something else?
> If you were to base it off of pu, this series would depend on all other
> series that pu contains. This is bad for the progress of this series.
> (If it were to be merged to next, all other series would automatically
> merge to next as well)
>
> If the conflicts are minor, then Junio resolves them; if you want to be
> nice, pick your merge point as
>
>      git checkout origin/master
>      git merge ds/lazy-load-trees
>      git merge ps/test-chmtime-get
>      git tag my-anchor
>
> and put the series on top of that anchor.
>
> If you do this, you'd want to be reasonably sure that
> those two series are not in too much flux.

I believe ds/lazy-load-trees is queued for 'next'. I'm not surprised 
that there are some conflicts here. Any reference to the 'tree' member 
of a commit should be replaced with 'get_commit_tree(c)', or 
'get_commit_tree_oid(c)' if you only care about the tree's object id.

I think Stefan's suggestion is the best approach to get the right 
conflicts out of the way.

Thanks,
-Stolee
