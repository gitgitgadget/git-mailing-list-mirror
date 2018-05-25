Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642ED1F42D
	for <e@80x24.org>; Fri, 25 May 2018 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030558AbeEYWlt (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 18:41:49 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42467 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEYWls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 18:41:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id q7-v6so2200425ywd.9
        for <git@vger.kernel.org>; Fri, 25 May 2018 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=muExcNWSlVTxXjY+jbjOWqo2ykTgCb/rJKrhFKxfRdI=;
        b=D9PiknDYtySldpshBVNENxP5y3jf6j2bnbRiINAeSHG4DqDdQO7iODnmPwuBP3yYB7
         OhZTFRDmVbY8F5hQx2n7+XuPhOp4ul9VMqB9Lrf168oh4hOluSeY0d3jud2OPrXdtblW
         XftEPN7hogWcj66MPuMRkjDXljRC/YNmnO6w1G2t9+xKbgKM+DHnaICzx1ZJ5j+T6eYw
         /Q8RclYN+pvdirNd7qzLYD52nCLAhrBqBMDpo3zCRiAWkpKz7LbZmOGlm4rYL3YtLMFu
         krkHFbsx0jvTklZlZ9oT23oCxl5ibT0qso1SkKPYVMF5YtYrtr20rOpC5RPWTRZBzj7B
         n2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=muExcNWSlVTxXjY+jbjOWqo2ykTgCb/rJKrhFKxfRdI=;
        b=r+PLvajy9mtsJad5FOAmWy5Cj1a8WHsYYLR9bGj8yX9hDD/HgaffI7rcW3rnuqv8q3
         L/iMVJVHWdKdBtYbC9Uii3/cCVHg4Fd85Ly1UQFbgqk8lq/Nh1q3vrL68I2mzO2UEjFl
         XSU6J0zCsJEp226Ua3Q+/eP+ANo7eh7huuaLZa1Vy4/vLJaOHkYMum449fImdAA08oH7
         t9gjlSlEYkhfZytb9/zZ/WnoGYYrBDNTiM8RloXZGL47ZEuLxeDL23dtrmSJ1oZOoNPx
         s3UBhEafHsTz6Vx7+/IalnYZ04f1sGTh+0eu5Zl13W8SwEKgTSz6CRIf2bIZSt5MvOl+
         jfuA==
X-Gm-Message-State: ALKqPwfEj7tH+KgIECzzmcukHQzwcN6sunhjn92N6L3RNiDRUt2DQGgF
        bB43NPUlL61aBYAMIKoB4h0hTfDCL9Y3LPMjNUVYVg==
X-Google-Smtp-Source: AB8JxZrkZUh8yPenPMi1PwDOEVCK85xU3Ssj+LR+v96B7LenJtHkFJWeQDQkEGtr4Aq8U3LHLU38YpBM7yz/AyDYcQU=
X-Received: by 2002:a81:b205:: with SMTP id q5-v6mr2467378ywh.414.1527288107500;
 Fri, 25 May 2018 15:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 25 May 2018 15:41:46 -0700 (PDT)
In-Reply-To: <20180523144637.153551-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180523144637.153551-1-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 May 2018 15:41:46 -0700
Message-ID: <CAGZ79kZ6B84Upx2HBzUTPcYnhiV=GkDU53Z6fC2rJGdsZb2-oA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] allocate cache entries from memory pool
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 7:47 AM, Jameson Miller <jamill@microsoft.com> wrote:
> Changes from V2:
>
>         - Tweak logic of finding available memory block for memory
>           allocation
>
>           - Only search head block
>
>         - Tweaked handling of large memory allocations.
>
>           - Large blocks now tracked in same manner as "regular"
>             blocks
>
>           - Large blocks are placed at end of linked list of memory
>             blocks
>
>         - Cache_entry type gains notion of whether it was allocated
>           from memory pool or not
>
>           - Collapsed cache_entry discard logic into single
>             function. This should make code easier to maintain
>
>         - Small tweaks based on V1 feedback
>
> Base Ref: master
> Web-Diff: git@github.com:jamill/git.git/commit/d608515f9e

Unrelated to this series, but to the tool you use to generate the cover-letter:
I think the Web-Diff only works when you give the http[s] address, git@
won't work here?
