Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC30C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5D320791
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="BSLSegwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgH0Arn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:47:43 -0400
Received: from avasout02.plus.net ([212.159.14.17]:41628 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgH0Arn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 20:47:43 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2020 20:47:42 EDT
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id B5xYkOySTU8CkB5xakdI78; Thu, 27 Aug 2020 01:40:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1598488810; bh=zipowMLDCO3TEFbj9v0fyyjaCMhTL12R1aDyjQJK8pg=;
        h=To:Cc:From:Subject:Date;
        b=BSLSegwuyg8RUxFMreA0zGXN6JqtPGzqAojA3UHZkvkFqA4x9cu35cvSHrtT60AgV
         booQzMf+LmIWvhKQW97rXB3c/6tK/wlUMuMOZfmQLUs7ZqQ5FxASo9xcdOdCXHL9ru
         LrychrtY916CuL9WmTXU8Z/c/CRJqiUlJ5VGN/zkTTG0uXGM23UbZK9e1AT4vC5sDc
         K0L6NReRlMeYK13z1YK38V9zo1zSpDajcqssx50FeQgEt18qtxwtgfcUWNfnRwJa/u
         wQx8ooegMLmwiC8p9iXHdu9nyDtXaZ9NiPHIkwmQ2d/8lr+FZFOurwGjBLe1mdkKP3
         Gfb43PDEAO25A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=G/eH7+s5 c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=u5K2lFauhH6ctk0EEZQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/index-pack.c: fix some sparse warnings
Message-ID: <f2c8b658-f9d8-43bd-7121-9e0f04adeb4b@ramsayjones.plus.com>
Date:   Thu, 27 Aug 2020 01:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKDcJ+sI3UQo7hyAY+Ox/e8OKX+aw+3XVSV1EtSovDNNqQob6eU9ppcCMAHUB/MJlR3jthNWD84KtiwmtxVXpJBSWMrCL3Nnt+OP0QLGOr95eV3hjxhN
 +3DeRRS/0J5ptn7DmF/NQyEvhXv9GpQWdpjHMynl5xwT+YSGWhRsLcF/CvyRhDvo43jeLti7tiZMeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/threaded-index-pack' branch, could you
please squash this into the relevant patch (commit 4a03e3d995 (index-pack:
make quantum of work smaller, 24-08-2020)).

Thanks!

ATB,
Ramsay Jones

 builtin/index-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3a20017102..8acd078aa0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -65,7 +65,7 @@ struct base_data {
  *
  * Guarded by work_mutex.
  */
-LIST_HEAD(work_head);
+static LIST_HEAD(work_head);
 
 /*
  * Stack of struct base_data that have children, all of whom have been
@@ -75,7 +75,7 @@ LIST_HEAD(work_head);
  *
  * Guarded by work_mutex.
  */
-LIST_HEAD(done_head);
+static LIST_HEAD(done_head);
 
 /*
  * All threads share one delta base cache.
@@ -83,8 +83,8 @@ LIST_HEAD(done_head);
  * base_cache_used is guarded by work_mutex, and base_cache_limit is read-only
  * in a thread.
  */
-size_t base_cache_used;
-size_t base_cache_limit;
+static size_t base_cache_used;
+static size_t base_cache_limit;
 
 struct thread_local {
 	pthread_t thread;
-- 
2.28.0
