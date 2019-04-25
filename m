Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822551F453
	for <e@80x24.org>; Thu, 25 Apr 2019 11:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfDYLGK (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 07:06:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44819 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfDYLGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 07:06:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id s10so13052638qtc.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4lDOQA1RDcRVTOY77uQhImFQp8Pt3aVuMjyaXcPsQ8=;
        b=HZDBx/dmtBrEqtNGPbOEK5QAWBWmYz9ZaZykFL4HefPfM0rFKsFg4brlguPQKbLQ6b
         fCPGfFmLe2BYFd/c45O2Peb4h3Ol/ll3jTX3yd46EJniw1FZ+pG/9b/DKCtfk1+ypuMw
         SdwyCsPSLrosltvzgktVU1Q6ePL/7SkTcFb9Q29/YmL5a8XIeXHYnQpbVqEE0s2go1m7
         uLeI5TOs9LBMWaz4lZvSB4IHvae44m2sUVK190l8KInnD3l5N53UlKp00joahEYH1fJf
         QMAqhniIxSOqnxWd9713lyxEECLhSMcfOopIoLfrJacNY8jk5OpPqe5lCLT2etUGF9fF
         61JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4lDOQA1RDcRVTOY77uQhImFQp8Pt3aVuMjyaXcPsQ8=;
        b=rq1W2jTfbISeZlhT0urFD0eizrbPtT2dWEp7ETo1W4wkxuk+G6Jad2FlcCWNqrC0GZ
         JRU6VgHHFsIJO0mmKw2ElF7hzicqN19JlhdyPu3cEpPtPNxSOkWrb2tKLxK0PmnqphpL
         iOBxdh8AYb9gXrNBgCJHekQww3L3x/ONfIz7lN1ZVd93R+JHlHykf+rvJKifuZM72Dca
         wylRAr5HeQKYo25N4CXJgky118qkZ6li0+zgkTFZOTs9kddn8HubZVVWMYO/PxYl3OjR
         Mcw8fIQenl4+xPe/NXdoDdOLwtBrkfCrYWpleqdLerrw8TQthnv/oVzsheos/0b60yln
         01Aw==
X-Gm-Message-State: APjAAAVOz1G/HAubt5zcwaupmA50ciRgtr1GkUJRXgd/K7miahAyvi0E
        wHQ7ATuHkk9FtAPulGzZsw4=
X-Google-Smtp-Source: APXvYqwxC6utDUtxxbaSGVtJAJcMQCmHto4mcbCo0p+Lr56HwGaavh4wNzXJfHcn0tVcHzGP5ZNtbw==
X-Received: by 2002:ac8:396e:: with SMTP id t43mr10288550qtb.1.1556190368816;
        Thu, 25 Apr 2019 04:06:08 -0700 (PDT)
Received: from [10.0.1.5] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e6sm10453950qtr.56.2019.04.25.04.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 04:06:08 -0700 (PDT)
Subject: Re: [PATCH v5 00/11] Create 'expire' and 'repack' verbs for
 git-multi-pack-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
 <xmqqbm0uy78e.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <651dd41f-4d16-8adf-e128-7ca2f5eff907@gmail.com>
Date:   Thu, 25 Apr 2019 07:06:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <xmqqbm0uy78e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2019 1:38 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Updates in V5:
>>
>> * Fixed the error in PATCH 7 due to a missing line that existed in PATCH 8. Thanks, Josh Steadmon!
>>
>> * The 'repack' subcommand now computes the "expected size" of a pack instead of
>>   relying on the total size of the pack. This is actually really important to
>>   the way VFS for Git uses prefetch packs, and some packs are not being
>>   repacked because the pack size is larger than the batch size, but really
>>   there are only a few referenced objects.
>>
>> * The 'repack' subcommand now allows a batch size of zero to mean "create one
>>   pack containing all objects in the multi-pack-index". A new commit adds a
>>   test that hits the boundary cases here, but follows the 'expire' subcommand
>>   so we can show that cycle of repack-then-expire to safely replace the packs.
> 
> I guess all of them need to tweak the authorship from the gmail
> address to the work address on the Signed-off-by: trailer, which I
> can do (as I noticed it before applying).

Sorry. Due to the conflicts, GitGitGadget prevented me from submitting in
my normal way, so I pulled out format-patch and send-email for the first
time in a very long time. I manually added new "From: " lines in the bodies
of the patch files, but they got suppressed, I guess.

Thanks,
-Stolee
