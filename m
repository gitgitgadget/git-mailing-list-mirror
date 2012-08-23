From: Junio C Hamano <junio@pobox.com>
Subject: Re*: mergetool: support --tool-help option like difftool does
Date: Wed, 22 Aug 2012 22:33:15 -0700
Message-ID: <7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
 <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 07:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Q2r-0004tf-4z
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 07:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2HWFdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 01:33:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab2HWFdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 01:33:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B0635FE6;
	Thu, 23 Aug 2012 01:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQwwyfoGD1add/VSOhfoe83nAak=; b=CGIpH2
	tXRudjyHQtSL+nPkqyMkSotCbEpmtYwjfFtrGo5kh/pNZMauLJi8voGGOP5BKQGE
	oNlfAC9Yqt7OfRoWyzpiNNVq/I8ILvZDk1fW/yp7xS5w8BxNeGztjK2CsuXCQwET
	p8qD9xP2iyuxtdbeT5a44hK9hgDbvLgO/pWHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1W/w1s2CFBoWnXQ6CiPglQvUsJzlaz7
	jstYWgCEqSkYgja3hLaZNaXou2PFAIi8/W2K6y0nHADVuKtv2rL1Is+MwXRXpF5w
	dyAbtuMc2eb1YoLt0vG2vgwCrGKAQGfuCYTptPFfUqDSx0Wn/m8vaBy4CHi77umm
	nHGNAy9XZF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2853F5FE5;
	Thu, 23 Aug 2012 01:33:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C96AE5FE4; Thu, 23 Aug 2012
 01:33:16 -0400 (EDT)
In-Reply-To: <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jul 2012 10:21:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A5C0184-ECE4-11E1-9F59-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204112>

Junio C Hamano <gitster@pobox.com> writes:

> This way we do not have to risk the list of tools go out of sync
> between the implementation and the documentation.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +--tool-help::
>>> +	List the supported and available diff tools.
>>
>> This part is a good addition (but it already is mentioned in the
>> description of --tool above, so it is more or less a "Meh").
>
> I noticed that the main while loop has style violations in its
> case/esac, but I left it as-is.  Reindenting it would be a low
> hanging fruit janitor patch that would be a separate topic.

After hinting a low-hanging-fruit that would be an easy way for new
people to dip their toes, I saw no takers for one month, so I ended
up doing it myself.

-- >8 --
Subject: mergetool: style fixes

This script is one of the sizeable ones that tempted people to copy
its "neibouring style" in their new code, but was littered with
styles incompatible with our style guide.

 - use one tab, not four spaces, per indent level;

 - long lines can be wrapped after '|', '&&', or '||' for
   readability.

 - structures like "if .. then .. else .. fi", "while .. do .. done"
   are split into lines in such a way that does not require
   unnecessary semicolon.

 - case, esac and case-arms align at the same column.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The change would be easier to see if the reader runs these
   command before and after applying this patch:

    $ git diff -w git-mergetool.sh
    $ git grep -e '^[\t]* ' -e '; *then' -e '; do' git-mergetool.sh

 git-mergetool.sh | 581 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 308 insertions(+), 273 deletions(-)

diff --git i/git-mergetool.sh w/git-mergetool.sh
index 0db0c44..c50e18a 100755
--- i/git-mergetool.sh
+++ w/git-mergetool.sh
@@ -18,270 +18,301 @@ require_work_tree
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
-    test "$1" = 120000
+	test "$1" = 120000
 }
 
 is_submodule () {
-    test "$1" = 160000
+	test "$1" = 160000
 }
 
 local_present () {
-    test -n "$local_mode"
+	test -n "$local_mode"
 }
 
 remote_present () {
-    test -n "$remote_mode"
+	test -n "$remote_mode"
 }
 
 base_present () {
-    test -n "$base_mode"
+	test -n "$base_mode"
 }
 
 cleanup_temp_files () {
-    if test "$1" = --save-backup ; then
-	rm -rf -- "$MERGED.orig"
-	test -e "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
-	rm -f -- "$LOCAL" "$REMOTE" "$BASE"
-    else
-	rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
-    fi
+	if test "$1" = --save-backup
+	then
+		rm -rf -- "$MERGED.orig"
+		test -e "$BACKUP" && mv -- "$BACKUP" "$MERGED.orig"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+	else
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
+	fi
 }
 
 describe_file () {
-    mode="$1"
-    branch="$2"
-    file="$3"
-
-    printf "  {%s}: " "$branch"
-    if test -z "$mode"; then
-	echo "deleted"
-    elif is_symlink "$mode" ; then
-	echo "a symbolic link -> '$(cat "$file")'"
-    elif is_submodule "$mode" ; then
-	echo "submodule commit $file"
-    else
-	if base_present; then
-	    echo "modified file"
+	mode="$1"
+	branch="$2"
+	file="$3"
+
+	printf "  {%s}: " "$branch"
+	if test -z "$mode"
+	then
+		echo "deleted"
+	elif is_symlink "$mode"
+	then
+		echo "a symbolic link -> '$(cat "$file")'"
+	elif is_submodule "$mode"
+	then
+		echo "submodule commit $file"
+	elif base_present
+	then
+		echo "modified file"
 	else
-	    echo "created file"
+		echo "created file"
 	fi
-    fi
 }
 
