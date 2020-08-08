Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41EAC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB04221E2
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="VHc8F+bD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHHH6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:58:48 -0400
Received: from out1.migadu.com ([91.121.223.63]:17678 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgHHH6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:58:47 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2RXIkMbPApxdbgLHKA4/16zQ4ugQW+6XMD2hZ8aYnc=;
        b=VHc8F+bD0TAmouKhd0w39Uss1yG04kfodutXwh9H1z1Es2jDz4tfKwrAWu9+C7pFSdfjh0
        Lpf0Fhs9eojaaNvEZNtdFwU3UXpn2hT7Cd3gxINIXgT80KBt9nQReG3n/DVvbZAMv0+tjg
        6Zz8ds+AMOnXWuouys/taoaNGarIwYc=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [HYPOTHETICAL PATCH 0/2] apply: reject modification diffs to i-t-a entries
Date:   Sat,  8 Aug 2020 03:58:25 -0400
Message-Id: <20200808075827.36248-1-ray@ameretat.dev>
In-Reply-To: <20200806060119.74587-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the main patchset of this thread, and makes apply
reject diffs other than creation or deletion diffs to i-t-a entries. I
think that as long as --ita-visible-in-index exists as an option this
probably doesn't make sense to merge into the tree - I am just including
it for the record.

Raymond E. Pasco (2):
  apply: reject modification diffs to i-t-a entries
  t4140: test failure of diff from empty blob to i-t-a path

 apply.c              |  3 +++
 t/t4140-apply-ita.sh | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.28.0.5.gfc8e108108

