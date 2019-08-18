Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549071F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfHRUFu (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58014 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbfHRUFt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 07BA760736;
        Sun, 18 Aug 2019 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158747;
        bh=Cvhh0ce9G/l6AYaO6kqaExnwR+Ald1DPK7Qv8aiDHYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1cN224hdtXIk6u/BF0qHIMfPoh1MJuKfaz8fkRDWRHdu1feUCGuDbFAKsd1iZ8fAT
         FHtyuaFQgU6aY6LalN4bs2QU0B/qylQcHnZ6rZIXno/Cl7NFq7NcFa6MR9aBX5vI8N
         g7J1iC7hpSn+vfknz34eePhLl5N58/ivUiliG7ivgLVfThdWH9dZhqOXQr2k3fVhyX
         WZjIoSt7Upm5akkcUNp4qbO51hhJRIkVBlThJT3PhVsJYqcgliX+bIEjzOhaimUw1A
         pwpysZqH95AQ3TjR75Fg5ykkjFxYnWMl2vX0RJ67ay6PAqMJDEVV0XtX+J+N2G4E12
         K/GEOkOtwspuG+AT5KdJVH5je70c2AnBMJzAC7SUPYX3RylRkd3Ce+d1IkaSKw1xQL
         B1xqmsIEUpHRFBH3iYNk6wFwixND2aWi5FNzNCIhdF/Wp5GiOB1HvUIxQcYchped2W
         Vzl/68Qn76mR8j+UFo9hxdbg1ka/aufnz8p0vALbaArbnSHtCON
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 18/26] builtin/worktree: switch null_sha1 to null_oid
Date:   Sun, 18 Aug 2019 20:04:19 +0000
Message-Id: <20190818200427.870753-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch the remaining use of null_sha1 to null_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a5bb02b207..0c0df3b0b8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -350,7 +350,7 @@ static int add_worktree(const char *path, const char *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", sha1_to_hex(null_sha1));
+	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
