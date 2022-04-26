Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B7C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 23:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbiDZXh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDZXhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 19:37:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494069CC8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 16:34:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so162294wrc.13
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Owzd5tnNedylg4i3XesV50G1SCpLa62gECKvXfx09cw=;
        b=EaGDIPUV/KHSwIr3pCG0iXmRmQnvksTfti2t8joYE0UfqAj9ByIxZwRKE+qi2LuCop
         7U3z+7vF2wY43S82Xj+trfu6rZifRl8w1fbAOTgdAzUxlRUb/bLdqJOp3hbcMnvSqg72
         gnKCLfe5ocjGmLYzMqWDlvF/+z5bPFvOrjo7gRxQc6YsR16iXL9emflX6SyKVOD2Ix8e
         tygaLI7rHpM8jC0prgQSNvij5yPhaUGdjDoYvXRb4kD50/ZURCAc+GTBHI9mntKmaNLI
         LoSb/21jmeUVY28RNMebF6Y5aQ3vV7IVDVZ3Y5+ydqQb1gyev7G2Sap5hrpGc6errmVH
         ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Owzd5tnNedylg4i3XesV50G1SCpLa62gECKvXfx09cw=;
        b=TmUXWwyRyeNx0r3r9DE/5r6nHkfT4MWfNRCKOmhWBxl1g1LcANIIgarEgzP8aWN/oJ
         57xann8h64k4D5V0k6vBqVJDPEw9oc1DGqZcz9PFU6McF0WkO3Vsd36uR5vEm44uhq4s
         0fM/AKASzOgqnVodvoP+lS1Y23gdlUv0srVkP/Catqw6QCzf1r+UffwpfH4kmEK9SjBm
         G2ViFzmjAtw7yT0uznKo1MTGJao+i3F62y/0CuyZRoA7ee7CNXBNUbWJui4mta3klgcU
         O2pU6ang2p/DZwB5zwkP9m/7hqoteeZjWEddsZLYJD8jIGYTGIjv/5XRuQS2D539AzV+
         yX0A==
X-Gm-Message-State: AOAM533EigJtqS2g4YMaAc+XFE104NWC7eEkuyry7pBPdLQoojipA2Oi
        mrK4GQxmYGSwF3rAHqdL58D3Sm1x7kNhD4ggG+c=
X-Google-Smtp-Source: ABdhPJznj0L6ewKK+totV3azm+tbLMtyPSxp+DQMXBsdzQj9lBUia0T71eHP56etlMImXmRXUiWC6C3BauuDqOOxAek=
X-Received: by 2002:a5d:448e:0:b0:20a:de9a:a7f3 with SMTP id
 j14-20020a5d448e000000b0020ade9aa7f3mr8343511wrq.129.1651016083686; Tue, 26
 Apr 2022 16:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
 <pull.1225.v2.git.1650988659280.gitgitgadget@gmail.com> <YmhkCAbmNE8A7Wqy@camp.crustytoothpaste.net>
In-Reply-To: <YmhkCAbmNE8A7Wqy@camp.crustytoothpaste.net>
From:   Drew Green <agreenbhm@gmail.com>
Date:   Tue, 26 Apr 2022 19:34:32 -0400
Message-ID: <CANDN8xGh31E3VwgRUb6YgFuswiyYjzJwK-tyvmo2c6KY+pOtJA@mail.gmail.com>
Subject: Re: [PATCH v2] Added Curl Option to Override Request Method v2
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew Green via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Drew Green <agreenbhm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 7:30 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-04-26 at 15:57:39, Drew Green via GitGitGadget wrote:
> > From: agreenbhm <agreenbhm@gmail.com>
> >
> > Added support for environment variable "CURLOPT_CUSTOMREQUEST"
> > and config option "http.customrequest" to allow setting the Curl
> > option to override the default request method used by HTTP Git
> > operations.  Primary reason for this is to allow support for
> > cloning repositories where only GET requests
> > are allowed by a local web proxy but not POSTs.  When cloning
> > a repo first a GET is made to the server and then a
> > POST is made to the "git-upload-pack" endpoint.  In some
> > corporate environments with strong controls
> > only GET requests are allowed to known repository hosts (such
> > as GitHub) through a web proxy to prevent data leakage.  Using this
> > new setting, a user can set the "CURLOPT_CUSTOMREQUEST=GET" env at runtime
> > or "http.customrequest = GET" in their config file which will
> > change the second request from a POST to a GET, bypassing
> > web proxy restrictions on the type of requests allowed.
> > Tested with GitHub, changing the request from POST to GET still
> > results in the expected behavior of the repo successfully being cloned.
>
> I don't think this is a good idea.  It may happen that GitHub or other
> servers happen to accept a GET request here, but that is a bug and
> should be fixed.  It is definitely not something we should depend on or
> rely on, and it isn't a documented part of the protocol.
>
> If your corporate environment doesn't allow POST requests, you may wish
> to use SSH for Git operations instead, or you may need to explain to
> your company why you cannot do your job with their proxy in place.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

Brian - I understand what you're saying, however I don't think adding
this feature is detrimental in any way. It is simply leveraging a
feature of curl without any promises of resulting behavior. Why not
allow users to take advantage of a library feature if it can help?
-- 
Drew Green
www.drewgreen.net
PGP: 17BDDD7E
