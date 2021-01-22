Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9EC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BE522DBF
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbhAVMi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbhAVMiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 07:38:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB79C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 04:37:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v67so7340122lfa.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uM5Cxjv6J5o1UoxiXUlknXEKeAqckGa0pZS+L5I9eNQ=;
        b=qBkI2oU4MdcWBCgNeD7Ccr+f8ET1UJ2JVHhCpXtCQdp23GZTf4akV6RFSIyyy/xnw0
         AlQKbypIZ56txn/xytcwY/KBS1ievnIBVD2q61fdhHOxJzXbU8CGoB2Fd1vmdLKAEc6o
         3sSiEk4Hi1ESPjn7neAX3cWzsXKCPWqguxxQn1i5QBMdgCtYU5FhrGNBjUut0CXHRkHb
         BPleMfKb1unvjd1UMX37p4EBOeF58EmbjdbRDRcNrO7SK5tU0Xzuc8uT1YSfQjJbGYl0
         eBRVx2jW/FPDtIfGaijKIkKh7yWRjr0bMX4B9zWPqfKJ1kFuQJQXyC1g6z+FtWva5JCs
         +x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uM5Cxjv6J5o1UoxiXUlknXEKeAqckGa0pZS+L5I9eNQ=;
        b=qsqkjk77udPs95EDDXXetY4HxQduqtYlh84gRTS6uK8MMdGy85ycjIr5TI+TIyZpo2
         AqrCoIF9XdV2UNnrHhIYEofvuekL2SLXnzu4uW8Br+c80yItdSaUyHQBW0C9yo3t4tpi
         fH2tD1Yer7mXuUo34FQ5YoG2x2u0BeZYnp7hrUIFyuRmSnixJQzdgD7mUPn7GKbywy6N
         6ONGmx0rURA6ydvdzNYi8tuEeKueFYBqnJaGTC2YHNxLNNgiedt04xda9PceogKJdx7R
         0JAJvYT0uJU9LB/HUvV4q5MKO9A4RT3XrPx+JZ+W7+avy2q3OFJCFzgzUb+NZv3sJmjI
         EzYg==
X-Gm-Message-State: AOAM531Y6q3Sf9VX2pJDiyryXKbslzZXX/QSZH6JHkL5Wzg8lK3TjBGx
        tKb2CBeu3GrgGQLTnrYBja8bkSJrw61tXlmw1ZECiBi9EY4=
X-Google-Smtp-Source: ABdhPJxTDmJA+e5ptULuddRpWrP33SjRC5lPZrQrDNIFikDK1e93aJBX+kJLLoukPD893EatlBRFChyfsD5VM9ckYwQ=
X-Received: by 2002:ac2:4ec4:: with SMTP id p4mr412185lfr.130.1611319061043;
 Fri, 22 Jan 2021 04:37:41 -0800 (PST)
MIME-Version: 1.0
From:   muzimuzhi Z <muzimuzhi@gmail.com>
Date:   Fri, 22 Jan 2021 20:37:30 +0800
Message-ID: <CAEg0tHQWH_Ko40K4bVghYH1cxJVJJWgfZAGnWO_1iVLvp83QLw@mail.gmail.com>
Subject: git-completion.bash: time to add --ws-error-highlight?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

git-diff option "--ws-error-highlight=<kind>" [1] was added 6 years
ago [2], but is still missing from the completion file [3]. Are there
any particular reasons for this, for example it is experimental?

[1] https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---ws-error-highlightltkindgt
[2] https://github.com/git/git/commit/b8767f791c15f119554c1466af60e4f2433ae971
diff.c: --ws-error-highlight=<kind> option
[3] https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
, search for "ws-color"

best regards
Yukai Chou
