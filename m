Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC1C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhKVSDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhKVSD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:03:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FCC061746
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:00:22 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so10293099pfa.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=Z5kfxSQx37YMq6HHFu924is5yEICO4+eSf1vT5gxcG4=;
        b=QUUQ7xJKYtKwVOh9bQ6k7F3vWPEe0scsV7P1CiiznHcgvw/H9L2+xjbJ6iqkajY2zX
         SNtnZmYtA0J+Ikmx5N0MoG8Zy5hzPdEFFHVsjCGzt2MW/+cG/r68itw/IcYNkz1AxcLk
         ug/H4sH3fT0ahRKzOZJPXT6pc6bEXMwF2IKtt6ncv+VcKn24h5JbOGqVxsWIVXQ9qXAb
         TX8+rED7rQgLybuGWDy0/IOGR/waewejP3IUz3/lOyYCER97Yd1hL3cjHPeHYFaX8cfx
         UHbjSsxD77w3epF4/57OFzRGNHrd0/v/tEvpxfaR7C2lLkspxOgZnc+odYpkuNWvgRsf
         6mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=Z5kfxSQx37YMq6HHFu924is5yEICO4+eSf1vT5gxcG4=;
        b=KPB+LYRagoskGg3tuk0Y26N4PNi/PW5WBwvobHE+r4MnDzv4wPLRTqAEpkOHH5wd9e
         ynW5HPi3qyiShhbF6vkz9wRCKIViKvv+K7/Rep74uSe6GkCMrf34V3bxC4laI6iYTnHB
         e4RIyqeW53tZ1S30nwmW9wFIuN9QYNrDQnucOAkGdIWyLRbgYlJTTTRSQNd8n6CPmSx6
         D3YhICCE0Cl/RCvtKtuNYRKDy0M9bNT1wKIV0Pe+71955iY+iQwizEmASvrF2HV750bl
         BUxn20Rcw1NkDgvGxdS1oTjbI/wYDYYoRvEHFastcC+h/fD67/t87v08xTZDf1rXfd2Z
         oW7A==
X-Gm-Message-State: AOAM533u5eE1AGcVf5Pr3G72blsdGbECYApYtaQ5NwSHJ+xYGsl/RQtt
        D4leXe0O3sLvYsk8zDQnihsENJ4d6u6L9Q==
X-Google-Smtp-Source: ABdhPJxFG6jQpmVNCb3L8azxcwKUVelgg29tJPME+rlgZZkxAemGY2miagE/Z6Zr5VOCcV5RrI2/TT3sTBEdQQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:245:b0:143:c5ba:8bd8 with SMTP id
 j5-20020a170903024500b00143c5ba8bd8mr86206280plh.64.1637604022386; Mon, 22
 Nov 2021 10:00:22 -0800 (PST)
Date:   Mon, 22 Nov 2021 10:00:20 -0800
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
Message-Id: <kl6lr1b8qde3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/remote-with-fewer-static-global-variables (2021-11-18) 5 commits
>  - remote: die if branch is not found in repository
>  - remote: remove the_repository->remote_state from static methods
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
>  - t5516: add test case for pushing remote refspecs
>
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
>
>  Will merge to 'next'?

This got a Reviewed-by from Jonathan Tan; do we need more reviewers to
look at this?
