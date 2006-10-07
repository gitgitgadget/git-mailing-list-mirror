From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] git-commit: fix coding style.
Date: Sat, 7 Oct 2006 21:07:40 +0200
Message-ID: <20061007190740.GY2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 07 21:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHWU-0000rq-Ff
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWJGTHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWJGTHn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:07:43 -0400
Received: from agent.admingilde.org ([213.95.21.5]:41886 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932723AbWJGTHm
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 15:07:42 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GWHWO-0006DE-UV
	for git@vger.kernel.org; Sat, 07 Oct 2006 21:07:40 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28498>

git-commit.sh was using a mixture of spaces and tabs for indentation.
This is changed to one tab per indentation level.
No code changes.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 git-commit.sh |  464 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 233 insertions(+), 231 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 6f6cbda..5b1cf85 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -41,21 +41,21 @@ run_status () {
 	# so the regular index file is what we use to compare.
 	if test '' != "$TMP_INDEX"
 	then
-	    GIT_INDEX_FILE="$TMP_INDEX"
-	    export GIT_INDEX_FILE
+		GIT_INDEX_FILE="$TMP_INDEX"
+		export GIT_INDEX_FILE
 	elif test -f "$NEXT_INDEX"
 	then
-	    GIT_INDEX_FILE="$NEXT_INDEX"
-	    export GIT_INDEX_FILE
+		GIT_INDEX_FILE="$NEXT_INDEX"
+		export GIT_INDEX_FILE
 	fi
 
-  case "$status_only" in
-    t) color= ;;
-    *) color=--nocolor ;;
-  esac
-  git-runstatus ${color} \
-                ${verbose:+--verbose} \
-                ${amend:+--amend} \
+	case "$status_only" in
+	t) color= ;;
+	*) color=--nocolor ;;
+	esac
+	git-runstatus ${color} \
+		${verbose:+--verbose} \
+		${amend:+--amend} \
 		${untracked_files:+--untracked}
 }
 
@@ -87,179 +87,181 @@ only_include_assumed=
 untracked_files=
 while case "$#" in 0) break;; esac
 do
-  case "$1" in
-  -F|--F|-f|--f|--fi|--fil|--file)
-      case "$#" in 1) usage ;; esac
-      shift
-      no_edit=t
-      log_given=t$log_given
-      logfile="$1"
-      shift
-      ;;
-  -F*|-f*)
-      no_edit=t
-      log_given=t$log_given
-      logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
-      shift
-      ;;
-  --F=*|--f=*|--fi=*|--fil=*|--file=*)
-      no_edit=t
-      log_given=t$log_given
-      logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-      shift
-      ;;
-  -a|--a|--al|--all)
-      all=t
-      shift
-      ;;
-  --au=*|--aut=*|--auth=*|--autho=*|--author=*)
-      force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-      shift
-      ;;
-  --au|--aut|--auth|--autho|--author)
-      case "$#" in 1) usage ;; esac
-      shift
-      force_author="$1"
-      shift
-      ;;
-  -e|--e|--ed|--edi|--edit)
-      edit_flag=t
-      shift
-      ;;
-  -i|--i|--in|--inc|--incl|--inclu|--includ|--include)
-      also=t
-      shift
-      ;;
-  -o|--o|--on|--onl|--only)
-      only=t
-      shift
-      ;;
-  -m|--m|--me|--mes|--mess|--messa|--messag|--message)
-      case "$#" in 1) usage ;; esac
-      shift
-      log_given=m$log_given
-      if test "$log_message" = ''
-      then
-          log_message="$1"
-      else
-          log_message="$log_message
+	case "$1" in
+	-F|--F|-f|--f|--fi|--fil|--file)
+		case "$#" in 1) usage ;; esac
+		shift
+		no_edit=t
+		log_given=t$log_given
+		logfile="$1"
+		shift
+		;;
+	-F*|-f*)
+		no_edit=t
+		log_given=t$log_given
+		logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
+		shift
+		;;
+	--F=*|--f=*|--fi=*|--fil=*|--file=*)
+		no_edit=t
+		log_given=t$log_given
+		logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		shift
+		;;
+	-a|--a|--al|--all)
+		all=t
+		shift
+		;;
+	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
+		force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		shift
+		;;
+	--au|--aut|--auth|--autho|--author)
+		case "$#" in 1) usage ;; esac
+		shift
+		force_author="$1"
+		shift
+		;;
+	-e|--e|--ed|--edi|--edit)
+		edit_flag=t
+		shift
+		;;
+	-i|--i|--in|--inc|--incl|--inclu|--includ|--include)
+		also=t
+		shift
+		;;
+	-o|--o|--on|--onl|--only)
+		only=t
+		shift
+		;;
+	-m|--m|--me|--mes|--mess|--messa|--messag|--message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=m$log_given
+		if test "$log_message" = ''
+		then
+		    log_message="$1"
+		else
+		    log_message="$log_message
 
 $1"