-
 resolve_symlink_merge () {
-    while true; do
-	printf "Use (l)ocal or (r)emote, or (a)bort? "
-	read ans || return 1
-	case "$ans" in
-	    [lL]*)
-		git checkout-index -f --stage=2 -- "$MERGED"
-		git add -- "$MERGED"
-		cleanup_temp_files --save-backup
-		return 0
-		;;
-	    [rR]*)
-		git checkout-index -f --stage=3 -- "$MERGED"
-		git add -- "$MERGED"
-		cleanup_temp_files --save-backup
-		return 0
-		;;
-	    [aA]*)
-		return 1
-		;;
-	    esac
+	while true
+	do
+		printf "Use (l)ocal or (r)emote, or (a)bort? "
+		read ans || return 1
+		case "$ans" in
+		[lL]*)
+			git checkout-index -f --stage=2 -- "$MERGED"
+			git add -- "$MERGED"
+			cleanup_temp_files --save-backup
+			return 0
+			;;
+		[rR]*)
+			git checkout-index -f --stage=3 -- "$MERGED"
+			git add -- "$MERGED"
+			cleanup_temp_files --save-backup
+			return 0
+			;;
+		[aA]*)
+			return 1
+			;;
+		esac
 	done
 }
 
 resolve_deleted_merge () {
-    while true; do
-	if base_present; then
-	    printf "Use (m)odified or (d)eleted file, or (a)bort? "
-	else
-	    printf "Use (c)reated or (d)eleted file, or (a)bort? "
-	fi
-	read ans || return 1
-	case "$ans" in
-	    [mMcC]*)
-		git add -- "$MERGED"
-		cleanup_temp_files --save-backup
-		return 0
-		;;
-	    [dD]*)
-		git rm -- "$MERGED" > /dev/null
-		cleanup_temp_files
-		return 0
-		;;
-	    [aA]*)
-		return 1
-		;;
-	    esac
+	while true
+	do
+		if base_present
+		then
+			printf "Use (m)odified or (d)eleted file, or (a)bort? "
+		else
+			printf "Use (c)reated or (d)eleted file, or (a)bort? "
+		fi
+		read ans || return 1
+		case "$ans" in
+		[mMcC]*)
+			git add -- "$MERGED"
+			cleanup_temp_files --save-backup
+			return 0
+			;;
+		[dD]*)
+			git rm -- "$MERGED" > /dev/null
+			cleanup_temp_files
+			return 0
+			;;
+		[aA]*)
+			return 1
+			;;
+		esac
 	done
 }
 
 resolve_submodule_merge () {
-    while true; do
-	printf "Use (l)ocal or (r)emote, or (a)bort? "
-	read ans || return 1
-	case "$ans" in
-	    [lL]*)
-		if ! local_present; then
-		    if test -n "$(git ls-tree HEAD -- "$MERGED")"; then
-			# Local isn't present, but it's a subdirectory
-			git ls-tree --full-name -r HEAD -- "$MERGED" | git update-index --index-info || exit $?
-		    else
-			test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
-			git update-index --force-remove "$MERGED"
+	while true
+	do
+		printf "Use (l)ocal or (r)emote, or (a)bort? "
+		read ans || return 1
+		case "$ans" in
+		[lL]*)
+			if ! local_present
+			then
+				if test -n "$(git ls-tree HEAD -- "$MERGED")"
+				then
+					# Local isn't present, but it's a subdirectory
+					git ls-tree --full-name -r HEAD -- "$MERGED" |
+					git update-index --index-info || exit $?
+				else
+					test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+					git update-index --force-remove "$MERGED"
+					cleanup_temp_files --save-backup
+				fi
+			elif is_submodule "$local_mode"
+			then
+				stage_submodule "$MERGED" "$local_sha1"
+			else
+				git checkout-index -f --stage=2 -- "$MERGED"
+				git add -- "$MERGED"
+			fi
+			return 0
+			;;
+		[rR]*)
+			if ! remote_present
+			then
+				if test -n "$(git ls-tree MERGE_HEAD -- "$MERGED")"
+				then
+					# Remote isn't present, but it's a subdirectory
+					git ls-tree --full-name -r MERGE_HEAD -- "$MERGED" |
+					git update-index --index-info || exit $?
+				else
+					test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+					git update-index --force-remove "$MERGED"
+				fi
+			elif is_submodule "$remote_mode"
+			then
+				! is_submodule "$local_mode" &&
+				test -e "$MERGED" &&
+				mv -- "$MERGED" "$BACKUP"
+				stage_submodule "$MERGED" "$remote_sha1"
+			else
+				test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
+				git checkout-index -f --stage=3 -- "$MERGED"
+				git add -- "$MERGED"
+			fi
 			cleanup_temp_files --save-backup
