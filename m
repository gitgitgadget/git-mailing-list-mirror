Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB2A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfA2XIV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:08:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36460 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfA2XIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:08:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so12626714qkf.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYOwZ1hXlnlh9QTs+azAVouWqJCy0sHG+jLjEAkTyzY=;
        b=Mqcco814T4QAC33KXYUatQ0RTrMmFjSLSu+GuLOLCwWPaDfLiUROnSDz6aRTJmcsi1
         UEoH5mXzXb0S0FHjSR2PiwsyBPvwm33V4+dToh1RZa6BmYuDT3daB1fO92ESvQAuz1zx
         k/nHojamsoWhTTjoE4n3wzzDM6na8UF7hCU+NBJ2Nyd4qoTI2qVzXbv+7GME3CDS6xmU
         Dgv+VdqtUOcTvzKaNCEKh8Sj/j5LQVf8naWjgWBWidtyBZY2dY92i6AVXIOWuAsdZdd4
         3vJnZbn5xncxwKbMn+iL/Cx1bMmjYfaFLy77qJ1va26CXO88IEg1mdsCRrF4S4wZj4K2
         MNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xYOwZ1hXlnlh9QTs+azAVouWqJCy0sHG+jLjEAkTyzY=;
        b=ezSdUZ26YN05nUmJw3/UdxaKZyHgJ0Q5AklEQQlP4cCgtuwE3EecaH7SEv6SJ4oE4b
         PtcT2n5xbmwlO30OOJuAB4ERY39EkLBis6n/1/WnvewLc0xTjK/Pcn+Ny2O9JJ0V0z8x
         /i65GnXI1FN8a/EsSHO6Bedg4bm9IN4lYqzlzHZb8xKcLupl5cV5BwO3Rr0kh/DdLA6l
         GGOtdVhsl93yKHm+a5dP/phkPuP82iKBEiRSZrfidfqjGW8vm6yAL0V+1RhX5RAhJYxU
         V1Z8gp4IdaAtNl3PrH9yvKw3Pjc4ryPhdUlm/eooHOZSAsVqi5luwH7CvtwwZGxZSaYB
         CK2g==
X-Gm-Message-State: AJcUukcIsIsj9y5IKTIe1/Q3XXGRtfhbyeBNTvMRhO9EUdRQGnYOmiXg
        LuyF7iNYFP6YyF6tBw0LVk5DXAiz
X-Google-Smtp-Source: ALg8bN7b6JXz4FXldGRE5FglUFSGgHJ8SMf8cnO2R9SUWrY596JKGYGs4tENkHagUVQ5Q1pEa+ikjQ==
X-Received: by 2002:a37:4bd7:: with SMTP id y206mr26016995qka.167.1548803299947;
        Tue, 29 Jan 2019 15:08:19 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id y14sm108808394qky.83.2019.01.29.15.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:08:18 -0800 (PST)
Received: (nullmailer pid 5341 invoked by uid 1000);
        Tue, 29 Jan 2019 23:08:17 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v3 0/1] config: allow giving different author and committer idents
Date:   Tue, 29 Jan 2019 17:08:05 -0600
Message-Id: <20190129230806.5295-1-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All,

this version of the patch adds more test cases, combines the tests into
the main patch, creates the static set_ident function, updates the
documentation and fixes some formatting.

It also applies against master.

Please review.

William Hubbs (1):
  config: allow giving separate author and committer idents

 Documentation/config/user.txt | 23 ++++++---
 blame.c                       |  3 +-
 builtin/am.c                  |  1 +
 builtin/commit.c              |  3 +-
 cache.h                       | 13 ++++-
 config.c                      |  6 +++
 ident.c                       | 92 ++++++++++++++++++++++++++++++++---
 log-tree.c                    |  3 +-
 sequencer.c                   |  5 +-
 t/t7517-per-repo-email.sh     | 74 ++++++++++++++++++++++++++++
 10 files changed, 200 insertions(+), 23 deletions(-)

-- 
2.19.2

