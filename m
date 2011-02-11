From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git-blame.el: format of date strings
Date: Fri, 11 Feb 2011 00:42:47 -0600
Message-ID: <20110211064247.GA26091@elie>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
 <20110204014315.GB28525@elie>
 <87tygkm8h7.fsf@krank.kagedal.org>
 <201102041103.10770.jnareb@gmail.com>
 <87r5bom7g3.fsf@krank.kagedal.org>
 <87oc6sm1ef.fsf@krank.kagedal.org>
 <20110211022928.GA24775@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Martin Nordholts <enselic@gmail.com>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 11 07:43:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnmic-0000sg-1U
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 07:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab1BKGm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 01:42:57 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47286 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1BKGm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 01:42:56 -0500
Received: by gwj20 with SMTP id 20so943917gwj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 22:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LIffWEKxlwYZ2i8NiQFvL6R9OFwSOIc2D9bqCVkxLI4=;
        b=mc6Gqb5vG2q4bwur5kAlMTFgPKuiiZbRbjsaleVrn4T3fkM3702d57eTymd8jbjSOc
         OCmJDofirVhWnvKPq2fCl1rwKTmgrJN2cK1R3IrMHytSK0Up6aj410JAmQ9bnjMaThMS
         szpQzaU9cSbyVq49TGMMD8NF2yRN97ExINRto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tuphjYjUBy+6H8amL0TAiYFqs93mLpzOl/rMluxHHT2Ob6fCZ4uSAs3r6KefdRJdzq
         OJKG12NofsSYbZcyAY9yBtKO+MfGn1Qvdu17EH1dcw2zQdv3s5kji+8WFAWQKMQo9yVO
         KWmFliz7SdzRlc+PGwltDjt6Q16odxg87LaI4=
Received: by 10.236.110.1 with SMTP id t1mr266385yhg.94.1297406575505;
        Thu, 10 Feb 2011 22:42:55 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id a11sm333718yhd.36.2011.02.10.22.42.52
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 22:42:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110211022928.GA24775@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166539>

Jonathan Nieder wrote:

>  - The time format (%c) is rather verbose.  I think I prefer %D
>    (so maybe this is a potential tweakable?).

Here's what that might look like.  Sadly, format-time-string does not
seem to have an equivalent to git log's %ar format.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/emacs/git-blame.el |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 9f60a6f..a43981e 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -121,6 +121,12 @@ mode. See `git-blame-format' for more information.
 `git-blame' mode. See `git-blame-format' for more information."
   :group 'git-blame)
 
+(defcustom git-blame-date-format
+  "%c"
+  "The format of dates specified with %t or %T passed to `git-blame-format'.
+See `format-time-string' for more information."
+  :group 'git-blame)
+
 (defun git-blame-format (info format)
   "Use format-spec to format the blame info in INFO with the following keys:
 
@@ -146,10 +152,10 @@ mode. See `git-blame-format' for more information.
                    (?H . ,(car info))
                    (?a . ,(git-blame-get-info info 'author))
                    (?A . ,(git-blame-get-info info 'author-mail))
-                   (?t . ,(format-time-string "%c" author-time))
+                   (?t . ,(format-time-string git-blame-date-format author-time))
                    (?c . ,(git-blame-get-info info 'committer))
                    (?C . ,(git-blame-get-info info 'committer-mail))
-                   (?T . ,(format-time-string "%c" committer-time))
+                   (?T . ,(format-time-string git-blame-date-format committer-time))
                    (?s . ,(git-blame-get-info info 'summary))))))
 
 (defun git-blame-color-scale (&rest elements)
-- 
1.7.4
