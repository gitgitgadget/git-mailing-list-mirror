Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87264C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC436113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhDSJLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhDSJLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 05:11:54 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949BAC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:11:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g38so37875111ybi.12
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L8aPf9kCZaQE7f/09C3TlzYmjksUeBIoTKDwqnIZD9Y=;
        b=NXWfqGTo2DpvSzT91K2rbp2Ov3KC8Y4Xj90ncDGOBk25vgDcGV8ueRuocfwETeTJZu
         JFG3KXxiPQRL9X5WDuqnRrab4gU3/Wc9yqj/xMute4QaF/lVkXXVnLVVE2GtliaAwhGE
         wuUoHREtGEtWAa1oEB9imW044SgWA8wNirQM/TIUAOfOrm5xNI0sZIaWZ03Oo+0o1/5P
         FKl+VR21LtYYosvYnjztppftCWrJpp/XAEk7QAhB9wTNBT35AcEHsDU8nWoSYQNfXB5G
         3h2aRzlEOcN002wXBDo0t6vFv8WaO5VTAo3y4NrDbtwN6kKSBI4VyBzeoh/jcJm92vSZ
         Yozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L8aPf9kCZaQE7f/09C3TlzYmjksUeBIoTKDwqnIZD9Y=;
        b=SGorSJat7rVjZcv3O0Vb9pk1Hxl7kOotpzmqF9Z4touhHL4FqPlpIV6d8ZsWyuE6bT
         5Uf03NQYcxjtfz/CoDNpIawLoQNqLtO1tp1ZMTYQgaCwuWbe0rVO7+SBWB1WizXwSjY1
         yKjJnd0a31kvB7xgUi+pPmD+0RdON+/xPbJT4wGNU3zT0fSBG6puDfB5JuFJhSFbxaWU
         8rdYo9Ev05FM87PTsYQ0MR+igpJ4J0U0mJPDokky72GJeLP4QLkE7WjrEpy1/Pi9g/uW
         e0pkdAddU7fznViqToIunwMKdfWLPmzyIHiFDKQfdgY3vHIP4lim5bUE6Mg+tJYBoDGf
         QYXw==
X-Gm-Message-State: AOAM530lHuC9FwKzmGAqpVzTVwy9NBJLnMTXB7LyAn13dcMxgYnG05VF
        h3+AlCiE0yrPWkYEk/2zH9TTdxnv8eKlskXoWqJwx2zpEljI+Q==
X-Google-Smtp-Source: ABdhPJyDX1Snjja85gq0uUa+sPYqbm/dZdjFhIbIFvdZtCxj2PZlxbL2BgN+YHsngkQquxPHm5x4i/LMr9lXqqZ7/ZM=
X-Received: by 2002:a25:ab88:: with SMTP id v8mr15015020ybi.500.1618823483543;
 Mon, 19 Apr 2021 02:11:23 -0700 (PDT)
MIME-Version: 1.0
From:   Cristian Morales Vega <christian.morales.vega@gmail.com>
Date:   Mon, 19 Apr 2021 10:11:12 +0100
Message-ID: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
Subject: git checkout behaviour when only ctime of file changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought you may want to take a look at
https://issues.jenkins.io/browse/JENKINS-65395.

Basically after something updates the ctime of a file, a
"git checkout" can behave differently depending on whether a
"git update-index --refresh" has been run before or not.
_Maybe_ it could make sense for "git checkout" to always behave as if
"git update-index --refresh" had been run before? No idea really.

I have seen this with git version 2.30.2.
