Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A4C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiADTTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiADTTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:19:20 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B98C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 11:19:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y18so37128310iob.8
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aoXMdDP4BiCLY77MeQT1cZDEAavjbgYEXQjCRdc0a8I=;
        b=qCriR4my2QwsBFDa/MYOTiZ9NxsQvHExVx/5fJYbtkbLAZY9pmFQRlQHiFgnSjP/qz
         7vNNAhPWc581i6iJdRPWyhWxJSsuRlO2MpAQFs95AMlD64Odg6P1+VvjTOxQQtiRILn4
         xCk5O8YiIdiqfb3Z/6Il2zrhj7tGZ35hFuI92oslsZh/uiSsZiaD4ZvyHWoRz6dfxjIH
         Xbr4toHMc1az9wr/wzNWX+786bB5jiu8kRg+6J3SjNz1Rf7g89x03kTpgvvSTqgAo3iR
         eHnpv7y/q4Pxy+5VM4jDwpkRFGh+KOpsCxAtR89K2iL7QZhWiRolBKQJJOAPzLabbEPq
         uSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aoXMdDP4BiCLY77MeQT1cZDEAavjbgYEXQjCRdc0a8I=;
        b=rVAuGFSnFAEQlhk0npNildl0HNXf9CYfyv3hTRnX3pwZI4bbalrPwkuC7Z13aOX69K
         DeGjGA1dU5y4cSR45suFRSfaIKBzDAxUMxST9l8LZqWQdriZZPtQ5Q1NB7assPMgthQQ
         a1SONc8Kt06Ex9dFJFWdxzqonbBmNLjawDyGB5QjsH3cSjRXTp7LEJXV1ZtSrkjzwBwZ
         /053gLqKzS6+IcDBCOPt5a+h5h/9f6j+/HhHGJJSiADu2ZNZIY54fZXYuF9CVLJo+lyn
         LQpjnSNbWPzKfpBfEvzntziLi5rH8yGizgJ1jZC7GUcgn3NGsVHN5QX4tL+tfKAtzlsv
         NDqA==
X-Gm-Message-State: AOAM533Wz7wC1K7QgURz6ZAdxp/2+/vQKICqd/g7cdnkM/1KPo+FJ2cG
        MbTQm5Q+sYg6cnHH/xBfOmQ=
X-Google-Smtp-Source: ABdhPJwjO0fXTJC5HRB0PgcL0D+sp/ekihdE2hT8VynRFfEOGjwtEVGh+EiqXpSfnetxcBa9S2WD1Q==
X-Received: by 2002:a02:a307:: with SMTP id q7mr23147938jai.272.1641323959565;
        Tue, 04 Jan 2022 11:19:19 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id d16sm22983491ioy.29.2022.01.04.11.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 11:19:19 -0800 (PST)
Message-ID: <bad4de96-cf76-ab25-29e5-eb14325e2918@gmail.com>
Date:   Tue, 4 Jan 2022 13:19:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
 <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com>
 <e6728ed1-52c6-05eb-e816-a9d919d3e9d1@gmail.com>
 <63bb7366-71f6-d4c3-529f-c52d3610c1cd@gmail.com>
 <CABPp-BGun+v3BCuutPW2L1q3wzdB+Etuh_0Jz1aFanivZmyXWQ@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BGun+v3BCuutPW2L1q3wzdB+Etuh_0Jz1aFanivZmyXWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/31/21 1:27 PM, Elijah Newren wrote:
> On Fri, Dec 31, 2021 at 2:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/30/2021 11:19 AM, Lessley Dennington wrote:
>>> On 12/30/21 7:43 AM, Derrick Stolee wrote:
>>
>>>>> +    (
>>>>> +        cd sparse-checkout &&
>>>>> +        test_completion "git sparse-checkout set f" <<-\EOF
>>>>> +        folder1 Z
>>>>> +        folder1/0 Z
>>>>> +        folder1/0/1 Z
>>>>> +        folder2 Z
>>>>> +        folder2/0 Z
>>>>> +        folder3 Z
>>>>
>>>> This tab-completion doing a full directory walk seems like it could
>>>> be expensive for a large repository, but I suppose it is the only way
>>>> to allow the following sequence:
>>>>
>>>>      fol<tab> -> folder
>>>>      folder1/<tab> -> folder1/0
>>>>      folder1/0/<tab> -> folder1/0/1
>>>>
>>>> (Hopefully that makes sense.)
>>>>
>>> Yes, it does.
>>>> It would be more efficient to only go one level deep at a time, but
>>>> that might not be possible with the tab completion mechanisms.
>>>>
>>> When you say one level deep, do you mean that from the sparse-checkout
>>> directory, tab completion would only show the following?
>>>
>>>      folder1
>>>      folder2
>>>      folder3
>>
>> That's what I mean by one level deep at a time, but I also am not
>> sure that that is the correct functionality. I would leave the full
>> expansion as you have now as the design.
> 
> I think one level at a time is better and is the optimal design.  By
> way of comparison, note that if I do the following:
> 
> mkdir tmp
> cd tmp
> mkdir -p a/b/c/d
> touch a/b/c/d/e
> cd <TAB>
> 
> I do not see a/b/c/d as the completion, I only get "a/" as the
> completion.  If I hit tab again, then I get "a/b/".  Tab again, and I
> get "a/b/c/".
> 
> I don't think normal tab completion recursively checks directories, so
> it'd be better for us to not do so with git either.  However, if it's
> hard to avoid automatically completing just a directory at a time,
> then I think a fair first cut is completing to full depths, but call
> it out as something we'd like to fix in the commit message.

Thank you for the feedback! This is fine by me - I'll respond further to
your comments in [1].

[1] 
https://lore.kernel.org/git/CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com/
