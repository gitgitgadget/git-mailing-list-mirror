Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE20C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiFWPCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWPCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:02:33 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B22CC85
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:02:32 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101d96fe0a5so17544218fac.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Sh/maUi6pweikz7hmgWvuoNueRI8O7BvPt844+voAc=;
        b=cHMTuyybyaWdQZPYPBGRSqk/VxV3IidR3LOOtXLCjL0bTemlxPUjJw+XrcUTNwZ1+r
         QDMID9ZsClvU7RZtwBDfqlzWS4v0eqqYVAzJTEqRMl0MphuwkGAGSOJLtw3AwuB8dttg
         riE38L2COuHCzutUdMqSQMa5+ENQoUf6bRLZFN4Dm35+PWcp6eqOgq3EGypeY5i8BEBk
         m+5ciGhRCjP+/TjHzZxZiwMQDeQSnSeKR3oG0+nT4nmoiBnkS6ratGmY9c8qZtZRDwJp
         DUj4wYeJTuZMKrbpDsqmXTUz+RyGklvngfjHtR+hLQMfNWcxABT5WxwKX88f2HXV+wWn
         kQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Sh/maUi6pweikz7hmgWvuoNueRI8O7BvPt844+voAc=;
        b=oyMt37QmI+2otce2y7bjwHy8mlmSuP12ils7G6XWNaW0U32xkDklE81I3+yWjaPhza
         7iFsz+p7yx9s5NoLa6MxYqfTTAqMMJ7gmexSMdT/OVI2w+sA4Pk8L2Yrknfd/Yews/0w
         wOieK7xQ6MBU2zi1k+A3Q+/sCiJKmqOC77Nd8c7Ew9kSdcfCBq/tksDCPR09MOkjOBif
         xJ2dOTvatSMjRaXwXWH+Tb/1eIdhMvtOgFD/71vHFcusjjluS5rFsvxjp+uvahJAO1is
         3ib9rPzHsQyVsaauySyS38ymUVnS4jdIx+eXEncAuZ9T7FvlIsM8RYw69KR/7ph4YEwL
         oXEA==
X-Gm-Message-State: AJIora8mx2OjfYpsJx6c3lWHNld02cBVPq0LucW/Roarpe3e5EjXhtm5
        1kInSr683BctVdAPjUo+q52R
X-Google-Smtp-Source: AGRyM1sDjBFHWJyleb/krlL5oIUROKt+SAcDA/jtgWv21QJo6uMSBQHCzH4LPo7F1JZBoBwsRSc70A==
X-Received: by 2002:a05:6870:5b81:b0:101:b256:b7d with SMTP id em1-20020a0568705b8100b00101b2560b7dmr2908480oab.198.1655996551811;
        Thu, 23 Jun 2022 08:02:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id j8-20020a056830240800b00616a2919312sm70994ots.8.2022.06.23.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:02:31 -0700 (PDT)
Message-ID: <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
Date:   Thu, 23 Jun 2022 11:02:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/1] scalar: move to the top-level, test, CI and
 "install" support
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
 <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 6:26 AM, Ævar Arnfjörð Bjarmason wrote:
> This one-patch series integrates the "scalar" command to the
> top-level, meaning we build the "scalar" binary by default, and run
> its tests on "make test" and in CI. We'll also build and test its
> documentation. We now also have "install" support, both for the
> program and its docs, but you'll need to:
> 
>     make <install-target> INSTALL_SCALAR=Y
> 
> I'm sending this out now to avoid needless duplicate work.

As mentioned on the list earlier, Victoria is taking over the
remaining work to complete the Scalar project. Nothing has been
sent to the list because we didn't want to cause a distraction
from the release window.

Victoria is taking time to incorporate your previous thoughts on
how Scalar is built and its location in the codebase and create
a complete narrative of how to get from our current state to that
point.

To that point, this thread is the duplicate work you're trying
to avoid. Please instead wait for Victoria to present her plan in
July instead of moving forward with this topic.

Thanks,
-Stolee

