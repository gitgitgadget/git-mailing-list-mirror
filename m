From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] i18n: Shell script translation infrastructure
Date: Sun,  3 Apr 2011 16:42:31 +0000
Message-ID: <1301848953-31525-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:43:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QOF-0003Uz-Tt
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1DCQmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:42:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48923 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1DCQmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:42:42 -0400
Received: by eyx24 with SMTP id 24so1502208eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=lsiPJEII6FqnokhP09P30IpxCTWzHeN6IWvI48RSMZw=;
        b=EQfAs4MghdUgVLWeqcwcEQBEcXMiaLzP29Pdldpv0rMgfw4mvacg9RC65csQSv4V0t
         3TQAUOcj5NivyNHQg/eGAjcBv8sOVAgHU0nRhT79ZOLXBs9iqqZfupGqIHSe2aNQzujZ
         Mhj/aCoLRkFvpFx6lZoFTHvqNRwtIpLu3TGnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=R5/+VOVebDjpBz7PPX0hHterQjUlbupmHAQIEaav51D366BJGSZjjDmsUgOWTNWyrG
         FnZJLs+R2v0Bo2hXSkFCAIf4PK4cxHgfYrrWQbQPVrHUdZwFs/v8FBI+zqdAmWcpxTD4
         JtpDPqsfinFRnQERcrwk/WIz3z9oAy9mNuRwY=
Received: by 10.14.16.100 with SMTP id g76mr2966753eeg.168.1301848959775;
        Sun, 03 Apr 2011 09:42:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm2754455eei.22.2011.04.03.09.42.38
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:42:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170703>

Now that the C gettext infrastructure patches have made it to master
I'm submitting a series to do the same for our shell scripts. These
are the first two patches from:

    git://github.com/avar/git.git ab/i18n-sh-only

The rest (to be submitted soon) are the patches marking up the
shellscripts themselves for translation.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
  git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers

 .gitignore                              |    3 +
 Documentation/git-sh-i18n--envsubst.txt |   36 +++
 Documentation/git-sh-i18n.txt           |   57 ++++
 Makefile                                |    2 +
 git-sh-i18n.sh                          |   17 ++
 sh-i18n--envsubst.c                     |  444 +++++++++++++++++++++++=
++++++++
 t/t0201-gettext-fallbacks.sh            |   51 ++++
 7 files changed, 610 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n--envsubst.txt
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh
 create mode 100644 sh-i18n--envsubst.c
 create mode 100755 t/t0201-gettext-fallbacks.sh

--=20
1.7.4.1