-		    fi
-		elif is_submodule "$local_mode"; then
-		    stage_submodule "$MERGED" "$local_sha1"
-		else
-		    git checkout-index -f --stage=2 -- "$MERGED"
-		    git add -- "$MERGED"
-		fi
-		return 0
-		;;
-	    [rR]*)
-		if ! remote_present; then
-		    if test -n "$(git ls-tree MERGE_HEAD -- "$MERGED")"; then
-			# Remote isn't present, but it's a subdirectory
-			git ls-tree --full-name -r MERGE_HEAD -- "$MERGED" | git update-index --index-info || exit $?
-		    else
-			test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
-			git update-index --force-remove "$MERGED"
-		    fi
-		elif is_submodule "$remote_mode"; then
-		    ! is_submodule "$local_mode" && test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
-		    stage_submodule "$MERGED" "$remote_sha1"
-		else
-		    test -e "$MERGED" && mv -- "$MERGED" "$BACKUP"
-		    git checkout-index -f --stage=3 -- "$MERGED"
-		    git add -- "$MERGED"
-		fi
-		cleanup_temp_files --save-backup
-		return 0
-		;;
-	    [aA]*)
-		return 1
-		;;
-	    esac
+			return 0
+			;;
+		[aA]*)
+			return 1
+			;;
+		esac
 	done
 }
 
 stage_submodule () {
-    path="$1"
-    submodule_sha1="$2"
-    mkdir -p "$path" || die "fatal: unable to create directory for module at $path"
-    # Find $path relative to work tree
-    work_tree_root=$(cd_to_toplevel && pwd)
-    work_rel_path=$(cd "$path" && GIT_WORK_TREE="${work_tree_root}" git rev-parse --show-prefix)
-    test -n "$work_rel_path" || die "fatal: unable to get path of module $path relative to work tree"
-    git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
+	path="$1"
+	submodule_sha1="$2"
+	mkdir -p "$path" ||
+	die "fatal: unable to create directory for module at $path"
+	# Find $path relative to work tree
+	work_tree_root=$(cd_to_toplevel && pwd)
+	work_rel_path=$(cd "$path" &&
+		GIT_WORK_TREE="${work_tree_root}" git rev-parse --show-prefix
+	)
+	test -n "$work_rel_path" ||
+	die "fatal: unable to get path of module $path relative to work tree"
+	git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
 }
 
 checkout_staged_file () {
-    tmpfile=$(expr \
-	    "$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
-	    : '\([^	]*\)	')
-
-    if test $? -eq 0 -a -n "$tmpfile" ; then
-	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
-    else
-	>"$3"
-    fi
+	tmpfile=$(expr \
+		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
+		: '\([^	]*\)	')
+
+	if test $? -eq 0 -a -n "$tmpfile"
+	then
+		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
+	else
+		>"$3"
+	fi
 }
 
 merge_file () {
-    MERGED="$1"
+	MERGED="$1"
 
-    f=$(git ls-files -u -- "$MERGED")
-    if test -z "$f" ; then
-	if test ! -f "$MERGED" ; then
-	    echo "$MERGED: file not found"
-	else
-	    echo "$MERGED: file does not need merging"
+	f=$(git ls-files -u -- "$MERGED")
+	if test -z "$f"
+	then
+		if test ! -f "$MERGED"
+		then
+			echo "$MERGED: file not found"
+		else
+			echo "$MERGED: file does not need merging"
+		fi
+		return 1
 	fi
-	return 1
-    fi
-
-    ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-    BACKUP="./$MERGED.BACKUP.$ext"
-    LOCAL="./$MERGED.LOCAL.$ext"
-    REMOTE="./$MERGED.REMOTE.$ext"
-    BASE="./$MERGED.BASE.$ext"
-
-    base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
-    local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-    remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
-
-    if is_submodule "$local_mode" || is_submodule "$remote_mode"; then
-	echo "Submodule merge conflict for '$MERGED':"
-	local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
-	remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
-	describe_file "$local_mode" "local" "$local_sha1"
-	describe_file "$remote_mode" "remote" "$remote_sha1"
-	resolve_submodule_merge
-	return
-    fi
-
-    mv -- "$MERGED" "$BACKUP"
-    cp -- "$BACKUP" "$MERGED"
-
-    checkout_staged_file 1 "$MERGED" "$BASE"
-    checkout_staged_file 2 "$MERGED" "$LOCAL"
-    checkout_staged_file 3 "$MERGED" "$REMOTE"
-
-    if test -z "$local_mode" -o -z "$remote_mode"; then
-	echo "Deleted merge conflict for '$MERGED':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
-	resolve_deleted_merge
-	return
-    fi
 
-    if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symbolic link merge conflict for '$MERGED':"
+	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
+	BACKUP="./$MERGED.BACKUP.$ext"
+	LOCAL="./$MERGED.LOCAL.$ext"
+	REMOTE="./$MERGED.REMOTE.$ext"
+	BASE="./$MERGED.BASE.$ext"
+
+	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
+	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
+	remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
+
+	if is_submodule "$local_mode" || is_submodule "$remote_mode"
+	then
+		echo "Submodule merge conflict for '$MERGED':"
+		local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
+		remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
+		describe_file "$local_mode" "local" "$local_sha1"
+		describe_file "$remote_mode" "remote" "$remote_sha1"
+		resolve_submodule_merge
+		return
+	fi
+
+	mv -- "$MERGED" "$BACKUP"
+	cp -- "$BACKUP" "$MERGED"
+
+	checkout_staged_file 1 "$MERGED" "$BASE"
+	checkout_staged_file 2 "$MERGED" "$LOCAL"
+	checkout_staged_file 3 "$MERGED" "$REMOTE"
+
+	if test -z "$local_mode" -o -z "$remote_mode"
+	then
+		echo "Deleted merge conflict for '$MERGED':"
+		describe_file "$local_mode" "local" "$LOCAL"
+		describe_file "$remote_mode" "remote" "$REMOTE"
+		resolve_deleted_merge
+		return
+	fi
+
+	if is_symlink "$local_mode" || is_symlink "$remote_mode"
+	then
+		echo "Symbolic link merge conflict for '$MERGED':"
+		describe_file "$local_mode" "local" "$LOCAL"
+		describe_file "$remote_mode" "remote" "$REMOTE"
+		resolve_symlink_merge
+		return
+	fi
+
+	echo "Normal merge conflict for '$MERGED':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
-	resolve_symlink_merge
-	return
-    fi
-
-    echo "Normal merge conflict for '$MERGED':"
-    describe_file "$local_mode" "local" "$LOCAL"
-    describe_file "$remote_mode" "remote" "$REMOTE"
-    if "$prompt" = true; then
-	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-	read ans || return 1
-    fi
-
-    if base_present; then
-	    present=true
-    else
-	    present=false
-    fi
-
-    if ! run_merge_tool "$merge_tool" "$present"; then
-	echo "merge of $MERGED failed" 1>&2
-	mv -- "$BACKUP" "$MERGED"
-
-	if test "$merge_keep_temporaries" = "false"; then
-	    cleanup_temp_files
+	if "$prompt" = true
+	then
+		printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
+		read ans || return 1
 	fi
 
-	return 1
-    fi
+	if base_present
+	then
+		present=true
+	else
+		present=false
+	fi
+
+	if ! run_merge_tool "$merge_tool" "$present"
+	then
+		echo "merge of $MERGED failed" 1>&2
+		mv -- "$BACKUP" "$MERGED"
+
+		if test "$merge_keep_temporaries" = "false"
+		then
+			cleanup_temp_files
+		fi
 
-    if test "$merge_keep_backup" = "true"; then
-	mv -- "$BACKUP" "$MERGED.orig"
-    else
-	rm -- "$BACKUP"
-    fi
+		return 1
+	fi
 
-    git add -- "$MERGED"
-    cleanup_temp_files
-    return 0
+	if test "$merge_keep_backup" = "true"
+	then
+		mv -- "$BACKUP" "$MERGED.orig"
+	else
+		rm -- "$BACKUP"
+	fi
+
+	git add -- "$MERGED"
+	cleanup_temp_files
+	return 0
 }
 
 show_tool_help () {
@@ -325,61 +356,61 @@ prompt=$(git config --bool mergetool.prompt || echo true)
 
 while test $# != 0
 do
-    case "$1" in
+	case "$1" in
 	--tool-help)
 		show_tool_help
 		;;
 	-t|--tool*)
