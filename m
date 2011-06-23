From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] check-ref-format doc: de-emphasize the implementation
 detail of a ref
Date: Thu, 23 Jun 2011 09:52:34 -0700
Message-ID: <1308847958-3429-2-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn99-0007A5-Ol
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759774Ab1FWQwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759Ab1FWQwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C63BE5B81
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lxBA
	pquL1n8oCRB8Bg3eLtaYGlc=; b=tgS0xMPz58YCWwhKNa0ScsGIo7Wo3lRlQSYz
	nCkJQZXnfwnH0ixLqP96c6NCaCWYSugGucK14V7tCG+YAxTZrUfxX9nzoV9EVVx6
	+ewwoid7JHlucia9dp8vfKeqeMNBZCdrXlHdu4mHh3sRtGZBd+EATOMpkDWsCiyw
	s3SRCOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Veg+Az
	rGe68ofNaLa8SRprJWUMVZVFureR3YxX8E0rkVCTAmjHAYyob0vu6WAtnZFPmuo5
	WNJ/CYspyXSgS2WW+0KC7KBsJF2P05GIxb+8TQGA0tqi3mbMXpDB1msHe85LyhQD
	SNa0wVBD+CTYbWEvH6qvR0e69myK7dBKWhF8Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC0C35B7F
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CB0D5B7E for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <1308847958-3429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 849E664C-9DB9-11E0-B595-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176274>

It is an unimportant implementation detail that branches and tags are
stored somewhere under $GIT_DIR/refs directory. What is more important
is that branches live in refs/heads and tags live in refs/tags hierarchy
in the ref namespace.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 205d83d..61471cf 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -18,9 +18,12 @@ Checks if a given 'refname' is acceptable, and exits with a non-zero
 status if it is not.
 
 A reference is used in git to specify branches and tags.  A
-branch head is stored under the `$GIT_DIR/refs/heads` directory, and
-a tag is stored under the `$GIT_DIR/refs/tags` directory (or, if refs
-are packed by `git gc`, as entries in the `$GIT_DIR/packed-refs` file).
+branch head is stored in the `refs/heads` hierarchy while
+a tag is stored in the `refs/tags` hierarchy of the ref namespace
+(which are found in `$GIT_DIR/refs/heads` and `$GIT_DIR/refs/tags`
+directories or, if refs are packed by `git gc`, as entries in
+the `$GIT_DIR/packed-refs` file).
+
 git imposes the following rules on how references are named:
 
 . They can include slash `/` for hierarchical (directory)
-- 
1.7.6.rc3
