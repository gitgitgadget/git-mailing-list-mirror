From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/5] Add contrib/stg-show-old: show old version of a patch.
Date: Fri, 05 Jan 2007 00:46:42 +0100
Message-ID: <20070104234642.13580.5841.stgit@gandelf.nowhere.earth>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJV-0004EC-1i
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbXADXrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbXADXrw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:47:52 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:50438 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030287AbXADXrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:47:51 -0500
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by postfix1-g20.free.fr (Postfix) with ESMTP id DCB6B746ADD
	for <git@vger.kernel.org>; Fri,  5 Jan 2007 00:47:50 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D0F68435A7;
	Fri,  5 Jan 2007 00:46:49 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIO-0001l2-IG; Fri, 05 Jan 2007 00:46:52 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35962>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-show-old |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-show-old b/contrib/stg-show-old
new file mode 100755
index 0000000..82692a7
--- /dev/null
+++ b/contrib/stg-show-old
@@ -0,0 +1,13 @@
+#!/bin/sh
+set -e
+
+# stg-show-old - mini helper to look at the previous version of a
+# patch (current one by default)
+
+# Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+[ "$#" -le 1 ] || { echo >&2 "Usage: $(basename $0) [<patch>]"; exit 1; }
+patch="$1"
+
+stg diff -r"${patch}//bottom.old".."${patch}//top.old"
