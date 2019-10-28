Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5003A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 23:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJ1Xy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 19:54:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41980 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfJ1Xy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 19:54:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so6552145plr.8
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mraueuAcCwIbc44OUg74G7YGDtbHdKHbVmKjePHhJ9E=;
        b=llBTvCXDpXvZ2Ldh61w+3ujQ/QIGWc4yrz5IDcLGiBgxaGrypqpoo0AQu7D6rLiyAr
         qzAEz9U74Fll7d8GIjg7mSTN8aPDFM1G4K72sZDIIkB/ArWnvYKejiwiJsXF2Sjr/tnd
         LvxtMnCt4cyzMo23TbzNNxT8G0DhJUHDtXjZh/Ydod5CW4970YmLuhXcmvAAYR/AIaea
         C0MWcW/VsvqPyvYAI1/Agxrms6w+gegYfLMBCO/XsW5cc0bjVCmGve4876cU6sOPtJNE
         tUbGCLycd7D9ShB5niXDKWa64zuiiUwUi1kVDkT5dkUYxsw7r/ww2MqJakmrW182GNaN
         bk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mraueuAcCwIbc44OUg74G7YGDtbHdKHbVmKjePHhJ9E=;
        b=lcJcZ4jtOBR4L3upbD02inKjVj8UPceAtW4akzfKbaaq1ocdS0m7KZn7ZmvJ2P5luD
         MKTe5j69tpH6NqYPdmJEB5gd8u0e2+KKknTx4cV3iljF1nZUzpM3KQv5TTRBqi7mf8KY
         XPky8/VmZAqUoLZozKCtPndoH7e7XKCK9NeKYy+Z+k+wlDACdoEqQ/9PPyEwyVIJDIrF
         UCpSZAjOQyQGLaI8HOtrW3PLeeWmwHrL3FD3V7nyu8pwpJZQMmi+eAWaMHCb3F3TQfvE
         Q+vVEX/XsAZbM3GPtBpLB9nwv0Rjt/xaq0IPQ852Nx7X5M7wZS20zRqSM9sizov3KtDY
         BSSw==
X-Gm-Message-State: APjAAAUXyDqFCEPZIpLZOYh9UoJdNlU/DYSL5Jgu5zqTTqE658iEaaYs
        f0c552o+z7hum95ZEGu0hNZ71CLD
X-Google-Smtp-Source: APXvYqyr0YNmPbnCtAI2uQzHbC0vDSDLsIywancd0HoCq5kCvQZU58jQWQHqtuPmBy1IStLMnyp6UA==
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr775923plz.167.1572306868397;
        Mon, 28 Oct 2019 16:54:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c9sm12420517pfb.114.2019.10.28.16.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:54:27 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:54:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Mihail Atanassov <m.atanassov92@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/git-bisect.txt: add --no-ff to merge
 command
Message-ID: <20191028235426.GF12487@google.com>
References: <20191028220122.21449-1-m.atanassov92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028220122.21449-1-m.atanassov92@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mihail Atanassov wrote:

> The hotfix application example uses `git merge --no-commit` to apply
> temporary changes to the working tree during a bisect operation. In some
> situations this can be a fast-forward and `merge` will apply the hotfix
> branch's commits regardless of `--no-commit` (as documented in the `git
> merge` manual).
>
> In the pathological case this will make a `git bisect run` invocation
> loop indefinitely between the first bisect step and the fast-forwarded
> post-merge HEAD.
>
> Add `--no-ff` to the merge command to avoid this issue.

Makes sense.

> Changes since v1:
>  - removed comment change

This kind of note, that doesn't need to be recorded in the Git commit
history, should go after the "---" marker.  See [1]:

  You often want to add additional explanation about the patch, other
  than the commit message itself. Place such "cover letter" material
  between the three-dash line and the diffstat. For patches requiring
  multiple iterations of review and discussion, an explanation of
  changes between each iteration can be kept in Git-notes and inserted
  automatically following the three-dash line via `git format-patch
  --notes`.

> Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
> ---
>  Documentation/git-bisect.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Except for that one nit,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[1] https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#send-patches
