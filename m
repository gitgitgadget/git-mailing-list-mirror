From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v3 0/3]  git-remote-fd & git-remote-ext
Date: Thu, 30 Sep 2010 20:06:59 +0300
Message-ID: <1285866422-23964-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 19:01:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MW2-0006h8-8P
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab0I3RBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 13:01:51 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:45121 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248Ab0I3RBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 13:01:50 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 9503CEBB11
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:48 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01F4E8FC10; Thu, 30 Sep 2010 20:01:48 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 859A62BD46
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 20:01:47 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157690>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...

Changes from last time:
* Actually include all needed files (oops)
* Lots of documentation wording changes and some minor code changes.

Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 .gitignore                       |    2 +
 Documentation/git-remote-ext.txt |  112 ++++++++++++++++
 Documentation/git-remote-fd.txt  |   57 ++++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-ext.c             |  261 ++++++++++++++++++++++++++++++++++++++
 builtin/remote-fd.c              |   76 +++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  254 +++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 11 files changed, 774 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c

-- 
1.7.3.1.48.g4fe83
