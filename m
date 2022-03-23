Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D0C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiCWTVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiCWTVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 15:21:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF5887A4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:20:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c4so2063590qtx.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LFsok2YAXA0I/RXpzAUNh0jJ/F8dfUtRbzVotqKQWEg=;
        b=sW27UbOE1ZOjchxGrYt3MVRzfEOGX+X8IdfyytMe8TrshG/GsuBpSji28byTMuEnXE
         jS+cq1Gsfod13fW5/ZrT9CQ8dhKv4BoNSY8rLE1vA6Vgs7bHDSFnkm6NrsbVBvLZe2WH
         PWYzLzJQfwDci8zhQVcOY6Y9VvqJmhCsHVxfeSEpHStfXm1CNoW57gNyD/yAAUykQhYe
         wuGRYgomeIA64c4BaX3eVTuxzfzwenrqWNcK2tFNHmX0V3K5uyDCPBX18wA8YACdZXeB
         oo+koHGHHYUy91UmJW6ESUBzv6IJ/0RJ5pQtI2uU9kAs+AFRn8yzI8Yj6j0AQzyvbMQr
         RXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFsok2YAXA0I/RXpzAUNh0jJ/F8dfUtRbzVotqKQWEg=;
        b=hSy3OH3n0mkwI2kY3b4If8AHOOMhodkrMbOdhJe43FqrdXoxzjCgBhx+JnlxXyQJpz
         jl5+8ZrOrM91iRSAfXQRTuzCLh4o9yIIBdscse6UhhD60LAdsrfW8de05SrUqyoy38dk
         tP8FSYBwMAfXbJ0WKlGs0IjkkxjMsqJh/9ERgxL9zXj/mVFMFJw6nAZQqypesfOtZxvw
         Y4dglkIX9RrLenE489sXqgOXP7i5tuWflq3KBRTsYmoOdyHgm/m1x/N7+auLcAhxvViX
         21xud4/VuS1pSMzsM8HyPuF+yxC1w+pg+1aG9LM8raIhpeKAMef2yWxRt4kez1zgpGfJ
         LeYQ==
X-Gm-Message-State: AOAM531P7wCOC6Q7Pj5X4Hv17S7+OAJd14Ty1z5t3IiAcdcaxCVnlvZt
        mMpWA4oEg72TrpxH8UCuEg1QK1wPt23GWzzv
X-Google-Smtp-Source: ABdhPJyLflqLKylIfUuUvPeVmtc9X4659vA5wQJ4RuGOepDbJhMnKYkl7vZjlQM6+kCX1ZjXfFfUMg==
X-Received: by 2002:a05:622a:4d3:b0:2e1:bc11:3b97 with SMTP id q19-20020a05622a04d300b002e1bc113b97mr1246589qtx.189.1648063222101;
        Wed, 23 Mar 2022 12:20:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk15-20020a05620a1a0f00b0067e5bd7a9ccsm439171qkb.50.2022.03.23.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:20:21 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:20:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
Message-ID: <Yjty9DhYLDfz5Oay@nand.local>
References: <xmqqv8wcizi4.fsf@gitster.g>
 <YjkloVk0BTqcgIiL@nand.local>
 <xmqqo81wsewt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo81wsewt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 11:27:14AM -0700, Junio C Hamano wrote:
> I think <Yjpxd8qhwnAIJJma@nand.local> yesterday is the last message
> in that thread?
>
> Let's see how well it goes.

Yeah, that is the last message in the thread (at least, at the time of
writing this message).

Jonathan had a few suggestions of things that we could add to
Documentation/cruft-packs.txt. I added details in my reply where they
were unclear, but I'll focus on touching up the new documentation in a
follow-up set of patches to avoid delaying things further.

Thanks,
Taylor
