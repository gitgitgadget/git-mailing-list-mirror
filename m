From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 1/3] completion: get rid of empty COMPREPLY assignments
Date: Mon, 22 Oct 2012 03:45:40 +0200
Message-ID: <1350870342-22653-2-git-send-email-felipe.contreras@gmail.com>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ75o-0002p9-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788Ab2JVBp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:45:57 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58869 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab2JVBp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:45:56 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1181979wey.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ixnPb/5BwlirDOym7ONZ+DAaFHUzKzVQXSMdT+zHz8=;
        b=ta+MnaXjxQKi2bXD37MDL2HdLJLfT8ulnUAEbHZwKPiFdxHy8bfmU/fE5v9noQtrgI
         W6zwIJzioEaeoD4N9l9rFhwFEmTU0YBrpxKejRIcKHfwL6XFNszZeeZXpKsqeAXAFOfK
         LRWmtiYpLqZ7ONKJYGZln1J2ZVcMQgc16z4VMVNLIxxWYmmJw+vVZ8DbE11HVVXtHmhR
         d6mCwpQMaZVc10CzGUKRfQh7clpov7kl8rirUCqz8s/gi2a3/nKWdHzP6mzUAoOpVsHK
         8Q48rAKAjO3wFfdFmoHdaug5RFydEY/nRsJe+GhDXMaTVtnynTouQFlBEpiFkc218Ti/
         4ICw==
Received: by 10.216.85.212 with SMTP id u62mr4718428wee.185.1350870355601;
        Sun, 21 Oct 2012 18:45:55 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id cn6sm19139504wib.9.2012.10.21.18.45.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:45:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208171>

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
