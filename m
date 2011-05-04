From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 3/4] http-push: use const for strings in signatures
Date: Wed,  4 May 2011 18:11:35 +0800
Message-ID: <1304503896-5988-4-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <1304503896-5988-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 12:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZ3n-0002px-4o
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1EDKLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 06:11:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44899 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDKLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 06:11:50 -0400
Received: by pvg12 with SMTP id 12so429002pvg.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ObKwg4b8ABRbflkn4dh7FEkEjNNmXsjXhCJVXlAH5bs=;
        b=MICMa8fqH+Wz6hNAZEn9rABmIy/CydlywYRn5AgA3KsQ+Pe01JTnK6MwZ0N4CGXSnf
         416vEP/O21EXWZPNXz5n9XhqjhBc8QtYbTDC1Spqky4sGYAsBBPjF+xrW+V2p5wsP/4H
         iZPQaa5TTDwTgqoArCrdP81PDXMZ3CBHCv+SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EfJK/OrX46rsTsINt/s23dZmxA758QydxMzsLLTr53LMj6wE+RF3J/gUlB0noIrbUJ
         MEtvTs2SAySyNQ+HDoXqx8P21Ilbvw9Za0y+27JdQPotu+lPoQqZrIT1oJZ7pc0QbIt6
         PyBUcdctZ4MpldI8k33qPp8wLG8QU9Uxtymcg=
Received: by 10.68.66.35 with SMTP id c3mr1357585pbt.135.1304503909851;
        Wed, 04 May 2011 03:11:49 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id y5sm643190pbq.57.2011.05.04.03.11.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 03:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304503896-5988-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172735>

From: Dan McGee <dpmcgee@gmail.com>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index d18346c..0fce38d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -169,7 +169,7 @@ enum dav_header_flag {
 	DAV_HEADER_TIMEOUT = (1u << 2)
 };
 
-static char *xml_entities(char *s)
+static char *xml_entities(const char *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 	while (*s) {
@@ -797,7 +797,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 	}
 }
 
-static void one_remote_ref(char *refname);
+static void one_remote_ref(const char *refname);
 
 static void
 xml_start_tag(void *userData, const char *name, const char **atts)
@@ -1471,7 +1471,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 static struct ref *remote_refs;
 
-static void one_remote_ref(char *refname)
+static void one_remote_ref(const char *refname)
 {
 	struct ref *ref;
 	struct object *obj;
@@ -1660,7 +1660,7 @@ static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha
 	return (merge_bases && !merge_bases->next && merge_bases->item == branch);
 }
 
-static int delete_remote_branch(char *pattern, int force)
+static int delete_remote_branch(const char *pattern, int force)
 {
 	struct ref *refs = remote_refs;
 	struct ref *remote_ref = NULL;
-- 
1.7.3.3.585.g74f6e
