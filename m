Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF70B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfA2UEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:04:36 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:49766 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfA2UEg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:04:36 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 15:04:35 EST
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83f031166;
        Tue, 29 Jan 2019 11:39:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=Oc8P2hDEklH9h2Z9tF5vWOkJfZvfJ1ssM+fznDlxEb4=;
 b=viQrxpg9RcIPQ98OBw4FvnrpEpEV1DPmt3gVdZGWIyXGuZHMg7pDBK+KoY6iQXVyfe3J
 QvfO87Q9JRyzi1g+3yI3ZHjGUJ87W2FskbkkAx7Z/wTuUpmMHudw7OH93kSMwwYsJXUu
 gvBCNuWjEZgDL4n/1EPd4x1I59zD5W5BXFZBMZKR3u5r+LINfy8N/GkqH1OMbToMZnpF
 ktdTSFB8QXzE7XBbeGQ5yVroQ/lfztSKzqT3tbAi832uq2zdYFv7ogc7YTgICxhXkRS4
 Wr6D8yKpxZsKiYblxW+TNjNYwRM29mRp2jIQHHpM3MHgGtw6ujxLWV5WmYD9HdZRMq+2 ug== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-6
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
 2018)) id <0PM300D00Y9PJK00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: f9accb4494658d1cb3de836023ba1b6e
X-Va-R-CD: 0f8c382d5f1eb3c1f44878ee6d2bd78a
X-Va-CD: 0
X-Va-ID: f4cdec7d-5914-4d28-a2dd-85c5c6293ea9
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: f9accb4494658d1cb3de836023ba1b6e
X-V-R-CD: 0f8c382d5f1eb3c1f44878ee6d2bd78a
X-V-CD: 0
X-V-ID: 3771d776-88ee-4fdd-b176-3c67e2d15d80
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
Subject: [PATCH (Apple Git) 05/13] t5701: git --version can have SP in it
Date:   Tue, 29 Jan 2019 11:38:11 -0800
Message-id: <20190129193818.8645-6-jeremyhu@apple.com>
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
 t/t5701-git-serve.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ae79c6bbc0..7bc25700fa 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,7 +7,7 @@ test_description='test git-serve and server commands'
 test_expect_success 'test capability advertisement' '
 	cat >expect <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	agent=git/$(git --version | sed -e "s/git version //" -e "s/ /\./g")
 	ls-refs
 	fetch=shallow
 	server-option
-- 
2.20.0 (Apple Git-115)

