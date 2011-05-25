From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/6] i18n: Windows shellscript support
Date: Wed, 25 May 2011 23:19:48 +0000
Message-ID: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNM-00080b-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab1EYXUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64480 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab1EYXUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:03 -0400
Received: by eyx24 with SMTP id 24so106217eyx.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=XD59SVs1BAKvM/a4Fb+AHywJshhgAIk5OXuwHUEaoTg=;
        b=JVkxlNLpWKmwPVDDdo/n+LlQiOMcyiSlNSvsEO7ctdospyKL4ucA6Uhdka9Z/amwoy
         8HkKDbRRG9ak/LL5t7D2bD3aIiecf9DVgZbCBJkQbjG2IFEEj8KVZ1zJGsYC8xW4H7t1
         YnfSJvO/X9AA+au3sRS5ZrEcU+sGOPt9a3lVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=LAX86/Ptp4/QsjuD0gxh/Jm3MkZiLgCUcOxOt5pOBhDtQv9e7sJMZb01jGGnQkTgk0
         EgF7OkfWuu18OXHC8fJB5NMgqFDLbUYvuxpOTMvrjQwuUE0jQ/jWRuhwV3LscDv7x48o
         nkUCDqVvcnZUFxMNDAzfAYIJxnv0Bm44atQh0=
Received: by 10.14.44.197 with SMTP id n45mr61054eeb.146.1306365602008;
        Wed, 25 May 2011 16:20:02 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.00
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174477>

This series goes on top of the other shell script serieses and fixes
the issue with case insensitive environment variables on Windows by
giving all the variables passed to eval_gettext a prefix that's
unlikely to clash with existing variables in the environment.

With this series the ab/i18n-sh-scripts series should be ready for
master, since this fixes the last known issue with it.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
  i18n win32: add git-am eval_gettext variable prefix
  i18n win32: add git-bisect eval_gettext variable prefix
  i18n win32: add git-pull eval_gettext variable prefix
  i18n win32: add git-stash eval_gettext variable prefix
  i18n win32: add git-submodule eval_gettext variable prefix
  i18n win32: add test eval_gettext variable prefix

 git-am.sh                    |   29 +++++---
 git-bisect.sh                |   39 +++++++----
 git-pull.sh                  |    5 +-
 git-stash.sh                 |   26 ++++---
 git-submodule.sh             |  151 ++++++++++++++++++++++++++++------=
--------
 t/t0201-gettext-fallbacks.sh |    4 +-
 6 files changed, 167 insertions(+), 87 deletions(-)

--=20
1.7.5.1
