Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44CC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjEVVjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEVVjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 17:39:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D42C6
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:39:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae4a0b5a90so35789675ad.1
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684791551; x=1687383551;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CdWoqTKagcv/drkjBteVzOf/jfhYEIsfH9RFj5ugtTU=;
        b=rvIBhLBWiRv4RDn2o3WNv/3Qii97Dwo4iy+JNf8DrcWII0mTIegB+uhlrnPol3Ppmk
         jGvy9/KdNY8daLKoWYWRQ3lPqYwJ9GPOVob6Ogy6y0jpmN+t/ha7awb6OdZ87etXvxtO
         doMeuAYyh9t7rk8XwQ+aeQgmvt/xnI2CutJ7nr/otxrnvFNKLExpOxmxGFWF1M6296bc
         EZzct340gHDlEu9sOB6CoWw4fulwYbA8Jl/ukRwlyjKjEiLKRiSf48BbSjgHV4OW26mX
         yECkdRB9/cBuOfDT9JZh1FHZOGVT7U8pzlubNSzeeZDfbTQj2XVt59BXjjqTNBsmHwpE
         wDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684791551; x=1687383551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdWoqTKagcv/drkjBteVzOf/jfhYEIsfH9RFj5ugtTU=;
        b=BPiBBd+E6tWUIxLILq05p19vaqeMr5lmWURcnKXsdbpkq8VMYkDkShnx+E5M4alP51
         Afv7tXYpEFKEd00BwrJKo0mPczjMZUFoIRUuzGXWXUOejpZdyAbu0cgoOIFT45g3SV8s
         QU/guTOHFhnSRjVjudQ1S1ovbk1IHjCFxxfhLJxMe0zbiLpM4rcWtHVhXNr1SpnB3VPu
         HTUM28VZvHnKkIFXiNnt8vkdK79HeMht+IybDM20QewD/govR49Cqi4n/+BlVJ0JTmgJ
         OGwmzXg7VfHq8VX6KB2i5dIFtWSfuF8Dpa1paZs2NaV3D7PUdLqQhjme3yI0sUwnpcbx
         tf4Q==
X-Gm-Message-State: AC+VfDwW+JawfDOEX+7xVrYxtccioUhssben6YALljKbI6eZfemPclQG
        JsRYhyb1rmYeWuhH5RPQI1moNSWJZZ0nB1oFfEwrHhuP/3X5Lmmed6crYkSVH2TXMsqVepiSCmp
        CxwEnArW8Ndn+y4yb9m+RiN3mw2KO19hTp4OzdbxsjiEBv3GyZ3iRx7YDMPP5370=
X-Google-Smtp-Source: ACHHUZ4gKg46BFd0LvS3di6Jl8rBR2WtK/eUyEUImaNR98tVrCs+7grHL9x6Ij5rT3kiA9v7jKkXlkdVaZULxA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:284b:b0:1af:93cf:5ffc with SMTP
 id kq11-20020a170903284b00b001af93cf5ffcmr2014665plb.2.1684791551414; Mon, 22
 May 2023 14:39:11 -0700 (PDT)
Date:   Mon, 22 May 2023 14:39:09 -0700
Mime-Version: 1.0
Message-ID: <kl6lv8gkxczm.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday, 22 May, 10:00 Pacific time
(UTC-8). Note the different time (it's usually 14:00)! I'm pushing for
alternate sessions to happen around this time, so if you have a
preference for either timing, do let me know.

You can find more info at [1] and on gitcal [2]. We run a session every
other week. This week, we'll be discussing a series from Taylor Blau
that introduces a hook to tell "git gc" about recent objects [3]. Let me
know if you're interested and would like to join (off-list is fine), and
I'll send you an invite.

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/git/cover.1684196634.git.me@ttaylorr.com/
