From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5] git-remote-mediawiki: support File: import and export
Date: Tue, 26 Jun 2012 18:04:28 +0200
Message-ID: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 26 18:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjYG9-0005yI-SA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 18:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758448Ab2FZQEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 12:04:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47092 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757003Ab2FZQEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 12:04:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5QG47QP013642
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2012 18:04:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYFw-0008Jg-JT; Tue, 26 Jun 2012 18:04:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYFw-0006eD-Ft; Tue, 26 Jun 2012 18:04:44 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 26 Jun 2012 18:04:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5QG47QP013642
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341331450.4102@mzi0F2trKTYiAun90vBvAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200653>

This is a rework of two patch series already discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/199877
http://thread.gmane.org/gmane.comp.version-control.git/200002

I've split the commits in smaller patches, hopefully they should be
easier to read and should address remarks already made.

This is built on top of mm/credential-plumbing which also touches
git-remote-mediawiki, but should apply to master too.

Matthieu Moy (3):
  git-remote-mediawiki: don't compute the diff when getting commit
    message
  git-remote-mediawiki: don't "use encoding 'utf8';"
  git-remote-mediawiki: split get_mw_pages into smaller functions

NGUYEN Kim Thuat (1):
  git-remote-mediawiki: send "File:" attachments to a remote wiki

Pavel Volek (1):
  git-remote-mediawiki: import "File:" attachments

 contrib/mw-to-git/git-remote-mediawiki | 453 ++++++++++++++++++++++++++++-----
 1 file changed, 390 insertions(+), 63 deletions(-)

-- 
1.7.11.5.g0c7e058.dirty
