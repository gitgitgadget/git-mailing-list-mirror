Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1AA21F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 02:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeKYM4h (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 07:56:37 -0500
Received: from smtp.rcn.com ([69.168.97.78]:38805 "EHLO smtp.rcn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeKYM4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 07:56:37 -0500
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=DKTN2GFb c=1 sm=1 tr=0 a=OXtaa+9CFT7WVSERtyqzJw==:117 a=OXtaa+9CFT7WVSERtyqzJw==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=NTnny0joGdQA:10 a=JHtHm7312UAA:10 a=bmmO2AaSJ7QA:10 a=5rxgeBVgAAAA:8 a=l18e7q39AAAA:8 a=pGLkceISAAAA:8 a=BTUBnpS-AAAA:8 a=uh0kXezinnGV6DdXh4IA:9 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=AKtIAzDFQ15IUzIbpgNn:22 a=pblkFgjdBCuYZ9-HdJ6i:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZHNlb21uQHJjbi5jb20=
Authentication-Results: smtp02.rcn.cmh.synacor.com header.from=david@mandelberg.org; sender-id=softfail
Authentication-Results: smtp02.rcn.cmh.synacor.com header.DKIM-Signature=@mandelberg.org; dkim=pass
Authentication-Results: smtp02.rcn.cmh.synacor.com smtp.mail=david@mandelberg.org; spf=softfail; sender-id=softfail
Authentication-Results:  smtp02.rcn.cmh.synacor.com smtp.user=dseomn@rcn.com; auth=pass (LOGIN)
Received: from [209.6.43.168] ([209.6.43.168:33226] helo=uriel.mandelberg.org)
        by smtp.rcn.com (envelope-from <david@mandelberg.org>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=DHE-RSA-AES256-GCM-SHA384) 
        id 2D/74-27719-2B30AFB5; Sat, 24 Nov 2018 21:06:42 -0500
Received: from [192.168.1.152] (DD-WRT [192.168.1.1])
        by uriel.mandelberg.org (Postfix) with ESMTPSA id AE0B71C6055;
        Sat, 24 Nov 2018 21:06:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
        s=201809; t=1543111597;
        bh=voM2ARNZnA9FfAcr8tHbulY/TTEZnJT9bBmheo1vLoE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L7GveqgQfle46oDZPCllX68bdwNjv1imwZulwGcR9iBRHVoZbzIK8lIQ9n2H/hNDB
         poTyRpyOI6diX5gUdcC/JXqe7xroJwb5TCqwpDgmIc8ju/OLDdcwYff+Ny+2wZ36Sl
         gHg5U6MHPzB/myqi8+RfLbzxKiFyFpQ5zIK5t8R/lwj4yUPNiGWF3bz/uZftRKKJOn
         uc7UrNAF6ESYsDlvrctkORnQdUHFqI7VKRNiYizD7JKEQ+yAv20SrolHlWYxVuHzik
         lEbUgImod+xJ1yiNOBkYy3BTjKbgxWgNSafmO3d5uLPOtdEaOQOcLa+OVqAqiOZeWj
         qY+ON91nBIU9g==
Subject: Re: git overwriting local ignored files?
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
 <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
 <7ac49733-2e62-7d29-36aa-99df4124b54c@mandelberg.org>
 <20181124145723.ow2h7x374xwwts6m@tigra>
 <20181124154132.co3lo27wy25i4v47@tigra>
From:   David Mandelberg <david@mandelberg.org>
Message-ID: <89204364-f624-62ec-fbaa-84b5b7ae4099@mandelberg.org>
Date:   Sat, 24 Nov 2018 21:06:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181124154132.co3lo27wy25i4v47@tigra>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/18 10:41 AM, Konstantin Khomoutov wrote:
> On Sat, Nov 24, 2018 at 05:57:24PM +0300, Konstantin Khomoutov wrote:
>> On Sat, Nov 24, 2018 at 09:37:06AM -0500, David Mandelberg wrote:
>>
>>>>> It seems that git is overwriting my local files on merge if they're in
>>>>> .gitignore.
>> [...]
>>>> The .gitignore file is to list "ignored and expendable" class of
>>>> files; there is no "ignored but precious class" in Git.
>>> Ok. Would a patch be welcome? I have three ideas for how to implement it,
>>> and I'm not sure which is better.
>> [...]
>>
>> You might want to first investigate this recent thread [1] which AFAIK
>> was dedicated to exactly this problem.
> 
> Well, actually the thread is old, but its continuation [2] is recent.
> The crux is that it discusses certain approaches to solve the apparent
> problem and patches to do that.
> 
> 1. https://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/
> 2. https://public-inbox.org/git/871s8qdzph.fsf@evledraar.gmail.com/

Thanks for the pointers, and sorry to start a new thread. It looks like 
most of the work to do is in finding consensus on the right way forward, 
rather than in writing a patch. While I really would like there be a way 
to prevent git from overwriting ignored files, I don't have any strong 
opinions on what that way should look like. So I think I'll just wait 
and hope somebody else does the work.

-- 
https://david.mandelberg.org/
