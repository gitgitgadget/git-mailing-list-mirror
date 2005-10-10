From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git.sh: quote all paths
Date: Mon, 10 Oct 2005 11:32:54 +0200
Message-ID: <20051010093254.GD18009@diku.dk>
References: <20051010085259.GA18009@diku.dk> <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net> <20051010092638.GC18009@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 11:34:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOu1j-0000Jm-F2
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 11:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVJJJc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 05:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVJJJc4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 05:32:56 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:63736 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750704AbVJJJc4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 05:32:56 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 9D2DA6E1C2B; Mon, 10 Oct 2005 11:32:41 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 656246E1C0F; Mon, 10 Oct 2005 11:32:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 155EB60FBE; Mon, 10 Oct 2005 11:32:55 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051010092638.GC18009@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9882>

This makes it handle spaces in paths.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

Sorry I am so sloppy: s/.exe/@@X@@/ ...

diff --git a/git.sh b/git.sh
index 7400c16..b424055 100755
--- a/git.sh
+++ b/git.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 cmd=
-path=$(dirname $0)
+path=$(dirname "$0")
 case "$#" in
 0)	;;
 *)	cmd="$1"
@@ -12,13 +12,13 @@ case "$#" in
 		exit 0 ;;
 	esac
 	
-	test -x $path/git-$cmd && exec $path/git-$cmd "$@"
+	test -x "$path/git-$cmd" && exec "$path/git-$cmd" "$@"
 	
 	case '@@X@@' in
 	    '')
 		;;
 	    *)
-		test -x $path/git-$cmd@@X@@ && exec $path/git-$cmd@@X@@ "$@"
+		test -x "$path/git-$cmd.exe" && exec "$path/git-$cmd@@X@@" "$@"
 		;;
 	esac
 	;;
-- 
Jonas Fonseca
