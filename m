From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 0/2] Gettext support for Git
Date: Tue, 15 Jun 2010 19:33:50 +0000
Message-ID: <1276630432-13299-1-git-send-email-avarab@gmail.com>
References: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Wiegley <johnw@newartisans.com>,
	Graham Anderson <graham.anderson@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 21:34:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OObtq-0004te-6H
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 21:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0FOTeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 15:34:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61512 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab0FOTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 15:34:10 -0400
Received: by wwb18 with SMTP id 18so5094628wwb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=agZI7rYyDOryfwcQjD3/2xjshEUhp3LgOtjGZcs9q6Q=;
        b=OYiu4NR6RljM5bcsnuzSNgLd74UWkoKP6cS46ej6HhmLsXrZKpkySj9wB6ToD+vGbt
         cO/immKXhnBfVM1cxfowtD9O0S1ilzjiRqtzvvYvLz3df8Ecxqp5v6+/8uoigDPTgsnM
         G5kej0SM3mxB5xUuOBmvtcHyI9gm62zIVt7zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Fd598xEHlfnJS3nHZUqrsmmQxzFel57dVuQ8wgDbmQxs4NcVFFHEsg4nvk0aX5+WW1
         OVuthytPyPBgvYjmJEQBOnhSWkgG4ucxEeC088rV5ShK76vxXTLnvZ7lt8OVOqASl+iW
         Sqd7VB3T68o567dIFS51Qpug+W7TiNVx6F4HA=
Received: by 10.216.156.77 with SMTP id l55mr1281800wek.28.1276630447635;
        Tue, 15 Jun 2010 12:34:07 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm1965955wec.27.2010.06.15.12.34.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 12:34:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149216>

This patch series implements gettext support for git, making it
possible to localize it.

Changes since v3:

  * Skip tests that depend on is_IS locale unless
    TEST_GIT_GETTEXT_EXHAUSTIVE=3D1 is set.

    All the systems I'd tested on previously (FreeBSD, Solaris, Mac OS
    X, openSUSE, Debian, Ubuntu) had an Icelandic locale
    installed. Skip tests that depend on being able to set the locale.

    I've now added a bare-bones Debian system to my test setup. It
    failed on the same tests that Junio failed on.

Here's the git diff -w --stat since v3:

    t/t0200-gettext.sh |   16 ++++++++--------
    1 files changed, 8 insertions(+), 8 deletions(-)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Add infrastructure for translating Git with gettext
  Add initial C, Shell and Perl gettext translations

 .gitignore                   |    2 +
 INSTALL                      |   12 +++
 Makefile                     |   69 +++++++++++++++++-
 config.mak.in                |    2 +
 configure.ac                 |   12 +++
 daemon.c                     |    3 +
 fast-import.c                |    3 +
 gettext.c                    |   22 ++++++
 gettext.h                    |   18 +++++
 git-pull.sh                  |   16 ++--
 git-send-email.perl          |    3 +-
 git-sh-i18n.sh               |   71 ++++++++++++++++++
 git.c                        |    3 +
 http-backend.c               |    3 +
 http-fetch.c                 |    3 +
 http-push.c                  |    3 +
 imap-send.c                  |    3 +
 perl/Git/I18N.pm             |   91 +++++++++++++++++++++++
 perl/Makefile                |    3 +-
 perl/Makefile.PL             |   14 +++-
 po/.gitignore                |    1 +
 po/is.po                     |   70 ++++++++++++++++++
 shell.c                      |    3 +
 show-index.c                 |    3 +
 t/t0200-gettext.sh           |  166 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t0200/test.c               |   13 +++
 t/t0200/test.perl            |   14 ++++
 t/t0200/test.sh              |   14 ++++
 t/t0201-gettext-fallbacks.sh |   50 +++++++++++++
 t/t0202-gettext-perl.sh      |   23 ++++++
 t/t0202/test.pl              |  104 ++++++++++++++++++++++++++
 t/test-lib.sh                |    2 +
 upload-pack.c                |    3 +
 wt-status.c                  |  107 ++++++++++++++-------------
 34 files changed, 864 insertions(+), 65 deletions(-)
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
