Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21851F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfA2UGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:06:41 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:55964 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfA2UGl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:06:41 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83g031166;
        Tue, 29 Jan 2019 11:39:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=G8Yi1kQS/0EQt9KJ0/ja98BdIlutkZgK+emU4OZavv8=;
 b=CQUoD4BS5TE3M/O56ZLZ/qFBkBWs00DQCJ2XGoBRJ4fF7jOZydFXFkOEDAD+egliKyGF
 zwTJ51EyZ71EqlSenPCm9mslv8nhOCsw/h+6K40twZQ0mZw4ch/Zgx030lpBljwCjz7C
 s7hAqz7KnNaJHz3QxsqjFhJJSKA509sNk/JXlyXj5Gqx62m/MtdkBvHDlkVf3xNwSkWa
 KrMASWizTE4vHZHGb2jALw4DLHCkFlIQWy8L7bwWrN4i9pcdU0q7Aa9g87qk+yCGN06A
 Rbi5TpV1HSigdWVg03IIwgkgLxprJtbDxGLRrLiQkYpn0ueiyse1XpXhxaRIq+Uvx/xj ug== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:39 -0800
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
 2018)) id <0PM300C00Y9IP800@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: efe0cb3df84d3e2b6fe8dd92a814c8b8
X-Va-R-CD: 701f5f596f5bfe2ff3f2fa67cee5a5ea
X-Va-CD: 0
X-Va-ID: 9a95f7aa-0439-47be-951f-46da45f3b5ca
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: efe0cb3df84d3e2b6fe8dd92a814c8b8
X-V-R-CD: 701f5f596f5bfe2ff3f2fa67cee5a5ea
X-V-CD: 0
X-V-ID: c6b8dfb5-9a32-4400-804d-ac385d45ec27
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
Subject: [PATCH (Apple Git) 06/13] Set Apple Git version during build
Date:   Tue, 29 Jan 2019 11:38:12 -0800
Message-id: <20190129193818.8645-7-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 GIT-VERSION-GEN | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d1a2814ec7..6fb90854b9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,6 +3,10 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v2.20.1
 
+if [ -n "$RC_ProjectSourceVersion" ] ; then
+	DEF_VER="$DEF_VER (Apple Git-$RC_ProjectSourceVersion)"
+fi
+
 LF='
 '
 
-- 
2.20.0 (Apple Git-115)

