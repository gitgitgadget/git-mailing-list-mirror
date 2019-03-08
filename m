Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B08820248
	for <e@80x24.org>; Fri,  8 Mar 2019 19:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCHTqp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 14:46:45 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46192 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHTqo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 14:46:44 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 2LS6hxv1NAOoy2LS7hozWH; Fri, 08 Mar 2019 19:46:43 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=G3HwsQ4Ae5TlnPrUaEkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] upload-pack.c: fix a sparse 'NULL pointer' warning
Message-ID: <3d3e6647-0f22-aed5-f388-fe5243662f94@ramsayjones.plus.com>
Date:   Fri, 8 Mar 2019 19:46:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPPtKdQfI6ipA7Y4sFurWStw4911Rm5/6qfIQxNa65hUe6KzKE/NUhNNkeFB+8PXrJjK6tmREWH2Insly9/wrliZUp1DqNYqbbwRbGqmcgSRmrN07+l/
 hKDWGnycQQvFl82ZNbGRgSDZJ91LMWz/TMrX4OiM/mxNfGQGwCSihRQ3H2VFlcG2Fe87HxaXOrxmpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/fetch-cdn-offload' branch, could you
please squash this into the relevant patch (commit 0e821b4427
("upload-pack: send part of packfile response as uri", 2019-02-23)).

Thanks!

ATB,
Ramsay Jones

 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 534e8951a2..a421df2bbb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1164,7 +1164,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj, 0);
+		create_pack_file(&have_obj, &want_obj, NULL);
 	}
 }
 
-- 
2.21.0
