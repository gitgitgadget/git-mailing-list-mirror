From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/5] Handling of rfc1991 signatures
Date: Sat,  6 Nov 2010 12:04:05 +0100
Message-ID: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEger-00043n-Ln
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab0KFLJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:09:58 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42469 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755319Ab0KFLJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:09:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AF70C62D;
	Sat,  6 Nov 2010 07:03:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 06 Nov 2010 07:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=SljcOOIRbdV1swZ7tGvTJP/9ZVE=; b=nL8b0vpl1L7+t0cEs2zxa+0uJmaZEfruBab9Sjdk1Hzi2YpVZC7jhgxACbega5lnm8r9JIaCVIsvApLipr4edLjqoQ6z9ZhEE4gsENp8jCHcDWK/ZpQ5ZDlXrLE25pszqdv2eF9ofj2sGvpTC3qApxoQjAJCOemSs3u9tNgLKXk=
X-Sasl-enc: +okMTp7lCvXPGuJ56FU2AQzO6Zlpbu+0W6qs0w2TETT7 1289041424
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0EB9340244A;
	Sat,  6 Nov 2010 07:03:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160836>

This mini-series fixes the handling of signed tags for users
with "rfc1991" in their gpg config. In fact, the refactoring
done in the middle three patches would be worthwhile even
without the side effect of having to fix the handling in
one place only rather than three...

Michael J Gruber (5):
  t/t7004-tag: test handling of rfc1991 signatures
  verify-tag: factor out signature detection
  tag: factor out sig detection for body edits
  tag: factor out sig detection for tag display
  tag: recognize rfc1991 signatures

 builtin/tag.c        |   16 ++++------------
 builtin/verify-tag.c |   10 ++--------
 t/t7004-tag.sh       |   43 +++++++++++++++++++++++++++++++++++++++++++
 tag.c                |   12 ++++++++++++
 tag.h                |    4 ++++
 5 files changed, 65 insertions(+), 20 deletions(-)

-- 
1.7.3.2.193.g78bbb
