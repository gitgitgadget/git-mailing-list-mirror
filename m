Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12CF31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeKOENz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 23:13:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42393 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeKOENy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 23:13:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so27439972qka.9
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pL/DPiNoM1HViQB/hQMXXlQ9dVWUHJSDq6f5i0Z0WhM=;
        b=jAmn6KMzZ/+31K34frl3yvCSgNbkJp6K8u52339zipsjI6aIQMXJNfYcH4gpgSu0lz
         UGxAwree4PCOOIaBn7BYk0bfeL9DXpRj/isD+wxezX3rDAgHLm/5tw0iU8jc0Z4Eqv4s
         fEuNw+r6XIH9jsCjqvYaYp5tI+3L/DXNeY8Z627aXhxA+5gUtoDzGFrBoNe8na4KD4We
         5RxloXoDnqA/51vO73SFOvBB525E66NvjaQb9eDdqaXTY4X+UFX86liB152FRVQCaX0M
         SCOzTLtyHDwiDThq6pi44V86E+7ni+U2PHpUhMgFaHMJeUr/Mp0APytAWSxxIJqOyXTb
         VLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pL/DPiNoM1HViQB/hQMXXlQ9dVWUHJSDq6f5i0Z0WhM=;
        b=VQliEjn+Cw4UTwm1SrJX5OOYuwUP2jhMvtqOkKLhS3loaEBzS7QuSpADc/zJuq35Wa
         5EKn68AonLlor3xanfxQCpQFI7VgAPGwSxzRPtRyAr6Gil+8xsRylnQ/H7URzfY0Qycv
         l8KCpW1a6FrH2ZYr67r3wlqlIeyeZGzD1BtChtF4gt8VSAFfFrRV+Ikh9NXFo3yxh/zW
         l2peLgHLV83gl0F1zWmhDOSZ4lQzHookNsOiNh2S5hwO7qDH+S3fjqxsYZob2wHB7lYC
         PcQU0EI+IhDjyjjZyt4AOTgD9iSF4LuLKc0Jv8b/55joPF05NBNGED6DzIw7qXkv2n0Z
         /CFQ==
X-Gm-Message-State: AGRZ1gKBGPUQgOJqeV1s3euwxaJHyRDKc68X+7pz92QGbcqwEDAbAzC7
        b0EpZ551AtPGa2P3IbL2GE8=
X-Google-Smtp-Source: AJdET5d8pGYq34nwB+i2qesAuXjelDtbYEgtUJUTqoe9r1T86x0V10BzIEPs2eBDlTbQyzXY0Mqs3g==
X-Received: by 2002:a0c:e9c4:: with SMTP id q4mr2979001qvo.18.1542218979004;
        Wed, 14 Nov 2018 10:09:39 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id q2sm756353qkc.68.2018.11.14.10.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:09:37 -0800 (PST)
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <20181113181855.GB68106@google.com>
 <1b890149-ee7f-c391-9abc-46d120e4324c@gmail.com>
 <20181113210815.GD68106@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <75c91c81-f66f-ab2d-2b29-339deb3a6557@gmail.com>
Date:   Wed, 14 Nov 2018 13:09:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113210815.GD68106@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/13/2018 4:08 PM, Jonathan Nieder wrote:
> Hi again,
> 
> Ben Peart wrote:
>> On 11/13/2018 1:18 PM, Jonathan Nieder wrote:
>>> Ben Peart wrote:
> 
>>>> Why introduce a new setting to disable writing the IEOT extension instead of
>>>> just using the existing index.threads setting?  If index.threads=1 then the
>>>> IEOT extension isn't written which (I believe) will accomplish the same
>>>> goal.
>>>
>>> Do you mean defaulting to index.threads=1?  I don't think that would
>>> be a good default, but if you have a different change in mind then I'd
>>> be happy to hear it.
>>>
>>> Or do you mean that if the user has explicitly specified index.threads=true,
>>> then that should imply index.recordOffsetTable=true so users only have
>>> to set one setting to turn it on?  I can imagine that working well.
>>
>> Reading the index with multiple threads requires the EOIE and IEOT
>> extensions to exist in the index.  If either extension doesn't exist, then
>> the code falls back to the single threaded path.  That means you can't have
>> both 1) no warning for old versions of git and 2) multi-threaded reading for
>> new versions of git.
>>
>> If you set index.threads=1, that will prevent the IEOT extension from being
>> written and there will be no "ignoring IEOT extension" warning in older
>> versions of git.
>>
>> With this patch 'as is' you would have to set both index.threads=true and
>> index.recordOffsetTable=true to get multi-threaded index reads.  If either
>> is set to false, it will silently drop back to single threaded reads.
> 
> Sorry, I'm still not understanding what you're proposing.  What would be
> 
> - the default behavior
> - the mechanism for changing that behavior
> 
> under your proposal?
> 
> I consider index.threads=1 to be a bad default.  I would understand if
> you are saying that that should be the default, and I tried to propose
> a different way to achieve what you're looking for in the quoted reply
> above (but I'm not understanding whether you like that proposal or
> not).
> 

Today, both the write logic (ie should we write out the IEOT extension) 
and the read logic (should I use the IEOT, if available, and do 
multi-threaded reading) are controlled by the single "index.threads" 
setting.  I would like to keep the settings as simple as possible to 
prevent user confusion.

If we have two different settings (index.threads and 
index.recordoffsettable) then the only combination that will result in 
the user actually getting multi-threaded reads is when they are both set 
to true.  Any other combination will silently fail.  I think it would be 
confusing if you set index.threads=true and got no error message but 
didn't get multi-threaded reads either (or vice versa).

If you want to prevent any of the scary "ignoring IEOT extension" from 
ever happening then your only option is to turn off the IEOT writing by 
default.  The downside is that people have to discover and turn it on if 
they want the improvements.  This can be achieved by changing the 
default for index.threads from "true" to "false."

diff --git a/config.c b/config.c
index 2ee29f6f86..86f5c14294 100644
--- a/config.c
+++ b/config.c
@@ -2291,7 +2291,7 @@ int git_config_get_fsmonitor(void)

  int git_config_get_index_threads(void)
  {
-       int is_bool, val = 0;
+       int is_bool, val = 1;

         val = git_env_ulong("GIT_TEST_INDEX_THREADS", 0);
         if (val)


If you want to provide a way for a concerned user to disable the message 
after the first time they have seen it, then they can be instructed to 
run 'git config --global index.threads false'

There is no way to get multi-threaded reads and NOT get the scary 
message with older versions of git.  Multi-threaded reads require the 
IEOT extension to be written into the index and the existence of the 
IEOT extension in the index will always generate the scary warning.

> Jonathan
> 
