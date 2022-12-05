Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA4C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLEXmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLEXmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:42:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262152DED
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:42:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 136so11888093pga.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlNUvsn+EmP3CR31Y8jqPXZy/v4LJh+RSyMMZebx6AU=;
        b=aChFhkHJpg/ij1/uvkLuLP2WFsc+VgIx4mn8/GA625EaOkcWGoDDr1u8pHsk3HJjP0
         xF73q7URiShZAB/SpOh714Ai6rqVxbvcC2f2mS9R9CMKFAPiIsBU1KGQfd008sEMQG7X
         3B385+YEDKyurr46qtHvvbT+Molk/owOzEuNQzf0AOUWwqmn92Ua40OfxrmkOLJbNAT8
         6f7XTVXytIadAI9rwJrqSJiMnVuREacMe0aYuLCxjk8NYRFdwf7vnKq/IbAPTZcRDfWq
         tOvpcpOduLFY67FaqMDBwnuluO8yb3AwfuHnqtQGjwd5ykqZ2poXXXD6L8qmJUWt/gcT
         icWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlNUvsn+EmP3CR31Y8jqPXZy/v4LJh+RSyMMZebx6AU=;
        b=xczzWq/hdQ0b1QSecWmA1qSYT9qfbSP648h3Gn4prh2ZUYgDiUmZJ8kNGpGc9lbFX1
         inRYmS5x1LjCdMJyqYKu8yOFocO4Ln9JAYM8s/CQTbXGkhGdNlXT9CGmoN87F8FWOjch
         RKfQbPMkg+c3S3GpuB7CqG84f2Z2sqi/UNvNeTj/hEwAWZuxygBOaCFMN4FRU5PZhlIo
         9Mf+87vJQqplhxqIW4IA1n/lyM3gzanQCfadBYNVmtru3ngkmbKIqP5yFbmIIJTIiA9V
         z8QAv5DrQlKOucdCi7fbE487mQrrm32ny59HeMdeQSFWVSInDy9E6BCjdecX8aUEGlBz
         +4Pw==
X-Gm-Message-State: ANoB5pk57lUDB1VyakP9uUNS3GcqGkFvO86hbmQcQCS9ovdcmyZegFhO
        M2CpWDLnZqUEpm8Nq0dyQjNn
X-Google-Smtp-Source: AA0mqf6kTFUdw0HlRtuK+xCPkMiWAkggkHlifjrIH1wys2KyCpKXvr1E9x/3k4TAYA+i0KjSqoZfRw==
X-Received: by 2002:a65:58ca:0:b0:470:2c91:9579 with SMTP id e10-20020a6558ca000000b004702c919579mr57108488pgu.22.1670283762731;
        Mon, 05 Dec 2022 15:42:42 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902b18900b0017f8094a52asm11089596plr.29.2022.12.05.15.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:42:42 -0800 (PST)
Message-ID: <bafe5d54-1322-d9b8-3721-af34067b5e87@github.com>
Date:   Mon, 5 Dec 2022 15:42:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 00/11] Bundle URIs IV: advertise over protocol v2
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> Updates in v3
> =============
> 

Thanks for addressing all of my questions/comments from the past version(s)!
Overall, the series is easy to follow and cleanly integrates the new
functionality. In this version, I just had a few minor phrasing/typo nits &
some questions about 'GIT_TEST_BUNDLE_URI', but otherwise I'm happy with it. 

