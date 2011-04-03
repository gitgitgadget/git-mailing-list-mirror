From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/51] i18n: git-am printf(1) message to eval_gettext
Date: Sun,  3 Apr 2011 16:45:35 +0000
Message-ID: <1301849175-1697-12-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUa-0005ya-Gy
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1DCQsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1DCQql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=44wiJwSMS2t3di2CGm6TFANnF4DieJcQrJoWmuxIXck=;
        b=Aew0a1smbToSxO49dH9/RaEEWDQKI9WX6cKJKxtSRARgP9944x3SGoxXDkt6opfH6t
         +rFJ8DR6CDzcuoM4BPLhMUa3WFtLNZSQ5Ktxjcl9gcAj+7HFa+++JekgdNT5DmtLGWCb
         sBrvJwA2eL+FiJhtkSbqEcCEOiwAeNbn7PyBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ym3t2oPttkdW3dfjsnNccjw6O0oJug6Wj/EXcBAvRYQiISsHsm1LfQnpxEH+9KQQFf
         XE1gd6wH/iz3RWmk3CEUEqmx6uuHwPjIqK9XLBlTWGqe6+jbNso3mb1+TJmqpfK2Id+d
         ZZVHV0sIOfQ582ZOAVWV45aY4h2Xa/y9xkJvs=
Received: by 10.14.134.79 with SMTP id r55mr3163819eei.18.1301849200968;
        Sun, 03 Apr 2011 09:46:40 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.40
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170751>

Convert a message that used printf(1) format to use eval_gettext. It's
easier for translators to handle the latter, since the eval format
automatically gives them context via variable names.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a15c5cc..2a42ea2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -794,7 +794,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
+		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.4.1
