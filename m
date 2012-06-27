From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5 v2] git-remote-mediawiki: support File: import and export
Date: Wed, 27 Jun 2012 11:10:15 +0200
Message-ID: <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 27 11:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjoHB-0005rw-7l
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 11:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412Ab2F0JKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 05:10:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41216 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab2F0JKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 05:10:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5R99ltE020845
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:09:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGd-0003Nj-AM; Wed, 27 Jun 2012 11:10:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGd-0002dc-6U; Wed, 27 Jun 2012 11:10:31 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Jun 2012 11:09:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R99ltE020845
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341392994.43257@CUNYoCHkGKKlb9efsalnrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200707>

Changes since v1:
- Added forgotten Signed-Off-By
- UTF-8 related fixes
- Fix parsing of mediaimport configuration variable

Matthieu Moy (3):
  git-remote-mediawiki: don't compute the diff when getting commit
    message
  git-remote-mediawiki: don't "use encoding 'utf8';"
  git-remote-mediawiki: split get_mw_pages into smaller functions

NGUYEN Kim Thuat (1):
  git-remote-mediawiki: send "File:" attachments to a remote wiki

Pavel Volek (1):
  git-remote-mediawiki: import "File:" attachments

 contrib/mw-to-git/git-remote-mediawiki | 466 ++++++++++++++++++++++++++++-----
 1 file changed, 402 insertions(+), 64 deletions(-)

-- 
1.7.11.5.g0c7e058.dirty
