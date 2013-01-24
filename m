From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-cvsimport.txt: cvsps-2 is deprecated
Date: Thu, 24 Jan 2013 19:18:45 +0000
Message-ID: <20130124191845.GS7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
 <7vip6ndveb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySUQ-0006Yf-50
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab3AXT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:29:11 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42472 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab3AXT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:29:09 -0500
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2013 14:29:09 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C227B23096;
	Thu, 24 Jan 2013 19:18:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqx2akcUD8fE; Thu, 24 Jan 2013 19:18:53 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 0C01A22F2A;
	Thu, 24 Jan 2013 19:18:47 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip6ndveb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214442>

git-cvsimport relies on version 2 of cvsps and does not work with the
new version 3.  Since cvsps 3.x does not currently work as well as
version 2 for incremental import, document this fact.

Specifically, there is no way to make new git-cvsimport that supports
cvsps 3.x and have a seamless transition for existing users since cvsps
3.x needs a time from which to continue importing and git-cvsimport does
not save the time of the last import or import into a specific namespace
so there is no safe way to calculate the time of the last import.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Wed, Jan 23, 2013 at 09:04:12PM -0800, Junio C Hamano wrote:
> Care to roll a proper patch with a log message?  I'll discard the
> topic for now and replace it with your documentation update.

Here it is.

 Documentation/git-cvsimport.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 9d5353e..f059ea9 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -18,6 +18,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
+deprecated; it does not work with cvsps version 3 and later.  If you are
+performing a one-shot import of a CVS repository consider using
+link:http://cvs2svn.tigris.org/cvs2git.html[cvs2git] or
+link:https://github.com/BartMassey/parsecvs[parsecvs].
+
 Imports a CVS repository into git. It will either create a new
 repository, or incrementally import into an existing one.
 
-- 
1.8.1
