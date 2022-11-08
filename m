Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D4C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKHUhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKHUhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:37:06 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83D60EBB
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:37:05 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q5so8060310ilt.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ErHj8YvsXecxKaOtO3xyPVVQSet2p8XNEjLWLDPfc4=;
        b=cT7rycv0w+HgukVkTzrMMZOD/lYuXwTBqYmPcgLH2Z59fKwwYm24K9bt28AgJk6beT
         5rBKbBNsflfL23qbloYUVfqSIex4TTPH3KyJlCWOKJKA/7oJgNnrc21236Lr/vTpmMl2
         VIFBI1IU7T+5c/iATPGZ1sKIVLD3zwqBZNXMBViopvwIbwwzDI4a1KbNd+NChQZuybhQ
         lln3XvhX+bQZsGOMhR7KSo0hwXXZAEN4LMxG6bhGLMSA3WCwkx3nNbruzOP9o/7KjyE3
         vjYaLgaUQvgZClgvCNkSgtPOTbtAI+Kf+BGULBtinLRxrq2ih3lcl22bcT8nQ8HeOs2N
         m4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ErHj8YvsXecxKaOtO3xyPVVQSet2p8XNEjLWLDPfc4=;
        b=W7rWlgC1rV+OzkwyepwXV7lBtyNJZNzhlEV0dB6H4oa4FAx96eltGcXyU3D85HeBUi
         OFFlpsU+GRm99c8L1JM55HvXqW9tM6CyD2Ldud6he57NdjEVtGL/njKKLFP15dn9Dzki
         v7bbGcaRmbGvaZIJK8KlDsxG1HAH0LQsB8WXzwxipSCkOMyFf/+q6jOn/HfwojAyx9iy
         rirG6FcgLyxq0MPZTcFippT2kW5lN9fStkDeLePkXVedu4a920aEJon2HHRbpAWkCgmt
         X+6pk76mgkdWOnfKagntobMwyokWBR9Br/snNuBbDZ0id4yqWdzN6m3sl3rwWsjZvzPm
         u6ig==
X-Gm-Message-State: ACrzQf0kXabDTE9zzcc6//nnY8pWqnqPhxM3/NaaT9CwmPQRcthISjxc
        F6aEcZE2Fv+edzonicF7eikSTA==
X-Google-Smtp-Source: AMsMyM4V/opywoTtvaLDtoZFELrtcK4ty3uLjB+cuWeIlP4UFRsoy94oF2VmBxH1iFe+1tqBn+HyxQ==
X-Received: by 2002:a92:cbc8:0:b0:2fc:b8b7:484e with SMTP id s8-20020a92cbc8000000b002fcb8b7484emr1047208ilq.122.1667939824537;
        Tue, 08 Nov 2022 12:37:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n11-20020a056602340b00b006c0cb1e1ea8sm4561032ioz.12.2022.11.08.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:37:04 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:37:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: use a newer `github-script` version
Message-ID: <Y2q9723uEtfkJrah@nand.local>
References: <pull.1387.git.1667902408921.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1387.git.1667902408921.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:13:28AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The old version we currently use runs in node.js v12.x, which is being
> deprecated in GitHub Actions. The new version uses node.js v16.x.
>
> Incidentally, this also avoids the warning about the deprecated
> `::set-output::` workflow command because the newer version of the
> `github-script` Action uses the recommended new way to specify outputs.

Thanks for working on this.

I also appreciate you taking a more minimal approach by avoiding
touching the explicit "echo ::set-output::"'s throughout the workflow
definition, since there is other work going on there.

So let's merge this one down, let the dust settle on the other topic,
and then come back and remove the remaining ::set-output::'s later on.


Thanks,
Taylor
