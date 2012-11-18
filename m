From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 2/8] completion: get rid of empty COMPREPLY assignments
Date: Sun, 18 Nov 2012 11:56:47 +0100
Message-ID: <1353236213-13471-3-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZC-0007rR-T1
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab2KRK5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KRK5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JUKKbhzz9xrHjGVHz1Iod0KLEQjQI0o+UJT0EgzSyr0=;
        b=VvkFqJDuwfJyucVu9vmd/lSrghvbvB+tEelYdskAvVDrKoHporXlF+A3xxkdTFp/UQ
         tc7ejNITmqp6Oob+fjMixFHY/DMolZkbfy+JNJGXOt80ZL80ScAThd71cFcKWyOSLM8e
         euS3vXKGWuVOnVsVcgqzVPo89yTNACWZYWWKhhXMktEgGGhLvWk9vp7A23HpTXqq9vfS
         Qhr72iIk0vY0qhyb5bYi6U4Mx921pvAkFmBmL/H5MNWoQaLyfBSiHK6O9MyCRP5pr1Dq
         LBEeC+2E3pZW7ibd49zHbBRZlS+3IHhZz5Yrc52JaVIejS4cml33EPEiaXLNyQAiqB0f
         4UQA==
Received: by 10.204.145.129 with SMTP id d1mr3754157bkv.31.1353236237591;
        Sun, 18 Nov 2012 02:57:17 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id go4sm2902835bkc.15.2012.11.18.02.57.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210015>

There's no functional reason for those, the only purpose they are
supposed to serve is to say "we don't provide any words here", but even
for that it's not used consitently.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc0657a..c2fb061 100644
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
@@ -1152,7 +1142,6 @@ _git_fsck ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gc ()
@@ -1163,7 +1152,6 @@ _git_gc ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gitk ()
@@ -1240,7 +1228,6 @@ _git_init ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_ls_files ()
@@ -1259,7 +1246,6 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_ls_remote ()
@@ -1375,7 +1361,6 @@ _git_mergetool ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_merge_base ()
@@ -1391,7 +1376,6 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_name_rev ()
@@ -1681,7 +1665,6 @@ _git_config ()
 		return
 		;;
 	*.*)
-		COMPREPLY=()
 		return
 		;;
 	esac
@@ -2061,7 +2044,6 @@ _git_remote ()
 		__gitcomp "$c"
 		;;
 	*)
-		COMPREPLY=()
 		;;
 	esac
 }
@@ -2105,7 +2087,6 @@ _git_rm ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_shortlog ()
@@ -2174,8 +2155,6 @@ _git_stash ()
 		*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
 				__gitcomp "$subcommands"
-			else
-				COMPREPLY=()
 			fi
 			;;
 		esac
@@ -2188,14 +2167,12 @@ _git_stash ()
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
@@ -2312,7 +2289,6 @@ _git_svn ()
 			__gitcomp "--revision= --parent"
 			;;
 		*)
-			COMPREPLY=()
 			;;
 		esac
 	fi
@@ -2337,13 +2313,10 @@ _git_tag ()
 
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
