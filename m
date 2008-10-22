From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN if
 squashing
Date: Wed, 22 Oct 2008 12:10:33 -0700
Message-ID: <7v4p34v42e.fsf@gitster.siamese.dyndns.org>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com> <20081022125149.GA17092@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:12:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksj82-0007DC-KF
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYJVTK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbYJVTK4
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:10:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbYJVTK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:10:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 716298E2E3;
	Wed, 22 Oct 2008 15:10:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4AC008E2D4; Wed, 22 Oct 2008 15:10:35 -0400 (EDT)
In-Reply-To: <20081022125149.GA17092@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 22 Oct 2008 08:51:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23DCE154-A06D-11DD-877B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98890>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 15, 2008 at 02:44:36AM -0500, Stephen Haberman wrote:
>
>> +		if [ "$fast_forward" == "t" ]
>
> This one even fails on my Linux box. :) "==" is a bash-ism.

Thanks.

-- >8 --
Subject: [PATCH] git-rebase--interactive.sh: comparision with == is bashism

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a563dea..0cae3be 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -170,7 +170,7 @@ pick_one_preserving_merges () {
 
 	if test -f "$DOTEST"/current-commit
 	then
-		if [ "$fast_forward" == "t" ]
+		if test "$fast_forward" = t
 		then
 			cat "$DOTEST"/current-commit | while read current_commit
 			do
-- 
1.6.0.3.723.g757e
