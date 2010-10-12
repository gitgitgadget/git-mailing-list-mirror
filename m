From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v7 0/3] git-remote-fd & git-remote-ext
Date: Tue, 12 Oct 2010 19:39:40 +0300
Message-ID: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 18:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5hmq-0005qQ-Iy
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 18:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811Ab0JLQdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 12:33:05 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:60768 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0JLQdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 12:33:03 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id B913A8C27D
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:01 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A071E0B1077; Tue, 12 Oct 2010 19:33:01 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id ADE6B2BD42
	for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:33:00 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158860>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...

Changes from last time:
* Some misc cleanups.
* Fix bug in transfer loop that manifests when remote end is socket and
tasks are implemented as processes.

Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 .gitignore                       |    2 +
 Documentation/git-remote-ext.txt |  125 +++++++++++++++
 Documentation/git-remote-fd.txt  |   59 +++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-ext.c             |  248 ++++++++++++++++++++++++++++++
 builtin/remote-fd.c              |   79 ++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  311 ++++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 11 files changed, 836 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c

-- 
1.7.3.1.53.g597b29.dirty
