From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Mon, 23 Nov 2009 16:35:10 -0800
Message-ID: <7vtywksqtd.fsf@alter.siamese.dyndns.org>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
 <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx>
 <20091123112221.GA7175@sajinet.com.pe>
 <7vtywlyu43.fsf@alter.siamese.dyndns.org> <4B0B185B.4090305@lsrfire.ath.cx>
 <7v4ooku7cv.fsf@alter.siamese.dyndns.org> <4B0B21CF.5040504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjNX-0003tR-GS
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 01:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbZKXAfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 19:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZKXAfU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 19:35:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZKXAfS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 19:35:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B07FEA00D5;
	Mon, 23 Nov 2009 19:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=22FyJm8MAkx7
	AaLWZjBzB2bCqFU=; b=bkKBPJs7iMmqiRz+4IplzrOb+cC5btMdk6JgqlT83fG9
	Am7Pg26cDZ4vDS4fdokcT9dTs9kescUSjBjLyPRIyFVb9VRCCcMDzfY5HW6SxGxO
	GH3IeQ/q9qw0JMQ8vthnJ/8eNldO9q9mI1Xc59RHsutMMpgSh4Q4rESfeXie2so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e90pO/
	Uo2HNPaGL6eOd4UfYHNaj3mFnWE75T5CfIw7cw51ewRTkWJf6Yet/kL5phyxmzAm
	iiRLMHRHsgwVZb5/AA4jIDA6wMMPYy97OzRywzD526FQAudamzO+Iz3SqTCs51Rf
	N88rZNOh1ILsvj6KR5F35kj0DNavXjfJ+hgQQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C096A00D4;
	Mon, 23 Nov 2009 19:35:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BF61A00D3; Mon, 23 Nov 2009
 19:35:11 -0500 (EST)
In-Reply-To: <4B0B21CF.5040504@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 24 Nov 2009 00\:59\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E3DA170-D891-11DE-8683-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133546>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index c41c2f7..2b2afa6 100755
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -114,6 +114,20 @@ git_editor() {
>>  	eval "${GIT_EDITOR:=3Dvi}" '"$@"'
>>  }
>> =20
>> +sane_grep () {
>> +	GREP_OPTIONS=3D \
>> +	GREP_COLOR=3D \
>> +	GREP_COLORS=3D \
>> +	LC_ALL=3DC grep "$@"
>> +}
>> +
>> +sane_egrep () {
>> +	GREP_OPTIONS=3D \
>> +	GREP_COLOR=3D \
>> +	GREP_COLORS=3D \
>> +	LC_ALL=3DC egrep "$@"
>> +}
>> +
>
> Ah, yes, much nicer.

Actually I am having a second thought after spending some time trying t=
o
come up with a commit log message.  This leaves the door open for user
scripts to honor the environment variables, but it also means that
everybody needs to be aware of the insanity.  It is really tempting to
treat these exactly like CDPATH and unconditionally unset it.

Oh, and unsetting GREP_COLORS/GREP_COLOR was a mistake, I think.  As lo=
ng
as we do not pass --color (and unset GREP_OPTIONS to make sure it is no=
t
given), their settings should not matter to us.

-- >8 --
Subject: [PATCH] Protect scripted Porcelains from GREP_OPTIONS insanity

If the user has exported the GREP_OPTIONS environment variable, the out=
put
from "grep" and "egrep" in scripted Porcelains may be different from wh=
at
they expect.  For example, we may want to count number of matching line=
s,
by "grep" piped to "wc -l", and GREP_OPTIONS=3D-C3 will break such use.

The approach taken by this change to address this issue is to protect o=
nly
our own use of grep/egrep.  Because we do not unset it at the beginning=
 of
our scripts, hook scripts run from the scripted Porcelains are exposed =
to
the same insanity this environment variable causes when grep/egrep is u=
sed
to implement logic (e.g. "grep | wc -l"), and it is entirely up to the
hook scripts to protect themselves.

On the other hand, applypatch-msg hook may want to show offending words=
 in
the proposed commit log message using grep to the end user, and the use=
r
might want to set GREP_OPTIONS=3D--color to paint the match more visibl=
y.
The approach to protect only our own use without unsetting the environm=
ent
variable globally will allow this use case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-setup.sh            |    8 ++++++++
 git-am.sh                  |    4 ++--
 git-bisect.sh              |    4 ++--
 git-filter-branch.sh       |    2 +-
 git-instaweb.sh            |    8 ++++----
 git-rebase--interactive.sh |   10 +++++-----
 git-rebase.sh              |    2 +-
 git-submodule.sh           |    6 +++---
 8 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c41c2f7..aa07cc3 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -114,6 +114,14 @@ git_editor() {
 	eval "${GIT_EDITOR:=3Dvi}" '"$@"'
 }
=20
+sane_grep () {
+	GREP_OPTIONS=3D LC_ALL=3DC grep "$@"
+}
+
+sane_egrep () {
+	GREP_OPTIONS=3D LC_ALL=3DC egrep "$@"
+}
+
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
diff --git a/git-am.sh b/git-am.sh
index c132f50..b49f26a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -205,7 +205,7 @@ check_patch_format () {
 			# and see if it looks like that they all begin with the
 			# header field names...
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
-			LC_ALL=3DC egrep -v '^[!-9;-~]+:' >/dev/null ||
+			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=3Dmbox
 		fi
 	} < "$1" || clean_abort
@@ -554,7 +554,7 @@ do
 			stop_here $this
=20
 		# skip pine's internal folder data
