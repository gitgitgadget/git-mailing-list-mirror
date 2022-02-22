Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253CC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiBVPtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiBVPrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:47:55 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C245040
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:47:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g1so12451765pfv.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0j9BQaQCfCrPquhl+ggWosPOYpVn7RK9cQOrRe5QIQ=;
        b=Ayx5fJ3Wt7nQZ/U/atv66gSxh+9xpRbpvsskMDz+g6NFn3ox4ueKd6R6vAghBDWnI8
         bDyfAnwsTUhw/vwKgGYAmdvqBZUkHvPuBRFJtkyy1z1Nuk6yWGIURk9rojurdbtIo1Ns
         PwV9AwtrkmS9CUjwQLxjIcSrHxqUK4txViqc1+UCMNZ3ehCUUHkv8rh+XKRhKty5w/LK
         Pxwyok5OmMVzeePQ+Qs5Kj4yua/OnPVNpRp4FCYdGV+cXkHMNWWE0eMDQMNxZAoXisZf
         FnvWgRd+e0p1u10pfFbK5u3v6FPLnKEu7jUlPN1nkyT4vWMJ2K1SqPPTtP3BNfee6Oa4
         11tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0j9BQaQCfCrPquhl+ggWosPOYpVn7RK9cQOrRe5QIQ=;
        b=fWozGOPbO+r1ztxtftdGzbRf59eImbCZsOhKKNdnQRe9gkO5ucISa5qBKOx27fIkMF
         KCUe+QJ+eTFTQFHTdwHmUB8Gwz/l+6md7IM09IWEFT2cd6KXZ5CW479FuOB1UV0IvBZz
         8es3TRp+J6DgfSLnrukGfba+SJYyP1EhkaR3F6ARpwaAtOFsQPHVq7RSOQlcdkpfQOSN
         VygYFy0Pm5nkssAih9WdxS34TdcakGLa3fT60rFC/Vp18xTVy9+rRNaK5G2XhXRZ6NGw
         2gniQUxbIlMxiMZoTtTrMFVluFXar9Z5l/wggVQ6kVbx9KtMs8k13Xr4tAniHj7dqmwk
         678Q==
X-Gm-Message-State: AOAM53137ZvNwffpEUdtStjyujlM+QmDrF3p/Ea2kthSgogepUn3bELO
        +axcDe8y1KJ72M0K4UAYVjk=
X-Google-Smtp-Source: ABdhPJxtjSysIJpN2/m05wikJ73KuWc02GhqAYrewTRrO+KGw/VIM4v1/8wJ/W5BuvfBPIHqVGGPnQ==
X-Received: by 2002:a63:9d85:0:b0:374:916e:4b19 with SMTP id i127-20020a639d85000000b00374916e4b19mr1379347pgd.128.1645544848770;
        Tue, 22 Feb 2022 07:47:28 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.56])
        by smtp.gmail.com with ESMTPSA id y23sm17357697pfa.67.2022.02.22.07.47.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Feb 2022 07:47:28 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Tue, 22 Feb 2022 21:17:00 +0530
Message-Id: <20220222154700.33928-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
References: <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julia Lawall wrote:

> Of there are some cases that are useful to do statically, with only local
> information, then using Coccinelle could be useful to get the problem out
> of the way once and for all.  Coccinelle doesn't support much processing
> of strings directly, but you can always write some python code to test the
> contents of a string and to create a new one.
>
> Let me know if you want to try this.  You can also check, eg the demo
> demos/pythontococci.cocci to see how to create code in a python script and
> then use it in a normal SmPL rule.
> ...
> If the context that you are interested in is in a called function or is in
> the calling context, then Coccinelle might not be the ideal choice.
> Coccinelle works on one function at a time, so to do anything
> interprocedural, you have to do some hacks.

Though in this case, `parse-options.c check` method is better, but in other
cases, this might be a good fit. In those cases, I would also like to help
you (i.e. you, Johannes, Ævar and other devs) to fix those cases.

Thanks :)
