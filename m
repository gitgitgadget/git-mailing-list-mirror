From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] fetch doc: update note on '+' in front of the refspec
Date: Thu, 29 May 2014 15:42:27 -0700
Message-ID: <1401403350-7122-3-git-send-email-gitster@pobox.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq92B-0003YY-17
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbaE2Wmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:42:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53450 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaE2Wmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:42:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE4E01C320;
	Thu, 29 May 2014 18:42:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RxYw
	mjv91pUjYaRG66gc4j9l5RM=; b=CiQmDn8Ge6S2SyvPh3jYyS6nZeqar2XxNMzd
	2M8jsIPBeDqUKwfPBdtbT/IkSl7+I3IYjYwbuwpBU5+CR+d91P8dWPS2g3oh9izS
	qnHzfy43yfv1ZmApNXyFkOCr2Zb4pLfRsin/0l+wuXOSJRKSB1cvrF7LAANiMZvx
	llPxunc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oHBcmG
	L955FmXZ4jSgklZb1zKSjLQPyHpPEXnvqI+N4vB2gMStUQ61Q7ZduCxaTT6y450M
	OZn8B5ejGy2zzz7XggAdyaU9YEPVMPsROsS2V4MuaAunK2fz3dUHlojnDcRPgc0R
	GnTMjeTaK5x0DMRYhD2DRE/LAH89gIw4yaMJM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A26F91C31F;
	Thu, 29 May 2014 18:42:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3FAD41C31D;
	Thu, 29 May 2014 18:42:42 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
In-Reply-To: <1401403350-7122-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B74D63E-E782-11E3-BB8C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250413>

While it is not *wrong* per-se to say that pulling a rewound/rebased
branch will lead to an unnecessary merge conflict, that is not what
the leading "+" sign to allow non-fast-forward update of remote-tracking
branch is at all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 18cffc2..2a7e2b7 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -24,15 +24,15 @@ is updated even if it does not result in a fast-forward
 update.
 +
 [NOTE]
-If the remote branch from which you want to pull is
-modified in non-linear ways such as being rewound and
-rebased frequently, then a pull will attempt a merge with
-an older version of itself, likely conflict, and fail.
-It is under these conditions that you would want to use
-the `+` sign to indicate non-fast-forward updates will
-be needed.  There is currently no easy way to determine
-or declare that a branch will be made available in a
-repository with this behavior; the pulling user simply
+When the remote branch you want to fetch is known to
+be rewound and rebased regularly, it is expected that
+the tip of it will not be descendant of the commit that
+used to be at its tip the last time you fetched it and
+stored in your remote-tracking branch.  You would want
+to use the `+` sign to indicate non-fast-forward updates
+will be needed for such branches.  There is no way to
+determine or declare that a branch will be made available
+in a repository with this behavior; the pulling user simply
 must know this is the expected usage pattern for a branch.
 +
 [NOTE]
-- 
2.0.0-479-g59ac8f9
