Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D63F1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbfJNUbc (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:31:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37176 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbfJNUbc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:31:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so17122450qkd.4
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EUJw0rMXFyDk0havydenz+91Ud74id5XtyQKiqkiaW0=;
        b=TuxxDU2AiD/6wy0Hs5jF9ovVNA/AX0MSb2LOmeeyN9esQegFxphnLNkUnYkkSNYAUZ
         ZsoDFz8WYV1yFKJhb2WXTP/T0qeRx32zY52B4XzUvxho4mj1b1G4AKz13tkvQQS/US2G
         CvFgBm6pD00HdxQ6yYDZ5Yu6003BKY7sQy14rKpOd51MNu1JnOE2KSa0l2vcKEUEtH2s
         bx5xmUoTw3Db63VixuJ1QTLPgeG2qQDnmKI6kI00gdQh3gjaB7F+BFom55HDzkWLL1kT
         Z5eMUxbr4XLSWtzbl7I7zcgGR9lc5zdV2wGnlclhNIARVoSPwuEEW/7PAvYyGa567Yne
         qsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EUJw0rMXFyDk0havydenz+91Ud74id5XtyQKiqkiaW0=;
        b=akNMWZwurFShAikb43zdFfRC2y9iIoOYVhhPSdcRhKRcczM3ihEb2eUcH0sJVoIV7x
         jCKx/yQ8sMO4b2vTCYGGfzBcsfvvLfze/d5T05la95jMVtRujAAD/HfaVVBcnmbZBziW
         8yPEILqwpAOosJVTW3yNkMie7QOrFFmK4+00Qna+6+yC5wmaJuMMv2Nm2HfuE/g5j1hf
         Jk67vgd84kcSg+MZnfxZS+hoTlNh64QdlgaCcaiREKRkwoXgPaUcDFMcK9TkNXsCndu7
         VR4zowXWQ44nh+6hG5JhzPQMccHxNpypxDLK8LqTtw4C3TVp3pb471cvqUTWl/TN79LN
         hqug==
X-Gm-Message-State: APjAAAUDAiIC+xkXnazbr1BQ7Mw9SBMBOay01HbuTXtp7M3gkuE2OQKf
        VbCGlpOxasOpXwZWkVU5vAw=
X-Google-Smtp-Source: APXvYqwTvRnXTv1gcGS7nDMBK6zWqgS/X3xJiNwdpr66IwZuVR7kyG7LMs/svlblvhum8Q/d+WoYxQ==
X-Received: by 2002:a05:620a:785:: with SMTP id 5mr31960541qka.114.1571085091206;
        Mon, 14 Oct 2019 13:31:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4807:bd77:fc97:8ac8? ([2001:4898:a800:1012:f93a:bd77:fc97:8ac8])
        by smtp.gmail.com with ESMTPSA id k18sm8543636qtj.69.2019.10.14.13.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:31:30 -0700 (PDT)
Subject: Re: [PATCH v3 13/17] read-tree: show progress by default
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
 <pull.316.v3.git.gitgitgadget@gmail.com>
 <3a677f32b6b914fcc800b619fd082da25c275422.1570478905.git.gitgitgadget@gmail.com>
 <CABPp-BH0pN5noDpFH286YFHC22+SNr9ZuyJxuy=WzNPQ=cyxfg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7887efb4-60de-f6d1-6cba-5ccb60645c52@gmail.com>
Date:   Mon, 14 Oct 2019 16:31:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BH0pN5noDpFH286YFHC22+SNr9ZuyJxuy=WzNPQ=cyxfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2019 6:16 PM, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The read-tree builtin has a --verbose option that signals to show
>> progress and other data while updating the index. Update this to
>> be on by default when stderr is a terminal window.
>>
>> This will help tools like 'git sparse-checkout' to automatically
>> benefit from progress indicators when a user runs these commands.
> 
> This change seems fine, but in patch 2 you said:
> 
>> The use of running another process for 'git read-tree' is sub-
>> optimal. This will be removed in a later change.
> 
> leaving me slightly confused about the goal/plan.

True, this is not necessary for the whole series. I created this
patch as a way to show progress in our microsoft/git fork [1], then
removed the read-tree call in a later change [2]. When preparing v3,
I took all of the changes together.

I thought this was valuable on its own, for those users who are
using the old mechanisms for sparse-checkout updates.

Thanks,
-Stolee

[1] https://github.com/microsoft/git/pull/200

[2] https://github.com/microsoft/git/pull/204
