From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] User-friendly error messages for merge failure on fast-forward.
Date: Sun, 29 Nov 2009 13:18:31 +0100
Message-ID: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 13:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEijs-0003vA-Qc
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 13:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZK2MSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbZK2MSj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 07:18:39 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49678 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbZK2MSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 07:18:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nATCGjUj024865
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 29 Nov 2009 13:16:45 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEijg-00089M-D1; Sun, 29 Nov 2009 13:18:40 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEijg-0005J0-Af; Sun, 29 Nov 2009 13:18:40 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 29 Nov 2009 13:16:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nATCGjUj024865
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1260101805.75911@AA8KXqcQPiC8UE/y1OKejA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134015>

I noticed that failures of fast-forward merges were still using the
plumbing error message:

$ git merge master
Updating 1fdeef9..e248dad
error: Entry 'foo.txt' not uptodate. Cannot merge.

I'm not 100% sure that my patch doesn't trigger the porcelain behavior
for plumbing. Someone more familiar than me with the codebase should
confirm/infirm this.

Matthieu Moy (2):
  merge-recursive: make the error-message generation an extern function
  builtin-merge: show user-friendly error messages for fast-forward
    too.

 builtin-merge.c   |    1 +
 merge-recursive.c |   41 +++++++++++++++++++++++------------------
 merge-recursive.h |    3 +++
 3 files changed, 27 insertions(+), 18 deletions(-)
