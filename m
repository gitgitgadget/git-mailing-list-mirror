From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Thu, 13 May 2010 16:24:35 +0200
Message-ID: <725860e3bfc692c7241695ef5f554ff73f277b15.1273760226.git.git@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:24:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZL8-0006Gl-Q8
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625Ab0EMOYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:24:39 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36523 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756814Ab0EMOYi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 10:24:38 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 42678F645C;
	Thu, 13 May 2010 10:24:38 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 10:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ObsH0nSQArIaeODCrTJfLbwUZXM=; b=tKXFsgAxIbgQfeWsdqYnBP8VRGhTBqum/Tw69BWWPPOkH7hnGPmF3jKvY5nZ7oUVSqxB7Am7SO78O+KRxRPJErPzZhqbPML1xODZB/J6weZNSSXHpXM9bR4Ejzsw6G300kQ7qgjrr4hA2dY9T4oCA69TsbG/F+wOgQqbJHJiSsA=
X-Sasl-enc: YlwOn5W1MQtAEEgVcsRE67qEO1hea/rPGV9rNlxGnLPf 1273760677
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F6B28478;
	Thu, 13 May 2010 10:24:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100505033536.GB8779@coredump.intra.peff.net>
In-Reply-To: <cover.1273760226.git.git@drmicha.warpmail.net>
References: <cover.1273760226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147009>

This command used to be used to distinguish between parameters meant
for rev-list and others, but this is deprectated now, and one should not
rely on rev-parse keeping up to date with rev-list. State this in the
man page and reword the title according to the primary use (converting
symbolic names to SHA1's).

Reference: <http://permalink.gmane.org/gmane.comp.version-control.git/146118>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-parse.txt |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8db600f..99d2a79 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -3,7 +3,7 @@ git-rev-parse(1)
 
 NAME
 ----
-git-rev-parse - Pick out and massage parameters
+git-rev-parse - Parse symbolic names into object names
 
 
 SYNOPSIS
@@ -13,12 +13,18 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Many git porcelainish commands take mixture of flags
+The primary use of 'git rev-parse' is to turn symbolic object names into
+40-letter object names ("SHA-1").
+
+Also, many git porcelainish commands take a mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
 meant for the underlying 'git rev-list' command they use internally
 and flags and parameters for the other commands they use
-downstream of 'git rev-list'.  This command is used to
-distinguish between them.
+downstream of 'git rev-list'.  This command used to be used to
+distinguish between them, but this is deprectated now, and you should
+not expect 'git rev-parse' to keep up to date with newer parameters for
+'git rev-list'. You can use linkgit:git-rev-list[1] directly or
+linkgit:git-for-each-ref[1] for scripting.
 
 
 OPTIONS
-- 
1.7.1.240.geeaa4d
