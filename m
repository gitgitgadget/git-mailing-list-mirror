From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] Use tabs for indent in shell scripts
Date: Tue, 1 Aug 2006 11:34:48 +0200
Message-ID: <200608011134.52006.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <ean0a1$irf$1@sea.gmane.org> <7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 11:37:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7qgI-0001WO-2s
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 11:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWHAJgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHAJgw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 05:36:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:228 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932588AbWHAJgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 05:36:51 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1212512ugc
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 02:36:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WLysfgrwmbf4jFILmTzjLybjLIY77TKGx7wNU2AWpneXu+PbTEVhRvzIitiqaEs49enMKsn+dSz7CZ7Seir8cgic/9nYDYDci+spMsYm1dA6lkEBv44qxJhLww0OrlZ1tTSZ0UrCvCMbb98w1U9Z2xOLDoiV22CVxIqFZFJgJdo=
Received: by 10.66.224.3 with SMTP id w3mr597867ugg;
        Tue, 01 Aug 2006 02:36:46 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id e1sm585036ugf.2006.08.01.02.36.45;
        Tue, 01 Aug 2006 02:36:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24586>

Consistently use tabs for indenting in some shell scripts.  Needs
checking for consistency (command1 && command2 && command3 split into
lines).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-clone.sh     |   94 +++++-----
 git-fetch.sh     |  493 +++++++++++++++++++++++++++---------------------------
 git-ls-remote.sh |   50 +++--
 3 files changed, 319 insertions(+), 318 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index a92b22a..adb752d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -18,7 +18,7 @@ get_repo_base() {
 }
 
 if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-    curl_extra_args="-k"
+	curl_extra_args="-k"
 fi
 
 http_fetch () {
@@ -43,7 +43,7 @@ Perhaps git-update-server-info needs to 
 		*^*)	continue;;
 		esac
 		if test -n "$use_separate_remote" &&
-		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
+			branch_name=`expr "z$name" : 'zheads/\(.*\)'`
 		then
 			tname="remotes/$origin/$branch_name"
 		else
@@ -119,13 +119,13 @@ while
 	*,--na|*,--nak|*,--nake|*,--naked|\
 	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
-        *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
-          local_shared=yes; use_local=yes ;;
+	*,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
+		local_shared=yes; use_local=yes ;;
 	1,--template) usage ;;
 	*,--template)
 		shift; template="--template=$1" ;;
 	*,--template=*)
-	  template="$1" ;;
+		template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote)
 		use_separate_remote=t ;;
@@ -137,18 +137,18 @@ while
 	*,-o|*,--or|*,--ori|*,--orig|*,--origi|*,--origin)
 		case "$2" in
 		'')
