From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t/lib-t6000: style fixes
Date: Fri, 21 Jun 2013 11:49:35 -0700
Message-ID: <1371840579-20161-2-git-send-email-gitster@pobox.com>
References: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:50:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PE-0002QS-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423703Ab3FUStp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUSto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B696E2A0AF;
	Fri, 21 Jun 2013 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FmcN
	0HheCrcD11b7t77VzMMitCs=; b=ks/zXbkPpijE3MfT0krxr02Znl3a5drThKX/
	K3xYFVRiPh15MStRD/+n3UuoV/hlVufbMnoywimosH8p90Z0nwE07b0uyBUpfX8f
	24+Ep20kzPAAzNWZXNe7aIlO4Jt//h+JjglRhBxSDMbxoRq25J1LBUINuJzcRLOu
	XWqbC5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	mRIHUT/HGatPDb1Ou367WCwzpkq/qU4Ht24lNyA2cXm/lJ505GdqSpJU/AlSREQU
	nlAO52v98dLpmNslB35rrC+r5jEigCVHDZhYAv4ANekqNp5LAOoi+9+xrfNfUSAW
	qMQSsdqSCmugTeCvmHPsIiXq0erF85IQyFYW7iG1NmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA08D2A0AE;
	Fri, 21 Jun 2013 18:49:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26762A0AB;
	Fri, 21 Jun 2013 18:49:42 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
In-Reply-To: <1371840579-20161-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 55C52594-DAA3-11E2-85FB-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228649>

Mostly fixes to initial indentation with 8-SP (they should be HT)
and wrapping long lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-t6000.sh | 87 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index ea25dd8..102d567 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,55 +1,50 @@
 : included from 6002 and others
 
-[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
+mkdir -p .git/refs/tags
 
-:> sed.script
+>sed.script
 
-# Answer the sha1 has associated with the tag. The tag must exist in .git or .git/refs/tags
-tag()
-{
+# Answer the sha1 has associated with the tag. The tag must exist in .git/refs/tags
+tag () {
 	_tag=$1
-	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
-	cat .git/refs/tags/$_tag
+	test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not exist"
+	cat ".git/refs/tags/$_tag"
 }
 
 # Generate a commit using the text specified to make it unique and the tree
 # named by the tag specified.
-unique_commit()
-{
+unique_commit () {
 	_text=$1
-        _tree=$2
+	_tree=$2
 	shift 2
-	echo $_text | git commit-tree $(tag $_tree) "$@"
+	echo "$_text" | git commit-tree $(tag "$_tree") "$@"
 }
 
 # Save the output of a command into the tag specified. Prepend
 # a substitution script for the tag onto the front of sed.script
-save_tag()
-{
+save_tag () {
 	_tag=$1
-	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
+	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >.git/refs/tags/$_tag
+	"$@" >".git/refs/tags/$_tag"
 
-        echo "s/$(tag $_tag)/$_tag/g" > sed.script.tmp
-	cat sed.script >> sed.script.tmp
+	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
+	cat sed.script >>sed.script.tmp
 	rm sed.script
 	mv sed.script.tmp sed.script
 }
 
 # Replace unhelpful sha1 hashses with their symbolic equivalents
-entag()
-{
+entag () {
 	sed -f sed.script
 }
 
 # Execute a command after first saving, then setting the GIT_AUTHOR_EMAIL
 # tag to a specified value. Restore the original value on return.
-as_author()
-{
+as_author () {
 	_author=$1
 	shift 1
-        _save=$GIT_AUTHOR_EMAIL
+	_save=$GIT_AUTHOR_EMAIL
 
 	GIT_AUTHOR_EMAIL="$_author"
 	export GIT_AUTHOR_EMAIL
@@ -63,45 +58,41 @@ as_author()
 	fi
 }
 
-commit_date()
-{
-        _commit=$1
-	git cat-file commit $_commit | sed -n "s/^committer .*> \([0-9]*\) .*/\1/p"
+commit_date () {
+	_commit=$1
+	git cat-file commit $_commit |
+	sed -n "s/^committer .*> \([0-9]*\) .*/\1/p"
 }
 
-on_committer_date()
-{
-    _date=$1
-    shift 1
-    GIT_COMMITTER_DATE="$_date"
-    export GIT_COMMITTER_DATE
-    "$@"
-    unset GIT_COMMITTER_DATE
+on_committer_date () {
+	_date=$1
+	shift 1
+	GIT_COMMITTER_DATE="$_date"
+	export GIT_COMMITTER_DATE
+	"$@"
+	unset GIT_COMMITTER_DATE
 }
 
 # Execute a command and suppress any error output.
-hide_error()
-{
+hide_error () {
 	"$@" 2>/dev/null
 }
 
-check_output()
-{
+check_output () {
 	_name=$1
 	shift 1
-	if eval "$*" | entag > $_name.actual
+	if eval "$*" | entag >"$_name.actual"
 	then
-		test_cmp $_name.expected $_name.actual
+		test_cmp "$_name.expected" "$_name.actual"
 	else
-		return 1;
+		return 1
 	fi
 }
 
 # Turn a reasonable test description into a reasonable test name.
 # All alphanums translated into -'s which are then compressed and stripped
 # from front and back.
-name_from_description()
-{
+name_from_description () {
 	perl -pe '
 		s/[^A-Za-z0-9.]/-/g;
 		s/-+/-/g;
@@ -119,9 +110,11 @@ name_from_description()
 test_output_expect_success()
 {
 	_description=$1
-        _test=$2
-        [ $# -eq 2 ] || error "usage: test_output_expect_success description test <<EOF ... EOF"
-        _name=$(echo $_description | name_from_description)
-	cat > $_name.expected
+	_test=$2
+	test $# -eq 2 ||
+	error "usage: test_output_expect_success description test <<EOF ... EOF"
+
+	_name=$(echo $_description | name_from_description)
+	cat >"$_name.expected"
 	test_expect_success "$_description" "check_output $_name \"$_test\""
 }
-- 
1.8.3.1-682-g924db96
