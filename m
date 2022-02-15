Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FAC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbiBOUfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBOUfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 15:35:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A8D76C2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:34:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y18so85741plb.11
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+8SDKzBvPSnZEzvspKX3BO2tlk/4EqZxU29S2KdXGw=;
        b=pD1JjuhsemTc5nLZN8O2UKWeHxip1gvr7C8XhEyS1NFGDyEOnojAoYopvhaaSh9SeK
         6oWwFbX/QO1wmQWfcv+GP+fjF9ZD+92JCbOeQlBaLJMaeh2qTB/XrPsaFG4XtTxG1LuL
         SSAVKDdRKSDZs3MCrVkwdbNvdLXi8ZjaFlz5z2M0+G+DkI0D/eDgsLe9Hdb9V52Hlv3V
         NX/K5K9G2AOpH04xI3gaRbTk+s2HmiUlcUtePjM4Sufm/muAYL52sX89dOsbiFaz3iVf
         +8OHLzvlmUtSO7fhyMbMWfzhod6fYkQIe2ntea/edHuFj+uSgMEy8FHqBSGS7g6q66MU
         h7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+8SDKzBvPSnZEzvspKX3BO2tlk/4EqZxU29S2KdXGw=;
        b=ItxsCg3lDeqrPGkn63kBSt+eNqnYcGMn3k2oC7s6HRq/u17Pa3doUrE0mD68lj3EqM
         thOflC0lgHNCuBRcqh7ubnenS1WdLEK531T+vDt+R4zYbvMxQoXoIWQlbz8IVxVvy2UG
         GGEwfP2+xpzy2syj/K4h/ekGKI1OyVI6yAgfNHxrvb7CTlAKbBw8uCLLQUoDeKUW/KdV
         cll2Oj4V2J0Qk0t12dvPqn9FhdW7OVbDt7R91rtR1D6ZHXK+g6Cyc1gY36lzaDooDNWG
         EbbyqfBYpV+ECqt10byQu1qMuqex/BuOodjMiczUVrCaC5w0Z9sor/DzhkeRyMxmCX4d
         lghg==
X-Gm-Message-State: AOAM530YZR5V6Yk/t4mz8IPeVywg223Oz2ySaK7IFE2TmBZAqKQuQ31h
        SZ0nMr64Uj8tNYMaGjjak8sV7O5HCY4yUQ==
X-Google-Smtp-Source: ABdhPJzsvEs6oigOpxrtD0hhWDaW/l41q/WBePuwxCErpbHFSrDCi7w4p0CUtAfTxacW1Y+ZDhcEBg==
X-Received: by 2002:a17:902:7442:: with SMTP id e2mr622881plt.104.1644957296361;
        Tue, 15 Feb 2022 12:34:56 -0800 (PST)
Received: from [192.168.133.232] ([106.198.32.168])
        by smtp.gmail.com with ESMTPSA id d22sm40397891pfl.71.2022.02.15.12.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:34:56 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local>
 <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <01183a76-24c5-4308-76e3-953a0b76df67@gmail.com>
Date:   Wed, 16 Feb 2022 02:04:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/02/22 7:05 pm, Christian Couder wrote:
> On Thu, Jan 27, 2022 at 10:32 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Wed, Jan 26, 2022 at 9:05 PM Taylor Blau <me@ttaylorr.com> wrote:
> 
>> I am also available and interested in mentoring and I can reuse a
>> project prepared for the last Outreachy round too.
> 
> I added the "Unify ref-filter formats with other pretty formats" to
> continue Hariom Verma's work during GSoC 2020. I would be happy to
> co-mentor it if someone is interested to co-mentor it with me.
> 

I would be willing to co-mentor it with you. In case anyone else
prefers to co-mentor this one, that's fine too. I can leave it
to them :)

-- 
Sivaraam
