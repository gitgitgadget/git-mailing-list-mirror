Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D701F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfA2Vcf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:32:35 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:39706 "EHLO
        ma1-aaemail-dr-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729531AbfA2Vcf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 16:32:35 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJasc3029331;
        Tue, 29 Jan 2019 11:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=PcSEQlv2ej7UIOl3joc+2+vIcGSc8qA2iFGc2CB2Fxo=;
 b=ovbZGYN4A1RKmXIeUvjXvJALt7IdU5eh9W5F+0FULrhCj2chzDfPjFzWv1VhVKImamER
 GEkBJ35XeaFW7gJFer/YBT4/7sFzzq82lGi6OHiJFxZ4RNesSbR7VpOlQ+PbAjRE+JDy
 rwNzXsFCrizeaAI1/dOnbctilYcWZH4mY9nO3ZHOJ5gE5eAfBB/S7RQjbeKNpnNjakWP
 H6kbvyu0DSTJDcKRgUDZOR6L6+DAqY/yHFWn/hoLK/kze8phQB8gXjfkH4/cBvkjw/yU
 jh2iNPvnBHo0RXVgEm0xWHkeuvA9x+Wj0UhaRA46Q0z/TxrJOPk16ekzm+9CTX8FutNT LA== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com [17.179.226.133])
        by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2q8qe37s2f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:37 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300L5TYM0BND0@mr2-mtap-s01.rno.apple.com>; Tue,
 29 Jan 2019 11:39:37 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300C00Y9IP900@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:37 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 249c6f1ae3114c2f13bfeafb12b7216f
X-Va-R-CD: 6c9f092297d979b2478c63065f77f984
X-Va-CD: 0
X-Va-ID: f70a43ec-340b-4a19-83dd-dcb39c14d06e
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 249c6f1ae3114c2f13bfeafb12b7216f
X-V-R-CD: 6c9f092297d979b2478c63065f77f984
X-V-CD: 0
X-V-ID: e6cf812c-3b6d-414a-bef4-dca1d0f21847
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 13/13] Enable support for Xcode.app-bundled
 gitattributes
Date:   Tue, 29 Jan 2019 11:38:19 -0800
Message-id: <20190129193818.8645-14-jeremyhu@apple.com>
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
 attr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/attr.c b/attr.c
index eaece6658d..1b87905d4a 100644
--- a/attr.c
+++ b/attr.c
@@ -823,6 +823,14 @@ static const char *git_etc_gitattributes(void)
 	return system_wide;
 }
 
+static const char *git_xcode_gitattributes(void)
+{
+	static const char *xcode_gitattributes;
+	if (!xcode_gitattributes)
+		xcode_gitattributes = system_path("share/git-core/gitattributes");
+	return xcode_gitattributes;
+}
+
 static const char *get_home_gitattributes(void)
 {
 	if (!git_attributes_file)
@@ -864,6 +872,9 @@ static void bootstrap_attr_stack(const struct index_state *istate,
 
 	/* system-wide frame */
 	if (git_attr_system()) {
+		e = read_attr_from_file(git_xcode_gitattributes(), 1);
+		push_stack(stack, e, NULL, 0);
+
 		e = read_attr_from_file(git_etc_gitattributes(), 1);
 		push_stack(stack, e, NULL, 0);
 	}
-- 
2.20.0 (Apple Git-115)