-      fi
-      no_edit=t
-      shift
-      ;;
-  -m*)
-      log_given=m$log_given
-      if test "$log_message" = ''
-      then
-          log_message=`expr "z$1" : 'z-m\(.*\)'`
-      else
-          log_message="$log_message
+		fi
+		no_edit=t
+		shift
+		;;
+	-m*)
+		log_given=m$log_given
+		if test "$log_message" = ''
+		then
+		    log_message=`expr "z$1" : 'z-m\(.*\)'`
+		else
+		    log_message="$log_message
 
 `expr "z$1" : 'z-m\(.*\)'`"
-      fi
-      no_edit=t
-      shift
-      ;;
-  --m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
-      log_given=m$log_given
-      if test "$log_message" = ''
-      then
-          log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-      else
-          log_message="$log_message
+		fi
+		no_edit=t
+		shift
+		;;
+	--m=*|--me=*|--mes=*|--mess=*|--messa=*|--messag=*|--message=*)
+		log_given=m$log_given
+		if test "$log_message" = ''
+		then
+		    log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		else
+		    log_message="$log_message
 
 `expr "z$1" : 'zq-[^=]*=\(.*\)'`"
-      fi
-      no_edit=t
-      shift
-      ;;
-  -n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|--no-verify)
-      verify=
-      shift
-      ;;
-  --a|--am|--ame|--amen|--amend)
-      amend=t
-      log_given=t$log_given
-      use_commit=HEAD
-      shift
-      ;;
-  -c)
-      case "$#" in 1) usage ;; esac
-      shift
-      log_given=t$log_given
-      use_commit="$1"
-      no_edit=
-      shift
-      ;;
-  --ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
-  --reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
-  --reedit-messag=*|--reedit-message=*)
-      log_given=t$log_given
-      use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-      no_edit=
-      shift
-      ;;
-  --ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
-  --reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|--reedit-message)
-      case "$#" in 1) usage ;; esac
-      shift
-      log_given=t$log_given
-      use_commit="$1"
-      no_edit=
-      shift
-      ;;
-  -C)
-      case "$#" in 1) usage ;; esac
-      shift
-      log_given=t$log_given
-      use_commit="$1"
-      no_edit=t
-      shift
-      ;;
-  --reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
-  --reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
-  --reuse-message=*)
-      log_given=t$log_given
-      use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-      no_edit=t
-      shift
-      ;;
-  --reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
-  --reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
-      case "$#" in 1) usage ;; esac
-      shift
-      log_given=t$log_given
-      use_commit="$1"
-      no_edit=t
-      shift
-      ;;
-  -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
-      signoff=t
-      shift
-      ;;
-  -v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-      verbose=t
-      shift
-      ;;
-  -u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|--untracked|\
-  --untracked-|--untracked-f|--untracked-fi|--untracked-fil|--untracked-file|\
-  --untracked-files)
-      untracked_files=t
-      shift
-      ;;
-  --)
-      shift
-      break
-      ;;
-  -*)
-      usage
-      ;;
-  *)
-      break
-      ;;
-  esac
+		fi
+		no_edit=t
+		shift
+		;;
+	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
+	--no-verify)
+		verify=
+		shift
+		;;
+	--a|--am|--ame|--amen|--amend)
+		amend=t
+		log_given=t$log_given
+		use_commit=HEAD
+		shift
+		;;
+	-c)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=t$log_given
+		use_commit="$1"
+		no_edit=
+		shift
+		;;
+	--ree=*|--reed=*|--reedi=*|--reedit=*|--reedit-=*|--reedit-m=*|\
+	--reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
+	--reedit-messag=*|--reedit-message=*)
+		log_given=t$log_given
+		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		no_edit=
+		shift
+		;;
+	--ree|--reed|--reedi|--reedit|--reedit-|--reedit-m|--reedit-me|\
+	--reedit-mes|--reedit-mess|--reedit-messa|--reedit-messag|\
+	--reedit-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=t$log_given
+		use_commit="$1"
+		no_edit=
+		shift
+		;;
+	-C)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=t$log_given
+		use_commit="$1"
+		no_edit=t
+		shift
+		;;
+	--reu=*|--reus=*|--reuse=*|--reuse-=*|--reuse-m=*|--reuse-me=*|\
+	--reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
+	--reuse-message=*)
+		log_given=t$log_given
+		use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		no_edit=t
+		shift
+		;;
+	--reu|--reus|--reuse|--reuse-|--reuse-m|--reuse-me|--reuse-mes|\
+	--reuse-mess|--reuse-messa|--reuse-messag|--reuse-message)
+		case "$#" in 1) usage ;; esac
+		shift
+		log_given=t$log_given
+		use_commit="$1"
+		no_edit=t
+		shift
+		;;
+	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
+		signoff=t
+		shift
+		;;
+	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
+		verbose=t
+		shift
+		;;
+	-u|--u|--un|--unt|--untr|--untra|--untrac|--untrack|--untracke|\
+	--untracked|--untracked-|--untracked-f|--untracked-fi|--untracked-fil|\
+	--untracked-file|--untracked-files)
+		untracked_files=t
+		shift
+		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
 done
 case "$edit_flag" in t) no_edit= ;; esac
 
