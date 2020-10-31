Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795BC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104A2206E3
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 21:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PsO/U0PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgJaVFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 17:05:01 -0400
Received: from avasout01.plus.net ([84.93.230.227]:60456 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaVFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 17:05:01 -0400
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id Yy3Xk1Tqbn8O7Yy3YkHniH; Sat, 31 Oct 2020 21:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604178300; bh=tS1fFzkPn0ZNwZ7IQRXd0AN9mB9aVIC8gHDuKvA5dLc=;
        h=To:Cc:From:Subject:Date;
        b=PsO/U0PTbMD2bPc6f/S2//oaW2JeqxhyeJ1XXYhR10eQjGFeYnMdh9Holevf6m0JV
         jJ6xB9mQBLqXwQ6NwQ2SF0OcpvHFvts1QAjTd/LW4a4nkFGfC9R3RLqg5o8s9Iaw1P
         ERwqDjOGBcNCqYmv3sdZFT72lGAKwcQlS0u3SWAQlq4XNFIqSridELz+8UAzwRNU+i
         I3D0GKTA2OvFh8ZdfOGzIRPDnj3l2rZHWEPc+psqKCBBQrexjSinTuD5E5OQWkz2hJ
         BMDGHQAI2Vxv7YdeKSDwlU4zlbW/LuPd7hwAScugNjvloQ3aCDhQVYNvItWAa0uswl
         G+h4IYbINWcUg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=0N6sMt672HxyIZQyLvgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     steadmon@google.com
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] upload-pack.c: fix a sparse warning
Message-ID: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
Date:   Sat, 31 Oct 2020 21:04:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEOXalXQ+QWtDchta1gEJNKliSD6FocoNwRlCyUmwATp+jhDVayCkytr2kcsYN5UsN5MuNRJQyGCqeP5u8LCziJGouYPaiGn3dXQGXu09B+9UMUIyaqb
 KxVQOWt7nk4o+EfT6PfWxvVXIH1Ikq8NgK2qBxMYwesmzs2jxfuBg2ZKWgM4yn0vblEcxjJ2gS2lww==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Josh,

If you need to re-roll your 'js/trace2-session-id' branch, could you please
squash this into the relevant patch (commit edb21a501e, "upload-pack, serve:
log received client trace2 SID", 29-10-2020).

Thanks!

ATB,
Ramsay Jones
 
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index b7d097bf1b..2996b8083c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1111,7 +1111,7 @@ static void receive_needs(struct upload_pack_data *data,
 		if (data->allow_filter &&
 		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
-		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, 0)))
+		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
 		{
 			char *client_sid = xstrndup(arg, feature_len);
 			trace2_data_string("trace2", NULL, "client-sid", client_sid);
-- 
2.29.0
