Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F7C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiGGSJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGSJP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:09:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C711DA70
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:09:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z14so19986046pgh.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M0+MZB1O3axp6XqPFqk6Iz+U5W2OF6gKOGVc7QXFGZA=;
        b=n3kimv9LRXDA+Yt76p9voi7v7X4NPC2HI0DuDcN+S2mRFbaTFaFEughq61qgFzfRsr
         d0cLk8Q0qpI++81xpn/a8EepRW7ARBrlIvByzaItOtGCnInB8egxlA2j7UMZUITmMZ1b
         S3F2JGvnYtWCMVacw15NehTFbytlrlkJ28uIP+r20IMHow+IezYwE1s+mYufZmNz5JM2
         FwbZpylSrbYZJu0KMxzTfnm4fjefP5m91ja8WhKobA1MxQrRBKTyedoFkOMGUYQkfYWk
         ntQGLYTFZxsl8RwLf2v5amVdmXIKux3JbyUvboqJ2FpuHbH6Q7pBxNS5LsBj0xY8whWo
         0quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M0+MZB1O3axp6XqPFqk6Iz+U5W2OF6gKOGVc7QXFGZA=;
        b=4CsY0XF2K8mEsYIy25myUR2U0kPWibQi4r0XYYngy2oL8C2mX6iMKMVsinngcPDN+/
         QMU8V40/sYX/E+6oRnY0yAbSImFpXiA9aGCAVzxm4ynoYqrvDRpIatzd2/Q7y+EA4PVY
         pjcJKARZaxKuIC6E//NuE4vLL90exYg+3pK8WA0m2kILshiTiSooClMJI5BsRmmRhvcD
         WAxYhWcLhzK2UpFMuFHUFfBAri6GcTX9/hejdv49z7eweXYNTNLxsqdWaUVabs+C8rGc
         +2b5xCMP6gTk9dt/Ey2Ef3DeZVzvz0Xuc+tXB6Hmcbi5blmSYuvdYZJgTe6U/XzPv1ww
         FDqQ==
X-Gm-Message-State: AJIora93UShRRs5zlFgwHno8iQ8HZhKWfaSO1lQIxbxjRdw+nLw99OEy
        n5jVTqhAhDCpAmh4PWuOIhrBD21Niao=
X-Google-Smtp-Source: AGRyM1sd8YgRY9zU5UuvMTAv3EgcD9wE6i9c3YIP4SH7/Eilj/EaRyEMDXhru+QA3BbmmnQXvI3VzA==
X-Received: by 2002:a62:1891:0:b0:528:5d43:c3ab with SMTP id 139-20020a621891000000b005285d43c3abmr26867948pfy.79.1657217354253;
        Thu, 07 Jul 2022 11:09:14 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.131.20])
        by smtp.gmail.com with ESMTPSA id by5-20020a056a00400500b0052521fd6caesm20098660pfb.111.2022.07.07.11.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 11:09:13 -0700 (PDT)
Message-ID: <7f7e8d91-47bc-ede4-a552-2ddc9fe98a1e@gmail.com>
Date:   Thu, 7 Jul 2022 23:39:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table extension
 to the bitmap format
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <xmqqiloagi80.fsf@gitster.g>
 <20220707084818.79881-1-chakrabortyabhradeep79@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20220707084818.79881-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-07-2022 14:18, Abhradeep Chakraborty wrote:
> 
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>>>  Documentation/technical/bitmap-format.txt |  39 ++
>>
>> I haven't tried merging it yet, but doesn't [1/6] overlap with and
>> semantically depend on your other series that touch the formatting
>> of this file?
> 
> Correct, [1/6] indeed depends on my previous patch series[2] and it
> is assuming that that series has already been merged.

I suppose it's the opposite. A quick check shows that the patch applies
cleanly over 'master' but fails to apply over 'next' which has the
changes from your other patch series. So, the base branch for [1/6]
is 'master'. The other 5 patches clearly don't conflict.

> As far as it seems,
> it will not create any merge conflicts while merging but I am not sure.
> This would be interesting to see.
>

Since the first hunk of 1/6 and your other series touch the same area
of Documentation/technical/bitmap-format.txt, the changes conflict.
Junio might be able to handle this one. If not, you would need to look
into separate 1/6 and based it over your other series to avoid the
conflict.

--
Sivaraam
