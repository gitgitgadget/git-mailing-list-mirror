Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF5C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 05:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiLTFu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 00:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTFux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 00:50:53 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA91011
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 21:50:52 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o12so7699046qvn.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 21:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CV7ERNy9Apm4xH/dHC2sZHaPDTs/IdD4LUPOF7/WXI=;
        b=I/VD+xnbrurecdjd0G4zFx7GWYF+cHFJeQePvP/jxRYPGijeKpWtC91hy/XFKszM2/
         IAkL4ZnrEHyodzi5+FVDu985KH7NuZrq2/gJW1cm7zg5Nep2zJQSqVTkCg0WuXrCejYO
         k9WeUAxmaoKteednwdz/N3oxQHAfxC6slx5+tYF6a6qAgEOVIRwXGII8K73G4tjkyMdU
         MIxQidy6B6hdCZD5kksAQcCWaRCi4gnaclnlB27jqD5L/wAgcXlyBfSHPVhiUtpCOlUP
         nUDAOybP9xIeD7fyQ9uxpjL272E3xZqjRtapZj6Sc1roi9s3outoOf5SyC61qGtfzg/+
         4YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CV7ERNy9Apm4xH/dHC2sZHaPDTs/IdD4LUPOF7/WXI=;
        b=4B/L2QXHi2nSWmbCNn8CZV9I7GGDhUlKbvHowR3fR8FzuZAvM4SIdWcy67ZSNzz5aT
         z+mgzudGBEJZJ/8P0I6Ob4pkgDk8ub0az2mURQpSjQKoXUR3lMeUl/y7aD4OGTMOvlxf
         MYX23fve1rthdMabcIz8O8cGPgLFv1adtQHmlQhpgsvwSuv1ZG2tdvLL2i8g1G56s6JA
         jV1r+Gbf9hRDO/EuDrMOQkjWI7Q+demWY+JavQoyNoQFDdGkJ1rZBP0S28sbbaRD+1WM
         Gx03YYueYW8dsDuo31L0UGjEucB0kLTT6F3L+7WcJZbsJv2iYtkawR1Ku8xi/xej0+zq
         NDGg==
X-Gm-Message-State: ANoB5pkHHAi/IZEjb4QA3hF65QVrsWvhY1CjNgXMfc0NEDhP7MqVh0sp
        MkVLFeNCKn8mEym73oFZ1e3p44yMLK13YlH3rBQHbrSTezyQxnlzYek=
X-Google-Smtp-Source: AA0mqf7FBNxesHCXod7jhUroUcTjtALY1K8snvYPp3hiidqj9T+akPW6ef2YT1SQywO7oiS8aX1TqI5SLMM9JZiroow=
X-Received: by 2002:a05:6214:19c2:b0:4cb:4272:e569 with SMTP id
 j2-20020a05621419c200b004cb4272e569mr3675976qvc.48.1671515451851; Mon, 19 Dec
 2022 21:50:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
 <xmqqo7s3mzlt.fsf@gitster.g> <CAGT1KpXDHc2bqiiPqxwBiW2UV8BKMnbKD68hKa3fHdCA5GDAzw@mail.gmail.com>
 <xmqq5ye6zwin.fsf@gitster.g>
In-Reply-To: <xmqq5ye6zwin.fsf@gitster.g>
From:   Chris Webster <chris@webstech.net>
Date:   Mon, 19 Dec 2022 21:50:39 -0800
Message-ID: <CAGT1KpWgu6j-Rb3ezmO+Uwj_LgsgXDbyogkHV=y1099SAk3=Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Make `check-whitespace` failures more helpful
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> Do we specifically ask for bash in our .github/ files?  That would
> be perfectly acceptable.  Then we only have to worry about their
> withdrawing support for bash which would never happen ;-)

We use the default but the default can be changed
https://docs.github.com/en/actions/using-jobs/setting-default-values-for-jobs.
IOW we can always use bash if the default changes.

...chris.
