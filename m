From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH 0/8] Remote helpers smart transport extensions
Date: Tue,  8 Dec 2009 15:16:09 +0200
Message-ID: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 14:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHzvV-0005yD-An
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZLHNQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZLHNQN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:16:13 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:33944 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbZLHNQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:16:13 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id D3A0013BECB
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:18 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0612FC69A0; Tue, 08 Dec 2009 15:16:18 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B81F6E51A6
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:17 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134857>

This is rerolled version of remote helpers exensions. The changes
from RFC patch v3 are:

- Enable stream buffering where possible.
- Pass the connection directly, not indirected via disown method.
- "invoke/connect" -> "connect" in commit message.
- Don't try to send disconnect command after connecting.

This series is based on same version as appiled previous version is.

Ilari Liusvaara (8):
  Add remote helper debug mode
  Support mandatory capabilities
  Pass unknown protocols to external protocol handlers
  Refactor git transport options parsing
  Support taking over transports
  Support remote helpers implementing smart transports
  Support remote archive from external protocol helpers
  Remove special casing of http, https and ftp

 .gitignore                           |    4 +
 Documentation/git-remote-helpers.txt |   30 ++++-
 Makefile                             |   24 +++-
 builtin-archive.c                    |   17 ++-
 transport-helper.c                   |  291 ++++++++++++++++++++++++++++++----
 transport.c                          |  228 +++++++++++++++++++++------
 transport.h                          |   22 +++
 7 files changed, 523 insertions(+), 93 deletions(-)
