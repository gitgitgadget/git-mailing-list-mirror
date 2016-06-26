Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DABB91F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbcFZEOf (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:14:35 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38869 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbcFZEOe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 00:14:34 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id CE4592B206A;
	Sat, 25 Jun 2016 21:14:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:mime-version:content-type:
	content-transfer-encoding; s=novalis.org; bh=fknsGv4cnFRIhMzXdUH
	b7z9Bq3E=; b=s6Ku75w2cdJ791MLqk2671ylHiYwESb2rIJO0jmNe7YUd/2bQ/Q
	56V5/TbTfyP/WnvQe8MIPf9fKEciqxgpfTgzp1M7+qy4svFoDe9bUQZU8yB56S1p
	252J74wAQvANmoov4ag9LcAI1dE5SXUpZItWPz3KLeNoe2HA1VIice5U=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 38FCC2B205C;
	Sat, 25 Jun 2016 21:14:33 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 01/20] read-cache.c: fix constness of verify_hdr()
Date:	Sun, 26 Jun 2016 00:14:05 -0400
Message-Id: <1466914464-10358-1-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
-- 
1.9.1

