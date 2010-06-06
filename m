From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] Gettext support for Git
Date: Sun,  6 Jun 2010 17:47:31 +0000
Message-ID: <1275846453-3805-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 19:48:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLJxK-0003Dh-54
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0FFRsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 13:48:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47442 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0FFRsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 13:48:07 -0400
Received: by fxm8 with SMTP id 8so1608532fxm.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=eaN2LGN4BYDM5T+U60TQh9V+lc29sStwuHX8FsK1ykE=;
        b=gjao3b+1L7PNWdy4OOE0VKp+5wpAAJl6msHoVp/yWR/4wR6GSGF8/ovv0qr6NiIBbq
         FdeeTfIOH/X0j7nulIQKidVBq1vDGYjUlgoPlomQmi46TdXHWX7Thq8a/onqvqwK+3nN
         nRGXySJfrOHPRGu2NPkuEvb23XLFLkSeO7418=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IRVzzyJVX5ptEzmQ7mw9TZ7h+7+6F5UzgRzUTTgLLrKzcr7qZr1AfHS/QxNHDVDT6D
         nIgmbE+4FtDPDrz3l5BihSUBKslPzyEE9X3NtMy2yaA8XzN9a1YgUL8dL0xZmIrlIqKh
         rpi6jicY6tU5ENoHjDL/2yiegFEmWOXEVXtoM=
Received: by 10.204.83.14 with SMTP id d14mr5953815bkl.50.1275846485432;
        Sun, 06 Jun 2010 10:48:05 -0700 (PDT)
Received: from aoeu.localdomain (pD9534641.dip.t-dialin.net [217.83.70.65])
        by mx.google.com with ESMTPS id v3sm15709527bkz.4.2010.06.06.10.48.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 10:48:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148530>

This patch series implements gettext support for git, making it
possible to localize it.

It been through 8 RFC iterations, gathering lots of changes along the
way. I think it's now ready to be submitted for inclusion.

This submission is exactly equivalent to the RFC v8, aside from
modifying the commit messages.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |    8 ++
 Makefile                     |   69 ++++++++++++++++++-
 config.mak.in                |    2 +
 configure.ac                 |   12 +++
 daemon.c                     |    3 +
 fast-import.c                |    3 +
 gettext.c                    |   21 ++++++
 gettext.h                    |   18 +++++
 git-pull.sh                  |   16 +++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   47 +++++++++++++
 git.c                        |    3 +
 http-backend.c               |    3 +
 http-fetch.c                 |    3 +
 http-push.c                  |    3 +
 imap-send.c                  |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 ++++-
 po/.gitignore                |    1 +
 po/is.po                     |   70 +++++++++++++++++++
 shell.c                      |    3 +
 show-index.c                 |    3 +
 t/t0200-gettext.sh           |  154 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   13 ++++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   42 +++++++++++
 t/t0202-gettext-perl.sh      |   20 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 upload-pack.c                |    3 +
 wt-status.c                  |  107 +++++++++++++++--------------
 34 files changed, 812 insertions(+), 65 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 git-sh-i18n.sh
 create mode 100644 perl/Git/I18N.pm
 create mode 100644 po/.gitignore
 create mode 100644 po/is.po
 create mode 100755 t/t0200-gettext.sh
 create mode 100644 t/t0200/test.c
 create mode 100644 t/t0200/test.perl
 create mode 100644 t/t0200/test.sh
 create mode 100755 t/t0201-gettext-fallbacks.sh
 create mode 100755 t/t0202-gettext-perl.sh
 create mode 100644 t/t0202/test.pl
