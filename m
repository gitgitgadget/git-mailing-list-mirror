Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C615FC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 07:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbhLVHzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 02:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbhLVHzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 02:55:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A20C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 23:55:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so1770959pjw.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SxI0Jj04bwxcERkI7pHfyWjHayPeWlkMFurLp5EluS0=;
        b=agqonGH+Qw8Ih+4HOECLf9e4fHSgj5HTYfmlcLvuHEdO/ZMgZDxuIYX6aGmtsAy6hx
         E1k7mgIeIhz2dh2x4A81IQRSCHW60leuO6lUIKZT0PcDnN6jQ9zmREwXSVlmwbPkpUNR
         TDvpsAnzXh/PNtfewv+uZDjm9hWeWTsIqL46YLDdhzHsprDI7fXDZayu1QG6LinxD+qq
         kg/1G/m6V01BM5mAD8HYyHx4iHE6HSoUL3Ddc5t7unku6RZ+YdlounPk6HAQVmDtfDfo
         mbDJID/1aOJuCwP23jdfFcXQuQupTJE7YDMimt5gOse33CYuCr2cbFqo33fNc5rRBfZn
         N6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SxI0Jj04bwxcERkI7pHfyWjHayPeWlkMFurLp5EluS0=;
        b=tuamU6N1/SVWjvIqc+2g3AekiOvIJqE3wx0GnXGeNh/CpJWEiGK2L+x4qZBHG11b6d
         Axufe5qpUmiPBsvqJzcERdAcfRCSkrVzXeCSHN9ER6l/r4rlDAofDWjPgH4WtUfqoCw2
         yJ0JgHO1kZ5TkRppvBf9mhtvYhlxulSpC7oGvNcSAQ6K7VnbLA+SXqWBax4ecvFonkBR
         XVmxEvN7k/0OwKJkkhB4NNcyYuFO64QcaB2hnnaST7NY4OUe/SJF+579mYwlmtZYfHme
         V5OsKOhHqWbaL5UMNy7hbRBpu8Lf8Nt4reFDtS8gc9c8Op3rQ+4NLUUVhrZJzV34IwcL
         RbTA==
X-Gm-Message-State: AOAM531xno8Z3QtdO7TGhFycHviXPqLCmsQqvYeW5OKhh0CJWj0YrOyf
        OcY0qR37Tugd0qZsuIHh1hC6XRRNmIcI7A==
X-Google-Smtp-Source: ABdhPJwUutBvXUPk4ZzNBOkLMcmKWh5EPQYuMr/M5jAVY2/oOfLkd1Qu+lCJibawC7ll71IeCfWeFw==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr31356pjb.200.1640159722124;
        Tue, 21 Dec 2021 23:55:22 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id o11sm1550575pfu.150.2021.12.21.23.55.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 23:55:21 -0800 (PST)
To:     git@vger.kernel.org
From:   Lemuria <nekadek457@gmail.com>
Subject: Rebasing commits that have been pushed to remote
Message-ID: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
Date:   Wed, 22 Dec 2021 15:55:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How do you reword messages of commits that have been pushed to remotes 
(in this case GitHub)? Do I simply perform an interactive rebase 
operation on the commits and simply push?
