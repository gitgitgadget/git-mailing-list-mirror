From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] bisect: cleanup formatting of git-bisect.sh
Date: Fri, 05 Aug 2011 10:09:23 -0700
Message-ID: <7vsjpf3hvg.fsf@alter.siamese.dyndns.org>
References: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpNtr-0002xM-M6
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab1HERJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 13:09:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab1HERJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 13:09:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C00954D5A;
	Fri,  5 Aug 2011 13:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rlrt9YqiwCkrMKt2QhtUFsCSTSk=; b=IxmWLW
	QSurl16GXzrRCYqf+N+owTd8Dqrn/SWxyli0IGYTqo4hRmAGFS/tLrgddmM84b8t
	ueItrZfYO/+VBrGEPEilZkuWrmhkzap6Il4dI5WYaVEuwxbfq4Od7l9/1DMYtvmJ
	pR7N6/KJDYWBB4itVyCcd+geJmFwz7i/6MuaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFYrTzH3vHGkhVvvaMSaWKrYmNZswacw
	U2/hlnQb1nzf4OiXhg8FnFfZjr4NXXdb8JvlWrKMilFa9kC6jiD+ZnSq95oBdpTY
	o9ifwIO5jP7b61pOLG65du7ojZybObvCUwfGY9q9bNBGsdN7KKMC6AXVaC4O+SuD
	fOSN+MAyYT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B89704D59;
	Fri,  5 Aug 2011 13:09:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA924D58; Fri,  5 Aug 2011
 13:09:25 -0400 (EDT)
In-Reply-To: <1312543891-11079-1-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Fri, 5 Aug 2011 21:31:29 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB9FEAE8-BF85-11E0-AAD7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178804>

Jon Seymour <jon.seymour@gmail.com> writes:

> This series is intended to be applied on top js/bisect-no-checkout.

Thanks; I wonder if we want to go a bit further.

-- >8 --
Subject: bisect: further style nitpicks

Fix a few remaining lines that indented with spaces.

Also simplify the logic of checking out the original branch and reporting
error during "bisect reset".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1f3c46d..22c4da5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -94,9 +94,9 @@ bisect_start() {
 			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 		*)
 			rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-			    test $has_double_dash -eq 1 &&
-			die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-			    break
+				test $has_double_dash -eq 1 &&
+				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
+				break
 			}
 			case $bad_seen in
 			0) state='bad' ; bad_seen=1 ;;
@@ -125,7 +125,7 @@ bisect_start() {
 		start_head=$(cat "$GIT_DIR/BISECT_START")
 		if test "z$mode" != "z--no-checkout"
 		then
-		    git checkout "$start_head" --
+			git checkout "$start_head" --
 		fi
 	else
 		# Get rev from where we start.
@@ -332,7 +332,7 @@ bisect_visualize() {
 	if test $# = 0
 	then
 		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
-		   type gitk >/dev/null 2>&1
+			type gitk >/dev/null 2>&1
 		then
 			set gitk
 		else
@@ -364,13 +364,11 @@ bisect_reset() {
 	*)
 		usage ;;
 	esac
-	if ! test -f "$GIT_DIR/BISECT_HEAD"
+
+	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
 	then
-		if ! git checkout "$branch" --
-		then
-			die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
-		fi
 	fi
 	bisect_clean_state
 }
