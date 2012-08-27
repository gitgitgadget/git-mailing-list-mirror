From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/7] Gettext poison fixes
Date: Tue, 28 Aug 2012 06:59:10 +0800
Message-ID: <cover.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68HD-0007cx-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2H0W7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 18:59:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2H0W7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:16 -0400
Received: by pbbrr13 with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gW0jOtH+eVo8j3j/g/o9rtfbLD8qnkrVgOaHDDUpwIY=;
        b=xhafW68jjETlnhYPwP0a7+heiWC9QRJ5mJ8BzGjcKNZkzvwNhzVTz0R/9qO3qt6ZoP
         9gD3f1YP4KZgcnfq90AFE6xyH2q2aIxmQgRkkuyZi3kvlTwkZpAJWIfCd6KE4cIyI9Na
         c+t+J01N/jJMZPmZ3ORzZl2tvOnMKDBOsQckZnvTGgpcpiRQB5H4syiFOdx7iB67eRoI
         Akjwy0YqlchfN+43jqVVfmph1H7HFZVNSAU8epqFBDedHu4Z4axZWGYc1I8Z1wsOh9dV
         8RCNAfwmjjv58VzT6Sn6WNfDfupMqd/01c6IAhm9l41klE7QJvidl0eLg8w3OCOHB2H2
         4wCA==
Received: by 10.68.241.99 with SMTP id wh3mr38312116pbc.16.1346108355779;
        Mon, 27 Aug 2012 15:59:15 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.12
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204377>

With this series, the test suite should pass again with gettext
poison on.

Updates in v3:
 * patch 1/7: fix typo in commit log message.
 * patch 6/7: remove tailing '&&'.

Jiang Xin (7):
  Fix tests under GETTEXT_POISON on relative dates
  Fix tests under GETTEXT_POISON on git-stash
  Fix tests under GETTEXT_POISON on diffstat
  Fix tests under GETTEXT_POISON on git-apply
  Fix tests under GETTEXT_POISON on pack-object
  Fix tests under GETTEXT_POISON on git-remote
  Fix tests under GETTEXT_POISON on parseopt

 t/t0006-date.sh                 |  2 +-
 t/t0040-parse-options.sh        | 34 +++++++++++++++++++++++++++++-----
 t/t1300-repo-config.sh          |  2 +-
 t/t1502-rev-parse-parseopt.sh   |  2 +-
 t/t2006-checkout-index-basic.sh |  4 ++--
 t/t2107-update-index-basic.sh   |  4 ++--
 t/t3004-ls-files-basic.sh       |  4 ++--
 t/t3200-branch.sh               |  4 ++--
 t/t3501-revert-cherry-pick.sh   |  4 ++--
 t/t3903-stash.sh                |  2 +-
 t/t4006-diff-mode.sh            |  8 ++++----
 t/t4012-diff-binary.sh          |  4 ++--
 t/t4120-apply-popt.sh           |  4 ++--
 t/t4133-apply-filenames.sh      |  4 ++--
 t/t4200-rerere.sh               |  4 ++--
 t/t4202-log.sh                  |  2 +-
 t/t4205-log-pretty-formats.sh   |  4 ++--
 t/t5300-pack-object.sh          |  4 ++--
 t/t5505-remote.sh               | 28 +++++++++++++++++-----------
 t/t5530-upload-pack-error.sh    |  4 ++--
 t/t6500-gc.sh                   |  4 ++--
 t/t7508-status.sh               |  2 +-
 t/t7600-merge.sh                |  2 +-
 23 files changed, 83 insertions(+), 53 deletions(-)

-- 
1.7.12.92.g949df84
