Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1113DC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 20:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiBZUao (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 15:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZUan (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 15:30:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E823EC66
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:30:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d15so4372814pjg.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cnpu4LJFX5RYmgyw3PE6BFLvZVEuGuunch2ir6z1QC8=;
        b=XOcxfZDJDUCrHsQnmCX0CX2YWr0B0hVn/O+rsRHPPA60wf9WHd0YFfstg3zIkMbrIR
         rJ0xnBm1zm3nKE3qgXWZcHME1HyYbocbPO0PxYO/WItPJAKeHQ+Y//+3yvW15iaPuecv
         t9ASdvEno5idXNYFHsuil4b0sfIOyFz8IejujdAP9y9BwjE7J3cvUa8Vvdfu2byCQ3fH
         qjf/T3NqSk7dx5nv3cz4iAotjZNHkpAGgi3bDeEivA+xubijQJ5zPGMbllKjoljTphKj
         W7SyqzaTIO8vfirSSVt1jEmw5k5DH6paQfdO8DFPu7QeQbjtkU9DrJAdPZ0Ab+UGDTOj
         hcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cnpu4LJFX5RYmgyw3PE6BFLvZVEuGuunch2ir6z1QC8=;
        b=FBt5NUBP/7RxMJi9p52Zj+gEfA5GTb2hx36wObEqL4tJ63qY3r0LM0MNA9d2Z+HECd
         CKZPAbK4GWVibXEnqnDUUZWgxqRXF+UhbHc1UwUqZ2RcmpS3sKR3hNAZWjqW3Tf4rY5r
         xKx5Sx0bEwJ+biS4q0o30JqMBKnknwRNMSKXzp0u/Lm5Phm051jm8coTAY0Er9dIvt1I
         ux8PzLVl/Q5dVcbPQltfSaUkJ0w1Vl2uPTuoh1IIVdvZX7qeDLXYz+DbUE6XEwl75Nfe
         ke6GhybRK6KsnTm70n8XlVsFIzqVAar7Gf5PNZ4C1i9JVr77laq2GOk2ehAoR3kHA9Ed
         OgMw==
X-Gm-Message-State: AOAM532B4aIyiHTjqrmbolG1dPBw6AFAp1gCeuqUav6Fq+9wwrcI/zUl
        U8GQNSjts3HWJDpfAY0azCE=
X-Google-Smtp-Source: ABdhPJxpo8w0ctRYLM7Y3Ez4SuaFdPLD0thnSTDALCDykXMngVUPWd24MbbLDmsgL1ejg2nXftBU/w==
X-Received: by 2002:a17:90a:db15:b0:1bd:71f:8123 with SMTP id g21-20020a17090adb1500b001bd071f8123mr6447357pjv.126.1645907407816;
        Sat, 26 Feb 2022 12:30:07 -0800 (PST)
Received: from [192.168.6.232] ([106.198.46.231])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm8004821pfc.99.2022.02.26.12.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 12:30:07 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Community <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <742c7455-8f74-ac03-350a-7c3851f2b792@gmail.com>
Date:   Sun, 27 Feb 2022 01:59:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfGpjm8mCkWIPM6V@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 27/01/22 1:35 am, Taylor Blau wrote:
> 
> On Wed, Jan 26, 2022 at 11:59:16PM +0530, Kaartic Sivaraam wrote:
>> First, are we interested in participating in the 2022 round of
>> GSoC?
> 
> I think it would be great to participate this year, provided that we can
> come up with some interesting projects and mentors to help out.
> 
>>      Taylor showed interest in a bitmap-related project during
>>      the Outreachy application period [4]. Taylor, are you still
>>      interested in mentoring a bitmap-related project? Would it
>>      be possible for you to do so for the upcoming GSoC?
> 
> I'm available and interested in mentoring. I don't think I found many
> interested folks via Outreachy who wanted to work on bitmaps, but I
> think it's worth trying again via GSoC. I can rejigger the proposed
> projects there a bit, too.
> 

Thanks for adding the ideas to the SoC-2022-Ideas[1] list! I noticed that
you're the only one mentioned as mentor for the idea there. It's usually
good to have at least 2 mentors per project. Is anyone else interested
in co-mentoring with Taylor for the idea?

[1]: https://git.github.io/SoC-2022-Ideas/

-- 
Sivaraam
