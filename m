Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E26F1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJRVAb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 17:00:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44064 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJRVAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 17:00:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id i30so4598219uae.11
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7euw3zPphyJ9wVxXPW0wt5xvnvEDtVh23nEExXqM7FA=;
        b=Z9xD0yc2M0p8TfrnUsuG61AyBYkX5I1a62TLt+r6T1Kos5jepKYJt9sVzrRYU2EMMb
         eimAySpgRMeGH4HmMmWjc5WyuMfGc18rjM8EBo5a2OBm+JtodtewtD/+l+fEXPrsvun2
         nI1M0iZ1O0SYBXB8wjpM7pvCswu/2PErS0T51mKc4bWr71MUwXJflBJxxr2zcUws6Sz3
         8F+KtdKLTP3wDWbk8mXgrUwj1LEm7+n/49DZ8HDNsRIhwCZRpnhsCYy+kfsdGuGWEPbZ
         z36f0rY9qTogQnXo4LCJYl1Psg4VDD00M722ig6nfGWGL4gpixkrBGykXGB4Id1l6rLZ
         JLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7euw3zPphyJ9wVxXPW0wt5xvnvEDtVh23nEExXqM7FA=;
        b=mgh5RaaqOCOG0TsjPunCrjZVPWzPfTcE0U/pKE8ubGLSmA3o4+g41Rf0Yg6K2Xnuw1
         ef5xaYkT15TMq1FCut8fgLbp0AhI3B3RAI3vz1lDJmRrIn45VhfvfRhtruW5zFtDsaCP
         Tpdn5gzR2aub8DATmuS7iO4d5l/pBvpJ5/uByKM2kmXsScYWDMFOhT/bT4lJbkTR9E/Y
         36Yf2Qeey3WnCj7rjuEsziDRtQnZ6EHP5nuiO5TUqC8GnMd3rfx0fKCHmpwX1Pklf9uM
         zv0dN75iuOPaiPSat6WWN0+3b3I3CoU2Qf2hs+H5zJ765Cah5CYAR/FhgS41xEzGn3Ip
         NSQA==
X-Gm-Message-State: ABuFfoibtz6CmCW8BxucBjzvkSiviOV0p3lKTBc8LV4hY5Jo5UgP9lOp
        0Zro+PU0r4hyiDMP1sY0Ey4=
X-Google-Smtp-Source: ACcGV61H+3ep0u/k4QIGWx+M5U08vYznvbyPxr42KKfxVWWrycgFekJNKEjjkqhZn/gEFNmtFlydXg==
X-Received: by 2002:ab0:5e8f:: with SMTP id y15mr12729245uag.21.1539867574802;
        Thu, 18 Oct 2018 05:59:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c079:83d:1a9:9f46? ([2001:4898:8010:0:a9af:83d:1a9:9f46])
        by smtp.gmail.com with ESMTPSA id 126sm4318944vku.32.2018.10.18.05.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 05:59:34 -0700 (PDT)
Subject: Re: [PATCH 1/3] t6501: use --quiet when testing gc stderr
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.50.git.gitgitgadget@gmail.com>
 <ab118e60e9988076edf43d0ed8c1924e6569a9d0.1539808389.git.gitgitgadget@gmail.com>
 <xmqq1s8nvndm.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <90d051a5-8c02-518d-01a7-16746061e6b9@gmail.com>
Date:   Thu, 18 Oct 2018 08:59:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <xmqq1s8nvndm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/18/2018 1:23 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The test script t6501-freshen-objects.sh has some tests that care
>> if 'git gc' has any output to stderr. This is intended to say that
>> no warnings occurred related to broken links. However, when we
>> have operations that output progress (like writing the commit-graph)
>> this causes the test to fail.
> I see that the descriptor #2 is redirected into a regular file.  Why
> should we be writing the progress indicator in that case in the
> first place?  Shoudln't we be doing the usual "are we showing this
> to an interactive terminal?" test?

This code from builtin/gc.c makes it look like we are doing that:

         if (gc_write_commit_graph)
                 write_commit_graph_reachable(get_object_directory(), 0,
                                              !quiet && !daemonized);

But really, daemonized is only for when running in the background.

Do you have an example of a builtin that checks this interactive 
terminal behavior?

Thanks,
-Stolee
