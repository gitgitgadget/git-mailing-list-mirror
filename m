Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0E31F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeERWbh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:31:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40373 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeERWbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:31:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id f189-v6so4387592pfa.7
        for <git@vger.kernel.org>; Fri, 18 May 2018 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0gLraXYGmv7VsUbBeSNg+dEBUx8YfLzGvyhIIBCxMc=;
        b=gohRYasCoolsUt9dJes6/F1f90U6yC+/4sOA9G7/mi1lYVV2esMb0LR5hMBrvK2c3X
         LuWOp1eNxzN/5WGylImAoK81YGrh7rgvhSgrGXcOj2buj4JjpO6TSfoGu14TcZ20SpFB
         1sxLNhZKYOd/TIpZglWWYsf0NGVeRC8quRiobAm/fuPxCNzXxceymPHniA+e/rLvEG9L
         bBZeMsN/X+73LmX9KHogu0RL/Br4DXGJDAGmd8vE/XAWU/mguAA3TAvyP3TuNdDYY6ec
         wVU/xxFkXGxvaA/luG50wSqXgqPeZWnak4JBRH/TIBNcP/dLg7SubwKJ9YimsZAQwBDi
         3CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0gLraXYGmv7VsUbBeSNg+dEBUx8YfLzGvyhIIBCxMc=;
        b=OOwoVaZbUfLpj5gHUPuGh/+09PFUZUnHJXXTIny9uiS+umGjWvFTs/TT3KyaeCRGMx
         1euNTm0M1x6eeLkTSkBJCnzExHgw3Rv1/tpKOZwa4EUx4PFsn8YwGqjL1M7HbLj10Ert
         ud7Xi7BRNuGJ7qQY2a+TYS+LtrVCckmvnOxHXDWjg9cvzhlOO4P4Lbc0MrqO6PKJdX1K
         5OD95AHMz1OrMXVV511uKbIhzNikvXR2syCpPJn3//xIBNiQyugQa47g56gvLaYMIj9a
         934wv5RpopTSWx/8GFccBWj9e6BwFXHPDfGFUPjAKPtGAB68iOkNQYERbB3HCkDlXLFt
         2gQA==
X-Gm-Message-State: ALKqPwceeVanfdRalE4z9tUIIypSMtKOLQjDw200rmmpVTdOfULajsHq
        3hmVtbd3ifcdB3Vvn+aG1d33Tg==
X-Google-Smtp-Source: AB8JxZrvqJ004wFgTc3LFLUK+KH21D0Gw6LyTrHYF5TJmEAbl+St7qfZQpDWVgQIhO6lP5kXlqkbJQ==
X-Received: by 2002:a62:ccdc:: with SMTP id j89-v6mr11272674pfk.182.1526682696378;
        Fri, 18 May 2018 15:31:36 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:75fb:b3b2:8793:31ee])
        by smtp.gmail.com with ESMTPSA id f2-v6sm6823436pgp.28.2018.05.18.15.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 15:31:35 -0700 (PDT)
Date:   Fri, 18 May 2018 15:31:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] config: die when --blob is used outside a repository
Message-ID: <20180518223134.GA56823@syl.local>
References: <20180518222506.GA9527@sigill.intra.peff.net>
 <20180518222704.GB9623@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518222704.GB9623@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 03:27:04PM -0700, Jeff King wrote:
> If you run "config --blob" outside of a repository, then we
> eventually try to resolve the blob name and hit a BUG().
> Let's catch this earlier and provide a useful message.

I think that this approach is sensible. Let's (1) fix a SIGSEGV that
should be a BUG(), and (2) make sure that we never get there in the
first place.

This looks fine to me.

> Note that we could also catch this much lower in the stack,
> in git_config_from_blob_ref(). That might cover other
> callsites, too, but it's unclear whether those ones would
> actually be bugs or not. So let's leave the low-level
> functions to assume the caller knows what it's doing (and
> BUG() if it turns out it doesn't).
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks,
Taylor
