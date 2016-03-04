From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] test-lib: quote TRASH_DIRECTORY
Date: Fri,  4 Mar 2016 11:53:49 +0100
Message-ID: <a07529d116612bcd1c411a697f8f8e37d7c18d3f.1457088499.git.git@drmicha.warpmail.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 11:54:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abnMu-0006pZ-9w
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 11:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcCDKx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 05:53:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58399 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbcCDKxy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 05:53:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 17AD425485
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 05:53:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Mar 2016 05:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=+B8hkCdkK/UZ+Ya3mhDar9SvtKQ
	=; b=YUCJ5c4O47lWJdBLDK9v0aXVfoZc552hI0O/Hy9NIeJ30A1viaYU9N8pDgB
	mBlg0s6t67MdYmMqWYG2tzy0KBCk1oKpiFHK8yF/bqPXzUPmdxeyqSUJbBPUaYG5
	AiTdEAAnVLbkGeXXGbtYNUUN3DbNov+FLS9luJxuQUE3RIbs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+B8h
	kCdkK/UZ+Ya3mhDar9SvtKQ=; b=gplnlVrdZukOJYvEbt/tORpDDP4sYWqDvLJF
	Obi5C5djYZIGBNW+R1zrR51lTcQDmbZK5dqwCUOi0tFuulAwQe97pq8tJJ8HYiDs
	xLpyN8UjsgQgOzrgwKJnhDvAhZZzI10bUjS2IvNnGN768mobxTsdQwg0xnC1kmwb
	mtYS3+c=
X-Sasl-enc: OKz3fftiKjddOXFwU1wznLoO/YhVq/3ECt8jHeXV/OM7 1457088832
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 78CA8C00018;
	Fri,  4 Mar 2016 05:53:52 -0500 (EST)
X-Mailer: git-send-email 2.8.0.rc0.181.g163d81c
In-Reply-To: <cover.1457088499.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288242>

We always quote $TRASH_DIRECTORY to guard against funky path names. Do
so in one more spot

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6..8957916 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -868,7 +868,7 @@ case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
-test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
+test ! -z "$debug" || remove_trash="$TRASH_DIRECTORY"
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
2.8.0.rc0.181.g163d81c
