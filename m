Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FBC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCA821527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="OU+rirSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbgFSPFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:05:10 -0400
Received: from sonic315-16.consmr.mail.bf2.yahoo.com ([74.6.134.126]:42023
        "EHLO sonic315-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390529AbgFSPFF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592579104; bh=rQUXSgP5Ctdi8nvT2QaVyYKlULe8Sq89kS+x9oJt2X0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OU+rirSDp9M8K2ER8jmWndzk6bsj6OhD6da3FwGUulAyv2gr11VcqFr3MMAVbiDT111xCJIWDSQjJiQssqcQY0Tj5dD6X9aEPS/aCVJHYh2kAzGLnNVVyUZumKsRXIilISDglFk4R5f6r+JC+ohUe+by6Z9ovtSx1hV+yGirmZjKeIXY23tNWUximydG3vv3WDWDLBckhTCBjG3fs/DkTgxHQD2n6WWbsk5o+/AO92PBN+fJcgtB8lTjnUnT7yjOOG8yYGQUyYJcJ2vmp5W+6zq9dyIE2fj4Dw26ZtzWn27JYBZUdKr1GQN1PljV/S4N2Su5/KICROpC7yOEMxbr3A==
X-YMail-OSG: cZZRLS0VM1nZxyhh73XPAc9cL.NFcSGQKycD251.HXBsBuy3.tiZSzmZCi4Sqbm
 nkNxbRMF0V7iNULOILgRR8ubO68xLyYQQRS7DiOHNRplahf4ymc0YZZQU4fhoa0aaBFfEj3kvgNn
 s5f2BcQeIJ5t3bG.nK4thhzedLbSsj27wP1Ivyg3Xk4IGN6_1eKx33ermhllgFHJdLt.1YaYt8F4
 DsCgjG5bHsSfTjXLVJlkZWOGvWnpeJkeIlFL.AsBrNFEAxCdcnxaBij62pjuh2BM2Kq4GQiqxPo3
 r6qmZHkKAyka4pvCFmxR1r5qpsr3kvLiSBnG5leCTPsbtvALQ5gAWz4aa8qss_0xz8JcUA2ByXwK
 3lyDh9YRaU7s5MH05lOAIbUDOsW.kChGvUFuCf3PE97eURiRCt5GvhaMrS20Tsi8uNx8WDSCMJiF
 SrasT5cg68_Smxe5aiBomslqGzKm0bQZqysRJq4JQMbt5ZZnSkMQhh6CQlpSwqh.BaGppziU5MLn
 w_VuvzwFzRdNZmgKSS5Wf__SJ6n53ddDwtiR5AKtMSVjYviswKMxI4.spyvCVSa.PE03BKnrVyDL
 4Cn9qjtOoeFGdd4IOHHrh1b2f7f9NYeKBdispbCK_Otc1WPQhdaLxpooIXwrqHLfXRQd1fDhttAq
 q6SA62j0VPUa4_0uCexzHDXPzlVrn.yXG9588OKXnYPwj0N7fbHjb0s_Y9ph6RwT.gDWkZZM6BGu
 cFIW8a4z63F6Ijy07fIqCy_WkFh5Knoh99_kqCS25O.kdaauCZ4eEm20S7XTiyotxH6zTJ1rxAHP
 0wY_jaYZYk2UyqTOZPBLocOXi0T5h9NoP1DJylUbBrrSR2oQ8qsSrvdOx1c0I.wD276XQ8kK1_IJ
 CySU1jDyDUF3frI41li__Vuax.HmFkUJtj0v6yFoNoeo5S8eHlVrO5fnHMDolCzrvK3rWdUYEqah
 5r7bSaa2Aj7Bf1vOGY5xCPhaRDQzDyS8SOB3jQhetXu7s4wmnUKNQNy6vt8U6tuUjzl0y7oN7wZG
 Syb6ilX5x2i1WOgn3j9lP8j1Td.8Y3W0puiDXK2gyfAqKgIwuEFSKjXy8O4MLWZI0ITeXmI.EtPN
 6PkYhi6toYjUd7zWXKql2TGgTVzXWM9R347MmlqZFA8QsBAR4GYROGze1UfZaK9024gwTf0pDYDv
 q_SKiEeOaFzXuFBsNwqm9in_6mKcKmYEWTuCCNzzVNm_TwSfpBRuO7uqxo3Y6cOz3Ozx6DzxQMFv
 cF_nv2QNsvQUEQvEXmNAGowBSrWOo9MvtzCy2ZXDQELBgszDYvT7RkPgrBcEtBEcszdtoBdMgdzK
 9D8ZmacZpChJmwWNDRsc9s4hopp.9OOcVtBvoEft4SrvUX4TgR31D4t0EHGqvj8ZN0SuV4CGyGaZ
 cK8NYxBUqftSVRuxox.hsVELbuej7qE9nufEEKisiE9M2KIHrIQ8vSa7kACxRudTaqNwwUu96QgI
 RZQlx6sF.2l1V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 15:05:04 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a3a454d2fd8d91b05ef2f93e2ccfa888;
          Fri, 19 Jun 2020 15:05:02 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 3/3] strbuf.h: remove declaration of deprecated strbuf_write_fd method.
Date:   Fri, 19 Jun 2020 11:04:45 -0400
Message-Id: <20200619150445.4380-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200619150445.4380-1-randall.s.becker@rogers.com>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 strbuf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 7062eb6410..223ee2094a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -473,7 +473,6 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  * NUL bytes.
  */
 ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
-ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents of
-- 
2.21.0

