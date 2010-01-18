From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 0/2] Branch --set-upstream
Date: Mon, 18 Jan 2010 22:44:10 +0200
Message-ID: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 21:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWySV-0005en-F1
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 21:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab0ARUoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548Ab0ARUoT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 15:44:19 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53291 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0ARUoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 15:44:18 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id A5D1818CFEA;
	Mon, 18 Jan 2010 22:44:17 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02DDA84BFE; Mon, 18 Jan 2010 22:44:17 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 6EB81158A74;
	Mon, 18 Jan 2010 22:44:13 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137401>

This adds new switch --set-upstream that can set upstream information
on existing branch branch without changing where the branch points
to.

push --set-upstream doesn't help if user doesn't have push priviledges
or if user is not up to date with upstream. Forcing branch recreate
is not possible if user has own patches appiled to the branch.

This series is edited version of Matthieu Moy's branch --track patch
series. The first patch is edited, the second is resent as-is.

Ilari Liusvaara (1):
  Add branch --set-upstream

Matthieu Moy (1):
  branch: warn and refuse to set a branch as a tracking branch of
    itself.

 Documentation/git-branch.txt |    8 ++++++-
 branch.c                     |   45 ++++++++++++++++++++++++++++++-----------
 builtin-branch.c             |    2 +
 cache.h                      |    1 +
 t/t6040-tracking-info.sh     |   21 +++++++++++++++++++
 5 files changed, 64 insertions(+), 13 deletions(-)
