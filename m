From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) v2 0/5] Add a customizable Tools menu.
Date: Sun, 16 Nov 2008 21:46:46 +0300
Message-ID: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 19:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mhH-0001g2-8P
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYKPSs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYKPSs4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:48:56 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:8153 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYKPSsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:48:55 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2494253fkq.5
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Hcyfp6q+kOwghzQfePHwaoSFkqpPehdffE8NxD77w/g=;
        b=CyKcX7ILIohUAD1nRQLp1DIRw0DpnfrSPE+dNmWE1HNvGA3VI39DmIil7QciAppuKX
         eq4J4kKt5QBMQLzWxPRLuthD+UIbGFPINyGyRPYi3wPWadBM7pI9kSW3dop/Bs3knGOz
         S8eJ9V2oeZ9VPA/iVOTYUUSuo7FLYHb1G7opM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dCarrDjEXdZIkSXmhtibKVHyK/T0iSwIbYnTaSZt1hw4ODmofuf4v/LqZMFoHBa0gU
         2s2yYbVg8f2uQQPIZBN+6N/DUksh6Bafwpmvfj9UGBBBjek5siOqpl2dXOFP9xOaGk3V
         /HiRlTXD3+M8v0LAaUe+3AZosftlXU+/AlLB0=
Received: by 10.181.59.19 with SMTP id m19mr802771bkk.91.1226861332596;
        Sun, 16 Nov 2008 10:48:52 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id z15sm3020368fkz.16.2008.11.16.10.48.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 10:48:51 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101150>

This series adds a customizable Tools menu, that can
be used to call any external commands from Git Gui.
It reduces the inconvenience of using tools like git-svn
with GUI, by removing the need to jump between the
terminal and the GUI even for simple actions. QGit
already has a similar feature.

UPDATES:

  1) Tweaked some of the text strings to make UI look better.
  2) Added auto-rescan functionality.

  Sorry for sending an incomplete WIP version 3 days ago.


SUMMARY:

    git-gui.sh        |   70 +++++++--
    lib/diff.tcl      |    6 +-
    lib/option.tcl    |   12 +-
    lib/tools.tcl     |  159 ++++++++++++++++++++
    lib/tools_dlg.tcl |  421 +++++++++++++++++++++++++++++++++++++++++++++++++++++
    5 files changed, 643 insertions(+), 25 deletions(-)


PATCHES:

    git-gui: Implement system-wide configuration handling.
    ---
    git-gui.sh     |   12 +++++++++---
    lib/option.tcl |   12 ++++++------
    2 files changed, 15 insertions(+), 9 deletions(-)

  (NEW) git-gui: Fix the after callback execution in rescan.
    ---
    git-gui.sh   |   41 ++++++++++++++++++++++++++++-------------
    lib/diff.tcl |    6 +++---
    2 files changed, 31 insertions(+), 16 deletions(-)

    git-gui: Add a Tools menu for arbitrary commands.
    ---
    git-gui.sh        |   17 ++++
    lib/tools.tcl     |  108 ++++++++++++++++++++++++
    lib/tools_dlg.tcl |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
    3 files changed, 359 insertions(+), 0 deletions(-)
    create mode 100644 lib/tools.tcl
    create mode 100644 lib/tools_dlg.tcl

    git-gui: Allow Tools request arguments from the user.
    ---
    lib/tools.tcl     |   13 +++-
    lib/tools_dlg.tcl |  195 +++++++++++++++++++++++++++++++++++++++++++++++++++-
    2 files changed, 203 insertions(+), 5 deletions(-)

  (NEW) git-gui: Implement automatic rescan after Tool execution.
    ---
    lib/tools.tcl |   44 ++++++++++++++++++++++++++++++++++++++++++--
    1 files changed, 42 insertions(+), 2 deletions(-)
