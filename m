Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79FC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiCBJ32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiCBJ30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:29:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74262C111
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:28:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso1259504pjo.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=LxjKWHVafcvguU6Jtd3ORtp5KWuQXMPVILFGhvTam6w=;
        b=HCbWDsKYFqK8hJlKNqSeF0IeUEx0wD5fRsqdvvU/IuVVV5o/h89il9s5thqL+Vht1G
         PP/HfBKEF4lYKB1IFBrnfBtoKFy1WamHk+VLa9Xm8PNuSdCWNMPWjxeTI3poLtp3WTLH
         Beh2AiSFJwXD06ZV8dGKKdtrTMN4ezfGoyuJnYQ9417KruSFcW24ihYkmXZzwp4k+3ZI
         rbTR+bOWYa2jp9ypM94EMjmqQWzezWFWQnkpuIXKP3AV57jHX7GghrVbJCwct/45bhXT
         QU/PVijuqzd9KOKnlXvBCszNmiEVVcEhb2pMtxzPmlNxi6zgIU672F3iZMloZaiLiXYU
         9A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=LxjKWHVafcvguU6Jtd3ORtp5KWuQXMPVILFGhvTam6w=;
        b=75XFNky44YCIaSvfG2XCcxp3nRwrhA94p4CLS8f3RDMtFi27h78RJXNTBh6vJ+LV7/
         tyILOPO4unOcpeIBwjVpunlYF/KprJfz9mP9eUq/RXe90UhXZhYrH414ldAGd1nHvWt4
         6Nd6HsS/wbRZA/e8QyfyY3DQRJLvfJMmVJp4htrzwJbZUD7tAFwAO49C0CIAMKeiLzbM
         7Ac5MBMDk+DKS4Ut11S6wJKKbYyVL+xEnKn5BN/12GzsaVxr9UeZZ777oeCaaqaIVgTe
         XR9Z8MOc9YqZhkzpO0NAzG0HLNxBekfJ+1RfhOvKiJImmfYZ7f2oQP/BboKMVCq9a6Wd
         IWUQ==
X-Gm-Message-State: AOAM532YFeGsP62p9gtZzMY+2sh3BqnmKYFiPS27DJjRrvZvczLbcR2D
        +b4AP+HDqCoNG8yn9Xk/VxA=
X-Google-Smtp-Source: ABdhPJzq0/Mkh+mzgZAbe3MTHA2Rr1QkT5EiCFQiHTdSUHEqefw5ZougN6unx8ffovWwBDXJVEhhUw==
X-Received: by 2002:a17:90a:df16:b0:1bc:46ce:636a with SMTP id gp22-20020a17090adf1600b001bc46ce636amr26126839pjb.155.1646213323429;
        Wed, 02 Mar 2022 01:28:43 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id 142-20020a621894000000b004dfc714b076sm20752512pfy.11.2022.03.02.01.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:28:43 -0800 (PST)
Message-ID: <e3996526-e3c7-7126-e8c6-4868c8e07f27@gmail.com>
Date:   Wed, 2 Mar 2022 14:58:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     jaydeepjd.8914@gmail.com, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-2-jaydeepjd.8914@gmail.com>
 <34a2ad39-604c-4edd-ea1c-de1212fc506b@kdbg.org>
 <f16cf3aa-dbae-8645-1d59-a8d5639d22fc@gmail.com>
In-Reply-To: <f16cf3aa-dbae-8645-1d59-a8d5639d22fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/2/22 2:39 PM, jaydeepjd.8914@gmail.com wrote:

> `0x0F` indicates that its a hexadecimal literal in Kotlin.


My bad. It was wrong. Hexadecimals are prefixed with 0xFF. I will fix it.