-	    case "$#,$1" in
+		case "$#,$1" in
 		*,*=*)
-		    merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
-		    ;;
+			merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
+			;;
 		1,*)
-		    usage ;;
+			usage ;;
 		*)
-		    merge_tool="$2"
-		    shift ;;
-	    esac
-	    ;;
+			merge_tool="$2"
+			shift ;;
+		esac
+		;;
 	-y|--no-prompt)
-	    prompt=false
-	    ;;
+		prompt=false
+		;;
 	--prompt)
-	    prompt=true
-	    ;;
+		prompt=true
+		;;
 	--)
-	    shift
-	    break
-	    ;;
+		shift
+		break
+		;;
 	-*)
-	    usage
-	    ;;
-	*)
-	    break
-	    ;;
-    esac
-    shift
-done
-
-prompt_after_failed_merge() {
-    while true; do
-	printf "Continue merging other unresolved paths (y/n) ? "
-	read ans || return 1
-	case "$ans" in
-
-	    [yY]*)
-		return 0
+		usage
 		;;
-
-	    [nN]*)
-		return 1
+	*)
+		break
 		;;
 	esac
-    done
+	shift
+done
+
+prompt_after_failed_merge () {
+	while true
+	do
+		printf "Continue merging other unresolved paths (y/n) ? "
+		read ans || return 1
+		case "$ans" in
+		[yY]*)
+			return 0
+			;;
+		[nN]*)
+			return 1
+			;;
+		esac
+	done
 }
 
