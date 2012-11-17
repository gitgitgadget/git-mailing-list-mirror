From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/5] completion: get rid of empty COMPREPLY assignments
Date: Sat, 17 Nov 2012 02:38:14 +0100
Message-ID: <1353116298-11798-2-git-send-email-felipe.contreras@gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXN2-0004Op-Vu
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab2KQBii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ixnPb/5BwlirDOym7ONZ+DAaFHUzKzVQXSMdT+zHz8=;
        b=xFQCcLMpgY3Ny48jg4d/Qrntjg/9e/p8fBBmd2VO1sSr7fzMKNaN0Z7Vt6CPJtGBOD
         mwd/Jb3RavX6BumNdzyq3/7EoPYpUFi8i76bAa2czwnhd5nn8SO4lP/Vl9oFlal8MjRW
         1kKhwTRwePf5/+A1bfjNBCpJLjIO0ubcrWZuXcGx0KCFeXhDbRGxkMng4fnvNTt5A4uo
         FBA3SamBRpFB+QcV2+rSHyRxNXzH198F/2Rkl+GZC9+KLW0V2KOfAP6X/oKjXBEfskJf
         fyAhoSVodCcMQ8HaiM2qVa9534zP3O14iVQvU3EzIGWnxJoXGlAdOrmG8oMdXKE5GR02
         /oyA==
Received: by 10.204.146.83 with SMTP id g19mr2792259bkv.33.1353116316603;
        Fri, 16 Nov 2012 17:38:36 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id hm4sm2003678bkc.7.2012.11.16.17.38.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:35 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209925>

There's no functional reason for those, the only purpose they are
supposed to serve is to say "we don't provide any words here", but even
for that it's not used consitently.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..7bdd6a8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -238,7 +238,6 @@ __gitcomp ()
 
 	case "$cur_" in
 	--*=)
-		COMPREPLY=()
 		;;
 	*)
 		local IFS=$'\n'
@@ -486,7 +485,6 @@ __git_complete_remote_or_refspec ()
 			case "$cmd" in
 			push) no_complete_refspec=1 ;;
 			fetch)
-				COMPREPLY=()
 				return
 				;;
 			*) ;;
@@ -502,7 +500,6 @@ __git_complete_remote_or_refspec ()
 		return
 	fi
 	if [ $no_complete_refspec = 1 ]; then
-		COMPREPLY=()
 		return
 	fi
 	[ "$remote" = "." ] && remote=
@@ -776,7 +773,6 @@ _git_am ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_apply ()
@@ -796,7 +792,6 @@ _git_apply ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_add ()
@@ -811,7 +806,6 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_archive ()
@@ -856,7 +850,6 @@ _git_bisect ()
 		__gitcomp_nl "$(__git_refs)"
 		;;
 	*)
-		COMPREPLY=()
 		;;
 	esac
 }
@@ -969,7 +962,6 @@ _git_clean ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_clone ()
@@ -993,7 +985,6 @@ _git_clone ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_commit ()
@@ -1027,7 +1018,6 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_describe ()
@@ -1158,7 +1148,6 @@ _git_fsck ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gc ()
@@ -1169,7 +1158,6 @@ _git_gc ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gitk ()
@@ -1246,7 +1234,6 @@ _git_init ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_ls_files ()
@@ -1265,7 +1252,6 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_ls_remote ()
@@ -1381,7 +1367,6 @@ _git_mergetool ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_merge_base ()
@@ -1397,7 +1382,6 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_name_rev ()
@@ -1567,7 +1551,6 @@ _git_send_email ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_stage ()
@@ -1680,7 +1663,6 @@ _git_config ()
 		return
 		;;
 	*.*)
-		COMPREPLY=()
 		return
 		;;
 	esac
@@ -2060,7 +2042,6 @@ _git_remote ()
 		__gitcomp "$c"
 		;;
 	*)
-		COMPREPLY=()
 		;;
 	esac
 }
@@ -2104,7 +2085,6 @@ _git_rm ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_shortlog ()
@@ -2173,8 +2153,6 @@ _git_stash ()
 		*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
 				__gitcomp "$subcommands"
-			else
-				COMPREPLY=()
 			fi
 			;;
 		esac
@@ -2187,14 +2165,12 @@ _git_stash ()
 			__gitcomp "--index --quiet"
 			;;
 		show,--*|drop,--*|branch,--*)
-			COMPREPLY=()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
 			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
-			COMPREPLY=()
 			;;
 		esac
 	fi
@@ -2311,7 +2287,6 @@ _git_svn ()
 			__gitcomp "--revision= --parent"
 			;;
 		*)
-			COMPREPLY=()
 			;;
 		esac
 	fi
@@ -2336,13 +2311,10 @@ _git_tag ()
 
 	case "$prev" in
 	-m|-F)
-		COMPREPLY=()
 		;;
 	-*|tag)
 		if [ $f = 1 ]; then
 			__gitcomp_nl "$(__git_tags)"
-		else
-			COMPREPLY=()
 		fi
 		;;
 	*)
-- 
1.8.0
