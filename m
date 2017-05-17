Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C8E201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbdEQMGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55110 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbdEQMGK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:10 -0400
X-AuditID: 12074413-0c9ff70000001dc3-ba-591c3cab4abe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 06.8E.07619.BAC3C195; Wed, 17 May 2017 08:06:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pft000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/23] prefix_ref_iterator: don't trim too much
Date:   Wed, 17 May 2017 14:05:27 +0200
Message-Id: <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLvGRibS4MN8Jou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGn49vWAr6eSs2X77I3sB4gquLkZNDQsBE
        4u38bYxdjFwcQgI7mCS2PvvGBOGcYJKY+O4ZC0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgcdM
        En+XdYMVCQvYS2xa+pS1i5GDg0VAVWLaDS8Qk1cgSuJaTwbEMnmJXW0XWUFsTgELifvvH7GD
        lAgJmEtsv145gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQMBPe
        wbjrpNwhRgEORiUe3glc0pFCrIllxZW5hxglOZiURHn3PwAK8SXlp1RmJBZnxBeV5qQWH2KU
        4GBWEuG9aSoTKcSbklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuAVsgZq
        FCxKTU+tSMvMKUFIM3FwggznARrOBVLDW1yQmFucmQ6RP8WoKCXOG2sFlBAASWSU5sH1wtLA
        K0ZxoFeEefNA2nmAKQSu+xXQYCagwc0gH/EWlyQipKQaGO28L6RI73lnu02B6ZT47v6tGZzz
        92p9MFHRWjInqSq778/GI633pvrpLau/cIK7dwaLlMhDmYsxMX/NzRTaTMQTF53lsEnZefLx
        y0dBL6eKpBYVPQrkvu2/+gDH0hV/G5IU1CcmCK03WZQsYLkpcHF2YHvoN0H5PkmLloC8lIik
        HVkXKl69UWIpzkg01GIuKk4EAHJ4BGHeAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `trim` parameter can be set independently of `prefix`. So if some
caller were to set `trim` to be greater than `strlen(prefix)`, we
could end up pointing the `refname` field of the iterator past the NUL
of the actual reference name string.

That can't happen currently, because `trim` is always set either to
zero or to `strlen(prefix)`. But even the latter could lead to
confusion, if a refname is exactly equal to the prefix, because then
we would set the outgoing `refname` to the empty string.

And we're about to decouple the `prefix` and `trim` arguments even
more, so let's be cautious here. Skip over any references whose names
are not longer than `trim`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/iterator.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index bce1f192f7..f33d1b3a39 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -292,7 +292,19 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		if (!starts_with(iter->iter0->refname, iter->prefix))
 			continue;
 
-		iter->base.refname = iter->iter0->refname + iter->trim;
+		if (iter->trim) {
+			/*
+			 * If there wouldn't be at least one character
+			 * left in the refname after trimming, skip
+			 * over it:
+			 */
+			if (memchr(iter->iter0->refname, '\0', iter->trim + 1))
+				continue;
+			iter->base.refname = iter->iter0->refname + iter->trim;
+		} else {
+			iter->base.refname = iter->iter0->refname;
+		}
+
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
 		return ITER_OK;
-- 
2.11.0

