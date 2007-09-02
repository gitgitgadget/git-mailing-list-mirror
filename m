From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Allow "stg add" when we have no stack
Date: Mon, 03 Sep 2007 01:59:04 +0200
Message-ID: <20070902235846.23778.11160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzLf-0000Nf-74
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbXIBX7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 19:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXIBX7T
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:59:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3527 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbXIBX7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:59:18 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IRzLO-0008Dj-00; Mon, 03 Sep 2007 00:59:06 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57407>

There's simply no reason not to allow this. It behaves just like
git-add, so it's well-defined enough.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/add.py |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/add.py b/stgit/commands/add.py
index 7f5a0b3..fc9c5a7 100644
--- a/stgit/commands/add.py
+++ b/stgit/commands/add.py
@@ -40,7 +40,4 @@ def func(parser, options, args):
     if len(args) < 1:
         parser.error('incorrect number of arguments')
=20
-    if not crt_series.get_current():
-        raise CmdException, 'No patches applied'
-
     git.add(args)
