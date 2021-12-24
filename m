Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D54C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhLXOiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 09:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhLXOiC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 09:38:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD74C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 06:38:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b22so7906980pfb.5
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WGDE8/0Q8j5e/Q+ovO/vL2K54Q4Uq8VSZwqhmsuFa24=;
        b=Z8DvvW8tsj+Ox72oYDvu7viGSRKWmncIMgNAa3v2AmJhxPEMsb5eb085p9Z5yKWNhr
         Az3oWHGZNsHGrzU0+yPe5gN4Pa9ktHNa0R3sM/HVcUnT1HtxMPLqHM/49AIKGamCfUg3
         cogGkSDFWtzBQPuOO7w2tPhHBEu/7miXeNLjmx914Ha5yxFWCBRmb4Td1h+D3eQTs0R9
         +j0h2k1HwZSIYmLCWTjjX3+AQlRmeVsZ2nJvlrP3rqlpoxEVwUCsIPq5gi1Vcob2E4U0
         /7DfCdm8UaU6h5ZVdkRhhQ+w91GpS6VjfvNNF+pM7MbcEgcJ5PV7zvGtrs1TbtGaG/4c
         Nv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WGDE8/0Q8j5e/Q+ovO/vL2K54Q4Uq8VSZwqhmsuFa24=;
        b=LjkVlNx3a6N5liWSoQN7ksffjcU84FGoc44bm/Vi9BS6E76hGgT1U0VpWolGJssDYm
         J3+soJU3A2WZxov0aqVb1lDFpau1Fn7Uai8XwQjKeuVHo3KloAjpTdWP3loke1kopaxI
         ar1en7dX1HqDaUpHtYas7jV4SJXYH1eZyCY5ZUFNmAE9h9uLeA24WfbTrxuHIKYptAVn
         0C3wv0W7i6VlgTMU1FjG3vYgfY1avO+4pmbKK16uX2Cisse1QHfTlOGodyik/H4G8+XS
         RvcBjkEGL+YtTFiNFCHn13EQI2omamBBaP8QiTlmrFustWKwBb4Cou4y0czOvz7nQy70
         llaA==
X-Gm-Message-State: AOAM530sSO5lOJfuTMBw9UfCfdXQIm8ulekAHe6M/BN7B+exbt+RL8Fd
        N/a+9m1HhzYF9+cawn61ikThQ8M81jOpVw==
X-Google-Smtp-Source: ABdhPJyooTIL0D5YhZE4szTBEi8HXGHUxdwHbv+mdfHidjLLhvYLZNQLXXc2tz8ixD7PVwa9jbhbyw==
X-Received: by 2002:a63:4461:: with SMTP id t33mr6309856pgk.309.1640356682047;
        Fri, 24 Dec 2021 06:38:02 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id l186sm7895196pga.24.2021.12.24.06.38.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 06:38:01 -0800 (PST)
To:     git@vger.kernel.org
From:   Lemuria <nekadek457@gmail.com>
Subject: Git internal command line parser
Message-ID: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
Date:   Fri, 24 Dec 2021 22:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

#=< TLDR: Where's the code for git's internal command line parser? >===#

I'm interested in the internals of git, more specifically it's command
line parser.

Does Git use a library like getopt for it's command line handling, or 
does it use a custom parser?

If possible, I would appreciate being redirected to the source code 
files that handle this.

Sincerely,
Lemuria
