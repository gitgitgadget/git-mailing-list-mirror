Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9EAC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 20:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiBOUcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:32:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiBOUca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 15:32:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC44D64EC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:32:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w20so76996plq.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDxwzmv/rULkGZ/4zM8P5/AZarjI0DCX9KCwJyiYLKk=;
        b=NC4h3tPAf1pIfRMg739+A6qjCK8dRQ/PfFQHG4pRzufR0/pqs7i5qBuS+tui99qLVk
         FMQ4s5zLPjnP87E/Y2mQQoNjGBupTACA7LXlYbQsyqzSVKnmH2O1P20AuGA1CJ8gVnoB
         WVxAGbYodp3HtvMukK0lnAt6Xq+VVUWuhhHhkjN+wVoToS6wtdap9wBHJkk3xAer3FhG
         okeZiuWKNa3MrUPigjrfU9fV0LTco/TT/TPjol6Q0kv8YbuJdeUOA4QGk4cZIZVa+PBD
         TBuJoSLwb3BrN6Heavl4fBFbO2Q0Te86FDufk4IBk+fbae8Ug3KkvlxGjfRriRFkl4P1
         3QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDxwzmv/rULkGZ/4zM8P5/AZarjI0DCX9KCwJyiYLKk=;
        b=hrbDYOTfJGYmvEztyE7PsrfzRyOFNC2R+ttGNLUXCeXFf90QVBsIZ9OyM/aGu/5ZJQ
         L6FrTInehP8efUsdFM8MGA3QBc8YXbq1l1damHjcyrFgJRQm30GlsnOq1ciTMssyz/hL
         D51Zpw3KR3IMS7OLgW87MeBv1tTERMIhoO0rDq30X9eHvIN80qPRF5TADwp66fUALDUF
         uduhBaS/V3gMTvrC+93qYoZz7n7bHE31TCxhtdPTU6BhGERCvVmH88ONkcsPMyYszljc
         1WH3sCBZPhYeFeMmSCTDW1njd9Db9JZcUP2z0TxP12kQBG5hkvW+E6pn9EdWTHzpb++y
         BSWQ==
X-Gm-Message-State: AOAM530ue1mrM6/xlLm3iXrs9VW+KvTzzpyEosqQ69HIU148oZMvohi2
        LVDRd2qeM9lz1zE1c5NWsEI=
X-Google-Smtp-Source: ABdhPJw4vcRskWKvBGxqCsYr6LbAPXOAyiJVr5Uz57IBhabnlYSOvkmhJ+GFk/UaRAK+NpoFbRRxGQ==
X-Received: by 2002:a17:903:41ca:: with SMTP id u10mr761526ple.69.1644957138678;
        Tue, 15 Feb 2022 12:32:18 -0800 (PST)
Received: from [192.168.133.232] ([106.198.32.168])
        by smtp.gmail.com with ESMTPSA id 84sm11985120pfx.181.2022.02.15.12.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:32:18 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.email>,
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
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <65abccbe-eaae-5d68-c738-b7f9a3844bbc@gmail.com>
Date:   Wed, 16 Feb 2022 02:02:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/02/22 3:03 pm, Christian Couder wrote:
> On Sat, Feb 12, 2022 at 7:12 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> 
>> On a related note, the organization registrations are now open for this year.
>> The deadline is February 21 - 18:00 UTC. I'm not sure if anyone else is
>> planning on applying for Git. In case no one else beats me to it, I plan on
>> applying for Git around February 15 17:00 UTC.
> 
> I was thinking about applying for Git, but I am glad that you plan to
> do it. I will try to add some project ideas to SoC-2022-Ideas.md
> before February 15.

Thanks for adding it! I've applied for Git in GSoC 2022. The application
information could be found here:

   https://git.github.io/SoC-2022-Org-Application/

Let me know in case anything needs to be tweaked. I mentioned that we have
5 mentors available counting Stolee, Victoria, Christian, Taylor and myself.
Also, I've invited Christian as an Org Admin. In case anyone else would like
to volunteer to be an Org Admin, do let me know.

On a lighter note, the application structure was a bit different than
previous years due to the new website. They say that it supports persisting
the organization information which should mean less work while applying for
GSoC in upcoming years.

-- 
Sivaraam
