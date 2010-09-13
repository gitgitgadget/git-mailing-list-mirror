From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 04/12] gettextize: git-submodule die + eval_gettext messages
Date: Mon, 13 Sep 2010 22:09:10 +0000
Message-ID: <1284415758-20931-5-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEB-0006xe-Io
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab0IMWKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0IMWKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:05 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so393266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mIM+6UiB05G/dP/g5NhIsCjTK407e4fX9oHrr39/WH4=;
        b=ATPlkiuTyOZac+UAQZCuPmcuZNWgWT+8t8iFH3m05jb/0emulpKlBysANImMNOXl/c
         HeH/rI6ZnNmlVcFNTfpcnzsSD23Aiu0f72vRd5AQGsCdcmZMUob+t0tEQKWXys2Eefnk
         5cMwGixOTdhgBdkoGK4l+J/tic5nvNH+EZpw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P1cPQn1ypeDuY5uwYyyVbuLodsrHy0ErxKIuIuj3b4c5Una7x8iikCcx8k9YyKnygV
         IvyVe14vBB/hqputZQ9DbyvGa89GXYKcyeRFFWIFVckyGnqiHwOu8r7osgbrsKazQ2JS
         gsvmcO3ceiE/FpLqkQtb3cttApNrbHefKOvSc=
Received: by 10.216.175.12 with SMTP id y12mr3138695wel.61.1284415804929;
        Mon, 13 Sep 2010 15:10:04 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156137>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 086acdd..1b3132f 100755
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
 	while test -n "$url"
@@ -76,7 +76,7 @@ module_name()
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
@@ -102,11 +102,11 @@ module_clone()
 	if test -d "$path"
 	then
 		rmdir "$path" 2>/dev/null ||
-		die "Directory '$path' exists, but is neither empty nor a git reposi=
tory"
+		die "$(eval_gettext "Directory '\$path' exists, but is neither empty=
 nor a git repository")"
 	fi
=20
 	test -e "$path" &&
-	die "A file already exist at path '$path'"
+	die "$(eval_gettext "A file already exist at path '\$path'")"
=20
 	if test -n "$reference"
 	then
@@ -114,7 +114,7 @@ module_clone()
 	else
 		git-clone -n "$url" "$path"
 	fi ||
-	die "Clone of '$url' into submodule path '$path' failed"
+	die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' fa=
iled")"
 }
=20
 #
@@ -187,7 +187,7 @@ cmd_add()
 		realrepo=3D$repo
 		;;
 	*)
-		die "repo URL: '$repo' must be absolute or begin with ./|../"
+		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin wi=
th ./|../")"
 	;;
 	esac
=20
@@ -204,7 +204,7 @@ cmd_add()
 			s|/*$||
 		')
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
-	die "'$path' already exists in the index"
+	die "$(eval_gettext "'\$path' already exists in the index")"
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
@@ -221,7 +221,7 @@ cmd_add()
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
@@ -244,16 +244,16 @@ cmd_add()
 			'') git checkout -f -q ;;
 			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
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
@@ -303,7 +303,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) ||
-			die "Stopping at '$path'; script returned non-zero status."
+			die "$(eval_gettext "Stopping at '\$path'; script returned non-zero=
 status.")"
 		fi
 	done
 }
@@ -346,7 +346,7 @@ cmd_init()
=20
 		url=3D$(git config -f .gitmodules submodule."$name".url)
 		test -z "$url" &&
-		die "No url found for submodule path '$path' in .gitmodules"
+		die "$(eval_gettext "No url found for submodule path '\$path' in .gi=
tmodules")"
=20
 		# Possibly a url relative to parent
 		case "$url" in
@@ -356,14 +356,14 @@ cmd_init()
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
@@ -453,7 +453,7 @@ cmd_update()
 		else
 			subsha1=3D$(clear_local_git_env; cd "$path" &&
 				git rev-parse --verify HEAD) ||
-			die "Unable to find current revision in submodule path '$path'"
+			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$path'")"
 		fi
=20
 		if ! test -z "$update"
@@ -473,7 +473,7 @@ cmd_update()
 			then
 				(clear_local_git_env; cd "$path" &&
 					git-fetch) ||
-				die "Unable to fetch in submodule path '$path'"
+				die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
 			fi
=20
 			case "$update_module" in
@@ -502,7 +502,7 @@ cmd_update()
 		if test -n "$recursive"
 		then
 			(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
-			die "Failed to recurse into submodule path '$path'"
+			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
 		fi
 	done
 }
@@ -793,7 +793,7 @@ cmd_status()
 				cd "$path" &&
 				cmd_status $orig_args
 			) ||
-			die "Failed to recurse into submodule path '$path'"
+			die "$(eval_gettext "Failed to recurse into submodule path '\$path'=
")"
 		fi
 	done
 }
--=20
1.7.3.rc1.220.gb4d42
