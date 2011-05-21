From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 12/48] i18n: git-am printf(1) message to eval_gettext
Date: Sat, 21 May 2011 18:43:53 +0000
Message-ID: <1306003469-22939-13-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCr-0001Bj-Uz
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233Ab1EUSrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:17 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab1EUSpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:13 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Wrb6ZzZVQn+/o7Sy0GhyB9NnuekX+wAVWNPXceYERQE=;
        b=N27z4fQ9dyvrT3d9reK0ORRqWIGtfT/tbIzMCgt9uyGlYDEeoCFNhkbmF0BaSU3ssc
         p7yeAxrcpnCBimt0BnO+THeQFlaK7xxbTBikI2elTCW+2tnXVeQ5BqQDcWZYa7IdDl61
         36Z1g5q/d2Zd9tFPblU5mjF0d36cJI4Rq/Pq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Qj2cCNIF85TSZBMxDuaOwXQThjN1tvrG6ladjdgKO/izpBYeTikJ5x/jhSFhnKH8UJ
         V4ANn9jsvvp6b+b+XYmXl8/MZFGI6n3rdQ4ZykTRunrgjX5Zk8C+HxVuBXYodzB8PUZ+
         oMeUtV5/5xKYbrezMDUZfIqN5nJXNJxhPwudc=
Received: by 10.213.99.71 with SMTP id t7mr542688ebn.81.1306003513141;
        Sat, 21 May 2011 11:45:13 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.12
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174158>

Convert a message that used printf(1) format to use eval_gettext. It's
easier for translators to handle the latter, since the eval format
automatically gives them context via variable names.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 99032ca..df918bb 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -797,7 +797,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
+		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.5.1
