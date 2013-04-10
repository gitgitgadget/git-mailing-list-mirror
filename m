From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/7] completion: get rid of empty COMPREPLY assignments
Date: Wed, 10 Apr 2013 01:57:52 -0500
Message-ID: <1365577077-12648-3-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPozw-0007M5-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3DJG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:59:08 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:52238 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3DJG7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:07 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so109823qaj.20
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fcbpyQOC8znUmdbt88lFkGPzLASsXXhJYkFmz5MJAgI=;
        b=GKwrnWapdl48j/Io8BrO34nPedqklKd9D9wpaZ2Sq2Dxw9e3vAzOkGmXFT4ROv4P4L
         IbBkfblThQ6wa6fwu+5ffF5Mjzj80WVEdrxqIgQuQNbV37UR9PuaqawuoCHk/uzWf0SG
         SkedkGOR/sfZq+O/XwPfmAh8AZBEOQh9uoPo0kI13i72bDYmKWDgdTQNyh32yHFOTgml
         RTR1HOxKhIHVnzw2V3NqHpfZ+cETILH76n3RBLO8HRubJx261Bgae3lWTD96pMndce9z
         2vAjjjUHGZGM8CIlHHtSuGqD5M/6wAAdui2+MVn6/CFj8xwqkO4Td9RCtT8gtGZrE98m
         agZQ==
X-Received: by 10.224.25.145 with SMTP id z17mr1152501qab.15.1365577146360;
        Tue, 09 Apr 2013 23:59:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id hm4sm29128002qab.2.2013.04.09.23.59.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220665>

There's no functional reason for those, the only purpose they are
supposed to serve is to say "we don't provide any words here", but even
for that it's not used consitently.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93eba46..2c87fd8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -208,7 +208,6 @@ __gitcomp ()
 
 	case "$cur_" in
 	--*=)
-		COMPREPLY=()
 		;;
 	*)
 		local IFS=$'\n'
@@ -614,7 +613,6 @@ __git_complete_remote_or_refspec ()
 			case "$cmd" in
 			push) no_complete_refspec=1 ;;
 			fetch)
-				COMPREPLY=()
 				return
 				;;
 			*) ;;
@@ -630,7 +628,6 @@ __git_complete_remote_or_refspec ()
 		return
 	fi
 	if [ $no_complete_refspec = 1 ]; then
-		COMPREPLY=()
 		return
 	fi
 	[ "$remote" = "." ] && remote=
@@ -951,7 +948,6 @@ _git_am ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_apply ()
@@ -971,7 +967,6 @@ _git_apply ()
 			"
 		return
 	esac
-	COMPREPLY=()
 }
 
 _git_add ()
@@ -1031,7 +1026,6 @@ _git_bisect ()
 		__gitcomp_nl "$(__git_refs)"
 		;;
 	*)
-		COMPREPLY=()
 		;;
 	esac
 }
@@ -1170,7 +1164,6 @@ _git_clone ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_commit ()
@@ -1354,7 +1347,6 @@ _git_fsck ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gc ()
@@ -1365,7 +1357,6 @@ _git_gc ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_gitk ()
@@ -1442,7 +1433,6 @@ _git_init ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_ls_files ()
@@ -1578,7 +1568,6 @@ _git_mergetool ()
 		return
 		;;
 	esac
-	COMPREPLY=()
 }
 
 _git_merge_base ()
@@ -1891,7 +1880,6 @@ _git_config ()
 		return
 		;;
 	*.*)
-		COMPREPLY=()
 		return
 		;;
 	esac
@@ -2272,7 +2260,6 @@ _git_remote ()
 		__gitcomp "$c"
 		;;
 	*)
-		COMPREPLY=()
 		;;
 	esac
 }
@@ -2388,8 +2375,6 @@ _git_stash ()
 		*)
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
 				__gitcomp "$subcommands"
-			else
-				COMPREPLY=()
 			fi
 			;;
 		esac
@@ -2402,14 +2387,12 @@ _git_stash ()
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
@@ -2526,7 +2509,6 @@ _git_svn ()
 			__gitcomp "--revision= --parent"
 			;;
 		*)
-			COMPREPLY=()
 			;;
 		esac
 	fi
@@ -2551,13 +2533,10 @@ _git_tag ()
 
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
1.8.2.1
