Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45986C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B90F60241
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhDWUcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:32:36 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37479 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhDWUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:32:36 -0400
Received: by mail-ej1-f47.google.com with SMTP id w3so75692595ejc.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qt6c1mx7kK7DgbHBAgomeg+afMcDm015ScMU6AkhQ54=;
        b=nezuWoUWGmfyCI6XPjjVqPiySAe+ksbX+lyWlVaZDMeBnpWt2qZitEXjgd70wrXdFg
         SqDdgjy07IIKzjVmIhHoaeA1qCaWwCVl+M27hCClwL/sI/t7UvWdItdexjGZqDZduT6X
         AYrlXsCRxyNx4LVJAfDeHK9gsSgydbD7ycXXpFysfWn5JnM/zv8ur99jS9dnArU2ezCE
         PHRjNd9oljxI7EUSFSvfOmBLE5iK8sSqEpRcmoH1+FEbie+izY48xHI9B8hmdvcy9pG0
         WYye6cZsvSEgoMlwzvjZ+nHj8BcxIc6o8R3ZHXnT7gyUJCqHA1frcIo34Shnp/SZpqN0
         DAng==
X-Gm-Message-State: AOAM531VOqOCjMIEzucDDXpjJppXRJqQv0FY4ubSEfWUImD3vV1paFfi
        X7JH+1BvnhQZn4fibce1O1rxx0VN/9hP2pcd0tw=
X-Google-Smtp-Source: ABdhPJxuV/OwAkrSgbJJNi8F0lbMf76JQ/bsQQq+cYBUFq0PjGE2iEdEiwSI4urjFjL4zySa/e2Qwmyyv/GlSdV8iUo=
X-Received: by 2002:a17:906:6d41:: with SMTP id a1mr6226622ejt.482.1619209916869;
 Fri, 23 Apr 2021 13:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-15-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-15-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 16:31:46 -0400
Message-ID: <CAPig+cRcBA1y0WY_k4fge1KiRcLrW7PMeOS=Ns8bMa4VMdyy2w@mail.gmail.com>
Subject: Re: [PATCH 14/30] subtree: drop support for git < 1.7
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> That was nice to have when git-subtree lived out-of-tree.  But now that
> it lives in git.git, it's not nescessary to keep around.

s/nescessary/necessary/

> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>

Is there a higher reason for this change aside from "let's do it
because we can"? For instance, are subsequent changes going to take
advantage of features only present in more recent Git versions which
would be painful or impossible to support with the older Git?

The downside of this change is that, while git-subtree may live in
git.git, it's still just "contrib", so people might grab git-subtree
from a modern git.git but then end up using it with an older Git
installation. That's not to say that doing such a thing is guaranteed
to work anyhow, but we don't need to make it harder on people if there
isn't a good reason (hence my question about whether subsequent
changes will actually take advantage of newer Git features).
