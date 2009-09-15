From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/4] bash: teach 'git checkout' options
Date: Tue, 15 Sep 2009 12:21:46 +0200
Message-ID: <7c8c4f6a4c581bcba101b8ca467d241738aa376e.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
	<0d125e60b97ab58ad51fef170fd36b707a271a10.1253009868.git.szeder@ira.uka.de>
	<ccf129a01115027ee7438ac47f1bc35631a1b2bb.1253009868.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVBE-0004gi-VK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbZIOKWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 06:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbZIOKWX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:22:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:61487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbZIOKWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:22:23 -0400
Received: from [127.0.1.1] (p5B131467.dip0.t-ipconnect.de [91.19.20.103])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MKt72-1MnVAr0Dnp-000gYc; Tue, 15 Sep 2009 12:22:14 +0200
X-Mailer: git-send-email 1.6.5.rc1.92.gee3c1
In-Reply-To: <ccf129a01115027ee7438ac47f1bc35631a1b2bb.1253009868.git.szeder@ira.uka.de>
In-Reply-To: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
References: <e927e4d3bfe50d93e5e6d65c46821158332b37f9.1253009868.git.szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX19ee+jYrhCJOrn/n4KA4eYbSeR5yvt+BNNT7tW
 AIaR4MrEN9lyz1qiubquZrBpmzKYwmsXrX8R6jlKJ+lGBA6PVb
 Zkks1MGbTQv+UX3/EkgiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128523>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8c268a1..8e3cdbd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -809,7 +809,18 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
=20
-	__gitcomp "$(__git_refs)"
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--quiet --ours --theirs --track --no-track --merge
+			--conflict=3D --patch
+			"
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
 }
=20
 _git_cherry ()
--=20
1.6.5.rc1.92.gee3c1
