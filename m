Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8305DC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 17:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBFRoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBFRoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 12:44:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF9E233F7
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 09:44:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g13so8136696ple.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uydiN3aBuO1RitbctaT/6EYX/CEMLKfdOm0Bc+o+ByA=;
        b=L/n1AZ56cxEU2agc9rdzpOkGJJ7BtfoeKi7H4336qchDi7xJGmEapE93ojvsB21qKB
         kqJNAQa3QG2ymE2hFBKNzJAh/dKXUGXlz3rNfZkCeEGAsjebZWseqS6Yp+g9nlCDP9FU
         sAG5WbFuSydvOth/MAiLHADWKSVpJzsrkm2yd5f5druMkKKijc6I2ELRoS81zWhHFw4N
         g77sgHJtqtPLx0xq909hHSk+Z5EFPqsFQwO1LrEEBsqQRtJqRhhUyj5Qsgm9U7BlZN36
         NzoAcMZex6wV5Bl9P5r0hkhsKAcFarbZm40n1X3yvVH5Kqy4dF/H2mJUJsvWMKVcfDAx
         bIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uydiN3aBuO1RitbctaT/6EYX/CEMLKfdOm0Bc+o+ByA=;
        b=FN3tbwtBbjOBvE0QksN9DPlVFEcdNJ0Vje/RPRR07FWdSiA/xonVRwfogrYlyWDCzH
         +HblplwJDquPeGLHkvLqsBmToy5VvzKMQrPJSXTu8H85JHKU41T2P3nY6/ib9MQp/paS
         NC4/j7XXiHNMloLzglc9Dv4IkB6zdDsbAtxckqSl0J3mZNvzmTKwHvEMKolqbBx0SyAD
         Tlo8jwX1ZkAWwVFU/MJ5glOIhDvuVpw6ZinvNj65RafiMIk3orwb72CZ3qKR/TpZjoYO
         DZcEdicUHfKGs7swpA/U8ZAC4dvvl1mJLESSf+2LTuyRT7phqfsbJmcgWEF0XCKf/dDP
         6fiQ==
X-Gm-Message-State: AO0yUKX1gdJ71952cDSSJ87f08GHFb8T+KRJ3Sf6NngHVRqUWwhcFli8
        C+YL6fh0sFdq72xMcSg7HcY=
X-Google-Smtp-Source: AK7set+x1cWGTH5ZpIySjEF6yaO+3iDXnGkyN7SAhqa/l+EMxwaHVUFXZZ+wiHp0oszbtJbCrdnUjg==
X-Received: by 2002:a05:6a20:7f9b:b0:c1:2038:c8e8 with SMTP id d27-20020a056a207f9b00b000c12038c8e8mr2294013pzj.36.1675705454302;
        Mon, 06 Feb 2023 09:44:14 -0800 (PST)
Received: from [192.168.208.87] ([49.204.138.58])
        by smtp.gmail.com with ESMTPSA id p19-20020a637413000000b00477def759cbsm6424503pgc.58.2023.02.06.09.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:44:13 -0800 (PST)
Message-ID: <35c20121-f9ea-295a-b840-5bf380b26b81@gmail.com>
Date:   Mon, 6 Feb 2023 23:14:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: GSoC 2023
Content-Language: en-US
To:     Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
 <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
 <CA+CkUQ-t3-jOaGE4yMHXxREBs3-t35NCAJ3VTSnMSq5072rsBg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CA+CkUQ-t3-jOaGE4yMHXxREBs3-t35NCAJ3VTSnMSq5072rsBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hariom,

On 06/02/23 01:20, Hariom verma wrote:
> 
> On Tue, Jan 24, 2023 at 10:08 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> I removed the "Reachability bitmap improvements" idea but left the 2 others:
>>
>>    - More Sparse Index Integrations (I removed `git mv` in the list of
>> commands that need to be improved though)
>>    - Unify ref-filter formats with other pretty formats
>>
>> On both of them I removed all possible mentors except me though. They
>> are welcome to tell me that they should be added back.
> 
> I'm positive that I'll be available by the time the GSoC contribution
> officially starts.
> You can add me back to "Unify ref-filter formats with other pretty formats".
> I would be happy to co-mentor it with you.
>

Thank you for volunteering. I've added you back as a possible mentor for 
the project hoping Christian would be fine with it.

-- 
Sivaraam
