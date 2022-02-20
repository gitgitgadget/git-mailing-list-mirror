Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD62C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 22:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiBTWip (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:38:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiBTWio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:38:44 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31840A32
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:38:22 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q8so14013945iod.2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjRud4YVsM3bR/ntxVi8GkMK6D6cCNpF/UaZOA7A2P4=;
        b=Zt4DG/XWXMWLbb2q4w+w23LUad7g8hIOkU1wJR00fAkPfTjsj0TgATBZWyWzO2OQgT
         Cw0p+fjUEerlpFagOZ9kV7xtxtha4Zvyy8FhZ0B/3YQO/RGLXdeoUfQZvEo61MEZT4mI
         3sGyxjvxGHB5vmnFijHUHt8WDsa6Kg9AniAe55Qt0+wad93hzLjDlFgFGcNwKupFcuBO
         naWXaJaRlrTtPa7LK5Nczg8Co8DYhLsvskKuDwwrZ5M0en8SpQHZ+7f0/U7r8oUaXAJm
         UTrAAi9x7wNaZ3l2lxVoCy7Asc8lkdhdmUXJih2juOO2e9RuPKL542uhwG958m9fp11s
         5aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjRud4YVsM3bR/ntxVi8GkMK6D6cCNpF/UaZOA7A2P4=;
        b=tbjLdjezGQxIea8WW0meONAaGYmQ3SkO/WJoHydkqlF1VtF9/Ubiz3bC4LyGNz02He
         A7gtdEYp1FAGUE8qzQqLDnwkLFqydzOPpC5v9+jPL2PMB1OPo/N4hrUr4n9Fy2G2FerV
         A1PeWtgv8mz5f4sKkgHxdoW1VvKLipCvIqXJhzJApzVSJ42z69F9XvwdM9OeZm/Dx+cE
         17cz7q0yzg6jFt8Zny+DC3drce2XYTJ8a0HCfuMVzPFQi2w849HAwQmpDl9jZgmRwvs9
         BB+oQwsGXy6lzFosQM7YlKnGgd3d7+BkdVSHflB+6Rtp/QDS3nueXcPzPp3XHPE0TIF3
         fHmg==
X-Gm-Message-State: AOAM533P09L/l5dDtN69q8Z0OUbudaLwuJNqGGDGJ4b8wJdZMnmIfB/v
        B4JXQ4Gu5Npkpk9YZ/X0u045AA==
X-Google-Smtp-Source: ABdhPJxBXt/DasTAsBQMYmZLl1/R2I7rCabesz9mnI+Abmz1L51DQjd/YyUuFq/hhjT6fVZjETcmkw==
X-Received: by 2002:a5d:85d2:0:b0:5ed:a17c:a25c with SMTP id e18-20020a5d85d2000000b005eda17ca25cmr13780647ios.85.1645396701729;
        Sun, 20 Feb 2022 14:38:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r7sm6818253ilm.14.2022.02.20.14.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:38:21 -0800 (PST)
Date:   Sun, 20 Feb 2022 17:38:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Updates to worktree code and docs
Message-ID: <YhLC3OVuRpAbxrhY@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:54:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> This is built on top of ds/sparse-checkout-requires-per-worktree-config and
> includes some forward fixes for comments from that series.

Thanks, I took a careful look through these and they all mostly look
good to me.

I left a couple of small notes throughout, but I wouldn't be sad if you
ignored any or all of them (though see my notes on the very last patch,
where I think you replaced one too many instances of "working tree").

Thanks,
Taylor
