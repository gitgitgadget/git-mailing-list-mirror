Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2BC001B2
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLNXuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLNXuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:50:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741ED37224
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:50:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g10so5063088plo.11
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CcerAEouZbaGlGwbUm6i8+WPauuetOV3EawpVEs5gY0=;
        b=G355PWxZl3hqjqywRQJNY4ugcL3gOHoUJKPzottWMjCyO5r65brOioSCh3HJb1pIRq
         q13R8xyWLIBp7wOvrs1FnyFm3SycVajq138W9Za5IlsbZYnCviywkZlYj1tDyAUo1e88
         LJh1hD5lTn/0sDGdgRRtAg9B27K5vWXXQ1lbLMAOV1Zy02Szv2zcl6BBp0/dhd68EiGi
         0R1YUBUMmd76XbYjJtXUeHykdSCkUsx1HCLU8uRh7+lisHtXXcnlgG40ZlDd/S+d+2zR
         NlOFgmOhkUmW+0OXHp3dFVvqmJe6zExS/btriiOwqajJmelzrbJMphKQKcQIyXfm/62W
         vUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcerAEouZbaGlGwbUm6i8+WPauuetOV3EawpVEs5gY0=;
        b=OH3CQSKLu0uNVTi7dEhKW7rbaGgE1yu1GOQWYwv4zd99koMivTiaULJdu0DQimDA4T
         ZkmMg+J3CRG/advZ35A3kc9iW/xcXJX6oLT6D85JMwb+D+Tc/2UVgXnDwiW2VAO8id4y
         zVXuo089Txe9LbVTrm9I757lw1hzjKayO9Vh01UGmkEuaisDL93st3/1awva44aM0J2p
         NS7x08eMHe/hC4GmL1tOa8ysZNdHYYkF5qeBc7cylfzop3yadgK0dCNXJux7+p9Dd3AD
         2MMG0duDqEioBi6eE4NUoh2QKCP13euJi5vm5GVwQHkw+7SpIFHKr4NSvGdnP7Tqi4Ix
         fouw==
X-Gm-Message-State: AFqh2krrqsdbGQqsh8HD0+Znp4JkgMLyep2gEHXZO7ZdTypi0BHT3E9B
        gLzzQQoFoTH4OWnf86EwjB0=
X-Google-Smtp-Source: AMrXdXtiZTrl8Rldexv5XiUbivhg+A0Nb6puQG3n1rT91iqTnQGJ7yA0/B4O6AUXkqGDdNtde6+HdQ==
X-Received: by 2002:a17:902:b201:b0:189:ea4c:e414 with SMTP id t1-20020a170902b20100b00189ea4ce414mr1604141plr.61.1671061812915;
        Wed, 14 Dec 2022 15:50:12 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b00189c26719cdsm2370774plg.272.2022.12.14.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:50:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
        <3fc9fa4f-9904-61a5-2b06-465e184d7c15@jeffhostetler.com>
Date:   Thu, 15 Dec 2022 08:50:12 +0900
Message-ID: <xmqq359hv93f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 12/14/22 4:59 AM, Junio C Hamano wrote:
>> * jh/fsmonitor-darwin-modernize (2022-12-05) 1 commit
>>   - fsmonitor: eliminate call to deprecated FSEventStream function
>>   Stop using deprecated macOS API in fsmonitor.
>>   Will merge back to 'next'.
>>   source:<pull.1436.git.1669991072393.gitgitgadget@gmail.com>
>
>
> Stefan Sundin noticed a typo in my commit message:
>>Typo here, MacOS 13 is Ventura not Ventana.
>
> I'll send a V2 shortly (and it will include your paragraph
> about Apple and deprecated APIs).

Thanks, will hold.

