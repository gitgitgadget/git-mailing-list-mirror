Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62452C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiBQR2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBQR2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:28:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD1F258456
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:28:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y18so5101033plb.11
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoj+BLLOVXGRhEWl8c7hTlNfIiqaDbSvF+yC3v3XKu0=;
        b=eJ3cnzF0HWMerWf2+0VVLKTjPGDJfF9fpwmDkaQPFRCF+pIE3JHu8T8N8aoG5jD3mP
         biYpiicNDMpTRcyvWnO/D2u49nLxsOo5cksQN5XM1BMj2EjVvEV3zsQN2uxsi70UyzIq
         fGes0pWEaJyvj5yjoDTWCmrysO2EZud7pEBUMOKXlx1HRsjpZ3Vk2xnYmcZ9DyidyKWj
         kByvp1BOyg+GY1vfky+6wFcEXAmuHBusfyXudm+dkdAvtdu8vrMyu/jq4InHsIJLbdL3
         dvBt9thbJw8wH+4fXaM7HvE97mNWILQwswr7EtAebMQHBOG71ciHxRhwCcvXScBvzz7+
         MAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoj+BLLOVXGRhEWl8c7hTlNfIiqaDbSvF+yC3v3XKu0=;
        b=waKMGiFECNnLX0CIXchjzS3GtWiiISZOXZqx43nA2HqYwuHF7yfAKMS768zHHXDWRf
         74geH/RmhXS2CzM5oFZh6aPwb7k0x7eGO2p9uhOo0D7L3a1sH8KCes3xRRzI3kHEn1bA
         gnKOnNO3nzUWfz+nyfGeiD5mGio2HXcOz7afu6j6bATg3omLlqHNgirg81NV+Fkc93Z4
         8J+yok3wsHLd3fgElWpJhRh0Giz+lK6uWaYHGnQGA2vSC6NsSTZ/yaC+JL76FuL+84O8
         DCeCOFAy6UEHjrG4N6pXIg3+MZ7Eo28qd9GU337D3yQy1XDQyJ6W9n+vCQDlaMQPUmLT
         qG9A==
X-Gm-Message-State: AOAM531nLWnzQfKgKbW3x8ssyp5H2GcxOKwiUsLPYmBTCH6JheHSz5yJ
        FSSjlewCVYhW+RG11kFUUIKUh4XjjUU=
X-Google-Smtp-Source: ABdhPJw6i0RJP3gBwQpo42JPQN/Ab2QSNYHZfQormp4p+6zK8ZdkQPfcFDU1rZjnaGNQ6ImTiq6ApQ==
X-Received: by 2002:a17:902:834a:b0:14f:3337:35de with SMTP id z10-20020a170902834a00b0014f333735demr3863879pln.8.1645118907233;
        Thu, 17 Feb 2022 09:28:27 -0800 (PST)
Received: from [192.168.133.232] ([106.198.41.176])
        by smtp.gmail.com with ESMTPSA id p4sm8711736pgh.53.2022.02.17.09.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:28:26 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email>
 <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
 <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com>
 <65abccbe-eaae-5d68-c738-b7f9a3844bbc@gmail.com>
 <CAP8UFD3prsevU_8zCXQu_BpZH+NHm+HD04RiBvOXkZkDoi+yjg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <5193ddc5-91d0-7fa2-dea9-32c28d7f0e2f@gmail.com>
Date:   Thu, 17 Feb 2022 22:58:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3prsevU_8zCXQu_BpZH+NHm+HD04RiBvOXkZkDoi+yjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/02/22 9:25 pm, Christian Couder wrote:
> On Tue, Feb 15, 2022 at 9:32 PM Kaartic Sivaraam
> 
> Thanks, I accepted the invite!
> 
> Not sure we can invite possible mentors yet.
> 

Yeah. Inviting mentors isn't possible yet. It's possible only after the
org application has been accepted. We'll know the status of our org
application by March 7 - 18:00 UTC [1]

[1]: https://developers.google.com/open-source/gsoc/timeline

-- 
Sivaraam
