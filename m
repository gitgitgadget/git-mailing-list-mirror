Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 24991 invoked by uid 107); 18 Jul 2011 18:09:19 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Mon, 18 Jul 2011 14:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab1GRSIo (ORCPT <rfc822;peff@peff.net>);
	Mon, 18 Jul 2011 14:08:44 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35701 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1GRSIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:08:43 -0400
Received: by fxd18 with SMTP id 18so7013726fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:08:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=odNB77UKkebKtcVZD6B7PlIWa62jB7nhxVi7zdYCr1o=;
        b=RVAhtgFR2TGsVVtHKJ+G0Eq7XGC7xtjQkt3EZonqG6HIxgtmWisvEJH/uTRHx92rir
         foG9FPf8zjZLPmrSHtjo1ZHfMyWq40jPx0Yo6QG9iZyTAzX0EIydT57T96+9pIfbbzdc
         n7JcRyhy+exPDxXI7Q+44o0XFLAYMxvTadJTY=
Received: by 10.223.68.5 with SMTP id t5mr10508946fai.53.1311012522323;
        Mon, 18 Jul 2011 11:08:42 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 21sm3110348fay.21.2011.07.18.11.08.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:08:40 -0700 (PDT)
From:	Erik Faye-Lund <kusmabite@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, j6t@kdbg.org
Subject: [PATCH v2 0/4] port upload-archive to Windows
Date:	Mon, 18 Jul 2011 20:08:32 +0200
Message-Id: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here's the updated version of this series. Changes since last time:
 - Patch 3/4 is new, makes enter_repo take const-input
 - Patch 4/4 (formerly 3/3): added a call to enter_repo to make sure
   the path-argument is taken into account.

Erik Faye-Lund (4):
  compat/win32/sys/poll.c: upgrade from upstream
  mingw: fix compilation of poll-emulation
  enter_repo: do not modify input
  upload-archive: use start_command instead of fork

 builtin/upload-archive.c |   65 +++++++++++++--------------------------------
 cache.h                  |    2 +-
 compat/mingw.h           |    2 -
 compat/win32/sys/poll.c  |   17 ++++++++---
 daemon.c                 |    4 +-
 path.c                   |   30 ++++++++++-----------
 6 files changed, 48 insertions(+), 72 deletions(-)

-- 
1.7.6.135.g378e9

