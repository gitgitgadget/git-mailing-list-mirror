Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D156C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F6C611C0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbhI1Gl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Gl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 02:41:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859AC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:40:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so86783917lfd.12
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=QYjRQZFQMBEeOl9YWvKIyBWfESLZ9fvwyMWPUtB0zHU=;
        b=hjfwN0z04zmBhZCyVLysPPBhl7lzbROy00IJjCDA7Bv82xJSjV8/C1mzHytBG70nA9
         9b0Yjz7lJ4Uhb0RmO6JgnLtBlbXwY7vQ8J+pSS0m9eu+bpzixPYRAf5LPcDDjXyefYLj
         6K34ALk1kdrQk4WwCIBiYgRMj/5n9f6ICLwB4hYWuOBaskKviGG2tOUEsHfJsdrkg3AW
         cSrQdRwl3H9KKjj9IwwVIQ/RkebWPNf77yyW1WmgCDrUrDEs/G3KOWY5uPyypv5LlYE/
         VCOMDEqZaAfjG8/9qD3Nd9rH7V1hTXrIqcpWJlqQ5PuPpFQVn62VxDuVUZeChHVoFcWE
         rLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QYjRQZFQMBEeOl9YWvKIyBWfESLZ9fvwyMWPUtB0zHU=;
        b=dZRKmTmid2UokkHKxtSQWrAzoiboCa37LVqPcaO+4DGFX6KmCgPu//MssGXLUG6QYC
         c+/cTs4SbP5TocXNXgS5+rKau9kG0go3Z41SGJo9GOFjbbUGEFeKsz/8uTUw/Z4fCUco
         XQ88fomlhNbF6eYcTzW+rauzKo+QAcxIywx5RCBhavmADkEeycHbkn8CUXPL8D2MhWBb
         PfDIaJQkJAF+tbpG9wjaLjQWGO/GY0dhID8I2Gvb8dRcno2XmB9K1TzTPrNJlk8DxYFd
         dittK0SEh4XHi530etdG5YCCnQ/b6WhQibmUWiz/CtsIwEaeNtoZbIzE/FIrl3yE6CSO
         C5fg==
X-Gm-Message-State: AOAM531RW0nTnU6KtGmNOhucF8VMtKq1bCx62b+3WB847lugT3SP+uMy
        lwYh+aev0aNDcZnCkDcL6PeryK1K3zL8vv1uMto1zDp8+UM=
X-Google-Smtp-Source: ABdhPJwk+RqPOeroZ4ZXO1CZEnfI+2iAZvGvPq2s1zWajaE44besTGeBu8/W+KJO5mePnaA1lMiVyI/SMq5CT6J5uOk=
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr3882166lfo.207.1632811215519;
 Mon, 27 Sep 2021 23:40:15 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Kendzia <kevin.kendzia@googlemail.com>
Date:   Tue, 28 Sep 2021 08:40:04 +0200
Message-ID: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
Subject: Issues with newest version of openssh 8.8p1-1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated to openssh (8.8p1-1) and git didn't get the keys anymore.
Couldn't pull or push. After reverting back to 8.7p1-2 it works as
intended.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Updated system packages (openssh)
What did you expect to happen? (Expected behavior)
Can git pull without issues
What happened instead? (Actual behavior)
Permission Denied due to key error
What's different between what you expected and what actually happened?
I couldn't push pull whatever because the keys haven't been recognized somehow
Anything else you want to add:
I reverted from openssh 8.8p1-1 to 8.7p1-2 to make it work again
Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.8-arch1-1 #1 SMP PREEMPT Sun, 26 Sep 2021 19:36:15
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
