Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 25110 invoked by uid 111); 5 Aug 2008 19:15:42 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 05 Aug 2008 15:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbYHETPa (ORCPT <rfc822;peff@peff.net>);
	Tue, 5 Aug 2008 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYHETP3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 15:15:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYHETP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 15:15:28 -0400
Received: by ug-out-1314.google.com with SMTP id h2so114128ugf.16
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 12:13:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=/MlwU/7D5PWlDI3DEaeRhuaAv2YYNuH5yEQNXV9vb8M=;
        b=BbGLd/xJ178JGnF/xMaEiWurtpnJudr5wDA1/NqITOzEBGKpqxnEMPrXxPbXXz2BVR
         GpOX3ajTkXIoOi9WvBuCQ74cqVwruiQHkSGVf2xqZAYA3W7hxNsVbc0/ucs7kWpWGxWL
         U6Cdq814uijJnxLUQBXsyXbf9YlE6DE8upEeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b4kDvPpYiCm+yxKXGGkZnTXP6r5T6gFebhfqjtpjAuiwVv3ZVcLFJN4H5gJua3A3Nd
         TSIDAYsXvrPJiUBlwa9B6ikLZ9cWAw6sH/8s+E8EBmu8bPoMcSXAKfBr6LZBnF74Gdtv
         SJ1pXPkNysLRju8jQ2mRsGOkaXmmuUSnzlpz8=
Received: by 10.66.220.12 with SMTP id s12mr7342047ugg.5.1217963617792;
        Tue, 05 Aug 2008 12:13:37 -0700 (PDT)
Received: from localhost ( [217.234.105.117])
        by mx.google.com with ESMTPS id 32sm2223000ugf.51.2008.08.05.12.13.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Aug 2008 12:13:37 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH 2/2] tg-create.sh: Introduce topgit.subjectprefix config option
Date:	Tue,  5 Aug 2008 21:13:30 +0200
Message-Id: <1217963610-15195-2-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
References: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Set the topgit.subjectprefix config option to prepend the string to the [PATCH]
field in the Subject: line of the '.topmsg' file.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 README       |    7 ++++---
 tg-create.sh |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/README b/README
index bd4f17a..f821bab 100644
--- a/README
+++ b/README
@@ -204,9 +204,10 @@ tg create
 
 	After `tg create`, you should insert the patch description
 	to the '.topmsg' file, which will already contain some
-	pre-filled bits. You can set topgit.to, topgit.cc and topgit.bcc
-	configuration variables in order to have `tg create`
-	add these headers with given default values to '.topmsg'.
+	pre-filled bits. You can set topgit.subjectprefix, topgit.to,
+	topgit.cc and topgit.bcc configuration variables in order to
+	have `tg create` use this subject prefix and add these headers
+	with the given default values to '.topmsg', respectively.
 
 	The main task of `tg create` is to set up the topic branch
 	base from the dependencies. This may fail due to merge conflicts.
diff --git a/tg-create.sh b/tg-create.sh
index 0bf329c..c2b38bf 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -107,7 +107,8 @@ author_addr="${author%> *}>"
 	! header="$(git config topgit.to)" || echo "To: $header"
 	! header="$(git config topgit.cc)" || echo "Cc: $header"
 	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
-	echo "Subject: [PATCH] $name"
+	subject_prefix="$(git config topgit.subjectprefix)" && subject_prefix="$subject_prefix "
+	echo "Subject: [${subject_prefix}PATCH] $name"
 	echo
 	cat <<EOT
 <patch description>
-- 
tg: (2fc069d..) t/subject-prefix (depends on: t/fix-subject-line-in-.topmsg)
