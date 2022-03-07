Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8ADC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiCGTvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiCGTvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:51:52 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D480918
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:50:57 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so19218068ooi.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ivaUpWlr+ZQl1XdotyjBIP6IPTP+iMPwv89SlpVehLM=;
        b=GUGFBsM0kq01BBq6jJ512zJfh+mxtSFtD6RnNA5K3sC0Py6nbhfK3KYdFgLxV49rb6
         50LRLLFWuI3OSZ/SPu8rhYzvZyw9ZcDWyupES8NjEusISCiDiJVplUeWSL3HHPXF483M
         /QeQtWVgd6S7Mmol9tlZIBkUNUPLqd1AR4jMk1tUWMTrAAgJtJWFfX85dwp37N07eZYZ
         3n3KZD1CIZl+OWqMIQ48OYsguFuUI1hv0n9Vh8+P+8qtiaLcl0FO0VfX5/qKJ5/uj7FK
         axAjL/g2LDM0L0Nj4YOwFd/NzipOxfKPADlCcjWywvHvbUXFNRZVK0a+yfpA77+vdW7h
         ngWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ivaUpWlr+ZQl1XdotyjBIP6IPTP+iMPwv89SlpVehLM=;
        b=OHe83JTaiocV9D5V2n3mGGHIqPxVLBBe9Kt1iqJd2k0LFHVH7PwTUTgg4MDkXciPBv
         tKHYJVIh8RTUxfrz1dg08EandIYKNwz/pMoyY6s2ucT42qEcZiWZzdN9+eO8JMTsMAkp
         LKNDynS7VX6W7KrdJbdxkiyXxGs5/y+spUiynJh6Jk8+CB9+dyMgPUn4O1fHXvX5vMLE
         Jfbuv1Klh6jELucjVt+/DBMS4A265l0Kt8Y2KFnvdEpc9P1HAqjh4kBzPCrhEwsA69zn
         pZ1kboU3xIM+sXLJMqpvS9moN0I9qDduD8eXhgbdrGpiJI3QNEsfUeTSXankgzbLv3gj
         JuHg==
X-Gm-Message-State: AOAM530AG7/kR3Rmm6SFANbOipVVB8CHmLWDIJQDJzboujrJ9AlXDu7c
        HN+4MzhJioMxs5ZBANtzJdfJ
X-Google-Smtp-Source: ABdhPJzceIN9cKQHqiKjjGSqSvzAD74SXA6Zze8LBjY6+/VRkOLmx5xuvLOvPYn+85NDtneX4IEURA==
X-Received: by 2002:a05:6871:87:b0:da:b3f:3208 with SMTP id u7-20020a056871008700b000da0b3f3208mr371579oaa.184.1646682657002;
        Mon, 07 Mar 2022 11:50:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o10-20020a0568080f8a00b002d726c76b77sm6854275oiw.15.2022.03.07.11.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:50:56 -0800 (PST)
Message-ID: <e1b59df0-2ec2-2854-7c53-b1a57bd157c3@github.com>
Date:   Mon, 7 Mar 2022 14:50:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: Git in GSoC 2022?
Content-Language: en-US
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <CA+ARAtquQOtcDtc0nCWkxyP2enb_QbxyoK9b3HWf-2JzbaKbkQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CA+ARAtquQOtcDtc0nCWkxyP2enb_QbxyoK9b3HWf-2JzbaKbkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 2:38 PM, Kaartic Sivaraam wrote:
> Hi all,
> 
> I'm glad to share the news that Git has been accepted as a mentoring
> organization [1] for GSoC!

Excellent news! Thanks for all your hard work on the application.
 
> Since it is possible to invite mentors now, I've invited the mentors who
> have suggested ideas[2] so far. I've used the e-mail mentioned in the
> ideas page to send the invite.

I've submitted the form for mine. Thanks!

-Stolee
