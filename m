From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Tue, 2 Jun 2009 20:35:29 +0200
Message-ID: <200906022035.30081.j6t@kdbg.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de> <20090602195533.6117@nanako3.lavabit.com> <7v7hzufxcu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	"Matthias Andree" <matthias.andree@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBYps-0006NU-TK
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 20:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbZFBSff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZFBSfe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 14:35:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55057 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZFBSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 14:35:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9308DCDF98;
	Tue,  2 Jun 2009 20:35:31 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0FFB45BCEB;
	Tue,  2 Jun 2009 20:35:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7hzufxcu.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120533>

On Dienstag, 2. Juni 2009, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> > Junio, I think you forgot to take a follow-up action on this thread after
> > sending this message.  The patch favors the git program in the current
> > directory.
>
> Indeed, I did, and I think I am Ok with the patch.  Thanks for a
> reminder.
>
> I thought there was an "simplicity" issue raised by J6t that was not
> addressed, but after re-reading the thread I do not think it applies
> (J6t?)

Sorry, I don't recall anymore what I said; but since the thread petered out, I 
use this patch in the repository where I share Matthias' 'sudo make install' 
problem:

Subject: [PATCH] version-gen: Use just built git if no other git is in PATH

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 39cde78..4779313 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,6 +3,9 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.6.3.GIT
 
+# use git that was just compiled if there is no git elsewhere in PATH
+PATH=$PATH:.
+
 LF='
 '
 

-- Hannes