-if test -z "$merge_tool"; then
-    merge_tool=$(get_merge_tool "$merge_tool") || exit
+if test -z "$merge_tool"
+then
+	merge_tool=$(get_merge_tool "$merge_tool") || exit
 fi
 merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
@@ -388,22 +419,24 @@ last_status=0
 rollup_status=0
 files=
 
-if test $# -eq 0 ; then
-    cd_to_toplevel
+if test $# -eq 0
+then
+	cd_to_toplevel
 
-    if test -e "$GIT_DIR/MERGE_RR"
-    then
-	files=$(git rerere remaining)
-    else
-	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
-    fi
+	if test -e "$GIT_DIR/MERGE_RR"
+	then
+		files=$(git rerere remaining)
+	else
+		files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
+	fi
 else
-    files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
+	files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
 fi
 
-if test -z "$files" ; then
-    echo "No files need merging"
-    exit 0
+if test -z "$files"
+then
+	echo "No files need merging"
+	exit 0
 fi
 
 printf "Merging:\n"
@@ -413,15 +446,17 @@ IFS='
 '
 for i in $files
 do
-    if test $last_status -ne 0; then
-	prompt_after_failed_merge || exit 1
-    fi
-    printf "\n"
-    merge_file "$i"
-    last_status=$?
-    if test $last_status -ne 0; then
-	rollup_status=1
-    fi
+	if test $last_status -ne 0
+	then
+		prompt_after_failed_merge || exit 1
+	fi
+	printf "\n"
+	merge_file "$i"
+	last_status=$?
+	if test $last_status -ne 0
+	then
+		rollup_status=1
+	fi
 done
 
 exit $rollup_status
