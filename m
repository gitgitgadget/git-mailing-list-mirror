From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Tue, 22 May 2007 23:29:45 +0200
Message-ID: <20070522212945.GA8002@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 23:30:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqbvi-00078v-GU
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761531AbXEVVaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760400AbXEVVaB
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:30:01 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44587 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759639AbXEVV36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:29:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B1CAB9680CD;
	Tue, 22 May 2007 23:29:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2s8opNA+H92; Tue, 22 May 2007 23:29:45 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9BFD79680C7;
	Tue, 22 May 2007 23:29:45 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0ADE66DF823; Tue, 22 May 2007 23:27:56 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 810E862A5D; Tue, 22 May 2007 23:29:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48117>

... to ask for the usage string.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-revert.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index ea2f15b..7984aeb 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -61,6 +61,8 @@ static void parse_options(int argc, const char **argv)
 	}
 
 	arg = argv[argc - 1];
+	if (!strcmp(arg, "-h"))
+		usage(usage_str);
 	if (get_sha1(arg, sha1))
 		die ("Cannot find '%s'", arg);
 	commit = (struct commit *)parse_object(sha1);
-- 
1.5.2.rc3.800.ga489e-dirty

-- 
Jonas Fonseca
