Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9441F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJASPy (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:15:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41652 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfJASPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:15:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id 206so5399339ybc.8
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rf5erE41oFdNfYws6UixLUf9Adi4SfzzQcFf55LDOYE=;
        b=i1+gZ4i5EHl5NO/0wBmWmb2oH5bCtTPOlqvWB19KUfOCl+6/IvcBBLihaa0mDPis7v
         C2/nnIb1yDfVTAKJVfnB+nYfh6Ell9P6S3WZ1BAA35G8tXUwzzWr3nRe4N0I2Lhi/Uxo
         JXzLMHn+5WJshha3y+wGHBYc+Bo475pfBF4RtMgVA7rOJr9pq586beR1s8p3EhR6WI+4
         X30od6j+2IAQxCwlkhyNLR/Koam0qyaQ1gY9PlElSwXRZ+TxPFwG2tV66pepZY3xZHj6
         52D6XupeU2O8FGgfZmqWVCJNG6OTBnn63k6JudtXIJBIMsJxnurxeayvfFZh0a7jsuQQ
         +Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rf5erE41oFdNfYws6UixLUf9Adi4SfzzQcFf55LDOYE=;
        b=VbkN2yFz8Fsbqa3J1I98RfmmRRAbhtxgK+8YxRaFtlKM1mOX2vTRaxrLT1BInU7Kpl
         FsAwX4My+MtCYw+BgoINRCypZQh0vNLvRNgInbYNWNTKzsGJieEumcO2jnz0E0/EC5A3
         M9J3pducPMZAvWDl5t4wULsCs7Q/FpXQwj1JmM1Vb8M9O+FMJAlg5EornntDuL5qUXxR
         EMTgIbRKaG6zfGl4QiDilOGn1T0YxgueycF1WjIGpyNsjFexvatU7Mzp3+YVB2WXjCuw
         9M1NIdIpPL1iHUTFy0Wy0qf4fTzjkYOvpg7MdepaZCbvZ7pM6sbZqXIpHmerBf0/4BrR
         39hA==
X-Gm-Message-State: APjAAAVjULsGyQ9cYtBzScK6AgzxaPcLSv9lavGt1JDwGbRYwo3FuaBx
        dfzQODzJivAhJWI7eVsYqnY=
X-Google-Smtp-Source: APXvYqyZpXnX9RpgBWS0iQiiCWsBFGVW7Z8Bj1uCnfnbLae84d9utuYTd79HzfPk0tjdfodpFxXDjg==
X-Received: by 2002:a25:af85:: with SMTP id g5mr20615590ybh.417.1569953753588;
        Tue, 01 Oct 2019 11:15:53 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e17sm4322372ywa.52.2019.10.01.11.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:15:53 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] New sparse-checkout builtin and "cone" mode
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com>
 <CABPp-BHGNzLNzOW6nSi_ComA0DrRnJukqoemG8z_qS6e22uBUQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb1bac92-2c65-b329-46ee-bcb64cb9ac0c@gmail.com>
Date:   Tue, 1 Oct 2019 14:15:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHGNzLNzOW6nSi_ComA0DrRnJukqoemG8z_qS6e22uBUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/2019 12:54 PM, Elijah Newren wrote:
> On Tue, Oct 1, 2019 at 9:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
>>> This series makes the sparse-checkout feature more user-friendly. While
>>> there, I also present a way to use a limited set of patterns to gain a
>>> significant performance boost in very large repositories.
>>>
>>> Sparse-checkout is only documented as a subsection of the read-tree docs
>>> [1], which makes the feature hard to discover. Users have trouble navigating
>>> the feature, especially at clone time [2], and have even resorted to
>>> creating their own helper tools [3].
>>>
>>> This series attempts to solve these problems using a new builtin.
>>
>> I haven't heard anything about this series since Elijah's careful
>> review of the RFC. There are definitely areas where this can be
>> made more robust, but I'd like to save those for a follow-up series.
>>
>> Junio: I know you didn't track this in the recent "what's cooking"
>> list, and I don't expect you to take it until I re-roll v3 to
>> include the .gitignore interaction I already pointed out.
> 
> Oh, sorry, I missed this.  By the way, is there any reason I wasn't
> cc'ed on this round after reviewing the RFC?

Sorry, I forgot to modify my GitGitGadget cover letter to include you
as a CC. Totally my oversight, not on purpose.

Thanks,
-Stolee
