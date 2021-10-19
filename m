Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C906C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111B460FE8
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhJSRkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJSRkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 13:40:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62858C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 10:38:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso4424728wms.4
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=6WRxCcSYbId+tb4+1A9W5HvB3vy+hdx+VCqjFNReaQM=;
        b=mumo82NsZzzDSeG+bvrR86gBm5EMIFaPX1bn5EbjZtvRu2S989XLB9uXdL/04K7z4V
         +CkIMkMdvCrl/UW8j0oniMRZJXKDcXFRtVYRQQlwbayd7OrDlq3YfryaNARAszptWgCQ
         mnOF4HjlXpzoWuUv5Em/+dXLQ0iPut/+26wh8ekuaSrk40HhAX4E+QbuCr0YvCoMqeB/
         Jt4LaWPmvSYz4LwvQeAy1fLqH70YyTdQAZNrwoQrO5/OUCsw7lAROcIYtKenl2PbEf9S
         dsxk2pZ/Sf/gkugSS9CcDZnkW7ubfZyIQDJf1iyR7hhBYPMfgAPzTSEmLIuF0K3JAEKT
         n3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=6WRxCcSYbId+tb4+1A9W5HvB3vy+hdx+VCqjFNReaQM=;
        b=FEpQdxNmBLGPDVqvOexdAgYC+r9A5rF26B2AkMedWdA/4j6acmnNMUEige8QfA/T0N
         NybC4qOwOXB2Ee9HztP5DAY2jFVlFb/75saxkSMJ26r2pg5d52uVydYAoYRzz56zk39D
         TbK2Edxa0hB5eFkBm4Sc+TkX4ypjOsNwAamTgsvoOhdmNTL8FtYI0q+ZXSrJRS4gPko3
         rriH9Ql2UfVhxhpMZPsv/RW77Weqpg8K0x01p5YU9vC4DrEblrx2mShUvFyn6QOqqG3L
         NJqvjx797vvom05TB+aX8LHX9zuQHXEK8lJnURCGVNu2hT/esnu9QJ6h6e48d3pHmVGk
         CB2w==
X-Gm-Message-State: AOAM530fE3/lqaSUO4cFk0loX9rY9qUmGp5W7sU109RyqYNjM6UzBiOd
        KubddVPdE0f6Clgzc71fIIQa4PLGNQ==
X-Google-Smtp-Source: ABdhPJwp4LbW63qRTvj31G58hH981tnxTEfs+kVx/WPfRi43MgBOfj2nqEzrJ2crM0/JfBOinUkeRQ==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr46376095wrq.27.1634665097920;
        Tue, 19 Oct 2021 10:38:17 -0700 (PDT)
Received: from [192.168.0.13] (dau94-2-82-66-65-160.fbx.proxad.net. [82.66.65.160])
        by smtp.gmail.com with ESMTPSA id 10sm3288985wme.27.2021.10.19.10.38.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 10:38:17 -0700 (PDT)
To:     git@vger.kernel.org
From:   =?UTF-8?B?QkFSRE9UIErDqXLDtG1l?= <bardot.jerome@gmail.com>
Subject: Questions, improvements
Message-ID: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
Date:   Tue, 19 Oct 2021 19:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It's my first email here.
Maybe questions have been already debate.

1)

Why git not embed by default some gitinore rules (and can be "disable"
after).
All the time i have to add all operating system stuff, all editor stuff.

2)

I need a domain name / uri / ip base way to choose auth information.
i find some examples in past but not as smart as what i want. (Maybe i
miss something)

3)

For auth client side can we use tools like Pass and or identity manager.



Thx.
j.

PS : Feel free to send me RTFM (with link) if needed.
