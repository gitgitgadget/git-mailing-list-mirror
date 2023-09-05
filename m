Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD80CA0FFD
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjIEP7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354747AbjIEOEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 10:04:25 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349A198
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 07:04:22 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57325fcd970so1571162eaf.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693922661; x=1694527461; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kiIYkSD/FhpDY5bsFdRfVC21s+cVQOThB825G8USG8k=;
        b=Hf85dR0cuNlZuFQuJntvlQGkyOtlmVU3yI4+q5RVOWf1q54/Uvjs1zMjcao42IxWdj
         n63Gz8HCt9p4wy56J/fGUBRhwe/TE7w9fjehygMrdsHQ66FzKsQADXB6Syuvu7D2W4PM
         Om+YNHLfwPbmvodH7hzkGILvqcEWK+0vimcoy1eJinHdZRPbvNTOYbczdfV9scm5wMrw
         Zv9SoUQVW8l9+K/Q5y1izrMLS+uqkKDvTh8RR3D+n1wr9dsWZBVTQZwV7ISlT/qUYNNb
         4nUE5f8YlejC9/4eHralUYrNPgG3prW9UcbNtarpk6A15cKVATfxUDJsClxjkIwHkzbf
         oiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693922661; x=1694527461;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiIYkSD/FhpDY5bsFdRfVC21s+cVQOThB825G8USG8k=;
        b=i78izezHxeTCnyCDO62j5fdQGy0kmHQhNlr2Hv7N9ZaSyOjCHPYksDvlf+dYpi0LV5
         GtUGSdwljYjwPykbOcWGv4F1MhHn/IHjljMK5EysyVH9nIjo8qrA2uzSIKUxBcphNKoK
         GdIRnGkyGf7CsIcSEdM1ufXhQkn8nw8NWZAIHDLPvVjuRHFFjzhvnpza05miiTlpb1os
         Wy61HOct5GSfKRk6rBdxslAHSTwFkAXq1GKauG9VlpyVQOtmkqPCyRf0LKanCzohEL6u
         BICLHib4QaBcEqnLfhNKd1CXVhRKxamlBtFRvzTb/pkYY2SFlx4Ulkz5fuBg8S8TgOE4
         WCFA==
X-Gm-Message-State: AOJu0YxJrvGLP/Lgg7w67/N0ksUAzlxsFg20tbfLVUvKzqscn7gwHQ8B
        oBuz1VUkRb8ZvfwzUlUj/RbevcnIZ2GYoDw80oitLNA5
X-Google-Smtp-Source: AGHT+IFw6sAlR+3sHk30kCmgTMrQElBthySy+e0YqyQnBQWtNcF9rR9wwo2vJ8ahZ+0YglnUXVE4Y/VmoId7aCf4KdQ=
X-Received: by 2002:a4a:6c11:0:b0:571:aceb:26d0 with SMTP id
 q17-20020a4a6c11000000b00571aceb26d0mr11521028ooc.2.1693922661510; Tue, 05
 Sep 2023 07:04:21 -0700 (PDT)
MIME-Version: 1.0
From:   Riza Dindir <riza.dindir@gmail.com>
Date:   Tue, 5 Sep 2023 17:03:06 +0300
Message-ID: <CA+ek4BEgQn6D4woazdxo_YmsNpnR-_Ym6GsuW7WtOKtwc5Qn4A@mail.gmail.com>
Subject: git gui - add new tool command not working
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am on slackware 15.0.

I have a problem with git gui. Yesterday I was able to add tool
commands. But today I am only able to open the "Add New Tool Command"
dialog using Tools | Add. I can not close the opened dialog with the
esc key (the escape key can close the other dialogs that are opened).
But I can close the dialog for the add new tool command using the
cancel button on the dialog. Also I can not click on the Name and
Command textbox to enter anything.

Is there a log file that the git gui tool is writing? What might there be wrong?

Regards
