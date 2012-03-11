From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5Bgsoc2012=20wiki=20PATCH=5D=20=22Graphical=20diff=20in=20git-gui=22=20project?=
Date: Sun, 11 Mar 2012 23:30:55 +0100
Message-ID: <1331505055-12231-1-git-send-email-jnareb@gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 23:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6rIM-0003qT-SE
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 23:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2CKWbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 18:31:05 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55522 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab2CKWbC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 18:31:02 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so2688158wej.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wNWpYjqcLp0bchr8J3vNaXCc7/WLxgoHI5MvAyjqFFE=;
        b=TTAwes1n2bNAaWtOvGXR0yBLu5y0pGzPMRpt5eN4oQ/BD6sqhXljoA3CA9i6N2M5qb
         Xam5Op2RwrLfl6yXcL+I3h4N/YumYabwk1Cjw4VTneipLuMK28KVZnbpoXbcVv+QbNqg
         vHRo6sYuCda+1hNPslY5CUwgCmSFogHfO/zG3ib7J6UioAp4+zRATsEorPYl5eq/owML
         Ju8vOLqSsOGeIHS1I6FQ5+bxGwq78oghAYKKlLCtktLxxQ50/yFis7oQOz5qm5+VLG/U
         nO/D5N1sdEM3M5qy66QOQ652QVUBZROSf10QkP1DUjc3k3CZd+OWY46VBh50SJFUFcw4
         D8jA==
Received: by 10.216.197.211 with SMTP id t61mr5999243wen.1.1331505061337;
        Sun, 11 Mar 2012 15:31:01 -0700 (PDT)
Received: from localhost.localdomain (abwj236.neoplus.adsl.tpnet.pl. [83.8.233.236])
        by mx.google.com with ESMTPS id fb2sm28449945wid.3.2012.03.11.15.30.59
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 15:31:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192833>

---
I don't have much hope that we can find a student that would be
interested in this feature and knows Tcl/Tk enough so that hs or she
can atually implement it...

But I can hope.

 SoC-2012-Ideas.md |   62 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 9ad449f..bea2c09 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -421,6 +421,68 @@ Write a tool that can be used for the task, and op=
tionally wrap an interactive U
 Programming language: Any =20
 Possible mentors: ??? =20
=20
+Graphical diff in git-gui
+-------------------------
+
+[git-gui] is a portable Tcl/Tk based graphical interface to Git,
+focused on commit generation and single file annotation.  It is part
+of Git, even though it is developed in a [separate repository].
+
+git-gui can show differences as syntax-highlighted unified diff.  The
+goal of this project would be to add graphical side-by-side diff.
+One possibility is to make use of [TkDiff] code (a graphical diff and
+merge tool), which is also GPL licensed.
+
+The project would consist of the following steps (not all must be
+implemented during Google Summer of Code):
+
+ * Add "git gui diff" subcommand, which would show single file
+   side-by-side graphical compare or/and graphical diff.
+
+   Graphical part and code for side-by-side compare (showing full
+   contents of both files) can be taken from TkDiff, while graphical
+   side-by-side diff (showing changes plus context) can be translated
+   from gitweb's side-by-side diff code.
+
+ * Integrate graphical diff with main git-gui application (including
+   switching between side-by-side and unified diff).
+
+ * Add highlighting of changes in diff both to side-by-side
+   (new code), and to unified diff (current code).
+
+   It can be done using code for TkDiff (perhaps with Git performing
+   word diff instead of doing it in Tcl), or/and using algorithm from
+   gitweb and diff-highlight in contrib.  The difference is that one
+   uses word diff or character diff to highlight changes, the other
+   just skips common prefix and suffix.
+
+ * Add graphical merge / graphical 3-way diff support.  Both are to be
+   used in case a file has textual conflicts; graphical merge also
+   includes resolving a merge by taking 'our' side, 'their' side (or
+   optionally also 'ancestor' side), or by editing merge result.
+
+ * Graphical side-by-side tree level diff, or side-by-side directory
+   listing with differences highlighted.
+
+   UI can be taken from two-panel filemanagers (like MC, or Total
+   Commander), or from synchronization tools (like e.g. Unison).
+
+   The difficulty can be in showing rename and copy detection results,
+   and in showing type (filemode) changes.
+
+The minimum would be to implement side-by-side diff or side-by-side
+compare of two files, without highlighting changes (diff refinement
+highlighting) in the form of separate "`git gui diff <file>`"
+command.
+
+[git-gui]: http://schacon.github.com/git/git-gui.html
+[separate repository]: http://repo.or.cz/w/git-gui.git
+[TkDiff]: http://freecode.com/projects/tkdiff
+
+Programming language: Tcl/Tk =20
+Proposed by: Jakub Nar=C4=99bski =20
+Possible mentor(s): Pat Thoyts, Paul Mackerras (?)
+
 Other sources of inspiration
 ----------------------------
=20
--=20
1.7.9
