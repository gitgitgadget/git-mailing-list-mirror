From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] git.txt: de-emphasize the implementation detail of a ref
Date: Thu, 23 Jun 2011 09:52:35 -0700
Message-ID: <1308847958-3429-3-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn9A-0007A5-8s
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759779Ab1FWQwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759Ab1FWQwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0115B5B8F
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Jkes
	e2w/aJtge4uaEbQEmkkMf2w=; b=g6BtxM6NBJ1gqID7STlbQER7ZtW579supwGO
	P6pHPxLjc5SzPoftZ4afyh0hxF6gZlZjarTmqGefhDhciYu3tHZzP+6BCv7lpNh3
	7A3roeQoCAZwcSSdeZWUhzd+Etxr3YQUxcI1mgvl4viqCpDo4ci5xyUPl9eaP0r1
	WPFZsJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=g5GaUw
	7Q75jh209Ncj8MI7/l9ZwLC6Fqi9GVIgrtxOwwvOK6H2JhskHlhbpic7RmLtVnZv
	q9RIRs12hR2nAa49uaxUJhJjAO6FwEhbigu72l3uaYki/fbfm0KDyFAEo7X8nWl1
	EyR04Q7Ck76V5gjIs8HlmTdOoaZAQE5nN/Pm4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE2235B8D
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3574F5B8C for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <1308847958-3429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 85E8EBA8-9DB9-11E0-8D60-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176277>

It is an unimportant implementation detail that branches and tags are
stored somewhere under $GIT_DIR/refs directory, or the name of the commit
that will become the parent of the next commit is stored in $GIT_DIR/HEAD.

What is more important is that branches live in refs/heads and tags live
in refs/tags hierarchy in the ref namespace, and HEAD means the tip of the
current branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8c0bfdf..7fc6b88 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -510,16 +510,15 @@ Any git command accepting any <object> can also use the following
 symbolic notation:
 
 HEAD::
-	indicates the head of the current branch (i.e. the
-	contents of `$GIT_DIR/HEAD`).
+	indicates the head of the current branch.
 
 <tag>::
 	a valid tag 'name'
-	(i.e. the contents of `$GIT_DIR/refs/tags/<tag>`).
+	(i.e. a `refs/tags/<tag>` reference).
 
 <head>::
 	a valid head 'name'
-	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
+	(i.e. a `refs/heads/<head>` reference).
 
 For a more complete list of ways to spell object names, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
-- 
1.7.6.rc3
