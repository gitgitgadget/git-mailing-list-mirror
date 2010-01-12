From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/18] pretty.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:46 -0800
Message-ID: <1263282781-25596-4-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZR-0004h8-1O
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab0ALHxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277Ab0ALHxU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0ALHxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD8378E880
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WRaH
	ogD3L1rqw8sz3Hf70RSqDy0=; b=hNZXmp6Jimx/gZwcMVBbbksBZSNArA5F/3W2
	cGwxhb/ZQC4wuuTE1iWNNQ1zSMW/qQlJGPB/fkvYcuhREYlji91oItazX+Y69MqB
	4zxNkN+/3uIoNjeah/5038X2Yw+h2t4PH9PMKmsckhvOiDRjC5uoU6qB6F/XTdHU
	W7O6DA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LCmI/W
	x+aQpot/nP9KrEbAa57MLTIqUECiKVbODJ0Cm6ci3rEP3pRN3FaOzhg4D6JYc0xJ
	biZwjmocG+lLnrBGBXO0evWJdGbbyDg7T13w06ukkgYsaVbTWXFQwqtz6s7LiLSL
	V0yDDUzCZo80b95FNqh33s+Vn/YdqKmcXpjjo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9BFC8E87F
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F1928E87B for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:15 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A677F3C-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136690>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h |    1 -
 pretty.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/commit.h b/commit.h
index e5332ef..24128d7 100644
--- a/commit.h
+++ b/commit.h
@@ -73,7 +73,6 @@ struct pretty_print_context
 	struct reflog_walk_info *reflog_info;
 };
 
-extern int non_ascii(int);
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
diff --git a/pretty.c b/pretty.c
index 8f5bd1a..9001379 100644
--- a/pretty.c
+++ b/pretty.c
@@ -83,7 +83,7 @@ static int get_one_line(const char *msg)
 }
 
 /* High bit set, or ISO-2022-INT */
-int non_ascii(int ch)
+static int non_ascii(int ch)
 {
 	return !isascii(ch) || ch == '\033';
 }
-- 
1.6.6.280.ge295b7.dirty
