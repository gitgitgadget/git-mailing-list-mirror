Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC3A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfA2UIP (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:08:15 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:60998 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727229AbfA2UIP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:08:15 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83l031166;
        Tue, 29 Jan 2019 11:39:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=L/IVwUZccTOnYqUCw67oQLwxddM8pdqcANP0OVfCW6M=;
 b=Y/bYLetZgoDM0wGTwiSh3KqK+Vp//pUjejMA+BbuHvaJDE34RRzLHTlpqhtmA1TNtmTx
 x+26onU8i0PzDHRzAioapBtXShZdGykq4ywSv15FLNmW6gBOWruAH7dT8me13DAgZBhr
 bou04YoaQFPtvwHK8nhGsoOHUzAyS2OQb9HrF7pVS5DozYZElkk0F2xa3NOx3GIJkbsc
 d5PhdVeIRXLBTVp8SHsuM+l4QmTAVriQTo/897Yg8VlFm6CqUobOtd/pAfz6DUV/ThUJ
 q51b686POmZr7gp8mRORARE1HwLz5iIQxzaX6ZB10xYzq+77HtJ2beWXGyd44OWYX3cz LQ== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:40 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300AIKYLYUZD0@mr2-mtap-s03.rno.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9PJA00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 7313b4f6adbdb5a059c8640fcff253e3
X-Va-R-CD: d193468aa2b6071e286eda62f2399c92
X-Va-CD: 0
X-Va-ID: bfc5a4ff-45b6-422f-b0e7-d31ba5efdae3
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 7313b4f6adbdb5a059c8640fcff253e3
X-V-R-CD: d193468aa2b6071e286eda62f2399c92
X-V-CD: 0
X-V-ID: dbbe7101-3200-4989-9b68-4b5dd0b89b41
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300100YK85D00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 09/13] Use symbolic links rather than hard links
 for files in libexec
Date:   Tue, 29 Jan 2019 11:38:15 -0800
Message-id: <20190129193818.8645-10-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See <rdar://problem/10573201>

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1a44c811aa..60711d6abe 100644
--- a/Makefile
+++ b/Makefile
@@ -2065,10 +2065,7 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 		git rev-parse -q --verify HEAD 2>/dev/null)"'
 
 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && \
-	ln $< $@ 2>/dev/null || \
-	ln -s $< $@ 2>/dev/null || \
-	cp $< $@
+	$(QUIET_BUILT_IN)ln -fs $< $@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
@@ -2387,7 +2384,6 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
-	ln $< $@ 2>/dev/null || \
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-- 
2.20.0 (Apple Git-115)

