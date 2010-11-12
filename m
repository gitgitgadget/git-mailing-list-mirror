From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v3] Documentation/git-pull: clarify configuration
Date: Fri, 12 Nov 2010 19:55:58 +0100
Message-ID: <1289588158-6869-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 13 01:56:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH4Pw-0001Mn-WA
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 01:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693Ab0KMA42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 19:56:28 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41538 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0KMA41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 19:56:27 -0500
Received: by qyk12 with SMTP id 12so1731020qyk.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 16:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=meFYNpcXMb52vSvORi9oi5FohI0CnFYqdwuLPHADbY4=;
        b=UvC9HG1SiJ811cY2/pJTHHfnfb9xO931Ctpzqc4rvjVyMnsSQELh28pyFGT+3lp6Ye
         etxDXngq1V78u2/45876tm7jVOuC/WMmoAaJqfwN4ohZMdoUfXqjtUB76aL2m64FmEhD
         DY/6nquNOcx1nFv2irfNSyPOcD2FG8W4waMI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hYEZtmYWZMABT4nJQ+aNSvwEqhZ2mtpMtHO57pjm/7JQQfWnhU+ZnRSosaqPDolesA
         88hiUHGSOnhVtEvB+YYOPmrWu3Cy0AbaChzipPw8Rd7stTLBqvc7366D1v7fuWQ0ivbv
         2mZYdwXA4EjlYjxEQ0z3aeY5PJi6fNwjo5kYs=
Received: by 10.224.179.131 with SMTP id bq3mr2761118qab.81.1289609786847;
        Fri, 12 Nov 2010 16:56:26 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id k15sm3505638qcu.35.2010.11.12.16.56.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 16:56:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161374>

The sentence about 'branch.<name>.rebase' refers to the first sentence
in the paragraph and not to the sentence about avoiding rebasing
non-local changes. Clarify this.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v2: Use the text provided by Junio and, consequently, it
actually generates valid documentation :-)

 Documentation/git-pull.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c50f7dc..e1b0bd2 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -92,12 +92,14 @@ include::merge-options.txt[]
 :git-pull: 1
 
 --rebase::
-	Instead of a merge, perform a rebase after fetching.  If
-	there is a remote ref for the upstream branch, and this branch
-	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes. To make this the default
-	for branch `<name>`, set configuration `branch.<name>.rebase`
-	to `true`.
+	Rebase the current branch on top of the upstream branch after
+	fetching.  If there is a remote-tracking branch corresponding to
+	the upstream branch and the upstream branch was rebased since last
+	fetched, the rebase uses that information to avoid rebasing
+	non-local changes.
++
+See `branch.<name>.rebase` in linkgit:git-config[1] if you want to make
+`git pull` always use `{litdd}rebase` instead of merging.
 +
 [NOTE]
 This is a potentially _dangerous_ mode of operation.
-- 
1.7.3.2.167.ga361b
