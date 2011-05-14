From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/4] i18n: Add shell script translation infrastructure
Date: Sat, 14 May 2011 13:47:41 +0000
Message-ID: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 15:48:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFCK-0007AN-3M
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab1ENNrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 09:47:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56391 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1ENNry (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:47:54 -0400
Received: by ewy4 with SMTP id 4so914469ewy.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=BBvPpqsd1SLxhux5fMZG+0XPBRSbdQYlX4/LIryZ2bU=;
        b=qa63LDxOAn455ggYPsMyIiiyOx9rmBkcOaxKrY0y/04X4h8WqQr+Dc1tqCeMlSzKwO
         OhCGFEESIrJPsNHpfvAjIUMgoa58qLzYysqJtT2Tsuqga7jzKS+euKe4ltCsMwWQ4aLj
         ao2PERdBoujBBPd9sDxna4EonE4elnRlbXOYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=mcC918IxweWdl06rUh6JMbrv3fWhnKcpdbEea8QqZdzOfzAB4gk7yHAQp7GIpJ0DH9
         OSFYa+lbltj8Z5MbF4qXHSkJi40kslwfs25W0Jl7EqrnpsU3+bSAvEwDGVn18w9yQK7f
         fkWfzZ/dG8MK42PQk57mzui84YF4HGI5QR0P4=
Received: by 10.14.38.26 with SMTP id z26mr1104522eea.14.1305380872996;
        Sat, 14 May 2011 06:47:52 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y9sm2110298eeh.8.2011.05.14.06.47.52
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 06:47:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173584>

This is v2 of the "Add shell script translation infrastructure"
series. Changes:

  * The Author & Documentation sections from the documentation are now
    gone. These should no longer be included, but the patch series
    preceded that convention.

  * Update the git-sh-i18n.txt and git-sh-i18n--envsubst.txt
    documentation to accurately reflect what the skeleton fall-through
    wrappers do.

  * Updated the commit message for "git-sh-i18n--envsubst: our own
    envsubst(1) for eval_gettext()" to not include a lengthy
    description of failed eval_gettext experiments at Junio's
    suggestion.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
  git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
  git-sh-i18n.sh: add GIT_GETTEXT_POISON support
  Makefile: add xgettext target for *.sh files

 .gitignore                              |    3 +
 Documentation/git-sh-i18n--envsubst.txt |   26 ++
 Documentation/git-sh-i18n.txt           |   42 +++
 Makefile                                |    8 +-
 git-sh-i18n.sh                          |   29 ++
 sh-i18n--envsubst.c                     |  444 +++++++++++++++++++++++=
++++++++
 t/t0201-gettext-fallbacks.sh            |   51 ++++
 7 files changed, 602 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-sh-i18n--envsubst.txt
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh
 create mode 100644 sh-i18n--envsubst.c
 create mode 100755 t/t0201-gettext-fallbacks.sh

--=20
1.7.4.4
