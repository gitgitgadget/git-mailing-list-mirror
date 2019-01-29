Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0181F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfA2UGo (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:06:44 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:56062 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfA2UGo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:06:44 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83a031166;
        Tue, 29 Jan 2019 11:39:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id; s=20180706; bh=BSPX1p1V/XBW9s1kBTU9GqDi9eOSkyri/68TrkxOyQ8=;
 b=WkWjPPfDavWRXSmVtg5+BQbgXfgK+c8EsAS6njTnJJCw/GvHt5+vSVYWSHDMmGyX2UDw
 jUA7i72apnmRZoStgd8CGoilEPw+LqUHluVCpGprbrf6Dias5NHO4uF0hqwvlDUZm9r6
 nfZqCaPw/MSIzPyqyUOthCVoMhS5r6sQq0h0pTzAYkPiWx3cSXtMiD3NyyF5KY5RaPFw
 16KWvpH+iAyykjdWYtxh1I9W6X3rwpxATPEEvnpezVTHZ0VyHN19JBwpleiFFmeHo6yI
 FQLO0YGpWsOcGM4MaT48Lfgb0sLvDU9n0CIronZUdELeEewpYDuv/QcToZQ3pn7k9qC6 Bw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:35 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300AIKYLYUZD0@mr2-mtap-s03.rno.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300C00Y9IOZ00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: adb1588e84afdf536b08c177728c48c7
X-Va-R-CD: 2b498eda93b003d4b30230ca05ddff23
X-Va-CD: 0
X-Va-ID: f36a0e69-c346-44d6-94f0-9931a7cdebf2
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: adb1588e84afdf536b08c177728c48c7
X-V-R-CD: 2b498eda93b003d4b30230ca05ddff23
X-V-CD: 0
X-V-ID: b1c368e9-73a6-4bfd-9ef3-703865733530
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH (Apple Git) 00/13] Differences between git-2.20.1 and Apple
 Git-116
Date:   Tue, 29 Jan 2019 11:38:06 -0800
Message-id: <20190129193818.8645-1-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xcode 10.2 Beta 1 contains Apple Git-116.  A couple months ago, Peff encouraged
me to re-send our changes in a patch series to the mailing list, so here they
are!

As reference, these (and past patch series for Apple Git) are availale at:
    https://github.com/jeremyhu/git

Some of these patches are upstreamable as is, but othes represent areas where
customization options could be provided upstream to allow similar behavior.

Note that I am very grateful for the recent changes in mainline to support
RUNTIME_PREFIX on darwin.  It almost completely replaced our RUNTIME_PREFIX
implementation and made the few remaining changes much more maintainale.

Please integrate the changes that are upstreamable and let's use the others
as a starting point for discussing how to accomplish the same effect through
configuration options or other means.

Thanks,
Jeremy