-		    usage ;;
+			usage ;;
 		*/*)
-		    echo >&2 "'$2' is not suitable for an origin name"
-		    exit 1
+			echo >&2 "'$2' is not suitable for an origin name"
+			exit 1
 		esac
 		git-check-ref-format "heads/$2" || {
-		    echo >&2 "'$2' is not suitable for a branch name"
-		    exit 1
+			echo >&2 "'$2' is not suitable for a branch name"
+			exit 1
 		}
 		test -z "$origin_override" || {
-		    echo >&2 "Do not give more than one --origin options."
-		    exit 1
+			echo >&2 "Do not give more than one --origin options."
+			exit 1
 		}
 		origin_override=yes
 		origin="$2"; shift
@@ -167,8 +167,8 @@ done
 repo="$1"
 if test -z "$repo"
 then
-    echo >&2 'you must specify a repository to clone.'
-    exit 1
+	echo >&2 'you must specify a repository to clone.'
+	exit 1
 fi
 
 # --bare implies --no-checkout
@@ -225,9 +225,9 @@ then
 		echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
 		(cd "$reference" && tar cf - refs) |
 		(cd "$GIT_DIR/refs" &&
-		 mkdir reference-tmp &&
-		 cd reference-tmp &&
-		 tar xf -)
+			mkdir reference-tmp &&
+			cd reference-tmp &&
+			tar xf -)
 	else
 		echo >&2 "$reference: not a local directory." && usage
 	fi
@@ -245,26 +245,26 @@ yes,yes)
 
 	case "$local_shared" in
 	no)
-	    # See if we can hardlink and drop "l" if not.
-	    sample_file=$(cd "$repo" && \
-			  find objects -type f -print | sed -e 1q)
+		# See if we can hardlink and drop "l" if not.
+		sample_file=$(cd "$repo" && \
+			find objects -type f -print | sed -e 1q)
 
-	    # objects directory should not be empty since we are cloning!
-	    test -f "$repo/$sample_file" || exit
+		# objects directory should not be empty since we are cloning!
+		test -f "$repo/$sample_file" || exit
 
-	    l=
-	    if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
-	    then
-		    l=l
-	    fi &&
-	    rm -f "$GIT_DIR/objects/sample" &&
-	    cd "$repo" &&
-	    find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
-	    ;;
+		l=
+		if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
+		then
+			l=l
+		fi &&
+		rm -f "$GIT_DIR/objects/sample" &&
+		cd "$repo" &&
+		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
+		;;
 	yes)
-	    mkdir -p "$GIT_DIR/objects/info"
-	    echo "$repo/objects" >> "$GIT_DIR/objects/info/alternates"
-	    ;;
+		mkdir -p "$GIT_DIR/objects/info"
+		echo "$repo/objects" >> "$GIT_DIR/objects/info/alternates"
+		;;
 	esac
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
@@ -282,19 +282,19 @@ yes,yes)
 			rm -f "$GIT_DIR/TMP_ALT"
 		if test -f "$GIT_DIR/TMP_ALT"
 		then
-		    ( cd "$D" &&
-		      . git-parse-remote &&
-		      resolve_alternates "$repo" <"$GIT_DIR/TMP_ALT" ) |
-		    while read alt
-		    do
-			case "$alt" in 'bad alternate: '*) die "$alt";; esac
-			case "$quiet" in
-			'')	echo >&2 "Getting alternate: $alt" ;;
-			esac
-			rsync $quiet -av --ignore-existing  \
-			    --exclude info "$alt" "$GIT_DIR/objects" || exit
-		    done
-		    rm -f "$GIT_DIR/TMP_ALT"
+			( cd "$D" &&
+				. git-parse-remote &&
+				resolve_alternates "$repo" <"$GIT_DIR/TMP_ALT" ) |
+			while read alt
+			do
+				case "$alt" in 'bad alternate: '*) die "$alt";; esac
+				case "$quiet" in
+				'')	echo >&2 "Getting alternate: $alt" ;;
+				esac
+				rsync $quiet -av --ignore-existing  \
+					--exclude info "$alt" "$GIT_DIR/objects" || exit
+			done
+			rm -f "$GIT_DIR/TMP_ALT"
 		fi
 		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
diff --git a/git-fetch.sh b/git-fetch.sh
index c2eebee..cea6e0b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -90,124 +90,124 @@ then
 fi
 
 append_fetch_head () {
-    head_="$1"
-    remote_="$2"
-    remote_name_="$3"
-    remote_nick_="$4"
-    local_name_="$5"
-    case "$6" in
-    t) not_for_merge_='not-for-merge' ;;
-    '') not_for_merge_= ;;
-    esac
+	head_="$1"
+	remote_="$2"
+	remote_name_="$3"
+	remote_nick_="$4"
+	local_name_="$5"
+	case "$6" in
+		t) not_for_merge_='not-for-merge' ;;
+		'') not_for_merge_= ;;
+	esac
 
-    # remote-nick is the URL given on the command line (or a shorthand)
-    # remote-name is the $GIT_DIR relative refs/ path we computed
-    # for this refspec.
+	# remote-nick is the URL given on the command line (or a shorthand)
+	# remote-name is the $GIT_DIR relative refs/ path we computed
+	# for this refspec.
 
-    # the $note_ variable will be fed to git-fmt-merge-msg for further
-    # processing.
-    case "$remote_name_" in
-    HEAD)
-	note_= ;;
-    refs/heads/*)
-	note_="$(expr "$remote_name_" : 'refs/heads/\(.*\)')"
-	note_="branch '$note_' of " ;;
-    refs/tags/*)
-	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
-	note_="tag '$note_' of " ;;
-    refs/remotes/*)
-	note_="$(expr "$remote_name_" : 'refs/remotes/\(.*\)')"
-	note_="remote branch '$note_' of " ;;
-    *)
-	note_="$remote_name of " ;;
-    esac
-    remote_1_=$(expr "z$remote_" : 'z\(.*\)\.git/*$') &&
+	# the $note_ variable will be fed to git-fmt-merge-msg for further
+	# processing.
+	case "$remote_name_" in
+	HEAD)
+		note_= ;;
+	refs/heads/*)
+		note_="$(expr "$remote_name_" : 'refs/heads/\(.*\)')"
+		note_="branch '$note_' of " ;;
+	refs/tags/*)
+		note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
+		note_="tag '$note_' of " ;;
+	refs/remotes/*)
+		note_="$(expr "$remote_name_" : 'refs/remotes/\(.*\)')"
+		note_="remote branch '$note_' of " ;;
+	*)
+		note_="$remote_name of " ;;
+	esac
+	remote_1_=$(expr "z$remote_" : 'z\(.*\)\.git/*$') &&
 	remote_="$remote_1_"
-    note_="$note_$remote_"
+	note_="$note_$remote_"
 
-    # 2.6.11-tree tag would not be happy to be fed to resolve.
-    if git-cat-file commit "$head_" >/dev/null 2>&1
-    then
-	headc_=$(git-rev-parse --verify "$head_^0") || exit
-	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* committish: $head_"
-	[ "$verbose" ] && echo >&2 "  $note_"
-    else
-	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
-	[ "$verbose" ] && echo >&2 "  $note_"
-    fi
-    if test "$local_name_" != ""
-    then
-	# We are storing the head locally.  Make sure that it is
-	# a fast forward (aka "reverse push").
-	fast_forward_local "$local_name_" "$head_" "$note_"
-    fi
+	# 2.6.11-tree tag would not be happy to be fed to resolve.
+	if git-cat-file commit "$head_" >/dev/null 2>&1
+	then
+		headc_=$(git-rev-parse --verify "$head_^0") || exit
+		echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
+		[ "$verbose" ] && echo >&2 "* committish: $head_"
+		[ "$verbose" ] && echo >&2 "  $note_"
+	else
+		echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
+		[ "$verbose" ] && echo >&2 "* non-commit: $head_"
+		[ "$verbose" ] && echo >&2 "  $note_"
+	fi
+	if test "$local_name_" != ""
+	then
+		# We are storing the head locally.  Make sure that it is
+		# a fast forward (aka "reverse push").
+		fast_forward_local "$local_name_" "$head_" "$note_"
+	fi
 }
 
 fast_forward_local () {
-    mkdir -p "$(dirname "$GIT_DIR/$1")"
-    case "$1" in
-    refs/tags/*)
-	# Tags need not be pointing at commits so there
-	# is no way to guarantee "fast-forward" anyway.
-	if test -f "$GIT_DIR/$1"
-	then
-		if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
+	mkdir -p "$(dirname "$GIT_DIR/$1")"
+	case "$1" in
+	refs/tags/*)
+		# Tags need not be pointing at commits so there
+		# is no way to guarantee "fast-forward" anyway.
+		if test -f "$GIT_DIR/$1"
 		then
-			[ "$verbose" ] && echo >&2 "* $1: same as $3" ||:
+			if now_=$(cat "$GIT_DIR/$1") && test "$now_" = "$2"
+			then
+				[ "$verbose" ] && echo >&2 "* $1: same as $3" ||:
+			else
+				echo >&2 "* $1: updating with $3"
+				git-update-ref -m "$rloga: updating tag" "$1" "$2"
+			fi
 		else
-			echo >&2 "* $1: updating with $3"
-			git-update-ref -m "$rloga: updating tag" "$1" "$2"
+			echo >&2 "* $1: storing $3"
+			git-update-ref -m "$rloga: storing tag" "$1" "$2"
 		fi
-	else
-		echo >&2 "* $1: storing $3"
-		git-update-ref -m "$rloga: storing tag" "$1" "$2"
-	fi
-	;;
+		;;
 
-    refs/heads/* | refs/remotes/*)
-	# $1 is the ref being updated.
-	# $2 is the new value for the ref.
-	local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
-	if test "$local"
-	then
-	    # Require fast-forward.
-	    mb=$(git-merge-base "$local" "$2") &&
-	    case "$2,$mb" in
-	    $local,*)
-	        if test -n "$verbose"
+	refs/heads/* | refs/remotes/*)
+		# $1 is the ref being updated.
+		# $2 is the new value for the ref.
+		local=$(git-rev-parse --verify "$1^0" 2>/dev/null)
+		if test "$local"
 		then
-			echo >&2 "* $1: same as $3"
+			# Require fast-forward.
+			mb=$(git-merge-base "$local" "$2") &&
+			case "$2,$mb" in
+			$local,*)
+				if test -n "$verbose"
+				then
+					echo >&2 "* $1: same as $3"
+				fi
+				;;
+			*,$local)
+				echo >&2 "* $1: fast forward to $3"
+				echo >&2 "  from $local to $2"
+				git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
+				;;
+			*)
+				false
+				;;
+			esac || {
+				echo >&2 "* $1: does not fast forward to $3;"
+				case ",$force,$single_force," in
+				*,t,*)
+					echo >&2 "  forcing update."
+					git-update-ref -m "$rloga: forced-update" "$1" "$2" "$local"
+					;;
+				*)
+					echo >&2 "  not updating."
+					exit 1
+					;;
+				esac
+			}
+		else
+			echo >&2 "* $1: storing $3"
+			git-update-ref -m "$rloga: storing head" "$1" "$2"
 		fi
 		;;
-	    *,$local)
-		echo >&2 "* $1: fast forward to $3"
-		echo >&2 "  from $local to $2"
-		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
-		;;
-	    *)
-		false
-		;;
-	    esac || {
-		echo >&2 "* $1: does not fast forward to $3;"
-		case ",$force,$single_force," in
-		*,t,*)
-			echo >&2 "  forcing update."
-			git-update-ref -m "$rloga: forced-update" "$1" "$2" "$local"
-			;;
-		*)
-			echo >&2 "  not updating."
-			exit 1
-			;;
-		esac
-	    }
-	else
-	    echo >&2 "* $1: storing $3"
-	    git-update-ref -m "$rloga: storing head" "$1" "$2"
-	fi
-	;;
-    esac
+	esac
 }
 
 case "$update_head_ok" in
@@ -225,26 +225,27 @@ reflist=$(get_remote_refs_for_fetch "$@"
 if test "$tags"
 then
 	taglist=`IFS="	" &&
-		  (
+		(
 			git-ls-remote $upload_pack --tags "$remote" ||
 			echo fail ouch
-		  ) |
-	          while read sha1 name
-		  do
+		) |
+		while read sha1 name
+		do
 			case "$sha1" in
 			fail)
 				exit 1
 			esac
 			case "$name" in
-			*^*) continue ;;
+			*^*)
+				continue ;;
 			esac
-		  	if git-check-ref-format "$name"
+			if git-check-ref-format "$name"
 			then
-			    echo ".${name}:${name}"
+				echo ".${name}:${name}"
 			else
-			    echo >&2 "warning: tag ${name} ignored"
+				echo >&2 "warning: tag ${name} ignored"
 			fi
-		  done` || exit
+		done` || exit
 	if test "$#" -gt 1
 	then
 		# remote URL plus explicit refspecs; we need to merge them.
@@ -256,146 +257,146 @@ then
 fi
 
 fetch_main () {
-  reflist="$1"
-  refs=
+	reflist="$1"
+	refs=
 
-  for ref in $reflist
-  do
-      refs="$refs$LF$ref"
+	for ref in $reflist
+	do
+		refs="$refs$LF$ref"
 
-      # These are relative path from $GIT_DIR, typically starting at refs/
-      # but may be HEAD
-      if expr "z$ref" : 'z\.' >/dev/null
-      then
-	  not_for_merge=t
-	  ref=$(expr "z$ref" : 'z\.\(.*\)')
-      else
-	  not_for_merge=
-      fi
-      if expr "z$ref" : 'z+' >/dev/null
-      then
-	  single_force=t
-	  ref=$(expr "z$ref" : 'z+\(.*\)')
-      else
-	  single_force=
-      fi
-      remote_name=$(expr "z$ref" : 'z\([^:]*\):')
-      local_name=$(expr "z$ref" : 'z[^:]*:\(.*\)')
+		# These are relative path from $GIT_DIR, typically starting at refs/
+		# but may be HEAD
+		if expr "z$ref" : 'z\.' >/dev/null
+		then
+			not_for_merge=t
+			ref=$(expr "z$ref" : 'z\.\(.*\)')
+		else
+			not_for_merge=
+		fi
+		if expr "z$ref" : 'z+' >/dev/null
+		then
+			single_force=t
+			ref=$(expr "z$ref" : 'z+\(.*\)')
+		else
+			single_force=
+		fi
+		remote_name=$(expr "z$ref" : 'z\([^:]*\):')
+		local_name=$(expr "z$ref" : 'z[^:]*:\(.*\)')
 
-      rref="$rref$LF$remote_name"
+		rref="$rref$LF$remote_name"
 
-      # There are transports that can fetch only one head at a time...
-      case "$remote" in
-      http://* | https://*)
-	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-	      curl_extra_args="-k"
-	  fi
-	  max_depth=5
-	  depth=0
-	  head="ref: $remote_name"
-	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
-	  do
-	    remote_name_quoted=$(@@PERL@@ -e '
-	      my $u = $ARGV[0];
-              $u =~ s/^ref:\s*//;
-	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
-	      print "$u";
-	  ' "$head")
-	    head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted")
-	    depth=$( expr \( $depth + 1 \) )
-	  done
-	  expr "z$head" : "z$_x40\$" >/dev/null ||
-	      die "Failed to fetch $remote_name from $remote"
-	  echo >&2 Fetching "$remote_name from $remote" using http
-	  git-http-fetch -v -a "$head" "$remote/" || exit
-	  ;;
-      rsync://*)
-	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
-	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
-	  head=$(git-rev-parse --verify TMP_HEAD)
-	  rm -f "$TMP_HEAD"
-	  test "$rsync_slurped_objects" || {
-	      rsync -av --ignore-existing --exclude info \
-		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
+		# There are transports that can fetch only one head at a time...
+		case "$remote" in
+		http://* | https://*)
+			if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+				curl_extra_args="-k"
+			fi
+			max_depth=5
+			depth=0
+			head="ref: $remote_name"
+			while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/null
+			do
+				remote_name_quoted=$(@@PERL@@ -e '
+					my $u = $ARGV[0];
+					$u =~ s/^ref:\s*//;
+					$u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
+					print "$u";
+					' "$head")
+				head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted")
+				depth=$( expr \( $depth + 1 \) )
+			done
+			expr "z$head" : "z$_x40\$" >/dev/null ||
+				die "Failed to fetch $remote_name from $remote"
+			echo >&2 Fetching "$remote_name from $remote" using http
+			git-http-fetch -v -a "$head" "$remote/" || exit
+			;;
+		rsync://*)
+			TMP_HEAD="$GIT_DIR/TMP_HEAD"
+			rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
+			head=$(git-rev-parse --verify TMP_HEAD)
+			rm -f "$TMP_HEAD"
+			test "$rsync_slurped_objects" || {
+				rsync -av --ignore-existing --exclude info \
+					"$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
 
-	      # Look at objects/info/alternates for rsync -- http will
-	      # support it natively and git native ones will do it on
-	      # the remote end.  Not having that file is not a crime.
-	      rsync -q "$remote/objects/info/alternates" \
-		  "$GIT_DIR/TMP_ALT" 2>/dev/null ||
-		  rm -f "$GIT_DIR/TMP_ALT"
-	      if test -f "$GIT_DIR/TMP_ALT"
-	      then
-		  resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
-		  while read alt
-		  do
-		      case "$alt" in 'bad alternate: '*) die "$alt";; esac
-		      echo >&2 "Getting alternate: $alt"
-		      rsync -av --ignore-existing --exclude info \
-		      "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
-		  done
-		  rm -f "$GIT_DIR/TMP_ALT"
-	      fi
-	      rsync_slurped_objects=t
-	  }
-	  ;;
-      *)
-	  # We will do git native transport with just one call later.
-	  continue ;;
-      esac
+			# Look at objects/info/alternates for rsync -- http will
+			# support it natively and git native ones will do it on
+			# the remote end.  Not having that file is not a crime.
+			rsync -q "$remote/objects/info/alternates" \
+				"$GIT_DIR/TMP_ALT" 2>/dev/null ||
+				rm -f "$GIT_DIR/TMP_ALT"
+			if test -f "$GIT_DIR/TMP_ALT"
+			then
+				resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
+				while read alt
+				do
+					case "$alt" in 'bad alternate: '*) die "$alt";; esac
+					echo >&2 "Getting alternate: $alt"
+					rsync -av --ignore-existing --exclude info \
+						"$alt" "$GIT_OBJECT_DIRECTORY/" || exit
+				done
+				rm -f "$GIT_DIR/TMP_ALT"
+			fi
+			rsync_slurped_objects=t
+			}
+			;;
+		*)
+			# We will do git native transport with just one call later.
+			continue ;;
+		esac
 
