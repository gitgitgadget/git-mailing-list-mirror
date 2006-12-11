X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add comments to update_tree_entry()
Date: Mon, 11 Dec 2006 22:13:11 +0000
Message-ID: <200612112213.11829.andyparkins@gmail.com>
References: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:16:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=Jbllw/CHHZORrzHRiZ12B/e6Aqq5A5xUNlil7OM3p1pmSyAka9zTNMcli7k78yCb569V4RpxmFzWqeKP53otad0zg1SbOXgocYCXQ3pVx6IncS2l27Qh/lkB/RqnVPF1Wz/TvhGiEX1v5p4rKB2nJSsqPDt8ycO2d1o2rKP3qas=
In-Reply-To: <f323e83a37efd3b913004666f2fc104578a92833.1165875140.git.andyparkins@gmail.com>
X-TUID: 89a2fe079079881e
X-UID: 185
X-Length: 1320
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34045>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttRV-0000Y6-Sc for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763168AbWLKWQG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763170AbWLKWQG
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:16:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:15250 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763168AbWLKWQE (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:16:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1471083uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:16:04 -0800 (PST)
Received: by 10.78.17.1 with SMTP id 1mr1986041huq.1165875364016; Mon, 11 Dec
 2006 14:16:04 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 39sm3249198hui.2006.12.11.14.16.03; Mon, 11 Dec
 2006 14:16:03 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 tree-walk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 14cc5ae..5363366 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -37,6 +37,11 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 
 void update_tree_entry(struct tree_desc *desc)
 {
+	/* Each tree is represented by a buffer containing hashes followed
+	 * by space followed by filename; separated with NUL.  To move to the
+	 * next entry we simply move forward by strlen() (which skips the filename)
+	 * then skip the hash and the space. */
+	/* This function should really be called skip_tree_entry() */
 	const void *buf = desc->buf;
 	unsigned long size = desc->size;
 	int len = strlen(buf) + 1 + 20;
-- 
1.4.4.1.geeee8

