Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D371F731
	for <e@80x24.org>; Sun, 11 Aug 2019 13:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHKNrv (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 09:47:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKNrv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 09:47:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so102438395wru.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2019 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dFZ+PHh0Q9X0fqET6/FsoUHTsiKD2OAel9HxOQGS9sw=;
        b=ZPipqWIKDe5VFvDd+pA/65grwfdun16/vyRE/ILQRdO+FduLcjJEMvWsClbcPn7D0l
         nxTl2tRBidp1koBpBp1f6NDNaj7HEklgVBydQloRZl//nr729h+mCjtZx+aKoYbaIQRy
         lENH2Q87+4bg/HfvWKV79xk3PqYxuf7OA8b6Oo25vPlR0dKuRz/ZfPUHX6NbD6sqp0Bg
         99nKOpATTBtCwNxBK56DK2M/fWkZPoowbyXz35VdqlBvdQ7Xf+b8mfvWIDSStfdk23HC
         sNb6fPXHoxO3YXs9k81EqM/cd6WNYXHIij3csM50I7exb98aLdCDXBHotS58In7yaHIJ
         1vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFZ+PHh0Q9X0fqET6/FsoUHTsiKD2OAel9HxOQGS9sw=;
        b=XHJzI4frf4S9Y7Y4bHExMH0OeW1SJ1buxU5bzBbkBfFEui5H6i8HpqhQVd/UCSmeKB
         P04Axzi5zBFWKn47ZurHaOZF6muPfvdxd7BrnwJpt/gQNjGp2gr8irMGxumgH/ysmoEH
         ghHHDk/GuFzG9tN2tIdgECWPcUEK/hgAZPtUaRLeVfcqAzTF9hYQqRsrwxpbFBb+l5Bn
         WF5oU+dZhtQDoZPoA5blDSYm+SYsiKqzAdZYX3xoLeiAEz/Oq16CxNK04MjCUQtXtZye
         IpvkK1JETZehsE8dnjaU9yvZ/MOguuNYBJ14ZVHBQoHgTgdi5BafYO4TRXCq2LCIIHSv
         cUHw==
X-Gm-Message-State: APjAAAXiujGV7QK/U/WJhuNn9Glw/G9N6EBtCNnqiuuDJwoAOthGlTIo
        5DpdY17f1a79SCUj91J4y/zcMdIm
X-Google-Smtp-Source: APXvYqzHIh8lyWXnpr/Un1KmoriT7KdtwVyjI0jL0wF4fMBcR5vLmnuSvS0Jlso0T1FQ114CdZWECA==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr37276681wrn.142.1565531267708;
        Sun, 11 Aug 2019 06:47:47 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id o7sm11058728wmc.36.2019.08.11.06.47.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:47:47 -0700 (PDT)
Subject: Re: Incorrect behavior from git checkout --patch
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Dave Kaminski <davekaminski@gmail.com>, git@vger.kernel.org
References: <CA+zjYZsojm0QgHBC3GFb2NeZR1aK3Uh7vO4ojBzsMKVvP6X+Tg@mail.gmail.com>
 <a243aa2f-b237-db8e-0cac-cb3f776fdbd2@gmail.com>
Message-ID: <caebef3e-b8ef-176d-ae70-ae3d5864f32c@gmail.com>
Date:   Sun, 11 Aug 2019 14:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a243aa2f-b237-db8e-0cac-cb3f776fdbd2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dave

On 11/08/2019 10:54, Phillip Wood wrote:
> Hi Dave
> 
> Thanks for the bug report. I've tried to reproduce it on the latest 
> master, version 2.22.0 and 2.20.1 and am unable to do so.

Doh, I was doing 'git checkout -p HEAD', when I checkout from the index 
I can reproduce the bug and it is fixed by the patch I linked to earlier 
which will be in git 2.23.0. That will be released soon (we're at 
2.23.0.rc2 at the moment)

Thanks again for taking the time to report the bug

Best Wishes

Phillip


> I thought it 
> might be related to a bug I recently fixed[1] but it does not appear to 
> be. I've appended the files I used below just in case I made a mistake 
> translating your patches to files that can be used with git checkout.
> 
> Best Wishes
> 
> Phillip
> 
> [1] 
> https://github.com/git/git/commit/1b074e15d0f976be2bc14f9528874a841c055213#diff-588be9a03d1f7e33db12f186aad5fde9 
> 
> 
> pre-image
> 
> block_one {
> line 1
> line 2
> line 3
> 2 4 6 8
> line 4
> line 5
> line 6
> 2 4 6 8
> line 7
> line 8
> line 9
> 2 4 6 8
> line 10
> line 11
> line 12
> }
> 
> block_two {
> line 1
> line 2
> line 3
> 2 5 6 9
> line 4
> line 5
> line 6
> 2 5 6 9
> line 7
> line 8
> line 9
> 2 5 6 9
> line 10
> line 11
> line 12
> }
> 
> post-image
> 
> block_one {
> line 1
> line 1.5
> line 2
> line 2.5
> line 3
> 2 4 6 8
> line 4
> line 4.5
> line 5
> line 5.5
> line 6
> 2 4 6 8
> line 7
> line 7.5
> line 8
> line 8.5
> line 9
> 2 4 6 8
> line 10
> line 10.5
> line 11
> line 11.5
> line 12
> }
> 
> block_two {
> line 1
> line 1.5
> line 2
> line 2.5
> line 3
> 2 5 6 9
> line 4
> line 4.5
> line 5
> line 5.5
> line 6
> 2 5 6 9
> line 7
> line 7.5
> line 8
> line 8.5
> line 9
> 2 5 6 9
> line 10
> line 10.5
> line 11
> line 11.5
> line 12
> }
> 
> 
> 
> On 10/08/2019 21:12, Dave Kaminski wrote:
>> I am observing git checkout --patch making changes to the wrong lines 
>> of a file.
>>
>> This is with a clean install of git version 2.20.1 on a debian docker
>> container (image tag 10.0 which is also "latest" as of this writing).
>>
>> With a diff that looks like the following:
>>
>> diff --git a/file.txt b/file.txt
>> index 868aa22..ea4d786 100644
>> --- a/file.txt
>> +++ b/file.txt
>> @@ -1,35 +1,51 @@
>>   block_one {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>>   2 4 6 8
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>>   2 4 6 8
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>>   2 4 6 8
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>>   block_two {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>> -2 5 6 9
>> +2 4 6 8
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>> -2 5 6 9
>> +2 4 6 8
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>> -2 5 6 9
>> +2 4 6 8
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>> doing a `git checkout --patch -- ./file.txt`, splitting the diff into
>> hunks, and discarding all of the hunks that begin with numbers, e.g.
>>
>> @@ -22,3 +32,3 @@
>>   line 3
>> -2 5 6 9
>> +2 4 6 8
>>   line 4
>>
>> the expected state of the file in the working directory is this:
>>
>> diff --git a/file.txt b/file.txt
>> index 868aa22..9ab67a1 100644
>> --- a/file.txt
>> +++ b/file.txt
>> @@ -1,35 +1,51 @@
>>   block_one {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>>   2 4 6 8
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>>   2 4 6 8
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>>   2 4 6 8
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>>   block_two {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>>   2 5 6 9
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>>   2 5 6 9
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>>   2 5 6 9
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>> but instead the actual state of the file is this:
>>
>> diff --git a/file.txt b/file.txt
>> index 868aa22..76fe65d 100644
>> --- a/file.txt
>> +++ b/file.txt
>> @@ -1,35 +1,51 @@
>>   block_one {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>>   2 4 6 8
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>>   2 4 6 8
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>> -2 4 6 8
>> +2 5 6 9
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>>   block_two {
>>   line 1
>> +line 1.5
>>   line 2
>> +line 2.5
>>   line 3
>>   2 5 6 9
>>   line 4
>> +line 4.5
>>   line 5
>> +line 5.5
>>   line 6
>>   2 5 6 9
>>   line 7
>> +line 7.5
>>   line 8
>> +line 8.5
>>   line 9
>> -2 5 6 9
>> +2 4 6 8
>>   line 10
>> +line 10.5
>>   line 11
>> +line 11.5
>>   line 12
>>   }
>>
>> See the changes between "line 9" and "line 10" in both blocks that are
>> not correct.
>>
