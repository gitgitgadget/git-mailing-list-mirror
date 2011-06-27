From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "branch -d" can remove more than one branches
Date: Mon, 27 Jun 2011 15:04:32 -0700
Message-ID: <7voc1jue1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 00:07:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJxL-0003Yx-FY
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 00:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab1F0WFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 18:05:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab1F0WEf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 18:04:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA1936152;
	Mon, 27 Jun 2011 18:06:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	vr5T2PFYhp5SPvoDXsWcx7LDCE=; b=ZWJXFeWC+qIrzUMs8PGU0jNP1D1fsYSTj
	Jtnim7BRJ1ObBgkqjR2/OaISudvJzALd3GBwo3tmkJ6NN7DCUavcMJJtXBoiDDmw
	w9mOX/DRuKDjKV03NgRhsWE8gDEashlwaQwZEzb+ACa0Z9yJUGqGokjjhAHe7mSU
	9wO6EadR64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=iLi
	slm/AvSoxoHsdou9ut5DLUlk6NQTIMY32twR80XYhuArqjzWEd9B2Qc268/C4DJq
	daPjz/AKerXNMuGYtfdpEdfN1dsIYG7YvKH/7wgdej0bLdgiFleja798Q/8MUSoT
	QmDPSFmL2fYMxgcbWH0e2gAbFs1M98GlRmHYunAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B18926151;
	Mon, 27 Jun 2011 18:06:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C5966150; Mon, 27 Jun 2011
 18:06:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0206AAA-A109-11E0-84BB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176375>

Since 03feddd (git-check-ref-format: reject funny ref names, 2005-10-13),
"git branch -d" can take more than one branch names to remove.

The documentation was correct, but the usage string was not.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d6ab93b..3142daa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -19,7 +19,7 @@
 static const char * const builtin_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
 	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
-	"git branch [options] [-r] (-d | -D) <branchname>",
+	"git branch [options] [-r] (-d | -D) <branchname>...",
 	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
 	NULL
 };
-- 
1.7.6
