From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 22 Apr 2013 11:40:47 +0200
Message-ID: <87vc7erjhc.fsf@linux-k42r.v.cablecom.net>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<7vmwsrqocu.fsf@alter.siamese.dyndns.org>
	<871ua2sy95.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUDF0-0002lq-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab3DVJku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:40:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:35523 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946Ab3DVJkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:40:49 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 11:40:47 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 11:40:47 +0200
In-Reply-To: <871ua2sy95.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Apr 2013 11:36:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222003>

Thomas Rast <trast@inf.ethz.ch> writes:

> -- >8 --
> Subject: [PATCH] git-log(1): remove --full-line-diff description

BTW, I generated this with your jc/format-patch, but it stopped working
after fc/send-email-annotate made it into next; I need this on top.  Am
I missing something?

-- >8 --
Subject: [PATCH] FIXUP jc/format-patch: adapt for fc/send-email-annotate

2a4c260 (format-patch: add format.coverLetter configuration variable,
2013-04-07) changed the coverletter variable to -1 by default, so the
die("... incompatible") always triggers.  Test if it is >0 instead.
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4804229..c972e62 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1247,7 +1247,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	/* Set defaults and check incompatible options */
 	if (rev.inline_single) {
 		use_stdout = 1;
-		if (cover_letter)
+		if (cover_letter > 0)
 			die(_("inline-single and cover-letter are incompatible."));
 		if (thread)
 			die(_("inline-single and thread are incompatible."));
-- 
1.8.2.1.844.g59e84de.dirty
