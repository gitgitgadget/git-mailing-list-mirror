Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C9C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 19:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJQTOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJQTOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 15:14:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6A7657A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 12:14:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f8so7296081qkg.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=493BC/ePCcq5vA1Nc9Asz2vl23CHMxXtwIiKHK0NTvw=;
        b=BYkO1i8z/TMD2EgtKrZTCMoa473A8cNmGqjrrSoY9OcXvnOXfeCyrKLEjUobkJxsct
         9dupC+0qsamv3jxbxjfxDMScVPZm6JIVcFj5jB1sIK16ek7Ckitn4Zz52Bkhqsi9omYr
         HuV+FIp5Qc1t18iFXtUkjDfjn98fqBcDIvLIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=493BC/ePCcq5vA1Nc9Asz2vl23CHMxXtwIiKHK0NTvw=;
        b=2tc9uVaZRNUrn47ZylouCHTCYroLesWmYfPKbddSoRDyJFeeLcyVDkzX7G34ZCv3VL
         2Dxj1nVqR+zVL5SkzpK4IEMc8My5GuEL7eI9S5Vwingz4BNDlcH2JtpTqYeGarHTauji
         Qbi6/aoBQZw3V6ap0WYOvyEdXx68StEfzjCtZog0zOOGT64vKbf3d58dEukL/wlO3cN3
         O6CAYntHxGMPhPdi9pG2q2sY/Bd6gqzHOBUu7+mwWFrH0SbDY7RMDAl8jaORi9VKae1C
         QG2jA/e41aBAadvlpg2Blr5oWdpsELdt5hbyyh82OzqNUKSXl+aRs9iaps1u+WLr/KLf
         j56A==
X-Gm-Message-State: ACrzQf1dtODt4Oc0iq5yQ1k9bKm3kb3igdaH0sLc3nVhQ09nNFI6bXKp
        Vw32X6Ysgt2/H/r3reb4Ah5M1UraH/1iDg==
X-Google-Smtp-Source: AMsMyM437TPqOyhKd5NnZwXLjq4qFn0tDgbddlGwGqXhflhNuFT+e5B58CvMbf8d86UlxivVKKB1ug==
X-Received: by 2002:a05:620a:2942:b0:6ee:e447:c3c6 with SMTP id n2-20020a05620a294200b006eee447c3c6mr4933529qkp.434.1666034048794;
        Mon, 17 Oct 2022 12:14:08 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id y4-20020a37e304000000b006b5cc25535fsm394409qki.99.2022.10.17.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:14:08 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:14:06 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     kpcyrd <kpcyrd@archlinux.org>
Cc:     rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
Subject: Re: git 2.38.0: Change in `git archive` output
Message-ID: <20221017191406.uimmmmr6c6eiy56t@meerkat.local>
References: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2022 at 11:57:40PM +0200, kpcyrd wrote:
> I don't know if there's some kind of gzip standard that could be used to
> align the git internal gzip implementation with gnu gzip.
> 
> I'm not saying this is necessarily a bug or regression but it makes it
> harder to reproduce github tar balls from a git repository. Just sharing
> what I've debugged. :)

I've previously complained about the output of .tar format changing, but I
think it's too much to expect the *compressed* output to remain the same. In
environments where CPU time is more expensive than bandwidth, it's entirely
normal to expect the administrator to arbitrarily adjust compression levels
without any warning, or, on the contrary, pre-generate and cache
zopfli-compressed archives.

-K
