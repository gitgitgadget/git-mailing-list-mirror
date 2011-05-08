From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Sun,  8 May 2011 12:20:52 +0000
Message-ID: <1304857280-14773-21-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ307-0003rg-Bv
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1EHMWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1EHMVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:50 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=nAd36S1VBDHk+lvrOYWo64N3O9gay/wTIGi27g8XswA=;
        b=tx1oiWDxPNxgTAyFzdmMc2ptaBnXVGIAYCQc9YRInzuRGqA5uGzbq7s6IeODQzIdVZ
         mF/zzHbngv8MvxETTN0DTpNGZd0gRIVWcKV34tC0IZyJedPSY2T2kIcSJFDeKBQ1rMdC
         XeP7KSkhu0cAoWTA/fzB6GvwL6OD3QCpsjYz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lovkPT7kBfTcsCfRPFaO8uUI2Qt7N8l0Es+Uq9oCJzdhjtpTyAF/L6HmlfBNWR/D5U
         pRPTQRw1BRTjkdwgoCnu6eveyiztjjjbAaPg1hQoh+LRdu8jUEaU0iSP4JXTrOWdp8ko
         ggfFLuDLv+CQ+cXGGAYj2RBQn57TBunLWIl/Q=
Received: by 10.14.50.7 with SMTP id y7mr2915590eeb.83.1304857310250;
        Sun, 08 May 2011 05:21:50 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.49
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173122>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 52e604a..1c3d4ce 100755
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
@@ -105,7 +105,7 @@ module_name()
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
@@ -129,7 +129,7 @@ module_clone()
 	else
 		git-clone -n "$url" "$path"
 	fi ||
-	die "Clone of '$url' into submodule path '$path' failed"
+	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' fa=
iled")"
 }
=20
 #
@@ -202,7 +202,7 @@ cmd_add()
 		realrepo=3D$repo
 		;;
 	*)
-		die "repo URL: '$repo' must be absolute or begin with ./|../"
+		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin wi=
th ./|../")"
 	;;
 	esac
=20
@@ -219,7 +219,7 @@ cmd_add()
 			s|/*$||
 		')
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "'$path' already exists in the index"
+	die "$(eval_gettext "'\$path' already exists in the index")"
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
@@ -236,7 +236,7 @@ cmd_add()
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
@@ -259,16 +259,16 @@ cmd_add()
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
@@ -318,7 +318,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) ||
-			die "Stopping at '$path'; script returned non-zero status."
+			die "$(eval_gettext "Stopping at '\$path'; script returned non-zero=
 status.")"
 		fi
 	done
 }
@@ -361,7 +361,7 @@ cmd_init()
=20
 		url=3D$(git config -f .gitmodules submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		die "$(eval_gettext "No url found for submodule path '\$path' in .gi=
tmodules")"
=20
 		# Possibly a url relative to parent
 		case "$url" in
@@ -371,14 +371,14 @@ cmd_init()
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
@@ -474,7 +474,7 @@ cmd_update()
 		else
 			subsha1=3D$(clear_local_git_env; cd "$path" &&
 				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$path'")"
 		fi
=20
 		if ! test -z "$update"
@@ -498,7 +498,7 @@ cmd_update()
 				(clear_local_git_env; cd "$path" &&
 					((rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
-				die "Unable to fetch in submodule path '$path'"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
 			fi
=20
 			# Is this something we just cloned?
@@ -534,7 +534,7 @@ cmd_update()
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
@@ -831,7 +831,7 @@ cmd_status()
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
1.7.4.4
