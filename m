From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/4] i18n: Add shell script translation infrastructure
Date: Sun,  8 May 2011 12:10:55 +0000
Message-ID: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2pR-0007Z5-MM
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab1EHMLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:11:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34772 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1EHMLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:11:12 -0400
Received: by ewy4 with SMTP id 4so1326170ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=o0/ZyLUIcX2k1dP9NhQZ7u8hp7U9HEftnImBqWB3B7c=;
        b=M4Cp6HnUKAsrY/P8g0NxxeQz8hTTmeG+zgJzF9VxZLXbUZYKyy3CkguJZGQtYf90xg
         3rKVrkogH5+ZZGAOiaZFZSc5qqLFe8rJ5wEzKH9Qn0NivdmVeB5lsR87qrC5DSo9EhiZ
         w0pIv97LFPpGVmhwHkwnG9QCNBnmcwhRjMRM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BUPa/mHZ5peWfSmxElDQMQf6UKZmg7euftz9xJrpBsfYNeFwVu/ZdZnx3yaQ1nUYBM
         omfyk3EKySiZmaqHNk050jqPFr9S9G3ulqI+6hQ7MgY0zOT7nJzdhZhxLHRIkOwzHt5a
         wrkcr54F8BE8o2Gn74o4jgvihAdEJK3uB+VMI=
Received: by 10.213.2.208 with SMTP id 16mr636127ebk.32.1304856671538;
        Sun, 08 May 2011 05:11:11 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id s62sm2713947eea.24.2011.05.08.05.11.10
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:11:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173098>

As threatened this is the updated shell script translation
infrastructure that I'm submitting now that 1.7.5 has been out for a
bit.

This adds skeleton no-op functions to git-sh-i18n.sh analogous to the
gettext.c skeleton functions for C, adds *.sh scripts to the "pot"
target for message extraction, and updates the git-sh-i18n--envsubst
tests to use the new test_i18ncmp function.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
  git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
  git-sh-i18n.sh: add GIT_GETTEXT_POISON support
  Makefile: add xgettext target for *.sh files

 .gitignore                              |    3 +
 Documentation/git-sh-i18n--envsubst.txt |   36 +++
 Documentation/git-sh-i18n.txt           |   57 ++++
 Makefile                                |    8 +-
 git-sh-i18n.sh                          |   29 ++
 sh-i18n--envsubst.c                     |  444 +++++++++++++++++++++++=
++++++++
 t/t0201-gettext-fallbacks.sh            |   51 ++++
 7 files changed, 627 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-sh-i18n--envsubst.txt
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh
 create mode 100644 sh-i18n--envsubst.c
 create mode 100755 t/t0201-gettext-fallbacks.sh

--=20
1.7.4.4
