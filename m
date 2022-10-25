Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3735C67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 02:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJYC0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJYC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 22:26:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB7A99CB
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 19:26:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so8248626wrt.12
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QgHWPfjQ2zrr6JoWAPDe6BeFweK8o5s3sruPHwt2LU=;
        b=W+9/ZdhdKM3sBxflczgAVgK1gHtTEit6+8QD0S+mRM0ng33/Qe5HuuMFqkJnz+Zbp+
         d1n5RNEKigWHdwyyYCA4ZpdNBjtfimeIgA9Xe7fbeWuIbVG3L+pXQwxGZTDNQiuWPg73
         5fjRb1SZ7AyWuqJF1ZAwv2gU+tl9Xn4/I3XIY228y/mZvnnkHjxFRJN47l/CFFO5YcQl
         TGXCbWKpEs2Ztp900GKSGS/PhNS8Bjp2fZ4KktPrsRZVSOFnfX/NTbef8cc/gHP2aZaz
         VB6DJj2iEdW9fCDY1PuuHBPS54Mw66j4Mbiu2YPaOzKvdnNdxzgbpxGjWHR9/1yFpffC
         B4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QgHWPfjQ2zrr6JoWAPDe6BeFweK8o5s3sruPHwt2LU=;
        b=yZQi3er+iByDS8XhLeYoqqkRaQLuArsfLKqbcAjucAwh3yKaE27u3z/GcWt5/j90jA
         Aw/IaaJ7cfCWv9hge/DuZy2hi2rab/UOAJ8SjggPaPkiF29LL6OSGJ9Dl99jHuIkOUfW
         5ka+FkqKgObYCtcq+GEUAzCY/RFDoHcNaCsOwHNzBY+FUTWLQXePM6dRZs6V61xC9quv
         gtLuq4kOSAdI1QQjx75Qb4dOO2SIg/ITJSlnae4jlogkEQDEnH1rRkLKVg6PyBHpEH8h
         27ylYBK78P4z4hzyZnwUHQ84xvZBrjbBf0nb/ZIv4mUc4Yvyh1EP5xnbFagkI6xWiYrW
         mpig==
X-Gm-Message-State: ACrzQf3USdfiMBTOVkMPeK5WQw8fqxJ3N36E6W1J34aA5ozj8C/iX34A
        lqrqKKVmf93KEpBBizpgWy8=
X-Google-Smtp-Source: AMsMyM7YF+KfumRVldE+Za+pYW6I9cCfMoJoPUfvVxPa5AC3dXKUrn92kNgGFU/WEYKQDByOJeJsHg==
X-Received: by 2002:a5d:4a4d:0:b0:234:c09b:5d58 with SMTP id v13-20020a5d4a4d000000b00234c09b5d58mr18315740wrs.586.1666664784363;
        Mon, 24 Oct 2022 19:26:24 -0700 (PDT)
Received: from penguin.lxd ([95.146.54.42])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b003a6125562e1sm1205741wmq.46.2022.10.24.19.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:26:24 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org,
        lessleydennington@gmail.com, mjcheetham@github.com,
        mjcheetham@outlook.com
Subject: git-credential.txt
Date:   Tue, 25 Oct 2022 03:26:23 +0100
Message-Id: <20221025022623.5449-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reading git-credential.txt, I'm not quite clear:

1. Are the new wwwauth[] and authtype attributes populated by Git and passed to helpers? Or vice versa?
2. Should a storage helper store these attributes? If so, must the values be treated as confidential?