-      append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+		append_fetch_head "$head" "$remote" \
+			"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
 
-  done
+	done
 
-  case "$remote" in
-  http://* | https://* | rsync://* )
-      ;; # we are already done.
-  *)
-    ( : subshell because we muck with IFS
-      IFS=" 	$LF"
-      (
-	  git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
-      ) |
-      while read sha1 remote_name
-      do
-	  case "$sha1" in
-	  failed)
-		  echo >&2 "Fetch failure: $remote"
-		  exit 1 ;;
-	  esac
-	  found=
-	  single_force=
-	  for ref in $refs
-	  do
-	      case "$ref" in
-	      +$remote_name:*)
-		  single_force=t
-		  not_for_merge=
-		  found="$ref"
-		  break ;;
-	      .+$remote_name:*)
-		  single_force=t
-		  not_for_merge=t
-		  found="$ref"
-		  break ;;
-	      .$remote_name:*)
-		  not_for_merge=t
-		  found="$ref"
-		  break ;;
-	      $remote_name:*)
-		  not_for_merge=
-		  found="$ref"
-		  break ;;
-	      esac
-	  done
-	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
-	  append_fetch_head "$sha1" "$remote" \
-		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
-      done
-    ) || exit ;;
-  esac
+	case "$remote" in
+	http://* | https://* | rsync://* )
+		;; # we are already done.
+	*)
+		( : subshell because we muck with IFS
+			IFS=" 	$LF"
+			(
+				git-fetch-pack $exec $keep "$remote" $rref || echo failed "$remote"
+			) |
+			while read sha1 remote_name
+			do
+				case "$sha1" in
+				failed)
+					echo >&2 "Fetch failure: $remote"
+					exit 1 ;;
+				esac
+				found=
+				single_force=
+				for ref in $refs
+				do
+					case "$ref" in
+					+$remote_name:*)
+						single_force=t
+						not_for_merge=
+						found="$ref"
+						break ;;
+					.+$remote_name:*)
+						single_force=t
+						not_for_merge=t
+						found="$ref"
+						break ;;
+					.$remote_name:*)
+						not_for_merge=t
+						found="$ref"
+						break ;;
+					$remote_name:*)
+						not_for_merge=
+						found="$ref"
+						break ;;
+					esac
+				done
+				local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
+				append_fetch_head "$sha1" "$remote" \
+					"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+			done
+		) || exit ;;
+	esac
 
 }
 
