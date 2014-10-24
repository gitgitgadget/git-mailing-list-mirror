From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t/lib-gpg: make gpghome files writable
Date: Fri, 24 Oct 2014 17:23:32 +0200
Message-ID: <e4a04b52ade76af3d2d53e865b20815a582f8171.1414164092.git.git@drmicha.warpmail.net>
References: <544A6D4E.7070408@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 17:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhgiR-0004ax-1O
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 17:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbaJXPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 11:23:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35332 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756697AbaJXPXe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 11:23:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 771B22043D
	for <git@vger.kernel.org>; Fri, 24 Oct 2014 11:23:33 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 24 Oct 2014 11:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=za5jnkHF7QK3WQ
	jGB7gf2lz+9zA=; b=T+9J6epiQRJd8AXPyb253H+F0JEnLaF9KKZ45HCGDUcaDd
	TIc/3bnoCHTWV63TmZxUAvvdc+fzL93fvgYoRZEjiWkmgLzYGVJrg03ebJeCyXqa
	PQ6xFRpRVGWsduUZctZvE8aI7JV46gErKeGEN/S84xTD23gWQaf3CbCnWGqk8=
X-Sasl-enc: tJHjHtIdACHENuaWIOES41zmZ6qkPj2MuDh5j+/I+piv 1414164213
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1AE32680154;
	Fri, 24 Oct 2014 11:23:33 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
In-Reply-To: <544A6D4E.7070408@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t/lib-gpg.sh copies the test environment's gpg home to the trash
directory and makes sure the directoty is writable.

Make sure the copied files are writable, too.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index fd499e7..cd2baef 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -18,6 +18,7 @@ else
 		# No password given, to enable non-interactive operation.
 		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
 		chmod 0700 gpghome
+		chmod 0600 gpghome/*
 		GNUPGHOME="$(pwd)/gpghome"
 		export GNUPGHOME
 		test_set_prereq GPG
-- 
2.1.2.756.gfa53a0a
