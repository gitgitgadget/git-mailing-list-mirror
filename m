Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F36C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 07:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiC2Hkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiC2Hkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 03:40:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09B57B38
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 00:38:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so1942057pjk.4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eho7u6P7YTCaYlbdnBesJ1qT35V286TedBp5bWGDQQw=;
        b=OaZRiXQB/ZSpZs+kwE5diNCa4s0GToG5mVnt93L5Cb12MhTBcyuddQt/wZSW4fZiR+
         aJ3CD6481fprsTB7pBIYvqDtx1lwrKTG4qF4+5SPPTTSINq744CES1lxnuM56paLQVhO
         tI8CXFJFLy8EE5z9+93K77qJFeG9v6hVEn9pWmErO/0LOwpvUA5iPAxmY15jd+TN917a
         MtOQGN88zHshqOrhgH9upZNnz6dtt+LCi2Q1ykjJLDT91nRS9mKf/M8SDjY7STWviXiV
         hsfuOtp76VwvQGSd1u5gxZItBYbqn2DaDSPSd6JzMS7ogGH00xXZ7rl+7raYRA7a+KjJ
         Xc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eho7u6P7YTCaYlbdnBesJ1qT35V286TedBp5bWGDQQw=;
        b=greCqiouc1TE3StfxxviVU/hfevnrdJoBSEIm3XedO4Dft5x9PDTvjG3VrCiGn5CDq
         Lb51eQlYOvcaEQ2x/VZjL+NrxifahRL4E5ggQSOUb98iwHzi/DuH3T5MccE6Vh/tzzYp
         HrVg6vHb9Z4fkHh66S3b3u/o6zlrengWQjmnndi9nhqztkw/uDOfVubI09g+2bHSOZ4t
         kAgnyWqqH6FbzXOWcojIUJCBpNAp4BLFt/fsrWCNNc6jQsWhsCPyfdsny5L6PM7T3uHN
         YXp/0OWjsXSNEQ260KSLFZnU8I+PFZu4b0Wbv+IOtdXkLO2PdAXiLlAe2djkM+CLrgJz
         szuw==
X-Gm-Message-State: AOAM530AfI9UVvz0pN0idA7XK9t7weH0bYVJ5HYkr5bAa+Cwef56pyWT
        iLzaA1aZkAjJDztflh/ARXU=
X-Google-Smtp-Source: ABdhPJyNHotA18KqaGLXTXRvCn5USHcEySZNhrO8g1vNObfszAgdmI6BuZ1zRn2hLcL85fwNRGVvog==
X-Received: by 2002:a17:902:d2cd:b0:154:418d:e3a4 with SMTP id n13-20020a170902d2cd00b00154418de3a4mr28801150plc.34.1648539536441;
        Tue, 29 Mar 2022 00:38:56 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.49])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm18302565pff.106.2022.03.29.00.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2022 00:38:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Teng Long
Date:   Tue, 29 Mar 2022 15:38:51 +0800
Message-Id: <20220329073851.80702-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.577.g74cc1aa55f.dirty
In-Reply-To: <220324.867d8jo45p.gmgdl@evledraar.gmail.com>
References: <220324.867d8jo45p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Was there an on-list v0 (RFC?) or is this a range-diff against nothing?
> Best not to include it until a v2 then.

My careless, there's no RFC, actually this patch should begin with v0 and
without range-diff.


> Sometimes it's better to split up patches, but I think these 3x should
> really be squashed together. We make incremental progress to nowhere in
> 1/3 and 2/3, and it all comes together in 3/3. The 1-2/3 are trivial
> enough that we can squash them in.

Sure.

>	+	trace2_data_string("midx", r, "core.multipackIndex",
>	+						   r->settings.core_multi_pack_index ? "true" : "false");
>
> Weird indentation here.

Will fix.

> I.e. surely you just want to create a region, and if you care enough to
> log failure shouldn't we log that in open_midx_bitmap_1() if we care,

Actually, I just want to use "trace2_data_string()" at first because which informations I
want to append is not so many, or does "create a region" a preferred principle for using
TRACE2 APIs?

> and perhaps error() there instead of silently returning -1?

I think so, after I checked function "error_builtin()" and there is a "trace2_cmd_error_va()"
usage in it which is already support to print some debug infos using TRACE2 envs.

Thanks.
