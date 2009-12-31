From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [updated patch v3 0/2] Imporve remote helpers exec failure reporting
Date: Thu, 31 Dec 2009 20:26:41 +0200
Message-ID: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 19:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQPjV-0006Eg-Lk
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 19:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZLaS0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZLaS0p
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 13:26:45 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:34785 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZLaS0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 13:26:45 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 6221E8C1A0
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:44 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A002905F689; Thu, 31 Dec 2009 20:26:44 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 53B5C41BF4
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:43 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135961>

Changes from previous rounds are:

- Don't loop on unknown errors from close.
- Don't loop on unknown errors from waitpid.
- Set silent_exec_failure on remote helper exec.
- Fix the test to actually test what it is supposed to.

Ilari Liusvaara (2):
  Report exec errors from run-command
  Improve transport helper exec failure reporting

 Makefile               |    1 +
 run-command.c          |   97 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0061-run-command.sh |   13 ++++++
 test-run-command.c     |   35 +++++++++++++++++
 transport-helper.c     |   14 +++++--
 5 files changed, 152 insertions(+), 8 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c
