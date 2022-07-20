Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB51C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiGTBnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbiGTBn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:43:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A24AD7A
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:43:14 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r70so12130489iod.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=krC/MtV+W8IQvon9jqH2k2R6lNkyvKK2/wlfaI7loBw=;
        b=TdVbp2oc7SxXwWnnswIBfP75cE5Sa47wu2FN2HR/gfGcdgoQnj8SHmnJ2HypGtmEs1
         HT8npcRg7F5ZhLo02cwp/f/zO2iBvVBt8JLIOPyYdG28fcGR68nh5ggXs0lxTTMWMOLh
         w5jETux4GHIDnnD0Yl2TS3C1sO2SQS9IrahAefLA5Lx5KwGLJx1QSGb3dWkICWDselNH
         5Mu/j2IOfyCCDIwKOg7gORbIZWplkOgwZPTILslcFavWiYnanXt+rwIKqxhTxD4XoPGh
         PpHIj+j94+j0dGYqY82GCbYpvDYXKf8HegJu0q7hoFeODZk/oJWxp7KvY1ox5plUy4yC
         CMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=krC/MtV+W8IQvon9jqH2k2R6lNkyvKK2/wlfaI7loBw=;
        b=g/G+weVbuKst9CDw4Ae8m/33saZxDJwyFUNJKmtNUUVdeLgq7O6RwmWnwg/J5RU4YE
         aj0T1SnsicjIW4EZO0A06oSOWhf3EW75u66R9l0IYlbJxP893/1snGWAYt6We9HDqNy4
         SakArzJtlmDLSCDliaCAUYz4y7IQHxZYgsYHUdN78cK7rAgtspyOOze4t5YLqPxpZK5q
         vtGwbQxuAh39Z8xZsjIjNkNQabWZF5NkrRxnOzzAmdUNeL3Zyt7F8kyD1BGXRbjDVc42
         55puOKkONsAOWdEnNBIzBaC5MZtku5gllN14YUdq0KN+EnS9fLy1mUqdo11p/9Xp4tg3
         JVXg==
X-Gm-Message-State: AJIora9WajjIxOACY9WDWOrEUM8PZK5AQFEFyJD5pKZbCWM5vkYj8q/k
        9UNHmtsXApAqWXJnOJUJPQ5O
X-Google-Smtp-Source: AGRyM1tQ9pW5hniwTbWdP5Pl/UTbOdDafOeCuI+aLyiESzcT2mxFxi8uNm9/vZKUNOw4QaUTzfLiWg==
X-Received: by 2002:a05:6638:ecd:b0:33f:32d5:469c with SMTP id q13-20020a0566380ecd00b0033f32d5469cmr17764255jas.222.1658281393468;
        Tue, 19 Jul 2022 18:43:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d574:b134:aa04:ad2c? ([2600:1700:e72:80a0:d574:b134:aa04:ad2c])
        by smtp.gmail.com with ESMTPSA id g26-20020a02271a000000b0033f8af36a96sm7328344jaa.165.2022.07.19.18.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 18:43:12 -0700 (PDT)
Message-ID: <7e31432c-4edb-ca95-bcc2-1aa1f20a246c@github.com>
Date:   Tue, 19 Jul 2022 21:43:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/10] test-lib.sh: add a
 GIT_TEST_PASSING_SANITIZE_LEAK=check mode
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
 <patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 5:05 PM, Ævar Arnfjörð Bjarmason wrote:

> +GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
> +"TEST_PASSES_SANITIZE_LEAK=true" markings are current. The "check" is
> +particularly useful with "--immediate", but otherwise acts the same
> +for tests that have "TEST_PASSES_SANITIZE_LEAK=true" set. For those
> +that don't have it set it runs them, and considers them passing

nit: "...that don't have it set it runs them" the two uses of "it" are
confusing here. Perhaps...

 In this mode, run the tests without TEST_PASSES_SANITIZE_LEAK=true
 and consider the test passing without errors as a failure...

> +without errors a failure (by providing "--invert-exit-code"). Thus the
> +"check" mode can be used e.g. with "git rebase --exec" to ensure that
> +there's a 1=1 mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
> +those tests that pass under "SANITIZE=leak".

nit: "1:1" is a better shortening of "one-to-one", but I'd use the
latter anyway.

Thanks,
-Stolee
