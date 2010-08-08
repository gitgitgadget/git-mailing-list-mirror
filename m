From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 9/9] Documentation: git stash branch now tolerates non-stash references.
Date: Sun,  8 Aug 2010 14:46:11 +1000
Message-ID: <1281242771-24764-10-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxo6-00080Q-OE
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab0HHEsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:48:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53152 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab0HHEsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:48:15 -0400
Received: by pzk26 with SMTP id 26so3301207pzk.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=q4ZOiAAvSJ67NNHbCQVJzdSN/qgceKq/1jSepcxcryo=;
        b=dZ/CCV0TIgIgGNRlkmBmPZq7qOP+x0HPxIFhWngTirCxj0zxMFcTfX4qzHjj/KzhNY
         advAJrnn0/EZTfeiHyujhlalr8FwHrwh8GPIk160srQVMCGWiSrGSAR9UEEA1vcn1XIp
         MbdhdLumhl3wASJJEJyI4cSlfxpPPc2S+fGYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C9AwuCbcFgDIzT/adyDYzK6cm8DulTV54z+y03kSZl3HpaoDpTBf/VZLW9CfdmRAif
         UtecF98Xzyvhts27GLXDBUE3NbcCdbAHouRBP1HPXtPxm7XzXCLlm1YJMYjKhM2PSWEJ
         avYG6sR/d72CU19rG1JnwqipyQnjdCm6qlFE0=
Received: by 10.142.140.19 with SMTP id n19mr12179850wfd.271.1281242895082;
        Sat, 07 Aug 2010 21:48:15 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.48.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:48:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152892>

Update the documentation to indicate that git stash branch only attempts
to drop the specified stash if it looks like stash reference.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-stash.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..c7b7e4e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -115,8 +115,8 @@ branch <branchname> [<stash>]::
 	Creates and checks out a new branch named `<branchname>` starting from
 	the commit at which the `<stash>` was originally created, applies the
 	changes recorded in `<stash>` to the new working tree and index, then
-	drops the `<stash>` if that completes successfully. When no `<stash>`
-	is given, applies the latest one.
+	drops the `<stash>` if that completes successfully and `<stash>` looks like a
+	stash the name of a stash list entry. When no `<stash>` is given, applies the latest one.
 +
 This is useful if the branch on which you ran `git stash save` has
 changed enough that `git stash apply` fails due to conflicts. Since
-- 
1.7.2.1.51.g82c0c0
