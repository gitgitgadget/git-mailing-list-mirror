Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6E4C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 11:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhL3LdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 06:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL3LdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 06:33:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E3C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 03:33:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so97088536edv.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 03:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to
         :content-language:content-transfer-encoding;
        bh=8RiFtXpb9QchIko8P08aYRrV+wwuEMxd7nzny9/9/OI=;
        b=eTulTd05ZMgZvtvED3vZd8Jv4IfR8a9vtfD4+sA4epU31g3wPSTuxF8vesEecqHRto
         bn6Qk1g2BIe8ATWFILthZ3OTpdxGeAirjKx2dHgjRY7SZSwB0KZhcZdzJlGILzuU/wJy
         U7BufpNuDCfi4lEL3GI1uhCPPbILT6i4sl0pZdv9PyoaKXs9LpMjIT1q2MyWU3hnsqIj
         k6mvIXVR9NMh0T9Zq0+qif9mjDJxOPCF+ZDTuhzjnyUaU46M5SlPPgL4cuB1GXD761BQ
         zht2sbF1ayg2o4QLjQ6FG1bl8P1pWw0lb76rGxhpHRVcrenoOg6hB35k0X/YCL4MHO0R
         Y3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:content-language:content-transfer-encoding;
        bh=8RiFtXpb9QchIko8P08aYRrV+wwuEMxd7nzny9/9/OI=;
        b=5QGrCrV+lm4X4ASQcJ+BLQNDpRqQlzeleGrP4WnxxwTSMCtv7rAPeBpxv/iiV/mKAJ
         X2M+GjXrD8804iQ6XQO8GjQAwhIpr8LQXYmoWmTmBiw1z9CpLjZGb9XMfyyWsG6z3Pu3
         lI5ztAUWlucrr/ZK/qGnuxigKuCepVs7oqzx2ZTSmsdME8zB3y5AYPElmPDlSOJAsxTv
         CujJ3MFIp4SKRXWBxmenxMdPgarBPsEpGOciobdtLbds6bUOcLq5ccbKg0F86l5h74QQ
         L6G3Fsw7/24ejQalGW4AbGBdSB5G8mqEbNwfESzcMZ1vlhI9GhrGpRjWHUlLMvBG3NGK
         yrxQ==
X-Gm-Message-State: AOAM531utGvc22foZyj3V5duIKf8uydcq/1mb5KMyAuuZtbgZ6G4xLrE
        jxaF7IfAvXZAgycdMvS4bfkvJgMX3mo=
X-Google-Smtp-Source: ABdhPJy56gn8poARWLBHpaDFd/Z7Q8x1FIHJVsMB59+bviN4uPqMVkwqu9YiRfFWN6d8DLf6eIenHg==
X-Received: by 2002:a17:906:8283:: with SMTP id h3mr10128603ejx.608.1640863989878;
        Thu, 30 Dec 2021 03:33:09 -0800 (PST)
Received: from [192.168.1.6] (ip-193-121-17-144.dsl.scarlet.be. [193.121.17.144])
        by smtp.gmail.com with ESMTPSA id 2sm308135ejx.123.2021.12.30.03.33.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 03:33:09 -0800 (PST)
Message-ID: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com>
Date:   Thu, 30 Dec 2021 12:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Nick Gearls <nickgearls@gmail.com>
Subject: Git Diff feature request
Reply-To: nickgearls@gmail.com
To:     git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On top of the option ignore-all-space, it would be very handy (for 
several programming languages) to have an additional option 
ignore-all-space-and-eol where the following snippets would be equivalent:

if (...) a = 1

if (...)
    a = 1

Thanks
