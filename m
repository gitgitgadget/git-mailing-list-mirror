From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] Gettext poison fixes
Date: Tue, 21 Aug 2012 11:30:57 +0700
Message-ID: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3g8Y-0006os-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab2HUEba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 00:31:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62578 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2HUEb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:31:28 -0400
Received: by pbbrr13 with SMTP id rr13so7914089pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0uw8fnE/8G2eR//s8qSlO9/CQjOUTrJ7KFFjefwlYwE=;
        b=r1cts9RQ6brnnIexlBCX02Fa1Wb0ZoOU68wU4e+w++T61xZcIMIJ9Sr6XGwwgxD++r
         sk3glhR4m0X/iKlW2rxN9fw9aOv2aMAZL6KXxw1VRm3sPkTwvRwuq/T7gOoQiEoVWWtR
         gDYdHb1Fj567C0v1Ggn39PsWB0oCN3/c00pQGODncqM77zUUZAn/D6vHTzpXwd6is7iy
         G7mBbsOTPHCoFTuIsT1/ykRZx6rFKCb6DmbTpDCfmMueZq9aGiza5BHhENMrBgR00c0N
         nj++X1SdrRPULoyJMgl4rj8AAVDg1d6IvEnwG+/gh0qrGFhUDlFHcDQyTdKW2vZC6boq
         572A==
Received: by 10.66.83.8 with SMTP id m8mr34970913pay.48.1345523487954;
        Mon, 20 Aug 2012 21:31:27 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oc2sm561593pbb.69.2012.08.20.21.31.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:31:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:31:12 +0700
X-Mailer: git-send-email 1.7.12.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203927>

Not much to say. With this series, the test suite should pass again with
gettext poison on. It's independent with the parseopt-i18n series I
sent yesterday as the test suite was broken even before.

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
 t/t5505-remote.sh               | 22 ++++++++++++++--------
 t/t5530-upload-pack-error.sh    |  2 +-
 t/t6500-gc.sh                   |  4 ++--
 t/t7508-status.sh               |  2 +-
 t/t7600-merge.sh                |  2 +-
 23 files changed, 79 insertions(+), 49 deletions(-)

-- 
1.7.12.rc2
