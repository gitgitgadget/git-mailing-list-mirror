From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: don't offer remote transport helpers as subcommands
Date: Fri, 22 Jan 2010 11:54:51 +0100
Message-ID: <1264157691-27187-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 11:55:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYHAn-000865-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 11:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab0AVKzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2010 05:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788Ab0AVKzV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 05:55:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49172 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab0AVKzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 05:55:20 -0500
Received: from [127.0.1.1] (p5B130DD1.dip0.t-ipconnect.de [91.19.13.209])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LuHCt-1O00y40b5T-011mcD; Fri, 22 Jan 2010 11:55:07 +0100
X-Mailer: git-send-email 1.6.6.1.361.gc5121
X-Provags-ID: V01U2FsdGVkX185ZfGPDZjwEsg8CSzq8C0m/rxGm1+thfWXMZJ
 MzR/xwvkBjYJunC8blIGtKOObN44qPntruXBV7bxuKINchjqb/
 mQJdH/Ac4etQaloWw+Hng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137754>

Since commits a2d725b7 (Use an external program to implement fetching
with curl, 2009-08-05) and c9e388bb (Make the
"traditionally-supported" URLs a special case, 2009-09-03) remote
transport helpers like 'remote-ftp' and 'remote-curl' are offered by th=
e
completion script as available subcommands.  Not good, since they are
helpers, therefore should not be offered, so filter them out.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Maybe maint-worthy?  1.6.5 was the first release with this bug, but
nobody complained since then.

 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 9651720..7def62c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -568,6 +568,7 @@ __git_list_porcelain_commands ()
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
 		reflog)           : plumbing;;
+		remote-*)         : transport;;
 		repo-config)      : deprecated;;
 		rerere)           : plumbing;;
 		rev-list)         : plumbing;;
--=20
1.6.6.1.361.gc5121
