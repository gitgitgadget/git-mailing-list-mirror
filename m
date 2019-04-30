Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6611F453
	for <e@80x24.org>; Tue, 30 Apr 2019 08:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD3IzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 04:55:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3Iy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 04:54:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so20027424wre.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dm/t1R7jUpFIJWV87RPKwozCRgwbYekuaEyDSW0UiHw=;
        b=aUq3dA9bfA27WK0rHWXJRhj/GJXGQoZzner0Hmbtek+qknFZOwxFsLry18IAn5HxRz
         OtPT0jGEh4YK8viVGyhR96J7r62Se4As8XtcanKtp51u6ipyxFShU08DptTDtsV4chgo
         B+DXBXYPLjS2VC11P7TIaSJzt2+eYCt5qhCKum9o9KUsc/IMqK7FElEqmLbNqIScXpT7
         BgTrXrgpkbUcjzjAGN4/7jzPAtsvUHJmiIKyPq3Xq60OxzwcUhkkwrJA+twuVPwu/nSr
         QYSq7TRQJ2Y1GwVB5k4oS43z6q5IaOrPYzW9wiWSy2bv0l6IwLSuED8GdtA7xXpKrEUU
         uZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dm/t1R7jUpFIJWV87RPKwozCRgwbYekuaEyDSW0UiHw=;
        b=tvoC7zlnKJcnEB7ojKRqyeeNSWgpGRGPaAFsNdjhktXqH4MU9L7bVbioqX+TEklThE
         cwgmRkJ3wuZ6qIRJo1S0tfHR+Uao199BRKf8MKwWooILGpBG1QAnYgad69c2RmVkhSFV
         8IZOt8EPL/IxVR4JnpCKxFRlAOBTfryHHmc3Xo92AywMqUJpvCX64Utd6wZw5SGLzMUq
         vHW/aAVM0ZhVvrkiZSkb0udlAUPXm+i+Zvat5svxe7cLg6O0f+yJ+mjTFQ3HKrhzxwzc
         ElLK9/ft4Dp2qEycL88UsdMPBvGFWFhZiia9zyhKiE75LTnzy0lC0I4suDwR/ia+bvm2
         q3GA==
X-Gm-Message-State: APjAAAW3tVFLLXdpy3L4Dk8h5iEgg+f90UTteJyc3vipqmQ01EWhAYH6
        URr+RqTDUnOAwMdL4ZbkRzk=
X-Google-Smtp-Source: APXvYqxiLLehAdXtSTsSBdPFQv+mQd6tj97VZF4yF/0mnS1CkPCf+YDtOsfJrqFW6zN4sIyhIlP5JA==
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr27155677wrv.319.1556614498134;
        Tue, 30 Apr 2019 01:54:58 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id g28sm8984028wrb.50.2019.04.30.01.54.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 01:54:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a3d5dd8c-12a6-a1d8-a41f-ef75c15df024@gmail.com>
Date:   Tue, 30 Apr 2019 09:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 29/04/2019 17:07, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 26 Apr 2019, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When `rebase -r` finishes it removes any refs under refs/rewritten
>> that it has created. However if the rebase is aborted these refs are
>> not removed. This can cause problems for future rebases. For example I
>> recently wanted to merge a updated version of a topic branch into an
>> integration branch so ran `rebase -ir` and removed the picks and label
>> for the topic branch from the todo list so that
>>      merge -C <old-merge> topic
>> would pick up the new version of topic. Unfortunately
>> refs/rewritten/topic already existed from a previous rebase that had
>> been aborted so the rebase just used the old topic, not the new one.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> Makes a ton of sense, and I feel a bit embarrassed that I forgot about
> that item on my TODO list. The patch looks obviously correct!

Thanks, after I sent it I realized that --quit should probably clear 
refs/rewritten as well, so I'll re-roll with that added. (One could 
argue that a user might want them after quitting the rebase but there is 
no way to clean them up safely once we've deleted the state files and I 
suspect most users would be suprised if they were left laying around)

Best Wishes

Phillip

> 
> Thanks,
> Dscho
> 
