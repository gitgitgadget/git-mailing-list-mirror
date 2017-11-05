Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30C320281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbdKEVio (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:44 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53894 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdKEVin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:43 -0500
Received: by mail-wm0-f41.google.com with SMTP id r196so10622855wmf.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+SU53e14UG7tDiHqTRxXp0Ac3WUXAmSS88SwA5EU4s4=;
        b=tNGTIGmKZUhOyJD3hWq31RCSkx/X7pVlbaE22MITuahm8NbO7AgtemgpDiXXX2Lph9
         D8J9RvUX5gksEYqQ3YRVe0GxNggOKcKq1aA4s0gU/mW5pozEWyrlpohcFNSAj5gX+YcH
         HCsNxBWn2vbt2lT6xZm8/dB0vO54HMpSSz6uqJscs1Y12HwJYb0OWkI3Ou750m5X0cCb
         8vGzGTkfJw6CoDrUDilNKw/OdQ57J5WfxV2M75HELhV3Uu+nt/j3CWfsrouBP8XNd/md
         OHInFO1tZreW7vGlls2EYOdjqzwQRUzpXY1x5BKFMu3g2ZjoLwrk3hv6yNB2EVzTS/i6
         l6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+SU53e14UG7tDiHqTRxXp0Ac3WUXAmSS88SwA5EU4s4=;
        b=ZagxgAnfIi62X6EtcyiXqQemD0Bce/HnjC5bTA1gyjJkGNNccmRZ7zaN/ekNLBSjMY
         Mh5odDefx6ASWx1+9wyEdTwsBSiNoQe4VMLsxXLsGS0DIhHqZI1SQ0PMbePtzPK48rU/
         /GOzNV7BExEm7v/y6gEpgdNFFlOgyPTsuIMClIY7OQcStNjXX4INFfaHTGPCFVrv4qTO
         Ut174kQmfZd8L2exj0WEthQwN77FUFNdU3kCg23J9ZF6VZ1PQR8xmK6z7Zalo5Ve5KAK
         V6EjkcwNAfR8Kb57NDS+ySUEGZgLBf7bFvHGgS0cJJos4il9gJoGObFty9j5xqJg7Vg4
         ht8Q==
X-Gm-Message-State: AJaThX73w9eo0tLwdb+yEaIHJzM8vCLpf+xGbzHvMKQqUVUiM9GCfirA
        RvJiIPqCj0lESybGNM0h/0UpqKsi
X-Google-Smtp-Source: ABhQp+Rf/7gk2tqORkUrBs9iSlKp+5A9tqH1/E6KO7sCKfClO9Mrx0bdr1W0BQxfd8/kIW0Odh54+Q==
X-Received: by 10.28.100.212 with SMTP id y203mr3918369wmb.64.1509917921561;
        Sun, 05 Nov 2017 13:38:41 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:40 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/8] Create Git/Packet.pm
Date:   Sun,  5 Nov 2017 22:38:28 +0100
Message-Id: <20171105213836.11717-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

Packet related functions in Perl can be useful to write new filters or
to debug or test existing filters. They might also in the future be
used by other software using the same packet line protocol. So instead
of having them in t0021/rot13-filter.pl, let's extract them into a new
Git/Packet.pm module.

Changes since the previous version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patch 1/8 is new. It fixes a list comparison bug that existed
    since the beginning of t0021/rot13-filter.pl.

  - Patch 2/8 is much improved. It now checks for unexpected EOF in
    all the code paths and introduces a new
    packet_required_key_val_read() function.

  - Patchs 3/8, 4/8 and 5/8 have not changed since v1.

  - Patch 6/8 is new. It adds a small helper function.

  - Patch 7/8 is much improved. It now describe better all the changes
    and better check that the capabilities we advertise are supported
    by the remote.

  - Patch 8/8 has been improved. It contains the Makefile change
    suggested by Dscho.

Links
~~~~~

This patch series is on the following branch:

https://github.com/chriscool/git/commits/gl-prep-external-odb

Version 1 of this patch series is on the mailing list here:

https://public-inbox.org/git/20171019123030.17338-1-chriscool@tuxfamily.org/

It is also available in the following branch:

https://github.com/chriscool/git/commits/gl-prep-external-odb1

This patch series was extracted from previous "Add initial
experimental external ODB support" patch series.

Version 1, 2, 3, 4, 5 and 6 of this previous series are on the mailing
list here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/

They are also available in the following branches:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373
https://github.com/chriscool/git/commits/gl-external-odb411


Christian Couder (8):
  t0021/rot13-filter: fix list comparison
  t0021/rot13-filter: refactor packet reading functions
  t0021/rot13-filter: improve 'if .. elsif .. else' style
  t0021/rot13-filter: improve error message
  t0021/rot13-filter: add packet_initialize()
  t0021/rot13-filter: refactor checking final lf
  t0021/rot13-filter: add capability functions
  Add Git/Packet.pm from parts of t0021/rot13-filter.pl

 perl/Git/Packet.pm      | 168 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile           |   1 +
 t/t0021/rot13-filter.pl | 127 ++++++++++--------------------------
 3 files changed, 202 insertions(+), 94 deletions(-)
 create mode 100644 perl/Git/Packet.pm

-- 
2.15.0.7.ga9ff306ed9.dirty

