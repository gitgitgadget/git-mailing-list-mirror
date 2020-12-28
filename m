Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3EC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7500120702
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 04:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgL1Ezo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 23:55:44 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:54792 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgL1Ezn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 23:55:43 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktkYe-001fev-JK; Sun, 27 Dec 2020 21:55:00 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1ktkYd-0005yt-VR; Sun, 27 Dec 2020 21:55:00 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id B81FE5004F7;
        Sun, 27 Dec 2020 21:54:59 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ymf0cKkjS7Zs; Sun, 27 Dec 2020 21:54:59 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 7A3685004ED;
        Sun, 27 Dec 2020 21:54:58 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 27 Dec 2020 21:54:23 -0700
Message-Id: <20201228045427.1166911-1-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228004152.522421-1-seth@eseth.com>
References: <20201228004152.522421-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktkYd-0005yt-VR;;;mid=<20201228045427.1166911-1-seth@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v8 0/4] mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v7:

 * Add a tool-specific override function to setup_tool based on Junio's
   original patch feedback.

   The implementation of initialize_merge_tool is very much not set in
   stone. Suggestions are very welcome for alternate approaches that are
   less invasive.

Felipe Contreras (1):
  mergetool: add automerge configuration

Seth House (3):
  mergetool: Add per-tool support for the autoMerge flag
  mergetool: Break setup_tool out into separate initialization function
  mergetool: Add automerge_enabled tool-specific override function

 Documentation/config/mergetool.txt   |  6 ++++++
 Documentation/git-mergetool--lib.txt |  4 ++++
 git-difftool--helper.sh              |  2 ++
 git-mergetool--lib.sh                | 11 ++++++++---
 git-mergetool.sh                     | 22 ++++++++++++++++++++++
 t/t7610-mergetool.sh                 | 18 ++++++++++++++++++
 6 files changed, 60 insertions(+), 3 deletions(-)

-- 
2.29.2


