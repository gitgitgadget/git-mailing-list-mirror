Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDCE1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 20:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfIKUaM (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 16:30:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36692 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfIKUaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 16:30:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so14449877pfr.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ll9TtoT2+d/b60TBJ/NNuSejv1jwqNQS2TlhYVGXdS8=;
        b=ALy0nk7OlguWn+RxbiCQ9wQamz3LsGV5hVTO2uJnIbe50GIZPhG6eWeB1oQVuO3fgz
         MwHh5Yi42itETtPZ3adDhRX/QB09uzekYiXo3u4Ljki9NgYeUShVc1SjLhA6TftAB79r
         CSnqOoZWBcd+zuBzLU8RBajMmFh/4Ypb8RMCvs90oBuXWjVBDQpH3DdIzy8svxpEpU1N
         BfXydjpbTTRJXL78c+KDdkx579pDYpxdC3EG3hX3XmpJqUqQr+mCn6C4qxrR2/dYz9nK
         7nVu6QRBT1n8OLEHRR7ycFY3OtTrNY6zKSuOCW4U5KXW9/N0BnKYpUOxdQzrhFyVb0je
         sXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ll9TtoT2+d/b60TBJ/NNuSejv1jwqNQS2TlhYVGXdS8=;
        b=JkueuA77xWs6V+LMIRGF8dRUn8pO3qHhKew02VSmW5u5tz7fiCf9mvQFxuOCkM3l7z
         olJvPhRh2p2588HE1rEkAd/XkWyKheCnYPkTw8p7dPQKWypX336a5l49mroYh2BQTZpt
         f52WRO35f3QYRTrBPAdSZA8irruIfbqln2+1hsCF+25sNLarVicwl7UV2gcBMbZ/Gpvl
         AYQiVHmFZq+MeLzzR3dEMx77m1POFvmBAD0KuLk8qz7CDUvKn49NTWRLbgewbY7UG+Ah
         3l1NC9P3rAFMVqLIxtccbFDZJxKORBSFz+8lniPJs6DlwhfOxPXJuxIQZLmuxAhvtx3x
         mPsw==
X-Gm-Message-State: APjAAAUj1a+LKAAAGf1Rd1HxsiZYn2DPvMhh0ByovAiNN/XB/g47wezp
        mFbm9oPUPva78xp6ePv0lLk=
X-Google-Smtp-Source: APXvYqz7YKXtZeDtYM4NVPonFtAtm97n+emWTfyUqhHFTAEORCd5r1g/RWEHlKS5V/di081Rkxpexw==
X-Received: by 2002:a63:3805:: with SMTP id f5mr34387745pga.272.1568233811167;
        Wed, 11 Sep 2019 13:30:11 -0700 (PDT)
Received: from [172.20.136.14] ([167.220.152.142])
        by smtp.gmail.com with ESMTPSA id v66sm27183219pfv.79.2019.09.11.13.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 13:30:10 -0700 (PDT)
Subject: Re: [PATCH 0/1] multi-pack-index: add --no-progress
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.337.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0dce74c7-4df8-6c6d-2a3a-2a23c1e89b42@gmail.com>
Date:   Wed, 11 Sep 2019 16:30:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <pull.337.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2019 11:37 AM, William Baker via GitGitGadget wrote:
> Hello Git contributors!
> 
> My name is William Baker and I work at Microsoft. Over the past few years
> I've worked closely with the Microsoft team contributing to the git
> ecosystem and I'm excited to start working with the community.

William is being modest. He joined our team from the Windows org due to
his extremely impactful work in the VFS for Git client, especially around
the file system virtualization areas. While he started with the filesystem,
he also delivered important features around managing the very large object
store, so he is not new to some of Git's deepest internals at scale.

Thanks,
-Stolee 
