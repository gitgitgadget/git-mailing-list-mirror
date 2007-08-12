From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-send-email.perl: Add angle brackets to In-Reply-To if necessary
Date: Sun, 12 Aug 2007 10:02:47 +0200
Organization: Organization?!?
Message-ID: <85lkchqixk.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 10:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK8Pu-0000q1-JJ
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 10:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbXHLICw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 04:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbXHLICv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 04:02:51 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:33466 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbXHLICt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 04:02:49 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id E2C9F17FBAC
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 10:02:47 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id D2964114372
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 10:02:47 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id B0BEB3425EA
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 10:02:47 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 42D731C3C79D; Sun, 12 Aug 2007 10:02:47 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3934/Sun Aug 12 03:59:08 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55667>


Signed-off-by: David Kastrup <dak@gnu.org>
---
I have not actually tested this, but from staring at it intensively,
it should be correct.  One of the things that bit me when I tried
using this program.

 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 69559b2..877f74c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -309,7 +309,8 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	} while (!defined $_);
 
 	$initial_reply_to = $_;
-	$initial_reply_to =~ s/(^\s+|\s+$)//g;
+	$initial_reply_to =~ s/^\s+<?/</;
+	$initial_reply_to =~ s/>?\s+$/>/;
 }
 
 if (!$smtp_server) {
-- 
1.5.3.rc2.187.g9a1d2-dirty
