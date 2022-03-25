Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiCYOXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359345AbiCYOXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:23:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09AD0AB8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:21:34 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-de48295467so8281199fac.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V/gvOMSH6blejhuIAeNwiMWoZB1/b8APEclOgp+/uaU=;
        b=VZC81SoEJ4AxPyRjTf363sEZKOHKlFlDECgrUKF0vIO7xH2Lg7kajcLtx4ZhfkvaQT
         qGhNLO4NkRNOj/b/dXS4/t29bUkLE/O1bBY3V9+L7r5FZNyEyJS8R7/EXtbC0IbuLl2z
         wLtJeivPAuCoSm3tQEIWX4MwJtHo7zDxIJU/WSC6ntUI73Bkop5Uh6DofEGC2upbuu+7
         bmlnP9YCrH/sagTG06s5CbXV9fBPk9QFJWdglcXe3a4k5vXFp8WBqBjjZJAGwoMTXXvL
         b7FWMw9xM/tGnhzvPCkLcULnYEMPkblhrC6decWN8p4zbkhuObbgyhHZmbrBrCwZ0gKC
         CqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V/gvOMSH6blejhuIAeNwiMWoZB1/b8APEclOgp+/uaU=;
        b=GaW7OhygCW2b4F20m35VAXweMNoVWrI7L8LZpDQ1tuThvy1MChkBqbennzQWsXIrcJ
         ni8RDskGFgRfYOJhB2OcC8takXWvD8VT9G8+gtWYnQyWwQ5eUdbBGjbash223MLk0idk
         9RGRwbzDxdWU+MrxsVPlPL0z9mGFen3deyJbRfat7b+a179C6xOx3/fIwgxCIcyppbA1
         vTFYKOzdZ27NUKiHbVNREAG3jOdonpx93uFy65V1eeT+UIftKzMEwBsrPg4fdfTiwvwL
         Uk4dIl5AdcpbBrUJPEmpINR9b76pL5ptDm+9njbW8CHq1CESxJLEvr0+B57hzRFnXylc
         xRtg==
X-Gm-Message-State: AOAM531Z5C7AEdnIuVT/jypcoKHvyp/z99u1j+R9jV8AdKw6suGRWAgF
        cTDKEIvZMmyRlZJ8EloaOaGu
X-Google-Smtp-Source: ABdhPJxBI9HrC4CBGqyQ0Ujp89GCv3wGcgzegqbYUAStI0c/M2YmCEY/JT+jsAohXrBQGi4NyYAL6w==
X-Received: by 2002:a05:6871:b0c:b0:dd:aa87:3266 with SMTP id fq12-20020a0568710b0c00b000ddaa873266mr5103067oab.227.1648218093490;
        Fri, 25 Mar 2022 07:21:33 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k22-20020a056830243600b005af5fb99326sm2563282ots.63.2022.03.25.07.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:21:33 -0700 (PDT)
Message-ID: <c21da33f-30a9-a405-fb39-9aee2caf7675@github.com>
Date:   Fri, 25 Mar 2022 10:21:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 26/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
 <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <bc2d5a7a9306c895f4a1105c08d86f24e5ea542c.1648140680.git.gitgitgadget@gmail.com>
 <9c584888-2dd2-139a-cf41-b2974386d1f8@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9c584888-2dd2-139a-cf41-b2974386d1f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 4:59 AM, Bagas Sanjaya wrote:

> In general, this test is written from Mac OS perspective, but since we have
> Git users also from Linux, Windows, and other OSes, I'd like to see from these
> other perspective.
 
Jeff can correct me if I'm wrong, but these tests are needed due to specific
issues that come up on macOS filesystems. Windows does not have these problems
and there is not a Linux implementation of the FS Monitor daemon (yet). Thus,
this macOS-specific inspection is intentional and correct.

Any additional issues that might happen on a Linux filesystem should be
added when discovering them during that implementation.

Thanks,
-Stolee
