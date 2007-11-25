From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-checkout: describe detached head correctly
Date: Sun, 25 Nov 2007 10:34:27 -0800
Message-ID: <7vprxymax8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 19:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwMJi-0003DU-Rq
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbXKYSec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbXKYSec
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:34:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60957 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbXKYSeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 13:34:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4748A2EF;
	Sun, 25 Nov 2007 13:34:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D5186999CA;
	Sun, 25 Nov 2007 13:34:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65981>

When you have a file called HEAD in the work tree, the code to report
where the HEAD is at when "git checkout $commit^0" is done triggered
unnecessary ambiguity checking.  

Explicitly mark the command line with "--" and make it clear that we are
talking about a revision.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 17f4392..93dfb46 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -169,7 +169,7 @@ detach_warn=
 describe_detached_head () {
 	test -n "$quiet" || {
 		printf >&2 "$1 "
-		GIT_PAGER= git log >&2 -1 --pretty=oneline --abbrev-commit "$2"
+		GIT_PAGER= git log >&2 -1 --pretty=oneline --abbrev-commit "$2" --
 	}
 }
 