-		grep '^Author: Mail System Internal Data$' \
+		sane_grep '^Author: Mail System Internal Data$' \
 			<"$dotest"/info >/dev/null &&
 			go_next && continue
=20
diff --git a/git-bisect.sh b/git-bisect.sh
index 6f6f039..0c422d5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -393,7 +393,7 @@ bisect_run () {
=20
       cat "$GIT_DIR/BISECT_RUN"
=20
-      if grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN"=
 \
+      if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT=
_RUN" \
 		> /dev/null; then
 	  echo >&2 "bisect run cannot continue any more"
 	  exit $res
@@ -405,7 +405,7 @@ bisect_run () {
 	  exit $res
       fi
=20
-      if grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/n=
ull; then
+      if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /=
dev/null; then
 	  echo "bisect run success"
 	  exit 0;
       fi
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a480d6f..8ef1bde 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -457,7 +457,7 @@ if [ "$filter_tag_name" ]; then
 				git mktag) ||
 				die "Could not create new tag object for $ref"
 			if git cat-file tag "$ref" | \
-			   grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
+			   sane_grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
 			then
 				warn "gpg signature stripped from tag object $sha1t"
 			fi
diff --git a/git-instaweb.sh b/git-instaweb.sh
index d96eddb..84805c6 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -41,7 +41,7 @@ resolve_full_httpd () {
 	case "$httpd" in
 	*apache2*|*lighttpd*)
 		# ensure that the apache2/lighttpd command ends with "-f"
-		if ! echo "$httpd" | grep -- '-f *$' >/dev/null 2>&1
+		if ! echo "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
 		then
 			httpd=3D"$httpd -f"
 		fi
@@ -297,8 +297,8 @@ EOF
=20
 	# check to see if Dennis Stosberg's mod_perl compatibility patch
 	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
-	if test -f "$module_path/mod_perl.so" && grep 'MOD_PERL' \
-				"$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
+	if test -f "$module_path/mod_perl.so" &&
+	   sane_grep 'MOD_PERL' "$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
 	then
 		# favor mod_perl if available
 		cat >> "$conf" <<EOF
@@ -316,7 +316,7 @@ EOF
 		# plain-old CGI
 		resolve_full_httpd
 		list_mods=3D$(echo "$full_httpd" | sed "s/-f$/-l/")
-		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
+		$list_mods | sane_grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
 AddHandler cgi-script .cgi
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..6268e76 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -106,8 +106,8 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
-	count=3D$(grep -c '^[^#]' < "$DONE")
-	total=3D$(($count+$(grep -c '^[^#]' < "$TODO")))
+	count=3D$(sane_grep -c '^[^#]' < "$DONE")
+	total=3D$(($count+$(sane_grep -c '^[^#]' < "$TODO")))
 	if test "$last_count" !=3D "$count"
 	then
 		last_count=3D$count
@@ -147,7 +147,7 @@ die_abort () {
 }
=20
 has_action () {
-	grep '^[^#]' "$1" >/dev/null
+	sane_grep '^[^#]' "$1" >/dev/null
 }
=20
 pick_one () {
@@ -731,7 +731,7 @@ first and then run 'git rebase --continue' again."
 			git rev-list $REVISIONS |
 			while read rev
 			do
-				if test -f "$REWRITTEN"/$rev -a "$(grep "$rev" "$DOTEST"/not-cherr=
y-picks)" =3D ""
+				if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$DOTEST"/not-=
cherry-picks)" =3D ""
 				then
 					# Use -f2 because if rev-list is telling us this commit is
 					# not worthwhile, we don't want to track its multiple heads,
@@ -739,7 +739,7 @@ first and then run 'git rebase --continue' again."
 					# be rebasing on top of it
 					git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$DROPPED"/$r=
ev
 					short=3D$(git rev-list -1 --abbrev-commit --abbrev=3D7 $rev)
-					grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}=
2" "$TODO"
+					sane_grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${=
TODO}2" "$TODO"
 					rm "$REWRITTEN"/$rev
 				fi
 			done
diff --git a/git-rebase.sh b/git-rebase.sh
index 6ec155c..0ec4355 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -467,7 +467,7 @@ orig_head=3D$branch
 mb=3D$(git merge-base "$onto" "$branch")
 if test "$upstream" =3D "$onto" && test "$mb" =3D "$onto" &&
 	# linear history?
-	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/nu=
ll
+	! (git rev-list --parents "$onto".."$branch" | sane_grep " .* ") > /d=
ev/null
 then
 	if test -z "$force_rebase"
 	then
diff --git a/git-submodule.sh b/git-submodule.sh
index 0462e52..b7ccd12 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -57,7 +57,7 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" | grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
 }
=20
 #
@@ -567,7 +567,7 @@ cmd_summary() {
 	cd_to_toplevel
 	# Get modified modules cared by user
 	modules=3D$(git $diff_cmd $cached --raw $head -- "$@" |
-		egrep '^:([0-7]* )?160000' |
+		sane_egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status name
 		do
 			# Always show modules deleted or type-changed (blob<->module)
@@ -581,7 +581,7 @@ cmd_summary() {
 	test -z "$modules" && return
=20
 	git $diff_cmd $cached --raw $head -- $modules |
-	egrep '^:([0-7]* )?160000' |
+	sane_egrep '^:([0-7]* )?160000' |
 	cut -c2- |
 	while read mod_src mod_dst sha1_src sha1_dst status name
 	do
--=20
1.6.6.rc0.15.g4fa80.dirty
