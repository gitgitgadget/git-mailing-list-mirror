Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3DBC76199
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A52086A
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjlnup35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBPNPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:15:23 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:44511 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBPNPW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:15:22 -0500
Received: by mail-qv1-f47.google.com with SMTP id n8so6419904qvg.11
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q9YyP4YabUj+gozcTk92+3nJoqKMqWTO8ZKkVcWBGNk=;
        b=Wjlnup35VvP7gvSacxEliYM57JuW/6jHcSglnsoeb4L9BpX7jUMxR/gCb2aQPTNbol
         ony8OPj2/GOQe7t1h3f2xOTmIE2MYh1rvdrCQIIsDRkXbteIgKZas3P3haN0gW4gjgFg
         qK0ZpPjYZuNcZ/lKdp7MKq56T3DTifZhDP5vKYIUYHoceB5s9HOzbAub0hX0TOxAifQI
         iS2Y6dVQ+Or89+9uOKTO/IInUrZokGWjDwaxKNP3kfzf1wewD0n9fMhW7LJkBsYy9hPL
         FWni6NnC4nO1s6s32p01htrnDouty2Gc2KK0ZMIrF0674AvyNbBCWzXuHu8t5/ZKxRMC
         i2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q9YyP4YabUj+gozcTk92+3nJoqKMqWTO8ZKkVcWBGNk=;
        b=hj+yCGL5AZDkIqRNeNd+RZOxlUndNrT7TZdbTbFZX3fRhgldKzUwABnTM8zt+2pg5s
         VILsdbe8NJzohz2aVgNDsbw28K+LVjEatGz4sMCDpZlIhWhMijAnMhuqB2XkBAXnkwtd
         X4UlgtfEsq6LJQtB9u4W9tthZeV5/gd/2STG6wJOzQFuFd0kPFrbXM2OjL1imhtAhvfp
         O5ty/yaMb6qzHFtpS6D7mNuexSgEYqhhc36nWOgnxFEEDGFK8c6ZD0GDD4c4wtWOxvWi
         YbK8rTY1EPlG/LsmtKYv7CEUpugWIteKZdSGxr84hbFdKH6LQ87kHjLZK2Kimv60D9y0
         UmTw==
X-Gm-Message-State: APjAAAV5PrHndJvJZ1fXVced4kOrSAI+VGtN+ClfNmChXaMVyjW/SJu5
        8sY0zd0Kbqt2zAi7k0IiUXjr3C708AliAzSDi4gEcMrqA5g=
X-Google-Smtp-Source: APXvYqzJlRMHRTr4DCBVzoPsceEDOfHzYYrDywldC3kaOoU8QhU+IBHk4MBHWJqi5sXzchuOLqo/qUC0pT5Qlg9Ozr8=
X-Received: by 2002:a0c:f193:: with SMTP id m19mr8775272qvl.154.1581858921670;
 Sun, 16 Feb 2020 05:15:21 -0800 (PST)
MIME-Version: 1.0
From:   Giovanni Tirloni <giovanni.tirloni@gmail.com>
Date:   Sun, 16 Feb 2020 10:14:55 -0300
Message-ID: <CAN=yFFn8GOobGpo2d3N8una4EE3L9nFTckH3D7rZ=G4d=MTmnQ@mail.gmail.com>
Subject: Error 500 from git-scm.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm currently getting HTTP error 500 from various links in the
git-scm.com website:

https://git-scm.com/about
https://git-scm.com/downloads
https://git-scm.com/community
https://git-scm.com/download/gui/win
https://git-scm.com/about/small-and-fast
https://git-scm.com/about/branching-and-merging
https://git-scm.com/about/free-and-open-source

Regards,
Giovanni
