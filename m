From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/51] i18n: git-am clean_abort messages
Date: Sun,  3 Apr 2011 16:45:32 +0000
Message-ID: <1301849175-1697-9-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUb-0005ya-3X
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab1DCQs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab1DCQqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:38 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ncoHLY5eaKVFqC4bs5VPzflMa+3AYdjaZjdLRQ8ZmUs=;
        b=kGe0iMFBtMtF009wv22w8AvmjdPMKi/tKkVm0RZTp7x1LP5dUPRzH+h8q8fSFF7OJq
         qsHuBoeDB2w8XVubmHyXtuez1iH/7p06P01HpfMbd638P0sB2SQh4xYWhaMSYpCQXrx6
         Fb6o17E/xf8FYfNQJu5zwKbnj7sgBeaL6HeWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QY+VH4Bm1j9rU1+WO9pRr6PvvPcs5x7mW1oXbe2rChKhZjp+HKjRMMLOc6/IQCxgK0
         XWhDnCpHY+BzssrW8hQlYx5euO9zUQ1Z4pAIEQD/VRWZnqBRUr3oLx3+FtUT7vnQrvjo
         mA23ZeCXXVCq872nIwEQLQSv2Mq1oxbTauUa8=
Received: by 10.213.29.193 with SMTP id r1mr3252157ebc.39.1301849197760;
        Sun, 03 Apr 2011 09:46:37 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.36
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170753>

Messages that used the clean_abort function needed both gettext(1) and
eval_gettext(). These need to be interpolated in a string like the die
and cannot_fallback messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5c06eda..ed48673 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -255,7 +255,7 @@ split_patches () {
 	stgit-series)
 		if test $# -ne 1
 		then
-			clean_abort "Only one StGIT patch series can be applied at once"
+			clean_abort "$(gettext "Only one StGIT patch series can be applied =
at once")"
 		fi
 		series_dir=3D`dirname "$1"`
 		series_file=3D"$1"
@@ -307,9 +307,9 @@ split_patches () {
 		;;
 	*)
 		if test -n "$parse_patch" ; then
-			clean_abort "Patch format $patch_format is not supported."
+			clean_abort "$(eval_gettext "Patch format \$patch_format is not sup=
ported.")"
 		else
-			clean_abort "Patch format detection failed."
+			clean_abort "$(gettext "Patch format detection failed.")"
 		fi
 		;;
 	esac
--=20
1.7.4.1
