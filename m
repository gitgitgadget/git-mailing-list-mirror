Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B451F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeFGOGq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:06:46 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38182 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbeFGOGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id x34-v6so9940967qtk.5
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AJ3F2GH8aeLUly9X9ggfF22oWGCRNLsfHCQvpWLZlDY=;
        b=sowhdUmleT2HuG61WBRUXGO69OtZqlpxM2NydVXiyYDQ2hA6cu6yrfeMvwHCNDKCdX
         18QlYP99gev0vdEMWpPt8cBp7JT72xSvxlYwSTc9NKGKElnSD0BLZOgv6j3qxM+a8GKY
         GE9XLHaqRueHoDFIvvUHcsuq+H/7qaLUpNZwM/cgzu5kuRzU7HMBVRDQohC1fZgvKkdB
         8lx5+OnPu7i4aNTQzlx2f0/9RikvU8MIz9PmoqVL+gVndTHFPeKv/MsArPMzi8jdxd9V
         DA0HFXx+qevUWP5DGsXWhkYaa02CNrJTUgqP8QRVbTmxIbsVWSJoeHakUzEHqRAKpVy5
         GXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AJ3F2GH8aeLUly9X9ggfF22oWGCRNLsfHCQvpWLZlDY=;
        b=e9IwaLf71fCOrza64hwWoaWx1+UT7Y68VgpBIDTq5GABYcWC+VdtijFkPXu1plVI06
         mvn+ngEYmdlknU4+B/ocsg0/Wq4/9vkQ2Hgx4cuWJmHLxzRQV9cqUZLBFnuIfaiGqSd9
         Ex1ueCRwlmizKZxqlOC+FQcUkD5XTZOg1kyHjChGLcDGpuVFbfOY1ADff9DbB6lC974W
         QvoMDtaovdfe+Fbq8d7gEDRjhXhkwtP+dqrmsEYNUo8MMU9RewqrU5vR0HhMqQXblihS
         8XdQZ2bkJcXr+y7qN5XCh089GtQZFJsNCLxRXoqs+tBViewjiBRvHeIv2Jo2YS4mB7oq
         7JbA==
X-Gm-Message-State: APt69E2I+Cc9u8scfjySILMq4WSjP3BMS4zNpnsT6MEQ915dZbTmzNWP
        K/R/j0/1PqP2aMVswXffMUo=
X-Google-Smtp-Source: ADUXVKK5J1MqnI60I+NFUwU4YUW22Q4ujKODL2PJuCX/zawLNTE0fKll2ubfGH0ISvI0t/DgkI6uXg==
X-Received: by 2002:aed:3f36:: with SMTP id p51-v6mr1814397qtf.213.1528380403868;
        Thu, 07 Jun 2018 07:06:43 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f8c8:bc46:d69b:91c2? ([2001:4898:8010:0:e1fe:bc46:d69b:91c2])
        by smtp.gmail.com with ESMTPSA id a80-v6sm10026918qkg.43.2018.06.07.07.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:43 -0700 (PDT)
Subject: Re: [PATCH 00/23] Multi-pack-index (MIDX)
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
References: <20180607140338.32440-1-dstolee@microsoft.com>
Message-ID: <e4542116-f48a-c5c2-de8d-74c53de46ae0@gmail.com>
Date:   Thu, 7 Jun 2018 10:06:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 10:03 AM, Derrick Stolee wrote:
> This patch series includes a rewrite of the previous
> multi-pack-index RFC [1] using the feedback from the
> commit-graph feature.

Sorry to everyone who got a duplicate copy of this series. I misspelled 
'kernel.org' and it didn't go to the list.

I also have this series available as a GitHub PR [1]

[1] https://github.com/derrickstolee/git/pull/7

