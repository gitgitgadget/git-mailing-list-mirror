Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC0C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiGRU3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiGRU3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:29:01 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC9BC18
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:29:00 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id u20so10260156iob.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :content-language:to:from:subject:content-transfer-encoding;
        bh=aAoJFW5PJ17g/xvuadqyN7XzQcTFClEYhlxtqIWADEg=;
        b=xttHyvG/xY9K85agr6dLR9yBrB2t2tXOHs1h5FrbWDxIWiD1WAjubeAUPF6io6D/HQ
         TN2Chkv1QaappBeSn45fnqvQN4ttJ2bCUYbRzYx5K2Zv2BGWEiJ/gEsChenZEEHXOk3E
         a+7dXr+hT4S4ouNoQb+yP0mom7CTIhfTDmpnvmF01r1T8W+CmbnNsw5JC1DXpdEYJUfp
         AccoZxY6s2sLw/0Uio9kMHfa64DoslHEjKy/LAu51d4FEDZV89uMQema8+oilDMLR4xx
         WcliM8rlWgLg5ilZhMc7uG3v7gXvhXfHkp50tKHALqR9WGtPPyvWcy0BMrCnLNJL7VE3
         Xizg==
X-Gm-Message-State: AJIora+JEAR+mYP4GEsbWCsjqZoN+f7whDhiXfEIbhrZlXjLrYwrmR9t
        BjMBEl5PARWYgxr2ZnuQo1L0xvk2bh8=
X-Google-Smtp-Source: AGRyM1v1z0lpQPXFjtk3xyKW+YbGcaa2w6kFqjnQ+/BPlaPlW4QC1j7HmlGZEaRkDDMUlAq/sANTCg==
X-Received: by 2002:a05:6638:14d4:b0:33f:5bef:cdc6 with SMTP id l20-20020a05663814d400b0033f5befcdc6mr15137628jak.265.1658176139656;
        Mon, 18 Jul 2022 13:28:59 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id b11-20020a92db0b000000b002dc3df1b345sm5070613iln.88.2022.07.18.13.28.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:28:58 -0700 (PDT)
Message-ID: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
Date:   Mon, 18 Jul 2022 14:28:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: paul@kinzelman.com
Content-Language: en-US
To:     git@vger.kernel.org
From:   Paul Kinzelman <paul@kinzelman.com>
Subject: Possible git bug when working with Microsoft Mapped drives
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git version 2.37.1.windows.1 and Windows 10

I've got two systems which are miles apart and so are not on the same
LAN, and I have connected them together using the ui.com VPN and M$
RDP/TSclient. I mapped each system's C: drive to be accessed by the
other system as Drive X: and I can transfer files back and forth
initiated on each system.

I can also see all the repository files on the source system, including
the tree of files under the .git directory. Note I had to unhide the
.git folder so that I could see that folder from the other system.

However, when I run 'git clone' on one system to get the repository from
the other system, git seems to think the repository on the other
system is empty when it's not. As I said, I can even do a directory
and see all the other files.

Any suggestions would be appreciated. Thanks!
-Paul Kinzelman, Peralta NM

