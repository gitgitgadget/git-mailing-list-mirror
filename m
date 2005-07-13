From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-stages: support "-u" as a synonym for "-p".
Date: Wed, 13 Jul 2005 12:45:06 -0700
Message-ID: <7vll4aze0t.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050712055218.GA18192@buici.com>
	<7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
	<20050712155316.GA5841@buici.com>
	<pan.2005.07.12.16.16.45.990714@smurf.noris.de>
	<loom.20050712T224801-163@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:55:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoFk-0000eN-BL
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVGMTsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGMTpj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 15:45:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11156 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262403AbVGMTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 15:45:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713194507.FUEO18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 15:45:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <loom.20050712T224801-163@post.gmane.org> (Junio C. Hamano's message of "Tue, 12 Jul 2005 20:51:17 +0000 (UTC)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just to be consistent, support "-u" as a synonym for "-p" like
everybody else does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-stages.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ef519b28e8edb19d4a0233152c9497ee807a4f5b
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -67,7 +67,7 @@ int main(int ac, const char **av)
 		const char *arg = av[1];
 		if (!strcmp(arg, "-r"))
 			; /* as usual */
-		else if (!strcmp(arg, "-p"))
+		else if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 			diff_output_format = DIFF_FORMAT_PATCH;
 		else if (!strncmp(arg, "-B", 2)) {
 			if ((diff_break_opt = diff_scoreopt_parse(arg)) == -1)
