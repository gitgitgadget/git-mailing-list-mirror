From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 41/48] i18n: git-bisect echo + eval_gettext message
Date: Sat, 21 May 2011 18:44:22 +0000
Message-ID: <1306003469-22939-42-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCj-0001Bj-0A
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab1EUSqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EUSpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:41 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fTiPUQZSQ1i6wtIGxubGgE/bCkzdML5VklbUjkgkGrE=;
        b=Op/8cjMwStaB49msTJoQj0ZA88bUfWwW33MQB/I4ZB8YidpOHpSBXnlgv+eI+5xUHP
         fF+OxgNCJM0UhB0vDflNB4npLPxanGMKWq9YamZ7El0pSpl6pqzGhYKEAc/YL5gvmjIQ
         iaUzmw6LJcFEkRODaFj0wXRP+R5pSTNWTF0OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ff38cJxm9x3QucKmfMKF7PhILgAml0wXKV19HhnzmMHoUxghp8IqgxKUvcsdKHSd57
         qel7f7SPoFm42+WM4URCCCdibMWMXNmuHPZB3ZbS4dIj0DPMoqMvIK8KCaESfd6Ayp9V
         ena4hmJNhEgs2acsFBFy6v36JO2zVSGGeigNs=
Received: by 10.14.11.5 with SMTP id 5mr260527eew.92.1306003540697;
        Sat, 21 May 2011 11:45:40 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.39
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174148>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b29238d..1b432b5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -417,8 +417,11 @@ bisect_run () {
       fi
=20
       if [ $res -ne 0 ]; then
-	  echo >&2 "bisect run failed:"
-	  echo >&2 "'bisect_state $state' exited with error code $res"
+	  (
+	      eval_gettext "bisect run failed:
+'bisect_state \$state' exited with error code \$res" &&
+	      echo
+	  ) >&2
 	  exit $res
       fi
=20
--=20
1.7.5.1
