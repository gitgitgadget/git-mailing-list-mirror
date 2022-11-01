Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F26FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 06:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKAG7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAG7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 02:59:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D7FACB
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 23:59:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so20559901edv.3
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDhC26Ml8k0CTk+ICTpafBUwXMKY8HqmsdIhLUjISqw=;
        b=lI04jCAikowuMrh0X9aBmFPpunAKFzNCn3uoCBGdrlP/OUVXw3qZgbysRwZRYHhGS6
         7i7koZDXvqQp/OBRz7AqacQYWBkHMxReY9IRcmzd0UgiZ6M7t3+lqOjyQEfM43YiAfIk
         /0hmiT8AqohpKCyYTgAWIr90Ws09DVFo30W1YDIYmf3WyqthcIXHm/YlIhAeIb15iow6
         I02eRMwkUAIv779DbwrWpo3TCg39jjGAIVY3Kyry/jKjmfyZWTyd3gfh3otFcfM98iUB
         epcQ2cbHf53GNvKGwpzrfcYJG+fA5HwxtyPeOQ5fo5rzAVL5+FqFtaSw1gwIXN5zCuuj
         lHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDhC26Ml8k0CTk+ICTpafBUwXMKY8HqmsdIhLUjISqw=;
        b=2QsowCfRTO+ywClS4HYn0v/ZK9b45NXJM+dA9g5hJtFGJi+QaOfkFVvlxYuVVImERq
         Ld6Ql4I2AvF1He72rjC2kHTX9OVE9P6s62WbwwI9VyaWIKbzkJZACkJ1Dc4fx372TCYF
         Lo2LSh6FdNUWyskQJKQh7YYhHgebrzUcoj6xzaG1eSujnjWS/KfJGA+yB+O86NwyISC+
         jwvKW+fjY8s4ngOp/vYmO17G1GOXgv8bFpxX7Yy4fovDLf80AQC3itEgua0U68K1jElw
         lBd9SnX2B2Zd3PsvGV04/Nnb21WJuDK6xXA+lAdDbS6IJ/1Pd/OT68vXT1YN7LVZ1tGq
         KyRQ==
X-Gm-Message-State: ACrzQf26Nu1nK3Q8U5PYlVildUljDs3MrNagr89aKWxWRVlVpnzr38tD
        BktHuWLQouu80veor1qWMyRAKX0trOmZp957Xeo=
X-Google-Smtp-Source: AMsMyM4uVsunzuLi0bIne1BVZyPOKJxIPrkL9QVFYtJL6OCMlZBtzYfg9JonL/YCZfTBFNLh18Q8byCa94mk4mu5/6c=
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id
 n13-20020aa7c78d000000b00454fe1d8eb1mr17346248eds.59.1667285938980; Mon, 31
 Oct 2022 23:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
 <xmqqczbdl6wl.fsf@gitster.g> <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
 <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
 <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com> <xmqqcza8dlkn.fsf@gitster.g>
In-Reply-To: <xmqqcza8dlkn.fsf@gitster.g>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 1 Nov 2022 12:28:47 +0530
Message-ID: <CAPOJW5xvrESGNQSMcVTwPt+fF0t7V-iB6ufjqjqYxn85_xt+bg@mail.gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 9:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > I HAVE OPINIONS! :D
> >
> > Mostly, there are two things I'd like for you to keep in mind:
>
> Nicely summarised.
>
> Stepping back a bit, we do not care about how the sources to some
> pieces of software we depend on, say OpenSSL, match our style guide.
> It is because we do not even have to see them while working on Git,
> but also because we do not have to maintain it.
>
> So a third-option could be to fill pieces missing from the upstream
> (e.g. big endian support) and contribute them back, and after that
> treat them as just one of the external dependencies, just like we
> happen to have a copy of sha1dc code for convenience but have an
> option to use the upstream code as a submodule.
>
> Assuming that such a "they are just one of our external
> dependencies, just like OpenSSL or cURL libraries" happens, I would
> not worry too much about C11, as long as use of roaring bitmaps can
> be made an optional feature that can be disabled at compile time.
> Bitmaps are used only for local optimization and never transferred
> across repositories, so you having only ewah would not prevent you
> from talking with other people with both ewah and roaring.

Seems a good option to me. Thanks for the info :)
