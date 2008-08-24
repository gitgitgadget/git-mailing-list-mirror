From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] Documentation: clarify pager.<cmd> configuration
Date: Sun, 24 Aug 2008 00:38:06 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808240028450.28567@harper.uchicago.edu>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
 <7vvdxs2t03.fsf@gitster.siamese.dyndns.org> <87k5e8i18c.fsf@cup.kalibalik.dk>
 <Pine.GSO.4.62.0808240019050.28567@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sun Aug 24 07:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX8Jp-0001um-Ah
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 07:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbYHXFiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 01:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYHXFiL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 01:38:11 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:41627 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYHXFiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 01:38:11 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7O5c7Dd013132;
	Sun, 24 Aug 2008 00:38:07 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7O5c6O5028972;
	Sun, 24 Aug 2008 00:38:06 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808240019050.28567@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93519>

It was not obvious from the text that pager.<cmd> is a boolean
setting.

While we're changing the description, make some other
improvements: lest we forget and fret, clarify that -p and
pager.<cmd> do not kick in when stdout is not a tty; point to
related core.pager and GIT_PAGER settings; use renamed --paginate
option.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 This is not related to the core.pager documentation patch I just
 sent; it just caught my eye as I was reading over the file.

 Documentation/config.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 88638f7..b12e695 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -988,9 +988,11 @@ pack.packSizeLimit::
 	linkgit:git-repack[1].
 
 pager.<cmd>::
-	Allows to set your own pager preferences for each command, overriding
-	the default. If `\--pager` or `\--no-pager` is specified on the command
-	line, it takes precedence over this option.
+	Allows turning on or off pagination of the output of a
+	particular git subcommand when outputing to a tty.  If
+	`\--paginate` or `\--no-pager` is specified on the command line,
+	it takes precedence over this option.  To disable pagination for
+	all commands, set `core.pager` or 'GIT_PAGER' to "`cat`".
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
-- 
1.6.0.481.g9ef3
