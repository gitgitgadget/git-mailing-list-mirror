Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E88C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 03:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhLVDUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhLVDUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:20:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:20:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mj19so999312pjb.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FDv1IAEgNgCNxeeznPjlxotCgL6/PzYmBVLlgfvmx5Q=;
        b=QelBUKk+qfp2N8v++7kqOmJ5ULYUFgQAfTHTVR65UJz/kYh8KDywce2pH0jYYGEqya
         51F//2xwRVNi5GAy5ArMKFEyRS4D0ZQAzymCSEo9ruQAB668H9bPrYGeEUiIo5cL479J
         XGXULxtq6augOJsLF3qSVRnM4xC8A1SAgOGqpOF/sXHm2Dt5V78kAlVAqXHbSgltqrMa
         1DjNXQVrX8/42qqhgPXRKSOt0lAXyMBZFDNjD3zqJkfC0+W0qUh8visIcNiyrUpZ8Knd
         IrgofhTaAoih6YVZf5s7vNECoWXeUgivZ48KXRTtKMK6NjBnNiC7n4tUV7Lm7kewzfgW
         7t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDv1IAEgNgCNxeeznPjlxotCgL6/PzYmBVLlgfvmx5Q=;
        b=gX27fh5Nd+vtNkU/30PryrEFH8cnWOMUk+6gb8LTEKGRnrsgiozep3ouA314D780fV
         NFR4YN+Tv0G4BF7zNcWQi+Tyo92PctSiMD8BG6qfoP2TqZEG41koSpLrlsbPChl0CMpC
         3pajlHwfqvdx1pkDgRj5+GIu5Js+LgXBE35Ze7O1OK6qJ58OGnEppT74hU4oU1xZfyfM
         nGgiGxgF78NQBGpjgCfgNPJRmkbp5hHhazZcg6FwPh0uMe24zdamouZYfgjoMLr8mAf7
         ulU3+QusJbKpmYx9jTY/8Hl1fey85pO/5R7KnPMjNQLIdlBXgBd9/sLrOMwowoz+hKP1
         T7hQ==
X-Gm-Message-State: AOAM531UpFFGoxFjk+Hzo126zwUOqIhJ9pXum0L+FBtlZ6Ig6G7JJmPe
        HiPp3ZdvtP7wafENrj2C2gIm8AUKCJrzMw==
X-Google-Smtp-Source: ABdhPJy5BNRyv61FrscAKafwyDWxiqHHkRTIe87qcFK2JVhgPG1GfJgywVtneIVUendCq5UaEhiZQQ==
X-Received: by 2002:a17:90b:1c86:: with SMTP id oo6mr1271117pjb.165.1640143234981;
        Tue, 21 Dec 2021 19:20:34 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id p10sm465132pfw.87.2021.12.21.19.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 19:20:34 -0800 (PST)
Subject: Re: rebase -S config option
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <CAM+a_NM=xTCrNPCjpP49T8d6hPFD26d+Cu06fiSq4TiZB=DzYw@mail.gmail.com>
 <cf17d437-61cc-6d01-fb12-af420c650e82@web.de>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <3930db02-4bda-59c8-3615-ef6b90c06714@gmail.com>
Date:   Wed, 22 Dec 2021 11:20:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cf17d437-61cc-6d01-fb12-af420c650e82@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I'm new to the mailing list but I should get
good at it pretty soon.

I set that to true and all commits I made via
interactive rebase operations were GPG-signed.

Thank you for your help,

- Lemuria

On 22/12/2021 1:55 am, René Scharfe wrote:
> Hello,
> 
> emails are better with a subject; added one.
> 
> Am 21.12.21 um 15:44 schrieb ?????? ??????:
>> Is it possible to always GPG-sign commits created by rebase operations
>> by default without having to specify the -S flag?
> 
> Setting the config option ﻿commit.gpgsign to true should do the trick.
> 
> René
> 
