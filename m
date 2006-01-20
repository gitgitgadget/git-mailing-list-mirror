From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] fix generation of "humanish" part of source repo
Date: Fri, 20 Jan 2006 17:16:19 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060120161619.GA13469@informatik.uni-freiburg.de>
References: <20060120064739.GA2306@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 17:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezywb-0003Aq-Ok
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 17:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWATQQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWATQQX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 11:16:23 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:16559 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751054AbWATQQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 11:16:22 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Ezyw1-0001Yg-3F
	for git@vger.kernel.org; Fri, 20 Jan 2006 17:16:21 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0KGGJxJ013576
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 17:16:20 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0KGGJe3013575
	for git@vger.kernel.org; Fri, 20 Jan 2006 17:16:19 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060120064739.GA2306@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14968>

Hello,

I resent this patch against (a more) current HEAD:

If repo has the form <host>:<path> and <path> doesn't contain a slash, the
cloned repository is named "<host>:<path>", instead of "<path>" only.

Signed-off-by: Uwe Zeisberger <zeisberg@cepheus.pub>

---

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

300d15b114323292c25259ce68b25cf1fb5769e2
diff --git a/git-clone.sh b/git-clone.sh
index 168eb96..ded4085 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -99,7 +99,7 @@ fi
 
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
-[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*/||g')
+[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 [ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
-- 
1.0.8

Best regards
Uwe

-- 
Uwe Zeisberger

main(){char*a="main(){char*a=%c%s%c;printf(a,34,a,34%c";printf(a,34,a,34
,10);a=",10);a=%c%s%c;printf(a,34,a,34,10);}%c";printf(a,34,a,34,10);}
