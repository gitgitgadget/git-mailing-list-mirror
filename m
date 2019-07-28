Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95361F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfG1UH2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45483 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so27106251pgp.12
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gJHpZDEJIeoxdpKcsAF/trs0Ix66ogCksFkLfDPAzI=;
        b=jemg2JgX69fkV9lHAbDIPAFEkTT5BmwaNKPA2Tn1pI/gyFa7/vmKD4yIQ6H8mCauir
         vmHNl8/+NJVJZvHZXjFR6tFKp4iBFZR2pzYfCXgh9J9xjDBrdJCdDc96NF5Q7oPCAGs/
         2KLYXIP8ho/MsPSL+GzU7usOkHTH2HEXkk6b1Rj1xQKG3dUyAz+b+srPPX0HDNkabDep
         iwFB6uip3SdvNuvYcjsHfZNTjwfsdIb0eOqtgF5x58Vo21shySPF/Qnnf3qdyYEKhZ9/
         2sRv44GihQd+HnO7XzBvdpvsQ2XDYZbxY1ymoZedSUB3l6FAzcvOYlncX0xHvMC4XcYC
         fVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gJHpZDEJIeoxdpKcsAF/trs0Ix66ogCksFkLfDPAzI=;
        b=HDMnez78jSvTdH25MZ4hnHvh/3zGWol7DBgotMYOR2LlX7ZaW1JszDAywlBGnhAYxv
         Y5qJUtHwgG80UTk6Cju6R3UOSqd13gtqxkGlwRDZBx1Dd+AWEGFww9bS/WvPJyXFerb9
         WcP9Ixn2BGPCEERnxOvHR0l30/nJNd73Npf9aWlZgZiviHjnLQqg2C/MlLvUkBdsCSGm
         KDOGfQYHMYclcO1D02C1+qth1vGY8oUuxY0uz64iYCRa1Oc0rOvQq9uijq9UQi/w4PU9
         ElMRJ+s2wmY+j0A96vj9gjLdnaadSeOORj9WBWp/tkmVu8HFsIBp2aFlUMV4G8u7pd+y
         Brbg==
X-Gm-Message-State: APjAAAVuv9R1yg/PJWG8vHs+OQ55Uk99fMavQb0Vk0fz1sDJ85+3bQL2
        nOVyybFo/azXzqMk3q6pAmmk/Zi2XNM=
X-Google-Smtp-Source: APXvYqy7mFZCA1knB9Qx2dBFGO5NvcVLFnATrkmy9ovGWugPjCU0jBxtNfStZYh13+equwBsBfqXPw==
X-Received: by 2002:a63:9dcb:: with SMTP id i194mr55815474pgd.444.1564344447297;
        Sun, 28 Jul 2019 13:07:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 0/5] system header cleanup
Date:   Sun, 28 Jul 2019 13:07:19 -0700
Message-Id: <20190728200724.35630-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a reroll of jk/no-system-includes-in-dot-c with
cb/xdiff-no-system-includes-in-dot-c applied on top with minor
fixes for the commit message based on feedback from Johannes
and the example put forward by Peff with his own patches.

The changes proposed shouldn't affect any systems (except for
the 3rd one) and that has since shown to also be needed
in Alpine Linux (because of _XOPEN_SOURCE redefinition).

The last 2 patches are new to the series and just cleanup
the dependency list in xdiff.

Carlo Marcelo Arenas Belón (3):
  xdiff: drop system includes in xutils.c
  xdiff: remove duplicate headers from xhistogram.c
  xdiff: remove duplicate headers from xpatience.c

Jeff King (2):
  verify-tag: drop signal.h include
  wt-status.h: drop stdio.h include

 builtin/verify-commit.c | 1 -
 builtin/verify-tag.c    | 1 -
 wt-status.h             | 1 -
 xdiff/xhistogram.c      | 2 --
 xdiff/xpatience.c       | 2 --
 xdiff/xutils.c          | 4 ----
 6 files changed, 11 deletions(-)

-- 
2.22.0
