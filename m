From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v8 0/3] git-remote-fd & git-remote-ext
Date: Tue, 16 Nov 2010 05:34:11 +0200
Message-ID: <1289878454-17192-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 04:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PICHr-0005Er-69
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 04:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256Ab0KPDck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 22:32:40 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:49149 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759226Ab0KPDcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 22:32:39 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id E345CEBCF6
	for <git@vger.kernel.org>; Tue, 16 Nov 2010 05:32:36 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02DB0D6DA3; Tue, 16 Nov 2010 05:32:36 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id D02FF27D82
	for <git@vger.kernel.org>; Tue, 16 Nov 2010 05:32:35 +0200 (EET)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161539>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...

Changes from last time:
* Some manpage formatting changes.
* Some manpage wording changes.
* Don't try to write outside buffers if all-whitespace command line is
received.
* Some code cleanups.


Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 .gitignore                       |    2 +
 Documentation/git-remote-ext.txt |  125 +++++++++++++++
 Documentation/git-remote-fd.txt  |   59 +++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-ext.c             |  246 +++++++++++++++++++++++++++++
 builtin/remote-fd.c              |   79 ++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  316 ++++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 11 files changed, 839 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c
