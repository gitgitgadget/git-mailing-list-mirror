Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996A81F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIMAjh (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:39:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40385 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeIMAjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:39:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id c126-v6so1842742qkd.7
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLvbg1MQCUN39fSBAZhYC/RLHutDYSWpba2ePcT29i8=;
        b=j3LbzhT9hPqm7LKrDt9yOUw78aGvMTiEdOuCx4heIT365rT2labDtA5/PxrF6+E7P7
         Cfoes+DUMSdGcJlZBshcBZZGRClX+Z964jvoj2lrgDlmWMLHfHzPVt740XZ/m+j5VBW6
         kCimps32CmXBMRQQ2xLo5ZeASacZy1Ss8FpADMHp8SW4yKiec3odJhsDrKeRDt/eBbor
         Zb3XaLCcLcNUjJ5JBs4hsF4rpFOW1Qu8oronVbtDWLWzJZ60KDpfND7AeVLXpjsZvQtc
         fDHB/3B3paUJe41mVYRJ5e67oLyY7AiElgNfZVVcbHZoHgud5YRUTChdk4hdZm+5bK3Y
         eFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLvbg1MQCUN39fSBAZhYC/RLHutDYSWpba2ePcT29i8=;
        b=pNOkKcMqoVuQcJGygldAHFJRNfCHR2nb1pxr/9BmcIhlL6Kv4ifrbkWvhaGWBj+lir
         VWN0hTebYEid6iAIa/+aW8baRdnZemmn52cUSk1W/TJJqt2oaaf38DW1KOTT/QGPtgiD
         KjhepT9LLp7apMhoMaaLxUdYLkLk8r5TBaIgYykimWSAnFK+GbD5TW7levULNrOrVZpg
         qQ0JZt72Y3Wsoc8tFDoxSUhq/5qCmgoklsmjsEs48DAv5Hw3Xe5iKcRyptnLO9iFlmte
         wLHU11BTENUo0u4uvKiNqD+F5dlDaoLnAXBsjHqq4aap6YeI9ZPNwW+H8X25MxQkx/S5
         MJFA==
X-Gm-Message-State: APzg51C7eLCMtM1UyWpH6l5jXPAmzJ0VSOsWPAhjMGUG6rYSR9Uy7FYK
        qs/Z6J9F3vfv8fad5y4v3d4=
X-Google-Smtp-Source: ANB0VdaXl5ehdmC/n8uZncTHxFgA8+qZGjPSLEryBVcTuJQyuvJ2Cy8YVtOQGfIrOhXa0MA6pPsYdg==
X-Received: by 2002:a37:d49d:: with SMTP id s29-v6mr2696641qks.42.1536780817340;
        Wed, 12 Sep 2018 12:33:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g64-v6sm954183qkc.37.2018.09.12.12.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 12:33:36 -0700 (PDT)
Subject: Re: [PATCH 0/1] contrib: Add script to show uncovered "new" lines
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.40.git.gitgitgadget@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a99b2a7a-6674-033f-16b9-34e2fce857b6@gmail.com>
Date:   Wed, 12 Sep 2018 15:33:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <pull.40.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/12/2018 12:45 PM, Derrick Stolee via GitGitGadget wrote:
> We have coverage targets in our Makefile for using gcov to display line
> coverage based on our test suite. The way I like to do it is to run:
> 
> make coverage-test
> make coverage-report
> 

Very nice, I was unaware of the coverage test make targets.  I like the 
new report; it makes it easier to verify any new changes are actually 
tested.

>      
>   4. The lines in read-cache.c are part of a new block for the condition "if
>      (expand_name_field)" as part of an optimization. These lines should
>      probably be covered before that series is merged to 'next'. I understand
>      that Ben and Duy are continuing work in this direction [1].
>      

This code is only exercised when the index format is V4 but the default 
is version 2/3 [1].  To enable the test suite to use version 4 and test 
those code paths will require the addition of a new 
GIT_TEST_INDEX_VERSION environment variable.  I'll add that to my TODO list.

[1] https://git-scm.com/docs/git/2.1.0

