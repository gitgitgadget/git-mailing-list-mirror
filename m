From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] merge-tree: lose unused "flags" from merge_list
Date: Wed, 26 Dec 2012 15:03:37 -0800
Message-ID: <1356563020-13919-3-git-send-email-gitster@pobox.com>
References: <1356563020-13919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To01E-0007FV-MO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab2LZXDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 18:03:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab2LZXDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 18:03:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0137FA322
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L3M5
	XPDaX26XidMqNtaAVjoLO5A=; b=wz296lWtkaqh2nxkYjxbhU0Xu+iMs2CxEohx
	Ia0ZWjis1xJofM1ERAxH1FFAVSDWlipIZiFnx1bvcGX0Pw9ds85UpICb2ibftWUh
	GSgtA/dbwz5YkCDF/sJJm5kSZuVFoBw2gLyR49xaxNFfxksqbSej+CUzGELfyPat
	YbikHBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YZ0ysD
	y9vN3XFWTj63/bbNTMooYLHdCvmEOldtbel86QFxCaOLAwI98YW486vFjdi4++QZ
	zxv0gTs9zHv9SdD5pbim3bSX1E26jwIchkdYCbxSMMG+u5jjDPMYH764xRdQPNbH
	0rgfXdml0m17aKMmF37fGzuviydrVtg3afldU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E13B7A320
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C314A31F for
 <git@vger.kernel.org>; Wed, 26 Dec 2012 18:03:46 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc3.356.g686f81c
In-Reply-To: <1356563020-13919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 80930AF8-4FB0-11E2-9D8E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212165>

Drop the unused field from the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ebd0d25..b61d811 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -12,8 +12,7 @@ struct merge_list {
 	struct merge_list *next;
 	struct merge_list *link;	/* other stages for this object */
 
-	unsigned int stage : 2,
-		     flags : 30;
+	unsigned int stage : 2;
 	unsigned int mode;
 	const char *path;
 	struct blob *blob;
-- 
1.8.1.rc3.356.g686f81c
