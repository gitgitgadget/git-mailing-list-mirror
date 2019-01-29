Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B981F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfA2WFa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:05:30 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:38270 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727342AbfA2WFa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 17:05:30 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb9fX006222;
        Tue, 29 Jan 2019 11:39:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=OkcgExc0u9gbjB3NldZmZaqRJllXmWp5Q445VgQsTEk=;
 b=BpaNAJX41FuMG7k+YotuPqfHKtc2PLANcuAb/KEwA/87lXIiynWclBEZg+QM66k1fQ2y
 GWxhagoYXcvo9u8eqZuPdoSJ+Xu0wfCch7FwpfeYWBWsS1viMed5eEv6I676CwXI8BlE
 2TW6tJzTeRfTsOWSrPc5DyjYNnkG1CI7H8+Bgb3KlyzZnGPG7fPyf5Z5a7ePSpPbc+nn
 KBrvDdGpBwwLdmHx3KzZ1QWH94PJ5bo4xyj/iq1YZ6HDLrSQmTg3uSqcSNGAOJ2EMxSG
 XWbIJlgsl5H2oImx2UHRZIUjVN82j9pOWCY7xYZEuRGgZrNnU3Zx64exexFnviyOjMfJ gA== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9832j51y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:35 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300G47YLXUYE0@ma1-mtap-s01.corp.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300C00Y9IPB00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: d85662c2693cab3d0081332caa201860
X-Va-R-CD: 53a156bc41a6baf29217e9ff01f61863
X-Va-CD: 0
X-Va-ID: 9f86d6d0-a97c-448f-801d-fd4675a8131e
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: d85662c2693cab3d0081332caa201860
X-V-R-CD: 53a156bc41a6baf29217e9ff01f61863
X-V-CD: 0
X-V-ID: 9f785264-dd25-49c4-9bc8-987f0910054f
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
Subject: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing git-svn
Date:   Tue, 29 Jan 2019 11:38:08 -0800
Message-id: <20190129193818.8645-3-jeremyhu@apple.com>
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
 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f1faa24b2..4060a53f56 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1017,6 +1017,9 @@ fi
 
 GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
 export GITPERLLIB
+PERL_VERSION=$(grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$:\1:')
+PERL5LIB="$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PERL_VERSION
+export PERL5LIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
-- 
2.20.0 (Apple Git-115)

