Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A742C1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfA2UL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:11:28 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:41422 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727308AbfA2UL2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:11:28 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83b031166;
        Tue, 29 Jan 2019 11:39:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=DXRiCrzSEhf91aFLDqtfI8M2B1WdL1Taew3+ObaM6fc=;
 b=U6wAeRDGodnsUjzGuqp7FVv2bSGNvHeQBEDS6WfYq+35oYsPjQPauopAQbT0sIMLxzAy
 6cBVtbxF8h8r7Mo5WnWn4ghN6fsBmilBAJWDXY9kRRj70W1MWqQwE0KzBNcSto32MhcP
 ViRYcsSptZ6s8EG05gdbJ8UEwldnrzmIYTOk3E/Ulv93HoDctFRYuiefX71YPu6cTOCL
 ncv0E5u0s38vWj9kujxZeDJbyEQscEBSZ+B854K2jRX+fDgyEio2yoLaiHIYO7nNKw5X
 zZRU1mop8F1mvV259tmFSkRuoqprNrRZP2M21HeXacQUNm96uCVKt/4k/Eav1ZpobVXG aw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:35 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300AIKYLYUZD0@mr2-mtap-s03.rno.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9OJD00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: e70b9e81c7dd0d8bdd4b8cd74cb14219
X-Va-R-CD: 209ccd1b7deb1b907f528f41d804ce87
X-Va-CD: 0
X-Va-ID: c301508e-79df-435f-8796-642107d44b16
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: e70b9e81c7dd0d8bdd4b8cd74cb14219
X-V-R-CD: 209ccd1b7deb1b907f528f41d804ce87
X-V-CD: 0
X-V-ID: f01f3424-9915-41f7-86e5-a0ab6407df08
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S on
 case insensitive filesystem
Date:   Tue, 29 Jan 2019 11:38:07 -0800
Message-id: <20190129193818.8645-2-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was causing problems with ppc/sha1ppc.S

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..a5db584576 100644
--- a/.gitignore
+++ b/.gitignore
@@ -195,7 +195,7 @@
 *.deb
 /git.spec
 *.exe
-*.[aos]
+*.[ao]
 *.py[co]
 .depend/
 *.gcda
-- 
2.20.0 (Apple Git-115)

