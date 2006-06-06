From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] builtin-grep: pass ignore case option to external grep
Date: Tue, 6 Jun 2006 23:15:16 +0000
Message-ID: <20060606231516.GA18405@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 01:12:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkjB-0002kc-Tc
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 01:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFFXMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 19:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFFXMr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 19:12:47 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:51623 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751334AbWFFXMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 19:12:46 -0400
Received: from [193.203.134.52] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.42)
	id 1Fnkir-0007VP-HI
	for git@vger.kernel.org; Wed, 07 Jun 2006 00:12:29 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21413>

Don't just read the --ignore-case/-i option, pass the flag on to the
external grep program.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index acc4eea..5fac570 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -459,6 +459,8 @@ static int external_grep(struct grep_opt
 		push_arg("-n");
 	if (opt->regflags & REG_EXTENDED)
 		push_arg("-E");
+	if (opt->regflags & REG_ICASE)
+		push_arg("-i");
 	if (opt->word_regexp)
 		push_arg("-w");
 	if (opt->name_only)
-- 
1.3.3.g16a4-dirty
