From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: text in --stat is colored like color.diff.plain
Date: Wed, 22 Apr 2009 23:13:49 +0200
Message-ID: <200904222313.50081.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjmP-00063F-DR
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbZDVVNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZDVVNM
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:13:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58112 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZDVVNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:13:11 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9EBFEFAF3957;
	Wed, 22 Apr 2009 23:13:10 +0200 (CEST)
Received: from [89.59.119.90] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lwjkk-0002Xq-00; Wed, 22 Apr 2009 23:13:10 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+vyiUv+77qfEc1tR15l3AvQSsWy3pGaTzWGDL/
	uh0sGanCoejmxmKqlm56yv6KXalTjxta5By/cxu0Zm5xQFdXGb
	GrlRC7ArUnbKQePUN/KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117261>

I noticed, that the filenames and the text "X files changed, Y
insertions(+), Z deletions(-)" in the --stat output ended with an ESC[m,
although they were not colored. Further investigation showed, that
these parts of the output indeed can use colors from color.diff.plain.

Is this intention? Commit 785f743 (diff --stat: color output.,
2006-09-26) introduced it, but only mentioned colored output of the
+++++++---- diffstat graph in the commit message. color.diff.plain is
documented for coloring context text and I don't think it looks good
either as it is now, nor is this really "context text".
Note: --shortstat and --summary don't use colors like --stat. Or is this
really intention and I don't see the reason for it?

If not, should we remove the colors for --stat?
After that maybe we could do some more color.diff.old/new coloring for
"Y insertions(+)", "Z deletions(-)", "create mode ...", "delete mode ..."

Markus
