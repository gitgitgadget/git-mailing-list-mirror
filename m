Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705E11F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfGAOlE (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:41:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51779 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfGAOlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:41:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so16129629wma.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDdAD+o4iTHoano/T+wk3PaAeX6Lt/aMXJuz4pekNSU=;
        b=ZZPVR1wJgCvCd6q+TJrdxpbsj5ZllfePHL/I86I4cavXQebrlXFvYo6Pr5dUq3axE9
         2vJxLUr8B1XgV0mrNyKene15IMmPXgOROVb655a4YJ6wNnX37iC9m9JYZD3MDexkIgu9
         HdCsoFvyXld+ENA3SWz556WKdLgkE/REues/Wio7f0JRpMaXbHizKmDPD4saZObgsHw/
         uIPmqxFXKFlnUaHWRxuUm3sPp+xd3DZUqARue71puCpOk0cM+f/5vdWmuqRZZ6tJEpZb
         wmT4jXwjTEn2uFV0fhLqyEQL+FHapqYX36OlJ2ic8tGnN4uC+LnN2EJJJGRGDJmE+r/L
         WKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HDdAD+o4iTHoano/T+wk3PaAeX6Lt/aMXJuz4pekNSU=;
        b=PIt5g9qOWf817l8V5gnwrx4SdOJgzhXW2BUW1ezX8Lf3p9RpmLLUbzVJmHlRyT0mkv
         0J3tHnVwmhqatBMnsMRCIQxveltXUY8+V4F/z0gYPB+cCsohSxyF5vTyMp3umWitaZC+
         leqnnicypNts01UEQTBduqzI3v+OEhombqj9OWir0EsVU8IS4jZbrdno8Bwy1vOEA8WV
         dE2R97XaMMLqGX7ayHUA+CHhu+KUaqolEt1in9OMHkZkdnBevZqYywW807yffQWpejTH
         LQVTcR0FXpMBHo25rDIYzRoJETgoZkWyH4xi7+T+MCIN38IjyEi9xVg+ksDB9a+268tp
         MA5w==
X-Gm-Message-State: APjAAAVYa0wTJnVaZq86Ns4bMGFZWZtDeEKo9GrS3ga0W6U50EIzCpzC
        HWsz73Z3HymF2MuXASN9qxY=
X-Google-Smtp-Source: APXvYqxWsxIOgNoqGUsxcrYpvgdBgymhwyEn7Fj1XSygTPbR2oRqV1+gZ3VWkOQ9zFSZzwETr8bTcg==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr17300607wme.117.1561992060884;
        Mon, 01 Jul 2019 07:41:00 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id g5sm10364389wrp.29.2019.07.01.07.40.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:40:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] status: do not report errors in sequencer/todo
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.275.git.gitgitgadget@gmail.com>
 <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
 <xmqqo92le6ns.fsf@gitster-ct.c.googlers.com>
 <51d31257-7093-a0fa-9681-929b9fea059c@gmail.com>
Message-ID: <1015625d-9975-3991-ebd2-25ba212286e3@gmail.com>
Date:   Mon, 1 Jul 2019 15:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <51d31257-7093-a0fa-9681-929b9fea059c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/06/2019 09:57, Phillip Wood wrote:
> On 25/06/2019 21:44, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> commit 4a72486de9 ("fix cherry-pick/revert status after commit",
>>> 2019-04-16) used parse_insn_line() to parse the first line of the todo
>>> list to check if it was a pick or revert. However if the todo list is
>>> left over from an old cherry-pick or revert and references a commit that
>>> no longer exists then parse_insn_line() prints an error message which is
>>> confusing for users [1]. Instead parse just the command name so that the
>>> user is alerted to the presence of stale sequencer state by status
>>> reporting that a cherry-pick or revert is in progress.
>>
>> Or is it likely that such an effort would end up being wasted, as...
>>
>>> Note that we should not be leaving stale sequencer state lying around
>>> (or at least not as often) after commit b07d9bfd17 ("commit/reset: try
>>> to clean up sequencer state", 2019-04-16).
>>
>> ...this already happened?
> 
> Probably. It is still possible for the user to run checkout in the 
> middle of a cherry-pick and forget to finish it but if they're using a 
> prompt with git support it should tell them that a cherry-pick is in 
> progress as `git status` detects that it is.

Unfortunately it is not true that the prompt will see the in-progress 
cherry-pick as it does not use git status - see 
https://public-inbox.org/git/0f04fa2930d5cc7dfd2a5c5185573f7ecefa6055.1561990865.git.gitgitgadget@gmail.com/T/#u 
for a fix

Best Wishes

Phillip
