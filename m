Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FB41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 08:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJKPla (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:41:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:41:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so8579168wra.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hAnCKzBbEgaYQUTTAXDkyNjgQeauCA1yUW1hyGroaNo=;
        b=Cswzvn2/lR0yfA6gbzqHhyJrFD1BUXgr9oXf3vCi5OGnVOpLLSfCEW3ajjWnIJQ1bm
         yk5arwIZTSxSNpGaAIyR5WTuDnq7/Jcss4zHDlmpSVUuc6n1JocwVS+TINxpiFHfBSGB
         IO8Sltl4l3mrhWffyTnhONJFzBlB6xHCxP6E6v0+L0asnLos30E96qgsT0V7VRYPrdQA
         NcEI2zRuhiG2QiP2dbzmr6tuEj7Y5vF2zA4zbxwC5rRCqniLBZ4IyiJrKxmE1UpavvoT
         O2kZPRBwI5pitaCxpH2TSF7bLv/ZN+3cKEKAYvlqt2kCinXRxaieXpdL3T7Qf6M20GId
         kEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hAnCKzBbEgaYQUTTAXDkyNjgQeauCA1yUW1hyGroaNo=;
        b=OaGqWL4OPgTXoWWXulD2tPtHd0rirnQkYtBXo9EJmqxACrzEWcGL63+KcVMldVoTVI
         Y6pMqU5qDHM32YPGA9cDCLzXAMCpHrRaYXy2EbuFz9GY6ZRfE2TYy8VeBbaLKCY2xHFM
         uVZ4nXP3TqhsUzN7GdhXH2bcO7Eo+T6ilmvomNuCnw3SdBpPpHp3lPTpbIgT2PstUbxV
         9Yr/VapuyM9kAUYALHx0AgTfyAmrjl56VBQbAFzJpzBPlIPxccbBP8E1vJGRb+V7pZYu
         iHmsRSX14YUIdjTg38jFCLz64xE7TmLxiMzxmS1zyW/iKDlxbpLRsP80BjmHpD1U6QX+
         qGvA==
X-Gm-Message-State: ABuFfohuRHCwlP7K7bQEQV6tpNDewEiJk9Ec0vxpnIHowEbBRz5XCyeH
        +in1QpUpT1Fer4LneS0kh/o=
X-Google-Smtp-Source: ACcGV62qOjDEg0zoIGVKyw+e51n6Ghpg3wOXWISzNPDTkCGwPBr+ikcPlKTwosXbmBf90QR2DEp5ew==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr589145wre.274.1539245717923;
        Thu, 11 Oct 2018 01:15:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 2-v6sm19079946wro.96.2018.10.11.01.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:15:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] rebase -i: clarify what happens on a failed `exec`
References: <pull.43.git.gitgitgadget@gmail.com>
        <pull.43.v2.git.gitgitgadget@gmail.com>
        <2eefdb4874d36f14aac79b24c0f6216911f2143e.1539161632.git.gitgitgadget@gmail.com>
        <CAPig+cRMOOqGdiCqprUqiSXCa5SZDRy-kJSvdRmwY_uvynwoXQ@mail.gmail.com>
Date:   Thu, 11 Oct 2018 17:15:16 +0900
In-Reply-To: <CAPig+cRMOOqGdiCqprUqiSXCa5SZDRy-kJSvdRmwY_uvynwoXQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 10 Oct 2018 05:46:04 -0400")
Message-ID: <xmqqva68gaqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 10, 2018 at 4:54 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> We had not documented previously what happens when an `exec` command in
>> an interactive rebase fails. Now we do.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> @@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
>>  --exec <cmd>::
>>         Append "exec <cmd>" after each line creating a commit in the
>>         final history. <cmd> will be interpreted as one or more shell
>> -       commands.
>> +       commands. Anz command that fails will interrupt the rebase,
>> +       withe exit code 1.
>
> s/Anz/Any/
> s/withe/with/

Heh, I know I am not good at spelling, either, but hopefully I am a
bit more careful than leaving as many typoes as I have added lines
in my patch X-<.  After all, it's not a race to send in patches as
quickly as possible.

Queued.  Thanks, both.
