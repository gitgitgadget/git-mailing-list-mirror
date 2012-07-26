From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] test: rename $satisfied to $satisfied_prereq
Date: Thu, 26 Jul 2012 16:04:56 -0700
Message-ID: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 01:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuX7B-0000TD-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab2GZXE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:04:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab2GZXE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:04:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3698939;
	Thu, 26 Jul 2012 19:04:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	82IKsv2BcdTObgXbwGlGhgnOk8=; b=yS+QsS38qRk+W/KjuEK/CZm7/maxAyhUq
	z1uIujqGxF+FG+h8PcZtu4PKy8uqMoXHsWYUrjNG/k2j7UdSya7BlJso5FbMd4vm
	FF73bXW+ABJf26pi/vJ7ggREKk/RKIP2MAIJSsvnG4Bto+mz41zGG5+hYNPoNxU5
	EOqccHt4xU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LfD
	a7Db6jZcDOYfC6Yz+sLudkP1TepbVXLGCSYFBcXudg5u/g3LfKLamt1z0BQasTeQ
	eo7qCPXSDTwi4VhjeA1c9H2JoftyUjd93KfMUDm0XFjsYmokCxDYRkrzNHndvd8l
	+UXNFGZlHrH3aNP6gmXnn2IAPXHGDVBARa/r8ni8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC358938;
	Thu, 26 Jul 2012 19:04:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36AAA8936; Thu, 26 Jul 2012
 19:04:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 522840A0-D776-11E1-9964-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202313>

All other shell variables that globally keep track of prerequisite
related states have "prereq" somewhere in their names.  Be consistent
and avoid name crashes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Just a preparatory clean-up.

 t/test-lib-functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80daaca..4dc027d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -221,9 +221,9 @@ write_script () {
 # capital letters by convention).
 
 test_set_prereq () {
-	satisfied="$satisfied$1 "
+	satisfied_prereq="$satisfied_prereq$1 "
 }
-satisfied=" "
+satisfied_prereq=" "
 
 test_have_prereq () {
 	# prerequisites can be concatenated with ','
@@ -239,7 +239,7 @@ test_have_prereq () {
 	for prerequisite
 	do
 		total_prereq=$(($total_prereq + 1))
-		case $satisfied in
+		case "$satisfied_prereq" in
 		*" $prerequisite "*)
 			ok_prereq=$(($ok_prereq + 1))
 			;;
-- 
1.7.12.rc0.44.gc69a8ad
