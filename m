From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 00/10] send-email address management
Date: Tue, 30 Jun 2015 14:16:41 +0200
Message-ID: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTM-0005RW-8l
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbbF3MRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54643 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbbF3MRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGqUp020528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:16:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGrIX022733;
	Tue, 30 Jun 2015 14:16:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uT7-00050L-Qs; Tue, 30 Jun 2015 14:16:53 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 14:16:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCGqUp020528
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271416.10348@87OceHTKnc0HhOd6EJgpcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273043>

This is an almost unmodified resend of Remi's patch here:

http://thread.gmane.org/gmane.comp.version-control.git/271844/focus=272499

The last patches had trouble reaching the list, hopefully this will be
easier to apply. Two minor changes:

* Removed the Helped-by: Remi trailer in a message sent by the same
  Remi.

* Allow -> allow in the subject line of a patch.

No code change.

Remi Lespinet (10):
  t9001-send-email: move script creation in a setup test
  send-email: allow aliases in patch header and command script outputs
  t9001-send-email: refactor header variable fields replacement
  send-email: refactor address list process
  send-email: allow use of aliases in the From field of --compose mode
  send-email: minor code refactoring
  send-email: reduce dependencies impact on parse_address_line
  send-email: consider quote as delimiter instead of character
  send-email: allow multiple emails using --cc, --to and --bcc
  send-email: suppress meaningless whitespaces in from field

 Documentation/git-send-email.txt |  12 +--
 git-send-email.perl              |  50 ++++++-------
 perl/Git.pm                      |  67 +++++++++++++++++
 t/t9000-addresses.sh             |  30 ++++++++
 t/t9000/test.pl                  |  67 +++++++++++++++++
 t/t9001-send-email.sh            | 154 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 336 insertions(+), 44 deletions(-)
 create mode 100755 t/t9000-addresses.sh
 create mode 100755 t/t9000/test.pl

-- 
2.5.0.rc0.10.g7792c2a
