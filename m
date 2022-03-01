Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFBC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiCASb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiCASbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:31:25 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192501DA49
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:30:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g24so13641089qkl.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQGF4A3QLEIkfmysqpvw8KtircBLsismUp/CbTIj/+E=;
        b=PXIAmaBYp7OxUfdf294axGyuk/wmOb+DJpZHAvm2Pkiv7dtbg9D0vHKHyEtrqTxc64
         2eWIknlFrCiTO/N/T+YKn70G/f2RZ5V5EWGtr3Tmj7ztVFkl/FUSqz26Br9t0o8zH1eq
         zF6Zcx6AW0GDgSQKL3uHRjp+F92vnokjbhpS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQGF4A3QLEIkfmysqpvw8KtircBLsismUp/CbTIj/+E=;
        b=uPXLHQPdQqLkB1FbeDRHJvEFA0PVSmPi2XUIxNTxvkhQv+x5UWavce+XhOqswxbuIm
         O9lmcrf5i42P1VmiFGIs0e3mYTJkQlgW2rIc0z1Jd649oGQZvfKnbzxUxLaQxoBWF7nV
         oNzgvnfsoDY7R5IISc6SVZe4X5QtDkGn3yfsbctkrFn4P0/TNFaRgzmWkZjSU8yu5jPq
         I45dxBcuWgxDA/JeI8/ZAKh6j0hTQJGtSO2+tMg9OH86lZNxN6cWp94OPu1Nhbbn1ybp
         x2n3DAPSRMDG7Q+LaS0woSrfdw+LQmzyVtVrS961aQ0OQK4Be/Av2KuB1GHKcS3VO6qo
         Olbg==
X-Gm-Message-State: AOAM533hstMmYUnRPIyqXbmGGMUgtVWim2f2SMX5ltnwGE/oqXIJFFZh
        YD8tejib6oOyoGvaNRmKM++qYuYotnaPvQ==
X-Google-Smtp-Source: ABdhPJyG7r+AX9RFlQENqn9n3iQoUJRVfD+/Dm97ps8bSXNskcpMXJFORurKITO/b7c9viEtqVw2Og==
X-Received: by 2002:a37:2d85:0:b0:60d:d69d:9f28 with SMTP id t127-20020a372d85000000b0060dd69d9f28mr14403733qkh.227.1646159443123;
        Tue, 01 Mar 2022 10:30:43 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a181600b002dd4f62308dsm9426707qtc.57.2022.03.01.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:30:42 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:30:40 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ed Warnicke <hagbard@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: URI Scheme for git object ids?
Message-ID: <20220301183040.rvj6jb2mfc46kv6t@meerkat.local>
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
 <20220301175334.ctem25nxckynnvco@meerkat.local>
 <CAFVSqg3i_ANc1sTmEHaxjxxdkkN9HbUEUwejV5S5V5tM2fhWWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFVSqg3i_ANc1sTmEHaxjxxdkkN9HbUEUwejV5S5V5tM2fhWWA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 01, 2022 at 11:58:01AM -0600, Ed Warnicke wrote:
> Konstantin,
> 
> I suspect you read a bit more into my question than I intended :)  I
> do appreciate the breadth of your thought about it though :)

Ah. Sorry, my perception is understandably tainted in the past few days.

> Mostly, I'm just looking for a way to express the git object id as a
> uri scheme so completely outside-of-git things can refer to it clearly
> (ie, know to prepend the object header before hashing to see if the
> contents match).

Okay, I understand -- so for purposes like adding to sigstore or other supply
chain tracking systems?

-K