@@ -439,7 +440,7 @@ case ",$update_head_ok,$orig_head," in
 	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 	if test "$curr_head" != "$orig_head"
 	then
-	    git-update-ref \
+		git-update-ref \
 			-m "$rloga: Undoing incorrectly fetched HEAD." \
 			HEAD "$orig_head"
 		die "Cannot fetch into the current branch."
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 2fdcaf7..38122ad 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -2,36 +2,36 @@ #!/bin/sh
 #
 
 usage () {
-    echo >&2 "usage: $0 [--heads] [--tags] [-u|--upload-pack <upload-pack>]"
-    echo >&2 "          <repository> <refs>..."
-    exit 1;
+	echo >&2 "usage: $0 [--heads] [--tags] [-u|--upload-pack <upload-pack>]"
+	echo >&2 "          <repository> <refs>..."
+	exit 1;
 }
 
 die () {
-    echo >&2 "$*"
-    exit 1
+	echo >&2 "$*"
+	exit 1
 }
 
 exec=
 while case "$#" in 0) break;; esac
 do
-  case "$1" in
-  -h|--h|--he|--hea|--head|--heads)
-  heads=heads; shift ;;
-  -t|--t|--ta|--tag|--tags)
-  tags=tags; shift ;;
-  -u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|\
-  --upload-pac|--upload-pack)
-	shift
-	exec="--exec=$1"
-	shift;;
-  --)
-  shift; break ;;
-  -*)
-  usage ;;
-  *)
-  break ;;
-  esac
+	case "$1" in
+	-h|--h|--he|--hea|--head|--heads)
+		heads=heads; shift ;;
+	-t|--t|--ta|--tag|--tags)
+		tags=tags; shift ;;
+	-u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|\
+		--upload-pac|--upload-pack)
+		shift
+		exec="--exec=$1"
+		shift;;
+	--)
+		shift; break ;;
+	-*)
+		usage ;;
+	*)
+		break ;;
+	esac
 done
 
 case "$#" in 0) usage ;; esac
@@ -50,9 +50,9 @@ tmpdir=$tmp-d
 
 case "$peek_repo" in
 http://* | https://* )
-        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-            curl_extra_args="-k"
-        fi
+	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+		curl_extra_args="-k"
+	fi
 	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
 		echo "failed	slurping"
 	;;
-- 
1.4.1.1
