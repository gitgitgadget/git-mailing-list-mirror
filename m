Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1845C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 05:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiBJFwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 00:52:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiBJFwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 00:52:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED81D6
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 21:52:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso1100899pjb.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=RjBRN/6+MIrxK4BcLmwMfXcrML27XR8CscCN6rCXPNY=;
        b=eUg7mEPJF90Dw/Yx2K6xnWIE3+C1huWo8r/VJkzQuc0h9ZeUftJlcK/XN3pF24ATrP
         elBpx8tM9aU6ZykVvTjTlYHvCm+iDx2e1keESri2A14hwPFyh5cEi58DVARgbrCGnbZV
         Vpe4akYtrmxo6mbCptPAzDA8cZQPWrUh8pl1ix4vTgpGYjTR/L7sPBFeHWzLc4017HCY
         4OZlT+enkxI5JFBVjPAs2FncCEjeCvql9NuZxzP25jDsuGOUc0tjbViPEdFcvuSjmYBW
         UXGe48XGiiqoLXci/SwBM57MSUOqIPFNzd8peWdjRWsCtiDGulIktY148SoWa1yxgdWU
         0iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=RjBRN/6+MIrxK4BcLmwMfXcrML27XR8CscCN6rCXPNY=;
        b=KWXP+gqJ//SOzzhoLOoad7XF7yKjvh4BsoL0kcbuneKiIa2mT8+zjIT6DppCL/Y7xM
         EvLfOgbhy7+aWz+tBGMbVjLot0J55b/JNyL928H2hFVuZATt/ijwxhu2vomgVhXfn8bx
         TdwDnmCC+i5Iliwa4kHFdsv/6U6U9SCEOtzGbysSlkdhJf2CQo0IX6pdU4uLThI6tRes
         SRZP77qwOCAE7E6sMgxb9Rx/mRRIUJDVLciZ31NK5FpqhI36YpwbXEtqDJknc6FMIOef
         xU/P+b9SHdA7JIoh1EFUYIJZZ6FsAU7RfEFDvkgMlixFXnnpZcH7OORF22eBnBvsdYdp
         /lNQ==
X-Gm-Message-State: AOAM531A3nptJLEOhAVyvukeBbldNmB1n6w12bXwtStn3cBDbkKz6DKQ
        WjsbMKPpVIOseg67vffub20=
X-Google-Smtp-Source: ABdhPJyqb3YxkZ1z9Ra+wpHtyL60qFHztvCNVckO39bkPdQHaz7H6tij8/uUfVWrYlaPeGX68/CeXg==
X-Received: by 2002:a17:902:d48e:: with SMTP id c14mr6058776plg.129.1644472364319;
        Wed, 09 Feb 2022 21:52:44 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id v12sm15001698pgr.68.2022.02.09.21.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 21:52:43 -0800 (PST)
Message-ID: <c64e52e1-3916-dc7a-60d7-98c324814f0e@gmail.com>
Date:   Thu, 10 Feb 2022 11:22:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
References: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
 <20220208092339.651761-2-jaydeepjd.8914@gmail.com>
 <81e8a217-356d-65cd-3a89-f20ef9c1a5d7@gmail.com> <xmqqleyjxzs4.fsf@gitster.g>
In-Reply-To: <xmqqleyjxzs4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback.

I have a few more questions regarding contributions. 

I have seen that some command documentations lack consistent synopsis compared to other commands.
Is it on purpose or are improvements to those documentations welcome ?

Also, I have read some mails about "noise" in the mailing list. What does that mean? Does it mean 
very small patches (like mine)? I just want to make sure so that I donot repeat any mistakes :)
