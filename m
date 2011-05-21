From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 36/48] i18n: git-stash "unknown option" message
Date: Sat, 21 May 2011 18:44:17 +0000
Message-ID: <1306003469-22939-37-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBX-0000TI-Tw
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab1EUSpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab1EUSpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:36 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=rx6jHWuiDAYZ/Y/2CSrxBq51xtm0NqrDXsbV5E+vGns=;
        b=NYWdr/4mtArZrL+mwMTUweaEhu9IahryRIMi/haZa3AK+4SnZ9RjFSFHUl10vGV5Zf
         otZpHO9wOiMxsJ/62mOjdWDWH/0/yo9GVP6udB2RMCRYsvmC2koHrJ1CA86rieQKRdFY
         s3bHtXj5TgfPEaxoMt0NebNhTIliz/Dwm368Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pl2qdFxfFenoFxl5ZPsVrBkSzt0VeeRtkRcD8p+ipg0QsYHj/RjEB88/5XEkJ22iGU
         wdwqSRtbdPjcnpbRD6dgYX93fMLb5nEkFMlYDBDV/JIRv7LWVtRQfLGQeJG+/Zcdaro2
         43XE39ZPFedfhI3n6p1a+JBkASxuW5QtvSCf8=
Received: by 10.14.32.13 with SMTP id n13mr295013eea.21.1306003536173;
        Sat, 21 May 2011 11:45:36 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.34
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174134>

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
 git-stash.sh |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ede35a5..fa6b560 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -152,8 +152,19 @@ save_stash () {
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
+			# translation of "error: " takes in your language. E.g. in
+			# English this is:
+			#=20
+			#    $ git stash save --blah-blah 2>&1 | head -n 2
+			#    error: unknown option for 'stash save': --blah-blah
+			#           To provide a message, use git stash save -- '--blah-bla=
h'
+			eval_gettext "$("error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'")"; echo
 			usage
 			;;
 		*)
--=20
1.7.5.1
