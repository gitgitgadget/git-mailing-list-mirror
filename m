Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D2D201CF
	for <e@80x24.org>; Thu, 18 May 2017 21:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756113AbdERV3L (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 17:29:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34174 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756106AbdERV3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 17:29:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so684518wrb.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhWPnmsTug5i02bnOeRxffnuKeUFQ4EMwb2ccA/+oYY=;
        b=TQp0zm4WKmm3cuN5gA8afiNggzJYR35dcyEK2csCpT0mVkAxfmF0G9f+2TiUcYvdAm
         2vdsI3suzTtIu44BSduJ07KzLWcIU2ETwpqv/Vw7UVr7pw0DiBy90vTEA9QHnLKEuyg/
         GQFlj/+H+2OgCQKUITPgBD8K5NM+/u931aZ9oT5LaO+6gj/cbnPPgCqRH7svlA42ziG8
         sEAMGN2XavRzWPcTwKkMyKsKQAO8vQvZq3Yz+G8DIIcQTBv+lC7pSga5AeB6HdqGiHyh
         ldSTQ1MyHOa7IDaoFHjmm127SE+dbqclPfUcgN2+9no+kyBEbU1VJ4EhBdpsiO7MOxWa
         xyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhWPnmsTug5i02bnOeRxffnuKeUFQ4EMwb2ccA/+oYY=;
        b=JfVbvKzK8P3SyDMu3a9q94tz4j5x5LRT/cTFZzzKifWn/qPfaL8oS3El7KHw6pIYaA
         oh/NJ4UnDtZtZgHicRyZ/MNR80N+Gn/vsEQR/uNWUqIeKNEOUDFFI+NEMPyIJ1vrkqI1
         ESDzuomrOBJHMteUq3OzCu+IsCl3tYa5De4buhhGwtdsgU9kA3gqhNHoOo9sD9TjdD2E
         CsOh+jv7X0vdPwcKI+h65be+xZEg1X+KZqIXBahps4YO5xGYUXMSYIWtp++JdsLpaCaR
         kB2pPwigoTCa5tJpaVxiYUhen0uLV6m8LJbtJaxHfsRGhu1G4zQgDacmxeRqhJstt1qr
         byfg==
X-Gm-Message-State: AODbwcD8fjKLqmcKtF1uGCkvSOX/N0fxeBJIM6hRUeYfLFZeoWKtTYBQ
        aTVEvSOli6JSqg==
X-Received: by 10.223.128.80 with SMTP id 74mr734092wrk.30.1495142949337;
        Thu, 18 May 2017 14:29:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k18sm416181wre.9.2017.05.18.14.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 14:29:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Update sha1dc from upstream & optionally make it a submodule
Date:   Thu, 18 May 2017 21:28:55 +0000
Message-Id: <20170518212858.3649-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

Ævar Arnfjörð Bjarmason (3):
  sha1dc: update from upstream
   
   * Fixes the Big-Endian detection on Solaris SPARC (and probably
     others) which broke the build as of 2.13.0 due to sha1dc being the
     dauflt.
   
   * Includes a patch from upstream fixing unaligned access, which broke
     SPARC even more. This replaces Junio's "[PATCH] sha1dc: fix issues
     with a big endian platform"
     (<xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>) with something
     which brings in upstream as-is.
   
   * Most importantly: Uses upstream code as-is with no modifications,
     which is possible due to a pull request I sent them.

   * This patch can be picked stand-alone without [23]/3.

  sha1dc: use sha1collisiondetection as a submodule

   * Since we can now use upstream code as-is let's use it as a
     submodule.
   
     Yes there are still (solvable) UX issues with submodules, but
     there's no project better equipped to deal with them than
     git.git.

  sha1dc: remove the unused sha1dc/ directory

   * Sent as a separate patch for readability. Can be squashed into
     2/3.

 .gitmodules            |   4 +
 Makefile               |  13 +-
 hash.h                 |   2 +-
 sha1collisiondetection |   1 +
 sha1dc/LICENSE.txt     |  30 ----
 sha1dc/sha1.c          |  99 +++++++++-----
 sha1dc/sha1.h          | 122 -----------------
 sha1dc/ubc_check.c     | 363 -------------------------------------------------
 sha1dc/ubc_check.h     |  44 ------
 sha1dc_git.c           |  24 ++++
 sha1dc_git.h           |  19 +++
 11 files changed, 124 insertions(+), 597 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection
 delete mode 100644 sha1dc/LICENSE.txt
 delete mode 100644 sha1dc/sha1.h
 delete mode 100644 sha1dc/ubc_check.c
 delete mode 100644 sha1dc/ubc_check.h
 create mode 100644 sha1dc_git.c
 create mode 100644 sha1dc_git.h

-- 
2.13.0.303.g4ebf302169

