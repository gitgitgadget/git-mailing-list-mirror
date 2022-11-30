Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4725CC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 12:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiK3Mlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiK3Ml3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 07:41:29 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905464AF2B
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:41:28 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so15932603pgh.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4kv50m7Cu/TDwU2xz7VbnS0XiCYjjU3hIyskhsm3to=;
        b=hgI3584DADOwm5P1k0AR9axEh0lNHr/8m2zBzejE6v2I3CuxW9wB+/z+W7KCIWr2Ww
         mUp4Fr5wOv0E+65rV1/A1s6sLSnQe00xGFCqIFgL+dCbK8rKXc8UMRlqoc/D5GEqNyQA
         V3eiVCGKtBXbKpxJeQNyZ+WC0GjY21zCegP61FT/Why5ONFoBmWfEe8Jt0PH3mdSu2Pp
         +LZDueH+q63JEpGbez8KyFECoxJNKXuzt2Jqrdm9egUpkbsKE9zPacAwyaq64+q5z/zE
         mmKPHaMwpD5R6G4DU1xoxTVqHNWspIB1sYXcxx/p7/qEC6k57MW5Ya9JTeQh4XZmCf50
         5dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4kv50m7Cu/TDwU2xz7VbnS0XiCYjjU3hIyskhsm3to=;
        b=nyzGQQKNUKqDMoY42Gzxs/bYlSZcgfjKezw2tvOg9Jew7xgpHd6ayBgBO6ZS0Ye0ST
         Hqp7LML7mBRX4hQr2wMlNFGghh8dOkR4+YcU8mkNWhjpnlV0yd6Skj4rFfbPkYkS2Eau
         cvKlmlX9uoXqpxE/qBLYFdVgMr1FRKX10A+p4FNnqwzihtCIgcf1z/9ySW1rkK/dA64u
         QcC8kip2s5JqReuyGlnJH/JfT66FZaohTuU49ua3Y8Hr2GxWY3OWgQxvFrDJI/6SqoKX
         92xtohsZpPTUhwM358ovLVpNjp9JGkJ5nIlu1eCt86SUn41zPEJcjE0T5XpwovRZHK4G
         aoGw==
X-Gm-Message-State: ANoB5pnmnwy3N5mIJVlD8fwU1ZZRdwx/84N0Ft1jlSenX2szh/u0DpMh
        DA0N2y0VWmgQJpE8u/P3mtU=
X-Google-Smtp-Source: AA0mqf6UInI2P4k1LOpXiniA6Q8euF2HKWLH+tWTt/5e/jVnbjqCMuCB87SlpPcBATdrkSTkd+0gUg==
X-Received: by 2002:a63:d14f:0:b0:476:95a8:de78 with SMTP id c15-20020a63d14f000000b0047695a8de78mr39997106pgj.66.1669812087943;
        Wed, 30 Nov 2022 04:41:27 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id k12-20020a63d10c000000b004411a054d2dsm919234pgg.82.2022.11.30.04.41.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 04:41:27 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     dyroneteng@gmail.com, git-packagers@googlegroups.com,
        git@vger.kernel.org, gitster@pobox.com, lwn@lwn.net
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Date:   Wed, 30 Nov 2022 20:41:21 +0800
Message-Id: <20221130124121.97048-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <Y4ZI21F0yYxMk3O3@nand.local>
References: <Y4ZI21F0yYxMk3O3@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> > Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
> > be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)?
>
> It is rather late in the release cycle to include new patches. I
> wouldn't be sad to see them in, either, since they are pretty low risk
> in my opinion.
>
> But I think a safe assumption to make is that they *won't* be in 2.39.0,
> and that you should resubmit all four as a new series once 'next' is
> rewound.

Thanks, it's unnecessary to hitchhiking after I read the reply of Junio.