@@ -268,33 +270,33 @@ # Sanity check options
 
 case "$amend,$initial_commit" in
 t,t)
-  die "You do not have anything to amend." ;;
+	die "You do not have anything to amend." ;;
 t,)
-  if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
-    die "You are in the middle of a merge -- cannot amend."
-  fi ;;
+	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+		die "You are in the middle of a merge -- cannot amend."
+	fi ;;
 esac
 
 case "$log_given" in
 tt*)
-  die "Only one of -c/-C/-F can be used." ;;
+	die "Only one of -c/-C/-F can be used." ;;
 *tm*|*mt*)
-  die "Option -m cannot be combined with -c/-C/-F." ;;
+	die "Option -m cannot be combined with -c/-C/-F." ;;
 esac
 
 case "$#,$also,$only,$amend" in
 *,t,t,*)
-  die "Only one of --include/--only can be used." ;;
+	die "Only one of --include/--only can be used." ;;
 0,t,,* | 0,,t,)
-  die "No paths with --include/--only does not make sense." ;;
+	die "No paths with --include/--only does not make sense." ;;
 0,,t,t)
-  only_include_assumed="# Clever... amending the last one with dirty index." ;;
+	only_include_assumed="# Clever... amending the last one with dirty index." ;;
 0,,,*)
-  ;;
+	;;
 *,,,*)
-  only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
-  also=
-  ;;
+	only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
+	also=
+	;;
 esac
 unset only
 case "$all,$also,$#" in
@@ -341,47 +343,47 @@ t,)
 ,)
 	case "$#" in
 	0)
-	    ;; # commit as-is
+		;; # commit as-is
 	*)
-	    if test -f "$GIT_DIR/MERGE_HEAD"
-	    then
-		refuse_partial "Cannot do a partial commit during a merge."
-	    fi
-	    TMP_INDEX="$GIT_DIR/tmp-index$$"
-	    if test -z "$initial_commit"
-	    then
-		# make sure index is clean at the specified paths, or
-		# they are additions.
-		dirty_in_index=`git-diff-index --cached --name-status \
-			--diff-filter=DMTU HEAD -- "$@"`
-		test -z "$dirty_in_index" ||
-		refuse_partial "Different in index and the last commit:
+		if test -f "$GIT_DIR/MERGE_HEAD"
+		then
+			refuse_partial "Cannot do a partial commit during a merge."
+		fi
+		TMP_INDEX="$GIT_DIR/tmp-index$$"
+		if test -z "$initial_commit"
+		then
+			# make sure index is clean at the specified paths, or
+			# they are additions.
+			dirty_in_index=`git-diff-index --cached --name-status \
+				--diff-filter=DMTU HEAD -- "$@"`
+			test -z "$dirty_in_index" ||
+			refuse_partial "Different in index and the last commit:
 $dirty_in_index"
-	    fi
-	    commit_only=`git-ls-files --error-unmatch -- "$@"` || exit
-
-	    # Build the temporary index and update the real index
-	    # the same way.
-	    if test -z "$initial_commit"
-	    then
-		cp "$THIS_INDEX" "$TMP_INDEX"
-		GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -m HEAD
-	    else
-		    rm -f "$TMP_INDEX"
-	    fi || exit
-
-	    echo "$commit_only" |
-	    GIT_INDEX_FILE="$TMP_INDEX" \
-	    git-update-index --add --remove --stdin &&
-
-	    save_index &&
-	    echo "$commit_only" |
-	    (
-		GIT_INDEX_FILE="$NEXT_INDEX"
-		export GIT_INDEX_FILE
-		git-update-index --remove --stdin
-	    ) || exit
-	    ;;
+		fi
+		commit_only=`git-ls-files --error-unmatch -- "$@"` || exit
+
+		# Build the temporary index and update the real index
+		# the same way.
+		if test -z "$initial_commit"
+		then
+			cp "$THIS_INDEX" "$TMP_INDEX"
+			GIT_INDEX_FILE="$TMP_INDEX" git-read-tree -m HEAD
+		else
+			rm -f "$TMP_INDEX"
+		fi || exit
+
+		echo "$commit_only" |
+		GIT_INDEX_FILE="$TMP_INDEX" \
+		git-update-index --add --remove --stdin &&
+
+		save_index &&
+		echo "$commit_only" |
+		(
+			GIT_INDEX_FILE="$NEXT_INDEX"
+			export GIT_INDEX_FILE
+			git-update-index --remove --stdin
+		) || exit
+		;;
 	esac
 	;;
 esac
@@ -399,7 +401,7 @@ else
 fi
 
 GIT_INDEX_FILE="$USE_INDEX" \
-    git-update-index -q $unmerged_ok_if_status --refresh || exit
+	git-update-index -q $unmerged_ok_if_status --refresh || exit
 
 ################################################################
 # If the request is status, just show it and exit.
-- 
1.4.2.3

-- 
Martin Waitz
