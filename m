From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v4 0/3] git-remote-fd & git-remote-ext
Date: Mon,  4 Oct 2010 14:04:15 +0300
Message-ID: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 12:59:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2il6-0006jn-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 12:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0JDK6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 06:58:40 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:48924 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab0JDK6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 06:58:39 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id E89408C641
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 13:58:37 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00883B9B5E; Mon, 04 Oct 2010 13:58:37 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id AE46C1C638A
	for <git@vger.kernel.org>; Mon,  4 Oct 2010 13:58:36 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158027>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...

Changes from last time:
* Refactor the transfer loop quite a bit.
* Change the "format character" in remote-ext from '\' to '%'.
* Some code changes in remote-fd.
* Documentation changes for remote-fd.

Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 .gitignore                       |    2 +
 Documentation/git-remote-ext.txt |  119 ++++++++++++++
 Documentation/git-remote-fd.txt  |   59 +++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-ext.c             |  243 ++++++++++++++++++++++++++++
 builtin/remote-fd.c              |   80 ++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  324 ++++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 11 files changed, 839 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c

-- 
1.7.3.1.48.g63ac7.dirty
