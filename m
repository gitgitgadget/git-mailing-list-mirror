Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E573C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiBQRSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:18:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiBQRSw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:18:52 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743CF2AEDB6
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:18:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so239415pfv.1
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgHg/g2GufuqsoIGMEb7kjhqYz16FZPT8Wuru2l/eSY=;
        b=KbKdZWt6e+ct8skre5cqZ6XkPNV6UWC7gak2ZtbQliWIdYjARpR+BwGXd8h/dCmxlA
         vJXKOny9wMoelgrUQ/xBPVJ249r8ryRzk07vN8iVIrQDIHkjfhl+0h7iOENij+H+6Dn/
         YIRpUe3JE/aR46ZTRVC/v5k9hDmP9HP99mZ27pLTEwRgG03bBMXvzK8/4XR8uXWhc5jR
         iWiHvXrcL5S+qoHJQQiP2tnP7v8Ut0e+aJ4xmbVgd1QaLd8L8kZ5O2U1eYuNfBF0K0+j
         GqQWGfhU913ylPTvg/zUVt6PS4Xp2HZVqU4PbkDjuNvAKtlakpGvJL1ZSYKRZyNyXJ6e
         D4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgHg/g2GufuqsoIGMEb7kjhqYz16FZPT8Wuru2l/eSY=;
        b=NSLwkK7j1k7fihPWAh1wej6XnNEBDfQgEJm2n4Mctlu5KP2xH59mKtzSTM2w+1Ju/w
         AoWwW/75zICdFAdkqmg45DQwALg8bdvWuvgiD2ErlAEtqVXJRzOxnoAKnYZF3m0E9BOr
         J0A6eeX93kzD7ip/MMU9uMskiwpkGbNpoavMQUU/Gosy5VmWUahhSllxCShOHb6Zp6AM
         onzu8b2ozVmULV6t4i8NSH15oSGFfUPtDCSbMSqlXE4/ogC6QkJAQbTxgl0Odqav7QeU
         4Oc1OcdQOxYPOu1nRTIZuFRlwz3wdqrkHBkYkCD9F9Oa5MxpKu+nadAnxZTagA/C7vbl
         Y0MA==
X-Gm-Message-State: AOAM532Rt1pZXHWH+4U5ZcNsITPfxpd5EEMtIo3gdcAF1sGYhs9FNKek
        UJ0Sr68ojMHWGPNW/pB20n2mTT12YgY=
X-Google-Smtp-Source: ABdhPJyopWQcw6JZTQ0DXm353gNGIA16/0TrRFefaDaAgljecVByY3xGt5RQeDU14TzAbdEgVo+uoQ==
X-Received: by 2002:a63:d904:0:b0:372:9faf:5467 with SMTP id r4-20020a63d904000000b003729faf5467mr3201581pgg.196.1645118316899;
        Thu, 17 Feb 2022 09:18:36 -0800 (PST)
Received: from [192.168.133.232] ([106.198.41.176])
        by smtp.gmail.com with ESMTPSA id s6sm181166pfk.86.2022.02.17.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:18:35 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local>
 <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
 <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com>
 <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <0a29bbcf-5c36-3884-96c6-60f9b930ce5f@gmail.com>
Date:   Thu, 17 Feb 2022 22:48:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/02/22 9:10 pm, Christian Couder wrote:
> Hi,
> 
> On Wed, Feb 16, 2022 at 12:18 AM Hariom verma <hariom18599@gmail.com> wrote:
>>
>> Hi,
>>
>> On Mon, Feb 14, 2022 at 2:59 PM Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> I added the "Unify ref-filter formats with other pretty formats" to
>>> continue Hariom Verma's work during GSoC 2020. I would be happy to
>>> co-mentor it if someone is interested to co-mentor it with me.
>>
>> Since I worked on this for quite some time. I maybe am able to provide
>> some insights. If it's not too late, I would like to co-mentor it with
>> you.
> 
> Great! I am happy to co-mentor it with you!
> 

Yeah. That's great! Hariom, would you mind opening a PR to mention yourself
as a mentor in SoC-2022-Ideas.md [1] ?

> Kaartic, I hope it's ok for you.
>

Now worries at all. I'm actually glad Hariom volunteered to mentor as he's
more appropriate a co-mentor for the project :-)

[1]: https://github.com/git/git.github.io/blob/master/SoC-2022-Ideas.md

-- 
Sivaraam
