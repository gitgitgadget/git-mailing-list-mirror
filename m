Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE081FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbcHJS6H (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:58:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965047AbcHJS6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:58:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3452713CFE;
	Wed, 10 Aug 2016 10:39:37 +0000 (UTC)
Received: from [10.36.4.226] (vpn1-4-226.ams2.redhat.com [10.36.4.226])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7AAdZEt016701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Aug 2016 06:39:36 -0400
Subject: Re: [PATCH] document git-repack interaction of pack.threads and
 pack.windowMemory
To:	Junio C Hamano <gitster@pobox.com>
References: <db25fccf-ed85-3974-143d-2c50b3037642@redhat.com>
 <xmqqlh05ajbm.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	Michael Stahl <mstahl@redhat.com>
Organization: Red Hat
Message-ID: <cbee7385-5f66-0386-8566-ebf15ca9efeb@redhat.com>
Date:	Wed, 10 Aug 2016 12:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqlh05ajbm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 10 Aug 2016 10:39:37 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael Stahl <mstahl@redhat.com>
---
 Documentation/git-pack-objects.txt | 4 ++--
 Documentation/git-repack.txt       | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 19cdcd0..8973510 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -104,8 +104,8 @@ base-name::
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
 	size can be suffixed with "k", "m", or "g".
-	`--window-memory=0` makes memory usage unlimited, which is the
-	default.
+	`--window-memory=0` makes memory usage unlimited.  The default
+	is taken from the `pack.windowMemory` configuration variable.
 
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c597523..26afe6e 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -100,8 +100,10 @@ other objects in that pack they already have locally.
 	out of memory with a large window, but still be able to take
 	advantage of the large window for the smaller objects.  The
 	size can be suffixed with "k", "m", or "g".
-	`--window-memory=0` makes memory usage unlimited, which is the
-	default.
+	`--window-memory=0` makes memory usage unlimited.  The default
+	is taken from the `pack.windowMemory` configuration variable.
+	Note that the actual memory usage will be the limit multiplied
+	by the number of threads used by linkgit:git-pack-objects[1].
 
 --max-pack-size=<n>::
 	Maximum size of each output pack file. The size can be suffixed with
-- 
2.7.4


