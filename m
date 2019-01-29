Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E5A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA2UEm (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:04:42 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:49766 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfA2UEm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:04:42 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 15:04:35 EST
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83i031166;
        Tue, 29 Jan 2019 11:39:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=TWflV/Qa8QKmHSflVyA0aJmsE1Mvnz+xqFAT+EJZCRc=;
 b=AZ4IeUMDcBv/h3EDZAzCMx5Kq2adp4sWw1SraiMaZKbfBN3omRkXGvigTP5xZNeggEPy
 kbfP1Fv3szz4fG94cjlaSDyAjKZ1OpfqDomzp+gG8jrqF9wCCdTGJm/ZNU1KJPDhq4rZ
 FYGoPcl3PCRNCJKQUiH4YlIOtm/LRpjRn0IIl2SJYs0cQvSKZ55rcF61IXCP+/U5Ob1+
 zQhqg5b20j0dmU47pbf5MI3yNMdMJdy2gMoqGl86AuOqD4ZroctketXOYX6QrKrPNNiU
 VyUA8FyeFtNBXznf1ttt3bDU7nWzyDMgEtDSTk81WW5W0U0WtvXeh7lO8b7D2S0Nl/nb Nw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-9
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
 2018)) id <0PM300D00Y9OJL00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 15397c394c71dc32ddfd580d3694a409
X-Va-R-CD: 38569fc3dd080465860bd9d268b33f29
X-Va-CD: 0
X-Va-ID: d0364088-3cdb-4019-9313-e7828ca7cc0b
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 15397c394c71dc32ddfd580d3694a409
X-V-R-CD: 38569fc3dd080465860bd9d268b33f29
X-V-CD: 0
X-V-ID: 5f87fe2d-aa1b-4254-8e1d-4a9355a8536d
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
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
Subject: [PATCH (Apple Git) 08/13] git mergetool/difftool doesn't list
 'opendiff' as an available tool on 10.8
Date:   Tue, 29 Jan 2019 11:38:14 -0800
Message-id: <20190129193818.8645-9-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See <rdar://problem/12652310>

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 git-mergetool--lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..f85be7406f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -273,9 +273,9 @@ list_merge_tool_candidates () {
 	then
 		if test -n "$GNOME_DESKTOP_SESSION_ID"
 		then
-			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
+			tools="meld kdiff3 tkdiff xxdiff $tools"
 		else
-			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
+			tools="kdiff3 tkdiff xxdiff meld $tools"
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
@@ -288,6 +288,8 @@ list_merge_tool_candidates () {
 		tools="$tools emerge vimdiff"
 		;;
 	esac
+
+	tools="opendiff $tools"
 }
 
 show_tool_help () {
-- 
2.20.0 (Apple Git-115)

