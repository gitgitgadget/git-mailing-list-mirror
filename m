Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B501F454
	for <e@80x24.org>; Wed,  6 Nov 2019 21:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKFVgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 16:36:15 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48372 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFVgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 16:36:15 -0500
Received: by mail-pg1-f202.google.com with SMTP id q20so5949700pgj.15
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 13:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/q551BE/JaIM5l/FCo8KYQoh/AB4dk1+N89XrlEhACc=;
        b=ol0p91GU8sDphWNUkY5VLzSLQ0jQRg0kL0CK64WAcFAEr+MwbbOj/hDDvGXQIIzzIr
         YjVaKSptaZdfufn1UtsgwOw+aZuKhYWZagfstnlJYkwxXRbvHqBakF3ZCWuvi+AgZcrv
         rSiO7oL/fiizaukkE9aGXFpY2IB72WMH5Cxdf62vCwjilCLi/YTuRCZgXEmljM7gt2kw
         mUriFQoM3+XYi0UJ/zKo8XSbmboMkwPUaWuYSYW/a+G8aA/wTtNHiQp2ylkqwEN4teHE
         QXDurIo4lhnDSdloOmGUqkG4L4o8BldOXd1I6fofmZ0fJA//u1fRan/PFKTPNCQ2M6KW
         PdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/q551BE/JaIM5l/FCo8KYQoh/AB4dk1+N89XrlEhACc=;
        b=C/6vQBmL6PY4W+CbD7nQ1ltPASh+tQqAa2xiPJX/1jE6NJ1wE74AGAdjjsOmaUyPiH
         A39RGZD+BVUg1P7l2R1Nvs6HSAUG1QeBBlZ876KQAPt+GI6Bh1ylACwLkXyaNGMoySkT
         GG2OflyAQbvssUgxgOV4JIHDiGHBXtDIz3G5qS0C6CF9IopDlhYbn3PJH4SIfULYpf6u
         FjJ9da15C7kz7kL1tIbMXcSVjTZbeSOQtxpnk84aR8BBd2T02wi2RahXAZDKxPC3j2ak
         ElPK49xoag12NJ4unMcIrzouoTIOuJsvvbMg+XvCKHhpGbslCxtffJ4plYst3fKQrsXL
         6DPw==
X-Gm-Message-State: APjAAAXUXBta8wMNbi6NL5WuL5rJ2ZlU/Ym4C8N5diwy7YMiTZMgzU8N
        AAG9XRb5Rn8KtXvPUBZfBu6vuK3OrHpcc2UJE4B5
X-Google-Smtp-Source: APXvYqyRLnFLpCqAEVxThhfjAYnqeSKRk6uYnp7DSwwOiURvkjdrywx7gOiddHCvRXFFpPxT508SWoYKGSDBn7ue/h1G
X-Received: by 2002:a65:5a02:: with SMTP id y2mr31774pgs.104.1573076172843;
 Wed, 06 Nov 2019 13:36:12 -0800 (PST)
Date:   Wed,  6 Nov 2019 13:36:09 -0800
In-Reply-To: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191106213609.57464-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, workingjubilee@gmail.com,
        git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Also, clarify in the commit message somewhere that this commit does not
> > change the behavior of "git bisect".
> 
> s/\.$/ when used without the "--first-parent" option&/; you mean?

As far as I know, "git bisect" doesn't support --first-parent, whether
before or after this patch.

At first I thought that this patch also teaches "git bisect" to support
"--first-parent", but that is not the case. Only "git rev-list" learns
to make "--bisect" work with "--first-parent". So I wanted the
clarification. (But if you think that the clarification is unnecessary,
that's fine too.)
