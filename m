From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] stash: suggest the correct command line for unknown options.
Date: Fri,  5 Mar 2010 17:14:53 +0100
Message-ID: <1267805693-25206-1-git-send-email-Matthieu.Moy@imag.fr>
References: <4B910736.7060604@syntevo.com>
Cc: Thomas Singer <thomas.singer@syntevo.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 05 17:18:37 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnaEX-0001lt-9r
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 17:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab0CEQSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 11:18:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:56904 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab0CEQSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 11:18:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o25GF2Pk015631
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Mar 2010 17:15:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NnaB4-0002PX-0D; Fri, 05 Mar 2010 17:15:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NnaB3-0006Z8-Qg; Fri, 05 Mar 2010 17:15:01 +0100
X-Mailer: git-send-email 1.7.0.231.g9fa6.dirty
In-Reply-To: <4B910736.7060604@syntevo.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Mar 2010 17:15:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141586>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> > Does SmartGit call 'git stash save' behind the scenes with the
> > user-supplied message? Then it should run
> > 
> >   git stash save -- "$msg"
> > 
> > and you don't need to forbid anything.
> 
> Thank you very much, this solved the problem.

... unless one considers that the problem is that you had to ask.
Something like this should avoid others the problem.

 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 2d69196..cf4e673 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -151,6 +151,7 @@ save_stash () {
 			;;
 		-*)
 			echo "error: unknown option for 'stash save': $1"
+			echo "       To provide a message, use 'git stash -- $1'."
 			usage
 			;;
 		*)
-- 
1.7.0.231.g9fa6.dirty
