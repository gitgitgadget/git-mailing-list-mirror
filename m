Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D64BC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 17:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKURoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 12:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKURoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 12:44:23 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2D29361
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 09:44:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j6so8457455qvn.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 09:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAHVwImsncSglxn1BnhiAPVlcLl4lEHloaqEUHwKmOA=;
        b=hjBqFYbfNTSOYY+KttUDEgKsr3MsxCVmu9CnvwGktKoBAPYD5VKzHOjYD0dvjp8ed4
         eCjMS+houMAcFz/1JGzAmhefs+hr/zbjZ5RwlDyM9gQYl74pjClvZtwXrKCX47k29HNN
         okDzrdQO5eNnhrrwy40jxu6aWsUQt2Z17QPK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAHVwImsncSglxn1BnhiAPVlcLl4lEHloaqEUHwKmOA=;
        b=gMVPiK+nt22yOIaKlrDBsL/T+Mrt+8zuHQ5CZNZBli7heVcSAubEjMekLslhTh/469
         eGn9m2F0hqL/ndaioy6DyPwtaqZPqKSnYuzYkeotNmThzCTOSnR18/3gOI0ZGtdAtDkp
         IvEnVDP0EDGGNDc2T1/a57/gef+8dT7Y2gNZ7U7EX2o7AelMAZ59EklVzysOQmwOyq+C
         YEqzEQvRLwdO5PjMSG1QheZGNmhRSOjFav/lRGOICfs2S2lRE6qXOKVa44Y4n4dYLrPE
         HnAR06oOswUYHpxOhTVv0oV8OIrl1KPjpooFST4pwdH6dMFSZLDke9Ju6+/VG2bBoP6R
         jGrw==
X-Gm-Message-State: ANoB5pnLVJsbbH1s0ggE4CAu6XrjoIW1X6SrpJzF6SD3451dUXUXbVwb
        uClR9OTl247WMKkEqV5tYL34NAdDu9I9sQ==
X-Google-Smtp-Source: AA0mqf6x0EM2xPQv+BI8O4fNyve/063foy1Mq/vX+m+3sWC2KZsO4N6ox9DdOe29qK+2DYO2YZjFkA==
X-Received: by 2002:a0c:c491:0:b0:4bc:16a2:d4f5 with SMTP id u17-20020a0cc491000000b004bc16a2d4f5mr15319qvi.64.1669052661800;
        Mon, 21 Nov 2022 09:44:21 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006fafaac72a6sm8412103qke.84.2022.11.21.09.44.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 09:44:21 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:44:19 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: filter-repo: support for copying notes
Message-ID: <20221121174419.trgn7izl52cxhahh@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

It looks like git-filter-repo has no support for copying notes, even when the
following is defined in git-config:

    [notes]
      rewriteRef = refs/notes/commits
    [notes "rewrite"]
      rebase = true
      amend = true

I'm wondering if this is deliberately left out or if it's something that will
be potentially implemented in the future.

Best wishes,
Konstantin
