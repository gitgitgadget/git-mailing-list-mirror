Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C338C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjHKRin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHKRim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:38:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C926A2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:38:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589ac93bc6eso24151577b3.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691775521; x=1692380321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YC6N2j9QdcXJ38MCKF4ECcZrRPqdqCq+9MXeZ3gjUyI=;
        b=Q8nTTzh2BKo9xh100fr216i6zOUCwqt5GqB0a1nonCUvlrYFgLn/AyhvAYGm5NcENB
         AxzFoB511ubj8JhNMd5t2JK6fCvoK/BbUv5q45Vc35O/XQloXO/uPth/m0mR/ocV9OdO
         F2CLWP57RCjmDrD8CrmXU5P7Pgp14r0nFEPqwS5+TfTXWvylCHWH3KzVUEJe3CtkIVWr
         idZstXJUcLx5XB1N0ylk69m8WbhQVjCxEnliT+EE9QJAXcBw28tx683w+XEhLTY2e4ch
         4rTynaU9v0K0Ri3fHM/SOyks6E3uAYPhozOTZiFa1fA8tni5WuhdGArxO4sBKeo0GTZQ
         J1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775521; x=1692380321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC6N2j9QdcXJ38MCKF4ECcZrRPqdqCq+9MXeZ3gjUyI=;
        b=Ej+JFgGsDHXvBIewDKxdF0yQbMTdF3ONP1Y/3KnylsXP37moI+UQzw5z5S4nlLYVNn
         8XwM9qO/mr0sp2407BIYjc/uinsgIhG8lA281TReDUfT3JhcOnbQjuuVilPghgN+UyeV
         /bvefdhHIFueKQcSBchck+U8Bq66LS62WfN2dy5xzO9cA1MAGswDHM3G6whCNn/P00Kw
         Alssgh+L9T7P38CjKSAwQa9YZj2cOgLvVMYeW9329ZXpYFN+B7om5KJ+RsBDJl3cys+q
         jzNCJFTRtHBDdwQ2fkIIWpZqkaBASnObA/G/wv+CB0x59glKc0UGLIZWLJOkiAomnDnW
         r5sA==
X-Gm-Message-State: AOJu0Yz9T6/u3MWNIvcc62Y6Husogz52MqZHaUDdIetcC3CDCWBRql6e
        KNiuYt4CAar39WBwqkZ8z+FYYJ3oSmM=
X-Google-Smtp-Source: AGHT+IGFsZgSQtG1sO3tW/PmrzdLYzHITFro4Uzjcwepg7hUcZDELfHpAR2wi2ws3npd4GQB5f1Q4YX9Dos=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:ae63:0:b0:565:9bee:22e0 with SMTP id
 g35-20020a81ae63000000b005659bee22e0mr43086ywk.0.1691775521475; Fri, 11 Aug
 2023 10:38:41 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:38:40 -0700
In-Reply-To: <xmqq7cq2pd7o.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
 <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com> <xmqq7cq2pd7o.fsf@gitster.g>
Message-ID: <owlyh6p5fpi7.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 00/13] Fixes to trailer test script, help text, and documentation
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> t0450 dies like the attached, probably because the documentation was
> updated to say "<key> or <keyAlias>" but a matching update to the
> output of "interpret-trailers -h" command help is missing?

Yes, sorry I missed this. I already have made the fix locally.

> A possible trivial fix to 13/13 will be queued on top as "SQUASH???"
> patch for now.

Thanks.
