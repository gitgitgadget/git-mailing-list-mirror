From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/8 v2] git-remote-mediawiki: fixes, optimizations, and progress report
Date: Mon, 16 Jul 2012 21:46:34 +0200
Message-ID: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrGB-0008DP-RY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2GPTrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:47:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56063 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab2GPTrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:47:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJj89U014855
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrFx-0001RE-Ll; Mon, 16 Jul 2012 21:46:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrFx-0008IG-Ff; Mon, 16 Jul 2012 21:46:57 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:45:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJj89U014855
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072709.95746@C6l+WmGn9g+Z661bTzjdyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201555>

Changes since v1: more explanations in commit message for "make
mediafiles export optional", and use --parents instead of --children
in "get rid of O(N^2) loop".

Matthieu Moy (8):
  git-remote-mediawiki: don't split namespaces with spaces
  git-remote-mediawiki: actually send empty comment when they're empty
  git-remote-mediawiki: make mediafiles export optional
  git-remote-mediawiki: get rid of O(N^2) loop
  git-remote-mediawiki: use --force when adding notes
  git-remote-mediawiki: show progress information when listing pages
  git-remote-mediawiki: show progress information when getting last
    remote revision
  git-remote-mediawiki: properly deal with invalid remote revisions

 contrib/mw-to-git/git-remote-mediawiki | 79 +++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 16 deletions(-)

-- 
1.7.11.2.258.g5ff3cdf.dirty
