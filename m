Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DCEC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 03:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F93613A9
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 03:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhD0DDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 23:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0DDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 23:03:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB97C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 20:02:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j6so980916pfh.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Gf+Nl5bFH+5syaUwH65r4OGlDLwBxqjcaySaS4Qvynk=;
        b=YpxFkqg7mZJzRmRgaGHSXXwmQMDqusS5aFIjU+a3wX0NoJ6CrGQ7fjwPK2yA8sipnl
         xfaFfaFeGyVCgA572ByvHPXtM0UfUTZytMTuwD0YJIRFfAbaO6yDfvHhJPXGqC6YthdL
         +UTO3suUUcEr3A/twmzPS2HPq0HGR5YFRpguPMCaK+LdwjOmEIC0RJ9gnGueT0MeK6dO
         CwX4E56od4jNrF48Gu+F2Q3N85h032yYwllL8Uz4FPZLOQMNPiORgvdpRZeAmfwpq+fe
         c1kjFYuKwNEkhCo3yAK6fS6+wrL9ylOk4anH42bB695mlz6ISYBB+96UyDZ8aWjxHqCw
         yu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Gf+Nl5bFH+5syaUwH65r4OGlDLwBxqjcaySaS4Qvynk=;
        b=WB3eYvKc1qo6q0J2RkgPRVZa+oeSzWFZ78Upzfg47w/mI/+6VwS9kKNWjZ3xtASDyL
         mNXIW8JGlHPmwvuV0AK7UQFNRhTmZXDnrtzCvZ+FdF7sTUfGj40t/UDNY6DrrpLq0n2M
         oQEsuEHVN8h+ONpIqrwXnCdUgxoCTbq/1Af5lRHPKb67RWMUoHkNUucKhoayidd4DjLf
         qFW1bJQtyBXCOdFPKc+llcLimm+B+9Ahwi2h8/pgGuSLcqylBz7jp5WmWYHe15J7EOrQ
         F5KHaEz3vftR18qT635ljTzFdxzS/u7ePC83npDkh3j+GK2EX3T5yzQ6qQlsxORm82fJ
         hACw==
X-Gm-Message-State: AOAM532bUHhWwpF3Fok9Mtp7Jxcjihu67b+2OHPw55q2E0yuUKfK3sI5
        2U+8gxvnBK1wzdw4h8SG3s/49jT4GzLIPQrKNlrDOm9K5LMdhfdy
X-Google-Smtp-Source: ABdhPJwZxkttu7ajNl16lGYjgT77kXIiejR1uUzm5fTyAiNvn44oVnk8xvI0JGqVfEOdkckv5Y9U3Umib/OhYcA3Lqo=
X-Received: by 2002:a63:ed58:: with SMTP id m24mr20463112pgk.248.1619492550227;
 Mon, 26 Apr 2021 20:02:30 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5ruV6b6Z?= <dyroneteng@gmail.com>
Date:   Tue, 27 Apr 2021 11:02:19 +0800
Message-ID: <CADMgQSR1rWW694tWq3aJgPuhcfYuxUA_L9vOdjNrWXHpypaqQQ@mail.gmail.com>
Subject: The way to maintain lots of packfile-uris configs?
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently I read about the implementation of packfile-uris feature, the
server realizes the mapping between blob and packfile-uri through
multiple configurations of <uploadpack.blobPackfileUri>.

I have a question. If there are many such mappings, there will be a
lot of <uploadpack.blobPackfileUri> in the warehouse. If I want to
maintain them (such as update and delete), it is not an easy task. I
know that there are still many works to be done on this feature in the
future. Regarding the above point, I don't know how the community
considers it and whether it will do some targeted optimization.

One of my methods is (maybe not very thoughtful), is it possible to
support an extended method, such as packfile-uris-hook, through fork
its child process, interact with pack-objects, packfile-uris-hook
default implementation Is read from uploadpack.blobPackfileUri
configuration.

This method may not be the best, but the focus of my expression is a
scalable method that allows the user to flexibly decide how to
maintain packfile-uris.
