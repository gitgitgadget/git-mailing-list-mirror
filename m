Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BECC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiCARgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiCARgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:36:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A197E0A9
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:36:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j17so21750391wrc.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=mYFH2tb0YE54KnwXvLfPulTvLY80PuG7PyQjjYW/+2Y=;
        b=mrl7VPIROgiiDrefoQeaRu2tZeHGD5NoC6cVJEoQXHGchdIlXURABERixy/+r88wj0
         oKHCg3urQqYiUM/TLJYFIID9y2X6pugIwf06JLses6gvr58e/v8tPQwlcDl8wNq/bKeE
         XlFpm9j3sAEN9veYXhJ1tV/O8tROeYjJ2c04c3w8UcUDkPrmeDMJ9kc0rj3QUhnLbt3j
         nZtLevHyY3L4MxUDxoGIc+PEud9hXLNt1PATLyGFx22OIuEhxgWAC+fb1aVDnYZqhSPa
         vpaKK4ZenTri6M/2evKQ2GleABHuaGHKVrEu/GscF/ckn30v7qi8LPwNwKfLbJ+hw7tM
         xGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mYFH2tb0YE54KnwXvLfPulTvLY80PuG7PyQjjYW/+2Y=;
        b=c+Yi5kEkmQ/yXhfTY4kfHrGwR/ti0bBry8ku34jaMs4w2zJCh8ADgcw8QaTUdm48TW
         XLXXdMoHEPHl9Yb7cMHiuI9gSJtc8rTmgN4WRD3EKJjQ1hjOlsvTsZWvkB+O7asfFETV
         fL0dJoVew2kYtGxrV2MQQe020gKT38iq4wmL5VwwguvQNCsPm3TpSpUgYo9YUgaXFJOJ
         D9UZNaDbistzxMtNrM8Fw9FhDM46EGrIMBGzW4bEmV2xS96x+4J0U+3JQlstjzL7FS4E
         j1E839jObtyFs+T/lqfRzGYjKG3a3ykHGgLSFLeznlCZX5AFu2EMLqTddrqvDCKaRxxL
         2syA==
X-Gm-Message-State: AOAM532jg7zAsEPTot4tzWv+bhvjunsHAcHMZMUi/MLcBB0dm6qXjcGL
        EdWwRF1xaigo+DhBH6ajTYuh4rjsP8ZA+Yo/Qqge/wavAtmSUQ==
X-Google-Smtp-Source: ABdhPJy3bS9h3VLs47d+NKd6n7ySkxqVkDu4Hk4iqY+F4i2iTvyjZi5o6nUBKQCA4voEaaa86vdhBg+UdAVLa41A+Gk=
X-Received: by 2002:a5d:6d0d:0:b0:1e8:7b6a:38e7 with SMTP id
 e13-20020a5d6d0d000000b001e87b6a38e7mr20548308wrq.625.1646156163518; Tue, 01
 Mar 2022 09:36:03 -0800 (PST)
MIME-Version: 1.0
From:   Ed Warnicke <hagbard@gmail.com>
Date:   Tue, 1 Mar 2022 11:35:52 -0600
Message-ID: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
Subject: URI Scheme for git object ids?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Has there been any discussion of how one might represent a git object
id as a urn or uri?

It's clear that 'git:' is registered with IANA as a URI prefix for
locations of git repos.

I was wondering if there was any existing use of something like:

'gitoid:${type}:${hash type}:${hash of git object}' ?

So for example:

gitoid:blob:sha1:261eeb9e9f8b2b4b0d119366dda99c6fd7d35c64

which could be used to communicate generic git object ids.

Ed
