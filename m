From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 11:35:02 +0400
Message-ID: <20070326073502.GD44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 09:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVjjV-00033h-CO
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 09:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXCZHfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 03:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXCZHfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 03:35:09 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:57860 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXCZHfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 03:35:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=P8+5n2XQ/IKoj5kN3eubZCZ9PWhR+fYgnWOahyp/T093W4cWtF/w0ZXT1PWdrlVO8kBnQfyl4Gf8hn+Va1zJ+rL/75JOIzvBU98qo5zJL/6jeoX5iODbYJJQvAjrlWTgos3w/tHR6c3PT4OYjdVyr3Utywz/pVqLkgtC0/X44mw=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVjjO-000BcZ-Ov for git@vger.kernel.org; Mon, 26 Mar 2007 11:35:07 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43120>

Remove unnecessary '-S' option that enabled less to chop long lines.
It used to provide some confusion at least for the 'git diff':
"Where are my long lines? Are they missed from the patch?".

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 pager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 5f280ab..2dca00e 100644
--- a/pager.c
+++ b/pager.c
@@ -62,7 +62,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "FRSX", 0);
+	setenv("LESS", "FRX", 0);
 	run_pager(pager);
 	die("unable to execute pager '%s'", pager);
 	exit(255);
-- 
1.5.0.3-dirty
