From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] reset: add --quiet option
Date: Sun, 29 Nov 2009 12:58:10 +0200
Message-ID: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 11:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEhUF-0002wq-Im
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 11:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZK2K6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 05:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZK2K6S
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 05:58:18 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34929 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbZK2K6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 05:58:18 -0500
Received: by bwz27 with SMTP id 27so1911739bwz.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UNSV0mt6YcpJQtFgKYaM6q1vbifrRLsdH9vVXNVtG8I=;
        b=jMKDDeeBwtNpOgu6wTZNo62jFbKnSmIwXObtLStIYVk2dwAr2X04Wi6NmXawote6Ip
         RArtitCP4Ocfjecqu7y9ejUJUiMFGJGUn3u833jx4+AKTKWEtagtpsoz8JPqhCB7UKao
         6bfl756PPUZPpwK2iPEt7aDOBterKgKG1zc5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WpBY38a4jB8ypRlNARbUaNvilDMo7gobGOHThhZAxM1HU6ZPdsGmFMqsHPXlS0DzkC
         IIU696VW7h9cv7qTvU2UWTG6W82Sme1CH/ZwXVQaUgXIQn3dpRdx5ETvG2yTORyZ6h7h
         dbboa4EzKiFGUjTSm+3pUilSE7xabhOyqcioI=
Received: by 10.204.25.152 with SMTP id z24mr3164050bkb.44.1259492302157;
        Sun, 29 Nov 2009 02:58:22 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 14sm845286bwz.5.2009.11.29.02.58.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 02:58:20 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.63.g0471c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134010>

There's already -q, but --quiet is missing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-reset.txt |    1 +
 builtin-reset.c             |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2d27e40..9df6de2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -62,6 +62,7 @@ This means that `git reset -p` is the opposite of `git add -p` (see
 linkgit:git-add[1]).
 
 -q::
+--quiet::
 	Be quiet, only report errors.
 
 <commit>::
diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..c0127c4 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -209,7 +209,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
 				"reset HEAD, index and working tree", MERGE),
-		OPT_BOOLEAN('q', NULL, &quiet,
+		OPT_BOOLEAN('q', "quiet", &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
-- 
1.6.6.rc0.63.g0471c
