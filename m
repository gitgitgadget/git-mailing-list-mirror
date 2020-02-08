Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0931C35242
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8196222522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 20:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHUoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 15:44:09 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38159 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBHUoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 15:44:09 -0500
Received: by mail-lj1-f181.google.com with SMTP id w1so2895557ljh.5
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 12:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zozRFxV+uufpnOlMC7hSCscZPLJJOHXf8LxS7WBuz4=;
        b=kLfM+0pM1Kl59atdYQiispzz1y3HU09Tr7rSLxhObzEEmnEXItZtyEFIM2JtgMTzsM
         M8OnP6CHwH8fuJHBOSIH+y6rYgVPusumK4zbZ77hgrwIdOSUHQuMh0fiWHDkfGf46bPq
         b+/x+BVYQAhlP5dkt4HUHjtxpxPPRM8aGM9aax/VlKzHJdOd9+JIkQm2R3QUbxmzT53C
         Hi6MFgjoKq19O3KDb11n9PpVxJ481wM0nZW0syWnd1VHy1qM4dNoJ4cI2pHjpWohk9JV
         ZwbN7ouunEedlfMeVu8p+idb7HxJ0/f0NlSEs4VMgSrjS+TYbCHPl6WK2SearpeH1msH
         2umQ==
X-Gm-Message-State: APjAAAXUID0ggkqTEtdSrGSICyVUlK5LvkgWdA1EThi0J33iu72zRUGM
        pjjT9rHYsG0T1g7WWYHSUpY=
X-Google-Smtp-Source: APXvYqwlAUZC78+ZRfyClGmIox6lPcjtq4uTuHNBGAZRioZA9LSgaxxkOdwI+N/Ua5e8pgYLAQOfFQ==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr3617924ljk.179.1581194647498;
        Sat, 08 Feb 2020 12:44:07 -0800 (PST)
Received: from beta.herland (160.37-191-159.fiber.lynet.no. [37.191.159.160])
        by smtp.gmail.com with ESMTPSA id g15sm3614080ljl.10.2020.02.08.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 12:44:06 -0800 (PST)
From:   Johan Herland <johan@herland.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, Johan Herland <johan@herland.net>
Subject: [PATCH v2 0/2] Minor fixes to git notes fanout code
Date:   Sat,  8 Feb 2020 21:44:02 +0100
Message-Id: <20200208204404.5531-1-johan@herland.net>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No changes from v1 (except cosmetic fixes to commit messages).

Johan Herland (2):
  t3305: check notes fanout more carefully and robustly
  notes.c: fix off-by-one error when decreasing notes fanout

 notes.c                 |  20 +++++---
 t/t3305-notes-fanout.sh | 107 ++++++++++++++++++++++++++++++----------
 2 files changed, 94 insertions(+), 33 deletions(-)

-- 
2.23.1
