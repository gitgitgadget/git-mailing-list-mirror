Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A5DC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 17:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiARR4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiARR4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 12:56:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553CC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:56:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a5so30739pfo.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jWHfKrgnfayL66Pf2MxL0oZk1QA17p93OUYz8lspvBQ=;
        b=QEk9DrS00RTAAmSi3AxFZgUens9ZrINOoUb8sseJ+EITq7DkDGC1SEk/y2ook65o+C
         kF9GAnWX5uZAJImDdoWz9xe39IXie4D9PBnI5i8HOmd/NoiZ5t4eQKInXyvPiTx0IQ6N
         7fLphXfPlPB6ADNaeY6c5v3lesKUTGOKZ8gu5nCzBC7BPP2B2GmZZX8CJSP7TiAS+u82
         KIeoaMkI/BcWdZjjFZSKR1ps3ZQ0eGTlY6QQd/uXuOXWMIYMzSf7lMFm3b7YmTDXSBqS
         QLxV+qp6uiqw7cuqg57UwLmdC4muMybFnhUyAG4VDh2zNOd8Rzo+TNMo/L/mel6ocfzz
         oE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jWHfKrgnfayL66Pf2MxL0oZk1QA17p93OUYz8lspvBQ=;
        b=PZEQzXci0X0ThBxd0np0hOdlNObEgGryCBWVu5wq5MDfsuFdgrzqMI+UhZSyr3S35h
         9PAJp0B2YEqU6ONQfZ7nvGEkSn2hDgmJGdD72kh0y6k/PBcrWe47NhrBtghGSCBtl8IK
         KNrZJbXXcR+GedB5VB1p824crMWYJqj3ExsN14knVypqbZ/S33dHqbd/McmaZhxmMsPM
         /fpU+ncQtTl252TDy0N3eCBSEZAdgPJEYVRtm6NSVr+I9Rcjw978cwBJtEIqQz48hzYq
         ozLm2XzkN21YduJVM379T6i53U5dFf4qP3YEl33rz3g8UsIeMDjR7b+/k2yy8t3SVL6Y
         MHBA==
X-Gm-Message-State: AOAM530RKx8Xv7hfEOy+W61xg3ncJ0hAJ3mnAwWGyznY4wtNve7Wc1jc
        A6Q7poFDQRIDSlRG4B7n2uc=
X-Google-Smtp-Source: ABdhPJx7NW1/w2zG9ZqTU9++TMT+8VQNnYidWXntOc/vDje9rLuwungXU3vwG8lSGW4iX8MuhbYN0Q==
X-Received: by 2002:a05:6a00:148c:b0:4c2:6f06:8c70 with SMTP id v12-20020a056a00148c00b004c26f068c70mr22732970pfu.48.1642528600038;
        Tue, 18 Jan 2022 09:56:40 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:2d18:26b4:c539:428e? ([2601:602:9e81:12c0:2d18:26b4:c539:428e])
        by smtp.gmail.com with ESMTPSA id b12sm19600132pfv.148.2022.01.18.09.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:56:39 -0800 (PST)
Message-ID: <ee58a0d5-5773-238d-706f-3fb264b6e8db@gmail.com>
Date:   Tue, 18 Jan 2022 09:56:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
 <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
 <xmqq7dayup5d.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqq7dayup5d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/22 11:40 AM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> I'm not sure I follow.  READM<TAB> already doesn't complete to
>> README.md in the following example command lines:
>>     'cd READM<TAB>'
>>     'ssh READM<TAB>'
> 
> If the example were "ls READM<TAB>", it would have been worth the
> time to read and think about this again, but all users expect "cd"
> to go into directories, and "ssh" to go visit another host, and
> taking a local filename as a hint to complete would be nonsense.
> 
> But that is not what we are talking about (and it is frustrating
> that you know it).
> 
> To users, what sparse-checkout takes look like local pathnames, not
> necessarily limited to directory names (if you disagree, go back and
> read what SZEDER wrote to trigger this thread).
> 
> I know it is your preference to complete only directories and
> exclude filenames, but I question if the confusion such a design
> causes to end-users is worth it.

I think perhaps we're a little caught up in exemplifying commands that
are unrelated to sparse-checkout. As Elijah said in [1], the documentation
states that directories and patterns are acceptable to sparse-checkout but
not files. While it is not reasonable to try to offer every pattern a user
could possibly pass to sparse-checkout, it is reasonable to offer
directories and (in my opinion) will help guide users toward correct usage
of the command.

However, since completion on directories is cone-mode-specific, I am
willing to accept the suggestion to only complete directories if we are in
a cone-mode sparse-checkout and apply it in v4 of this series.

[1]: 
https://lore.kernel.org/git/CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com/
