From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 39/51] i18n: git-stash "unknown option" message
Date: Sun,  3 Apr 2011 16:46:03 +0000
Message-ID: <1301849175-1697-40-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTS-0005RJ-2j
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab1DCQrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab1DCQrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:12 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=n01jlP882dEhIcHGTEC4Nc+wvAKBUA9HkpmX4t96i+s=;
        b=uIdbl5FIQRZoi9TvCNOcB7Tkf8e6M3e3jsrzStZ39uognzAdHplwV3dTsUExxtSZco
         Fbt949f3vcsXsg1J/fK+jWTomxiLysCpIyTnqQafa9sCbRYeuXLVr27F+VLJkuzzxsPp
         GS3jPK8XIHiuKHRdDF89+p7IhQMFepWDUVCNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ti0qT2uyPE/Aed5kQnMUlZRIxlm8fQO/hwJsuZDktu5DLnrxMJIxLC1dbMPzTQtEBZ
         gqVhsoNf0iCKp4MYpP4P6bVGe9uJ9mrMcce8p8MER/HgUnvGR7e57RTzYBptbF7Nd9vq
         eagUbbyu+yMSbTYzyOVKiTimOHpqsphGfAdoU=
Received: by 10.14.10.69 with SMTP id 45mr3060096eeu.33.1301849231847;
        Sun, 03 Apr 2011 09:47:11 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.09
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170738>

Gettextize the "unknown option for 'stash save'" message that's shown
on:

    $ git stash save --blah-blah
    error: unknown option for 'stash save': --blah-blah
           To provide a message, use git stash save -- '--blah-blah'
    Usage: git stash list [<options>]

In a translation the second line should be aligned with the first
one. I've added a TRANSLATORS comment to indicate this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9ab5ed9..0468499 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -151,8 +151,14 @@ save_stash () {
 			break
 			;;
 		-*)
-			echo "error: unknown option for 'stash save': $1"
-			echo "       To provide a message, use git stash save -- '$1'"
+			option=3D"$1"
+			# TRANSLATORS: $option is an invalid option, like
+			# `--blah-blah'. The 7 spaces at the beginning of the
+			# second line correspond to "error: ". So you should line
+			# up the second line with however many characters the
+			# translation of "error: " takes in your language.
+			eval_gettext "$("error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'")"; echo
 			usage
 			;;
 		*)
--=20
1.7.4.1
