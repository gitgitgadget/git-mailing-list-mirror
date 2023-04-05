Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DAFC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 05:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjDEFjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 01:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjDEFjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 01:39:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1019B3
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 22:39:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q8-20020a17090ad38800b0023f116f305bso16795324pju.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 22:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680673159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQVOIsAT216Zdt+yPCme0lvW1EPfL9zmkyJTYflVC6I=;
        b=JGIp2a6zDo+f/m/iPLB8zbs1RbxNGVGSM0wgw6Ys47kp6piIHU20dAtJKmv3NR9RVe
         9XuIMXI/Wz8U1DypXjEaSIMkpUn6+0kMPeTi2jFxWti1uBLpxtkmsKNV3+Uz2/BQ1uWk
         beIxAQWWaWBGAE1wtgwixtxx5OvSMlIiXarbZj0CDWptaRxcWz7N1tlDuOly24rjJhZI
         BjrbMxn8b02nUwmOgIoP9FxyLS2ztWsDM6ME8k/YzMHEHVf9uq33aOQso1KwUssJViuH
         s9RzE/VxLo8VU7zm6d62cmGLthDz5XZ67A4+o1AkPdiN9+4XUs+1kYcmFo83fITe3hyj
         vKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680673159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQVOIsAT216Zdt+yPCme0lvW1EPfL9zmkyJTYflVC6I=;
        b=hhZL1lSArQCDm3F5WpGhFfFFisxhTHIqyhvEgGUXqmcdzsB6sO7VE/8S4iyc808Wbv
         ZPLWmtdpg2I6VZfAN2OJsYjBW6OQV6DJlPvgr1W4gNsqcGXflzptRt3hLcevLWFrQt+R
         TX0KDZ+hh5pjkv5G70kguYfMjBg/yPBw+B8XmpqGDv4fB+IJ62qwwJI6cNQHdfUWPikn
         XIgXq9XK1YuigpBo8b7HMka6yJRFtmpnZBF8oh5voyx9DXUq6Rw+N8MZDVZiozDR4dYK
         E1BOyN9CZegk68lGyhVI/df6rvUmqdu62WzwLiYUez/m3CtxUkOiAwx5Epk41QYyCoPu
         MMcQ==
X-Gm-Message-State: AAQBX9cTRO+K+P0Adohs7mTrQSGxsVXgbLFzBp6gT7sMxVUaFv8WD2KM
        jHJOqFGHrbzRtafLliE9yypHqkj5gTE=
X-Google-Smtp-Source: AKy350beS6bZfKTxVZWDEObMoweq8XLwPgIdjgG0DpIVyUbUYO5dl1Rtl2y+2+w+uVFadwMu7SSsT22tdhQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:2b09:b0:23d:33e5:33ec with SMTP id
 x9-20020a17090a2b0900b0023d33e533ecmr1836072pjc.1.1680673159183; Tue, 04 Apr
 2023 22:39:19 -0700 (PDT)
Date:   Tue, 04 Apr 2023 22:39:17 -0700
In-Reply-To: <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com> <CAMP44s15E0xJwXv8qGp8FqQvB_KaxS2TXenNZNH_VzvXpXv4Hw@mail.gmail.com>
Message-ID: <owlyzg7mubui.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
From:   Linus Arver <linusa@google.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Felipe!

Felipe Contreras <felipe.contreras@gmail.com> writes:
> Small nit: with this change we would lose the quotes, which are
> helpful, I would rather do "`foo`".

I see that the doc currently does not quote backticked areas, so this
would be introducing a new style. I think such a change should belong in
a separate patch.

That being said, personally I think having the quotes around the
backticks makes things harder to read, especially for users directly
reading from the raw *.txt file.


> And for what it's worth I would revamp the whole section, something like  
> this:

> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1136,18 +1136,18 @@ information on how to handle comments from  
> reviewers.
>   We'll reuse our `psuh` topic branch for v2. Before we make any changes,  
> we'll
>   mark the tip of our v1 branch for easy reference:

> -----
> +....
>   $ git checkout psuh
>   $ git branch psuh-v1
> -----
> +....


While I see the four dots (....) being used to denote regions in other
files like SubmittingPatches, they are not used at all in
MyFirstContribution.txt. So I am not sure why we would want to change
this.
