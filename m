From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv4 0/4] Moving gitweb documentation to manpages
Date: Sun, 18 Sep 2011 15:34:40 +0200
Message-ID: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Sep 18 15:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5HWn-00027Y-A1
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 15:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab1IRNfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 09:35:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59914 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1IRNfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 09:35:15 -0400
Received: by fxe4 with SMTP id 4so3099867fxe.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7N7R46Ztc3fouJ8SIQyelu0B1fUjbHHE9ktsAjdQY/c=;
        b=P1xd9tVXfRIuz1LuWFJWvBBIebSTSEGZxDY/vwifyTAGV40cEc1o8ec7KcaxyKQKap
         cfvm4UoGYCzeTQnf30giOY/wFJUeTDiEkm8BRII7ymcQZbLmY+IATBmWknr0toKJ3Jum
         rLAVzBGrhdiOrT6Ui8/I+0EwKCfRnNA2u4IXo=
Received: by 10.223.8.2 with SMTP id f2mr3225839faf.23.1316352913718;
        Sun, 18 Sep 2011 06:35:13 -0700 (PDT)
Received: from localhost.localdomain (abvm199.neoplus.adsl.tpnet.pl. [83.8.210.199])
        by mx.google.com with ESMTPS id x22sm18322348faa.5.2011.09.18.06.35.10
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 06:35:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181605>

The original patch adding manpage for /etc/gitweb.conf was sent by
Drew Northup; I have added manpage for gitweb itself, inspired by his
patch.  Unfortunately Drew doesn't currently have time to work on this
patch (patch series), so that is why it is me resending this series.

It is closer to final version, but still is a bit work in progres.
The main improvement is that documentation now renders correctly as
HTML.

Note that we should probably add gitweb(1) and gitweb.conf(5) manpages
to the list in git(1) manpage.


Table of contents:
~~~~~~~~~~~~~~~~~~
1. The changes to Documentation/Makefile adding gitweb-doc target and
to gitweb/Makefile adding doc target are now upfront as a separate
patch, compared to previous version of this series:

  "[RFC/PATCHv3 0/5] Improving gitweb documentation, creating manpages"
  http://thread.gmane.org/gmane.comp.version-control.git/175140

This is mainly so that description of ideas, which is common for both
gitweb.conf.txt and gitweb.txt, is in a separate upfront commit
message.


2. The man page for /etc/gitweb.conf is modified, extended and
improved version of original patch by Drew Northup from

  "[PATCH/WIP] Starting work on a man page for /etc/gitweb.conf"
  http://thread.gmane.org/gmane.comp.version-control.git/173422

Drew version was mostly pulled directly from the README and INSTALL
files of gitweb.  I have tried to incorporate comments in mentioned
thread, and to group config variables by category.  This version
is also checked that it renders correctly as HTML and as manpage,
compared to version send earlier in

  "[RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)"
  http://thread.gmane.org/gmane.comp.version-control.git/175140/focus=175145

This version now moves, rather than copies, contents from
gitweb/README file.  It now has up-to-date commit message.

It was also updated to include new gitweb-comon.conf config file
(common system-wide config file, used *in addition to* per-instance
gitweb_config.perl config file).


3. The man page for gitweb is improved version of patch I have sent to
git mailing list as

  "[RFC/PATCHv3 5/5] gitweb: Starting work on a man page for gitweb (WIP)"
  http://thread.gmane.org/gmane.comp.version-control.git/175140/focus=175146
 
This version was fixed to render correctly as HTML and as manpage, and
has update commit message.


4. The addition of gitweb manpages to 'gitweb' subpackage in
gitweb.spec (via gitweb.spec.in) is new in this series.


Shortlog:
~~~~~~~~~
Drew Northup (1):
  gitweb: Add manpage for /etc/gitweb.conf (for gitweb documentation)

Jakub Narebski (3):
  Documentation: Preparation for gitweb manpages
  gitweb: Add manpage for gitweb
  gitweb: Add gitweb manpages to 'gitweb' package in git.spec

Diffstat:
~~~~~~~~~
 Documentation/Makefile        |    7 +-
 Documentation/gitweb.conf.txt |  789 +++++++++++++++++++++++++++++++++++++++++
 Documentation/gitweb.txt      |  703 ++++++++++++++++++++++++++++++++++++
 git.spec.in                   |    7 +
 gitweb/INSTALL                |   96 +-----
 gitweb/Makefile               |    7 +-
 gitweb/README                 |  411 ++--------------------
 7 files changed, 1540 insertions(+), 480 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt
 create mode 100644 Documentation/gitweb.txt

-- 
1.7.6
