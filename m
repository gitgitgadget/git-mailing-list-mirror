Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5AC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbiFNPsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiFNPsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:48:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA35111B
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:48:48 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p1so6845432ilj.9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hBO8aQ2fdaMSoet5aAHvyip+F94uTLRruUERuTUvg24=;
        b=WXfTZ1gdlobYn0l4bPjinMimuY0+vWst/y1BPfRqy5zCDckaV13kaSFacz4uF3hMAT
         LVmUS3awYVzU6bZtprW1NdogKVJTjWf1oap6vC6Dw/hBglrwbbExViZknSERwvoLd3P2
         MvnPdhoIr+CggUiC78x8OrHDJjXcWGYhVNpkis+JrCWtUviLbG7twQ6CKVtIdvENbtjm
         EJxlDjeq5RY0IxQ2wcWxpGO/RgREqW62iw52fyqdIk1yQAYlHZQ+vf2Rouz+O1nrkM/X
         HMcLxipP3nUVYAYkkHLM7LFjAuNl26kH1yXRtzLchskLwuQ96hj7158noCPzCaMRG8c5
         cfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hBO8aQ2fdaMSoet5aAHvyip+F94uTLRruUERuTUvg24=;
        b=o9Lf1zxfmx1Cop/dBxcRPfYTRZrIz25FjLorcuDWHVXlFifnUsyUYR4mTSV11QkwRy
         ofd3RAscPL0qbB4zwzpnMyrupccmEztklMR5fCWAF3CNYwPiJ7cIUcopMVBNkf1n2Nm/
         9+pkqCRFzZIyNxE/TYRBrMT3pXH6F7L1aIH8NSNAmDocOeyXoLwuIETbO/eCqkxj3qJI
         eYRnOKfT5R6XWot2XlrUOvruRxjT3f86kZYc3Y96/evkQH0Xo56Q8I4EVoz5HSkKolHf
         a+CFVyKQrhhylf0YPwo3DLf3eYLjQh8C90vlzZKznXmBsbfUKWwd7B2E1DJzQiLlLL6a
         wv9Q==
X-Gm-Message-State: AJIora+b7fIIm3fcy2NiopcrhPwFImo1aEemIhrdXUv/YhsSH4aBWcvZ
        9tAJh7+4AWP3RiSq/ttmiWFO
X-Google-Smtp-Source: AGRyM1tINrBobpDoVZdWEWOlCS83l5hE3fXdKk3fY7TMsQH+SIoX6jXm9S0ZXllkKaEF88eisj1thw==
X-Received: by 2002:a05:6e02:188f:b0:2d3:c38f:7e9b with SMTP id o15-20020a056e02188f00b002d3c38f7e9bmr3399488ilu.151.1655221727725;
        Tue, 14 Jun 2022 08:48:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id w20-20020a029694000000b00331d98c9a7fsm4985894jai.40.2022.06.14.08.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:48:47 -0700 (PDT)
Message-ID: <b7d4dc9f-613c-17b6-f3e7-83cbd88a24db@github.com>
Date:   Tue, 14 Jun 2022 11:48:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] t3701: two subtests are fixed
Content-Language: en-US
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 11:26 AM, Michael J Gruber wrote:
> 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> switched to the implementation which fixed to subtest. Mark them as
> expect_success now.

s/to subtest/two subtests/

> 
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> I did check the ML but may have missed a series which contains this. (I
> only found one which tries to make the test output clearer in CI.)

The breakage vanished as of 1fc1879839 (Merge branch 'js/use-builtin-add-i',
2022-05-30). The direct change is likely 0527ccb1b5 (add -i: default to the
built-in implementation, 2021-11-30), but that commit actually fails the
tests, it seems. Something about a parallel topic must have made it work at
the merge point.

Patch looks good. Thanks!

-Stolee
