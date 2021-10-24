Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6027AC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3937660FDA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhJXRMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJXRMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:12:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD8C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y12so9092776eda.4
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuPr0J0JGKLbmB17PxSUsTGQTF8vWvfvQ5j/IL2Sjg=;
        b=jSsLoz3/Vf8xP3csiBcvZY+hVh6nP4YgnIzg5Ydq6QqdzB8ZNXIsSe7Z0d5op0j+yc
         sKSpaX50l64WsapqJH3bbMRheYEYf5K4MgQWyYaYCikPMSEJZ9z0VBlPWKVIF8ftH8Zu
         TbM5rC9NOwbfHaJEVleL2pat/MU0gnNbgTmz/5fZJdJxfb4N+Tz1NXVM8xP98GnQ8fQ6
         duT2kxcriiE1DFx+YSVwTMUrOdQOGj8UtLsTJj4QPR/vQsCjPqdC134GEMyUM/7fHKf/
         dOPfsuAQKH6gQIbRNkVSO48jnRcM9ohFhZb+/U+cIHZKntG1W+Mxl2Uf7PSvkFGMCWkV
         6qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuPr0J0JGKLbmB17PxSUsTGQTF8vWvfvQ5j/IL2Sjg=;
        b=I2I3EjzI5yepmszCAGGr7j/pKPxBHGbCjTGYUW38tn960O8bUltxAD6eo+OFQ3BkK2
         FuJklDe6U7htuvu95yw0dNCy/vqVFjPOtT16m5B406mpnrwk+epKg4OdDoqC9cJwTMpX
         0wxS9ivQiVq9wzuOQs9x+To9C/E2t5BuO6WE0XvltkmghqOruSiihsO3YosdIBluDr8S
         Saa9YhqbgHtAojiUUNtjlhCq7c4PBfCaYfGuslnGoU61bwcntHQG0XqdP4lLKoSsgfbs
         7mWxRjU0QpI4Is120qc1iaENpsCg1zwX5VfLLLo8rWzBjLUe9wWbWZefIg/tyvMJlNg8
         VfPw==
X-Gm-Message-State: AOAM530+ctnQz8GPf9nUPXPeR2fp+FEz0NHkZ1RcbTDGezVthAvR1Jws
        XBs9HzjIuYMbtCxJyi3Kwbi65p48uo0xFw==
X-Google-Smtp-Source: ABdhPJwPGpPiEiYuFwsjTw1PVBwxASIA0IWiUlabvgY5DIKK2Aa9z0B6tsX65HBWK06zB3tUndSw7A==
X-Received: by 2002:a17:907:972a:: with SMTP id jg42mr17037923ejc.75.1635095378861;
        Sun, 24 Oct 2021 10:09:38 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id j11sm6313670ejt.114.2021.10.24.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:09:38 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH 0/3] Documentation: change "folder" to "directory"
Date:   Sun, 24 Oct 2021 19:09:14 +0200
Message-Id: <cover.1635094161.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is my understanding that we prefer "directory" over "folder" when
discussing the file system concept. (Whereas "folder" is commonly used
for the GUI view of such a directory, or for an IMAP folder.)

I stumbled on a mention of the ".git folder" when going through the
doc-diff between v2.33.0 and 9d530dc002 ("The fourteenth batch",
2021-10-18), and started looking around. This series is the outcome.

Based on master.

Martin Ågren (3):
  git-multi-pack-index.txt: change "folder" to "directory"
  gitignore.txt: change "folder" to "directory"
  gitweb.txt: change "folder" to "directory"

 Documentation/git-multi-pack-index.txt | 6 +++---
 Documentation/gitignore.txt            | 2 +-
 Documentation/gitweb.txt               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.33.1.711.g9d530dc002

