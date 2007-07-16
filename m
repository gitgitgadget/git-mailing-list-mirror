From: David Kastrup <dak@gnu.org>
Subject: [PATCH] (vc-git-annotate-command):  Make synchronous for now.
Date: Mon, 16 Jul 2007 02:05:48 +0200
Organization: Organization?!?
Message-ID: <46a0cbb79076aa55cbbef313e9561a4be1174a16.1184548803.git.dak@gnu.org>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 03:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAFUW-00073N-B9
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760578AbXGPBfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760953AbXGPBfI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:44986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759831AbXGPBfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 21:35:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAFUM-0003VP-Bq
	for git@vger.kernel.org; Mon, 16 Jul 2007 03:35:02 +0200
Received: from dslb-084-061-039-155.pools.arcor-ip.net ([84.61.39.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:35:02 +0200
Received: from dak by dslb-084-061-039-155.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-155.pools.arcor-ip.net
X-From-Line: 46a0cbb79076aa55cbbef313e9561a4be1174a16 Mon Sep 17 00:00:00 2001
In-Reply-To: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:3nd+quC5WXDwLXE9bbuYqJSe1jk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52622>

We need a test to figure out whether Emacs supports asynchronous
annotations (not yet available in CVS).

Signed-off-by: David Kastrup <dak@gnu.org>
---
 contrib/emacs/vc-git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index d7ad314..c3f30ad 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -185,7 +185,7 @@ Returns nil if not possible."
 Optional arg VERSION is a version to annotate from."
   (let ((coding-system-for-read git-commits-coding-system))
     (vc-do-command buffer
-		   'async
+		   0
 		   "git" file "blame"
 		   (or version "HEAD")
 		   "--")))
-- 
1.4.4.2
