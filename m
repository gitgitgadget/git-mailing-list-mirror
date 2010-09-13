From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 07/12] gettextize: git-submodule "Submodule change[...]" messages
Date: Mon, 13 Sep 2010 22:09:13 +0000
Message-ID: <1284415758-20931-8-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHED-0006xe-6i
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab0IMWKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab0IMWKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:14 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so393266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ueEiS9oELhgfrwas9jlfbdWhnuww8BvP/SMY6AEa4mk=;
        b=lFmqGp/MbaAIELjY6Mr+XXbrxMXYkvMuw4PDdWvnI2Ahz9pY1Q7CrEmwMBz6/niNMm
         YTTcGWKknYofJzcJrSG5gkDWl4nw7P51/Dcs3l0MsWb+ogo3WNaMN4oce66LqvFCauCc
         JAJrx7n8gCDzikZdmamugmUK4PR932wPZC268=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=arcTV5yfkiK0uX/OrY+53qPVOIJF9rv2knFnuJPFe1vXHfpCNX0NTSP/bEkYNXQKrO
         9jM1I7M8dgMT0dDlPejIBf36fiOIWJ9kuCUGYxS/e3qkolmbdyRICItq0xa8YiR3EWT/
         2ILGaP/K1FLXqrUulLOlTpu6fmDfjBWtNIrb4=
Received: by 10.216.1.77 with SMTP id 55mr4908480wec.72.1284415813561;
        Mon, 13 Sep 2010 15:10:13 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156139>

Gettextize the "Submodules changed but not updated" and "Submodule
changes to be committed" messages. This is explicitly tested for so we
need to skip some tests with NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    4 ++--
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fcb11d9..065b343 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -710,9 +710,9 @@ cmd_summary() {
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
index 6a320cc..70b2fb1 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -225,7 +225,7 @@ EOF
     test_cmp expected actual
 "
=20
-test_expect_success '--for-status' "
+test_expect_success NO_GETTEXT_POISON '--for-status' "
     git submodule summary --for-status HEAD^ >actual &&
     test_cmp actual - <<EOF
 # Submodule changes to be committed:
--=20
1.7.3.rc1.220.gb4d42
