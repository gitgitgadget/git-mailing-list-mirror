From: Gerrit Pape <pape@smarden.org>
Subject: cogito: cannot add dangling symlinks whereas git can
Date: Mon, 2 Jan 2006 12:15:17 +0000
Message-ID: <20060102120912.13409.qmail@c3aed7b85ae352.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 02 13:09:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtOUh-0003Xz-IW
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 13:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWABMIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jan 2006 07:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWABMIw
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jan 2006 07:08:52 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:63154 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751020AbWABMIw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2006 07:08:52 -0500
Received: (qmail 13410 invoked by uid 1000); 2 Jan 2006 12:09:12 -0000
To: git@vger.kernel.org, 313596@bugs.debian.org,
	313596-submitter@bugs.debian.org
Mail-Followup-To: git@vger.kernel.org, 313596@bugs.debian.org,
	313596-submitter@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14140>

forwarded 313596 upstream
quit

Hi, cg-add refuses to add special files such as dangling symlinks while
git can handle them just fine.  Please see http://bugs.debian.org/313596

I'm not sure why cg-add checks files to commit with test -f.

Regards, Gerrit.

---
diff --git a/cg-add b/cg-add
index 33cdc7f..382f8d5 100755
--- a/cg-add
+++ b/cg-add
@@ -61,9 +61,6 @@ for file in "${ARGS[@]}"; do
 			echo "$file is a directory (use cg-add -r?)" >&2
 			error=1
 		fi
-	elif [ ! -f "$absfile" ]; then
-		echo "$file does not exist or is not a regular file" >&2
-		error=1
 	else
 		echo "$file" >>"$TMPFILE"
 	fi
