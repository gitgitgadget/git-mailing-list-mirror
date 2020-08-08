Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C90C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6998D20866
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="tjSrvhqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHHHuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:50:35 -0400
Received: from out0.migadu.com ([94.23.1.103]:3718 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgHHHue (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:50:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FaAor5hXHvYzV53p8JhpPlcd7mgQJgyo8VMyzDiIJec=;
        b=tjSrvhqeaHH3hBX8R42YOKCA3fSmMExQsXwlUYFO/GMwV5AFHujDPEkPD1EyW5IqQHZSkl
        JTaIKw7pYAZTurOaJ7YYI5zX1Ji9WVsGRRsaeK/P2LBwRS4V1sX5KJQpTMf8IoKsxatj5M
        uTxDEnEgSd+OGfweLaxThX1yluh96Pg=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v5 0/3] apply: handle i-t-a entries in index
Date:   Sat,  8 Aug 2020 03:49:56 -0400
Message-Id: <20200808074959.35943-1-ray@ameretat.dev>
In-Reply-To: <20200806060119.74587-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While testing the logic, I encountered some other issues, to be
addressed in related patchsets.

Raymond E. Pasco (3):
  apply: allow "new file" patches on i-t-a entries
  apply: make i-t-a entries never match worktree
  t4140: test apply with i-t-a paths

 apply.c              | 25 ++++++++++++++++----
 t/t4140-apply-ita.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100755 t/t4140-apply-ita.sh

-- 
2.28.0.5.gfc8e108108

