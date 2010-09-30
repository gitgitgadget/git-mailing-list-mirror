From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v2 0/3] git-remote-fd & git-remote-ext
Date: Thu, 30 Sep 2010 14:52:56 +0300
Message-ID: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 13:47:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HcE-0003MB-AV
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab0I3Lrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:47:49 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:45739 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0I3Lrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:47:49 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 87A93EC2D9
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:47 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07AD654FCC; Thu, 30 Sep 2010 14:47:47 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 6B0B04033
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 14:47:46 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157642>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...


Differences from last time:

* The mingw build patch is now included.
* Include some documentation.
* Patches squashed into more logical chunks instead of base and discrete
fixes.

Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 Documentation/git-remote-ext.txt |   87 +++++++++++++
 Documentation/git-remote-fd.txt  |   57 +++++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-fd.c              |   88 +++++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  254 ++++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 9 files changed, 498 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-fd.c

-- 
1.7.2.3.401.g919b6e
