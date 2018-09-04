Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57BA61F404
	for <e@80x24.org>; Tue,  4 Sep 2018 17:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIDVi6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:38:58 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37598 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDVi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:38:58 -0400
Received: by mail-qt0-f176.google.com with SMTP id n6-v6so4844192qtl.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jIYEZl+tvNrZX0AZ/yYixjIq6pwtDjjV2sFuFhas71k=;
        b=R3s5SM4L4+ZGgv9dyvZv4QmHn/4t8438qrI/0DlKCzH0juoT64C90+nLFh2DMyKj6q
         W05mqzrsUqaFTbMPQpIlLi4IIJYhx86pLUDjJY+jFqWfNDyGEy70H4AOMIPG+27Uzl7K
         dK0JgX2A5R5GtfcN0wVFZzwrl8LWeHhzzO239whymMcsI14tWDRohFpzmpIpCY0anfew
         wttuEYKRjaQbZd0KUoNlH6mUMrvVRg21h/aZpxxfFyxuNrd8p+ZCjPd8dpIkEz28ngeU
         +mU+cg3w0GBea3GpX61vBVVXYiU/L0a4f52vr6jwZ9+m2/2FXRoVWX0jKVDIGvltEW2g
         FSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jIYEZl+tvNrZX0AZ/yYixjIq6pwtDjjV2sFuFhas71k=;
        b=ZFOE7OqYjHaqnDvDgH6T/cgnZNC/xghsIWchhlTjyB9cadh9vH2yBdftnodfj8dyqk
         a8B4bN/bi8sUpFQ9FCeUJQTkvG0ScSyPvMr/pgZXfRhn/h+S8po0ra4U26mUoOWpWoxX
         A47EFLmE2Kt7lX5b7RiBS/fKUSLAxgIQGYblIsuKpxdCBf0exgr4FwFkdOHa6FmZ2cSR
         Xg9/wQJE0phQ98PxVU0BKY3xwdF5uhRyzUT3W9CY4J0wi+5P3OIWpATJtkZ7LJK0TfEb
         GFMDao7E5ICjVaC6pOPJhSkBoC55X5Qtw2KOdCu/3cUoGPUnVR+XR2KopKMe6j5z211X
         SWvg==
X-Gm-Message-State: APzg51CyzFBN88dWmdJk8MRjQLQWyscF2Jo2BifKBDJlB44EHvBExxdn
        Xcb+IKVj7AYkMc7puGVDSko=
X-Google-Smtp-Source: ANB0VdYDKfdW+/Faa/7/17GFbtpHXUB7x3obaIMJxjFhr/jOiBSjt/RkXidIuYlGXNRG8UPJNs/LiA==
X-Received: by 2002:a0c:81e7:: with SMTP id 36-v6mr30120601qve.53.1536081176309;
        Tue, 04 Sep 2018 10:12:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:846:acea:77a8:94b8? ([2001:4898:8010:0:f17b:acea:77a8:94b8])
        by smtp.gmail.com with ESMTPSA id n189-v6sm12655782qkn.2.2018.09.04.10.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 10:12:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test
 coverage
To:     Duy Nguyen <pclouds@gmail.com>, gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.26.git.gitgitgadget@gmail.com>
 <pull.26.v2.git.gitgitgadget@gmail.com>
 <CACsJy8DRzhnxJHXr+zRpBX+rfGPakgbVHYWRDb-XiatFsstfpg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <faebdf82-7e9b-b662-2884-1398d90ab26c@gmail.com>
Date:   Tue, 4 Sep 2018 13:12:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DRzhnxJHXr+zRpBX+rfGPakgbVHYWRDb-XiatFsstfpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2018 12:49 PM, Duy Nguyen wrote:
> On Wed, Aug 29, 2018 at 2:49 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The commit-graph (and multi-pack-index) features are optional data
>> structures that can make Git operations faster. Since they are optional, we
>> do not enable them in most Git tests. The commit-graph is tested in
>> t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
>> one script cannot cover the data shapes present in the rest of the test
>> suite.
>>
>> This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
>> . Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
>> with every git commit command. Thanks, Duy, for pointing out this direction
>> [1].
> Any reason to not add this new flag in ci/run-build-and-tests.sh
> (which is used by Travis)? I see your note about VSTS but I don't see
> why it has to be exclusive to VSTS.

I only wanted to volunteer resources that I know are available. I am 
looking into an additional test run in Travis CI builds, but didn't want 
to presume the extra resources would be available.

