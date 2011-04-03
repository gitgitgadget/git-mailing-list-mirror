From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 26/51] i18n: git-submodule "Submodule change[...]" messages
Date: Sun,  3 Apr 2011 16:45:50 +0000
Message-ID: <1301849175-1697-27-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTT-0005RJ-Nr
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab1DCQsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1DCQq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:56 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=SvNpBHZPogfrDo3FgROAO378QF93f3ztqqf7eggJxoM=;
        b=xEp46hKU1BQK7lnIYOaOu0luLWHjPRsraf6Iv4U/AQuG3YWB7VqrpiJEYg8DrpDgqz
         UjHENZ3v83zbkAZc9RIQkxlMRWTYFKQJK7oOAxE9f0lL1c92CnZxF77ubS4t/xUd7s2F
         eleay+Uy3pYByOrHl0vXAacXGIGIVSYdAtJag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xYr4Rt9KvNGxDClbkuq3EurCVvj7u21JgUkwo5KA760Zjsulq8ZgsS1hB0K2yKjH4O
         9oN5b30AoY5zEzFhzBTby8VxZIgGQVnxs+rrKxbbn2uRAwjBJ5fsnILxiA7vOKuRguG1
         iVKe+0d/cRrSEEOOpbcerRRxtJ4ZuKBa1lHIY=
Received: by 10.213.100.65 with SMTP id x1mr3211080ebn.78.1301849215307;
        Sun, 03 Apr 2011 09:46:55 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.54
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170742>

Gettextize the "Submodules changed but not updated" and "Submodule
changes to be committed" messages. This is explicitly tested for so we
need to skip some tests with C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    4 ++--
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 28523b7..5fe29a2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -713,9 +713,9 @@ cmd_summary() {
 	done |
 	if test -n "$for_status"; then
 		if [ -n "$files" ]; then
-			echo "# Submodules changed but not updated:"
+			gettext "# Submodules changed but not updated:"; echo
 		else
-			echo "# Submodule changes to be committed:"
+			gettext "# Submodule changes to be committed:"; echo
 		fi
 		echo "#"
 		sed -e 's|^|# |' -e 's|^# $|#|'
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index 7d7fde0..efd220b 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -226,7 +226,7 @@ EOF
     test_cmp expected actual
 "
=20
-test_expect_success '--for-status' "
+test_expect_success C_LOCALE_OUTPUT '--for-status' "
     git submodule summary --for-status HEAD^ >actual &&
     test_cmp actual - <<EOF
 # Submodule changes to be committed:
--=20
1.7.4.1
