Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DF81F405
	for <e@80x24.org>; Thu,  9 Aug 2018 16:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeHISfX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:35:23 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:61242 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHISfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:35:22 -0400
Received: from [192.168.2.240] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nnVSfpuSmwhzSnnVTfGMcF; Thu, 09 Aug 2018 17:09:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533830988;
        bh=DSm9aKLFchxie78DBj7CMzhRKsNpr7v9yN927ObKUbA=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=P5039xMX+YgjyyiZyNV0U391cECP0rRJK2zfz0+F5+nJLB51B56Sd+8leGGbNzzm+
         CQ1ulUNHbnI9emMWPTJHX/IzScJgcLrSCFJFsEqnC/eC+jhF1/MrFS4vMaD0oqB5xW
         XUnjpqmpqU9opsaJbPJisGlX2ov8vBSp844IESKw=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=PvrGUNYB_FTU1SulNSUA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 04/20] rebase -i: rewrite the edit-todo
 functionality in C
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-5-alban.gruin@gmail.com>
 <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
 <6826d318-b0ab-4e8e-e2ba-5425e3bf6f5f@gmail.com>
 <75549397-9080-3b5a-8655-cea04065b2eb@talktalk.net>
 <bc07317b-ba44-7a3c-7cb4-504b7dbc7c34@gmail.com>
 <329d89f1-5ade-aeec-40bc-cd7168822d3e@talktalk.net>
Message-ID: <d8b203b6-6fbe-1751-3c85-a8e7991bd765@talktalk.net>
Date:   Thu, 9 Aug 2018 17:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <329d89f1-5ade-aeec-40bc-cd7168822d3e@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLnyHOuXWE3YQNDXTLtZKPbs87Mf9yRXnAv4MxuSlN52vKjY001ZUG/hhW2VF/zx4654IseB0Axh7n0/hZMiKxMjwrKx12vgmn6V722a23XXm52F+huk
 VfWhIHZjPZ/KDRMhwswkeYyDXOjoLN1xhJlfjZurHxNIHrwiqWwacJw/7v8PmCX1QLYyuunogoEiMbUecEBb2m7ixtfvvXUTXdHOY8OWp2gkA7N6w284XddU
 ysR69bj4f0D7B4KAa3t+OoSx130JJcz6Idw9pPdi2HcYCNlIchziEJkrhkovpp48u7z0PKS7lvREbbuhx9XtWIJ5cLUY5Du9i26kt4LQpjWucZ0qDKF2YRmf
 KhbVWJDFy5xszSjGkkK0HAK7qrbfR6Iro5ubm60AueTNO7J7igt0/G00lDVVEylcj9n6yeFF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 09/08/18 16:35, Phillip Wood wrote:
> Hi Alban
> 
> On 09/08/18 14:30, Alban Gruin wrote:
>> Hi Phillip,
>>
>> Le 08/08/2018 à 18:04, Phillip Wood a écrit :
>>>>>> +int edit_todo_list(unsigned flags)
>>>>>> +{
>>>>>> +    struct strbuf buf = STRBUF_INIT;
>>>>>> +    const char *todo_file = rebase_path_todo();
>>>>>> +    FILE *todo;
>>>>>> +
>>>>>> +    if (strbuf_read_file(&buf, todo_file, 0) < 0)
>>>>>> +        return error_errno(_("could not read '%s'."), todo_file);
>>>>>> +
>>>>>> +    strbuf_stripspace(&buf, 1);
>>>>>> +    todo = fopen_or_warn(todo_file, "w");
>>>>>
>>>>> This truncates the existing file, if there are any errors writing the
>>>>> new one then the user has lost the old one. write_message() in
>>>>> sequencer.c avoids this problem by writing a new file and then 
>>>>> renaming
>>>>> it if the write is successful, maybe it is worth exporting it so it 
>>>>> can
>>>>> be used elsewhere.
>>>>>
>>>>>> +    if (!todo) {
>>>>>> +        strbuf_release(&buf);
>>>>>> +        return 1;
>>>>>> +    }
>>>>>> +
>>>>>> +    strbuf_write(&buf, todo);
>>>>>> +    fclose(todo);
>>>>>
>>>>> There needs to be some error checking after the write and the close
>>>>> (using write_message() would mean you only have to check for errors in
>>>>> one place)
>>>>>
>>>>
>>>> Right.  Should I find a new nawe for write_message()?
>>>
>>> That might be a good idea, I'm not sure what it should be though, maybe
>>> write_file()?, perhaps someone else might have a better suggestion.
>>>
>>
>> write_file() already exists in wrapper.c.  I wondered, as this make use
>> of the lockfile API, perhaps it could be moved to lockfile.{c,h}, and
>> renamed to something like write_file_with_lock().
> 
> Hmm, I'm not sure about that, to me the use of the lockfile api is just 
> a way to get the semantics of an atomic update to the file. Looking in 
> wrapper.c there is write_file_buf() which could maybe be changed to to 
> an atomic update. Looking at the current callers to that function they 
> look like they would work with such a change (sadly none of them bother 
> to check the return value to see if the write was successful). I don't 
> think we need to worry about them being broken by having a stale 
> lockfile left over if there's an error as I think the lockfile api 
> automatically cleans them up but I'm not an expert on that api so it 
> would be worth checking with someone like Johannes or Jeff King (I seem 
> to remember him working in that area relatively recently).

On second thoughts the current function dies rather than returning an 
error so it would be a bit of work to do the conversion properly. For 
now you could just make write_message() available outside sequencer.c 
and see if anyone comes up with a better name when v6 is reviewed.

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
> 
>> Cheers,
>> Alban
>>
> 

