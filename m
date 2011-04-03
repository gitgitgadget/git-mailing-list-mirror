From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 23/51] i18n: git-submodule die + eval_gettext messages
Date: Sun,  3 Apr 2011 16:45:47 +0000
Message-ID: <1301849175-1697-24-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSJ-00055g-MN
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab1DCQqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab1DCQqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=k0CJc1oE5pYjSyU1TWgSA0M0QTwx8QAbt4h811XnJ6U=;
        b=WcsJHn57Nb0ppduaXN9i+snPTZeQvWtblRi/pAC6LlzPWjxUoXB6im5BiwCkKNpkRf
         4x4Zicxt/3Cs9qoNvQ02I0QrUV9omulskSrgkZF5IwXyWiXa0mtHmuJ3Rgijze+Rjfiu
         Cfc5oEBDBEfjA3quvTKB4bafJGC3lBOtREYhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Z1Qz61WQzJ3n2jg9nYXuLvVn97wO7Jsla706DyMqrEdxcqY9bPOlnSSpQVMGCxFrzn
         M5PjkF/EkHN0lRkoIBWssg1AEFYcR08g8fKAYv6a9CLM47iKZmOuc08ukPhwFPupG7HY
         P6ft7/iwr7lkJmJPOTfnqJMzHCaRaFv20EnmM=
Received: by 10.14.32.13 with SMTP id n13mr3172029eea.21.1301849212351;
        Sun, 03 Apr 2011 09:46:52 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.51
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170718>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ba80b22..dcdda53 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -35,7 +35,7 @@ resolve_relative_url ()
 {
 	remote=3D$(get_default_remote)
 	remoteurl=3D$(git config "remote.$remote.url") ||
-		die "remote ($remote) does not have a url defined in .git/config"
+		die "$(eval_gettext "remote (\$remote) does not have a url defined i=
n .git/config")"
 	url=3D"$1"
 	remoteurl=3D${remoteurl%/}
 	sep=3D/
@@ -53,7 +53,7 @@ resolve_relative_url ()
 				sep=3D:
 				;;
 			*)
-				die "cannot strip one component off url '$remoteurl'"
+				die "$(eval_gettext "cannot strip one component off url '\$remoteu=
rl'")"
 				;;
 			esac
 			;;
@@ -88,7 +88,7 @@ module_name()
 	name=3D$( git config -f .gitmodules --get-regexp '^submodule\..*\.pat=
h$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
-       die "No submodule mapping found in .gitmodules for path '$path'=
"
+       die "$(eval_gettext "No submodule mapping found in .gitmodules =
for path '\$path'")"
        echo "$name"
 }
=20
@@ -112,7 +112,7 @@ module_clone()
 	else
 		git-clone -n "$url" "$path"
 	fi ||
-	die "Clone of '$url' into submodule path '$path' failed"
+	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' fa=
iled")"
 }
=20
 #
@@ -185,7 +185,7 @@ cmd_add()
 		realrepo=3D$repo
 		;;
 	*)
-		die "repo URL: '$repo' must be absolute or begin with ./|../"
+		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin wi=
th ./|../")"
 	;;
 	esac
=20
@@ -202,7 +202,7 @@ cmd_add()
 			s|/*$||
 		')
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "'$path' already exists in the index"
+	die "$(eval_gettext "'\$path' already exists in the index")"
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
@@ -219,7 +219,7 @@ cmd_add()
 		then
 			echo "$(eval_gettext "Adding existing repo at '\$path' to the index=
")"
 		else
-			die "'$path' already exists and is not a valid git repo"
+			die "$(eval_gettext "'\$path' already exists and is not a valid git=
 repo")"
 		fi
=20
 		case "$repo" in
@@ -242,16 +242,16 @@ cmd_add()
 			'') git checkout -f -q ;;
 			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
 			esac
-		) || die "Unable to checkout submodule '$path'"
+		) || die "$(eval_gettext "Unable to checkout submodule '\$path'")"
 	fi
=20
 	git add $force "$path" ||
-	die "Failed to add submodule '$path'"
+	die "$(eval_gettext "Failed to add submodule '\$path'")"
=20
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
 	git add --force .gitmodules ||
-	die "Failed to register submodule '$path'"
+	die "$(eval_gettext "Failed to register submodule '\$path'")"
 }
=20
 #
@@ -301,7 +301,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) ||
-			die "Stopping at '$path'; script returned non-zero status."
+			die "$(eval_gettext "Stopping at '\$path'; script returned non-zero=
 status.")"
 		fi
 	done
 }
@@ -344,7 +344,7 @@ cmd_init()
=20
 		url=3D$(git config -f .gitmodules submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		die "$(eval_gettext "No url found for submodule path '\$path' in .gi=
tmodules")"
=20
 		# Possibly a url relative to parent
 		case "$url" in
@@ -354,14 +354,14 @@ cmd_init()
 		esac
=20
 		git config submodule."$name".url "$url" ||
-		die "Failed to register url for submodule path '$path'"
+		die "$(eval_gettext "Failed to register url for submodule path '\$pa=
th'")"
=20
 		upd=3D"$(git config -f .gitmodules submodule."$name".update)"
 		test -z "$upd" ||
 		git config submodule."$name".update "$upd" ||
-		die "Failed to register update mode for submodule path '$path'"
+		die "$(eval_gettext "Failed to register update mode for submodule pa=
th '\$path'")"
=20
-		say "Submodule '$name' ($url) registered for path '$path'"
+		say "$(eval_gettext "Submodule '\$name' (\$url) registered for path =
'\$path'")"
 	done
 }
=20
@@ -449,7 +449,7 @@ cmd_update()
 		else
 			subsha1=3D$(clear_local_git_env; cd "$path" &&
 				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$path'")"
 		fi
=20
 		if ! test -z "$update"
@@ -469,7 +469,7 @@ cmd_update()
 			then
 				(clear_local_git_env; cd "$path" &&
 					git-fetch) ||
-				die "Unable to fetch in submodule path '$path'"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
 			fi
=20
 			# Is this something we just cloned?
@@ -505,7 +505,7 @@ cmd_update()
 		if test -n "$recursive"
 		then
 			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") =
||
-			die "Failed to recurse into submodule path '$path'"
+			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
 		fi
 	done
 }
@@ -797,7 +797,7 @@ cmd_status()
 				cd "$path" &&
 				eval cmd_status "$orig_args"
 			) ||
-			die "Failed to recurse into submodule path '$path'"
+			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
 		fi
 	done
 }
--=20
1.7.4.1
