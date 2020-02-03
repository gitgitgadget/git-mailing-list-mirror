Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D52C35249
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 01:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A9A20679
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 01:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otmJpMtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBCBQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:16:17 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:43842 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCBQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 20:16:17 -0500
Received: by mail-io1-f51.google.com with SMTP id n21so14825087ioo.10
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 17:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tWhKTefb47EnFQ8JjqyJF9vapqX6oH3uopjcrqhG/rI=;
        b=otmJpMtEH2dEUrcrQrzXHkkdGHJgfFlySo+PN9PTnDWyd7IhXraG1IB6YfgKrYlPPt
         HJR2K6GQZDISYC/47CU7OhGWPCcdi5bVjmBcoYpeAQZKCKz7jY3RPDKHL4893QA04iFr
         gC4Mqd5pJUITasPrv+NzUX52z4uIeDL2TqedsIzgPN7wcLq6d/5ljKVq8KhARVJZpHyK
         tJ7TY4BW+Rg2xvaHTBKnB3JOii3jXJR/PMUS4i8UgdR8LS6SvQuv+7HL1gxHmLYqDxy+
         EaL8Q/I36GClFp53bOUXgLuNOqOiAxG14rnZFYw4w46KVmYvmvqlqYGC2bEw8X9o2BUY
         YHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tWhKTefb47EnFQ8JjqyJF9vapqX6oH3uopjcrqhG/rI=;
        b=CqmuuXjAESMKZHJz+M/uJ0WNKVXlvw7/dL0PKzXmbVIaNvXsKMDbeDrzquJs/+ziRj
         v9HtmP6GweNVtuCAeS8UAEmphtNZF4rK7Ei+op2JuydPJD2S2lx2slE2UJBGRKVwIoGn
         JNTV/4ZYf+Ki7CdUMDxaHKNHfa7PnY0ZmSwX9cC5WuDQUSN9maUXdcUiFnvKCpGHkrJ5
         WUisPF3zY3yRbh1JgJYw6QO6NEni7tGLqxUU4oSFrR+ClEQwVWc5SEza581nn2l55z/R
         F6jVESItTBHUpPYiLqjwqzle51vr6rzFG73wE/V0j3PnT2ns+QALxiid59/wdt9q85ds
         7rsQ==
X-Gm-Message-State: APjAAAVzVZJO7MH3+bs4gUqB5Ixw/1kaDxQOcZGMvyn3aXYBRtbfM8fR
        I4oITSg84UNmX+fuqOoSVgq1v2/WrOMjavmOmT6/bUHD
X-Google-Smtp-Source: APXvYqzSjp7jRd8nOvrQ5apL+0J8qFBFj9/JpncH3WT2l/9Kkhx/Xz0CwBMLidlbSjDqLaf/djANw/pa4tojdLCDCaU=
X-Received: by 2002:a05:6638:a31:: with SMTP id 17mr16852921jao.15.1580692576654;
 Sun, 02 Feb 2020 17:16:16 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 2 Feb 2020 20:16:05 -0500
Message-ID: <CAH8yC8mmq0eCvpmmzKXNSW0wCnD7ApZVUGceJ4BsP+by2GF_RA@mail.gmail.com>
Subject: rm: conftest.dSYM: is a directory
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

This old wart just caught my eye on OS X 10.5:

    checking for egrep... /usr/bin/grep -E
    checking for ANSI C header files... rm: conftest.dSYM: is a directory
    rm: conftest.dSYM: is a directory
    yes
    checking for sys/types.h... yes
    ...

Also see https://lists.gnu.org/archive/html/bug-autoconf/2007-11/msg00017.html.

Jeff
