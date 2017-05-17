Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA58201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbdEQMGt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57196 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753607AbdEQMG2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:28 -0400
X-AuditID: 12074414-071ff70000004f50-06-591c3cbe2c7b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B8.CF.20304.EBC3C195; Wed, 17 May 2017 08:06:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg5000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/23] ref_update_reject_duplicates(): use `size_t` rather than `int`
Date:   Wed, 17 May 2017 14:05:37 +0200
Message-Id: <42c41e7550ca4d81475780cd02b355a8c20cf4c3.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvPRibSYOYjAYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGtgvdLAX/mCuu3F3C0sA4k7mLkZNDQsBE
        Yvf7Z0A2F4eQwA4miQ+Nb5kgnBNMEvOmHWABqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCzwmEni
        77JusCJhgVCJ17u+s4PYLAKqEms2PgKL8wpESfz+cIAdYp28xK62i6wgNqeAhcT994+A4hxA
        28wltl+vnMDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSKiJ7GA8
        clLuEKMAB6MSD68Fh3SkEGtiWXFl7iFGSQ4mJVHe/Q+AQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4b5rKRArxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJanBwCNxd0ruBUYol
        Lz8vVUmCd4o10BDBotT01Iq0zJwShFImDk6QRTxAi7hAaniLCxJzizPTIfKnGHU55tz7+p5J
        CGyQlDjvAZAiAZCijNI8uDmw1PGKURzoRWHe5yBVPMC0AzfpFdASJqAlzSCf8haXJCKkpBoY
        y3mXme6fluPgXHfvhccyH7UHtpZeqotNBA9vDrkqqSSuI/su9Gl84OTfgTn7y//Upm1Vy7j7
        frr0oWsaLgw+N7uO37x4UOzipsMWe82qfVhU1ktN8WLNYm6sDmd/o2w214P5zZlzPTMmN61y
        7916P0a7QejRigyX2q/HLk0Q9dwp/qh8w2Z2JZbijERDLeai4kQAeiYJWvgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 43d65bc9c6..ffc9bd0be5 100644
--- a/refs.c
+++ b/refs.c
@@ -1692,7 +1692,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_update_reject_duplicates(struct string_list *refnames,
 				 struct strbuf *err)
 {
-	int i, n = refnames->nr;
+	size_t i, n = refnames->nr;
 
 	assert(err);
 
-- 
2.11.0

