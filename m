From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] fetch doc: update note on '+' in front of the refspec
Date: Tue,  3 Jun 2014 15:16:26 -0700
Message-ID: <1401833792-2486-4-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx0u-0005E6-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbaFCWQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58513 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbaFCWQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 460FE1DD68;
	Tue,  3 Jun 2014 18:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vR8p
	EBoPcEvMd8GFcWhOaQfhOgU=; b=wIrAQVZDSEvlBBpkWRr3Mn/5waPVY+ql4g26
	deq5Ohl5/1+Dx/vHkEYh1KgTg2M9ETgVudkygGDVgKFn/Oby67HNTgV/v9VZdQRV
	s/l/KMumWtcLqci0z4/ZCcxAOQrlKBxQL8bWNpVOlElzkMfgD7SzFuh8MpN9gRZ0
	8naIiAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=f/0kYm
	F23ITm30jdi9LdFK9PLKK1+Zwsuhm3VbVmblebKivbcrXDHmL5YIw77N7ywdP0Od
	LGMvXFMrey+wIcj7qnsEgucz1ElJCtFq4bWYZnclmHqITMQ18uQL95t1kYof7lWM
	navJee5R9GwmK7DmVobArEE7Jl3xE8x4+PTc8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E0781DD67;
	Tue,  3 Jun 2014 18:16:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 966201DD63;
	Tue,  3 Jun 2014 18:16:48 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C17A2DFE-EB6C-11E3-AB9C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250698>

While it is not *wrong* per-se to say that pulling a rewound/rebased
branch will lead to an unnecessary merge conflict, that is not what
the leading "+" sign to allow non-fast-forward update of remote-tracking
branch is at all.

Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 18cffc2..41474c5 100644
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
+its new tip will not be descendant of its previous tip
+(as stored in your remote-tracking branch the last time
+you fetched).  You would want
+to use the `+` sign to indicate non-fast-forward updates
+will be needed for such branches.  There is no way to
+determine or declare that a branch will be made available
+in a repository with this behavior; the pulling user simply
 must know this is the expected usage pattern for a branch.
 +
 [NOTE]
-- 
2.0.0-511-g1433423
