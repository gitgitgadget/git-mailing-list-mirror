From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-mail in sh
Date: Sat, 26 Nov 2005 12:12:48 -0800
Message-ID: <7vpsonp3r3.fsf@assigned-by-dhcp.cox.net>
References: <4386DD45.6030308@op5.se>
	<7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 21:13:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg6Pl-0008GT-E3
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKZUMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 15:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVKZUMu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 15:12:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58288 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750729AbVKZUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 15:12:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126201210.FJSC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 15:12:10 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43874935.2080804@op5.se> (Andreas Ericsson's message of "Fri, 25
	Nov 2005 18:26:13 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12786>

Subject: [PATCH] format-patch: output filename reported to stdout verbatim.

Prepending asterisk to the output was just adding noise, and
forcing scripts like git-send-mail proposed by Andreas Ericsson
do unnecessary work.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Andreas Ericsson <ae@op5.se> writes:

 > Junio C Hamano wrote:
 >
 >> ...  If the standard output from format-patch is useful like
 >> this, I would like to drop the '* ' prefix from it, so that you
 >> do not have to sed it out.
 >
 > I'll do that then. It doesn't really add any value anyways.

 Agreed, so I'll push this out in the next batch.

 git-format-patch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 9ccf8849fa9b522a344645c2f28f12ab036e30d5
51b3c00e9d95371a9ad202204f01c5981f241b20
diff --git a/git-format-patch.sh b/git-format-patch.sh
index bc56876..9b40880 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -268,7 +268,7 @@ do
     file=`printf '%04d-%stxt' $i "$title"`
     if test '' = "$stdout"
     then
-	    echo "* $file"
+	    echo "$file"
 	    process_one >"$outdir$file"
 	    if test t = "$check"
 	    then
@@ -279,7 +279,7 @@ do
 		:
 	    fi
     else
-	    echo >&2 "* $file"
+	    echo >&2 "$file"
 	    process_one
     fi
     i=`expr "$i" + 1`
---
@@GIT_VERSION@@
