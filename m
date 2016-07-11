Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3491F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbcGKRX1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36646 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbcGKRXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so15280003wma.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bKtH6MaodUucGSfeLvCyTBbKEI0DLhS/16Vx+Vb5fk=;
        b=qgNUgJTAJ2B18XuCoHUgQfBYltsx+Uu1fMeg7QFTt0vjuznJQpy2+vnoylhSXtcf01
         oAcLgYROOWptfZerR74v7vZsHYuK2LFoUNlhvQ+gfuReEOMHvy9zWc1e7xhlbRFOSvTy
         W56vf4tR8IwXw3CLM4L/qKDkSgVDVV8SZnEAcq+x3YMoXoF8+TLLByTe/TUNm+0JjCXc
         DNJUqfTPidlCSRNcE5E0vmuSINTzPy/a0bVuMt8mPDMCS0gPU8hBWYQFS0TiyTkrHJtT
         Vb+4zChBHa8/9EuUzbBgCDXNgst7cxceWZB20wQ0MThmsTbAY3D7D6zwjLsVZKjgmCVF
         NLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1bKtH6MaodUucGSfeLvCyTBbKEI0DLhS/16Vx+Vb5fk=;
        b=F7Wag74hyQKWlXDMntxPJwEqTHus8yZd92f7o7dcfMtd0EGEGcRE9ulvU3il72T4/9
         m8BFmnfWV+ekYK7CLtvODN+CKYE1LS0RRRqNmgBZpem8AqU5VIG/f1TV7+sE99Z9vAnz
         31uZWV52kNmzpxyRVa7w9YFqTfNQzA/fyoby3ewWp85WqKUxBjdI1IGDaEnqLLGsVn02
         svbnE9LxI6/kU3vdoxIWNEeWnh243wx5BwczhsG444AeK6aNg3/o84dDmhjwFMpd7joI
         k6YLQbV0+6zE9yV7cadhZC1NtPyNogoIF72NWZd3HRvCKPi8RW5UmiKO//DCufbalWye
         Q8RQ==
X-Gm-Message-State: ALyK8tItRvTISvwjIDvk/YGML0ZtyvxamCGWDI/ORs91Fq/Kiny6axFaF6lBMw0oN4jggw==
X-Received: by 10.194.15.72 with SMTP id v8mr951641wjc.149.1468257804192;
        Mon, 11 Jul 2016 10:23:24 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:23 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 5/8] Documentation/config: add information for core.splitIndex
Date:	Mon, 11 Jul 2016 19:22:51 +0200
Message-Id: <20160711172254.13439-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e208af1..aec8ecb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -324,6 +324,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.9.0.250.g7087ccc.dirty

