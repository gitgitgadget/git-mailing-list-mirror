Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF3C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25CE2168B
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="qXDilDVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbgFSQMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:12:22 -0400
Received: from sonic317-29.consmr.mail.bf2.yahoo.com ([74.6.129.84]:44871 "EHLO
        sonic317-29.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391237AbgFSPFF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592579103; bh=OjZfLgI/+5XtwrIq5jnbx9zGRv+Hc5dh+J0tUW9mGnY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qXDilDVZPCqckBBcWJ2b/W8LLK4a+DZkI+3CmB3KoW9YnUFtzZ3Qt3dT8Ukw+uZ0O3WuIFaL0YNxhyVzY7VQEeWyp0VPG4kCtAv4t1BKk1WgqmXE9G9+t3pfJxv/JOHejBGzaMkV159m8GsJQDzLFDBfwdwmFTS4LEfpcQKPYNfLm6dghXOt0iSfyXMWLEAcZWXsZe4yN4PYPsForm8r/cEEAH7wp0SBOlAtnNAG/IlEWldvXM2AaB5vwXRcmYDwila4ddZwlJMCHwdgPVPXP/G9eUMg+yRe+4p5WNjFSpHrMyGRNSzWtSdX7vL81EQ7RY86U6msCqFmnZowEruDLQ==
X-YMail-OSG: iBgJ9AEVM1nkgX5hnmJF0S3Yfircdgv3ybU02kd0qi0..Kn80ClPNVpsQQdK0Sm
 hY.3_3tBB9vSGmRSOLVwYX3ieJTWD2bFRcPTK539lmIjq.IZUdQIdiRSgEym43Zs3BHWd4jP3iFf
 xJfloigGNzXo9VqoF8uUIabg4jI7bDsF3ZKApdbjJWFLkI0zJdcVK0sSTXNM9wrVwy8lNay_FU9E
 uUlG9pHxPfv28BAZFv7vP_NPkcK5EwDed8uvYh5evF5u5EOV3nUoGhzmqYYkdBdpXDL9_eJc.dUa
 oPa5lWmh_OxR2bKToMuZki94hOMjTXgJS8b.4_z680StlL7isipSkNx9LActxDBQeKlbs.ImdnPI
 T3vTPkXS04CBeUIf0HXOXwihygswYIt8ODJcgtaDkcEBWA4vC_zXRxw8PzR7sbGAyjfcnnEZRZ4o
 jmHeyk1cVjRtjySABsajTM9UpdHeTsjA3PWNKHskY5eFA36DojTXmBlYVQgoCG.n9sWD2icag77a
 h03JPzMQars73GIWAF2yQwfxm2sUFAxfVHZw715D1HnzO_6s6qoWbI3Z_NxWO3oObZiHAmuimp9n
 MyiC0dli8YmaN9KHaljRgEpKMA7qWLAwxCYJJ2mOHbDhU1M_k4SSUt3JWzvYqLZ7qFyvZxfqsREB
 szDofxTfs80dv_anTjBbfRVFfHqRVGdsIKLua5rPI7WEBF7ncQep6NyrAmi9z_cZS7ao1tjBM4N_
 Wypqfb_1LRBhPSV31yvSaYPwiJAhiDwiVesuQZy7hRYtjSGcFKfAUOKi_lHJYptuWP7mwOeUIAfj
 9pnIatO2_8UJGrsUX352nxRDlDa.2EL2gn_.8CL6Xpjy_jHizEkL8sACJtnkYq1ESHVg5kwaNSbg
 qFwuFiSYEHhg1ncCjN92r6jfrbk7Rxp761Zozag6YDpqDeqC9ovEDi24pqolQvLIc4KVz1Q70sVG
 .ldNnrJRaA92oJdvKvNAHB32tsFEVyrATzv02obvnHSqWyFzsOfyfYIyDoMActqdWoFa5ROGPMMc
 zxtCa2S0DPv881BLXYM0hqws.auFgKL.0QW_qvb9troq4BYfLBvU4hz1qQSr8h8UlrgTZtvyXwPI
 k8sscjtTBoCSaxdFZqc8v_U_SqsHRGPlK2Mr98DSxn4rnKAXqjBq9ZvIh2OIlz7nL045EpgeiaKT
 aU49hFN9Jqt25fVgcX2BzkuRkiHWy.QCX3JHWgKn8Aw4wJ.aDuOQ95ncRfveUKn4YI3o_CVYnkvZ
 iZycRHFvvkqIx48buM22fWZ_p9nVb1cYu9yTPC3qyKH5MXmMCZus_4A79k9valEdtBVdTfqifjYd
 1l2RE5GmEX7p0KMGIgHPTQPkCqvGUnjNXq1SSYGtQbaYIxKp7o0xJpjP9GQzzWmSo.zz_RedZrKj
 yjhRktRGzCrGH1vPZsxHfp6Y2Yo2XlQ.C8JGjJ8ywGrnF.UGFH7Cyfy3XCO3Ggfkt6_8Y7HMwPh2
 dwA.kTgl_uNc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 15:05:03 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a3a454d2fd8d91b05ef2f93e2ccfa888;
          Fri, 19 Jun 2020 15:05:00 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 2/3] strbuf.c: remove unreferenced strbuf_write_fd method.
Date:   Fri, 19 Jun 2020 11:04:44 -0400
Message-Id: <20200619150445.4380-3-randall.s.becker@rogers.com>
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

strbuf_write_fd was only used in bugreport.c. Since that file now uses
write_in_full, this method is no longer needed.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 strbuf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 2f1a7d3209..e3397cc4c7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -556,11 +556,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
-ssize_t strbuf_write_fd(struct strbuf *sb, int fd)
-{
-	return sb->len ? write(fd, sb->buf, sb->len) : 0;
-}
-
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
-- 
2.21.0

