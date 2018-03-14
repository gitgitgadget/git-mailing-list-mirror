Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840851F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeCNRCu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:02:50 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:47020 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeCNRCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:02:24 -0400
Received: by mail-qk0-f175.google.com with SMTP id o184so4198150qkd.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=tZKNI3CwZKMe6Ejdf3zcXjGYwv0wX/gWIn0TeUuZGVk=;
        b=uFlHFNoAhm/zJ0+xToDAHTOdxc/UGyy5ZJOOsSASkWMFINE5Jc3Sa/UoHWmovoY0Vk
         OEcAA/cbkXnEfj8HAdFFMM4wK/SXAs1sL9Iwipvi16OkGvX6x74dCuJ4h7ReKiYE+e5N
         /DdG0bJyH13HcARhbseLHIsT+C2oOdxmRs+CVt5Dj0hEzjI/OEOfc6OHQB7tFw5aVDw5
         m9wS/Fxk4+r7SrjNkYZgnZ//JTh/yfGZbzCXj3r2XjB2hTMScrobHILveHCRHogkcOJQ
         VFZDOxKJn7cOVTA+w0S31BZrHS1hWnblpSOxTjuf0vDHkqJIoBkphcAmTwSurIgkWRtm
         iaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tZKNI3CwZKMe6Ejdf3zcXjGYwv0wX/gWIn0TeUuZGVk=;
        b=YuU0Ip1mOhX3MwWmaMT4fOHK45bAWUIG8v8DLNhhCKqt2Z4AceGuqvYWCl5WB49H2S
         xSZogwGZyaKON9NNkl5pApKHjc9teTiDTIyuFGFtw8ZjDQYO345gnMHLOHijVXF8L6m7
         JUDMm5fcW9hLlI6qaKWAtjzTN35susT6hdVUHZ/SGfDaSC1caUykOkzxtEdIzIrAhYXF
         7DQUN1Pc5FJohE3scrq6/ooltyWWvU9D25I74tCdgO7cYqnvOlxN9No32AJOdS6hMpUD
         M6lhVnQAELb3uRKiz15Cok39o3ZtYuFnLG94SssHlsC6p7gBfUv3zmE40wiv/JDxe0cy
         NgSA==
X-Gm-Message-State: AElRT7HsdhKyLq5zRMR0zjz7H0RY+XTfujGTu00+u95jp+mxWovJD1ed
        e0DnRVPZ0Y/XC/DmA8QHgr4oY5wv
X-Google-Smtp-Source: AG47ELvGO8IVC/bl8AolAYQ1/CGuCGBJgEck/Vl59NdYSM/rk6izqdN0b701/0fXpRvGVXf5vxrcuQ==
X-Received: by 10.55.36.132 with SMTP id k4mr7707306qkk.68.1521046943228;
        Wed, 14 Mar 2018 10:02:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o18sm2409615qto.8.2018.03.14.10.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 10:02:22 -0700 (PDT)
Subject: Re: How to debug a "git merge"?
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddde09e9-0524-23f8-3585-ac00c2ec7f45@gmail.com>
Date:   Wed, 14 Mar 2018 13:02:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2018 12:56 PM, Lars Schneider wrote:
> Hi,
>
> I am investigating a Git merge (a86dd40fe) in which an older version of
> a file won over the newer version. I try to understand why this is the
> case. I can reproduce the merge with the following commands:
> $ git checkout -b test a02fa3303
> $ GIT_MERGE_VERBOSITY=5 git merge --verbose c1b82995c
>
> The merge actually generates a merge conflict but not for my
> problematic file. The common ancestor of the two parents (merge base)
> is b91161554.
>
> The merge graph is not pretty (the committers don't have a clean
> branching scheme) but I cannot spot a problem between the merge commit
> and the common ancestor:
> $ git log --graph --oneline a86dd40fe

Have you tried `git log --graph --oneline --simplify-merges -- path` to 
see what changes and merges involved the file? I find that view to be 
very helpful (while the default history simplification can hide things). 
In particular, if there was a change that was reverted in one side and 
not another, we could find out.

You could also use the "A...B" to check your two commits for merging, 
and maybe add "--boundary".

>
> Can you give me a hint how to debug this merge further? How can I
> understand why Git picked a certain version of a file in a merge?
>
> I am using Git 2.16.2 on Linux.
>
> Thanks,
> Lars

