Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA761F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeKKThn (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 14:37:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKThn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 14:37:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so2716887pgh.8
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNvUEsCTuYx3LNapgicGhPt2w5K2SWNKlP1zekPgzRQ=;
        b=bjXZP1MbvAdEg64vbObhNyx73tCYSBGIFYNEy8FbdzIwxC7WKIj2aEUs/WM12OVO6B
         remHEjHZQMDkar7+ejhidGPn2FzvisJxx2f+wmTGSK1EqQhpvqXwWHr2aDTatnRTKFKC
         kisY9aEa9WgJEDrTq0sKgF5vfIiajFfiXVfLTOEMdm9MXMpFEv3dVShhPnWPJGyjgtlK
         PQqAajovHkC/ums5QSY5ycUbRfH8Sr4NKXf/g506S6OAvvuaZmnrxwtPxcRFbOYbCsiK
         el+OZsPE2UnGlsuTDGh4lI/YLrq4L2kQqfbEWV5N1XT0+16wxbtdeyinjh+96swcgcLE
         O4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNvUEsCTuYx3LNapgicGhPt2w5K2SWNKlP1zekPgzRQ=;
        b=o89z4riZ4Um5xoztg2GK/MzpZC9iL87TveIy1ZILvsuImnAfYiLM8thSC3UZa+Rxfj
         3jAmOFoPiTH97zNIa+CiLhEaBOBYdm6fDImfmrTu7SI7zeZcI5+VAQZDEAlpICPlBWfJ
         LaP0FjEgcu1yfWysJ+Qbx0FxNxJTkoiPUz1MXaLyDEhz7pxJeAoFe7KrFtoCr+d+pvH7
         Ilmj+1NL8CivPldQ2X+EaYyvDhMM7kJMo7JR3qb91aefqlLWGEyp3nybcJ+if5Mkb3kC
         jXH79fy6GaWgGJbkALfcrHSm32i6zmOY2/cDFscTSrwgkZpt731vPoCdnY37KycCeJ8f
         U3HQ==
X-Gm-Message-State: AGRZ1gKdVV9IQSg4Kps/AHI8tNestZu/VDrrEsN4dbinoHHGHqTxgeKW
        Z45zQqgaDbr1t612IqMHPTGUrO0T
X-Google-Smtp-Source: AJdET5eBD41Azm3lwt2ahnayv96TvGggC+P2UQLWscyL3d66+XabZxW+sycjvh+em3gE0LfifmLMpw==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr15677158pfs.6.1541929777781;
        Sun, 11 Nov 2018 01:49:37 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d65-v6sm14955902pfc.144.2018.11.11.01.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 01:49:37 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johan@herland.net
Subject: [PATCH] builtin/notes: remove unnecessary free
Date:   Sun, 11 Nov 2018 01:49:33 -0800
Message-Id: <20181111094933.27325-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

511726e4b1 ("builtin/notes: fix premature failure when trying to add
the empty blob", 2014-11-09) removed the check for !len but left a
call to free the buffer that will be otherwise NULL

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/notes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c05cd004ab..68062f7475 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -255,10 +255,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_oid(arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_object_file(&object, &type, &len))) {
-		free(buf);
+	if (!(buf = read_object_file(&object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
-	}
 	if (type != OBJ_BLOB) {
 		free(buf);
 		die(_("cannot read note data from non-blob object '%s'."), arg);
-- 
2.19.1.856.g8858448bb

